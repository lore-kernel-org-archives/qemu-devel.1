Received: from eggs.gnu.org ([2001:4830:134:3::10]:51149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1flW7U-0000By-Hf
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1flW7P-0004Yp-FM
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:11:36 -0400
Received: from smtp.h3c.com ([60.191.123.56]:13070 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1flW7O-0004QH-Jv
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:11:31 -0400
From: Changlimin <changlimin@h3c.com>
Date: Fri, 3 Aug 2018 09:11:16 +0000
Message-ID: <BC29A004BA570342A4CC0044A384557201784EDE3E@H3CMLB14-EX.srv.huawei-3com.com>
References: <BC29A004BA570342A4CC0044A384557201784EDDA1@H3CMLB14-EX.srv.huawei-3com.com>
	<BC29A004BA570342A4CC0044A384557201784EDDD6@H3CMLB14-EX.srv.huawei-3com.com>
In-Reply-To: <BC29A004BA570342A4CC0044A384557201784EDDD6@H3CMLB14-EX.srv.huawei-3com.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] qemu 2.12.0 crash during install windows 10 with vga.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

Hi,
I have the same issue as https://www.qubes-os.org/doc/windows-vm/ , it's no=
t easy to reproduce.
cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <=3D snap=
->end' failed

Qemu version is 2.12.0.=20
(gdb) bt
#0  0x00007f504ed6fc37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007f504ed73028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007f504ed68bf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007f504ed68ca2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.=
so.6
#4  0x00005585bbdc9641 in cpu_physical_memory_snapshot_get_dirty (snap=3Dsn=
ap@entry=3D0x5585bfdc2ff0, start=3D<optimized out>, length=3D<optimized out=
>)
    at /qemu-2.12/exec.c:1264
#5  0x00005585bbe2b4de in memory_region_snapshot_get_dirty (mr=3Dmr@entry=
=3D0x5585c06e3d10, snap=3Dsnap@entry=3D0x5585bfdc2ff0, addr=3D<optimized ou=
t>,
    size=3D<optimized out>) at /qemu-2.12/memory.c:1997
#6  0x00005585bbe552a4 in vga_draw_graphic (full_update=3D0, s=3D0x5585c06e=
3d00) at /qemu-2.12/hw/display/vga.c:1671
#7  vga_update_display (opaque=3D0x5585c06e3d00) at /qemu-2.12/hw/display/v=
ga.c:1767
#8  0x00005585bc0d9a8f in qemu_spice_display_refresh (ssd=3D0x5585c06e3930)=
 at /qemu-2.12/ui/spice-display.c:478
#9  0x00005585bc0ced72 in dpy_refresh (s=3D0x5585c081b2a0) at /qemu-2.12/ui=
/console.c:1629
#10 gui_update (opaque=3D0x5585c081b2a0) at /qemu-2.12/ui/console.c:203
#11 0x00005585bc1d333c in timerlist_run_timers (timer_list=3D0x5585bee1f950=
) at /qemu-2.12/util/qemu-timer.c:536
#12 0x00005585bc1d35a3 in qemu_clock_run_timers (type=3DQEMU_CLOCK_REALTIME=
) at /qemu-2.12/util/qemu-timer.c:547
#13 qemu_clock_run_all_timers () at /qemu-2.12/util/qemu-timer.c:674
#14 0x00005585bc1d3aa4 in main_loop_wait (nonblocking=3D<optimized out>) at=
 /qemu-2.12/util/main-loop.c:528
#15 0x00005585bbdc2f8a in main_loop () at /qemu-2.12/vl.c:1973
#16 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimized=
 out>) at /qemu-2.12/vl.c:4804=20

(gdb) frame 5
(gdb) p/x *snap
$1 =3D {start =3D 0x1000c0000, end =3D 0x1000c0000, dirty =3D 0x5585bfdc300=
0}

Here the snap->start is identical to snap->end , I think something is wrong=
.=20
In function vga_draw_graphic, the snap is allocated from region_start/regio=
n_end.
        snap =3D memory_region_snapshot_and_clear_dirty(&s->vram, region_st=
art,
                                                      region_end - region_s=
tart,
                                                      DIRTY_MEMORY_VGA);

Is that possible for region_start=3D=3D region_end ?=20

BR,
Chang Limin
