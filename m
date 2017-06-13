Received: from eggs.gnu.org ([2001:4830:134:3::10]:56121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dKmFg-0006uc-L5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dKmFd-0000QT-JS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dKmFd-0000Q5-Aj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:52:57 -0400
Date: Tue, 13 Jun 2017 15:52:52 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170613135252.GA29382@potion>
References: <1497273796-44720-1-git-send-email-jianjay.zhou@huawei.com>
	<20170612195209.GA16151@potion> <593FD3E0.5070807@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <593FD3E0.5070807@huawei.com>
Content-Transfer-Encoding: quoted-printable
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

2017-06-13 20:00+0800, Jay Zhou:
> On 2017/6/13 3:52, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> > If you get a timestamp from KVM_GET_CLOCK() and pass that to
> > KVM_SET_CLOCK(), then kvmclock should not jump backwards anymore
> > (it could before 4.9, but only if the host had stable tsc).
>=20
> If migrating from old KVMs to newer KVMs (v4.9+), the clock member
> of struct KVMClockState is migrated to the destination side, but the
> clock_is_reliable isn't migrated.

clock_is_reliable is migrated as a subsection on newer QEMUs.

>                                   The value of clock_is_reliable is fal=
se
> at the source side, and it is true at the destination side.

clock_is_reliable is only set right after KVM_GET_CLOCK() and doesn't
change on the destination side.

>                                                             Is it possi=
ble
> the clock member of struct KVMClockState migrated is smaller than the
> last_value saved in the guest theoretically?

KVM_GET_CLOCK() should return the kvmclock timestamp that would be seen
by the guest at that time.  And KVM_SET_CLOCK() would set the timestamp
so that a guest reading at that time would see it.

And because the guest is not running after KVM_GET_CLOCK() and before
KVM_SET_CLOCK(), then it should never see a timestamp that goes
backwards -- the kvmclock is going to readable until "X - epsilon" and
from "X + epsilon", where X is the value QEMU got from KVM_GET_CLOCK().

>                                              Could you explain more
> why it should not jump backwards in the scenario of migrating from unst=
able
> tsc host to stable tsc host?

KVM_GET_CLOCK() returns clock based on ktime_get_boot_ns() and unstable
tsc host uses that to synchronize kvmclock on every VM entry, so the
last time we can read inside the guest is exteremely unlikely to be
larger that the value we get get from KVM_GET_CLOCK() after all VCPUs
have been paused -- the guest would have to run without a VM exit for a
really long time to make a delta of several microseconds.

KVM does have a KVM_SET_CLOCK() bug on a stable TSC destination that
could also shift the time, but that one could only be hit if the
destination was waiting for a long time and I hope it doesn't happen in
the wild, because we'd also be hitting it with stable source tsc.

> > Can you provide the values used for KVM_GET_CLOCK and KVM_SET_CLOCK w=
hen
> > the bug occurs?
>=20
> I didn't print these values out when the bug occured, and I do not have=
 the
> physical machine with unstable tsc clocksource now. But I will try to
> reproduce with the newest KVM and QEMU once I have.

Great, thanks!
