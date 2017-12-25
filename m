Received: from eggs.gnu.org ([2001:4830:134:3::10]:47053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eTIW8-0001Ml-QB
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eTIW5-0007Q9-NS
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:29:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2056 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eTIW5-0007Lc-B7
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:29:25 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 25 Dec 2017 10:28:35 +0800
Message-ID: <20171225022835.23236-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vga: check the validation of memory addr when
 draw text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, fabrice@bellard.org, linzhecheng <linzhecheng@huawei.com>

Start a vm with qemu-kvm -enable-kvm -vnc :66 -smp 1 -m 1024 -hda redhat_5.11.qcow2  -device pcnet -vga cirrus,
then use VNC client to connect to VM, and excute the code below in guest OS will lead to qemu crash:

int main()
 {
    iopl(3);
    srand(time(NULL));
    int a,b;
    while(1){
	a = rand()%0x100;
	b = 0x3c0 + (rand()%0x20);
        outb(a,b);
    }
    return 0;
}

The backtrace is:
#0  0x000055defdf28dd1 in vga_draw_text (s=0x55deffe19a80, full_update=1)
    at /mnt/sdb/lzc/code/open/qemu/hw/display/vga.c:1283
#1  0x000055defdf2a371 in vga_update_display (opaque=0x55deffe19a80)
    at /mnt/sdb/lzc/code/open/qemu/hw/display/vga.c:1766
#2  0x000055defe28098e in graphic_hw_update (con=0x55deffeeb770) at ui/console.c:263
#3  0x000055defe29360f in vnc_refresh (dcl=0x55deffc54860) at ui/vnc.c:2855
#4  0x000055defe2842fe in dpy_refresh (s=0x55deffeeb700) at ui/console.c:1595
#5  0x000055defe2806ca in gui_update (opaque=0x55deffeeb700) at ui/console.c:201
#6  0x000055defe3ca875 in timerlist_run_timers (timer_list=0x55deff420100) at util/qemu-timer.c:536
#7  0x000055defe3ca8bd in qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME) at util/qemu-timer.c:547
#8  0x000055defe3cac83 in qemu_clock_run_all_timers () at util/qemu-timer.c:662
#9  0x000055defe3cb430 in main_loop_wait (nonblocking=0) at util/main-loop.c:521
#10 0x000055defe029838 in main_loop () at vl.c:1951
#11 0x000055defe031720 in main (argc=16, argv=0x7ffe5fb600e8, envp=0x7ffe5fb60170) at vl.c:4867

The above code is writing the registers of VGA randomly.
We can write VGA CRT controller registers index 0x0C or 0x0D 
(which is the start address register) to modify the 
the display memory address of the upper left pixel 
or character of the screen. The address may be out of the 
range of vga ram. So we should check the validation of memory address 
when reading or writing it to avoid segfault.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Change-Id: Ib7466361b18e0a232fc068aad50d2113701786ab

diff --git a/hw/display/vga.c b/hw/display/vga.c
index a0412000a5..c265572bf3 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1279,6 +1279,10 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         cx_min = width;
         cx_max = -1;
         for(cx = 0; cx < width; cx++) {
+            if (src + sizeof(uint16_t) > s->vram_ptr + s->vram_size) {
+                printf("src is out of the range of vga ram.\n");
+                return;
+             }
             ch_attr = *(uint16_t *)src;
             if (full_update || ch_attr != *ch_attr_ptr || src == cursor_ptr) {
                 if (cx < cx_min)
-- 
2.12.2.windows.2
