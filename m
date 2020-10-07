Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F148C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE39520782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fvm0LZqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39520782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ88E-0006ij-Kz
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84H-0001T2-2n
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84D-0001gy-V3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602071829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wE4xYngsHjpqAQke6cOySjcfqIG9xco+FEa43LMMRDo=;
 b=Fvm0LZqpzKOLySbMrYkW24fa42PNhvigYx75XY1yFNI0k55fGLNp67Bzj8N3WWVKhvBx/N
 QO9McLVYa6O4ZeLRJ3PCEdXnoFD4s1HlyiQn2afCfCrE0YD1AWOE5vVIMtI+ktweqh31p7
 eCcRNw40hRomlhUmlSV3RpgB64/kFac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-8QZhCiaZPkmckPLRtzj5mA-1; Wed, 07 Oct 2020 07:57:07 -0400
X-MC-Unique: 8QZhCiaZPkmckPLRtzj5mA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76C0A425E0;
 Wed,  7 Oct 2020 11:57:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 186F755760;
 Wed,  7 Oct 2020 11:57:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/17] device-plug-test: use qtest_qmp to send the
 device_del command
Date: Wed,  7 Oct 2020 07:56:47 -0400
Message-Id: <20201007115700.707938-5-pbonzini@redhat.com>
In-Reply-To: <20201007115700.707938-1-pbonzini@redhat.com>
References: <20201007115700.707938-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the code now that events are buffered.  There is no need
anymore to separate sending the command and retrieving the response.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/device-plug-test.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index a2247856be..559d47727a 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -15,26 +15,17 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 
-static void device_del_start(QTestState *qtest, const char *id)
+static void device_del(QTestState *qtest, const char *id)
 {
-    qtest_qmp_send(qtest,
-                   "{'execute': 'device_del', 'arguments': { 'id': %s } }", id);
-}
+    QDict *resp;
 
-static void device_del_finish(QTestState *qtest)
-{
-    QDict *resp = qtest_qmp_receive_dict(qtest);
+    resp = qtest_qmp(qtest,
+                     "{'execute': 'device_del', 'arguments': { 'id': %s } }", id);
 
     g_assert(qdict_haskey(resp, "return"));
     qobject_unref(resp);
 }
 
-static void device_del_request(QTestState *qtest, const char *id)
-{
-    device_del_start(qtest, id);
-    device_del_finish(qtest);
-}
-
 static void system_reset(QTestState *qtest)
 {
     QDict *resp;
@@ -79,7 +70,7 @@ static void test_pci_unplug_request(void)
      * be processed. However during system reset, the removal will be
      * handled, removing the device.
      */
-    device_del_request(qtest, "dev0");
+    device_del(qtest, "dev0");
     system_reset(qtest);
     wait_device_deleted_event(qtest, "dev0");
 
@@ -90,13 +81,8 @@ static void test_ccw_unplug(void)
 {
     QTestState *qtest = qtest_initf("-device virtio-balloon-ccw,id=dev0");
 
-    /*
-     * The DEVICE_DELETED events will be sent before the command
-     * completes.
-     */
-    device_del_start(qtest, "dev0");
+    device_del(qtest, "dev0");
     wait_device_deleted_event(qtest, "dev0");
-    device_del_finish(qtest);
 
     qtest_quit(qtest);
 }
@@ -109,7 +95,7 @@ static void test_spapr_cpu_unplug_request(void)
                         "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
 
     /* similar to test_pci_unplug_request */
-    device_del_request(qtest, "dev0");
+    device_del(qtest, "dev0");
     system_reset(qtest);
     wait_device_deleted_event(qtest, "dev0");
 
@@ -125,7 +111,7 @@ static void test_spapr_memory_unplug_request(void)
                         "-device pc-dimm,id=dev0,memdev=mem0");
 
     /* similar to test_pci_unplug_request */
-    device_del_request(qtest, "dev0");
+    device_del(qtest, "dev0");
     system_reset(qtest);
     wait_device_deleted_event(qtest, "dev0");
 
@@ -139,7 +125,7 @@ static void test_spapr_phb_unplug_request(void)
     qtest = qtest_initf("-device spapr-pci-host-bridge,index=1,id=dev0");
 
     /* similar to test_pci_unplug_request */
-    device_del_request(qtest, "dev0");
+    device_del(qtest, "dev0");
     system_reset(qtest);
     wait_device_deleted_event(qtest, "dev0");
 
-- 
2.26.2



