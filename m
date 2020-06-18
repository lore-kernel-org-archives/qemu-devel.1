Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F005C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3EF2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEgHEEBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3EF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlueT-0006a4-2O
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluV8-0005nX-Ix
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluV6-0005lP-Mz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WY9uuhYcrLCiZTe+aHYizIWB/zPu8U68u5vIIhwUxgY=;
 b=FEgHEEBmLE+0ov8gN0SdBSuR67K9t+Pm5L+x9ahnMGyU7UPFbx1QJYvTDbE9TDquUiygD9
 /Ji+JIHr/eK1siSi3/f7WOrW9eTh1eQdDpaVHbtLHLWdUsrGqevMmUYGcl+0jzSr9FXbaT
 SruIjtWkOly82t9eH9Ems5hAxVgw9uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-gVHtbOanNH6qi3EviPvQRw-1; Thu, 18 Jun 2020 09:22:37 -0400
X-MC-Unique: gVHtbOanNH6qi3EviPvQRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B033F1902EDC;
 Thu, 18 Jun 2020 13:22:33 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0D0E5BAC3;
 Thu, 18 Jun 2020 13:22:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 10/33] hw/net/tulip: Log descriptor overflows
Date: Thu, 18 Jun 2020 21:21:25 +0800
Message-Id: <1592486508-6135-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Log with GUEST_ERROR what the guest is doing wrong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/tulip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 57ecbe2..4487fd6 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -578,6 +578,9 @@ static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *desc)
     int len2 = (desc->control >> TDES1_BUF2_SIZE_SHIFT) & TDES1_BUF2_SIZE_MASK;
 
     if (s->tx_frame_len + len1 > sizeof(s->tx_frame)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: descriptor overflow (ofs: %u, len:%d, size:%zu)\n",
+                      __func__, s->tx_frame_len, len1, sizeof(s->tx_frame));
         return -1;
     }
     if (len1) {
@@ -587,6 +590,9 @@ static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *desc)
     }
 
     if (s->tx_frame_len + len2 > sizeof(s->tx_frame)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: descriptor overflow (ofs: %u, len:%d, size:%zu)\n",
+                      __func__, s->tx_frame_len, len2, sizeof(s->tx_frame));
         return -1;
     }
     if (len2) {
-- 
2.5.0


