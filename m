Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A62C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB83206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9CgGqvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB83206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpY9-0001pc-Md
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUW-0005jT-Ch
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUT-000402-Sn
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 13so3506162wmf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RW2H8oOxjZLyAyqn7EI7Rl9/hR5wbT5g58TjqEuFX28=;
 b=a9CgGqvKUbFo56Ittlchy0f++wNEtM2khS+JodrFtyz00pI+lxJO7cZ+8YhBvW/GC/
 Wt2ghKZebErQSXj6ke8Y57LYtUNmvW3G2g0A0zSMNF2yjvxxLQ99Eepd+T92Dq/iU/0r
 QSyTAxd2FPVdoxfz4YSWHuFY77qg6VQdUSGuGWTRVePtdAukZRgCqsi0//lDuSg/QeRF
 ftFEcipkxMh7N/nIepO+VoNG2AoGYGFGL4oKeLIl8PJblFzAVXXxVUfAtPzU2SXr76q+
 qWwAmk7F5/OqI8YiysEXE7ASd6TOLhyrdpSRLLY0LGI3vXRiM4WF/nZEsOG8JoL4Oxs7
 y3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RW2H8oOxjZLyAyqn7EI7Rl9/hR5wbT5g58TjqEuFX28=;
 b=tu7xw97tU0sQ/LhIYgVTeETSC18F7K+xeIWQBFWg/OManzty1nzuujjlORXhzpgsd9
 n46NDV1qrgDp9B22I/X2R3N83iLUsnIgu1ic3XkuIm3WYtSKQlK2qXxF65q8l3H0SdfR
 Mtcg1e5llaEHXdjU/wAThOSbyFdY5jjAhGdkrnOvvqvl74sJdoqCzkSwuy/zd3febXmv
 IfmKsHhooqyn0UnSpHFLTPsZDJ+u8JJKkA/Ow3Bq5kuRn2XyqoYF5tA4A125zIycwXTb
 JysRMxbhdjw16VBBEH/QeBZeh3phlYPCGeEslPQ4rmUVYittT4IG6VkXdxFsu5P60s+w
 W4ng==
X-Gm-Message-State: AOAM531h3j5VL3nKiUN24mC6mvPvFVKBhAU1IS+4DOwk/agZWvvlzfgC
 n6/hWBD1IkFos7kVnzlyqKQ=
X-Google-Smtp-Source: ABdhPJyL6Jr1TRMDFgyA0HY5UW735Ah9QXS9DasRyjrPLfLkYyW3YQPpXAtOzkqOOyzvVemNshpFSA==
X-Received: by 2002:a05:600c:230a:: with SMTP id
 10mr5800026wmo.151.1602000420469; 
 Tue, 06 Oct 2020 09:07:00 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:06:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 04/12] contrib/gitdm: Add ByteDance to the domain map
Date: Tue,  6 Oct 2020 18:06:45 +0200
Message-Id: <20201006160653.2391972-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Acked-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index a4102154b6..ae5d149434 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -6,6 +6,7 @@
 
 amd.com         AMD
 baidu.com       Baidu
+bytedance.com   ByteDance
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
-- 
2.26.2


