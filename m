Received: from eggs.gnu.org ([2001:4830:134:3::10]:40253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dbnWK-0002vK-LP
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dbnWJ-0004rG-BI
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:40:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1dbnWJ-0004pV-6e
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:40:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id j194so16116276oib.4
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 05:40:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501444898-27668-1-git-send-email-peng.hao2@zte.com.cn>
References: <1501444898-27668-1-git-send-email-peng.hao2@zte.com.cn>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 30 Jul 2017 20:40:28 +0800
Message-ID: <CANRm+Cw0KM45XGGNRzKosyG2jBmBObjhJnGSpm7YNNz1hXHByg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-i386 : fix a race condition result
 to lost INIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm <kvm@vger.kernel.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

2017-07-31 4:01 GMT+08:00 Peng Hao <peng.hao2@zte.com.cn>:
> when SMP VM start, AP may lost INIT because of receiving INIT between
> kvm_vcpu_ioctl_x86_get/set_vcpu_events.
>
>    vcpu 0                             vcpu 1
>                                kvm_vcpu_ioctl_x86_get_vcpu_events
>                                        events->smi.latched_init=0
>  send INIT to vcpu1
>    set vcpu1's pending_events
>                                kvm_vcpu_ioctl_x86_set_vcpu_events
>                                     events->smi.latched_init == 0
>                                       clear INIT in pending_events
> considering migration, just at level >= KVM_PUT_RESET_STATE,
> add KVM_VCPUEVENT_VALID_SMM in events.flags.I think it is better to
> modify in qemu.

Do it in qemu just avoids to trigger the bug instead of fixing it. Why
we touch INIT pending if INIT is not latched in SMM?

Regards,
Wanpeng Li

>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  target/i386/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index a6613e1..be146cb 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2438,7 +2438,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>          /* Stop SMI delivery on old machine types to avoid a reboot
>           * on an inward migration of an old VM.
>           */
> -        if (!cpu->kvm_no_smi_migration) {
> +        if (!cpu->kvm_no_smi_migration && (level >= KVM_PUT_RESET_STATE)) {
>              events.flags |= KVM_VCPUEVENT_VALID_SMM;
>          }
>      }
> --
> 1.8.3.1
>
>
