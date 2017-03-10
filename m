Received: from eggs.gnu.org ([2001:4830:134:3::10]:46350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cmQni-00088O-Na
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cmQng-0002Qp-G3
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 15:06:10 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 10 Mar 2017 22:05:49 +0200
Message-Id: <20170310200550.13313-2-krzk@kernel.org>
In-Reply-To: <20170310200550.13313-1-krzk@kernel.org>
References: <20170310200550.13313-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 1/2] qdev: Constify value passed to
 qdev_prop_set_macaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Krzysztof Kozlowski <krzk@kernel.org>

The 'value' argument is not modified so this can be made const for code
safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/core/qdev-properties.c    | 3 ++-
 include/hw/qdev-properties.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ab4265eb478..fa3617db2df1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1010,7 +1010,8 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
     object_property_set_str(OBJECT(dev), value, name, &error_abort);
 }
 
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value)
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value)
 {
     char str[2 * 6 + 5 + 1];
     snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7ac315331aa0..1d69fa7a8f04 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -188,7 +188,8 @@ void qdev_prop_set_chr(DeviceState *dev, const char *name, Chardev *value);
 void qdev_prop_set_netdev(DeviceState *dev, const char *name, NetClientState *value);
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp);
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value);
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* FIXME: Remove opaque pointer properties.  */
 void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
-- 
2.9.3
