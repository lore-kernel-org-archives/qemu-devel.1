Received: from eggs.gnu.org ([2001:4830:134:3::10]:53591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKrDe-0001Bn-UT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKr0s-0000X4-0i
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:34:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKr0r-00007V-LL
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:34:49 -0500
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<CALMp9eRk=a1FEyr78NRGBBZ2iFCo5s2n5N=bM4zR=YF56oob3A@mail.gmail.com>
	<1C803EF0-9E1B-4E1B-A4DD-4BE788A7A1FF@oracle.com>
	<DF5EC0F1-BA8D-4B85-BB1A-B22234235FBA@oracle.com>
	<CALMp9eQSptO+S1NZjQQUa=HQCXFOevHwTDS9i0KXHCGSfKzEkA@mail.gmail.com>
	<a567de11-a106-fd6d-7998-1a18ba17eaaa@redhat.com>
	<939A6255-306C-431C-8799-0D56A30A3BD5@oracle.com>
	<d29d27ba-f34e-6dd6-4eec-8e75971269e3@redhat.com>
	<59EE7141-6771-47E2-8473-C1429676AD7B@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb9e672a-9d5f-6a6c-2fa6-2c097c1892ab@redhat.com>
Date: Thu, 8 Nov 2018 21:34:31 +0100
MIME-Version: 1.0
In-Reply-To: <59EE7141-6771-47E2-8473-C1429676AD7B@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Liran Alon <liran.alon@oracle.com>
Cc: Jim Mattson <jmattson@google.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On 08/11/2018 19:41, Liran Alon wrote:
> So what I plan to do is indeed to define first 4K of data as vmcs12 and=
 next 4K as shadow_vmcs12.
> I will also define each of them in a separate VMState subsection that e=
ach will have it=E2=80=99s own .needed()
> method that will decide if it=E2=80=99s relevant to send it based on kv=
m_state.size.
> vmcs12 and shadow_vmcs12 will be put in a struct which is unioned with =
a struct
> of 2 pages buffer to clearly indicate that one well-defined struct is u=
sed for VMX and the other for SVM.
> (based on kvm_state.format)

And SVM will use other subsections.

> In addition, I will change KVM_{GET,SET}_NESTED_STATE documentation to =
indicate that
> future nested state fields should be added at the end of struct and wea=
ther they are valid should
> be determined by a flag in kvm_state.flags.
> QEMU will handle these new states in the future by adding more VMState =
subsections that have
> .needed() method based on appropriate flag in kvm_state.flags.
> The struct itself that userspace use against it=E2=80=99s local kernel =
will be determined based on KVM_CAPs.
>=20
> If there are no objections, I will write the needed patches for QEMU (a=
nd the documentation patch for KVM).

Sure.  You can also place the flags and format in yet another subsection.

Paolo
