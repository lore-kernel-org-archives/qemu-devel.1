Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW0e9-0004jz-51
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cW0e8-0007bR-1P
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:56:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
Date: Tue, 24 Jan 2017 13:56:14 +0100
In-Reply-To: <3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com> (Paolo
	Bonzini's message of "Tue, 24 Jan 2017 12:17:40 +0100")
Message-ID: <87r33saa6p.fsf@dusky.pond.sub.org>
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

Cc'ing in sPAPR maintainers...

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/01/2017 20:16, Markus Armbruster wrote:
>>>                                                      Could we change
>>> those messages to errors
>> 
>> Fine with me, but when it comes to arguing for backward compatibility of
>> our byzantine command line, I'm kind of like a lethargic public defender
>> with an overly deep relationship to Bourbon.  "Your honor, sure capital
>> punishment is called for?  Yes?  Okay then."
>> 
>> I vaguely recall discussing the topic with Peter (cc'ed).  If memory
>> serves, one concern was breaking usage of -device with -drive lacking
>> if=...  Works fine (no warning) with machines that don't pick up drives
>> with their default block interface type, i.e. most of them.  But PATCH 3
>> changes their default to if=none, so that usage wouldn't actually break.
>
> I think that tips the scale in favor of having errors.

I can add a patch to make it an error when I respin.

>> What would break is -device with -drive if=T, where T is not none and
>> not picked up by the board.  Such usage is certainly questionable[*],
>> but it's questionable enough for us to break it?
>> 
>>>                          and then drop PC if=scsi support altogether?
>> 
>> Different backward compatibility question: here we break usage of
>> if=scsi with PC machine types.  Legacy way to do things, but it's
>> documented in qemu.1.  Are we happy to break it?
>
> That usage is wrong after this patch, since it mentions
> qemu-system-i386.

You're right, I better fix that.

>                    So it's documented, but almost useless and the
> example is not exactly correct.  Let's deprecate it in 2.9 and remove in
> 2.10.

Let me spell things out a bit more, to make sure we all agree on what
exactly we want to deprecate.

After this series, -drive if=scsi works for the following machine types:

* magnum pica61 LX SPARCClassic SPARCbook SS-10 SS-20 SS-4 SS-5 SS-600MP
  Voyager

  The machine has an onboard SCSI HBA, which adopts the drives with
  bus=0..  Drives with non-zero bus numbers stay orphaned.  This is
  exactly how other interface types work.

  Except when additional HBAs get cold-plugged somehow, non-zero bus
  numbers can work; see below.

* realview-eb realview-eb-mpcore versatileab versatilepb

  These create N lsi53c895a SCSI HBAs, where N is the largest value of
  bus.  If N is too large, machine initialization fails with a "no
  slot/function available for lsi53c895a, all in use" error.

  This is just like the PC machine types work before this patch.

* pseries-*

  Likewise, except create spapr-vscsi SCSI HBAs.  Large N make machine
  initialization s-l-o-w.  I tried to find out whether and how it fails
  when N is too large, but I lost patience.

Additionally, -drive if=scsi works when you cold-plug certain SCSI HBAs,
independent of machine type.  The HBAs get assigned bus numbers in order
of creation, and adopt the drives with their bus number.  Drives with
bus numbers not so assigned stay orphaned.

* SCSI HBAs supporting if=scsi: am53c974 dc390 esp lsi53c810 lsi53c895a
  megasas megasas-gen2 mptsas1068 spapr-vscsi virtio-scsi-device

* Not supporting it: pvscsi usb-storage usb-bot usb-uas

So, what do we want to deprecate?

I think the onboard SCSI HBA adopting if=scsi drives should stay,
because it matches what we do for other interface types.  Unless we
wanted to deprecate interface types other than none entirely.

What about realview and versatile auto-creating lsi53c895a?

What about pseries auto-creating spapr-vscsi?

What about cold-plug of HBAs auto-creating SCSI devices?  You proposed
deprecating it for PC types, but it's currently independent of the
machine type.  Deprecate it for all types?  If not, add a flag to
MachineClass so we can deprecate it just for PC types?
