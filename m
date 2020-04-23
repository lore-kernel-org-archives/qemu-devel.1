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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B02FC55192
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C1E20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvLz5bKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C1E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRaij-0003TM-5s
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahN-00024X-Cj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahN-00085v-2F
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:21 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jRahM-00085N-LE; Thu, 23 Apr 2020 08:11:20 -0400
Received: by mail-lj1-x244.google.com with SMTP id n6so5907840ljg.12;
 Thu, 23 Apr 2020 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YVkWkfMLZqJjeUY/UkhC2JqEDudQAewY227aecSIcQA=;
 b=QvLz5bKfJ7ZkPBA+xQ7RXcsCxhiu4FopAVwgqaytywA6rFfM/yIE2GWFQysTQ6Mzdy
 vO83kZjsNAGSEtdAPl9QlrVGPM0kj/igm2rKRavryTRUhi0UCbKRHZmxiUcinVxBRxpm
 bLuq9wbDeJPysVu3kH9VBTOl5QuKi4wVOfYzJcOW/rXLvNqJrzr95jNJZwdYmU5rED2/
 o/VdAaPW6H98n6E9S+/2aRGSIUTu7BjzsZYya39dgJGnvfb44E4MOYnkwd76TO+E3PS6
 HvoV99sD7KR9vOI0nNu5Mm8t/nxs3E+6cEx4oDMiRVKztJEYiMKv0rsULccDcT2XRFHH
 ZJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YVkWkfMLZqJjeUY/UkhC2JqEDudQAewY227aecSIcQA=;
 b=oiFULWgTHNoZRvAlLsQgEaVmb/zL0d6npdAo44hiF3SOelsKiMlqRv6zlZy0WicRlg
 acl1gnkN815i2ee1nYTOeB4mWdYGD+lGvfTduRuCkrQL1rodfvCWg+9jwEY2JUzgewqW
 kw7vboLSprWXJTNA1aBofN+vml8yAr9xXK4nmveE47O5APIJw7b2NzJIGeqhrzFMOoO7
 taLc5W+TEgXu1pqEnLfscSPcn8ENC35RWtI0rvfHBlt+wKQ9U/eRSa7NID3loh+LPgbK
 FdM8BZ3IaM7z6anNd5NSCmddJfHBn/ytYngdoXkGeML2O4lN/AhjAwBQn6Ajdx0Bd40N
 y4ew==
X-Gm-Message-State: AGi0PubuABfx/P5yrovNEQhnGdIX7yJWLoSfiGi551YwvBUaag+MxCF4
 l0D1xomalNKq8x5N/2tP7X6NV6BtQNw=
X-Google-Smtp-Source: APiQypIh9NOVYzeM7sOit40n1f7NfeU4n6dh/ES7KCsUtfdnn5nkqeoJ29ru76R1FBx/nbvCdfNtDg==
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr526774ljn.148.1587643876676; 
 Thu, 23 Apr 2020 05:11:16 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u21sm1639447ljo.61.2020.04.23.05.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:11:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] device_tree: Allow name wildcards in
 qemu_fdt_node_path()
Date: Thu, 23 Apr 2020 14:11:11 +0200
Message-Id: <20200423121114.4274-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423121114.4274-1-edgar.iglesias@gmail.com>
References: <20200423121114.4274-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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

Allow name wildcards in qemu_fdt_node_path(). This is useful
to find all nodes with a given compatibility string.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 device_tree.c                | 2 +-
 include/sysemu/device_tree.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index bba6cc2164..f5b4699aed 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -308,7 +308,7 @@ char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
             offset = len;
             break;
         }
-        if (!strcmp(iter_name, name)) {
+        if (!name || !strcmp(iter_name, name)) {
             char *path;
 
             path = g_malloc(path_len);
diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index c16fd69bc0..7c53ef7634 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -39,6 +39,9 @@ void *load_device_tree_from_sysfs(void);
  * NULL. If there is no error but no matching node was found, the
  * returned array contains a single element equal to NULL. If an error
  * was encountered when parsing the blob, the function returns NULL
+ *
+ * @name may be NULL to wildcard names and only match compatibility
+ * strings.
  */
 char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
                           Error **errp);
-- 
2.20.1


