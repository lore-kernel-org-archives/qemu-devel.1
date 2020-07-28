Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02DBC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B0B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1NjIiBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B0B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MZ6-0006JK-UO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0MYA-0005Ng-8L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:09:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0MY7-0006u5-DZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595930970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BhUW9ESioUiSA1BxCHyRzLsoe5bVOy2Ifgl37qfIfW8=;
 b=M1NjIiBcjrot7DWhYtF7aKO/qSfinOA8LevBZzsPan0Mgj49Al0NeqNbtcZRx5QrmQBRXo
 dxBEVNer32uiZinbJIYLTo2uedbvtVL8CiJy75F9Ycvatp7nV6ZxvlQCrtlonk50acMBic
 T+JlF6CRHB5IF/gqOdbUotbhDRgTjfY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-U_OYnENiNLiJvY542YaO1A-1; Tue, 28 Jul 2020 06:09:28 -0400
X-MC-Unique: U_OYnENiNLiJvY542YaO1A-1
Received: by mail-wm1-f70.google.com with SMTP id h205so8702012wmf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BhUW9ESioUiSA1BxCHyRzLsoe5bVOy2Ifgl37qfIfW8=;
 b=qa5cCIbYsO/Tza0tdrHIDZkAJ+TOMX40v6MYuSU4CxFwsq8JxsxFEn+GXMhMzJ/FYS
 Amg1nKT66er1xRmOD0Ijpp3aDkWNWxZYFueC0OG6yxx29rabiCI8549/3/BfRV5F7daj
 mpA4DjuBPe1Rw1KFfwKWiNRburwag4gdVYD9pU3eYZ1zMF9NItF04xNyKr/qZvm+Wshk
 NLg6Cjora74zBcT4AmhQxN9o4ko7wsiYYdQJaDZQKjQV9uZj/99HoSHroeDhZV+XHjM8
 i+fsb203nVZR9e8azGRF100/S3/XOV9vMMo2LcuDZeLtdOLkQ2nquXNWLKvPpa0gRlvI
 LPZA==
X-Gm-Message-State: AOAM530Yyoj2a9drq1/UqIewN45OxOBVZKmpytmJQcdWwW9+b1h8MEsk
 ncnum+s/JyCJKypXlAoEBTbnwGOIXGESCYEKF4C27vZePCStZUunhKWM6RQlDSXHHpsSIGxBRCL
 jf37naO0TRJyuvv4=
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr3138784wmh.129.1595930967308; 
 Tue, 28 Jul 2020 03:09:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBky3N1fiOwAUAbRDwFfDOzU+3zWFKcPh/zvwPQji/U4MbFglqtL0NILX0yFEK52pUUrByrA==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr3138766wmh.129.1595930967114; 
 Tue, 28 Jul 2020 03:09:27 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id t202sm3475876wmt.20.2020.07.28.03.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:09:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
Date: Tue, 28 Jul 2020 12:09:25 +0200
Message-Id: <20200728100925.10454-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:05:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CONFIG_XEN is generated by configure and stored in "config-target.h",
which is (obviously) only include for target-specific objects.
This is a problem for target-agnostic objects as CONFIG_XEN is never
defined and xen_enabled() is always inlined as 'false'.

Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
when we don't know to force the call of the non-inlined function,
returning the xen_allowed boolean.

Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
Reported-by: Paul Durrant <pdurrant@amazon.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/xen.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 1ca292715e..385a1fa2bf 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -8,7 +8,15 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
-#ifdef CONFIG_XEN
+#ifdef NEED_CPU_H
+# ifdef CONFIG_XEN
+#  define CONFIG_XEN_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_XEN_IS_POSSIBLE
+#endif
+
+#ifdef CONFIG_XEN_IS_POSSIBLE
 
 bool xen_enabled(void);
 
@@ -18,7 +26,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 #endif
 
-#else /* !CONFIG_XEN */
+#else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
 #ifndef CONFIG_USER_ONLY
@@ -33,6 +41,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 }
 #endif
 
-#endif /* CONFIG_XEN */
+#endif /* CONFIG_XEN_IS_POSSIBLE */
 
 #endif
-- 
2.21.3


