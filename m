Received: from eggs.gnu.org ([2001:4830:134:3::10]:39271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cX7JJ-0008CS-Fe
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cX7JI-000655-Hm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:15:29 -0500
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-9-git-send-email-armbru@redhat.com>
	<9684a908-f425-82d8-046b-19cc17d01f55@redhat.com>
	<87r33o3emm.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <2bcf4c7c-5c29-fda5-1ba3-5828600a8995@redhat.com>
Date: Fri, 27 Jan 2017 09:15:19 -0500
MIME-Version: 1.0
In-Reply-To: <87r33o3emm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org, mreitz@redhat.com



On 01/27/2017 06:51 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 01/26/2017 10:09 AM, Markus Armbruster wrote:
>>> We've traditionally rejected orphans here and there, but not
>>> systematically.  For instance, the sun4m machines have an onboard SCSI
>>> HBA (bus=0), and have always rejected bus>0.  Other machines with an
>>> onboard SCSI HBA don't.
>>>
>>> Commit a66c9dc made all orphans trigger a warning, and the previous
>>> commit turned this into an error.  The checks "here and there" are now
>>> redundant.  Drop them.
>>>
>>> Note that the one in mips_jazz.c was wrong: it rejected bus > MAX_FD,
>>> but MAX_FD is the number of floppy drives per bus.
>>>
>>> Error messages change from
>>>
>>>     $ qemu-system-x86_64 -drive if=ide,bus=2
>>>     qemu-system-x86_64: Too many IDE buses defined (3 > 2)
>>>     $ qemu-system-mips64 -M magnum,accel=qtest -drive if=floppy,bus=2,id=fd1
>>>     qemu: too many floppy drives
>>>     $ qemu-system-sparc -M LX -drive if=scsi,bus=1
>>>     qemu: too many SCSI bus
>>>
>>> to
>>>
>>>     $ qemu-system-x86_64 -drive if=ide,bus=2
>>>     qemu-system-x86_64: -drive if=ide,bus=2: machine type does not support this drive
>>>     $ qemu-system-mips64 -M magnum,accel=qtest -drive if=floppy,bus=2,id=fd1
>>>     qemu-system-mips64: -drive if=floppy,bus=2,id=fd1: machine type does not support this drive
>>>     $ qemu-system-sparc -M LX -drive if=scsi,bus=1
>>>     qemu-system-sparc: -drive if=scsi,bus=1: machine type does not support this drive
>>>
>>
>> Hm, that's a lot less helpful, isn't it? Can we augment with hints?
> 
> The message itself may be less specific, but it now comes with a precise
> location.  Personally, I'd even find
> 
>     qemu-system-sparc: -drive if=scsi,bus=1: *mumble* *mumble*
> 
> more helpful than
> 
>     qemu: too many SCSI bus
> 
> because the former tells me *which* of the options is bad.  We tend to
> have lots and lots of them.
> 
> The deleted special case errors cover only a minority of "orphan"
> -drive.  If these cases need improvement, then so will the general case.
> If you can come up with a hint that makes the general case message more
> useful, I'm more than happy to squash it into PATCH 6.
> 

The old error had "why" and the new error has "where" but neither has
both. I would suggest that from the "why" you can divine the "where,"
but the opposite is not as easily true.

The new error even suggests information I think is wrong and misleading:
We do support SCSI! (Just not this many of them.)

No suggestions for how or where to append the hints. This is not the
hill I am preparing to die on.

--js
