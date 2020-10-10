Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5301EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA271207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q27/TSfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA271207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRA7s-0003VF-3i
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lQ-0004Pt-Hc
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lO-0006jB-GL
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QR+l/N8Obv+SdC/2ljxqyyDY0N4TRXJQixylW9KYaw=;
 b=Q27/TSfiTZzWSE7gvEQHi6xPdbJVXwZLndSTtQBDyzxS/1xOy61Y1wMi+r6Nn/kc7/4RU4
 nKM8i3jEqlJsfyoFl16r3IA1ZnXjY0ME00g951tj9pDOrEcJgChTbdnRwP6r8ls3B9t6V9
 UYIDKTRlkmPzHlUJIopgNAWYIiQ40UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-6XwVd9JnOBiGCnv4uY_0RQ-1; Sat, 10 Oct 2020 03:57:56 -0400
X-MC-Unique: 6XwVd9JnOBiGCnv4uY_0RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257D1107B470
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3B0F60C07;
 Sat, 10 Oct 2020 07:57:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/39] qtest: check that drives are really appearing and
 disappearing
Date: Sat, 10 Oct 2020 03:57:27 -0400
Message-Id: <20201010075739.951385-28-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not just trust the HMP commands to create and delete the drive, use
query-block to check that this is actually the case.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/drive_del-test.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 9d20a1ed8b..ff772b3671 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -14,20 +14,49 @@
 #include "libqos/libqtest.h"
 #include "libqos/virtio.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
+
+static bool has_drive(QTestState *qts)
+{
+    QDict *response;
+    QList *ret;
+    QListEntry *entry;
+    bool found;
+
+    response = qtest_qmp(qts, "{'execute': 'query-block'}");
+    g_assert(response && qdict_haskey(response, "return"));
+    ret = qdict_get_qlist(response, "return");
+
+    found = false;
+    QLIST_FOREACH_ENTRY(ret, entry) {
+        QDict *entry_dict = qobject_to(QDict, entry->value);
+        if (!strcmp(qdict_get_str(entry_dict, "device"), "drive0")) {
+            found = true;
+            break;
+        }
+    }
+
+    qobject_unref(response);
+    return found;
+}
 
 static void drive_add(QTestState *qts)
 {
     char *resp = qtest_hmp(qts, "drive_add 0 if=none,id=drive0");
 
     g_assert_cmpstr(resp, ==, "OK\r\n");
+    g_assert(has_drive(qts));
     g_free(resp);
 }
 
 static void drive_del(QTestState *qts)
 {
-    char *resp = qtest_hmp(qts, "drive_del drive0");
+    char *resp;
 
+    g_assert(has_drive(qts));
+    resp = qtest_hmp(qts, "drive_del drive0");
     g_assert_cmpstr(resp, ==, "");
+    g_assert(!has_drive(qts));
     g_free(resp);
 }
 
@@ -130,6 +159,7 @@ static void test_drive_del_device_del(void)
      */
     drive_del(qts);
     device_del(qts);
+    g_assert(!has_drive(qts));
 
     qtest_quit(qts);
 }
-- 
2.26.2



