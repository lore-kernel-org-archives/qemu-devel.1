Received: from eggs.gnu.org ([2001:4830:134:3::10]:37716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f0Y1q-00070l-Gh
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f0Y1n-0006vb-DT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f0Y1n-0006u1-4U
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:43:35 -0400
Date: Mon, 26 Mar 2018 16:43:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180326194330.GB5046@localhost.localdomain>
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
	<20180323201852.GB1396@localhost.localdomain>
	<CANRm+CwCyMzCkqs3J27tq32xg4bBsh1V4fh-MJBWCStVyLY2sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANRm+CwCyMzCkqs3J27tq32xg4bBsh1V4fh-MJBWCStVyLY2sA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Sun, Mar 25, 2018 at 11:33:01AM +0800, Wanpeng Li wrote:
> 2018-03-24 4:18 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> > On Fri, Mar 16, 2018 at 07:36:42AM -0700, Wanpeng Li wrote:
> >> From: Wanpeng Li <wanpengli@tencent.com>
> >>
> >> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides user=
space with
> >> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/=
HLT/PAUSE
> >> in order that to improve latency in some workloads.
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> >
> >
> > Thanks.
> >
> > Patch looks good (except for comment below), but I would like to
> > see QEMU documentation mentioning what exactly are the practical
> > consequences of setting "+kvm-hint-dedicated" (especially what
> > could happen if people enable the flag without properly
> > configuring vCPU pinning).
> >
> >
> > [...]
> >> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
> >> +        int disable_exits =3D kvm_check_extension(cs->kvm_state, KV=
M_CAP_X86_DISABLE_EXITS);
> >> +        if (disable_exits) {
> >> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> >> +                              KVM_X86_DISABLE_EXITS_HLT |
> >> +                              KVM_X86_DISABLE_EXITS_PAUSE);
> >> +        }
> >
> > Documentation/virtual/kvm/api.txt says that KVM_FEATURE_PV_UNHALT
> > shouldn't be enabled if disabling HLT exits.  This needs to be
> > handled by QEMU.
>=20
> This is handled by KVM(in kvm_update_cpuid()) currently to avoid kvm
> userspace doing something crazy.
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=3Dqueue&id=3D=
caa057a2cad647fb368a12c8e6c410ac4c28e063

This seems to disable kvm-pv-unhalt silently if
KVM_X86_DISABLE_EXITS_HLT is enabled.  We shouldn't do that if
the user explicitly requested +kvm-pv-unhalt in the command-line.

>=20
> >
> > Probably the simplest solution is to not allow kvm-hint-dedicated
> > to be enabled if kvm-pv-unhalt is.  This should be mentioned in
> > QEMU documentation, also, especially considering that we might
> > enable kvm-pv-unhalt by default in future QEMU versions.
>=20
> As Locking guy Waiman mentioned before:
> > Generally speaking, unfair lock performs well for VMs with a small nu=
mber of vCPUs. Native qspinlock may perform better than pvqspinlock if th=
ere is vCPU pinning and there is no vCPU over-commitment.
> I think +kvm-hint-dedicated, -kvm-pv-unhalt is more suitable for vCPU
> pinning and there is no vCPU over-commitment, on the contrary,
> -kvm-hint-dedicated, +kvm-pv-unhalt is more prefer.

Disabling kvm-pv-unhalt by default if only "-cpu
...,+kvm-hint-dedicated" is used makes sense.  But we still need
the system to not silently ignore options if
"-cpu ...,+kvm-pv-unhalt,+kvm-hint-dedicated" is specified.

--=20
Eduardo
