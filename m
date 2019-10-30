Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B59CA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 04:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DC120874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 04:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="p/socSB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DC120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPg3p-0004GR-EJ
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 00:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iPg2y-0003n6-BC
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 00:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iPg2x-0001Bv-9C
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 00:57:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iPg2w-0001BW-Us
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 00:57:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id 21so665080pfj.9
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 21:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=QD5lzKum+Qo4vVF6hgbVJbUU4Qh7RzWKO3RZ7H1Bm0A=;
 b=p/socSB8T1sjyFDkXRmQkZSCZSjjCS+9CUG52wW/nmYHbXtYvK7u4yE5u9dm37Ec9M
 wMuAZOzCptwbssantO/Vp3DVqKCEZe7gsaqrjpsBs1pXJfm50hRIaTCmO2Gdmn4MffGs
 5+VHBrNwWV/+skvMAdRwz9ekDh+H3DtYl2DbWNxbgCJYsDg6nha4d//KFf3ZwDwDQRKl
 mPwpBg2i/uq7VUMl7/dKN+tokhHUxig1NcIwWDs1vmRCldQUC94OkdMLRDY9PRJ9Nr9N
 6XP6CF7aZMR9jThKetWL3rqOjq5lEm4isjHC3f049MKXyt0SmOWO1aiOPybzAZBXa3/U
 DX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=QD5lzKum+Qo4vVF6hgbVJbUU4Qh7RzWKO3RZ7H1Bm0A=;
 b=Ppz5kmmOfb11itIX6jzjNifo4LAUp2+id2DB9k1rzW7moRmLceMOr23rLQd2tveuKk
 1sfl6nrY2MlBO9KxgG3U8OUnQY7Eun+f7ozC1MDLTeeGPrPL4cwM3lIIuwg/BTqU2888
 FVe5UHrjUyNTo0Z8K8qLfalIr32gQSpavl0ASOeln+rlxrJiA/EtmCs6SorrfRI4y/kg
 KrTegf2Ss92rxX+2ou11NeSXEfXbJSk1ItIWjGhKnPBr3IrMsZPu5V5JRWPw1pkjwVwp
 EX23ZfLWpCxzKjmZTzSFiw775M+ta9YzLxwN2S9/DxDEf/YjDHwmDIl6GkbxGUeB1yKy
 iF5A==
X-Gm-Message-State: APjAAAV6FdD1b1TRdhTLgAlppKHxYFTJp1aCAojzRhBRETFTbULvyLIh
 Ho5Q2mJTNQoKjDttISSwWeBcOoeIhdU=
X-Google-Smtp-Source: APXvYqyLnBnl0qQjGR+lCpSI8Rh9Tj0sQQUl92gf35LwP0Rqgf+XxkxFwU0pLzfsfmZmtnGi2bnmRg==
X-Received: by 2002:a17:90a:9104:: with SMTP id
 k4mr11442805pjo.39.1572411445399; 
 Tue, 29 Oct 2019 21:57:25 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id s24sm974473pfm.144.2019.10.29.21.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 21:57:24 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: Change to my personal email address
Date: Tue, 29 Oct 2019 21:43:41 -0700
Message-Id: <20191030044341.29179-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Palmer Dabbelt <palmer@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm leaving SiFive in a bit less than two weeks, which means I'll be
losing my @sifive email address.  I don't have my new email address yet,
so I'm switching over to my personal address instead.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 325e67a04eee..20445f353e7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -259,7 +259,7 @@ F: include/hw/ppc/
 F: disas/ppc.c
 
 RISC-V TCG CPUs
-M: Palmer Dabbelt <palmer@sifive.com>
+M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
@@ -2392,7 +2392,7 @@ F: tcg/ppc/
 F: disas/ppc.c
 
 RISC-V TCG target
-M: Palmer Dabbelt <palmer@sifive.com>
+M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
-- 
2.21.0


