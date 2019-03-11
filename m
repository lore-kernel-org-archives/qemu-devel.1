Received: from eggs.gnu.org ([209.51.188.92]:55774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3SFz-0004Ym-Uq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3SFy-00076j-Cw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:14:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3SFy-00075V-2e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:14:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311085024.13780-1-kraxel@redhat.com>
	<20190311085024.13780-5-kraxel@redhat.com>
	<87ef7d8fh8.fsf@dusky.pond.sub.org>
	<alpine.BSF.2.21.9999.1903112044360.69539@zero.eik.bme.hu>
	<476d5325-7097-7a27-392b-65a0119b24ea@ilande.co.uk>
Date: Mon, 11 Mar 2019 22:14:32 +0100
In-Reply-To: <476d5325-7097-7a27-392b-65a0119b24ea@ilande.co.uk> (Mark
	Cave-Ayland's message of "Mon, 11 Mar 2019 19:55:45 +0000")
Message-ID: <87y35l6rlz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/5] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 11/03/2019 19:51, BALATON Zoltan wrote:
>
>> On Mon, 11 Mar 2019, Markus Armbruster wrote:
>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>>
>>>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>>>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>>>> guests running on these and the PMON2000 firmware of the fulong2e
>>>> expect this to be available. Fortunately these are very similar chips
>>>> so they can be mostly emulated in the same device model. This patch
>>>> adds basic emulation of these ATI VGA chips.
>>>>
>>>> While this is incomplete and currently only enough to run the MIPS
>>>> firmware and get framebuffer output with Linux, it allows the fulong2e
>>>> board to work more like the real hardware and having it in QEMU in
>>>> this state provides a way to experiment with it and allows others to
>>>> contribute to improve it. It is compiled for all archs but only the
>>>> fulong2e (which currently has no display output at all) is set to use
>>>> it by default (in a separate patch).
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>>>> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>>>> Message-id:
>>>> 0b1b7c22873a6e37627261b04fb687412b25ff4f.1552152100.git.balaton@eik.bm=
e.hu
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> [...]
>>>> diff --git a/hw/display/trace-events b/hw/display/trace-events
>>>> index 37d3264bb2e6..80993cc4d913 100644
>>>> --- a/hw/display/trace-events
>>>> +++ b/hw/display/trace-events
>>>> @@ -138,3 +138,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t val=
) "offset
>>>> 0x%x, val 0x%x"
>>>> =C2=A0sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x=
%02x"
>>>> =C2=A0sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0=
x%02x"
>>>> =C2=A0sii9022_switch_mode(const char *mode) "mode: %s"
>>>> +
>>>> +# hw/display/ati*.c
>>>> +ati_mm_read(unsigned int size, uint64_t addr, const char *name, uint6=
4_t val) "%u
>>>> 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
>>>> +ati_mm_write(unsigned int size, uint64_t addr, const char *name, uint=
64_t val)
>>>> "%u 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64
>>>
>>> Blows up for me:
>>>
>>> Traceback (most recent call last):
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool.py", line 152, in <modu=
le>
>>> =C2=A0=C2=A0 main(sys.argv)
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool.py", line 147, in main
>>> =C2=A0=C2=A0 binary=3Dbinary, probe_prefix=3Dprobe_prefix)
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool/__init__.py", line 472,=
 in generate
>>> =C2=A0=C2=A0 tracetool.format.generate(events, format, backend, group)
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool/format/__init__.py", li=
ne 85, in generate
>>> =C2=A0=C2=A0 func(events, backend, group)
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", li=
ne 121, in generate
>>> =C2=A0=C2=A0 fmt_str =3D "%d@%d " + e.name + " " + c_fmt_to_stap(e.fmt)=
 + "\\n"
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", li=
ne 64, in
>>> c_fmt_to_stap
>>> =C2=A0=C2=A0 bits.append(c_macro_to_format(macro))
>>> =C2=A0File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", li=
ne 36, in
>>> c_macro_to_format
>>> =C2=A0=C2=A0 raise Exception("Unhandled macro '%s'" % macro)
>>> Exception: Unhandled macro 'HWADDR_PRIx'
>>=20
>> No idea. Nobody else reported a problem with this yet and the above erro=
r makes no
>> sense to me. Cc'd some tracetool related people who hopefully can hint w=
hat might be
>> wrong. Do you get error during build? What trace backend do you use?

I enable all trace backends for my integration testing.  The error is
thrown for the dtrace backend.

> You can't use HWADDR_PRIx in trace-events because other non-qemu-based tr=
ace backends
> have no awareness of it (as I also found out). For HWADDR_PRIx you need t=
o use PRIx64
> instead. I have a vague recollection of someone posting a patch for check=
patch to
> detect this - does it pass a local checkpatch run?

Only unrelated warnings:

$ scripts/checkpatch.pl 0001-hw-display-Add-basic-ATI-VGA-emulation.patch=20
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#69:=20
new file mode 100644

WARNING: line over 80 characters
#176: FILE: hw/display/ati.c:103:
+                    vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_O=
FFSET);

total: 0 errors, 2 warnings, 1876 lines checked
