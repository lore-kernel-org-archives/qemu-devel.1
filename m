Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A51D22200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN20YtLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A51D22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUe9o-0003S1-Jj
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5r-00070e-Nj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5p-0005cR-CP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603148248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSeDqMHpB+FHPSAPyKgXEXUo5azyTlLZe7OlYAX6W4M=;
 b=HN20YtLtpxXFbY0b0taAHU+vocFXZHUnq3U+T4uwblq1xsmgzdo+vj98dmSepJ2T6NyoE8
 l5IS5n9Ilr5HS5XooBGiinOaHnToWsqATzKvCEoRgN0fQPg17xWOsZyilDsP5Mq6XwYqnA
 BR4SKPezjb27uLSuAZ9e2WkL1ZOOdfU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-WdAkfVXcO6eaETXgw7ARLw-1; Mon, 19 Oct 2020 18:57:27 -0400
X-MC-Unique: WdAkfVXcO6eaETXgw7ARLw-1
Received: by mail-io1-f69.google.com with SMTP id x13so1339530iom.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSeDqMHpB+FHPSAPyKgXEXUo5azyTlLZe7OlYAX6W4M=;
 b=MBqMgiouHHMuCfd5SojlUcJQrdbqNcJYRS+uWPLWfxR0ryRmnqa3gQkHa0v36M7Fz6
 aeWX/14GcIFdEJ6ijPSCqa85K5ng1W9XGxC8XQSDrdMFEBGfPcsqG2+iMQCEe67xEVLJ
 xBj9qVgvuJPZpYZH0G7YeHsihIQ4xwlDfXkMPc8wKC9AbVHEzup9G8TxW7aHgC7ff0VA
 XzfyxniFQeF6Sm5zFuX8m2SAOcGemYhQJ6AvQ0BQRpgrt4blZDRprTQnHfVsu7INAhdg
 eojYxCCsDMHkAZFcrXQC7o+bQR08O0ar3nXXshNBxVQj2d26IgEpeZKz+rXMHRSmqFZq
 N57A==
X-Gm-Message-State: AOAM530SIxEYnGaa8KiqT0Hl3UBxxduNISlnYMZTFlNTTSFfAZ8DuhIA
 XZnPKb7sb6kOSp+C7ujytCPmLqw8eGY17gkVtZr9JfDQYc8B/Thu4kdrJE/SbgacA2gjkaGCzH8
 CraeS61Zz/Eyt3Gg=
X-Received: by 2002:a92:5b02:: with SMTP id p2mr1875079ilb.283.1603148246433; 
 Mon, 19 Oct 2020 15:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfVISBIRnF+2+sUJINEEiz8W0RLnjUZpqmYjYkDfWfmwzD/pVG/QB2hlKQi05JGNyGR7y1cg==
X-Received: by 2002:a92:5b02:: with SMTP id p2mr1875069ilb.283.1603148246275; 
 Mon, 19 Oct 2020 15:57:26 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z89sm6017ilk.4.2020.10.19.15.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 15:57:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/6] migration: Introduce
 migrate_send_rp_message_req_pages()
Date: Mon, 19 Oct 2020 18:57:16 -0400
Message-Id: <20201019225720.172743-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019225720.172743-1-peterx@redhat.com>
References: <20201019225720.172743-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is another layer wrapper for sending a page request to the source VM.  The
new migrate_send_rp_message_req_pages() will be used elsewhere in coming
patches.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++++++++--
 migration/migration.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index aca7fdcd0b..b2dac6b39c 100644
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
index deb411aaad..e853ccf8b1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -333,6 +333,8 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
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


