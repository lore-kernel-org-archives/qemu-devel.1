Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69317C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361BD205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isQLzT5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361BD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTLo-0001H8-8A
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJT-000810-3V
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJR-0002X3-Qu
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJR-0002UN-Ks
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r7so11324325wmg.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tUPUMiNZm+FvSUsI6UySdA140phZ0Bce9IKxnavBMOg=;
 b=isQLzT5U4O0I3Fg0J12gvvyxp8n/hLRirnDStAYtp/HCg990wGzuoDBFERWIR9hy5Z
 bu/u8z05wHd4JH7oVGtPji0MCHNq7BPHuMHZfR1Wjhcm+fLPwt6wOKTQWrG5nfrKdo8l
 kWfdhLthXznwTZuSxVvWCwfndMEfCkmeIcFWnjqEXXgzDw7+A4oy38JOqK2nxn1gZuE0
 sIFucASRb9Hs14wPZN9pSldjlvocvFVRqKqSCQhnWh+6BNPddqZEBiqHjXhSz+nJf6Iz
 UW1k2GRJxMJmsA0nasv8fPocD69o+Wc7QUr/HGyEccuJUkZe4r2dlHoXTpzgMUrRPjFA
 9wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tUPUMiNZm+FvSUsI6UySdA140phZ0Bce9IKxnavBMOg=;
 b=TIDMvTmANhPmVgeA0j4CL7GGHcFHQ8r5WSq/0iHuH0RxoLGZO4K/v3FAcWA5NUN1L3
 Xvwxc9wqbuIWwRcjF0zW4OUEzdj2Be/RRs+cR8U56gBblltPgnZA01NKpmJxjQbdyLrB
 G6L04T7AlCOMj0AiP1dCzgUG9Kt2ob3Al/HA155lfz868jxp+4NEO/IDefEF3+DBWRUS
 4di4mnBwUMDj3p6G4VrTUKGxbFNZYbbfx1bQVeZzBpqaqGUaLjLz3X5w2gHZqefrp0KN
 6rTzT5G7YWej0u1fxJ9UTKgC0OBoajnLXeoV4aIYk/lSlzDfv1QYcL0oCZc5C8Ed85bT
 xZIw==
X-Gm-Message-State: ANhLgQ1agmS9UlMwdfPvn/ICulv6O7ieiwv0sy46WCiyQdrfHgnFsNHy
 bmMEbgULt4Vf9jGUPbbXTAnrpFHk
X-Google-Smtp-Source: ADFU+vtDUv5loUzUpWtE2fQetNBPzFDbaZFzd7U16ND2TWMLl9bd/JfLcnlE0swgoodDwiucvZLzHA==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr22244930wmb.58.1584278896386; 
 Sun, 15 Mar 2020 06:28:16 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/13] MAINTAINERS: Cover Renesas RX architecture
Date: Sun, 15 Mar 2020 14:27:58 +0100
Message-Id: <20200315132810.7022-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-2-ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..3463533aee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -276,6 +276,11 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 
+RENESAS RX CPUs
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: target/rx/
+
 S390 TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
-- 
2.21.1


