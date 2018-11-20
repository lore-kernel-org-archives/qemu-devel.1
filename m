Received: from eggs.gnu.org ([2001:4830:134:3::10]:41975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPBGK-0003IC-EK
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPBGI-0006Py-8f
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:00:40 -0500
References: <20181116093152.27227-1-pbonzini@redhat.com>
	<4c83906c-0d78-3a73-b40d-ae5f7e58ffa3@oracle.com>
	<c968b33e-a487-3071-a51a-805794598b2c@redhat.com>
	<20181119174340.GH8066@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94514f40-e751-7102-a966-c3d2111a9b09@redhat.com>
Date: Tue, 20 Nov 2018 20:00:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181119174340.GH8066@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] nvme: fix out-of-bounds access to
 the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Li Qiang <liq3ea@gmail.com>, qemu-block@nongnu.org

On 19/11/18 18:43, Kevin Wolf wrote:
> Am 19.11.2018 um 18:09 hat Paolo Bonzini geschrieben:
>> On 19/11/18 16:23, Mark Kanda wrote:
>>> For CVE-2018-16847, I just noticed Kevin pulled in Li's previous fix =
(as
>>> opposed to this one). Was this done in error?
>>
>> Probably.  Kevin, can you revert and apply this one instead?  I don't
>> care if 3.1 or 3.2, but the previous fix is pointless complication.
>=20
> I was waiting for you to address Li Qiang's review comments before I
> apply it. I can revert the other one once this is ready.

Sorry, I forgot to send it.  Did it now.

> Anyway, that .min_access_size influences the accessible range feels
> weird to me. Is this really how it is meant to work? I expected this
> only to influence the allowed granularity of accesses, and that the
> maximum accessible offset of the memory region is size - access_size.
>> Does this mean that the size parameter of memory_region_init_io() real=
ly
> means we allow access to offsets from 0 to size + impl.min_access_size =
- 1?
> If so, this is very surprising and I wonder if this is really the only
> device that gets it wrong.

Usually the offset is a register, so an invalid value will simply be
ignored by the device or reported as a guest error.

> For nvme it doesn't matter much because it can trivially support
> single-byte accesses, so this change is correct and fixes the problem,
> but isn't the real bug in access_with_adjusted_size(), which should
> adjust the accessed range in a way that it doesn't exceed the size of
> the memory region?

Hmm, what's happening is complicated.  memory_access_size is clamping
the access size to 1 because impl.unaligned is false.  However,
access_with_adjusted_size is bringing it back to 2 because it does

    access_size =3D MAX(MIN(size, access_size_max), access_size_min);

So we could do something like

diff --git a/exec.c b/exec.c
index bb6170dbff..f1437b2be6 100644
--- a/exec.c
+++ b/exec.c
@@ -3175,7 +3175,11 @@
     if (!mr->ops->impl.unaligned) {
         unsigned align_size_max =3D addr & -addr;
         if (align_size_max !=3D 0 && align_size_max < access_size_max) {
-            access_size_max =3D align_size_max;
+            unsigned access_size_min =3D mr->ops->valid.min_access_size;
+            if (access_size_min =3D=3D 0) {
+                access_size_min =3D 1;
+            }
+            access_size_max =3D MAX(min_access_size, align_size_max);
         }
     }

Then I think the access size would remain 2 and and
memory_region_access_valid would reject it as unaligned.  That would
avoid the bug, but then nvme should be setting valid.min_access_size and
the exec.c patch alone would not be enough.

> I'm not sure why impl.min_access_size was set to 2 in the first place,
> but was valid.min_access_size meant maybe? Though if I read the spec
> correctly, that one should be 4, not 2.

I don't see any requirement for the CMB (section 4.7 in my copy)?

Paolo
