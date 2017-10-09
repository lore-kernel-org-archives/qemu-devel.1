Received: from eggs.gnu.org ([2001:4830:134:3::10]:57362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d@vidbuchanan.co.uk>) id 1e1XoD-0008PZ-C4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d@vidbuchanan.co.uk>) id 1e1Xo7-00021x-KA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:09:25 -0400
Received: from mx.pawnmail.com ([107.191.103.103]:58944 helo=pawnmail.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d@vidbuchanan.co.uk>) id 1e1Xo7-00021K-Db
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:09:19 -0400
References: <20170828122906.18993-1-kraxel@redhat.com>
	<e64a628c-3377-f3f5-0646-079a2a175354@vidbuchanan.co.uk>
	<1507553788.32088.12.camel@redhat.com>
From: David Buchanan <d@vidbuchanan.co.uk>
Message-ID: <6ceac427-3cdb-56f3-1a53-0639562ddd10@vidbuchanan.co.uk>
Date: Mon, 9 Oct 2017 14:09:06 +0100
MIME-Version: 1.0
In-Reply-To: <1507553788.32088.12.camel@redhat.com>
Content-Type: multipart/mixed; boundary="------------92CA8C3B78800441FFBA5925"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] vga: stop passing pointers to
 vga_draw_line* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>

This is a multi-part message in MIME format.
--------------92CA8C3B78800441FFBA5925
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/10/17 13:56, Gerd Hoffmann wrote:
> How do you start
> qemu?  Which user interface?

Like this:
qemu-system-x86_64 -vga cirrus [disk image]

(which I assume is using the GTK interface)

I have attached the reproducer NASM source and disk image.
Note that the reproducer is using VBE.

> Have you seen a stacktrace with pixman in there?  Care to share it?

#0  0x00007fffe1c2bf61 in  () at /usr/lib/libpixman-1.so.0
#1  0x00007fffe1c385db in  () at /usr/lib/libpixman-1.so.0
#2  0x00007fffe1c38991 in  () at /usr/lib/libpixman-1.so.0
#3  0x00007fffe1c6eb7c in  () at /usr/lib/libpixman-1.so.0
#4  0x00007fffe1c2aca1 in pixman_image_composite32 () at
/usr/lib/libpixman-1.so.0
#5  0x0000555555be5630 in gd_switch (dcl=3D0x555557e088b0,
surface=3D0x555556d76ac0) at /tmp/qemu/ui/gtk.c:628
#6  0x0000555555bb216a in dpy_gfx_replace_surface (con=3D0x5555569718d0,
surface=3D0x555556d76ac0)
    at /tmp/qemu/ui/console.c:1552
#7  0x000055555580aab6 in vga_draw_graphic (s=3D0x5555576de2c0,
full_update=3D0x1) at /tmp/qemu/hw/display/vga.c:1561
#8  0x000055555580b388 in vga_update_display (opaque=3D0x5555576de2c0) at
/tmp/qemu/hw/display/vga.c:1756
#9  0x0000555555bae64d in graphic_hw_update (con=3D0x5555569718d0) at
/tmp/qemu/ui/console.c:263
#10 0x0000555555be50f8 in gd_refresh (dcl=3D0x555557e088b0) at
/tmp/qemu/ui/gtk.c:493
#11 0x0000555555bb22a8 in dpy_refresh (s=3D0x5555577b05c0) at
/tmp/qemu/ui/console.c:1589
#12 0x0000555555bae362 in gui_update (opaque=3D0x5555577b05c0) at
/tmp/qemu/ui/console.c:201
#13 0x0000555555d20445 in timerlist_run_timers
(timer_list=3D0x555556928210) at /tmp/qemu/util/qemu-timer.c:536
#14 0x0000555555d204a2 in qemu_clock_run_timers
(type=3DQEMU_CLOCK_REALTIME) at /tmp/qemu/util/qemu-timer.c:547
#15 0x0000555555d208fe in qemu_clock_run_all_timers () at
/tmp/qemu/util/qemu-timer.c:662
#16 0x0000555555d21125 in main_loop_wait (nonblocking=3D0x0) at
/tmp/qemu/util/main-loop.c:521
#17 0x0000555555926553 in main_loop () at /tmp/qemu/vl.c:1995
#18 0x000055555592e793 in main (argc=3D0x4, argv=3D0x7fffffffe218,
envp=3D0x7fffffffe240) at /tmp/qemu/vl.c:4902
#19 0x00007fffdc663f6a in __libc_start_main () at /usr/lib/libc.so.6
#20 0x000055555577394a in _start ()

Thanks.

--------------92CA8C3B78800441FFBA5925
Content-Type: text/x-asm;
 name="poc.asm"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="poc.asm"

	BITS	16

	ORG	0x7C00

	mov	ax, 0x4F02
	mov	bx, 0x4118 ; 1024x768x24, LFB enabled
	int	0x10 ; init VESA graphics via BIOS
=09
=09
	mov	dx, 0x3d4
	mov	al, 0x1d
	out	dx, al
=09
	mov	dx, 0x3d5
	in	al, dx
	or	al, 0x80
	out	dx, al

	jmp	$

	TIMES	510-($-$$) DB 0
	DW	0xAA55		; boot signature

--------------92CA8C3B78800441FFBA5925
Content-Type: application/x-raw-disk-image;
 name="poc.img"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="poc.img"

uAJPuxhBzRC61AOwHe661QPsDIDu6/4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVao=
--------------92CA8C3B78800441FFBA5925--
