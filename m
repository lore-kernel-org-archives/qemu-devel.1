Received: from eggs.gnu.org ([2001:4830:134:3::10]:58698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dKVUU-0005r0-M3
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dKVUR-0004rO-Kh
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dKVUR-0004qX-ER
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:59:07 -0400
Date: Mon, 12 Jun 2017 21:52:10 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170612195209.GA16151@potion>
References: <1497273796-44720-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497273796-44720-1-git-send-email-jianjay.zhou@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC] KVM: X86: save and load
 PVCLOCK_TSC_UNSTABLE_BIT when migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com

2017-06-12 21:23+0800, Jay Zhou:
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

Hm, are you using KVM that has e3fd9a93a12a (4.9+)?

If you get a timestamp from KVM_GET_CLOCK() and pass that to
KVM_SET_CLOCK(), then kvmclock should not jump backwards anymore
(it could before 4.9, but only if the host had stable tsc).

A possible source of this bug in when QEMU recomputes the timestamp to
pass to KVM_SET_CLOCK() using TSC and kvmclock page.

Can you provide the values used for KVM_GET_CLOCK and KVM_SET_CLOCK when
the bug occurs?

Thanks.
