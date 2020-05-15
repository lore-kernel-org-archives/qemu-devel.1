Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C61F206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+nnXDrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C61F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWWV-0007HE-7D
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVK-0005RL-BE
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVJ-0005Y5-Li
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589534380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWEDFkY5Rmel12C/HQ1l0LLLTQtkfAgXAPazusvQxAw=;
 b=F+nnXDrOv0BSa5c8yTVAvNIyscxMIvtn07rBU6mQYf1fMpALwJMeBhNTw/spnx4KfiWvd7
 9rbVym/0XxKFGHJleUcG7MNdz0/Mso+QyZk4JdxH1Y31U25jSNdP7v2KFx7HQO9eUtqYCC
 BgCUmy1c6ckxfAzVCQgCw15TMWAMUdQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-kW0_d00dMJSwwZmcukx7LQ-1; Fri, 15 May 2020 05:19:37 -0400
X-MC-Unique: kW0_d00dMJSwwZmcukx7LQ-1
Received: by mail-wr1-f71.google.com with SMTP id 30so870609wrq.15
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rWEDFkY5Rmel12C/HQ1l0LLLTQtkfAgXAPazusvQxAw=;
 b=KqzwIIhJceYqcN6Oev8sizElbO5c9vQ4hO7SbuH70qe6/O2TS7Ynpye5Q0+Y1o6jur
 f/UmZGX6xMTIoj1mLCnETkG2Fb0W+1ehqmNUjqrzDDcwDVgvwxvJ0yfeV7EEi2HJfpZq
 Uc6mQ50lywGJqki8w0P7V1pgJ3a04Gn5TGcqmD2zqMTOAXtJZzdDvaepqqGuCOXYHU6g
 PwLcI4L8f9mcXdfTIQnzkkjMq7PSZ0F3DQ+HOPyiJCnRNwq0abIYZIti0rlKYriUvb06
 UlyIaIe5DYhNjLVDVp0NwUw8O6oRb9Hp9BrWqJnSQBcQ6RJNO58KTNqXGcUFTu2bPtgO
 gfVg==
X-Gm-Message-State: AOAM53070zdHT379mKcmrRkeejBQqXcQ5A1O9d9Ef4aGJ381dHGsaIBx
 AKpH6O35scLc/rC05V0yyZnkF0NIIyO49Dw0aXhW2+q//VcLJAcOv5mROClqvGfpZx1yKoQ/Tw3
 715zQQpn9fZbbmco=
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr3079994wmh.4.1589534375721; 
 Fri, 15 May 2020 02:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeS3ClRqfcuLfcXZ5mQOeVo3yT2q6D1UXw2xHzRmoHzwp0bdezUQLxOhJssxPeukKl8CaYNQ==
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr3079974wmh.4.1589534375505; 
 Fri, 15 May 2020 02:19:35 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 8sm1476820wmb.15.2020.05.15.02.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] qemu/bitmap: Document bitmap_new() returned pointer
Date: Fri, 15 May 2020 11:19:21 +0200
Message-Id: <20200515091924.14380-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515091924.14380-1-philmd@redhat.com>
References: <20200515091924.14380-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bitmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 82a1d2f41f..0b390ff576 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -90,12 +90,14 @@ int slow_bitmap_intersects(const unsigned long *bitmap1,
                            const unsigned long *bitmap2, long bits);
 long slow_bitmap_count_one(const unsigned long *bitmap, long nbits);
 
+/* callers must free the returned pointer with g_free() */
 static inline unsigned long *bitmap_try_new(long nbits)
 {
     long len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
     return g_try_malloc0(len);
 }
 
+/* callers must free the returned pointer with g_free() */
 static inline unsigned long *bitmap_new(long nbits)
 {
     unsigned long *ptr = bitmap_try_new(nbits);
-- 
2.21.3


