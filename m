Received: from eggs.gnu.org ([2001:4830:134:3::10]:33519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gKh4b-0002kH-7d
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gKh4Y-0004wv-0x
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:58:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1gKh4X-0004uR-Ha
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:57:57 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <a567de11-a106-fd6d-7998-1a18ba17eaaa@redhat.com>
Date: Thu, 8 Nov 2018 11:57:46 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <939A6255-306C-431C-8799-0D56A30A3BD5@oracle.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<CALMp9eRk=a1FEyr78NRGBBZ2iFCo5s2n5N=bM4zR=YF56oob3A@mail.gmail.com>
	<1C803EF0-9E1B-4E1B-A4DD-4BE788A7A1FF@oracle.com>
	<DF5EC0F1-BA8D-4B85-BB1A-B22234235FBA@oracle.com>
	<CALMp9eQSptO+S1NZjQQUa=HQCXFOevHwTDS9i0KXHCGSfKzEkA@mail.gmail.com>
	<a567de11-a106-fd6d-7998-1a18ba17eaaa@redhat.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org



> On 8 Nov 2018, at 11:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 08/11/2018 01:45, Jim Mattson wrote:
>> I have no attachments to the current design. I had used a data[] =
blob,
>> because I didn't think userspace would have any need to know what was
>> in there. However, I am now seeing the error of my ways. For example,
>> the userspace instruction emulator needs to know the contents of the
>> vmcs12 to emulate instructions when in guest mode.
>=20
> Yeah, we're probably going to have to document the KVM vmcs12 =
structure,
> possibly moving it to uapi.  But that's a different thing from
> save/restore state, which can use the 4K or 8K data[] blob.
>=20
> Paolo

But regardless of if we document vmcs12 or not, the current blob we have =
today
should be separated to well-defined blobs/structs (cached_vmcs12 and =
cached_shadow_vmcs12)
and each blob should have a relevant flag that specifies it is valid =
(saved by kernel or requested to be restored by userspace).
Additional future nested-state should be added as additional =
well-defined blobs/structs with appropriate flags.

Then, in QEMU, each such well-defined blob/struct should have it=E2=80=99s=
 own subsection with a relevant .needed() method.
This will allow us to preserve required backwards compatibility.

Agreed?

-Liran
