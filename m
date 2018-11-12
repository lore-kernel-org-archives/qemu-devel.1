Received: from eggs.gnu.org ([2001:4830:134:3::10]:43565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMDZA-00032J-7d
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMDZ3-0006Td-Aw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:51:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gMDYv-0006Op-Mq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:51:38 -0500
Date: Mon, 12 Nov 2018 14:51:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181112145121.GE2293@work-vm>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59EE7141-6771-47E2-8473-C1429676AD7B@oracle.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

* Liran Alon (liran.alon@oracle.com) wrote:
>=20
>=20
> > On 8 Nov 2018, at 19:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >=20
> > On 08/11/2018 10:57, Liran Alon wrote:
> >>=20
> >>=20
> >>> On 8 Nov 2018, at 11:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>>=20
> >>> On 08/11/2018 01:45, Jim Mattson wrote:
> >>>> I have no attachments to the current design. I had used a data[] b=
lob,
> >>>> because I didn't think userspace would have any need to know what =
was
> >>>> in there. However, I am now seeing the error of my ways. For examp=
le,
> >>>> the userspace instruction emulator needs to know the contents of t=
he
> >>>> vmcs12 to emulate instructions when in guest mode.
> >>>=20
> >>> Yeah, we're probably going to have to document the KVM vmcs12 struc=
ture,
> >>> possibly moving it to uapi.  But that's a different thing from
> >>> save/restore state, which can use the 4K or 8K data[] blob.
> >>>=20
> >>> Paolo
> >>=20
> >> But regardless of if we document vmcs12 or not, the current blob we
> >> have today should be separated to well-defined blobs/structs (cached=
_vmcs12
> >> and cached_shadow_vmcs12) and each blob should have a relevant flag =
that specifies
> >> it is valid (saved by kernel or requested to be restored by userspac=
e).
> >> Additional future nested-state should be added as additional
> >> well-defined blobs/structs with appropriate flags.
> >=20
> > We are somewhat limited by the ABI of the released kernel versions, a=
nd
> > it's unlikely that the structure will change in the short term.  So I
> > think it's okay if we just define that the first 4K of data are the V=
MCS
> > and the second 8K are the shadow VMCS, whenever format=3D0 in the
> > kvm_nested_state struct.
> >=20

(Sorry, I was out last week).

>=20
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
>=20
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
> (And throw away the current VMState technique I used in this version of=
 the patch :P)

Using subsections is good and makes it pretty clear on loading if
there's a problem; it also makes it good when you add new subsections
in new versions.  It can be tricky getting the logic for the .needed
functions right, so that you don't write out new .needed sections for
old configs and thus can allow yourself to migrate to an older
qemu/kernel.

Dave

> -Liran
>=20
> >=20
> >> Then, in QEMU, each such well-defined blob/struct should have it=E2=80=
=99s own subsection with a relevant .needed() method.
> >> This will allow us to preserve required backwards compatibility.
> >>=20
> >> Agreed?
> >>=20
> >> -Liran
> >>=20
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
