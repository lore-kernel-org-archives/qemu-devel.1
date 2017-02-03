Received: from eggs.gnu.org ([2001:4830:134:3::10]:60911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZeWH-0002IO-Pm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZeWD-0004cc-VS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:07:21 -0500
Date: Fri, 3 Feb 2017 22:07:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170203140706.GD28271@lemon>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-9-git-send-email-armbru@redhat.com>
	<9684a908-f425-82d8-046b-19cc17d01f55@redhat.com>
	<87r33o3emm.fsf@dusky.pond.sub.org>
	<2bcf4c7c-5c29-fda5-1ba3-5828600a8995@redhat.com>
	<8760l0ebgq.fsf@dusky.pond.sub.org>
	<e0f2369d-6ebf-ae73-abf1-7021b257748c@redhat.com>
	<87a8a9vuhu.fsf@dusky.pond.sub.org> <20170203110423.GC28271@lemon>
	<87vasrl7ls.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vasrl7ls.fsf@dusky.pond.sub.org>
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mreitz@redhat.com, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, John Snow <jsnow@redhat.com>

On Fri, 02/03 14:35, Markus Armbruster wrote:
> > I guess the painpoint is "okay, what the heck does the machine support then?" -
> 
> At the place where we can reliably detect orphaned drives regardless of
> what the machine initialization code does, we have no idea.
> 
> > that "3 > 2" is the good part of the old message.
> 
> At the places that actually adopt drives, we know.  But there are many
> of them.  Just three check for orphans.  One of them gets it right
> (ide/core.c), one of them gets it wrong (mips_jazz.c), and one of them
> sets a problematic example (sun4m.c): if copied to a machine that lets
> users configure additional SCSI HBAs, it would break if=scsi for those.
> Dampens my enthusiasm for improving the error message by adding similar
> checks to all the places that adopt drives.
> 
> We could make machines declare what they support.  Better, I think.  So
> if you have a burning desire to leave your mark in git-blame for every
> machine...

Could you please remind me the situation about if=scsi across all machines? If
it is simply legacy and it's recommended to use "-drive if=none" and "-device
...", I think saying this in the error message is enough; or if "if=scsi" is a
valid way for some machines, then maybe we can declare support limits found with
your script?

Fam

> 
> > Do we have a user documentation for this? Or, can we give a hint how to figure
> > that out?
> 
> Try it out:
> 
>     for i in ide scsi floppy pflash mtd sd virtio xen
>     do
>         for ((b=0; b<4; b++))
>         do
>             for ((u=0; u<10; u++))
>             do
>                 echo q | qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -drive if=$i,bus=$b,unit=$u,file=tmp.qcow2 >/dev/null
>             done
>         done
>     done
> 
> My upper bounds for bus and unit are arbitrary.
