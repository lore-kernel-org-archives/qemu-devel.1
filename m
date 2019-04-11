Received: from eggs.gnu.org ([209.51.188.92]:39885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hEU7U-0005e3-TZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hEU7T-0001rc-Ko
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:27:36 -0400
References: <1552370960-2061-1-git-send-email-guoheyi@huawei.com>
	<CAFEAcA-29Q-sTg2wLre0GJJCr2gfu89rg0vuTOf7cW5drE4d7Q@mail.gmail.com>
	<136f773f-9b08-a39b-3ecb-2c00ff290b49@arm.com>
	<22f57e8a-bdb0-ffeb-ab78-3e9e41cac66b@arm.com>
	<20190315085948.GB10950@e113682-lin.lund.arm.com>
	<ff1db661-13c2-50ff-940e-4a1d71bd0309@huawei.com>
	<101c5f17-9811-e2d0-ff3c-a0e64beee921@arm.com>
	<662367df-e702-dd0a-da83-f1b448c5f203@huawei.com>
	<1a315d48-1657-e50b-97ec-ead9c6c459c2@huawei.com>
	<0e1f903a-d445-6bef-3dfd-6d9f7f6a5f98@arm.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <3867fef8-15d9-623c-7bd3-2c673dccf745@huawei.com>
Date: Thu, 11 Apr 2019 15:27:16 +0800
MIME-Version: 1.0
In-Reply-To: <0e1f903a-d445-6bef-3dfd-6d9f7f6a5f98@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] arm/cpu: fix soft lockup panic after
 resuming from stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steven Price <steven.price@arm.com>, Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu, wanghaibin 00208455 <wanghaibin.wang@huawei.com>

Hi Steve,

After reading kernel code about time keeping and something related, I've not got a clear picture of how we can use MSR_KVM_WALL_CLOCK_NEW to keep wall clock in guest VM.

1. On X86, MSR_KVM_WALL_CLOCK_NEW is only used by the callback of system suspend and resume; I didn't find it used for runtime wall clock reading.
2. To use the MSR for wall clock synchronization, shall we register KVM PV-clock as a higher rating clock source, so that it will be bound to tk_core.timekeeper and be read at each time of running update_wall_time() in each timer tick?
3. If the above is true, how can we keep the paravirtualized wall clock always updated? Is it always trapped to the hypervisor? I'm afraid this may cause performance loss. If there is no trap and the data is updated by the hypervisor periodically, how can we guarantee the accuracy?

Meanwhile it seems easier to use KVM_KVMCLOCK_CTRL to get rid of false positive soft lock panic, and guest can rely on cntvct for wall clock updating as it does now, and it seems not difficult for the hypervisor to keep cntvct "always on" and "monotonic".

Please let me know if I miss something.

Thanks,
Heyi

On 2019/3/27 1:12, Steven Price wrote:
> Hi Heyi,
>
> On 26/03/2019 13:53, Heyi Guo wrote:
>> I also tested save/restore operations, and observed that clock in guest
>> would not jump after restoring either. If we consider guest clock not
>> being synchronized with real wall clock as an issue, does it mean
>> save/restore function has the same issue?
> Basically at the moment when the guest isn't running you have a choice
> of two behaviours:
>
>   1. Stop (i.e. save/restore) CNTVCT - this means that the guest sees no
> time occur. If the guest needs to have a concept of wall-clock time
> (e.g. it communicates with other systems over a network) then this can
> cause problems (e.g. timeouts might be wrong, certificates might start
> appearing to be in the future etc).
>
>   2. Leave CNTVCT running - the guest sees the time pass but interprets
> the vCPUs as effectively having locked up. Linux will trigger the soft
> lockup warning.
>
> There are two ways of solving this, which match the two behaviours above:
>
>   1. Provide the guest with a view of wall-clock time. The obvious way of
> doing this is with a pvclock implementation like MSR_KVM_WALL_CLOCK_NEW
> for x86.
>
>   2. Inform the guest to ignore the apparent "soft-lockup". There's
> already an ioctl for x86 for this: KVM_KVMCLOCK_CTRL
>
> My preference is for option 1 - as this gives the guest a good view of
> both the time that it is actually executing (useful for internal
> watchdog timers like the soft-lockup one in Linux) and maintains a view
> of wall-clock time (useful when communicating with other external
> services - e.g. the a server on the internet). Your patch to QEMU
> provides the first step of that, but as you mention there's much more to do.
>
> One thing I haven't investigated in great detail is how KVM handles the
> timer during various forms of suspend. In particular for suspend types
> like full hibernation the host's physical counter will jump (quite
> possibly backwards) - I haven't looked in detail how KVM presents this
> to the guest. Hopefully not by making it go backwards!
>
> I'm not sure how much time I'm going to have to look at this in the near
> future, but please keep me in the loop if you decide to tackle any of this.
>
> Thanks,
>
> Steve
>
> .
>
