Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D64C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8A7206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8A7206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJkaA-0006yr-Pj
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 16:02:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYT-0005l5-K7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0007My-Et
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0006XE-5A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18E898123D;
	Thu, 25 Apr 2019 20:01:02 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85709600C0;
	Thu, 25 Apr 2019 20:01:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 17:00:51 -0300
Message-Id: <20190425200051.19906-5-ehabkost@redhat.com>
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
References: <20190425200051.19906-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 25 Apr 2019 20:01:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] qdev-hotplug: Don't check type of
 qdev_get_machine()
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
	Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425200051.mNVEqT__qiCN1s8YOlfpzmLiE0XtLFXGRAwRN98sTs8@z>

Now that qdev_get_machine_hotplug_handler() is only compiled in
softmmu mode, we don't need to check if qdev_gt_machine() is
really of type TYPE_MACHINE.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-hotplug.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 8ab31043a7..017500c1e1 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -35,16 +35,11 @@ void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
 
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
-    MachineState *machine;
-    MachineClass *mc;
-    Object *m_obj = qdev_get_machine();
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
-        machine = MACHINE(m_obj);
-        mc = MACHINE_GET_CLASS(machine);
-        if (mc->get_hotplug_handler) {
-            return mc->get_hotplug_handler(machine, dev);
-        }
+    if (mc->get_hotplug_handler) {
+        return mc->get_hotplug_handler(machine, dev);
     }
 
     return NULL;
-- 
2.18.0.rc1.1.g3f1ff2140


