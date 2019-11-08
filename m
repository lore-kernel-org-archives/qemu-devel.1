Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04EAFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F09D2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="pi7fIL92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F09D2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTAGj-0001W2-Bo
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iTAFA-000092-Rb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iTAF9-00060u-N1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:28 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iTAF9-0005zZ-H1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:27 -0500
Received: by mail-pg1-x543.google.com with SMTP id h27so4630382pgn.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=9MuKvPi+Vd4vUU4gqbdXcIHJqwKNnvJAqsIK6Fo7Ucc=;
 b=pi7fIL923oWWgDW4NPnQr/eftyTVeXcfwmZIwygNlZzAU9KU4roZv2++952mIomA2A
 aIf0ihpR6GsxlgDp3WbhP3DMao2VHHieH8F1TJfYCS145O6Q/LnbmrdttZPUkm0Rva7S
 DXwD9uGEwkdY70/o6rNq6GiprPPjNnjeU66Afl3J7IFfUKV1U22N54TOqkA1NtM+m5R7
 RIAvi1sQG+hmoWN09m+rdkaeCbMn7IMCqZ9pdNtTF4h3aL257z9sANMewLU/RihQDOz6
 uJM7n8jBG9OAA9VmElcrAiRrqH/coQ3u9xcdFs4v17kWX/w5zaxmYmgzZMQsWF0jp8hc
 hboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=9MuKvPi+Vd4vUU4gqbdXcIHJqwKNnvJAqsIK6Fo7Ucc=;
 b=ZWIpiHVfMgK0aaps2KVrOJ/rvvyyZgzyldpQuO8V9/nV02miSO0PEBPJ0FCRrcGc3B
 O6QSb7Gi/pG/y4C8BxM/9ArL8gWf9LEtrxsWTHje+z+r1WopOxPNK8AXounYOo5g8n4f
 v3iVbZ9WZYg/REy3HzsBDTZlnUAWeUKT0KSA+YJKqKRbelgkPEcM7udq6l0SR2knG7HK
 LPYrtRNsaBHaoM0TeJkDUL0nhhf4UvbWdF/D42Z2JB+3brL3ejewUPpgC+EyPr5U1uYf
 +BsNNA9jMz7omqEqZF3bNUbAxi7gPiglZAYHW9LlPCHGG1X4PzGb7Fmeqmg0jOecMZQo
 Eexw==
X-Gm-Message-State: APjAAAUw++TKJ/RWLboLh0fBAWCDhvjAKik006cxAyRo92VyCI3SDPZf
 +kpwKW6Of9Phe6fX7+cPxKLUEipZ44M=
X-Google-Smtp-Source: APXvYqye9hkQzVWrvzFfvnjgCHDEpcWJPAIWeA2Fh2TraED35OgiTF3LQL4UzzHFLXFTLDyOEky3hA==
X-Received: by 2002:a63:e26:: with SMTP id d38mr8265069pgl.44.1573242506131;
 Fri, 08 Nov 2019 11:48:26 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id y24sm8053861pfr.116.2019.11.08.11.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 11:48:25 -0800 (PST)
Subject: [PATCH v2 1/3] device_tree: Add a helper function for string arrays
Date: Fri,  8 Nov 2019 11:47:56 -0800
Message-Id: <20191108194758.17813-2-palmer@dabbelt.com>
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
X-Received-From: 2607:f8b0:4864:20::543
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

The device tree format allows for arrays of strings, which are encoded
with '\0's inside regular strings.  These are ugly to represent in C, so
the helper function represents them as strings with internal '\0's that
are terminated with a double '\0'.  In other words, the array
["string1", "string2"] is represeted as "string1\0string2\0".

The DTB generated by this function is accepted by DTC and produces an
array of strings, but I can't find any explicit line in the DT
specification that defines how these are encoded.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 device_tree.c                | 17 +++++++++++++++++
 include/sysemu/device_tree.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/device_tree.c b/device_tree.c
index f8b46b3c73..b4379f13a7 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -397,6 +397,23 @@ int qemu_fdt_setprop_string(void *fdt, const char *node_path,
     return r;
 }
 
+static size_t stringarr_length(const char *strings)
+{
+    size_t count = 1;
+    while (strings[count - 1] != '\0' || strings[count] != '\0') {
+        count++;
+    }
+    return count;
+}
+
+int qemu_fdt_setprop_strings(void *fdt, const char *node_path,
+                            const char *property, const char *strings)
+{
+    size_t length = stringarr_length(strings);
+    return qemu_fdt_setprop(fdt, node_path, property, strings, length);
+}
+
+
 const void *qemu_fdt_getprop(void *fdt, const char *node_path,
                              const char *property, int *lenp, Error **errp)
 {
diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index c16fd69bc0..d43c07128e 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -70,6 +70,12 @@ int qemu_fdt_setprop_string(void *fdt, const char *node_path,
 int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
                              const char *property,
                              const char *target_node_path);
+/*
+ * This uses a particularly odd encoding: "strings" is a list of strings that
+ * must be terminated by two back-to-back '\0' characters.
+ */
+int qemu_fdt_setprop_strings(void *fdt, const char *node_path,
+                             const char *property, const char *strings);
 /**
  * qemu_fdt_getprop: retrieve the value of a given property
  * @fdt: pointer to the device tree blob
-- 
2.21.0


