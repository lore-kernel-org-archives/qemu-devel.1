Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D41C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD73207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="RCyO3IKz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="i0Si6+8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD73207F7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXA5b-00007C-BD
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXA3K-0006Nh-4O; Mon, 26 Oct 2020 17:29:18 -0400
Received: from home.keithp.com ([63.227.221.253]:57166 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXA3G-0000Yp-VW; Mon, 26 Oct 2020 17:29:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 87D003F2DD66;
 Mon, 26 Oct 2020 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603747751; bh=h5maS+Ga+vOmYNo0Gj4CRNOdrG+2EENdlc0yMuInjXk=;
 h=From:To:Cc:Subject:Date:From;
 b=RCyO3IKznZkge2TLn3UprmuZqvgEAN+KvvviY10/VbtFfSEdQ0Wo+g8ipP3XVWkC0
 hTuKHUIZXTApZnR3mH9Gle0rtOCSfxBKKW+FoMYIqeWeb/RwYAzf0JeqNUCmINW5Ya
 TkcfZTqfTLQXftPvYVF+vsKeeH5VMUYLjqRLprgUQpqFGVzQUKbFw8hbQuqKvc/rLv
 MEbe5bWFKPA9wJw6TagCEpvr8ntvwYxs2+mg0AiAE2mr9hYVgXtqdkS6P+XpQZxiiX
 55hr7ZOV9dQ/63xFClWLeGAv4QSkYBklXgEYwq9uEmLWWYCnZb0d2/adAPBMvtjUMK
 HQXON7M2C4Lbw==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id rSVIRRspRVFZ; Mon, 26 Oct 2020 14:29:11 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id AF45E3F2DD60;
 Mon, 26 Oct 2020 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603747749; bh=h5maS+Ga+vOmYNo0Gj4CRNOdrG+2EENdlc0yMuInjXk=;
 h=From:To:Cc:Subject:Date:From;
 b=i0Si6+8RZDFZh318UTulzuflo2yXtTS9hHlDQCyq1b9eBPGB0PaZRhpCBEe6waaHx
 IBR4KyBRvqbx1ZqGnVriU7fkkRigdxEMoCNWqE0GHplJW+xqeeYYzKhJ0xmyqkOUPf
 deyaxk7JMd/NtE3wv3lpPJgaCA36pwPKK8vvs4pDEOPM1D25EUKhP4Op45VMolIZ+P
 39ld052CoCa0486jS62V8E1PtlqbGHgtlVCsYEIIH9OyEtXm5lN/N+6jUQBweHd5E/
 JfGgq5MttJCYI5+ELTHprra6U0VVv3i6vA0ctnFHjBYdP7/tBYKz91sYdd7mqtJWa9
 J5wGA1FuQn8vQ==
Received: by keithp.com (Postfix, from userid 1000)
 id 8E3F71582210; Mon, 26 Oct 2020 14:29:09 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org
Subject: [PATCH 0/4] riscv: Add semihosting support [v10]
Date: Mon, 26 Oct 2020 14:28:49 -0700
Message-Id: <20201026212853.92880-1-keithp@keithp.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 17:06:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

This series first adapts the existing ARM semihosting code to be
architecture-neutral, then adds RISC-V semihosting support using that.

Patch 1/4 moves the ARM semihosting support code to common directories and
adapts the build system to match.

Patch 2/4 changes the public API to this code to use
architecture-independent names and types.

Patch 3/4 changes the internals of this code to use architecture
neutral types where practical, and adds helper functions to abstract
away the architecture-specific details.

Patch 4/4 adds the RISC-V support, including modifying the breakpoint
handling code to recognize a semihosting sequence and adding RISC-V
specific implementations of the helper functions.



