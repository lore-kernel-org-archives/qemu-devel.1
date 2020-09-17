Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316ADC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727242137B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D890UBYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727242137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kInLS-0006Dl-7M
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 02:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kInJw-0004hC-Ey
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kInJu-0002jk-G2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600323781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y86zsB51YRxIrGPaBaJ0OMrK6jcKF47UHG43z60HUs=;
 b=D890UBYokZy5sYmdIeIlObrrIwVB+yiv/0zrte8gSPo3jCowSV0Cc9nei3qiLbKFRlMcp2
 5YCDyxnsbYNbGlpWe80rRoY7PQyUHo7Be0zdP9uvBH72I7fxeOv4lr8wchOr9slwmnChYe
 2objZS4MoD2poTBX8y0vF5cM2kV98gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-sSl5fiavOA-6RD5ezeQrPw-1; Thu, 17 Sep 2020 02:23:00 -0400
X-MC-Unique: sSl5fiavOA-6RD5ezeQrPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41CE7186DD2A
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:22:59 +0000 (UTC)
Received: from localhost (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56F217BE44;
 Thu, 17 Sep 2020 06:22:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] edid: fix physical display size computation
Date: Thu, 17 Sep 2020 10:22:38 +0400
Message-Id: <20200917062242.1877925-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200917062242.1877925-1-marcandre.lureau@redhat.com>
References: <20200917062242.1877925-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Divide the resolution by the DPI, and multiply to mm.

Note the computation done for edid[21/22] is correct (in cm).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/edid-generate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index e58472fde5..618c74e1df 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -208,8 +208,8 @@ static void edid_desc_timing(uint8_t *desc,
                              uint32_t dpi)
 {
     /* physical display size */
-    uint32_t xmm = xres * dpi / 254;
-    uint32_t ymm = yres * dpi / 254;
+    uint32_t xmm = xres * 254 / 10 / dpi;
+    uint32_t ymm = yres * 254 / 10 / dpi;
 
     /* pull some realistic looking timings out of thin air */
     uint32_t xfront = xres * 25 / 100;
-- 
2.26.2


