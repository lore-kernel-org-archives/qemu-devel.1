Received: from eggs.gnu.org ([2001:4830:134:3::10]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOnfG-0006IZ-P1
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOnfE-0004TY-2c
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:48:50 -0500
Date: Mon, 19 Nov 2018 18:43:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181119174340.GH8066@localhost.localdomain>
References: <20181116093152.27227-1-pbonzini@redhat.com>
	<4c83906c-0d78-3a73-b40d-ae5f7e58ffa3@oracle.com>
	<c968b33e-a487-3071-a51a-805794598b2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c968b33e-a487-3071-a51a-805794598b2c@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Li Qiang <liq3ea@gmail.com>, qemu-block@nongnu.org

Am 19.11.2018 um 18:09 hat Paolo Bonzini geschrieben:
> On 19/11/18 16:23, Mark Kanda wrote:
> > For CVE-2018-16847, I just noticed Kevin pulled in Li's previous fix =
(as
> > opposed to this one). Was this done in error?
>=20
> Probably.  Kevin, can you revert and apply this one instead?  I don't
> care if 3.1 or 3.2, but the previous fix is pointless complication.

I was waiting for you to address Li Qiang's review comments before I
apply it. I can revert the other one once this is ready.

> > On 11/16/2018 3:31 AM, Paolo Bonzini wrote:
> >> Because the CMB BAR has a min_access_size of 2, if you read the last
> >> byte it will try to memcpy *2* bytes from n->cmbuf, causing an off-b=
y-one
> >> error.=A0 This is CVE-2018-16847.
> >>
> >> Another way to fix this might be to register the CMB as a RAM memory
> >> region, which would also be more efficient.=A0 However, that might b=
e a
> >> change for big-endian machines; I didn't think this through and I do=
n't
> >> know how real hardware works.=A0 Add a basic testcase for the CMB in=
 case
> >> somebody does this change later on.
> >>
> >> Cc: Keith Busch <keith.busch@intel.com>
> >> Cc: qemu-block@nongnu.org
> >> Cc: Li Qiang <liq3ea@gmail.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >> =A0 hw/block/nvme.c=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +-
> >> =A0 tests/Makefile.include |=A0 2 +-
> >> =A0 tests/nvme-test.c=A0=A0=A0=A0=A0 | 58 ++++++++++++++++++++++++++=
+++++++++++++---
> >> =A0 3 files changed, 57 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> >> index 09d7c90259..5d92794ef7 100644
> >> --- a/hw/block/nvme.c
> >> +++ b/hw/block/nvme.c
> >> @@ -1192,7 +1192,7 @@ static const MemoryRegionOps nvme_cmb_ops =3D =
{
> >> =A0=A0=A0=A0=A0 .write =3D nvme_cmb_write,
> >> =A0=A0=A0=A0=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> >> =A0=A0=A0=A0=A0 .impl =3D {
> >> -=A0=A0=A0=A0=A0=A0=A0 .min_access_size =3D 2,
> >> +=A0=A0=A0=A0=A0=A0=A0 .min_access_size =3D 1,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .max_access_size =3D 8,
> >> =A0=A0=A0=A0=A0 },
> >> =A0 };

Anyway, that .min_access_size influences the accessible range feels
weird to me. Is this really how it is meant to work? I expected this
only to influence the allowed granularity of accesses, and that the
maximum accessible offset of the memory region is size - access_size.

Does this mean that the size parameter of memory_region_init_io() really
means we allow access to offsets from 0 to size + impl.min_access_size - =
1?
If so, this is very surprising and I wonder if this is really the only
device that gets it wrong.

For nvme it doesn't matter much because it can trivially support
single-byte accesses, so this change is correct and fixes the problem,
but isn't the real bug in access_with_adjusted_size(), which should
adjust the accessed range in a way that it doesn't exceed the size of
the memory region?

I'm not sure why impl.min_access_size was set to 2 in the first place,
but was valid.min_access_size meant maybe? Though if I read the spec
correctly, that one should be 4, not 2.

Hm... But memory_region_access_valid() doesn't even check min and max
access size if an accepts function pointer isn't given as well. Yet,
there are devices that set min/max, but not accepts. Am I missing where
this actually takes effect or are they buggy?

This stuff really confuses me.

Kevin
