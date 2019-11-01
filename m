Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6784ECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C1120650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gZDwP1qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C1120650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZeE-0004N1-B1
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iQZcT-000339-03
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iQZcR-0005xt-Sm
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:17:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iQZcR-0005vh-Ng
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:17:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id q21so4574240plr.13
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=FWN25eP3ttkhHBPL8KIS9xKijpRU7CQEubpr34vg72E=;
 b=gZDwP1qPSECl8jBoIlwkw6alNMeF0H9HZNVUPRgxoOjIeJhVmrQUei+SCZ6PEOaJXe
 wPya4mnkQsb1B/p+EXOuU6YvunEpoCNE2x9PMcEgD30fctVvHl+1AolFklyCzydpP/V6
 OH7MkoNZg21AbnDGqazc7LiPgCp69gDMimu3CJKa5o6TCmMCXObGesJSds3i/wQT5KNY
 L831PJQztWz99kh+QegWVhtj561Tcm5u78heZWB3XIbOx7qSUSFPOd9KrPvvjW7W1s3R
 Y5ToJtP20vmIaYBLqK1nsKqg07QOGLjbscFXh0/IE8qhhRL4ukeMRtLaDye1sFbmJtBJ
 /Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=FWN25eP3ttkhHBPL8KIS9xKijpRU7CQEubpr34vg72E=;
 b=aIy9eAUsFrPx7OeUC9+E0tGHc/xmbhX/jtmYrjZqjdBU0K+rlGEju6ikU8pZtbQfL4
 LubkjZ8TBk0I6Aju3eC2imZ9EriHmfgSkJq4CKA8ffrb08T8WAUoTxjEDDoM0PhTZlya
 PBHdjWBVwjgU7TA02W1lg7tBrzpLW9Q3v1w/AIRISRHWvxoVY1gYSYhV1KZoG5gYe2sQ
 4EnpvBknJgalhzRqwliLj3RX4OB4D4fJW6gWIfxhWdEkUMJguWKZv4M0vV7H449SkpeE
 5wyyBVZqtLKXjtMThOogQcTwM0HrwtRvEsb2hyMQz8NrF8v0ChpcILGKmOjL7Gj/oaW+
 318Q==
X-Gm-Message-State: APjAAAW8EJwcMzJ9pduPiEPKs9Tcl6RlhKlQ5Da4XexvtAZtJ2bBrLHV
 lIGoyylKs6y7E+yasVQd6oZO46fjz7VOLw==
X-Google-Smtp-Source: APXvYqwneqcy2pixK4/B+flVdvqcT8IBq2G1XvEQvbekfmfu+onmMPvVOhXUmzsU+TK3RTt4twsKPA==
X-Received: by 2002:a17:902:ab94:: with SMTP id
 f20mr12637334plr.231.1572625066176; 
 Fri, 01 Nov 2019 09:17:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id x10sm1889579pfn.36.2019.11.01.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 09:17:45 -0700 (PDT)
Subject: [PULL] MAINTAINERS: Change to my personal email address
Date: Fri,  1 Nov 2019 09:16:54 -0700
Message-Id: <20191101161654.2871-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101161654.2871-1-palmer@sifive.com>
References: <20191101161654.2871-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm leaving SiFive in a bit less than two weeks, which means I'll be
losing my @sifive email address.  I don't have my new email address yet,
so I'm switching over to my personal address.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92961faa0e..c2a68555ae 100644
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
@@ -2401,7 +2401,7 @@ F: tcg/ppc/
 F: disas/ppc.c
 
 RISC-V TCG target
-M: Palmer Dabbelt <palmer@sifive.com>
+M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
-- 
2.21.0


