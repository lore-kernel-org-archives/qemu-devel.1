Received: from eggs.gnu.org ([2001:4830:134:3::10]:46481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eZcuB-0003D8-Jn
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eZcu8-0000ET-G0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:28:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2067 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eZcu7-0000AK-7a
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:28:24 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 11 Jan 2018 21:27:24 +0800
Message-ID: <20180111132724.13744-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] vga: check the validation of memory addr
 when draw text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ppandit@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, fabrice@bellard.org, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, linzhecheng <linzhecheng@huawei.com>

Start a vm with qemu-kvm -enable-kvm -vnc :66 -smp 1 -m 1024 -hda
redhat_5.11.qcow2  -device pcnet -vga cirrus,
then use VNC client to connect to VM, and excute the code below in guest
OS will lead to qemu crash:

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

The above code is writing the registers of VGA randomly.
We can write VGA CRT controller registers index 0x0C or 0x0D
(which is the start address register) to modify the
the display memory address of the upper left pixel
or character of the screen. The address may be out of the
range of vga ram. So we should check the validation of memory address
when reading or writing it to avoid segfault.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
---
 hw/display/vga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index a0412000a5..6e78a4e156 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1279,6 +1279,9 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         cx_min = width;
         cx_max = -1;
         for(cx = 0; cx < width; cx++) {
+            if (src + sizeof(uint16_t) > s->vram_ptr + s->vram_size) {
+                break;
+            }
             ch_attr = *(uint16_t *)src;
             if (full_update || ch_attr != *ch_attr_ptr || src == cursor_ptr) {
                 if (cx < cx_min)
-- 
2.12.2.windows.2
