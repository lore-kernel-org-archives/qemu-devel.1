Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00FCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A989206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQFF8kD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A989206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwsx-00050z-Hu
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwor-0000g6-Hi
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwon-0000wM-8I
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoKGRGT2V6fv30rJh8pJxgu9hLwQjaS3tEMU4jSGQIA=;
 b=ZQFF8kD2q2asTYxThS/xv6Es/xDt+5rnh2wdJT1eKYJrrfZxlBg1/Zzrkq7hXgKSJoD0Ky
 Bgg4OSkALmVXF+38fBLyqTC1ZR0pxBIetDVEzv0eV2RXyJs390OgexcH97CeAQRnrcdfre
 a/Pqd+XSLWDS88MSKGbZCK9qB+hX6FM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-49SMtp39My2o844oh3QTtg-1; Thu, 17 Sep 2020 12:31:29 -0400
X-MC-Unique: 49SMtp39My2o844oh3QTtg-1
Received: by mail-wm1-f69.google.com with SMTP id t8so705813wmj.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hoKGRGT2V6fv30rJh8pJxgu9hLwQjaS3tEMU4jSGQIA=;
 b=X86wQ4njdkALt999FGaFYbpcJcZcAnE9GAnjMgMsWLvA6m/GVvs5Tbc2ZU7gZfrNgW
 u9rt52epWCRMU/7+2ej6DehjhuvoiGtnGFYvu2dL62DF5q+beKmE4xo+5sl1/iYtzzmq
 yLb987K3oAsv+ZdJXFGC+vZyBjXuHt+jd5VYsBu+CZ69CxiOmSuDaFTS9hwTQCRpnqod
 HCjyIS03+pVz4aXNychvMj1lqdDYGM+OgcV+b2tcqOmFjzNy+jMazL+ljIrn+/4J+w2Q
 eJfROSmVyc1TZQmeLNasLvJGVmTJNNg08lrgx4WMJ6M/s1bF1GfOIZJLQTTp4PjiD3Zf
 Yo8Q==
X-Gm-Message-State: AOAM533SIQBvLL4LItkh5rj5oO5E1SQeOiJSpGOoM2CAsvU3V4gSop68
 Buf+zwSpwd0llnss2ehRdjpDHsOmh7TVIvEUKpLtuFtehTMyaoTkxCD0DZeUL9+YQr5hCbMGKwP
 hLqNPiqg1IxJ7CM4=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr35041007wrx.164.1600360287755; 
 Thu, 17 Sep 2020 09:31:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXPAP0gqwaUGtUWZKXaggU2xICD+f79soDWmMyd2fwP1yolvt5oTi7L6fQSKK2/5UDxgx7ZA==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr35040986wrx.164.1600360287607; 
 Thu, 17 Sep 2020 09:31:27 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b11sm154973wrt.38.2020.09.17.09.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:31:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] qemu/bswap: Let cpu_to_endian() functions handle constant
 expressions
Date: Thu, 17 Sep 2020 18:31:06 +0200
Message-Id: <20200917163106.49351-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917163106.49351-1-philmd@redhat.com>
References: <20200917163106.49351-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_to_endian() and endian_to_cpu() can be extended to handle
constant expressions. That way the programmer doesn't need to
remember the const_X() API exists.

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index de256cea3ab..8827e4760b9 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -191,12 +191,16 @@ static inline void bswap64s(uint64_t *s)
 #define CPU_CONVERT(endian, size, type)\
 static inline type endian ## size ## _to_cpu(type v)\
 {\
-    return glue(endian, _bswap)(v, size);\
+    return __builtin_constant_p(v) ?\
+           const_ ## endian ## size(v) :\
+           glue(endian, _bswap)(v, size);\
 }\
 \
 static inline type cpu_to_ ## endian ## size(type v)\
 {\
-    return glue(endian, _bswap)(v, size);\
+    return __builtin_constant_p(v) ?\
+           const_ ## endian ## size(v) :\
+           glue(endian, _bswap)(v, size);\
 }\
 \
 static inline void endian ## size ## _to_cpus(type *p)\
-- 
2.26.2


