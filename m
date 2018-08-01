Received: from eggs.gnu.org ([2001:4830:134:3::10]:39277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fknSg-00016M-Gb
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fknSc-0007ZF-OY
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:30:30 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:44831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1fknSc-0007Yz-It
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:30:26 -0400
Received: by mail-yb0-x244.google.com with SMTP id l16-v6so7278812ybk.11
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 02:30:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531315364-2551-1-git-send-email-xieyongji@baidu.com>
References: <1531315364-2551-1-git-send-email-xieyongji@baidu.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 1 Aug 2018 17:30:25 +0800
Message-ID: <CAONzpcasgid2N3iGCTHR7aVFx1MLJaYYZ54y2Jm4uEshGAPHUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] kvmclock: run KVM_KVMCLOCK_CTRL ioctl in
 vcpu thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?B?6LCi5rC45ZCJ?= <elohimes@gmail.com>, chaiwen@baidu.com

Ping...

On 11 July 2018 at 21:22, Yongji Xie <elohimes@gmail.com> wrote:
> According to KVM API Documentation, we should only
> run vcpu ioctls from the same thread that was used
> to create the vcpu. This patch makes KVM_KVMCLOCK_CTRL
> ioctl consistent with the Documentation.
>
> No functional change.
>
> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> Signed-off-by: Chai Wen <chaiwen@baidu.com>
> ---
>  hw/i386/kvm/clock.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 0bf1c60..25ea783 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -147,6 +147,15 @@ static void kvm_update_clock(KVMClockState *s)
>      s->clock_is_reliable = kvm_has_adjust_clock_stable();
>  }
>
> +static void do_kvmclock_ctrl(CPUState *cpu, run_on_cpu_data data)
> +{
> +    int ret = kvm_vcpu_ioctl(cpu, KVM_KVMCLOCK_CTRL, 0);
> +
> +    if (ret && ret != -EINVAL) {
> +        fprintf(stderr, "%s: %s\n", __func__, strerror(-ret));
> +    }
> +}
> +
>  static void kvmclock_vm_state_change(void *opaque, int running,
>                                       RunState state)
>  {
> @@ -183,13 +192,7 @@ static void kvmclock_vm_state_change(void *opaque, int running,
>              return;
>          }
>          CPU_FOREACH(cpu) {
> -            ret = kvm_vcpu_ioctl(cpu, KVM_KVMCLOCK_CTRL, 0);
> -            if (ret) {
> -                if (ret != -EINVAL) {
> -                    fprintf(stderr, "%s: %s\n", __func__, strerror(-ret));
> -                }
> -                return;
> -            }
> +            run_on_cpu(cpu, do_kvmclock_ctrl, RUN_ON_CPU_NULL);
>          }
>      } else {
>
> --
> 1.7.9.5
>
