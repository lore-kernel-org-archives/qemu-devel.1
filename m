Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10280C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C7D2223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ1Moud5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C7D2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpgS-00070n-Ce
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpeT-0005yw-5y
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpeR-0000IR-IM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603192678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWEbSFnTLkseVlOjOLaK6om3VaPCN0vE+qGHKWT8qrg=;
 b=YJ1Moud5lXbUvEX4jYpLzQ09/yiqlUN100tGRSBvl3+VBunWi7N6TCvwKpTCeYnBP+3vvb
 urFzZiymFcBuwaR9T9rgV3IJGRHunzG76XKjMzmh5rWRG0rdonf72+aZTTa6cbuHLahpzg
 WGUzXPkCP9tVySWE2Cgv9CKNqj4295Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-m6qEDjzZOX2SfKge4RrfMw-1; Tue, 20 Oct 2020 07:17:57 -0400
X-MC-Unique: m6qEDjzZOX2SfKge4RrfMw-1
Received: by mail-wm1-f70.google.com with SMTP id f191so283671wmf.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oWEbSFnTLkseVlOjOLaK6om3VaPCN0vE+qGHKWT8qrg=;
 b=orlpCnmVcDQ+nuSb9zluPYxX5MhI/AjkIfd6s1ogDtuhaHvGGibY/Kka4GXpknvPK3
 Jv99jOi3z7emziHyE7OdDz4Ieh0SaHfy99/pMuTqmL2wn4SfzDYHuD0fT17AtfDJjOET
 HnvV1fhf+yebOLTvlEy+DlGqG4B8XjmYmZtQxUEay0moUvaa8uiuNdlqDqZpsPJ4V5m8
 qhM/0n/LV3eSK6LVU/fZvOzQbzwt5zDKUWKbiVAeKkGs8Jrj4HTMpSnUAcCBCajcQCym
 On/Oy10mHL8gibJBdOa/dRtwZ6ysp2pUJs+FZHRgfq0+EJs8Pt2xv5RdAXM1Sytm8rHs
 jHfg==
X-Gm-Message-State: AOAM531PxRd0LpLzTmoZvozPBHwAJnUmTCIes1t3xaVHLZrX/n6ivwzt
 hSKHbxzgIdmb2dlbCA2CVjE+9VUrgiTfn4hTeCx8JKkCe3VIdn+gU6HSVL4cifLJClV0r1MGZEA
 Wx4TPwVx1hmj4ohc=
X-Received: by 2002:a7b:c3d3:: with SMTP id t19mr710645wmj.139.1603192676015; 
 Tue, 20 Oct 2020 04:17:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR07YGqsZwzjUp+0JV69TIFhP+WUrJ+X+m+Gq/NfjN6XQhUYHY9OViC5hwKA+osKwlgG7Ulg==
X-Received: by 2002:a7b:c3d3:: with SMTP id t19mr710632wmj.139.1603192675868; 
 Tue, 20 Oct 2020 04:17:55 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q8sm2510936wro.32.2020.10.20.04.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 04:17:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 2/2] util/oslib: Assert qemu_try_memalign() alignment is a
 power of 2
Date: Tue, 20 Oct 2020 13:17:43 +0200
Message-Id: <20201020111743.2074694-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020111743.2074694-1-philmd@redhat.com>
References: <20201020111743.2074694-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_try_memalign() expects a power of 2 alignment:

- posix_memalign(3):

  The address of the allocated memory will be a multiple of alignment,
  which must be a power of two and a multiple of sizeof(void *).

- _aligned_malloc()

  The alignment value, which must be an integer power of 2.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/oslib-posix.c | 3 +++
 util/oslib-win32.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f15234b5c03..9d6451f9239 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -200,6 +200,9 @@ void *qemu_try_memalign(size_t alignment, size_t size)
 
     if (alignment < sizeof(void*)) {
         alignment = sizeof(void*);
+    } else {
+        g_assert(QEMU_IS_ALIGNED(alignment, sizeof(void *)));
+        g_assert(is_power_of_2(alignment));
     }
 
 #if defined(CONFIG_POSIX_MEMALIGN)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 29dd05d59d7..72e4ee910ce 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -58,6 +58,7 @@ void *qemu_try_memalign(size_t alignment, size_t size)
     void *ptr;
 
     g_assert(size != 0);
+    g_assert(is_power_of_2(alignment));
     ptr = _aligned_malloc(alignment, size);
     trace_qemu_memalign(alignment, size, ptr);
     return ptr;
-- 
2.26.2


