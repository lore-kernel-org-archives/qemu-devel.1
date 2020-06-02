Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA63CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96874207D8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPl2hDcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96874207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Az-0000S5-Tj
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97X-0003W1-80
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97W-0007cm-C8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so3930874wru.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSCo20FpmcSa9pqRC9AwXDY8+utkLNtj0/ksS5sWNSA=;
 b=CPl2hDcBqDkH8YckenHJHDWIKS2aLw0vI3NKfQGRwbEkNP1HZQG78k8XORGUwMWHgi
 fG9OEsGzpY2BWMW/2Z+boNgBwi5De/OAlQxlHH7alUoZXu6w6JJesZh+1I0yZtAq/P34
 hhkHl3PsPxgj2+OIwwJl7zu4xprDwaLGn7Q0ymUYdgJTiX4LvczRb33ydePABlkcGC0d
 wGx67xXUXGZVss4x+btdUUGq7iQhB2O4BfCaUJ6Eoz8JIgm4+qoSqZVFU8eqj3DRlC7O
 s0lhH1hDMK1n6d4IVeCu54rq2jV0zUM+CUr97OeNIbwPvLOz9Zsugm9CDffg3LX09m5f
 Ht8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QSCo20FpmcSa9pqRC9AwXDY8+utkLNtj0/ksS5sWNSA=;
 b=UoQXqp8yMw5P/jLK9mt9oz4j+65v+n/AL0ViGjHkVLJG03vB8L/TDnsGY19ryEQzER
 F/qA/lgGXdO7ZCFvNSJSmhYzG9gju4dm+KjbQMIHqdm80I/22KJ+O6oeJ6kQbr9Or5LD
 awEwT7IrwWMstNF9QHWzASgdzUBkFhQDtZ+rEwwRHewk0wcx3mDLM+Ns0WMm0cLZdRpb
 WwhhDg+BVdz1kovOVzO0Rn2r4GZlML9GZGz6swZbVkpeFYRmpUnybPO1hYVQ+kGiqCSp
 KctNs1J59syHQ2/q2Zvi3fmV/y678TFkdRc1TFAJDXL4HiSNOGtUEuEh9y/69n65MLsL
 Nsxg==
X-Gm-Message-State: AOAM533Np0DNECI9bajZEh859UoTekiqFqp1WMzEWEwPBm0L6lYDtqKD
 x+dRYd7yPns1dB4StlbsmUXnmw==
X-Google-Smtp-Source: ABdhPJySCeji1fTkNCIPcDpNZxe8XdwV6Ty9YuadGok7QwzK3DnDooR53ACTbfDVIIgA5AdY0hyKMA==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr26269887wrp.82.1591112788931; 
 Tue, 02 Jun 2020 08:46:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d17sm5003905wrg.75.2020.06.02.08.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 82B1A1FF8F;
 Tue,  2 Jun 2020 16:46:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/9] scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as
 special header
Date: Tue,  2 Jun 2020 16:46:18 +0100
Message-Id: <20200602154624.4460-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

"qemu/qemu-plugin.h" isn't meant to be include by QEMU codebase,
but by 3rd party plugins that QEMU can use. These plugins can be
built out of QEMU and don't include "qemu/osdep.h".
Mark "qemu/qemu-plugin.h" as a special header that doesn't need
to be cleaned for "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200524215654.13256-1-f4bug@amsat.org>
---
 scripts/clean-includes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index dd938daa3ec..795b3bea318 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -123,6 +123,7 @@ for f in "$@"; do
       ;;
     *include/qemu/osdep.h | \
     *include/qemu/compiler.h | \
+    *include/qemu/qemu-plugin.h | \
     *include/glib-compat.h | \
     *include/sysemu/os-posix.h | \
     *include/sysemu/os-win32.h | \
-- 
2.20.1


