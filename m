Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C523C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A122074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRFNh/Ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A122074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcDh-0002Dq-3Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAcCz-00016d-MI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:54:05 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAcCy-0003eQ-4w
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:54:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id p37so7238471pgl.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MU1D0gcoO3ZaMdBitGLyuB0vQmL5fSRzDQyIOcmupWk=;
 b=RRFNh/ChKXSx1pXId/0QVXP/LMduMWDUJIHuK6jYKuSZ2EzJrIgJi3qIeWTFfYUn1+
 lWaJ36Vu8r+3BoSvtZcD2FNMxnR/7TZe/hfdedT8HlI9Pfu6LIFcNuMP8xUCasJLnQLF
 gACyQkw+YfEuRzGJFcb68Ls2DbdijzL9e5rdAtNRLi40oLKFZGXNM2klN6NrmJHS6VLT
 SwDBPiHrZpqTxVYU0GKxMSCt+FVEbE2UY7gfy6F0nzrgB6JCbvCAaRXqpwBXgEHF7cKm
 qipeusQN/EzlTBNeacItXBURg+jKvrSJvqEGuLbNVPVXohaphJqfx9DvJbFnSraaz0FQ
 NrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MU1D0gcoO3ZaMdBitGLyuB0vQmL5fSRzDQyIOcmupWk=;
 b=fcdRNDnbjSjxgCaZNR7u/2ajsxgZexP0PRoM1b+8aS7zqAsO1vo9RYmACo0F7utANt
 nLKkoTJfAwtH4KFtht/BABtJvFViwP7vyvwihmzEZITykGXUnv7jyBqLEdb0OhnlpqaM
 TOUeIvFxRcO3wiXRrqRf97ECalniO3olz99+jj6Ae843PXGavUMQoYfreTEBT6AtNNqo
 VAv/dsxMjlWSBLDXJ0k6M7vWmH4SOfS5amcaOEKDNrAAWTet5X9jlAwiYGM5gEIRUn2c
 HTgkgQU8moRKnlxCVzrDkgGgpt4eYjqZ8QB3BW8WiqHJHB/IukYsMJXOeKP0ZeY1jYYu
 T3DA==
X-Gm-Message-State: AOAM530h60fOQ3p+KE4zCMkJVzgPEVNz9DjHycLRMQeYhlKzLQrBNsi8
 wdAjT5soqbRRrrnDMzwmbwvGse00Taw407c7y+A=
X-Google-Smtp-Source: ABdhPJyQXihYc/eTsNGoXFyGE7HRBDtkIBYc3lNGwLBK2AuqdSQhiOthiH5tZqFKR3ANjo34pgw2FA==
X-Received: by 2002:a05:6a00:15cb:: with SMTP id
 o11mr8477923pfu.263.1598374441891; 
 Tue, 25 Aug 2020 09:54:01 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id
 193sm15988527pfu.169.2020.08.25.09.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 09:54:01 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] meson: Fixes the ninjatool issue that E$$: are generated
 in Makefile.ninja
Date: Wed, 26 Aug 2020 00:53:38 +0800
Message-Id: <20200825165341.520-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

SIMPLE_PATH_RE should match the full path token.
Or the $ and : contained in path would not matched if the path are start with C:/ and E:/
---
 scripts/ninjatool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index cc77d51aa8..6ca8be6f10 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -55,7 +55,7 @@ else:
 
 PATH_RE = r"[^$\s:|]+|\$[$ :]|\$[a-zA-Z0-9_-]+|\$\{[a-zA-Z0-9_.-]+\}"
 
-SIMPLE_PATH_RE = re.compile(r"[^$\s:|]+")
+SIMPLE_PATH_RE = re.compile(r"^[^$\s:|]+$")
 IDENT_RE = re.compile(r"[a-zA-Z0-9_.-]+$")
 STRING_RE = re.compile(r"(" + PATH_RE + r"|[\s:|])(?:\r?\n)?|.")
 TOPLEVEL_RE = re.compile(r"([=:#]|\|\|?|^ +|(?:" + PATH_RE + r")+)\s*|.")
-- 
2.27.0.windows.1


