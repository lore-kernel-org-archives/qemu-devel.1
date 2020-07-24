Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1293FC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D016A206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPxTE+vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D016A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqCH-0003Df-23
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAr-000114-CV
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAn-0007Ro-99
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PIIZ0rWR7fbA3h+dJxS8bPAnBQjFmR4OXt+O8WSIe4=;
 b=cPxTE+vnoOwmG0gdVqFKQTC6ZGm0JhvNqe4jyK194FKbrJWLgnMLwfWx/kV2/1KNCotrly
 3v4IqlCK+8IIN3cW2/CTYn0lT9muEFU3SJ9/+2jzFBMLXSfcTp3MnX8Q/eVbrT61izhMf/
 9KfM808qjvSy599Hu3j2Bu5hgISm0uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-8ZudlPRyPCafl_ZxXyD4gQ-1; Fri, 24 Jul 2020 01:23:06 -0400
X-MC-Unique: 8ZudlPRyPCafl_ZxXyD4gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D4B980183C;
 Fri, 24 Jul 2020 05:23:05 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 816B17F4D6;
 Fri, 24 Jul 2020 05:23:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] ide: reorder set/get sector functions
Date: Fri, 24 Jul 2020 01:22:57 -0400
Message-Id: <20200724052300.1163728-5-jsnow@redhat.com>
In-Reply-To: <20200724052300.1163728-1-jsnow@redhat.com>
References: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reorder these just a pinch to make them more obvious at a glance what
the addressing mode is.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index a880b91b47..f35864070b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -587,21 +587,23 @@ int64_t ide_get_sector(IDEState *s)
 {
     int64_t sector_num;
     if (s->select & 0x40) {
-        /* lba */
-        if (!s->lba48) {
-            sector_num = ((s->select & 0x0f) << 24) | (s->hcyl << 16) |
-                (s->lcyl << 8) | s->sector;
-        } else {
+        if (s->lba48) {
             sector_num = ((int64_t)s->hob_hcyl << 40) |
                 ((int64_t) s->hob_lcyl << 32) |
                 ((int64_t) s->hob_sector << 24) |
                 ((int64_t) s->hcyl << 16) |
                 ((int64_t) s->lcyl << 8) | s->sector;
+        } else {
+            /* LBA28 */
+            sector_num = ((s->select & 0x0f) << 24) | (s->hcyl << 16) |
+                (s->lcyl << 8) | s->sector;
         }
     } else {
+        /* CHS */
         sector_num = ((s->hcyl << 8) | s->lcyl) * s->heads * s->sectors +
             (s->select & 0x0f) * s->sectors + (s->sector - 1);
     }
+
     return sector_num;
 }
 
@@ -609,20 +611,22 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
 {
     unsigned int cyl, r;
     if (s->select & 0x40) {
-        if (!s->lba48) {
-            s->select = (s->select & 0xf0) | (sector_num >> 24);
-            s->hcyl = (sector_num >> 16);
-            s->lcyl = (sector_num >> 8);
-            s->sector = (sector_num);
-        } else {
+        if (s->lba48) {
             s->sector = sector_num;
             s->lcyl = sector_num >> 8;
             s->hcyl = sector_num >> 16;
             s->hob_sector = sector_num >> 24;
             s->hob_lcyl = sector_num >> 32;
             s->hob_hcyl = sector_num >> 40;
+        } else {
+            /* LBA28 */
+            s->select = (s->select & 0xf0) | (sector_num >> 24);
+            s->hcyl = (sector_num >> 16);
+            s->lcyl = (sector_num >> 8);
+            s->sector = (sector_num);
         }
     } else {
+        /* CHS */
         cyl = sector_num / (s->heads * s->sectors);
         r = sector_num % (s->heads * s->sectors);
         s->hcyl = cyl >> 8;
-- 
2.26.2


