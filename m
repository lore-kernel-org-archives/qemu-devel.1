Received: from eggs.gnu.org ([2001:4830:134:3::10]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORjH-00081P-Fh
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORjG-0002Uq-OG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:46:43 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORjG-0002Uk-K3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:46:42 -0400
Received: by mail-qt0-x242.google.com with SMTP id v31so2026302qtb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:46:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 23 Jun 2017 13:45:57 -0300
Message-Id: <20170623164557.11636-4-f4bug@amsat.org>
In-Reply-To: <20170623164557.11636-1-f4bug@amsat.org>
References: <20170623164557.11636-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] hw/core: report an error if invalid gpio
 is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

then abort calling error_setg()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 849952a8d4..05aaa67cb8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -448,7 +448,11 @@ qemu_irq qdev_get_gpio_in_named(DeviceState *dev, const char *name, int n)
 {
     NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
 
-    assert(n >= 0 && n < gpio_list->num_in);
+    assert(n >= 0);
+    if (n >= gpio_list->num_in) {
+        error_setg(&error_abort, "Invalid gpio #%d (of %d) for %s",
+                   n, gpio_list->num_in, name ? name : "device");
+    }
     return gpio_list->in[n];
 }
 
-- 
2.13.1
