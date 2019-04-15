Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA98C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEDD206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEDD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFwZg-0001WI-Mp
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 04:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXs-0000cC-SL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXr-0001S7-Nl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:40824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hFwXp-0001NR-1Y; Mon, 15 Apr 2019 04:00:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Apr 2019 01:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,352,1549958400"; d="scan'208";a="140739282"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2019 01:00:46 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-trivial@nongnu.org
Date: Mon, 15 Apr 2019 15:59:45 +0800
Message-Id: <1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor qdev_get_machine()
 with type assertion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, like.xu@intel.com,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415075945.pTB4Q0FV1WDTgSGpBNCM-CEvJClnj7iUDVS_DzB0dFY@z>

To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
mode) and adds type assertion to qdev_get_machine() in system-emulation mode.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/core/qdev.c         | 16 +++++++++++++---
 include/hw/qdev-core.h |  1 +
 qom/cpu.c              |  5 +++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9b6efe..8232216 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -223,7 +223,7 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
     MachineState *machine;
     MachineClass *mc;
-    Object *m_obj = qdev_get_machine();
+    Object *m_obj = qdev_get_machine_uncheck();
 
     if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
         machine = MACHINE(m_obj);
@@ -815,7 +815,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (!obj->parent) {
             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
 
-            object_property_add_child(container_get(qdev_get_machine(),
+            object_property_add_child(container_get(qdev_get_machine_uncheck(),
                                                     "/unattached"),
                                       name, obj, &error_abort);
             unattached_parent = true;
@@ -1095,7 +1095,7 @@ void device_reset(DeviceState *dev)
     }
 }
 
-Object *qdev_get_machine(void)
+Object *qdev_get_machine_uncheck(void)
 {
     static Object *dev;
 
@@ -1106,6 +1106,16 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *qdev_get_machine(void)
+{
+    static Object *dev;
+
+    dev = qdev_get_machine_uncheck();
+    assert(object_dynamic_cast(dev, TYPE_MACHINE) != NULL);
+
+    return dev;
+}
+
 static const TypeInfo device_type_info = {
     .name = TYPE_DEVICE,
     .parent = TYPE_OBJECT,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33ed3b8..e7c6a5a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -429,6 +429,7 @@ const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
 
 const char *qdev_fw_name(DeviceState *dev);
 
+Object *qdev_get_machine_uncheck(void);
 Object *qdev_get_machine(void);
 
 /* FIXME: make this a link<> */
diff --git a/qom/cpu.c b/qom/cpu.c
index a8d2958..bb877d5 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -325,9 +325,10 @@ static void cpu_common_parse_features(const char *typename, char *features,
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
-    Object *machine = qdev_get_machine();
+    Object *machine = qdev_get_machine_uncheck();
 
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
+    /*
+     * qdev_get_machine_uncheck() can return something that's not TYPE_MACHINE
      * if this is one of the user-only emulators; in that case there's
      * no need to check the ignore_memory_transaction_failures board flag.
      */
-- 
1.8.3.1


