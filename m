Received: from eggs.gnu.org ([2001:4830:134:3::10]:45826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxWnS-0008ON-AO
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxWnM-0002hh-Ky
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:20:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fxWnM-0002ez-Ds
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:20:28 -0400
Date: Wed, 5 Sep 2018 14:20:21 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180905122021.dfsvsvk6zn2ijefp@kamzik.brq.redhat.com>
References: <87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
	<20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
	<20180829131653.gk4yhjdi2pk5bdcd@kamzik.brq.redhat.com>
	<DC466FE6-98B4-485B-BE4D-C4E228B36107@caviumnetworks.com>
	<20180831111121.n7zafn6peiwe6ojn@kamzik.brq.redhat.com>
	<1604D594-E6D4-48BB-A270-F7CF1092978B@caviumnetworks.com>
	<20180904095402.izdnqag3xak3mgsb@kamzik.brq.redhat.com>
	<EF2DEC36-DDCB-4169-A30F-15F29B7F52E9@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF2DEC36-DDCB-4169-A30F-15F29B7F52E9@caviumnetworks.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Query] Live Migration between machines with
 different processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Auger Eric <eric.auger@redhat.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Sep 05, 2018 at 11:46:11AM +0000, Jaggi, Manish wrote:
> (a) Changes in KVM:
>=20
> - Introducing a specific error code (KVM_EINVARIANT) in case of invaria=
nt writes.
> This should not change anything to API SET_ONE_REG KVM API.
> Not sure which is the best place to put the define=E2=80=A6
> I have added in include/uapi/linux/kvm_para.h.
>=20
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 22fbbdbece3c..c8a4fbe8a8bb 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1111,7 +1111,7 @@ static int __set_id_reg(const struct sys_reg_desc=
 *rd, void __user *uaddr,
> =20
>         /* This is what we mean by invariant: you can't change it. */
>         if (val !=3D read_id_reg(rd, raz))
> -               return -EINVAL;
> +               return -KVM_EINVARIANT;
> =20
>         return 0;
>  }
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_par=
a.h
> index 6c0ce49931e5..3a49a321d0df 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -17,6 +17,7 @@
>  #define KVM_E2BIG              E2BIG
>  #define KVM_EPERM              EPERM
>  #define KVM_EOPNOTSUPP         95
> +#define KVM_EINVARIANT          96
> =20
>  #define KVM_HC_VAPIC_POLL_IRQ          1
>  #define KVM_HC_MMU_OP                  2
>=20
> (b) Changes in Qemu code
>=20
> 1. Handling of new error code, which would update
> guest state with hosts invariant reg values.
>=20
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 65f867d569..0cf14323a2 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -452,7 +452,15 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level=
)
>              abort();
>          }
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
> -        if (ret) {
> +        if (ignore_invariant && (ret =3D=3D -KVM_EINVARIANT)) {
> +            /* Update Guest invariant to match with migrated host regs=
*/
> +            ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
> +            if (ret)
> +                ok =3D false;
> +            else
> +                cpu->cpreg_values[i] =3D r.addr;
> +        }
> +        else if (ret) {
>              /* We might fail for "unknown register" and also for
>               * "you tried to set a register which is constant with
>               * a different value from what it actually contains".
>=20
> 2. ignore_invariant is the flag I was referring to which is what you al=
so
> mentioned opt-in. This can be supplied as a command line parameter to q=
emu on Machine B.

The same libvirt folk also suggest that a QMP command be provided that
allows the selection of this ignore-invariant mode (in addition to or
instead of the command line parameter.) Otherwise a guest that has
already started without the parameter will not be able to migrate to
a "close enough" host - even if it's decided later that it would be OK
to do so.

>=20
> PS: I will add code to put warning logs as suggested by Dave.

Yeah, I like that idea too.

This approach looks good to me. Let's see what maintainers say when they
see the patch submission.

Thanks,
drew
