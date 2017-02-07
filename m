Received: from eggs.gnu.org ([2001:4830:134:3::10]:35855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cb4jU-0007LH-9n
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cb4jP-0004aU-Bm
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cb4jP-0004aN-35
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:18:47 -0500
Date: Tue, 7 Feb 2017 10:18:25 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20170207121822.GA6270@amt.cnet>
References: <20161104094322.GA16930@amt.cnet> <20161104165933.GA3027@amt.cnet>
	<20161107154610.GG2054@work-vm> <20161107194058.GB28327@amt.cnet>
	<CANRm+CyzwtZqaGmhTj2pdk8ipjWSXuwtSHp9NzwA7aQR3ZG=cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CyzwtZqaGmhTj2pdk8ipjWSXuwtSHp9NzwA7aQR3ZG=cA@mail.gmail.com>
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
To: Wanpeng Li <kernellwp@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Juan Quintela <quintela@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Feb 07, 2017 at 06:02:13PM +0800, Wanpeng Li wrote:
> 2016-11-08 3:41 GMT+08:00 Marcelo Tosatti <mtosatti@redhat.com>:
> > On Mon, Nov 07, 2016 at 03:46:11PM +0000, Dr. David Alan Gilbert wrote:
> >> * Marcelo Tosatti (mtosatti@redhat.com) wrote:
> >> > This patch, relative to pre-copy migration codepath,
> >> > measures the time between vm_stop() and pre_save(),
> >> > which includes copying the remaining RAM to destination,
> >> > and advances the clock by that amount.
> >> >
> >> > In a VM with 5 seconds downtime, this reduces the guest
> >> > clock difference on destination from 5s to 0.2s.
> >> >
> >> > Tested with Linux and Windows 2012 R2 guests with -cpu XXX,+hv-time.
> >>
> >> One thing that bothers me is that it's only this clock that's
> >> getting corrected; doesn't it cause things to get upset when
> >> one clock moves and the others dont?
> >
> > If you are correlating the clocks, then yes.
> >
> > Older Linux guests get upset (marking the TSC clocksource unstable
> > because the watchdog checks TSC vs kvmclock), but there is a workaround for it
> > in newer guests
> > (kvmclock interface to notify watchdog to not complain).
> 
> Could you point out which interface? I didn't find it.
> 
> Regards,
> Wanpeng Li

PVCLOCK_GUEST_STOPPED flag.

> 
> >
> > Note marking TSC clocksource unstable on older guests is harmless
> > because kvmclock is the standard clocksource.
> >
> > For Windows guests, i don't know that Windows correlates between different
> > clocks.
> >
> > That is, there is relative control as to which software reads kvmclock
> > or Windows TIMER MSR, so i don't see the need to advance every clock
> > exposed.
> >
> >> Shouldn't the pause delay be recorded somewhere architecturally
> >> independent and then be a thing that kvm-clock happens to use and
> >> other clocks might as well?
> >
> > In theory, yes. In practice, i don't see the need for this...
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
