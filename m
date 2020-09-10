Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C437C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF6D21941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgZOGZh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF6D21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNBA-0005zC-9B
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGN6U-0001db-St
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:59:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGN6S-0003t4-MI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599746347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZoFYGRmakF5g5oQA1REcNZ0QsgbkYiu/M6HpT8wcTwo=;
 b=QgZOGZh+necEm2rvQ2yrX6TbR51UkqSFsDAp4mk4fkNZAKbBKyxNGpfClT7UfShk3+phqc
 yiRpEKCp0gjbOFfXVSgwgtXUV9jcJ/ygqAc7h2arbSLuh+XUQkP70uF9wEm/IxtVMOusHg
 cC3Z7okduE1w0+UuhH1Xu4+Oi2A312U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-fX9lGT51NSWjmyux4bxgqQ-1; Thu, 10 Sep 2020 09:59:05 -0400
X-MC-Unique: fX9lGT51NSWjmyux4bxgqQ-1
Received: by mail-wm1-f72.google.com with SMTP id d22so35121wmd.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZoFYGRmakF5g5oQA1REcNZ0QsgbkYiu/M6HpT8wcTwo=;
 b=ZEYFcHtpq4rInNWtEHOsolV4Ll2bv3ZlFHg4s/pvcFnoG91Wp6Rtfcm6WMQQXgDz6b
 gxKdGVc3c+XbK3UxU4tKNF8p3ZBxjJ1V683AGePpLJpnV21IlkxCL7jgDASXbdGqcq80
 6A1bXmPQMW2sKe3An8EQzEn8CcWF8i8ejLsyY8kc/yhb0y2ztI7UlEC/O572/4Ga4tNO
 244xV6mTbG6apkQuVSxwZYni0NRUjTZucJf45A96LJQKqVV+evvaqymq5AJZlkQ5+YK3
 N1wDZYv+9JQq7ZsZqWmMg5bEfr2BhJvbDJx0Rcsn+LlWEzaUrcoupB3yxMWmNS2bjX0V
 CcUw==
X-Gm-Message-State: AOAM532Htqk66gW1a/ibVNBOBB3t8q+jXVmF/1TLxCNcRawJeaf3awYE
 WZsMccZjmIUwCYCJIxpu8oRgMsA+fZIwTCfYBo0LbpJaJq6r7baUYtyNbcEWMVf/EI/2giwZqQ4
 Ozx/8WpVjQ5HQJ5s=
X-Received: by 2002:a5d:634d:: with SMTP id b13mr9430872wrw.324.1599746344464; 
 Thu, 10 Sep 2020 06:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy6RIhL+x/0FP0Y9VjyGYMw3xGiuSxmmhaKbxe8cBobjfShD25xqqCwP6BM5Yq37IhOZALSQ==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr9430848wrw.324.1599746344288; 
 Thu, 10 Sep 2020 06:59:04 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q20sm3640924wmj.5.2020.09.10.06.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:59:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/timer/hpet: Fix DPRINTF format string
Date: Thu, 10 Sep 2020 15:58:52 +0200
Message-Id: <20200910135852.516809-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910135852.516809-1-philmd@redhat.com>
References: <20200910135852.516809-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Dov Murik <dovmurik@linux.vnet.ibm.com>,
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/timer/hpet.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index b683f64f1d3..20bd0388740 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -495,7 +495,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;
 
-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
+    DPRINTF("qemu: Enter hpet_ram_writel at %#" HWADDR_PRIx " = %#"PRIx64"\n",
+            addr, value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -637,7 +638,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64 "\n",
+            DPRINTF("qemu: HPET counter written. ctr = %#"
+                    PRIx64 " -> %#" PRIx64 "\n",
                     value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
@@ -646,7 +648,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %" PRIx64 "\n",
+            DPRINTF("qemu: HPET counter + 4 written. ctr = %#"
+                    PRIx64 " -> %#" PRIx64 "\n",
                     value, s->hpet_counter);
             break;
         default:
-- 
2.26.2


