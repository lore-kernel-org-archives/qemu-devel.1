Received: from eggs.gnu.org ([2001:4830:134:3::10]:34521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1co9jG-0003BT-Fi
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1co9jD-0006FR-9v
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:16:42 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1co9jD-0006F7-1h
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:16:39 -0400
Received: by mail-wr0-x232.google.com with SMTP id u108so11959873wrb.3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:16:38 -0700 (PDT)
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
Date: Wed, 15 Mar 2017 14:16:55 +0000
Message-ID: <87efxypqug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu-system-ppc video artifacts since
 "tcg: drop global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net, Gerd Hoffmann <kraxel@redhat.com>


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 14/03/17 15:41, Alex Bennée wrote:
>
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>>> On Tue, 14 Mar 2017, Mark Cave-Ayland wrote:
>>>> On 14/03/17 10:00, Alex Bennée wrote:
>>>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>>>
>>>>>> I've recently noticed some video artifacts appearing in the form of
>>>>>> horizontal lines whilst testing OpenBIOS boot on some qemu-system-ppc
>>>>>> images (see https://www.ilande.co.uk/tmp/qemu/macos9-stripe.png for an
>>>>>> example) which I've finally bisected down to this commit.
<snip>
>
> Could it be that these underlying assumptions have now changed?

So there is an assumption that has changed. It used to be the TCG code
and the gui_update code could not run at the same time as they both
needed to take the BQL.

When drop global lock patch went in this was reversed. The BQL is no
longer held while running the TCG until it needs it.

It certainly needs it when it is doing HW emulation and for MMIO mapped
registers this is what happens. Every time we write to a MMIO register
the SoftMMU helper routines follow the slow path, through the memory API
(which takes a lock) and into the hw emulation code. However for
framebuffers our behaviour is slightly different.

Instead of having MMIO register spaces we use the dirty tracking
mechanism. Here regions are marked as for dirty tracking and when the
SoftMMU helper first comes to this bit of memory it will follow the slow
path and mark region as visited. Once done this bit is cleared and all
future writes to that page are written directly from the translated
code. This no longer has an implicit synchronisation from the BQL so
there is now a race and you can have memory being updated which might
miss this flagging.

I've sort of confirmed that by hacking full_update = 1 in
vga_update_display and the artefacts go away.

Note that KVM has some similar hacks to avoid trapping all writes to
video memory with its coalesced mmio mechanism however I'm not familiar
with all the details.

Now there are mechanisms we can use to ensure there are no races happen
and return to the situation that the display is only updated when the
TCG cores are not running. We simply queue up update function to run as
async safe work which will guarantee the TCG vCPUs will not be running
while stuff is updated. I'm a little hesitant to do that globally as it
may well slow down KVM by introducing an unneeded pause.

This also involves making a tweak into the ui/console.c code
(gui_update) so I'm CC'ing Gerd who might have an insight on how to do
this neatly.

--
Alex Bennée
