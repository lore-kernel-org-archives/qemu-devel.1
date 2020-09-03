Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E614EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCD7206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCGmH7Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCD7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrDk-00072E-TV
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8b-00009Q-5E
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:26:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8Z-0000DO-99
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAmUmQ2oPw8sOeJlLTMAYNZr3L9wUUBWGxTofVgM/fc=;
 b=RCGmH7Je/RbngJnccyEaDC63BTnc5ePItgydqsUeM5scbjtORysYu+Tb/VoZNrWLlUSa8y
 5J3SwSfkt9j6ce+YYv6tdBqfgL9dcIWfmHbku6hPzNRvlA3Pi5BhAsPrtfEsrOM5xZHyOq
 nxr5oStFYVnN/fgB8e8xqBN2db9IVoo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-MWWE9awJNxWsXs4qZJcB-g-1; Thu, 03 Sep 2020 11:26:52 -0400
X-MC-Unique: MWWE9awJNxWsXs4qZJcB-g-1
Received: by mail-qt1-f198.google.com with SMTP id o14so331948qtq.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DAmUmQ2oPw8sOeJlLTMAYNZr3L9wUUBWGxTofVgM/fc=;
 b=MKaNksgtxHwyY8OH2ho9rMDH9fLHqoWLkm/mMyMsoWOqgCqXZCweVBl2BQjynrfxke
 tGDjzxsAMzXVrBOYzmuLckpRCK6hvIRIemdjDDzxmm6NXGLoKQp4uMZlYMWiJsHFI+d8
 2HJNA/pTgkyBXVuye5HVpPFHHQAPOI8rfKNWqiYitseJtoLJjVI+hiRd3OUU83yaHexn
 dalSlwA3oDdP0zo4d5MjCOaE9qjet8HZTEsH1wjQNi4M5Yl8q+LVbyfP+Jz1+frHjlYk
 doSSAF9bNH0R10V6h7bmd9X/Y+HjXGjhQMWmaBb/5v9540npAr0frWAKmKizovrwxDK/
 uuag==
X-Gm-Message-State: AOAM53277tc0GnKEXeoUd12uwpNWK33AYahFh9ZzxV9/EQ2r7Y6CjIZR
 6LKJu0pUZ0eSPPKKgRxy1E9H8x8AvxK4CPKTQlzdHS4cQfEh+WTg5B1LymiBMqNoQwUoJ4GXsFD
 afK2jvtVdQGYoEn4=
X-Received: by 2002:a37:654b:: with SMTP id z72mr3485892qkb.365.1599146812087; 
 Thu, 03 Sep 2020 08:26:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhxnmxNHEzcd+Y0bZIUNW0PwSMhPvUejDGjAMadilAkSkNQXTPL/pBO3elKGG8hCC7YBwtKw==
X-Received: by 2002:a37:654b:: with SMTP id z72mr3485872qkb.365.1599146811895; 
 Thu, 03 Sep 2020 08:26:51 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id l38sm2319889qtl.58.2020.09.03.08.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 08:26:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] migration: Introduce migrate_send_rp_message_req_pages()
Date: Thu,  3 Sep 2020 11:26:43 -0400
Message-Id: <20200903152646.93336-3-peterx@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
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

This is another layer wrapper for sending a page request to the source VM,

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++++++++--
 migration/migration.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6761e3f233..6b43ffddbd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -316,8 +316,8 @@ error:
  *   Start: Address offset within the RB
  *   Len: Length in bytes required - must be a multiple of pagesize
  */
-int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
-                              ram_addr_t start)
+int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
+                                      RAMBlock *rb, ram_addr_t start)
 {
     uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
     size_t msglen = 12; /* start + len */
@@ -353,6 +353,12 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
     return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }
 
+int migrate_send_rp_req_pages(MigrationIncomingState *mis,
+                              RAMBlock *rb, ram_addr_t start)
+{
+    return migrate_send_rp_message_req_pages(mis, rb, start);
+}
+
 static bool migration_colo_enabled;
 bool migration_incoming_colo_enabled(void)
 {
diff --git a/migration/migration.h b/migration/migration.h
index ca8dc4c773..f552725305 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -330,6 +330,8 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
                               ram_addr_t start);
+int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
+                                      RAMBlock *rb, ram_addr_t start);
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
-- 
2.26.2


