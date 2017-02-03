Received: from eggs.gnu.org ([2001:4830:134:3::10]:33948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZfwY-0000HR-QD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZfwX-0002we-Ng
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:38:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-9-git-send-email-armbru@redhat.com>
	<9684a908-f425-82d8-046b-19cc17d01f55@redhat.com>
	<87r33o3emm.fsf@dusky.pond.sub.org>
	<2bcf4c7c-5c29-fda5-1ba3-5828600a8995@redhat.com>
	<8760l0ebgq.fsf@dusky.pond.sub.org>
	<e0f2369d-6ebf-ae73-abf1-7021b257748c@redhat.com>
	<87a8a9vuhu.fsf@dusky.pond.sub.org> <20170203110423.GC28271@lemon>
	<87vasrl7ls.fsf@dusky.pond.sub.org> <20170203140706.GD28271@lemon>
Date: Fri, 03 Feb 2017 16:38:25 +0100
In-Reply-To: <20170203140706.GD28271@lemon> (Fam Zheng's message of "Fri, 3
	Feb 2017 22:07:06 +0800")
Message-ID: <87zii3e13i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mreitz@redhat.com, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>, John Snow <jsnow@redhat.com>

Fam Zheng <famz@redhat.com> writes:

> On Fri, 02/03 14:35, Markus Armbruster wrote:
>> > I guess the painpoint is "okay, what the heck does the machine support then?" -
>> 
>> At the place where we can reliably detect orphaned drives regardless of
>> what the machine initialization code does, we have no idea.
>> 
>> > that "3 > 2" is the good part of the old message.
>> 
>> At the places that actually adopt drives, we know.  But there are many
>> of them.  Just three check for orphans.  One of them gets it right
>> (ide/core.c), one of them gets it wrong (mips_jazz.c), and one of them
>> sets a problematic example (sun4m.c): if copied to a machine that lets
>> users configure additional SCSI HBAs, it would break if=scsi for those.
>> Dampens my enthusiasm for improving the error message by adding similar
>> checks to all the places that adopt drives.
>> 
>> We could make machines declare what they support.  Better, I think.  So
>> if you have a burning desire to leave your mark in git-blame for every
>> machine...
>
> Could you please remind me the situation about if=scsi across all machines? If
> it is simply legacy and it's recommended to use "-drive if=none" and "-device
> ...", I think saying this in the error message is enough; or if "if=scsi" is a
> valid way for some machines, then maybe we can declare support limits found with
> your script?

Short story: once my followup series "[PATCH 0/3] hw: Deprecate unwanted
use -drive if=scsi" is in, if=scsi is deprecated except for machine
types magnum pica61 LX SPARCClassic SPARCbook SS-10 SS-20 SS-4 SS-5
SS-600MP Voyager realview-eb realview-eb-mpcore versatileab versatilepb
pseries-*.  Documenting what they support would be feasible.

Long story: it's... complicated.

Ideally, -drive if=T,... (T!=none) would be sugar for a -drive / -device
combo.  It actually is for if=virtio: drive_new() desugars it.

All the others are implemented by machine-specific ad hoc code,
i.e. machine initialization creates devices however it sees fit.

For modern devices, what's done is often pretty much equivalent to a
-device.  For instance, a PC machine type's action for
if=ide,media=disk,bus=B,unit=U is pretty much equivalent to -device
ide-hd,bus=ide.B,unit=U.  See also docs/qdev-device-use.txt.

Desugaring details depend on the machine, and are code, not data.  Data
would be easier to find and document.

For non-qdevified devices, we're even farther from a clean desugaring,
simply because these are not available with -device, but can only be
created by code.  For instance, some machine types implement if=sd with
the non-qdevified hw/sd/sd.c; grep for sd_init().

So, we're not yet ready for deprecating if!=none.

But you asked for if=scsi specifically.

Only a few machines have a SCSI HBA onboard, and therefore adopt if=scsi
drives: magnum pica61 LX SPARCClassic SPARCbook SS-10 SS-20 SS-4 SS-5
SS-600MP Voyager.  We're not deprecating this usage.

A few more create SCSI HBAs on demand: realview-eb realview-eb-mpcore
versatileab versatilepb pseries-* pc*.  My followup series deprecates it
for pc* only.

Finally, there's some special SCSI magic: most SCSI HBAs adopt if=scsi
drives independend of machine initialization.  My followup series
deprecates that.
