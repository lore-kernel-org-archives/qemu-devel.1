Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A0C55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBF220857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maMZOWCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBF220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRajz-0005V4-Vo
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahN-00024Z-Ng
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahN-000860-1v
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:21 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:32994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jRahM-00085T-Ld; Thu, 23 Apr 2020 08:11:20 -0400
Received: by mail-lj1-x242.google.com with SMTP id w20so5972078ljj.0;
 Thu, 23 Apr 2020 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ibni5GBdJPCYUbCK4oOU2/vhcP6N08qmypiQakNxh54=;
 b=maMZOWCoIqBkYRUPD5dLj7xFGvvrl7FK/OxkIwMNGmlNMi8fN1MqIuocIYDCpBNZfR
 j6IxkcFPjFtVD1ComvfYd2bRGR4fUqiRPmCztRcP4wWifCR/cGuCodFSXXa1Mq9wkbdu
 hPzqRwc//Jcmo8iO3MHuTLk65Zd2f/DyWe0bGMxucYj+M8QyuMB/qGXyC/M8E6kmXZ5M
 Xwj1XZWbUcvzyxeqWw31YbWYde4px4io1ZrRHg2Qcr3hsMMx8IO//A8bBzlV/LDcxtlX
 KPTmPDW1SZtqfDYbg+abW5Br0zIy/VGBwfcPfEuw5aD2kBThCF8dt1ZdO7Iswv1OP0AO
 tOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ibni5GBdJPCYUbCK4oOU2/vhcP6N08qmypiQakNxh54=;
 b=C1GRmo2aWgQ1mWtShMHE4acp9WMLTlITduDyAS6s68HPW/hl9o4Dm3cr4io2Sphe+A
 NvgfQ+HIPesgEBucAfZPQaScN/6kWhiu3pVk0ldUg4spKNDLD/8rtwZ0Kn2KXeETVcD6
 HiY3O3rMhDFAJNBF5UJ8txX6EBLSukzcvUdPgvRq2gh7TsUYLqZxh1oXp5ZDV/jT3o7R
 Rd/xZS3yPRyVQAmKKsH595mbSmbFzJX1Z6bLetPrmfxoNOB46G3XBwqnwf41InfwX4Rh
 x9ZHZ4bIJcBHH4kG+PjAVOBWzkknShcYiMZfUvquoX8gOu20pF0O2fWSZD+JNMl0IKeb
 sNTQ==
X-Gm-Message-State: AGi0PuZ0ZytciDh3IUjafTZ8LLZT8emmetNBVyyvdPZ+4qzUakZ+AEa/
 Lg+8fMe8NEyd0nikLx/F82JeK0fnZ3w=
X-Google-Smtp-Source: APiQypL0MmbVPn6xBaga799KZscPvt93J+PDxtO/MNAnxzl6bng6v7dYp/TttLGASor6QNSLQZDyTQ==
X-Received: by 2002:a2e:8693:: with SMTP id l19mr2159005lji.63.1587643878038; 
 Thu, 23 Apr 2020 05:11:18 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b73sm1708175lfg.86.2020.04.23.05.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:11:17 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] device_tree: Constify compat in qemu_fdt_node_path()
Date: Thu, 23 Apr 2020 14:11:12 +0200
Message-Id: <20200423121114.4274-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423121114.4274-1-edgar.iglesias@gmail.com>
References: <20200423121114.4274-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Make compat in qemu_fdt_node_path() const char *.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 device_tree.c                | 2 +-
 include/sysemu/device_tree.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/device_tree.c b/device_tree.c
index f5b4699aed..b335dae707 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -291,7 +291,7 @@ char **qemu_fdt_node_unit_path(void *fdt, const char *name, Error **errp)
     return path_array;
 }
 
-char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
+char **qemu_fdt_node_path(void *fdt, const char *name, const char *compat,
                           Error **errp)
 {
     int offset, len, ret;
diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index 7c53ef7634..982c89345f 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -43,7 +43,7 @@ void *load_device_tree_from_sysfs(void);
  * @name may be NULL to wildcard names and only match compatibility
  * strings.
  */
-char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
+char **qemu_fdt_node_path(void *fdt, const char *name, const char *compat,
                           Error **errp);
 
 /**
-- 
2.20.1


