Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B6C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18074206B2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW9ior+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18074206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7Qu-0006fy-00
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OY-0004se-7E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OW-0000jY-8k
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbxehOKSDhrGNK6geBTGIUYU7aRINTLfEwPMIA62UFY=;
 b=RW9ior+eaG8eol/uKG6H97t5Fd6aD3zKPAG8Gpmkpmp2kM4sHuDRVLp54eUZw1lqIKsgQJ
 XCyWvCmyeULgzwYqgzYde1ebYiJDK07JG3mWwVMia/ZQ7a7OQPlLi51sFfFmFAKS4VoTsA
 +kVEGSBLcrl/8qITOcgXaSMPHAoXg2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-1GkD06vrPIOYJajHZIefSA-1; Mon, 09 Nov 2020 08:39:38 -0500
X-MC-Unique: 1GkD06vrPIOYJajHZIefSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086E9800683
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:39:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7E876EF40;
 Mon,  9 Nov 2020 13:39:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] qemu-option: clean up id vs. list->merge_lists
Date: Mon,  9 Nov 2020 08:39:29 -0500
Message-Id: <20201109133931.979563-5-pbonzini@redhat.com>
In-Reply-To: <20201109133931.979563-1-pbonzini@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Forbid ids if the option is intended to be a singleton, as indicated by
list->merge_lists.  This avoids that "./qemu-system-x86_64 -M q35,id=ff"
uses a "pc" machine type.  Instead it errors out.  The affected options
are "qemu-img reopen -o", "qemu-io open -o", -rtc, -M, -boot, -name,
-m, -icount, -smp, -spice.

qemu_opts_create's fail_if_exists parameter is now unnecessary:

- it is unused if id is NULL

- opts_parse only passes false if reached from qemu_opts_set_defaults,
in which case this patch enforces that id must be NULL

- other callers that can pass a non-NULL id always set it to true

Assert that it is true in the only case where "fail_if_exists" matters,
i.e. "id && !lists->merge_lists".  This means that if an id is present,
duplicates are always forbidden, which was already the status quo.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-option.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index c88e159f18..91f4120ce1 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -619,7 +619,17 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
 {
     QemuOpts *opts = NULL;
 
-    if (id) {
+    if (list->merge_lists) {
+        if (id) {
+            error_setg(errp, QERR_INVALID_PARAMETER, "id");
+            return NULL;
+        }
+        opts = qemu_opts_find(list, NULL);
+        if (opts) {
+            return opts;
+        }
+    } else if (id) {
+        assert(fail_if_exists);
         if (!id_wellformed(id)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id",
                        "an identifier");
@@ -629,17 +639,8 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
         }
         opts = qemu_opts_find(list, id);
         if (opts != NULL) {
-            if (fail_if_exists && !list->merge_lists) {
-                error_setg(errp, "Duplicate ID '%s' for %s", id, list->name);
-                return NULL;
-            } else {
-                return opts;
-            }
-        }
-    } else if (list->merge_lists) {
-        opts = qemu_opts_find(list, NULL);
-        if (opts) {
-            return opts;
+            error_setg(errp, "Duplicate ID '%s' for %s", id, list->name);
+            return NULL;
         }
     }
     opts = g_malloc0(sizeof(*opts));
@@ -893,7 +894,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
      * (if unlikely) future misuse:
      */
     assert(!defaults || list->merge_lists);
-    opts = qemu_opts_create(list, id, !defaults, errp);
+    opts = qemu_opts_create(list, id, !list->merge_lists, errp);
     g_free(id);
     if (opts == NULL) {
         return NULL;
-- 
2.26.2



