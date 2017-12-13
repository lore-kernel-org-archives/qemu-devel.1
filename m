Received: from eggs.gnu.org ([2001:4830:134:3::10]:39406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtu-0004BL-2a
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDts-0006XF-QR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:10 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDts-0006Wo-Lm
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:08 -0500
Received: by mail-qt0-x243.google.com with SMTP id g9so5391267qth.9
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:45:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:30 -0300
Message-Id: <20171213204436.5379-6-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/11] sdbus: add sdbus_create_slave()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

The slave qdev is created connected to the parent SDBus.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h |  2 ++
 hw/sd/core.c       | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index dc9d697c12..d402231724 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -52,6 +52,8 @@ struct SDBus {
 
 /* Functions to be used by qdevified callers */
 SDBus *sdbus_create_bus(DeviceState *parent, const char *name);
+DeviceState *sdbus_create_slave(SDBus *bus, const char *name);
+DeviceState *sdbus_create_slave_no_init(SDBus *bus, const char *name);
 int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
 void sdbus_write_data(SDBus *sd, uint8_t value);
 uint8_t sdbus_read_data(SDBus *sd);
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 021a8d7258..fc9ccfedb2 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -188,6 +188,20 @@ static void sd_bus_register_types(void)
 
 type_init(sd_bus_register_types)
 
+DeviceState *sdbus_create_slave_no_init(SDBus *bus, const char *name)
+{
+    assert(bus);
+    return qdev_create(BUS(bus), name);
+}
+
+DeviceState *sdbus_create_slave(SDBus *bus, const char *name)
+{
+    DeviceState *dev = sdbus_create_slave_no_init(bus, name);
+
+    qdev_init_nofail(dev);
+    return dev;
+}
+
 SDBus *sdbus_create_bus(DeviceState *parent, const char *name)
 {
     return SD_BUS(qbus_create(TYPE_SD_BUS, parent, name));
-- 
2.15.1
