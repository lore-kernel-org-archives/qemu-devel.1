Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDFAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371052065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeqkTt8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371052065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglv2-0007u1-Gl
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgluA-00070d-J8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:11:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jglu9-0006D4-2T
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591261876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lqPlpcY1f7um6lZyFEQekaUFS+zb2uLYGtmAfm4q6Ek=;
 b=NeqkTt8Y6DICvoh3mx8KXyVgutBKTFcifRpqzuxB4XVCpV6MTNmVZ1gafHQt01Sq+Ib52y
 MQck8EEkppHWHXswMyyCgxzk8N9tN1E2IGenXl/+jfdmA5krEUugkYh9W2CeIASZqeO6dY
 IE2kPvIdtOxh7h33ld/ohU0v8/jMnCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-8LwWd-mXNFCNngYWrOw6eg-1; Thu, 04 Jun 2020 05:11:12 -0400
X-MC-Unique: 8LwWd-mXNFCNngYWrOw6eg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79DEC835B8B;
 Thu,  4 Jun 2020 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-200.sin2.redhat.com
 [10.67.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FC9A19C58;
 Thu,  4 Jun 2020 09:11:04 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] ati-vga: check mm_index before recursive call
 (CVE-2020-13800)
Date: Thu,  4 Jun 2020 14:38:30 +0530
Message-Id: <20200604090830.33885-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While accessing VGA registers via ati_mm_read/write routines,
a guest may set 's->regs.mm_index' such that it leads to infinite
recursion. Check mm_index value to avoid such recursion. Log an
error message for wrong values.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Reported-by: Yi Ren <c4tren@gmail.com>
Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/ati.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Update v3: log error message
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00827.html

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 60c5f246fd..98c21e7bd5 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -285,8 +285,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
             if (idx <= s->vga.vram_size - size) {
                 val = ldn_le_p(s->vga.vram_ptr + idx, size);
             }
-        } else {
+        } else if (s->regs.mm_index > MM_DATA + 3) {
             val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "ati_mm_read: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
@@ -523,8 +526,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             if (idx <= s->vga.vram_size - size) {
                 stn_le_p(s->vga.vram_ptr + idx, size, data);
             }
-        } else {
+        } else if (s->regs.mm_index > MM_DATA + 3) {
             ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
-- 
2.26.2


