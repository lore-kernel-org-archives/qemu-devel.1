Received: from eggs.gnu.org ([2001:4830:134:3::10]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQg-0000bb-ER
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQd-0006WV-JD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:42 -0300
Message-Id: <20171006235023.11952-48-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 47/88] hw/i2c: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i2c/bitbang_i2c.c | 2 +-
 hw/i2c/core.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 8be88ee265..20a9deef1a 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -186,7 +186,7 @@ bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus)
 {
     bitbang_i2c_interface *s;
 
-    s = g_malloc0(sizeof(bitbang_i2c_interface));
+    s = g_new0(bitbang_i2c_interface, 1);
 
     s->bus = bus;
     s->last_data = 1;
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 59068f157e..be84d6735f 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -132,7 +132,7 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
             DeviceState *qdev = kid->child;
             I2CSlave *candidate = I2C_SLAVE(qdev);
             if ((candidate->address == address) || (bus->broadcast)) {
-                node = g_malloc(sizeof(struct I2CNode));
+                node = g_new(struct I2CNode, 1);
                 node->elt = candidate;
                 QLIST_INSERT_HEAD(&bus->current_devs, node, next);
                 if (!bus->broadcast) {
@@ -258,7 +258,7 @@ static int i2c_slave_post_load(void *opaque, int version_id)
     bus = I2C_BUS(qdev_get_parent_bus(DEVICE(dev)));
     if ((bus->saved_address == dev->address) ||
         (bus->saved_address == I2C_BROADCAST)) {
-        node = g_malloc(sizeof(struct I2CNode));
+        node = g_new(struct I2CNode, 1);
         node->elt = dev;
         QLIST_INSERT_HEAD(&bus->current_devs, node, next);
     }
-- 
2.14.2
