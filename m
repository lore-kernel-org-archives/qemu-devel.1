Received: from eggs.gnu.org ([2001:4830:134:3::10]:59448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dKVYe-000722-O0
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 16:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dKVYb-0006fm-Kv
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 16:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dKVYb-0006ff-FP
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 16:03:25 -0400
Date: Mon, 12 Jun 2017 22:03:15 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170612200315.GB16151@potion>
References: <1497274251-26448-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497274251-26448-1-git-send-email-jianjay.zhou@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC] migration: kvmclock: save and load the
 PVCLOCK_TSC_UNSTABLE_BIT flag when migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com

2017-06-12 21:30+0800, Jay Zhou:
> Guest using kvmclock will be hanged when migrating from unstable
> tsc host to stable tsc host occasionally.
> Sometimes, the tsc timestamp saved at the source side will be
> backward when the guest stopped, and this value is transferred
> to the destination side. The guest at the destination side thought
> kvmclock is stable, so the protection mechanism against time
> going backwards is not used.
> When the first time vcpu0 enters the guest at the destination
> side to update the wall clock, the result of
> pvclock_clocksource_read will be backward occasionally,
> which results in the wall clock drift.
> 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
>  
>      if (running) {
>          struct kvm_clock_data data = {};
> +        uint8_t flags_at_migration;
>  
>          /*
>           * If the host where s->clock was read did not support reliable
>           * KVM_GET_CLOCK, read kvmclock value from memory.
>           */
>          if (!s->clock_is_reliable) {

'clock_is_reliable = true' on all newer KVMs (v4.9+), so I don't see a
reason to add a feature that can't be used.

> -            uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
> +            uint64_t pvclock_via_mem = kvmclock_current_nsec(s,
> +                                                    &flags_at_migration);

kvmclock_current_nsec() was introduced to work around the problem with
backward time, so we should understand why it returns a time that is
backwards if we want to do something for old KVMs ...

Is pvclock_via_mem < s->clock?

Thanks.

>              /* We can't rely on the saved clock value, just discard it */
>              if (pvclock_via_mem) {
>                  s->clock = pvclock_via_mem;
> +                /* whether src kvmclock has PVCLOCK_TSC_STABLE_BIT flag */
> +                if (!(flags_at_migration & PVCLOCK_TSC_STABLE_BIT)) {
> +                    data.flags |= MIGRATION_PVCLOCK_TSC_UNSTABLE_BIT;
> +                }
>              }
>          }
