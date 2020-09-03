Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A5C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D182072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brND23z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D182072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrBL-0004Gj-Iz
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8Z-00006J-Pw
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:26:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8X-0000DD-Rw
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9eafikgUXeUM2nyemK+4rrXIL5OR+qKMW3xwigy0Do=;
 b=brND23z47sYRAVHqO/QqTegf4scpbizoAwiELPL6EX6qMeLl93Vpy10sDqad/L5P+TstF4
 rGjZh3HsxYb+nB2pe2/JngxXAvbNyXm9rZOO25HcgMhbNwv3cTa8ijWMHRx3+ud3tXCfWE
 fQZ1qRqqsTX0K8eYy1/7n/2LQLjaw/g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-R7K1qk2nPm25vKxMv7kwdw-1; Thu, 03 Sep 2020 11:26:51 -0400
X-MC-Unique: R7K1qk2nPm25vKxMv7kwdw-1
Received: by mail-qk1-f198.google.com with SMTP id 139so1769226qkl.11
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q9eafikgUXeUM2nyemK+4rrXIL5OR+qKMW3xwigy0Do=;
 b=cfyVjAKCcF4qjVuDMfM805Viz9GcMOXxPmxAyET5WLZVzfGqiBNY1bX0taTnmQTtYI
 Tib3pq2j/4401Zt+RFKCjmyku5fKfyp62Gmk5Iri4pA80Tqp0HuQGMzPheUA1q7FkAq5
 zPaLbTJ9rWdQ3a31yiiJMJ99VIpyj3n1JtaOiaXR81N9BEUg/GQxsebnuyKlnIb2GPyj
 WY01e3YV/mjmRGWHeeFg8RnObmn5kc9WMjBlmmlYScbn1CyfFL0yBQF5QBWDWgZEUijP
 52IZqBHU0fhEBRMv0j7ExjEwYl0sg3N7GZRbr8VIpMiXYLjy+zVyczuJL3bQe5UQzC/8
 DYGg==
X-Gm-Message-State: AOAM5320J/704eoq0WHyPOD1St7d9yV4AIPdmV4EIe2JGZALnmYEb2ox
 j09Q7hzvnhGBggqJwDkVO2pBuCuyPZ66f+nFFpjPdbTf15G9M+G/U3SmNB/B768rmbk4ARS3EP2
 1Wz14vqhHIdQgFE8=
X-Received: by 2002:ac8:474d:: with SMTP id k13mr4050440qtp.20.1599146810641; 
 Thu, 03 Sep 2020 08:26:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa02dLLYxCKWZewAX/vzPnpK9Hkt5gxeRJ1DAD5hd+LVSyV5gy6uyRg5nukDwORqq44rDZ8w==
X-Received: by 2002:ac8:474d:: with SMTP id k13mr4050409qtp.20.1599146810383; 
 Thu, 03 Sep 2020 08:26:50 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id l38sm2319889qtl.58.2020.09.03.08.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 08:26:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] migration: Rework migrate_send_rp_req_pages() function
Date: Thu,  3 Sep 2020 11:26:42 -0400
Message-Id: <20200903152646.93336-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903152646.93336-1-peterx@redhat.com>
References: <20200903152646.93336-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We duplicated the logic of maintaining the last_rb variable at both callers of
this function.  Pass *rb pointer into the function so that we can avoid
duplicating the logic.  Also, when we have the rb pointer, it's also easier to
remove the original 2nd & 4th parameters, because both of them (name of the
ramblock when needed, or the page size) can be fetched from the ramblock
pointer too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c    | 26 ++++++++++++++++++--------
 migration/migration.h    |  4 ++--
 migration/postcopy-ram.c | 24 ++----------------------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 58a5452471..6761e3f233 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -311,25 +311,35 @@ error:
     return ret;
 }
 
-/* Request a range of pages from the source VM at the given
- * start address.
- *   rbname: Name of the RAMBlock to request the page in, if NULL it's the same
- *           as the last request (a name must have been given previously)
+/* Request one page from the source VM at the given start address.
+ *   rb: the RAMBlock to request the page in
  *   Start: Address offset within the RB
  *   Len: Length in bytes required - must be a multiple of pagesize
  */
-int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
-                              ram_addr_t start, size_t len)
+int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
+                              ram_addr_t start)
 {
     uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
     size_t msglen = 12; /* start + len */
+    size_t len = qemu_ram_pagesize(rb);
     enum mig_rp_message_type msg_type;
+    const char *rbname;
+    int rbname_len;
 
     *(uint64_t *)bufc = cpu_to_be64((uint64_t)start);
     *(uint32_t *)(bufc + 8) = cpu_to_be32((uint32_t)len);
 
-    if (rbname) {
-        int rbname_len = strlen(rbname);
+    /*
+     * We maintain the last ramblock that we requested for page.  Note that we
+     * don't need locking because this function will only be called within the
+     * postcopy ram fault thread.
+     */
+    if (rb != mis->last_rb) {
+        mis->last_rb = rb;
+
+        rbname = qemu_ram_get_idstr(rb);
+        rbname_len = strlen(rbname);
+
         assert(rbname_len < 256);
 
         bufc[msglen++] = rbname_len;
diff --git a/migration/migration.h b/migration/migration.h
index ae497bd45a..ca8dc4c773 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -328,8 +328,8 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
                           uint32_t value);
 void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
-int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
-                              ram_addr_t start, size_t len);
+int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
+                              ram_addr_t start);
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1bb22f2b6c..11a70441a6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -684,14 +684,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                         qemu_ram_get_idstr(rb), rb_offset);
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
-    if (rb != mis->last_rb) {
-        mis->last_rb = rb;
-        migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
-                                  aligned_rbo, pagesize);
-    } else {
-        /* Save some space */
-        migrate_send_rp_req_pages(mis, NULL, aligned_rbo, pagesize);
-    }
+    migrate_send_rp_req_pages(mis, rb, aligned_rbo);
     return 0;
 }
 
@@ -986,20 +979,7 @@ retry:
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
-            if (rb != mis->last_rb) {
-                mis->last_rb = rb;
-                ret = migrate_send_rp_req_pages(mis,
-                                                qemu_ram_get_idstr(rb),
-                                                rb_offset,
-                                                qemu_ram_pagesize(rb));
-            } else {
-                /* Save some space */
-                ret = migrate_send_rp_req_pages(mis,
-                                                NULL,
-                                                rb_offset,
-                                                qemu_ram_pagesize(rb));
-            }
-
+            ret = migrate_send_rp_req_pages(mis, rb, rb_offset);
             if (ret) {
                 /* May be network failure, try to wait for recovery */
                 if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
-- 
2.26.2


