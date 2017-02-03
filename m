Received: from eggs.gnu.org ([2001:4830:134:3::10]:34387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZbfO-0000ko-Hn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZbfN-000076-97
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:04:34 -0500
Date: Fri, 3 Feb 2017 19:04:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170203110423.GC28271@lemon>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-9-git-send-email-armbru@redhat.com>
	<9684a908-f425-82d8-046b-19cc17d01f55@redhat.com>
	<87r33o3emm.fsf@dusky.pond.sub.org>
	<2bcf4c7c-5c29-fda5-1ba3-5828600a8995@redhat.com>
	<8760l0ebgq.fsf@dusky.pond.sub.org>
	<e0f2369d-6ebf-ae73-abf1-7021b257748c@redhat.com>
	<87a8a9vuhu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a8a9vuhu.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] hw: Drop superfluous special checks
 for orphaned -drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mreitz@redhat.com, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Mon, 01/30 09:10, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
> > On 01/27/2017 11:04 AM, Markus Armbruster wrote:
> >> John Snow <jsnow@redhat.com> writes:
> >> 
> >>> On 01/27/2017 06:51 AM, Markus Armbruster wrote:
> >>>> John Snow <jsnow@redhat.com> writes:
> >>>>
> >>>>> On 01/26/2017 10:09 AM, Markus Armbruster wrote:
> >>>>>> We've traditionally rejected orphans here and there, but not
> >>>>>> systematically.  For instance, the sun4m machines have an onboard SCSI
> >>>>>> HBA (bus=0), and have always rejected bus>0.  Other machines with an
> >>>>>> onboard SCSI HBA don't.
> >>>>>>
> >>>>>> Commit a66c9dc made all orphans trigger a warning, and the previous
> >>>>>> commit turned this into an error.  The checks "here and there" are now
> >>>>>> redundant.  Drop them.
> >>>>>>
> >>>>>> Note that the one in mips_jazz.c was wrong: it rejected bus > MAX_FD,
> >>>>>> but MAX_FD is the number of floppy drives per bus.
> >>>>>>
> >>>>>> Error messages change from
> >>>>>>
> >>>>>>     $ qemu-system-x86_64 -drive if=ide,bus=2
> >>>>>>     qemu-system-x86_64: Too many IDE buses defined (3 > 2)
> >>>>>>     $ qemu-system-mips64 -M magnum,accel=qtest -drive if=floppy,bus=2,id=fd1
> >>>>>>     qemu: too many floppy drives
> >>>>>>     $ qemu-system-sparc -M LX -drive if=scsi,bus=1
> >>>>>>     qemu: too many SCSI bus
> >>>>>>
> >>>>>> to
> >>>>>>
> >>>>>>     $ qemu-system-x86_64 -drive if=ide,bus=2
> >>>>>>     qemu-system-x86_64: -drive if=ide,bus=2: machine type does not support this drive
> >>>>>>     $ qemu-system-mips64 -M magnum,accel=qtest -drive if=floppy,bus=2,id=fd1
> >>>>>>     qemu-system-mips64: -drive if=floppy,bus=2,id=fd1: machine type does not support this drive
> >>>>>>     $ qemu-system-sparc -M LX -drive if=scsi,bus=1
> >>>>>>     qemu-system-sparc: -drive if=scsi,bus=1: machine type does not support this drive
> >>>>>>
> >>>>>
> >>>>> Hm, that's a lot less helpful, isn't it? Can we augment with hints?
> >>>>
> >>>> The message itself may be less specific, but it now comes with a precise
> >>>> location.  Personally, I'd even find
> >>>>
> >>>>     qemu-system-sparc: -drive if=scsi,bus=1: *mumble* *mumble*
> >>>>
> >>>> more helpful than
> >>>>
> >>>>     qemu: too many SCSI bus
> >>>>
> >>>> because the former tells me *which* of the options is bad.  We tend to
> >>>> have lots and lots of them.
> >>>>
> >>>> The deleted special case errors cover only a minority of "orphan"
> >>>> -drive.  If these cases need improvement, then so will the general case.
> >>>> If you can come up with a hint that makes the general case message more
> >>>> useful, I'm more than happy to squash it into PATCH 6.
> >>>>
> >>>
> >>> The old error had "why" and the new error has "where" but neither has
> >>> both. I would suggest that from the "why" you can divine the "where,"
> >>> but the opposite is not as easily true.
> >> 
> >> Some users will be able to divine more easily than others.  Consider my
> >> "too many floppy drives" example.  There's just one, and the machine
> >> actually supports two.  The user has to make the connection to "bus=2"
> >> somehow.  Now, anybody crazy enough to mess with bus= can probably be
> >> expected to figure this out, but still, the deleted error messages
> >> aren't exactly wonderful.
> >> 
> >>> The new error even suggests information I think is wrong and misleading:
> >>> We do support SCSI! (Just not this many of them.)
> >> 
> >> Well, the error doesn't say "machine doesn't support SCSI", only
> >> "doesn't support this particular -drive".  Perhaps it could be worded
> >> more clearly.  Ideas?
> >> 
> >
> > Ah, I see what you mean now. I interpreted "this drive" to mean SCSI,
> > not this SCSI *instance*.
> 
> Uh, I would've written "does not support if=scsi" then.  But I see where
> you come from.
> 
> >                           If it can be made clearer that QEMU is simply
> > unable to instantiate this particular instance, that'd be fine.
> >
> > Instead of "Machine type does not support this drive,"
> >
> > how about
> >
> > "Machine type cannot instantiate this drive instance"
> 
> Hmm.
> 
> > Or ... follow your own best judgement. This is really YOUR wheelhouse.
> > My example is a little wordy.
> 
> All I can come up with is even wordier: "Machine type doesn't support
> this combination of if, bus, unit", or "if=scsi,bus=%d,unit=%d not
> supported with this machine type".  Could also be confusing when the
> user specified index instead of bus, unit.
> 
> Good error messages are hard...

I guess the painpoint is "okay, what the heck does the machine support then?" -
that "3 > 2" is the good part of the old message.

Do we have a user documentation for this? Or, can we give a hint how to figure
that out?

Fam
