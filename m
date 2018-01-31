Received: from eggs.gnu.org ([2001:4830:134:3::10]:52522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eh0Aj-0003JT-Ec
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 16:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eh0Ae-0000R4-IP
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 16:44:01 -0500
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:38957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eh0Ae-0000Qn-Cr
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 16:43:56 -0500
Received: by mail-it0-x235.google.com with SMTP id 68so1338437ite.4
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 13:43:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180131092213.srlhijglevhha6jw@sirius.home.kraxel.org>
Date: Wed, 31 Jan 2018 16:43:53 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCDC8A8F-F8CE-4F71-A11C-CF7078FB6BAF@gmail.com>
References: <20180130051837.8725-1-programmingkidx@gmail.com>
	<20180130094140.67xjf26jcymuz2bb@sirius.home.kraxel.org>
	<167881EE-F694-46C3-A15B-94B1733D2E40@gmail.com>
	<20180131092213.srlhijglevhha6jw@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/sb16.c: Convert file to new
 logging API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


> On Jan 31, 2018, at 4:22 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Tue, Jan 30, 2018 at 10:30:46AM -0500, Programmingkid wrote:
>>=20
>>> On Jan 30, 2018, at 4:41 AM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>>>=20
>>>> @@ -148,15 +142,16 @@ static int irq_of_magic (int magic)
>>>> #if 0
>>>> static void log_dsp (SB16State *dsp)
>>>> {
>>>> -    ldebug =
("%s:%s:%d:%s:dmasize=3D%d:freq=3D%d:const=3D%d:speaker=3D%d\n",
>>>> -            dsp->fmt_stereo ? "Stereo" : "Mono",
>>>> -            dsp->fmt_signed ? "Signed" : "Unsigned",
>>>> -            dsp->fmt_bits,
>>>> -            dsp->dma_auto ? "Auto" : "Single",
>>>> -            dsp->block_size,
>>>> -            dsp->freq,
>>>> -            dsp->time_const,
>>>> -            dsp->speaker);
>>>> +    qemu_log_mask(LOG_UNIMP, =
"%s:%s:%d:%s:dmasize=3D%d:freq=3D%d:const=3D%d:"
>>>> +                  "speaker=3D%d\n",
>>>> +                  dsp->fmt_stereo ? "Stereo" : "Mono",
>>>> +                  dsp->fmt_signed ? "Signed" : "Unsigned",
>>>> +                  dsp->fmt_bits,
>>>> +                  dsp->dma_auto ? "Auto" : "Single",
>>>> +                  dsp->block_size,
>>>> +                  dsp->freq,
>>>> +                  dsp->time_const,
>>>> +                  dsp->speaker);
>>>> }
>>>> #endif
>>>=20
>>> Hmm, dead code.  Any places which call log_dsp() ?
>>=20
>> There are several places but they are all dead code. Do you want this =
removed?
>=20
> So it is still used but not compiled in by default.
>=20
> Looking at all of this again, I think "qemu_log_mask(LOG_UNIMP, ...)"
> should only be used in case there *really* is some soundblaster =
feature
> unimplemented.  Otherwise converting to a tracepoint is probably more
> useful, so the debug messages can be enabled/disabled individually at
> runtime.
>=20
> The "#if 0" seems to be there to limit the flood of debug messages.  =
So
> once they all are converted to trace points this is not needed any =
more
> and I think we should just enable all this code.
>=20
> dolog() seems to be mostly cases where the code warns about
> unimplemented featues or incomplete emulation, so using LOG_UNIMP =
looks
> sensible.

Simply replacing dolog() with "qemu_log_mask(LOG_UNIMP," seems like what =
was desired.

> ldebug() should probably trace points.

I need help with this. I tried replacing ldebug() with =
"qemu_log_mask(LOG_TRACE,", but that caused a lot of messages to be =
printed to the terminal. It is odd because I thought I had to use "-d =
trace" to make it print. Do you have another suggestion on what to =
replace ldebug() with?=20

> Probably makes sense to split this patch up into a small series.

The first patch will be the replacing dolog() with =
qemu_log_mask(LOG_UNIMP. The second patch will be replacing ldebug() =
with what you suggest.=
