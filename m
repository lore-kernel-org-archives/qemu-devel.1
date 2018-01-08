Received: from eggs.gnu.org ([2001:4830:134:3::10]:33449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYfgb-0000ce-7r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYfgY-0003D4-2T
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:14:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYfgX-0003CE-Oe
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:14:25 -0500
Date: Mon, 8 Jan 2018 20:14:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180108221422.GK6646@localhost.localdomain>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
	<m3d12k9fyj.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m3d12k9fyj.fsf@luffy.cx>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Mon, Jan 08, 2018 at 10:51:48PM +0100, Vincent Bernat wrote:
>  =E2=9D=A6  8 janvier 2018 19:16 -0200, Eduardo Habkost <ehabkost@redha=
t.com>=C2=A0:
>=20
> > One possible way to work around this problem is to declare that
> > QEMU 2.12 with KVM will require Linux v3.6 and newer (because we
> > need Linux kernel commit ad756a1603c5 "KVM: VMX: Implement
> > PCID/INVPCID for guests with EPT").  I have proposed something
> > similar to allow us to enable kvm_pv_eoi by default, some time
> > ago:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html
> > ("qemu-doc: Document minimum kernel version for KVM in x86_64").
>=20
> I don't see a way to probe KVM to know what's supported, so yes.

We do have a way to probe KVM: GET_SUPPORTED_CPUID.  The problem
here is breaking libvirt and management software expectations.

libvirt assumes "stable runnability": a CPU model that is
runnable on a host using QEMU/machine-type version will stay
runnable on the same host after a QEMU or machine-type upgrade.


> Should
> I add a paragraph similar to yours or would your patch be merged soon?

My patch was dropped because we decided to wait a bit before
enabling kvm_pv_eoi by default.  My paragraph could be improved
by a description of what could happen if an older kernel version
is used (see below).


> What are the consequences of running a too old kernel? Would KVM just
> hide PCID flag?

On an old kernel, the SandyBridge and IvyBridge CPU models will
be unexpectedly become not runnable.


>=20
> > Second, we need compatibility entries setting pcid=3Doff on
> > PC_COMPAT_2_10 so we don't break compatibility on older
> > machine-types.

(Oops, I should have said PC_COMPAT_2_11 here)

>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6f77eb066587..da5bd8304eb0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -327,6 +327,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uin=
t64_t *);
>          .driver   =3D TYPE_X86_CPU,\
>          .property =3D "x-hv-max-vps",\
>          .value    =3D "0x40",\
> +    },{\
> +        .driver   =3D "SandyBridge-" TYPE_X86_CPU,\
> +        .property =3D "pcid",\
> +        .value    =3D "off",\
> +    },{\
> +        .driver   =3D "IvyBridge-" TYPE_X86_CPU,\
> +        .property =3D "pcid",\
> +        .value    =3D "off",\
>      },{\
>          .driver   =3D "i440FX-pcihost",\
>          .property =3D "x-pci-hole64-fix",\

This is correct, but it should be done on PC_COMPAT_2_11 instead
(sorry for my confusion above).

If you don't find PC_COMPAT_2_11 on master, please look for the
"pc: add 2.12 machine types" patch.  I thought it was already
merged on master.  I just queued it on my x86-next tree[1].


[1] https://github.com/ehabkost/qemu x86-next

>=20
> I'll resend a proper patch once the first point is cleared.

Thanks!

--=20
Eduardo
