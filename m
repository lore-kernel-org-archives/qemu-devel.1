Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3073FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E922220679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC8tOUnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E922220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYgH-00052g-Tf
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYf3-00045A-Ak
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYf2-0007Bi-EH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:04:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iUYf2-0007B2-8h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:04:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id p4so19127984wrm.8
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4N/LEuHIUHYOQCoZA48U+wOByIBPr4A4etU0NNzr4Fg=;
 b=PC8tOUnrCn+yNxrICFnQ6FfOMrk15NwSdLQqLspsGEP7WqRx02jPHOHOYlCCYs4dgS
 dcPOL2EhUSTpK8xYFOLBF2l3Z2rFjWbaI6NJOosjn9EeF1HhWZCTAglJ74aQ8nPNbBWb
 F7SspWZ6lguEj2dYBdh8b5ipKWkOkvZjbRDj5RYKBHF2raiZd4y1a0rqTKyGuy9Or4Io
 /s4dubNWA69D3FLZZHcYG0p90Ve9/l/Gfw2gxTBLQNfVyGVR3dl7ozu7xW6xGykpTZmC
 HgD9zZVZc/QlqoBcS/Qmdt4EEE5UcxpIiuk7c+GKlHDLszgEWr6/ukY6vJLGKYpm0vtV
 oGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4N/LEuHIUHYOQCoZA48U+wOByIBPr4A4etU0NNzr4Fg=;
 b=RKxtU99zQDg2gYzr4pk+fsf1c991i9E69+u7OutFJxjquOyy+Smvj3RM5YwsZ+qh2P
 4xdQpNs1CTW09O50Qf/1N/JydhYZEmgw9E/1CKMi0ezFi+2sQ/XVoZOCIAGE0khrGrBO
 D9L8B6Mmd8Pgyx3LMhv4J7jLNvp3KTF52KJZk9+pMJW82MEnxg0YyT0rFCFDWWYJrWPb
 EMw6Frh1DHKt8K/F2thUwrw8OTIQaQz/DdLD8MvwKTIQwcx8MyASsmn7uUDVeYLp8+Gs
 tPXl5mYnJKNQYA1utPJIsL+eYOBd4Vy3oDMs2yfQP6hBXkh/ITRrQWOIpI7izgkbp/q8
 boTQ==
X-Gm-Message-State: APjAAAWwQLmtriC5QdjbJN5lCgjEHy8x7YNFWjptZ0BndTIr28Uvps3T
 B93imlPSrVOAWBgjtzzxg8w7UoDFEck=
X-Google-Smtp-Source: APXvYqxmq0HlaSIjTGczb/k4z1iiMZ4zHG9cKypEHjiYo0EPIVTW1naIxcUwliK3CZOKr3ab74vYgA==
X-Received: by 2002:a5d:6b51:: with SMTP id x17mr3332334wrw.148.1573574694054; 
 Tue, 12 Nov 2019 08:04:54 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id b196sm4199128wmd.24.2019.11.12.08.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:04:53 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 0/3] MicroBlaze fixes
Date: Tue, 12 Nov 2019 17:04:46 +0100
Message-Id: <20191112160449.29212-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit 039e285e095c20a88e623b927654b161aaf9d914:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-11-12 12:09:19 +0000)

are available in the Git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2019-11-12.for-upstream

for you to fetch changes up to c49a41b0b9e6c77e24ac2be4d95c54d62bc7b092:

  target/microblaze: Plug temp leak around eval_cond_jmp() (2019-11-12 16:35:26 +0100)

----------------------------------------------------------------
For upstream

----------------------------------------------------------------
Edgar E. Iglesias (3):
      target/microblaze: Plug temp leaks for loads/stores
      target/microblaze: Plug temp leaks with delay slot setup
      target/microblaze: Plug temp leak around eval_cond_jmp()

 target/microblaze/translate.c | 77 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

-- 
2.20.1


