Received: from eggs.gnu.org ([2001:4830:134:3::10]:38163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cnmvw-0004rS-Qe
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cnmvs-0000qd-OM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:56:16 -0400
Date: Tue, 14 Mar 2017 14:56:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
Message-ID: <alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net

On Tue, 14 Mar 2017, Mark Cave-Ayland wrote:
> On 14/03/17 10:00, Alex Benn=C3=A9e wrote:
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>
>>> I've recently noticed some video artifacts appearing in the form of
>>> horizontal lines whilst testing OpenBIOS boot on some qemu-system-ppc
>>> images (see https://www.ilande.co.uk/tmp/qemu/macos9-stripe.png for a=
n
>>> example) which I've finally bisected down to this commit.
>>
>> Interesting. Is the video hardware in this case a simple framebuffer o=
r
>> is there some sort of GPU involved?
>
> For the mac99 machine it's just the normal QEMU PCI std-vga card, so
> nothing special. Having run tests across SPARC which uses its own
> framebuffer, there have been no obvious artifacts that I've spotted
> there to date.
>
>>> The horizontal lines tend to appear at different positions with
>>> different lengths, although it seems to be more common that a complet=
e
>>> scanline is affected. Reproducing the issue is fairly easy with a Mac=
OS
>>> 9.2.1 ISO and the command line below:
>>>
>>> ./qemu-system-ppc -cdrom MacOS921.iso -boot d -m 512 -M mac99
>>>
>>> Could it be that this patch is still missing a lock somewhere which
>>> causes these artifacts to appear?
>>
>> It depends. If the hardware is accessed via MMIO then the BQL is taken
>> automatically (unless the area is explicitly marked as doing its own
>> locking see: mr->global_locking).
>>
>> Is the artefact temporary or permanent? Could it be a change in
>> synchronisation between the emulator updating the framebuffer and
>> whatever backend updating its display?
>
> AFAICT they are temporary in that they appear randomly on the display,
> but the next time that particular area of the display is updated by the
> guest then they tend to either change/disappear.

I've also noticed artifacts when testing the SM501 changes with MorphOS o=
n=20
recent QEMU so it may not be related to just the std vga. It's shown as=20
bands (larger number of adjacent scanlines) not updating when the client=20
first wrote to the framebuffer but then they disappeared during the next=20
refresh. I'm guessing it may be related to dirty checking of the=20
framebuffer memory which is used to decide when a scan line needs update?

Regards,
BALATON Zoltan
