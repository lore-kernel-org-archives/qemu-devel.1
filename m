Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D73C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535D12077D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jK2Dhxfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535D12077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgYar-0006tF-HN
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 14:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgYa4-000679-G8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 14:57:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgYa2-0001bS-TF
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 14:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591210657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GrlBf7nmYTAXVG5xBhh2XusfIat7d/Qooh/R76PHWFU=;
 b=jK2DhxfvbNa05wpjOzxp4SNiKk8o6lZmIGmoCFuEDZk7CxdbctF1iUwynOfwsCHxKIOJwb
 +r2xvwVWK+XoahOg603Uy13CNevYHmThKoiR21rBtS7Al4mZirbfzpav6v/AGfA1/pYt8a
 W/O/l0Hdq7ZXlpyvbm5jbqSr0bWHKKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-NfuagYcmNJeL7l8d225rPw-1; Wed, 03 Jun 2020 14:57:33 -0400
X-MC-Unique: NfuagYcmNJeL7l8d225rPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64A3618A0762;
 Wed,  3 Jun 2020 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F28465C297;
 Wed,  3 Jun 2020 18:57:25 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] ati-vga: check mm_index before recursive call
Date: Thu,  4 Jun 2020 00:25:22 +0530
Message-Id: <20200603185522.1173354-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While accessing VGA registers via ati_mm_read/write routines,
a guest may set 's->regs.mm_index' such that it leads to infinite
recursion. Check mm_index value to avoid it.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Reported-by: Yi Ren <c4tren@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Update v2: add check before recursive call
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00781.html

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 065f197678..bda4a2d816 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -285,7 +285,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
             if (idx <= s->vga.vram_size - size) {
                 val = ldn_le_p(s->vga.vram_ptr + idx, size);
             }
-        } else {
+        } else if (s->regs.mm_index > MM_DATA + 3) {
             val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
         }
         break;
@@ -520,7 +520,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             if (idx <= s->vga.vram_size - size) {
                 stn_le_p(s->vga.vram_ptr + idx, size, data);
             }
-        } else {
+        } else if (s->regs.mm_index > MM_DATA + 3) {
             ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
         }
         break;
-- 
2.26.2


