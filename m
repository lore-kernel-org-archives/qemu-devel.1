Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EB0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9A721D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpwFI4mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9A721D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8jo-0005dV-NH
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UI-0000dk-ES
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UG-0004bN-Jy
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI+aOJWW59NHhphSZwR0nlNLS5F1Pya2WLuaZoiZpG8=;
 b=gpwFI4mnubq412Xo2K3wjWkTc9Eb0v5lxZfQFyN3dY6bxm5vmLnIfsUsmoHKn1FRt+TVwX
 QWgeZB7KSDMjQCdvGjh4FciAeGEKrTfGKKXWH/cf5Dw2lrqVRW2rx4kOGsUKg+lECwPWZm
 KZzBZ9ltHsx9mHUuwAbYoxOXedLYq6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89--2lLytUaM3mWrM5-YV_R4Q-1; Tue, 15 Sep 2020 06:46:57 -0400
X-MC-Unique: -2lLytUaM3mWrM5-YV_R4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B40802B70;
 Tue, 15 Sep 2020 10:46:56 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C1945DC08;
 Tue, 15 Sep 2020 10:46:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/22] qemu-img: Explicit number replaced by a constant
Date: Tue, 15 Sep 2020 12:46:17 +0200
Message-Id: <20200915104627.699552-13-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yi Li <yili@winhong.com>

Signed-off-by: Yi Li <yili@winhong.com>
Message-Id: <20200819013607.32280-1-yili@winhong.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 37365d06fa..1d8c5cd778 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1201,10 +1201,10 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
         *pnum = 0;
         return 0;
     }
-    is_zero = buffer_is_zero(buf, 512);
+    is_zero = buffer_is_zero(buf, BDRV_SECTOR_SIZE);
     for(i = 1; i < n; i++) {
-        buf += 512;
-        if (is_zero != buffer_is_zero(buf, 512)) {
+        buf += BDRV_SECTOR_SIZE;
+        if (is_zero != buffer_is_zero(buf, BDRV_SECTOR_SIZE)) {
             break;
         }
     }
@@ -2513,8 +2513,8 @@ static int img_convert(int argc, char **argv)
             }
         }
 
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, s.total_sectors * 512,
-                            &error_abort);
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
+                            s.total_sectors * BDRV_SECTOR_SIZE, &error_abort);
         ret = add_old_style_options(out_fmt, opts, out_baseimg, NULL);
         if (ret < 0) {
             goto out;
-- 
2.26.2


