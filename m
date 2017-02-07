Received: from eggs.gnu.org ([2001:4830:134:3::10]:36194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1cb2bJ-0005vZ-UJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1cb2bI-0002QX-Sq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:02:18 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1cb2bI-0002Pr-MX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:02:16 -0500
Received: by mail-wr0-x242.google.com with SMTP id 89so5197207wrr.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 02:02:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161107194058.GB28327@amt.cnet>
References: <20161104094322.GA16930@amt.cnet> <20161104165933.GA3027@amt.cnet>
	<20161107154610.GG2054@work-vm> <20161107194058.GB28327@amt.cnet>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 7 Feb 2017 18:02:13 +0800
Message-ID: <CANRm+CyzwtZqaGmhTj2pdk8ipjWSXuwtSHp9NzwA7aQR3ZG=cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [QEMU PATCH v2] kvmclock: advance clock by time
 window between vm_stop and pre_save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Juan Quintela <quintela@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

2016-11-08 3:41 GMT+08:00 Marcelo Tosatti <mtosatti@redhat.com>:
> On Mon, Nov 07, 2016 at 03:46:11PM +0000, Dr. David Alan Gilbert wrote:
>> * Marcelo Tosatti (mtosatti@redhat.com) wrote:
>> > This patch, relative to pre-copy migration codepath,
>> > measures the time between vm_stop() and pre_save(),
>> > which includes copying the remaining RAM to destination,
>> > and advances the clock by that amount.
>> >
>> > In a VM with 5 seconds downtime, this reduces the guest
>> > clock difference on destination from 5s to 0.2s.
>> >
>> > Tested with Linux and Windows 2012 R2 guests with -cpu XXX,+hv-time.
>>
>> One thing that bothers me is that it's only this clock that's
>> getting corrected; doesn't it cause things to get upset when
>> one clock moves and the others dont?
>
> If you are correlating the clocks, then yes.
>
> Older Linux guests get upset (marking the TSC clocksource unstable
> because the watchdog checks TSC vs kvmclock), but there is a workaround for it
> in newer guests
> (kvmclock interface to notify watchdog to not complain).

Could you point out which interface? I didn't find it.

Regards,
Wanpeng Li

>
> Note marking TSC clocksource unstable on older guests is harmless
> because kvmclock is the standard clocksource.
>
> For Windows guests, i don't know that Windows correlates between different
> clocks.
>
> That is, there is relative control as to which software reads kvmclock
> or Windows TIMER MSR, so i don't see the need to advance every clock
> exposed.
>
>> Shouldn't the pause delay be recorded somewhere architecturally
>> independent and then be a thing that kvm-clock happens to use and
>> other clocks might as well?
>
> In theory, yes. In practice, i don't see the need for this...
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
