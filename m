Received: from eggs.gnu.org ([209.51.188.92]:35955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GK-0002N0-Mz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GI-0003o4-6R
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GH-0003db-P0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:57 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t27so4710125wra.6
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:29 +0100
Message-Id: <1549390526-24246-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/76] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

Use pvh.bin option rom when we are booting an uncompressed
kernel using the x86/HVM direct boot ABI.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5d61557..9efbd16 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1261,6 +1261,10 @@ static void load_linux(PCMachineState *pcms,
                                  initrd_size);
             }
 
+            option_rom[nb_option_roms].bootindex = 0;
+            option_rom[nb_option_roms].name = "pvh.bin";
+            nb_option_roms++;
+
             return;
         }
         /* This looks like a multiboot kernel. If it is, let's stop
@@ -1712,6 +1716,7 @@ void xen_load_linux(PCMachineState *pcms)
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
+               !strcmp(option_rom[i].name, "pvh.bin") ||
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-- 
1.8.3.1
