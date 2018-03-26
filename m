Received: from eggs.gnu.org ([2001:4830:134:3::10]:34571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9N-0003KC-Pq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9I-0000K1-U4
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:09 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:44639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9I-0000Jh-PG
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:04 -0400
Received: by mail-qk0-x242.google.com with SMTP id o5so2139170qki.11
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 08:35:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Mar 2018 12:34:39 -0300
Message-Id: <20180326153441.32641-4-f4bug@amsat.org>
In-Reply-To: <20180326153441.32641-1-f4bug@amsat.org>
References: <20180326153441.32641-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.13 3/5] hw/dma/i8257: Split
 i8257_dma_init() by master/slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Nageswara Sastry <nasastry@in.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>

This emphasises than two controller are created (in master/slave configuration).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/i8257.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index df030f934c..72f8893b9e 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -622,26 +622,44 @@ static void i8257_register_types(void)
 
 type_init(i8257_register_types)
 
-void i8257_dma_init(ISABus *bus, bool high_page_enable)
+static ISADevice *i8257_dma_init_master(ISABus *bus, bool high_page_enable)
 {
-    ISADevice *isa1, *isa2;
+    ISADevice *isa;
     DeviceState *d;
 
-    isa1 = isa_create(bus, TYPE_I8257);
-    d = DEVICE(isa1);
+    isa = isa_create(bus, TYPE_I8257);
+    d = DEVICE(isa);
     qdev_prop_set_int32(d, "base", 0x00);
     qdev_prop_set_int32(d, "page-base", 0x80);
     qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x480 : -1);
     qdev_prop_set_int32(d, "dshift", 0);
     qdev_init_nofail(d);
 
-    isa2 = isa_create(bus, TYPE_I8257);
-    d = DEVICE(isa2);
+    return isa;
+}
+
+static ISADevice *i8257_dma_init_slave(ISABus *bus, bool high_page_enable)
+{
+    ISADevice *isa;
+    DeviceState *d;
+
+    isa = isa_create(bus, TYPE_I8257);
+    d = DEVICE(isa);
     qdev_prop_set_int32(d, "base", 0xc0);
     qdev_prop_set_int32(d, "page-base", 0x88);
     qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x488 : -1);
     qdev_prop_set_int32(d, "dshift", 1);
     qdev_init_nofail(d);
 
-    isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
+    return isa;
+}
+
+void i8257_dma_init(ISABus *bus, bool high_page_enable)
+{
+    ISADevice *master, *slave;
+
+    master = i8257_dma_init_master(bus, high_page_enable);
+    slave = i8257_dma_init_slave(bus, high_page_enable);
+
+    isa_bus_dma(bus, ISADMA(master), ISADMA(slave));
 }
-- 
2.16.3
