Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F42C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BC22053B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlM8lffs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BC22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAWP-0003xE-GY
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jhAVf-0002YM-JX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:27:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jhAVe-00031Z-D6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591356457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWTx3Iur+g/wLWbDzYDLshZvaZWBO0zM7EOG0uIUw90=;
 b=UlM8lffs+57/nu7fZLFl0iObEr2rreXJRy6K9jpYg7TdOBKmmcsJivfuoH763gZrxxjOSB
 v9lb6nl/gFNzjh7Oi1UXQnNDSnlLF7e5+AElAjHgNoNICTcrGQ1JI4UwKXaBTRtvBaCQ3b
 ii++xJH+Ifp+F5JWdAmT4aMlvZS9NTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-sSjkiy1TPpy4WkZiG_9TPw-1; Fri, 05 Jun 2020 07:27:35 -0400
X-MC-Unique: sSjkiy1TPpy4WkZiG_9TPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E05B18A8223;
 Fri,  5 Jun 2020 11:27:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CAE760BE2;
 Fri,  5 Jun 2020 11:27:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ED4721750A; Fri,  5 Jun 2020 13:27:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] ati-vga: check mm_index before recursive call
 (CVE-2020-13800)
Date: Fri,  5 Jun 2020 13:27:23 +0200
Message-Id: <20200605112724.18622-2-kraxel@redhat.com>
In-Reply-To: <20200605112724.18622-1-kraxel@redhat.com>
References: <20200605112724.18622-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>
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
Message-id: 20200604090830.33885-1-ppandit@redhat.com
Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 065f197678e4..67604e68deb1 100644
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
@@ -520,8 +523,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
2.18.4


