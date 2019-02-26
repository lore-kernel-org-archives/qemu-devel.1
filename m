Received: from eggs.gnu.org ([209.51.188.92]:58050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gyXEu-00078p-R8
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gyXEq-00085d-Op
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:33:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gyXEn-0007rQ-87
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:33:15 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 26 Feb 2019 15:31:59 +0800
Message-Id: <20190226073159.13434-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, mst@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
to define the attribute.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 039e0f91dba8..a1293cbd7adb 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
+static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
+			       char *buf)
 {
 	return sprintf(buf, "%u\n", fw_cfg_rev);
 }
-
-static const struct {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
-} fw_cfg_rev_attr = {
-	.attr = { .name = "rev", .mode = S_IRUSR },
-	.show = fw_cfg_showrev,
-};
+static const struct kobj_attribute fw_cfg_rev_attr =
+	__ATTR_RO_MODE(fw_cfg_rev, 0400);
 
 /* fw_cfg_sysfs_entry type */
 struct fw_cfg_sysfs_entry {
-- 
2.19.1
