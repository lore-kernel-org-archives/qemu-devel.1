Received: from eggs.gnu.org ([209.51.188.92]:51877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyI-0004YW-4E
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyH-0004MI-HB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyH-0004Ld-Ak
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:53 -0500
Received: by mail-wm1-x344.google.com with SMTP id d15so11710495wmb.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:01 +0100
Message-Id: <1548093980-43088-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/49] hw/i386/pc: use PVH option rom
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
index 9ed5063..2833b13 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1252,6 +1252,10 @@ static void load_linux(PCMachineState *pcms,
                                  initrd_size);
             }
 
+            option_rom[nb_option_roms].bootindex = 0;
+            option_rom[nb_option_roms].name = "pvh.bin";
+            nb_option_roms++;
+
             return;
         }
         /* This looks like a multiboot kernel. If it is, let's stop
@@ -1703,6 +1707,7 @@ void xen_load_linux(PCMachineState *pcms)
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
+               !strcmp(option_rom[i].name, "pvh.bin") ||
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-- 
1.8.3.1
