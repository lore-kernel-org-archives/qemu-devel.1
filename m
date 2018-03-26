Received: from eggs.gnu.org ([2001:4830:134:3::10]:34573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9O-0003KW-2K
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9N-0000M0-85
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Mar 2018 12:34:40 -0300
Message-Id: <20180326153441.32641-5-f4bug@amsat.org>
In-Reply-To: <20180326153441.32641-1-f4bug@amsat.org>
References: <20180326153441.32641-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.13 /5] hw/dma/i8257: Rename
 i8257_dma_init() -> i8257_dma_init_cascaded()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Nageswara Sastry <nasastry@in.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>

To keep the patch diff simple, an inline function is used (then removed
in the next commit).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/dma/i8257.h | 6 +++++-
 hw/dma/i82374.c        | 2 +-
 hw/dma/i8257.c         | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 3053f18797..986319e4e3 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -46,6 +46,10 @@ typedef struct I8257State {
     PortioList portio_pageh;
 } I8257State;
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable);
+void i8257_dma_init_cascaded(ISABus *bus, bool high_page_enable);
+static inline void i8257_dma_init(ISABus *bus, bool high_page_enable)
+{
+    i8257_dma_init_cascaded(bus, high_page_enable);
+}
 
 #endif
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 892f655a7e..b95edd7b98 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -125,7 +125,7 @@ static void i82374_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "DMA already initialized on ISA bus");
         return;
     }
-    i8257_dma_init(isa_bus, true);
+    i8257_dma_init_cascaded(isa_bus, true);
 
     portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
                      "i82374");
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 72f8893b9e..c930c4c531 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -654,7 +654,7 @@ static ISADevice *i8257_dma_init_slave(ISABus *bus, bool high_page_enable)
     return isa;
 }
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable)
+void i8257_dma_init_cascaded(ISABus *bus, bool high_page_enable)
 {
     ISADevice *master, *slave;
 
-- 
2.16.3
