Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E82C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941062074B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyYLb0yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941062074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmYe-0006zw-I7
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVU-0002BQ-9C
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVQ-0004Cw-Sa
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g11t0Rk3ousL47iNjK5Udtv7AJW1FtT5fTYIQ8CPVF0=;
 b=RyYLb0ylb36dJ46G7NRD37zhN5XT5kO7jMiRBZKoyJSETRfzJb0ggiTOyOI9fVTPprh8R2
 5HThK+wpYiYLlyfKHY/YjnlR1ZqfZ9FCHuXQYzd+Q0eiFGUc0FtG7fYhUJaMOLyao63wUD
 B5Xk74iF9Uy75J1rpfuJ36rIDZzNt/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-pKc3RSS3PTSVFX7rX5ZN6w-1; Fri, 25 Sep 2020 08:07:12 -0400
X-MC-Unique: pKc3RSS3PTSVFX7rX5ZN6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76C6210BBECB;
 Fri, 25 Sep 2020 12:07:10 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EAAB73692;
 Fri, 25 Sep 2020 12:07:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 02/26] migration: Rework migrate_send_rp_req_pages() function
Date: Fri, 25 Sep 2020 13:06:31 +0100
Message-Id: <20200925120655.295142-3-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

We duplicated the logic of maintaining the last_rb variable at both callers of
this function.  Pass *rb pointer into the function so that we can avoid
duplicating the logic.  Also, when we have the rb pointer, it's also easier to
remove the original 2nd & 4th parameters, because both of them (name of the
ramblock when needed, or the page size) can be fetched from the ramblock
pointer too.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200908203022.341615-3-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c    | 26 ++++++++++++++++++--------
 migration/migration.h    |  4 ++--
 migration/postcopy-ram.c | 24 ++----------------------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3495c9e542..827f8be07d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -314,25 +314,35 @@ error:
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
index bdc7450da3..e74042362d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -326,8 +326,8 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
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
index 1654ff11a5..0a2f88a87d 100644
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


