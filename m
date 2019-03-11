Received: from eggs.gnu.org ([209.51.188.92]:45636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3PCX-0007Ey-3y
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3P7W-0001AG-Lm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3P7U-000182-Ni
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:53:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311085024.13780-1-kraxel@redhat.com>
	<20190311085024.13780-5-kraxel@redhat.com>
Date: Mon, 11 Mar 2019 18:53:39 +0100
In-Reply-To: <20190311085024.13780-5-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Mon, 11 Mar 2019 09:50:23 +0100")
Message-ID: <87ef7d8fh8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 4/5] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Gerd Hoffmann <kraxel@redhat.com> writes:

> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
> guests running on these and the PMON2000 firmware of the fulong2e
> expect this to be available. Fortunately these are very similar chips
> so they can be mostly emulated in the same device model. This patch
> adds basic emulation of these ATI VGA chips.
>
> While this is incomplete and currently only enough to run the MIPS
> firmware and get framebuffer output with Linux, it allows the fulong2e
> board to work more like the real hardware and having it in QEMU in
> this state provides a way to experiment with it and allows others to
> contribute to improve it. It is compiled for all archs but only the
> fulong2e (which currently has no display output at all) is set to use
> it by default (in a separate patch).
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Message-id: 0b1b7c22873a6e37627261b04fb687412b25ff4f.1552152100.git.balaton@eik.bme.hu
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
[...]
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 37d3264bb2e6..80993cc4d913 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -138,3 +138,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
>  sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>  sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>  sii9022_switch_mode(const char *mode) "mode: %s"
> +
> +# hw/display/ati*.c
> +ati_mm_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
> +ati_mm_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64

Blows up for me:

Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/tracetool.py", line 152, in <module>
    main(sys.argv)
  File "/work/armbru/qemu/scripts/tracetool.py", line 147, in main
    binary=binary, probe_prefix=probe_prefix)
  File "/work/armbru/qemu/scripts/tracetool/__init__.py", line 472, in generate
    tracetool.format.generate(events, format, backend, group)
  File "/work/armbru/qemu/scripts/tracetool/format/__init__.py", line 85, in generate
    func(events, backend, group)
  File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", line 121, in generate
    fmt_str = "%d@%d " + e.name + " " + c_fmt_to_stap(e.fmt) + "\\n"
  File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", line 64, in c_fmt_to_stap
    bits.append(c_macro_to_format(macro))
  File "/work/armbru/qemu/scripts/tracetool/format/log_stap.py", line 36, in c_macro_to_format
    raise Exception("Unhandled macro '%s'" % macro)
Exception: Unhandled macro 'HWADDR_PRIx'
