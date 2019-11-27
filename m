Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF37C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE382215F1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPaEChY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE382215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia5Tx-0006xh-TG
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 17:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia5SC-0005dG-3t
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia5S9-0002Jg-TW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:31 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ia5S7-0002Gf-Ot
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:28 -0500
Received: by mail-lj1-x244.google.com with SMTP id a13so2990323ljm.10
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cwA5q3AFi5s0/Tu2HSgxO1ODp0hkSzcVTvyj+WyoDWU=;
 b=uPaEChY5Tks0LkdZgCUaIGMdz9gQ8BXmAvy9ozmEAaFNjGydxRjpi4GNIhwYMjt8fd
 PWidtMTP5CJtfykbRK/kMCvtWVC5eEGEvj90mjw3k1+/mPFwNAaUxwleH+6Vf7286wJo
 +5rxIGYWJhy+olJ2M0DrFFbixP/jV15McODCw9CYtmV4u9rM1Rz1H0vYSfCqGTLBBf5D
 BLao1JhfxgcaXlQtHx6BIdQV5/m61XpCutsWriLgan/Wdz5BN9t2JTnfNEM3H/Ug1nIk
 v8SjypqqXgpTm5XimMmygQDhRYK4HNX339MDRhNZ3jJtWm3HC0r9+lIgCFukpDqQKan9
 P0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cwA5q3AFi5s0/Tu2HSgxO1ODp0hkSzcVTvyj+WyoDWU=;
 b=KgIeJDVf7C78sP7Zjdgbcma3/1imOZhHe+oF72wLlJTg1wYRIOdqAe6A6/Z4/wJZKg
 ewdEX3p19vZ337NkgIMPhVt3PpYUIs+hf25lmO3/vaDizQMoO6NEBgaQd9fddL8KPpr/
 0tULUwAAFPGeYrHQ39xexvWFatuytoWovF1YeaxRPiZsVc8fk/9rBru2NYVDBGFrxvHQ
 5+FDjzzk79c9elBWo9oaIPuIXD0U5R06Mfhfu/r382F/HHgh7N4CEq14YGdfo5dLF6lj
 nm6fvkgviZEWCrbluZl+KaVQeIziDrwPTitI2cXYM9OOa476j1SVsstCixm1Qds15Kqg
 0F2g==
X-Gm-Message-State: APjAAAWZ9IpZhQ1rXubo2HGrBr7iW11gDNFq9o6Qyh7tERNoeXXKXz7P
 ldYqSIQ1kN27hnyeUrpNQ8WQgYMPAao=
X-Google-Smtp-Source: APXvYqyWy/INBe85A0mEn/3DbMcQGf1dVaEp+F9XnbVPzaWYzW9CbhZYR8/2CF79B1oC10VjY6sEoQ==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr32293170ljw.116.1574892384305; 
 Wed, 27 Nov 2019 14:06:24 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id r7sm7655611ljc.74.2019.11.27.14.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 14:06:23 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] flush CPU TB cache in breakpoint_invalidate
Date: Wed, 27 Nov 2019 14:06:00 -0800
Message-Id: <20191127220602.10827-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this series changes breakpoint_invalidate to unconditionally do
tb_flush and then changes remaining users of tb_invalidate_phys_addr
to do the same and removes tb_invalidate_phys_addr.

Changes RFC->v1:
- do tb_flush in breakpoint_invalidate unconditionally
- add tb_invalidate_phys_addr cleanup.

Max Filippov (2):
  exec: flush CPU TB cache in breakpoint_invalidate
  exec: drop tb_invalidate_phys_addr

 exec.c                     | 44 ++++++++------------------------------
 include/exec/exec-all.h    |  3 ---
 target/xtensa/dbg_helper.c | 19 +++-------------
 3 files changed, 12 insertions(+), 54 deletions(-)

-- 
2.20.1


