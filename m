Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D3B21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cegxpKcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D3B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vsh-0000mK-FS
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkU-0001Zq-8j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkT-0004IX-Ad
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:26 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkT-0004ID-50
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:25 -0500
Received: by mail-pg1-x533.google.com with SMTP id t3so677909pgn.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Z4P6gozBSU47n/hk0aj8aavTiRQY7Brngh8HRCtVNow=;
 b=cegxpKcddvJ/OuGj8qugWdH9rvHwI38xclfoHrz5EzRd+C1Fy7W9u/r3UEkcW0wfzn
 B85UqAnlTn9YLqJzUxauGGeR9ummTMzsxBY9ls06UWeyVL1JFQK2YDvnkHIf4/AdpKxa
 k0oF6mwk4a2a7XXLvowA5fbS5IcP5YQQIN2NH/Z2L9KWdPKyelYezM8gxjyTnCnsIWPP
 xa0EWcrpQx2avRYp2oioM0GUvV953tIun4CUACSTj0n3XUjg38RRKDNDvxj2ONa9itMe
 xVJLDg1LGh5jb6FrvYm+A/sWvsuVFy65hpUcX3P7Y8/kUWcx6iAKbX3Vuk6dXVBzSMqa
 I2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Z4P6gozBSU47n/hk0aj8aavTiRQY7Brngh8HRCtVNow=;
 b=og1y4ZK0QmWTToaaj+AVc8PEqaIITeYIfk/0ZITr52sZcdj+s3Hl+P5S+VOwyub5O2
 hsYyjxuCl88a340vGFRXh3ITz4iIDriGZsA+fk1tg62WtXks6kT4pBpVlZuPKkHJXWq4
 1OSbEX2PCskhy9B91Tglc7+Fz/8heBUsqmfXMjM+F1hXvJsUC76fhdtTlcVpFlxb6oxE
 6e0UUyNRTgFOwLpfdvlDvRSst61/YicJAUn8YKRHeuiYCCdwuSk5mOYhkvfXWYZq8m01
 ER7PvajByvQQ8/bZIiZb9PgZF4aS01x4SGd7jZC3MEqgWxCcjWsWU6V+kwSXz91Q0xYx
 B+CQ==
X-Gm-Message-State: ANhLgQ3LWshvKOnEWhb6BjPNm+pFWr5sIzFDx9Kz0mbMVCUgCD5n1px0
 htXO7CsK2dCPftzjUdRFhfvCAg==
X-Google-Smtp-Source: ADFU+vstzBL6DDNRXSuP0+j3QtrPgNvL79S8kXxEE78qJ3LWyGfYiYrz3C9k885yicKDKua6MaHZTg==
X-Received: by 2002:a65:62c8:: with SMTP id m8mr1520567pgv.69.1583196564065;
 Mon, 02 Mar 2020 16:49:24 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id g9sm22524722pfm.150.2020.03.02.16.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:23 -0800 (PST)
Subject: [PULL 15/38] target/riscv: Set VS bits in mideleg for Hyp extension
Date: Mon,  2 Mar 2020 16:48:25 -0800
Message-Id: <20200303004848.136788-16-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f7333286bd..c0e942684d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -448,6 +448,9 @@ static int read_mideleg(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
 {
     env->mideleg = (env->mideleg & ~delegable_ints) | (val & delegable_ints);
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg |= VS_MODE_INTERRUPTS;
+    }
     return 0;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog


