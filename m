Received: from eggs.gnu.org ([209.51.188.92]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h3R1c-0005Yz-0z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h3R1a-0002ZX-DZ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:55:51 -0400
Received: from [2001:41c9:1:41f::167] (port=33052
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1h3R1Z-0002Lh-4w
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:55:49 -0400
References: <20190311085024.13780-1-kraxel@redhat.com>
	<20190311085024.13780-5-kraxel@redhat.com>
	<87ef7d8fh8.fsf@dusky.pond.sub.org>
	<alpine.BSF.2.21.9999.1903112044360.69539@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <476d5325-7097-7a27-392b-65a0119b24ea@ilande.co.uk>
Date: Mon, 11 Mar 2019 19:55:45 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903112044360.69539@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 4/5] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 11/03/2019 19:51, BALATON Zoltan wrote:

> On Mon, 11 Mar 2019, Markus Armbruster wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>>> guests running on these and the PMON2000 firmware of the fulong2e
>>> expect this to be available. Fortunately these are very similar chips
>>> so they can be mostly emulated in the same device model. This patch
>>> adds basic emulation of these ATI VGA chips.
>>>
>>> While this is incomplete and currently only enough to run the MIPS
>>> firmware and get framebuffer output with Linux, it allows the fulong2e
>>> board to work more like the real hardware and having it in QEMU in
>>> this state provides a way to experiment with it and allows others to
>>> contribute to improve it. It is compiled for all archs but only the
>>> fulong2e (which currently has no display output at all) is set to use
>>> it by default (in a separate patch).
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>>> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>>> Message-id:
>>> 0b1b7c22873a6e37627261b04fb687412b25ff4f.1552152100.git.balaton@eik.bme.hu
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> [...]
>>> diff --git a/hw/display/trace-events b/hw/display/trace-events
>>> index 37d3264bb2e6..80993cc4d913 100644
>>> --- a/hw/display/trace-events
>>> +++ b/hw/display/trace-events
>>> @@ -138,3 +138,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset
>>> 0x%x, val 0x%x"
>>>  sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>>>  sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>>>  sii9022_switch_mode(const char *mode) "mode: %s"
>>> +
>>> +# hw/display/ati*.c
>>> +ati_mm_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u
>>> 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
>>> +ati_mm_write(unsigned int size, uint64_t addr, const char *name, uint64_t val)
>>> "%u 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64
>>
>> Blows up for me:
>>
>> Traceback (most recent call last):
>>  File "/work/armbru/qemu/scripts/tracetool.py", line 152, in <module>
>>    main(sys.argv)
>>  File "/work/armbru/qemu/scripts/tracetool.py", line 147, in main
>>    binary=binary, probe_prefix=probe_prefix)
>>  File "/work/armbru/qemu/scripts/tracetool/__init__.py", line 472, in generate
>>    tracetool.format.generate(events, format, backend, group)
>>  File "/work/armbru/qemu/scripts/tracetool/format/__init__.py", line 85, in generate
>>    func(events, backend, group)
>>  File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", line 121, in generate
>>    fmt_str = "%d@%d " + e.name + " " + c_fmt_to_stap(e.fmt) + "\\n"
>>  File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", line 64, in
>> c_fmt_to_stap
>>    bits.append(c_macro_to_format(macro))
>>  File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", line 36, in
>> c_macro_to_format
>>    raise Exception("Unhandled macro '%s'" % macro)
>> Exception: Unhandled macro 'HWADDR_PRIx'
> 
> No idea. Nobody else reported a problem with this yet and the above error makes no
> sense to me. Cc'd some tracetool related people who hopefully can hint what might be
> wrong. Do you get error during build? What trace backend do you use?

You can't use HWADDR_PRIx in trace-events because other non-qemu-based trace backends
have no awareness of it (as I also found out). For HWADDR_PRIx you need to use PRIx64
instead. I have a vague recollection of someone posting a patch for checkpatch to
detect this - does it pass a local checkpatch run?


ATB,

Mark.
