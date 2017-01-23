Received: from eggs.gnu.org ([2001:4830:134:3::10]:57465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVk6A-0003ZA-4A
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVk66-0006Qi-Nk
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:16:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
Date: Mon, 23 Jan 2017 20:16:03 +0100
In-Reply-To: <2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com> (Paolo
	Bonzini's message of "Mon, 23 Jan 2017 17:48:32 +0100")
Message-ID: <877f5l1tak.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/01/2017 10:48, Markus Armbruster wrote:
>> The PC machines (pc-q35-* pc-i440fx-* pc-* isapc xenfv) automatically
>> create lsi53c895a SCSI HBAs and SCSI devices to honor -drive if=scsi.
>> For giggles, try -drive if=scsi,bus=25,media=cdrom --- this makes QEMU
>> create 25 of them.
>> 
>> The lsi53c895a is thoroughly obsolete (PCI Ultra2 SCSI, ca. 2000), and
>> currently has no maintainer in QEMU.  megasas is a better choice,
>> except for old OSes, which lack drivers. virtio-scsi is a much better
>> choice when you have a driver, but only (newish) Linux comes with one
>> in the box.  There is no good default that works for all guests.
>> 
>> Instead of supplying the not-so-good default just because we've always
>> supplied it, make the user pick, by not creating any SCSI HBAs for
>> -drive if=scsi.  The user now needs to create the SCSI HBA himself
>> with -device.  The SCSI devices will still be created automatically.
>> 
>> For backward compatibility, keep the traditional behavior for old
>> machine types.
>
> It would print an "orphaned device" message, right?

Yes.

Before this patch, you can't get an "orhpaned" warning for if=scsi with
a PC machine.

After this patch, you get one for every if=scsi with new PC machine
types.

>                                                      Could we change
> those messages to errors

Fine with me, but when it comes to arguing for backward compatibility of
our byzantine command line, I'm kind of like a lethargic public defender
with an overly deep relationship to Bourbon.  "Your honor, sure capital
punishment is called for?  Yes?  Okay then."

I vaguely recall discussing the topic with Peter (cc'ed).  If memory
serves, one concern was breaking usage of -device with -drive lacking
if=...  Works fine (no warning) with machines that don't pick up drives
with their default block interface type, i.e. most of them.  But PATCH 3
changes their default to if=none, so that usage wouldn't actually break.
What would break is -device with -drive if=T, where T is not none and
not picked up by the board.  Such usage is certainly questionable[*],
but it's questionable enough for us to break it?

>                          and then drop PC if=scsi support altogether?

Different backward compatibility question: here we break usage of
if=scsi with PC machine types.  Legacy way to do things, but it's
documented in qemu.1.  Are we happy to break it?


[*] Here's my review of a prior attempt to outlaw it:
http://lists.gnu.org/archive/html/qemu-devel/2015-06/msg03334.html
