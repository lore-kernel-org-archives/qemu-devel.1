Received: from eggs.gnu.org ([209.51.188.92]:40644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0Rjs-0008OV-NL
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0Rjq-0001bb-Ox
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:05:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:50150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h0Rjq-0001Vg-F5
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:05:10 -0500
Date: Sun, 3 Mar 2019 15:04:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <2586687c-9f69-1c26-6f7f-841c5300ee0e@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1903031436530.20570@zero.eik.bme.hu>
References: <20190303000025.3496D7456A0@zero.eik.bme.hu>
	<0ba3b4c7-c0bc-f8d8-66d5-1f3b15eed6ce@redhat.com>
	<alpine.BSF.2.21.9999.1903031316220.1059@zero.eik.bme.hu>
	<2586687c-9f69-1c26-6f7f-841c5300ee0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Sun, 3 Mar 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/3/19 1:46 PM, BALATON Zoltan wrote:
>> On Sun, 3 Mar 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> +??? case RBBM_STATUS:
>>>
>>> ????????? /* fall through */
>>>
>>>> +??? case GUI_STAT:
>>>> +??????? val =3D 64; /* free CMDFIFO entries */
>>>> +??????? break;
>>
>> Obviously fall through because there are no statements between case
>> labels. I only use /* fall thorugh */ comment where there are some
>> statements and a missing break but not in this case which should be
>> clear without comment.
>
> Apparently not enough obvious to me since I stopped here, since I don't
> know the difference/relation between RBBM_STATUS/GUI_STAT registers.

I did not mean obvious from the registers but obvious from having no=20
statements between case labels. Multiple case labels for common cases in=20
switch without fall through comment between them is used in several other=
=20
places in QEMU as well. The fall through comment is only needed when ther=
e=20
are some statements but no break at the end and code falls through to the=
=20
next case. Then the comment tells that break was not forgotten but fall=20
through is intended but no such comment is needed when multiple cases go=20
to same place like here. It may look odd in a big switch where every othe=
r=20
case has statements only these two are common ones but it's correct and=20
consistent with other places and should be clear without comment what is=20
meant. (I could add a comment here anyway to make it look more regular bu=
t=20
I prefer code that's less verbose vertically so more lines fit on the=20
screen.)

>>>> +??? if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RADEON_QY &&
>>>> +??????? s->vga.vram_size_mb < 16) {
>>>> +??????? warn_report("Too small video memory for device id");
>>>> +??????? s->vga.vram_size_mb =3D 16;
>>>
>>> I'd rather use error_setg() and return.
>>
>> Correcting the error if possible is friendlier IMO but this can be
>> debated what's the preferred behaviour. I'll leave it as it is for now=
.
>
> Well we are somehow lying to the user... modifying his hardware without
> his consent.

We do warn them though so not silently changing hardware. There are=20
arguments for both ways, I can't decide and this can be changed anytime=20
later so I go with what I like unless more votes for another way.

>> I could do any of the above but all this file is temporary for
>> development and meant to be removed once enough functions of the devic=
e
>> are implemented so for now I don't bother unless there's a strong
>> argument other than style preference to change it.
>
> I'd definitively keep it, and I now believe you should drop the
> DEBUG_ATI around. It is only used by tracing right? And tracing is
> already optimized. If it becomes someday unuseful to you, it can still
> be useful for the next one wanting to improve/fix your device.

We've discussed before why trace points are not convenient for debugging=20
during development so for these I keep DPRINTF and only convert to traces=
=20
parts that are mostly finished. This way it's also clear which messages=20
are to be removed later and which are meant to be kept for tracing. If we=
=20
choose to keep register names also after development for more detailed=20
traces then this could be cleaned up but this probably would just add=20
unused code for most of the time. So after development is finished I don'=
t=20
think it's useful to include reg names.

>>>> diff --git a/hw/display/trace-events b/hw/display/trace-events
>>>> index 37d3264bb2..6aed33eeaa 100644
>>>> --- a/hw/display/trace-events
>>>> +++ b/hw/display/trace-events
>>>> @@ -138,3 +138,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t
>>>> val) "offset 0x%x, val 0x%x"
>>>> ?sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02=
x"
>>>> ?sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%0=
2x"
>>>> ?sii9022_switch_mode(const char *mode) "mode: %s"
>>>> +
>>>> +# hw/display/ati*.c
>>>> +ati_mm_read(unsigned int size, uint64_t addr, const char *name,
>>>> uint64_t val) "%d 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
>>>> +ati_mm_write(unsigned int size, uint64_t addr, const char *name,
>>>> uint64_t val) "%d 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64
>>>
>>> "%u ...
>>
>> Should not matter as size that can only be 1 to 4 but %u is more corre=
ct
>> to print unsigned variable so I'll change this.
>
> The argument is unsigned, so the correct format is %u.
>
> This help reducing the thousands of warnings in QEMU about incorrect
> formatstring.

Yes, I've corrected this. I did not get warnings for it but maybe some=20
compilers are pickier about this.

Regards,
BALATON Zoltan
