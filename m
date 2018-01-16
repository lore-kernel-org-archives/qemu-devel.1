Received: from eggs.gnu.org ([2001:4830:134:3::10]:59249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6A-00039t-GY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR68-0006uZ-IV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:18 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR68-0006tj-EW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:16 -0500
Received: by mail-qt0-x244.google.com with SMTP id i1so1288787qtj.8
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:45 -0300
Message-Id: <20180116131555.14242-2-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] smbus: add a NULL check for
 SMBusDeviceClass::init callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

ensure SMBusDeviceClass::init is set before calling it

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/smbus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a689..a90d65ef37 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -207,7 +207,11 @@ static int smbus_device_init(I2CSlave *i2c)
     SMBusDevice *dev = SMBUS_DEVICE(i2c);
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
-    return sc->init(dev);
+    if (sc->init) {
+        return sc->init(dev);
+    }
+
+    return 0;
 }
 
 /* Master device commands.  */
-- 
2.15.1
