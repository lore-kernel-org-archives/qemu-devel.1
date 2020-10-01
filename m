Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378ECC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A05E20848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBiZEY93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A05E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2wM-0007b3-1b
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fj-0003d9-Pj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fc-0006r0-5l
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601574427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKSXHVbVdVKVvM5LeQ2m/fbuOAoZlx3FTE3Me/SJ4yY=;
 b=XBiZEY93E58YEMu3ejwOMbTBsbWC9G1ch5V9QRHOOF7aw+ruRBvts2CZvolqA6ndT0QUoe
 M4jFSNrNo41cHjh2hQ3KnmLNHA478k/jVZLtcxugBtPqRgH2NFe0WZy4bEKFme89jSpCn+
 pO9L/r+vAL4V35a4DUkj/QxS9YChni8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-s7WiZU4oNfO-m8MGU_5jrA-1; Thu, 01 Oct 2020 13:47:01 -0400
X-MC-Unique: s7WiZU4oNfO-m8MGU_5jrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4CC82ED9;
 Thu,  1 Oct 2020 17:47:00 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C55445C1CF;
 Thu,  1 Oct 2020 17:46:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 6/9] ide: reorder set/get sector functions
Date: Thu,  1 Oct 2020 13:46:46 -0400
Message-Id: <20201001174649.1911016-7-jsnow@redhat.com>
In-Reply-To: <20201001174649.1911016-1-jsnow@redhat.com>
References: <20201001174649.1911016-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reorder these just a pinch to make them more obvious at a glance what
the addressing mode is.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/ide/core.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 6ececa5dfee..afff355e5c6 100644
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


