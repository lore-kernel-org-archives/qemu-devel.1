Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3926DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8083208FE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUqyXlqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8083208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkJj-0002bt-2z
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkGC-0004Ej-El
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkGA-0007wW-K7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599597033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amKOtoi6vPf/V/x2bL7dd1QXHRAnGLq9RsDduAfD7yI=;
 b=fUqyXlqWiqH1nSupchumy1DVtoEuwYxcT/bmcy5Acn8FhRR4KNg9ZSst5yY5P7caQE8omq
 Ad+UFKU3SgU2oT7Uw6O4oA720jW3xxJtREOT9QmglD3ITOdxDW9hgbtLpCitSsuJCxC7WH
 FXfg40vJ2BqGPIslffJOUFrhotj8vVk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-plPdsnNNPQGkLoTRepDjfA-1; Tue, 08 Sep 2020 16:30:31 -0400
X-MC-Unique: plPdsnNNPQGkLoTRepDjfA-1
Received: by mail-qt1-f200.google.com with SMTP id y53so361972qth.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=amKOtoi6vPf/V/x2bL7dd1QXHRAnGLq9RsDduAfD7yI=;
 b=Xo5y1O3uoKFBYlGBsg4KemDtaJUjCprzKlyJPOSc5loh8das0RU+MJ1/Sig23pit2a
 X3elsY5n0UQ/sBzV6/oeO+WxAXYsWHh8yrJKbkm4GwkJKQuT23PLIJwdSsghaeObLDdV
 vlAv3OVLgHNuXJmQZEjrAb/oJWekUUmxYO5sEvYh0btphhbzv1Q+q7GscFtaew213jAL
 qt8t8X3K8BzWRX3/35p/Qk89mUg+Q07rHp6OMfD3wRaFOs0CXFl1zEzVdpobJ6+IAERj
 a0oM3ps1R6pBEEBlitlk50PeHoXH2UYhpZ94Vj6TeF62VQ0ancZMFxf7VOcZytIfqN+H
 GZAA==
X-Gm-Message-State: AOAM531zWVVKHIRPlIRM6s5smUVQTN3iquEu9iH0g7ixntkvquP16XTK
 O3lZdl0CL88UK3RKconr5FGKnvSNPn8Qd5/pdJyBJbiI2HA/vYFqeofmo4u78FLUtkWQQARZ3CZ
 wNy3zxU5sHk3ZPtQ=
X-Received: by 2002:a05:620a:2404:: with SMTP id
 d4mr341544qkn.284.1599597030879; 
 Tue, 08 Sep 2020 13:30:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFmUngwy0dJAvKj+aoqnNnBh74yjMOE7qDM9NgQTTO1mdmcgrchSAU9NBOYwlLniDwrjjsAw==
X-Received: by 2002:a05:620a:2404:: with SMTP id
 d4mr341523qkn.284.1599597030615; 
 Tue, 08 Sep 2020 13:30:30 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id o28sm595397qtl.62.2020.09.08.13.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:30:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] migration: Introduce
 migrate_send_rp_message_req_pages()
Date: Tue,  8 Sep 2020 16:30:20 -0400
Message-Id: <20200908203022.341615-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908203022.341615-1-peterx@redhat.com>
References: <20200908203022.341615-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:55:20
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
index 2e6b21544b..6e06b6f4e6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -319,8 +319,8 @@ error:
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
@@ -356,6 +356,12 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
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


