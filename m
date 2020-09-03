Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C07C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE522071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RepqCBh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE522071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpag-0003vv-D4
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDpYJ-0008Rf-6f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDpYH-0001F6-Gk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599140720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+YUUeHxvSt9jEklOFUg4RIRBjPJnNhhCKhpJOO59Oy0=;
 b=RepqCBh8KPUr+pamnhm14VBS26oRosG9Naqah9ospB0idL7iklsoRn171Wv6iGZ4Eb9rjn
 Nz6dxvH/8MKqiboSzJQXke6lXWfnaWeSt9dzIVTI6/nWFaSpdBupD6FMTcCpeHZduu7ZnY
 1r50sag0VCCP8Xfjcvoco49uFWUg6lM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-mfvMDoM5O3aN1dtqqBEqjQ-1; Thu, 03 Sep 2020 09:45:19 -0400
X-MC-Unique: mfvMDoM5O3aN1dtqqBEqjQ-1
Received: by mail-wm1-f72.google.com with SMTP id b14so989257wmj.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+YUUeHxvSt9jEklOFUg4RIRBjPJnNhhCKhpJOO59Oy0=;
 b=jKjxUrlJkMv6uUwqiRwLr0OyeJHer4+nFWY9FhGQIQaHrTiZ8KXBpFHohPU/eArzTY
 wb//39sah/8WKXMgqw0x50y5H/pl+SHLN6CaMAsxOQUrhlBqXTf+5aFEqUV0hh9wR15A
 gzjIWBgALi/al6MCKFfQNRhgoYrpsJZnQNLE9Lh520o3f6uzKGK1xk40iQubw8wPdHzb
 KmpDauwZDgmsdrrbo94nriFum9vvt1XfhhYnfBmQVHrC2/T0V0BISQtinBj9/MvsOZyi
 wbsxxA69PEywaag18R9Jh4ArNDw/oINzol8SEnfHJf2sQuNhSuDEmXBYmmul3eaX8O0d
 5jYw==
X-Gm-Message-State: AOAM531PY64TwPxZOR00zwExvjHq+inMB18W0AGPQhbBYoaFM2/Qw1iM
 ELQ7yXXso17LIvPWHfv4ZC/Nq6UerOnhg9hIYKh6V4vb9JlZTL08IO/rbA3xyQcIgt6sWuC1+iF
 mSUgWctaqEDLDzLU=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr2688402wrl.419.1599140718160; 
 Thu, 03 Sep 2020 06:45:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz96avQHw1qZ0wMhowdR4rn+BD2EEJsYAj6f04bkCr/VLxYQWgXqOoKV6BpEHsLzXKeBnnSRA==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr2688384wrl.419.1599140717997; 
 Thu, 03 Sep 2020 06:45:17 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v9sm4335201wru.37.2020.09.03.06.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 06:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/timer/hpet: Fix DPRINTF format string
Date: Thu,  3 Sep 2020 15:45:06 +0200
Message-Id: <20200903134506.440082-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903134506.440082-1-philmd@redhat.com>
References: <20200903134506.440082-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix building with HPET_DEBUG enabled:

  hw/timer/hpet.c:512:73: error: format specifies type 'unsigned int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Werror,-Wformat]
      DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
                                                            ~~~           ^~~~~
                                                            %#lx
  hw/timer/hpet.c:655:21: error: format specifies type 'unsigned int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Werror,-Wformat]
                      value, s->hpet_counter);
                      ^~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Keep trace-events conversion as ByteSizeTask.
---
 hw/timer/hpet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index b683f64f1d3..8115e42cff3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -495,7 +495,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;
 
-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
+    DPRINTF("qemu: Enter hpet_ram_writel at 0x%" HWADDR_PRIx " = 0x%#"PRIx64"\n", addr, value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -637,7 +637,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64 "\n",
+            DPRINTF("qemu: HPET counter written. ctr = %#" PRIx64 " -> %" PRIx64 "\n",
                     value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
@@ -646,7 +646,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %" PRIx64 "\n",
+            DPRINTF("qemu: HPET counter + 4 written. ctr = %#" PRIx64 " -> %" PRIx64 "\n",
                     value, s->hpet_counter);
             break;
         default:
-- 
2.26.2


