Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC6C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20106206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT+U63Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20106206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPHA-0002bX-7T
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOPFa-0001IW-RN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOPFY-000575-8K
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601661223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSeDqMHpB+FHPSAPyKgXEXUo5azyTlLZe7OlYAX6W4M=;
 b=OT+U63VvLxpHCAUuCF4jO/xBZcs39ckU53PNZjEnfVlJmWDassrpWQRNPcN26vEGiEksP/
 whYvaD15MSwSddm9bypieAD7zIjrppI6AKH3zO2jGnFJ2+KgGNzlOv5ZD3/I3NKGXrYX8b
 GHnbHJ5VscaENM+KNNn9GjaidDdPnb4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-OkiZA_ivN6eqHlGdn-OsGw-1; Fri, 02 Oct 2020 13:53:42 -0400
X-MC-Unique: OkiZA_ivN6eqHlGdn-OsGw-1
Received: by mail-qt1-f199.google.com with SMTP id f5so1568982qtk.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSeDqMHpB+FHPSAPyKgXEXUo5azyTlLZe7OlYAX6W4M=;
 b=fKTjHd8khOLmzTHxLMkzRDgIlD+4yhbXIC4PAMGLdNv2nwprmsh0KMkAmFshcBDL+p
 K1qah0n5h9mAVQzSaKhBMWIi4FJtb1bmB4WCh9qfXlyXkCueWJlaqdMNXmhbrFmBctRO
 XGFukcfbqDqAkoOFUiRSYQkG0bp/OAX8uFl7v17Hjup2ueX6k+X0zhE1Sufd2I608MrU
 hS7IFe6yS8avTtfj2wtY2YB/wA1Riv8kraO334O70aZJN4WbguFEwYrxyr2XqzNJFKxv
 8FdI5KdfMMkNbQxIULqh706YbDXRbxmql5VN311IMtRUMl9qzOaXblZdc93uPovEQNWI
 /reg==
X-Gm-Message-State: AOAM533IP8IVNrHp5ZzpjkeoII7/k0F1bSx/4b6S8L9KOTsFfdPMQjF1
 8V1vmdCjywDziqiWe8rTqC5Qofqb/vvrAaIJPjWwkWtUR3KRblzd9Zp18dxyslWfxg8zA9RAqHK
 HtO30/VYo7jOS13I=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr3476265qto.158.1601661221582; 
 Fri, 02 Oct 2020 10:53:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfx/otY6zgjxIY+jEr+ON6ECTGV4tt+ojztdSnRtEZ6F4anDX7tIqREb5Zc56uzJdzUjhCMQ==
X-Received: by 2002:ac8:4658:: with SMTP id f24mr3476248qto.158.1601661221383; 
 Fri, 02 Oct 2020 10:53:41 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id a3sm1562229qtp.63.2020.10.02.10.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:53:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] migration: Introduce
 migrate_send_rp_message_req_pages()
Date: Fri,  2 Oct 2020 13:53:34 -0400
Message-Id: <20201002175336.30858-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002175336.30858-1-peterx@redhat.com>
References: <20201002175336.30858-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
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


