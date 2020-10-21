Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1875AC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EE32225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/cCOY9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EE32225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIRq-0000IP-OI
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVI4A-0006sX-J4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVI48-0006We-E6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603301898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMGo54MOAQhEJMWck8zBqfGUrL7xPSbuYgDgiKKm1lI=;
 b=c/cCOY9utAh6TUbIW/K9CMRy3XDo3jKznZx11bYQ4GNImM52PtndpAmrVPxtUL3vlIlzmM
 d1Q1bbS5cZfWrpAQC2+uM8gJql0vxbb7nLEjSgPX7RZYVKxaDX7/nSbkGR1coC/BOwdaLd
 XyoNrmE4SVoFOfpdwQH/YqrH25qLyJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-vQrX_7i2MQi-wwtQI8OLHw-1; Wed, 21 Oct 2020 13:38:16 -0400
X-MC-Unique: vQrX_7i2MQi-wwtQI8OLHw-1
Received: by mail-wm1-f71.google.com with SMTP id 13so1887350wmf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WMGo54MOAQhEJMWck8zBqfGUrL7xPSbuYgDgiKKm1lI=;
 b=Rgw5Ik6yPyd4nBmKGEbpqgLAP9keonNS/dFbl/Bb7oVOWpr1nnPHe9CRhRjZu5eoPS
 KcsuGfSW6pnc44wNx9ycrTkGdaBNv7LGYDUxLVSfSdZIjI0xhjk+4elnAfkfdDVKQ/72
 p69PZxL8Qr4pGzEK62MuBhtDzHGoSmmbciIrr4eUI49dsh/lNgGd66u9LMeNnF1ToDdj
 w+LVfwNXk20q8VbtXCa9o54F2j7J22p118ZckKc4qA3FCkx8xjEIazsUqwe4H4rFcfmY
 IdwCTjxEiMSG6iGzzoSLKkkIPiJTeQ/4KTTV7k+hI1PUozQXOHx8H5mnNi9j+TLaoliP
 21DA==
X-Gm-Message-State: AOAM531Zwpg1D6yC2vNatokj9yXyDRbrLWLJqoyLTY1dkuqeg8fFRVYL
 KLBkxtoVrQnqqoYhAI2bJiEajgIq4qDgG+Hi/JFv7gqjZ61zs+Glbe4mEpn0++y8FNIXJfmbi+2
 2rinxMEnH5X7axis=
X-Received: by 2002:adf:bbcb:: with SMTP id z11mr5960172wrg.130.1603301895420; 
 Wed, 21 Oct 2020 10:38:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqWwaPMFs9HY/4pT1v+LVeU18l21LHFTPFgJ+N9JgO19NPb9P7gX+ExBtD/x7p9gOZ+Qy8Qw==
X-Received: by 2002:adf:bbcb:: with SMTP id z11mr5960158wrg.130.1603301895246; 
 Wed, 21 Oct 2020 10:38:15 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o5sm4650076wrw.76.2020.10.21.10.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 2/2] util/oslib: Assert qemu_try_memalign() alignment is a
 power of 2
Date: Wed, 21 Oct 2020 19:38:03 +0200
Message-Id: <20201021173803.2619054-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173803.2619054-1-philmd@redhat.com>
References: <20201021173803.2619054-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 util/oslib-posix.c | 2 ++
 util/oslib-win32.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f15234b5c03..3e022d7206b 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -200,6 +200,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
 
     if (alignment < sizeof(void*)) {
         alignment = sizeof(void*);
+    } else {
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


