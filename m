Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWKRC-0004KP-B4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWKRB-0006gj-5r
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:41:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fWKRB-0006c8-04
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:41:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA0794023132
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 11:41:02 +0000 (UTC)
References: <20180306113442.15295-1-kraxel@redhat.com>
	<20180306113442.15295-6-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <af5669bc-f491-5d58-8da5-4de1cc028ffa@redhat.com>
Date: Fri, 22 Jun 2018 13:40:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180306113442.15295-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Memory corruption with secondary-vga (was: [PATCH v8
 5/9] secondary-vga: properly close QemuConsole on unplug)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

On 06.03.2018 12:34, Gerd Hoffmann wrote:
> Using the new graphic_console_close() function.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga-pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index 1674bd3581..f312930664 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -292,6 +292,14 @@ static void pci_secondary_vga_realize(PCIDevice *d=
ev, Error **errp)
>      pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mm=
io);
>  }
> =20
> +static void pci_secondary_vga_exit(PCIDevice *dev)
> +{
> +    PCIVGAState *d =3D PCI_VGA(dev);
> +    VGACommonState *s =3D &d->vga;
> +
> +    graphic_console_close(s->con);
> +}
> +
>  static void pci_secondary_vga_init(Object *obj)
>  {
>      /* Expose framebuffer byteorder via QOM */
> @@ -361,6 +369,7 @@ static void secondary_class_init(ObjectClass *klass=
, void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> =20
>      k->realize =3D pci_secondary_vga_realize;
> +    k->exit =3D pci_secondary_vga_exit;

 Hi Gerd,

not sure what is exactly happening here, but this patch introduced
a memory corruption problem. I can trigger it like this:

$ valgrind mips-softmmu/qemu-system-mips -accel qtest -monitor stdio
=3D=3D12739=3D=3D Memcheck, a memory error detector
=3D=3D12739=3D=3D Copyright (C) 2002-2017, and GNU GPL'd, by Julian Sewar=
d et al.
=3D=3D12739=3D=3D Using Valgrind-3.13.0 and LibVEX; rerun with -h for cop=
yright info
=3D=3D12739=3D=3D Command: mips-softmmu/qemu-system-mips -accel qtest -mo=
nitor stdio
=3D=3D12739=3D=3D=20
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) device_add secondary-vga
Unsupported bus. Bus doesn't have property 'acpi-pcihp-bsel' set
(qemu) dump-guest-memory /dev/null 0 4096
=3D=3D12739=3D=3D Invalid read of size 8
=3D=3D12739=3D=3D    at 0x6AFCD5: object_dynamic_cast (object.c:613)
=3D=3D12739=3D=3D    by 0x6AFCD5: object_resolve_abs_path (object.c:1721)
=3D=3D12739=3D=3D    by 0x6AFD30: object_resolve_partial_path (object.c:1=
745)
=3D=3D12739=3D=3D    by 0x6AFD92: object_resolve_partial_path (object.c:1=
755)
=3D=3D12739=3D=3D    by 0x6AFD92: object_resolve_partial_path (object.c:1=
755)
=3D=3D12739=3D=3D    by 0x6AFD92: object_resolve_partial_path (object.c:1=
755)
=3D=3D12739=3D=3D    by 0x6AFE61: object_resolve_path_type (object.c:1784=
)
=3D=3D12739=3D=3D    by 0x42992F: vmcoreinfo_find (vmcoreinfo.h:41)
=3D=3D12739=3D=3D    by 0x42992F: dump_init (dump.c:1643)
=3D=3D12739=3D=3D    by 0x42992F: qmp_dump_guest_memory (dump.c:1998)
=3D=3D12739=3D=3D    by 0x50B6EC: hmp_dump_guest_memory (hmp.c:2051)
=3D=3D12739=3D=3D    by 0x4153AA: handle_hmp_command (monitor.c:3455)
=3D=3D12739=3D=3D    by 0x4166BB: monitor_command_cb (monitor.c:4347)
=3D=3D12739=3D=3D    by 0x7A35C7: readline_handle_byte (readline.c:393)
=3D=3D12739=3D=3D    by 0x4154E6: monitor_read (monitor.c:4330)
=3D=3D12739=3D=3D  Address 0x231faf40 is 16 bytes inside a block of size =
256 free'd
=3D=3D12739=3D=3D    at 0x4C2ACBD: free (vg_replace_malloc.c:530)
=3D=3D12739=3D=3D    by 0x89F26B6: pixman_image_unref (in /usr/lib64/libp=
ixman-1.so.0.34.0)
=3D=3D12739=3D=3D    by 0x689154: qemu_pixman_glyph_render (qemu-pixman.c=
:266)
=3D=3D12739=3D=3D    by 0x683FFE: vga_putcharxy.isra.7 (console.c:469)
=3D=3D12739=3D=3D    by 0x68551C: console_refresh (console.c:601)
=3D=3D12739=3D=3D    by 0x684841: text_console_update_cursor (console.c:2=
160)
=3D=3D12739=3D=3D    by 0x78F8C0: timerlist_run_timers (qemu-timer.c:536)
=3D=3D12739=3D=3D    by 0x78FBA5: qemu_clock_run_timers (qemu-timer.c:547=
)
=3D=3D12739=3D=3D    by 0x78FBA5: qemu_clock_run_all_timers (qemu-timer.c=
:674)
=3D=3D12739=3D=3D    by 0x790099: main_loop_wait (main-loop.c:503)
=3D=3D12739=3D=3D    by 0x4F2BF1: main_loop (vl.c:1848)
=3D=3D12739=3D=3D    by 0x3C6C69: main (vl.c:4600)
=3D=3D12739=3D=3D  Block was alloc'd at
=3D=3D12739=3D=3D    at 0x4C29BC3: malloc (vg_replace_malloc.c:299)
=3D=3D12739=3D=3D    by 0x89F267A: ??? (in /usr/lib64/libpixman-1.so.0.34=
.0)
=3D=3D12739=3D=3D    by 0x89FF2FD: pixman_image_create_solid_fill (in /us=
r/lib64/libpixman-1.so.0.34.0)
=3D=3D12739=3D=3D    by 0x68909A: qemu_pixman_glyph_render (qemu-pixman.c=
:255)
=3D=3D12739=3D=3D    by 0x683FFE: vga_putcharxy.isra.7 (console.c:469)
=3D=3D12739=3D=3D    by 0x68551C: console_refresh (console.c:601)
=3D=3D12739=3D=3D    by 0x684841: text_console_update_cursor (console.c:2=
160)
=3D=3D12739=3D=3D    by 0x78F8C0: timerlist_run_timers (qemu-timer.c:536)
=3D=3D12739=3D=3D    by 0x78FBA5: qemu_clock_run_timers (qemu-timer.c:547=
)
=3D=3D12739=3D=3D    by 0x78FBA5: qemu_clock_run_all_timers (qemu-timer.c=
:674)
=3D=3D12739=3D=3D    by 0x790099: main_loop_wait (main-loop.c:503)
=3D=3D12739=3D=3D    by 0x4F2BF1: main_loop (vl.c:1848)
=3D=3D12739=3D=3D    by 0x3C6C69: main (vl.c:4600)
...

 Thomas
