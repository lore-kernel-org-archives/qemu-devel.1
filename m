Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxXh0-0004TS-SZ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxXgx-0007Ma-Ha
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:17:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fxXgx-0007MC-9i
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:17:55 -0400
Date: Wed, 5 Sep 2018 15:17:49 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180905131749.khzu3s7ow5gbycx4@kamzik.brq.redhat.com>
References: <20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
	<20180829131653.gk4yhjdi2pk5bdcd@kamzik.brq.redhat.com>
	<DC466FE6-98B4-485B-BE4D-C4E228B36107@caviumnetworks.com>
	<20180831111121.n7zafn6peiwe6ojn@kamzik.brq.redhat.com>
	<1604D594-E6D4-48BB-A270-F7CF1092978B@caviumnetworks.com>
	<20180904095402.izdnqag3xak3mgsb@kamzik.brq.redhat.com>
	<EF2DEC36-DDCB-4169-A30F-15F29B7F52E9@caviumnetworks.com>
	<20180905122021.dfsvsvk6zn2ijefp@kamzik.brq.redhat.com>
	<9418075A-CF3E-4C04-8751-3E1CD7BF534B@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9418075A-CF3E-4C04-8751-3E1CD7BF534B@caviumnetworks.com>
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
Cc: "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Auger Eric <eric.auger@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Sep 05, 2018 at 12:42:05PM +0000, Jaggi, Manish wrote:
>=20
>=20
> > On 05-Sep-2018, at 5:50 PM, Andrew Jones <drjones@redhat.com> wrote:
> >=20
> > External Email
> >=20
> > On Wed, Sep 05, 2018 at 11:46:11AM +0000, Jaggi, Manish wrote:
> >> (a) Changes in KVM:
> >>=20
> >> - Introducing a specific error code (KVM_EINVARIANT) in case of inva=
riant writes.
> >> This should not change anything to API SET_ONE_REG KVM API.
> >> Not sure which is the best place to put the define=E2=80=A6
> >> I have added in include/uapi/linux/kvm_para.h.
> >>=20
> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >> index 22fbbdbece3c..c8a4fbe8a8bb 100644
> >> --- a/arch/arm64/kvm/sys_regs.c
> >> +++ b/arch/arm64/kvm/sys_regs.c
> >> @@ -1111,7 +1111,7 @@ static int __set_id_reg(const struct sys_reg_d=
esc *rd, void __user *uaddr,
> >>=20
> >>        /* This is what we mean by invariant: you can't change it. */
> >>        if (val !=3D read_id_reg(rd, raz))
> >> -               return -EINVAL;
> >> +               return -KVM_EINVARIANT;
> >>=20
> >>        return 0;
> >> }
> >> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_=
para.h
> >> index 6c0ce49931e5..3a49a321d0df 100644
> >> --- a/include/uapi/linux/kvm_para.h
> >> +++ b/include/uapi/linux/kvm_para.h
> >> @@ -17,6 +17,7 @@
> >> #define KVM_E2BIG              E2BIG
> >> #define KVM_EPERM              EPERM
> >> #define KVM_EOPNOTSUPP         95
> >> +#define KVM_EINVARIANT          96
> >>=20
> >> #define KVM_HC_VAPIC_POLL_IRQ          1
> >> #define KVM_HC_MMU_OP                  2
> >>=20
> >> (b) Changes in Qemu code
> >>=20
> >> 1. Handling of new error code, which would update
> >> guest state with hosts invariant reg values.
> >>=20
> >> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> >> index 65f867d569..0cf14323a2 100644
> >> --- a/target/arm/kvm.c
> >> +++ b/target/arm/kvm.c
> >> @@ -452,7 +452,15 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int le=
vel)
> >>             abort();
> >>         }
> >>         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
> >> -        if (ret) {
> >> +        if (ignore_invariant && (ret =3D=3D -KVM_EINVARIANT)) {
> >> +            /* Update Guest invariant to match with migrated host r=
egs*/
> >> +            ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
> >> +            if (ret)
> >> +                ok =3D false;
> >> +            else
> >> +                cpu->cpreg_values[i] =3D r.addr;
> >> +        }
> >> +        else if (ret) {
> >>             /* We might fail for "unknown register" and also for
> >>              * "you tried to set a register which is constant with
> >>              * a different value from what it actually contains".
> >>=20
> >> 2. ignore_invariant is the flag I was referring to which is what you=
 also
> >> mentioned opt-in. This can be supplied as a command line parameter t=
o qemu on Machine B.
> >=20
> > The same libvirt folk also suggest that a QMP command be provided tha=
t
> > allows the selection of this ignore-invariant mode (in addition to or
> > instead of the command line parameter.) Otherwise a guest that has
> > already started without the parameter will not be able to migrate to
> > a "close enough=E2=80=9D host
>=20
> ignore_invariant: This can be supplied as a command line parameter to q=
emu on Machine B.
> Machine A VM has to be migrated to B.

OK, I just confirmed with libvirt people that there's no need for the QMP
command in this case, as the source host doesn't require any knowledge of
it. The command line parameter (machine property?) must be discoverable
by libvirt, though, so it can know whether or not the destination host's
QEMU supports it.

Thanks,
drew
