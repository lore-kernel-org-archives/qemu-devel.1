Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E6320878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="M1mJlQv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKAj-0001Ad-23
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 04:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kXK9o-0000le-NT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:16:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kXK9j-0005GI-Ep
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:16:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id h6so344270pgk.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7DT/cN/j3awZPQCHCmSLngV69EvxeQoOdxVv9zA9Ll4=;
 b=M1mJlQv4qRib6wbB29USFALiAoszQQVjj/My4rtP1/pLFU7pQSh3dr0K0FVPkAknJ/
 iMLJAMW/3oZG08h5xoP9iFjJirPkC+oFjvPSZGX/2FcSJKoBKl/B5XhvFXN0Rp7sUgMG
 sY54IOXEMvOUn8q2BA086Ggl/bUm2HSoZmMuRxq7JFZ5FizC4x41QpOsyMaQ6+d+Xfea
 9SUbefOFqeC0R2Ow8S6/xdNduVO8t/kWSGQ4q2Pe5TEIAKFhMs3druXtrvUR1Z9vdMrZ
 klkOhlujIuPOL6RchXNIXOKm7hxTnUXnVXxz4bEzAx1hsQChVB4mfLjAEAqYW6HEbnWc
 unIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7DT/cN/j3awZPQCHCmSLngV69EvxeQoOdxVv9zA9Ll4=;
 b=advYCx0jVw7USI23FF2ntzpuOzZIrlN7KFfstw6bE4Prgu3YxihQYNH4IIvWoib7/s
 Q4ji/1Ws/hb21s4xojdnuNReMvY0Gajos3l2e7hCqsvv17ibmpVQgCr1g61B/WhzVDy9
 uBWVTpNSN8/BINKBO8YL5qbW/a5IqzU+0sU+uFovEXjw3qcILuYJ0dB0/JqA48JRC33J
 DZ0g+/eK75HvOUPOsZzjddIq+8g6FHxvGYL8F5xByR5YRPeO5NjUx4NY8BvbxzJkRuS1
 V4Ajxw1XnNi6AVn1URkDHE+zYHOyAUT1slUcO79RbZkWZwDrUtOwMmKXzm2Fx0jBElca
 ThwQ==
X-Gm-Message-State: AOAM533/RxMNulC42v1IOcsvKlppB7JO02oldsQ8nRpDsEOP1XK8ZFG8
 DA2fBTb2VtNWWQMJvl+SSkEOwQ==
X-Google-Smtp-Source: ABdhPJwdFEO/3YXlKql26I0OQACV1I02w9loSNlY3DxpWWs430txC/sCz1wgF+zv7H/bhyJf0DDOmg==
X-Received: by 2002:a63:2d05:: with SMTP id t5mr949438pgt.178.1603786591449;
 Tue, 27 Oct 2020 01:16:31 -0700 (PDT)
Received: from C02CW2YLMD6R.bytedance.net ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id n6sm1085268pjo.31.2020.10.27.01.16.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 01:16:31 -0700 (PDT)
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtiofsd: Fix the help message of posix lock
Date: Tue, 27 Oct 2020 16:15:58 +0800
Message-Id: <20201027081558.29904-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit 88fc107956a5812649e5918e0c092d3f78bb28ad disabled remote
posix locks by default. But the --help message still says it is enabled
by default. So fix it to output no_posix_lock.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 tools/virtiofsd/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 85770d63f1..574dd09e91 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -161,7 +161,7 @@ void fuse_cmdline_help(void)
            "                               allowed (default: 10)\n"
            "    -o posix_lock|no_posix_lock\n"
            "                               enable/disable remote posix lock\n"
-           "                               default: posix_lock\n"
+           "                               default: no_posix_lock\n"
            "    -o readdirplus|no_readdirplus\n"
            "                               enable/disable readirplus\n"
            "                               default: readdirplus except with "
-- 
2.20.1


