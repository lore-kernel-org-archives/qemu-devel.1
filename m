Received: from eggs.gnu.org ([2001:4830:134:3::10]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ezwP2-0003wy-8G
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 23:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ezwP1-0004NG-1G
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 23:33:04 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:32880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ezwP0-0004N1-SC
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 23:33:02 -0400
Received: by mail-ot0-x242.google.com with SMTP id 23-v6so6763799otj.0
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 20:33:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323201852.GB1396@localhost.localdomain>
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
	<20180323201852.GB1396@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 25 Mar 2018 11:33:01 +0800
Message-ID: <CANRm+CwCyMzCkqs3J27tq32xg4bBsh1V4fh-MJBWCStVyLY2sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

2018-03-24 4:18 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Fri, Mar 16, 2018 at 07:36:42AM -0700, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides userspac=
e with
>> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/HLT/=
PAUSE
>> in order that to improve latency in some workloads.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>
>
> Thanks.
>
> Patch looks good (except for comment below), but I would like to
> see QEMU documentation mentioning what exactly are the practical
> consequences of setting "+kvm-hint-dedicated" (especially what
> could happen if people enable the flag without properly
> configuring vCPU pinning).
>
>
> [...]
>> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
>> +        int disable_exits =3D kvm_check_extension(cs->kvm_state, KVM_CA=
P_X86_DISABLE_EXITS);
>> +        if (disable_exits) {
>> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
>> +                              KVM_X86_DISABLE_EXITS_HLT |
>> +                              KVM_X86_DISABLE_EXITS_PAUSE);
>> +        }
>
> Documentation/virtual/kvm/api.txt says that KVM_FEATURE_PV_UNHALT
> shouldn't be enabled if disabling HLT exits.  This needs to be
> handled by QEMU.

This is handled by KVM(in kvm_update_cpuid()) currently to avoid kvm
userspace doing something crazy.
https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=3Dqueue&id=3Dcaa0=
57a2cad647fb368a12c8e6c410ac4c28e063

>
> Probably the simplest solution is to not allow kvm-hint-dedicated
> to be enabled if kvm-pv-unhalt is.  This should be mentioned in
> QEMU documentation, also, especially considering that we might
> enable kvm-pv-unhalt by default in future QEMU versions.

As Locking guy Waiman mentioned before:
> Generally speaking, unfair lock performs well for VMs with a small number=
 of vCPUs. Native qspinlock may perform better than pvqspinlock if there is=
 vCPU pinning and there is no vCPU over-commitment.
I think +kvm-hint-dedicated, -kvm-pv-unhalt is more suitable for vCPU
pinning and there is no vCPU over-commitment, on the contrary,
-kvm-hint-dedicated, +kvm-pv-unhalt is more prefer.

Regards,
Wanpeng Li
