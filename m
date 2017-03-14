Received: from eggs.gnu.org ([2001:4830:134:3::10]:48307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnkO8-0006w1-Tc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cnkO7-0006LS-NV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:13:12 -0400
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
Date: Tue, 14 Mar 2017 11:12:42 +0000
MIME-Version: 1.0
In-Reply-To: <87wpbsp49a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu-system-ppc video artifacts since "tcg: drop
 global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: jan.kiszka@siemens.com, fred.konrad@greensocs.com, cota@braap.org, rth@twiddle.net, bobby.prani@gmail.com, qemu-devel <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 14/03/17 10:00, Alex Bennée wrote:

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> I've recently noticed some video artifacts appearing in the form of
>> horizontal lines whilst testing OpenBIOS boot on some qemu-system-ppc
>> images (see https://www.ilande.co.uk/tmp/qemu/macos9-stripe.png for an
>> example) which I've finally bisected down to this commit.
> 
> Interesting. Is the video hardware in this case a simple framebuffer or
> is there some sort of GPU involved?

For the mac99 machine it's just the normal QEMU PCI std-vga card, so
nothing special. Having run tests across SPARC which uses its own
framebuffer, there have been no obvious artifacts that I've spotted
there to date.

>> The horizontal lines tend to appear at different positions with
>> different lengths, although it seems to be more common that a complete
>> scanline is affected. Reproducing the issue is fairly easy with a MacOS
>> 9.2.1 ISO and the command line below:
>>
>> ./qemu-system-ppc -cdrom MacOS921.iso -boot d -m 512 -M mac99
>>
>> Could it be that this patch is still missing a lock somewhere which
>> causes these artifacts to appear?
> 
> It depends. If the hardware is accessed via MMIO then the BQL is taken
> automatically (unless the area is explicitly marked as doing its own
> locking see: mr->global_locking).
> 
> Is the artefact temporary or permanent? Could it be a change in
> synchronisation between the emulator updating the framebuffer and
> whatever backend updating its display?

AFAICT they are temporary in that they appear randomly on the display,
but the next time that particular area of the display is updated by the
guest then they tend to either change/disappear.

MacOS 9 is interesting in that it's effectively an emulator within an
emulator, i.e. 68K code running on a PPC emulator and so does tend to
stress QEMU in interesting places. Given that I've also seen the
occasional issue with Darwin/OS X it seems the problem isn't just
constrained to OS 9, however it seems to occur a lot more often there.


ATB,

Mark.
