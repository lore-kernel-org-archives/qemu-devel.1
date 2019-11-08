Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A46FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DD32067B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Phez6cVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DD32067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTAGl-0001XY-OC
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iTAFC-00009k-5G
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iTAFB-000642-6b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:30 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iTAFB-00063b-0n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:29 -0500
Received: by mail-pf1-x443.google.com with SMTP id c184so5346683pfb.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=5agNHd9M2bORCVbIGO//JZMZDNyfUZl1bBgI5l6KvTQ=;
 b=Phez6cVAOAk6qvA3brvUjT0QhoQeK19ixiY6E8EHjShNInxaUAUxVga9N8f+ahKnB4
 eZUDjKYVzlgD4hVBUQBW42rgQ7tfX2VLAWVm8gj+M3+9lUr0X+auUBHf+nwNOZKFOr2S
 TNBLth0FYYYnT5toF+rM/dDsjb5kJdepUsN8lZYHCtXWxWd2+NdyZuPc5/OviT1lWMn/
 0xEge9o7YRi/M7szla8/Qh/VvkaEOAtMewPqwyx/83iGRbuxImvjt8/edortm2heLP43
 +MtOo6YPuRppc53pDpXMd+SglAST0/IGjZOOpkTNbFhfdI3uSJ+p/w+9/75c2wDvA/Lx
 MRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=5agNHd9M2bORCVbIGO//JZMZDNyfUZl1bBgI5l6KvTQ=;
 b=nTP3caUhiUVmZyMp7K+jdF3HPiF/Eo0h0uZXgodVLQagrsMzznYQQNJQHWQb6+8Vfg
 ySaCuDev69e3r962iK2xmM2jDEJvCMEnOOSkF5Yv/Dv9FH+HylCU1jdM7wTrGab73EvN
 A9luJr3HqxA7Z5Gs1rrPShrjTuhwqwhCRhmSFfMKJEYBK0zmIK3Bc8UCW7AFq5jYi+q0
 drqAQUsMA2HwtYj430TwS5fYgM6Gs1MxTeayx2KfWmoxCOkdTLPVmFYwyr9UNsk8vewp
 Vq6WOaTxyrjn6uB+wyFmL+AWV6rh48tIwuyozw5irCuhNy8JNL/OjZWv9TU5EX2+wsv3
 nJag==
X-Gm-Message-State: APjAAAVLzhGZtt0aipbx15mM3493Du4o7CHzAb9PUT7ECwj2/H2FQfJ1
 +Sx8xItxTX039MXCv6A1gK0A+w==
X-Google-Smtp-Source: APXvYqx89ckaICmNEcPymnIaPzw/La0DkOPJLAUZIE+RBy/lpguEOtXGyUt3wXoJKDiajjs6+Ikk0A==
X-Received: by 2002:a63:7887:: with SMTP id
 t129mr13976804pgc.144.1573242507720; 
 Fri, 08 Nov 2019 11:48:27 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r68sm7456977pfr.78.2019.11.08.11.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 11:48:26 -0800 (PST)
Subject: [PATCH v2 2/3] ARM/virt: Use fdt_setprop_strings()
Date: Fri,  8 Nov 2019 11:47:57 -0800
Message-Id: <20191108194758.17813-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191108194758.17813-1-palmer@dabbelt.com>
References: <20191108194758.17813-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new helper function encodes the idiom used by the ARM virt board to
set a string array.  I don't currently have a working ARM userspace, so I haven't tested
this, but I made the helper function because I wanted to use it for the
RISC-V virt board where I have tested it.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 hw/arm/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc2607..4dc00f54d5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -304,9 +304,8 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
-        const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
-        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
-                         compat, sizeof(compat));
+        qemu_fdt_setprop_strings(vms->fdt, "/timer", "compatible",
+                                 "arm,armv8-timer\0arm,armv7-timer\0");
     } else {
         qemu_fdt_setprop_string(vms->fdt, "/timer", "compatible",
                                 "arm,armv7-timer");
-- 
2.21.0


