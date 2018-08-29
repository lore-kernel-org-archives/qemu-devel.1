Received: from eggs.gnu.org ([2001:4830:134:3::10]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuy89-0007sM-Fr
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuy86-0007qF-AK
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:55:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fuy86-0007ph-2y
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:55:18 -0400
Date: Wed, 29 Aug 2018 11:55:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180829105510.GB2660@work-vm>
References: <BC29A004BA570342A4CC0044A384557201784EDDA1@H3CMLB14-EX.srv.huawei-3com.com>
	<BC29A004BA570342A4CC0044A384557201784EDDD6@H3CMLB14-EX.srv.huawei-3com.com>
	<BC29A004BA570342A4CC0044A384557201784EDE3E@H3CMLB14-EX.srv.huawei-3com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC29A004BA570342A4CC0044A384557201784EDE3E@H3CMLB14-EX.srv.huawei-3com.com>
Subject: Re: [Qemu-devel] qemu 2.12.0 crash during install windows 10 with
 vga.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlimin <changlimin@h3c.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

* Changlimin (changlimin@h3c.com) wrote:
> Hi,
> I have the same issue as https://www.qubes-os.org/doc/windows-vm/ , it's not easy to reproduce.
> cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <= snap->end' failed
> 
> Qemu version is 2.12.0. 
> (gdb) bt
> #0  0x00007f504ed6fc37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x00007f504ed73028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  0x00007f504ed68bf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #3  0x00007f504ed68ca2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
> #4  0x00005585bbdc9641 in cpu_physical_memory_snapshot_get_dirty (snap=snap@entry=0x5585bfdc2ff0, start=<optimized out>, length=<optimized out>)
>     at /qemu-2.12/exec.c:1264
> #5  0x00005585bbe2b4de in memory_region_snapshot_get_dirty (mr=mr@entry=0x5585c06e3d10, snap=snap@entry=0x5585bfdc2ff0, addr=<optimized out>,
>     size=<optimized out>) at /qemu-2.12/memory.c:1997
> #6  0x00005585bbe552a4 in vga_draw_graphic (full_update=0, s=0x5585c06e3d00) at /qemu-2.12/hw/display/vga.c:1671
> #7  vga_update_display (opaque=0x5585c06e3d00) at /qemu-2.12/hw/display/vga.c:1767
> #8  0x00005585bc0d9a8f in qemu_spice_display_refresh (ssd=0x5585c06e3930) at /qemu-2.12/ui/spice-display.c:478
> #9  0x00005585bc0ced72 in dpy_refresh (s=0x5585c081b2a0) at /qemu-2.12/ui/console.c:1629
> #10 gui_update (opaque=0x5585c081b2a0) at /qemu-2.12/ui/console.c:203
> #11 0x00005585bc1d333c in timerlist_run_timers (timer_list=0x5585bee1f950) at /qemu-2.12/util/qemu-timer.c:536
> #12 0x00005585bc1d35a3 in qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME) at /qemu-2.12/util/qemu-timer.c:547
> #13 qemu_clock_run_all_timers () at /qemu-2.12/util/qemu-timer.c:674
> #14 0x00005585bc1d3aa4 in main_loop_wait (nonblocking=<optimized out>) at /qemu-2.12/util/main-loop.c:528
> #15 0x00005585bbdc2f8a in main_loop () at /qemu-2.12/vl.c:1973
> #16 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /qemu-2.12/vl.c:4804 
> 
> (gdb) frame 5
> (gdb) p/x *snap
> $1 = {start = 0x1000c0000, end = 0x1000c0000, dirty = 0x5585bfdc3000}
> 
> Here the snap->start is identical to snap->end , I think something is wrong. 
> In function vga_draw_graphic, the snap is allocated from region_start/region_end.
>         snap = memory_region_snapshot_and_clear_dirty(&s->vram, region_start,
>                                                       region_end - region_start,
>                                                       DIRTY_MEMORY_VGA);
> 
> Is that possible for region_start== region_end ? 

Could this be the same bug as
https://bugs.launchpad.net/qemu/+bug/1784900/ ?

I'm not sure if the bug existed in 2.12.0 though.

Dave

> BR,
> Chang Limin
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
