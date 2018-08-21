Received: from eggs.gnu.org ([2001:4830:134:3::10]:60900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001Aw-Bi
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3o-0005gk-GM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3n-0005X4-EU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o37-v6so7596407wrf.6
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:40 +0200
Message-Id: <1534870966-9287-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/74] megasas: fix sglist leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

tests/cdrom-test -p /x86_64/cdrom/boot/megasas

Produces the following ASAN leak.

==25700==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f06f8faac48 in malloc (/lib64/libasan.so.5+0xeec48)
    #1 0x7f06f87a73c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
    #2 0x55a729f17738 in pci_dma_sglist_init /home/elmarco/src/qq/include/hw/pci/pci.h:818
    #3 0x55a729f2a706 in megasas_map_dcmd /home/elmarco/src/qq/hw/scsi/megasas.c:698
    #4 0x55a729f39421 in megasas_handle_dcmd /home/elmarco/src/qq/hw/scsi/megasas.c:1574
    #5 0x55a729f3f70d in megasas_handle_frame /home/elmarco/src/qq/hw/scsi/megasas.c:1955
    #6 0x55a729f40939 in megasas_mmio_write /home/elmarco/src/qq/hw/scsi/megasas.c:2119
    #7 0x55a729f41102 in megasas_port_write /home/elmarco/src/qq/hw/scsi/megasas.c:2170
    #8 0x55a729220e60 in memory_region_write_accessor /home/elmarco/src/qq/memory.c:527
    #9 0x55a7292212b3 in access_with_adjusted_size /home/elmarco/src/qq/memory.c:594
    #10 0x55a72922cf70 in memory_region_dispatch_write /home/elmarco/src/qq/memory.c:1473
    #11 0x55a7290f5907 in flatview_write_continue /home/elmarco/src/qq/exec.c:3255
    #12 0x55a7290f5ceb in flatview_write /home/elmarco/src/qq/exec.c:3294
    #13 0x55a7290f6457 in address_space_write /home/elmarco/src/qq/exec.c:3384
    #14 0x55a7290f64a8 in address_space_rw /home/elmarco/src/qq/exec.c:3395
    #15 0x55a72929ecb0 in kvm_handle_io /home/elmarco/src/qq/accel/kvm/kvm-all.c:1729
    #16 0x55a7292a0db5 in kvm_cpu_exec /home/elmarco/src/qq/accel/kvm/kvm-all.c:1969
    #17 0x55a7291c4212 in qemu_kvm_cpu_thread_fn /home/elmarco/src/qq/cpus.c:1215
    #18 0x55a72a966a6c in qemu_thread_start /home/elmarco/src/qq/util/qemu-thread-posix.c:504
    #19 0x7f06ed486593 in start_thread (/lib64/libpthread.so.0+0x7593)

Move the qemu_sglist_destroy() from megasas_complete_command() to
megasas_unmap_frame(), so map/unmap are balanced.

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180814141247.32336-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/scsi/megasas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index ba1afa3..a56317e 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -464,6 +464,7 @@ static void megasas_unmap_frame(MegasasState *s, MegasasCmd *cmd)
     cmd->frame = NULL;
     cmd->pa = 0;
     cmd->pa_size = 0;
+    qemu_sglist_destroy(&cmd->qsg);
     clear_bit(cmd->index, s->frame_map);
 }
 
@@ -580,7 +581,6 @@ static void megasas_complete_frame(MegasasState *s, uint64_t context)
 
 static void megasas_complete_command(MegasasCmd *cmd)
 {
-    qemu_sglist_destroy(&cmd->qsg);
     cmd->iov_size = 0;
     cmd->iov_offset = 0;
 
-- 
1.8.3.1
