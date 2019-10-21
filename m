Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D055CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DF4206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw5E9q12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DF4206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWGM-0002Sy-5i
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBb-0005VS-KZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBX-0003B1-EE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBR-00038j-Po
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id v9so2350152wrq.5
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L1ZRC5xfl7LAc8y7XcDjWKXdgHuMKTnYncwldrjeKoE=;
 b=Hw5E9q123R3Tvz1vaTdDmL8+/eQKpTsEt3Qgu1/klh48i+Z9puQ/jxBxlIBNIJiJAD
 XLSla8eh1r0PXmCUAlSDKSB3Q649GBdIXDqIl5V7M38uGtS0Jx+dHMXIdZ7ncLHqiqvq
 vaze0JZa9fANNtde143lXJ6Q466W87v1gwbL66k3R0gwaXdSRDjVj8+s0XS69PsnhixP
 H25q1qxm7MJ91L6OvN+BxG6cRDW+v9KbHR72tKnyW8wYTi/hIcMeJ2eo45ZyC+WYByyv
 ckqhtNyKw9fqVBx07N8LaqBvq+zrTNUVAORn+vFyKHYuZshJgLuccqAZWqcBeDjk/Vyb
 Dc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L1ZRC5xfl7LAc8y7XcDjWKXdgHuMKTnYncwldrjeKoE=;
 b=Xb54AYDarHtRqRvftP6qrTBBm1T+Zq+Tw89BXfwY9WJGEdiS3P5isCj0kYyWH4guGg
 cx4zslK2VMgPSWG9NexOOOiPT0ZN8Ellagkz+7dwVQzjYicsFSUshJsM0CqQ0ClIx6ND
 g53UoZlT+/YJ63Qkmci+VbhWvxLBCnhPdLvJqoRsn2c3i8U1dPgtEBtgOo+ipXfEN/Ca
 B4XhCKLC+SDcGYmOSDvxqd01HoI/EyCtVQX50ksrJ3x4mDDxi0QZK6A7k1dqgAYG/Fwa
 acj0YBiX3OpSnngKnR1jGR2ASFUUYoa7dLnn4LmgwQhuX+96RRVj0k5jiABIG5KudZQz
 sHfw==
X-Gm-Message-State: APjAAAVUVAD8/SDbc5GcHtBjUfUkUlSwnOLozrLvzjAcnM4HKlg2RtSI
 ahSvpsdrUDF6kbUk3lacSrqnwPDR
X-Google-Smtp-Source: APXvYqyhC2xqhen9lmC1sFAEfA0NBjNDe8SFmARNqljeJrKlGw0ydnjwfWaWvLqNIpG74ouKi+C2zA==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr7747800wri.16.1571658546821;
 Mon, 21 Oct 2019 04:49:06 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 4/9] linux-user/syscall: Introduce target_sockaddr_nl
Date: Mon, 21 Oct 2019 13:48:52 +0200
Message-Id: <20191021114857.20538-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v7: use abi_ushort and abi_uint to keep alignments good (lvivier)
---
 linux-user/syscall.c      | 6 ++++--
 linux-user/syscall_defs.h | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2af3c1494..f1ab81b917 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1496,8 +1496,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
         sizeof(target_saddr->sa_family)) {
         target_saddr->sa_family = tswap16(addr->sa_family);
     }
-    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
-        struct sockaddr_nl *target_nl = (struct sockaddr_nl *)target_saddr;
+    if (addr->sa_family == AF_NETLINK &&
+        len >= sizeof(struct target_sockaddr_nl)) {
+        struct target_sockaddr_nl *target_nl =
+               (struct target_sockaddr_nl *)target_saddr;
         target_nl->nl_pid = tswap32(target_nl->nl_pid);
         target_nl->nl_groups = tswap32(target_nl->nl_groups);
     } else if (addr->sa_family == AF_PACKET) {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fa69c6ab8d..7694d72446 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -153,6 +153,13 @@ struct target_sockaddr_un {
     uint8_t sun_path[108];
 };
 
+struct target_sockaddr_nl {
+    abi_ushort nl_family;   /* AF_NETLINK */
+    abi_ushort __pad;
+    abi_uint nl_pid;
+    abi_uint nl_groups;
+};
+
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
-- 
2.21.0


