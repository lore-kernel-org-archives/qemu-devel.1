Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B5CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021F5206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA8XifHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021F5206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWDr-0007L8-Lw
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBb-0005Vd-Mw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBZ-0003CA-Ic
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBZ-0003BP-Cr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:17 -0400
Received: by mail-wr1-x434.google.com with SMTP id l10so13182327wrb.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M3aCjLzoSIL7ixb0kk9ystt7R8xUSVOY/bvuxxJ0uh4=;
 b=YA8XifHwosXQTF7oe0vMEXhR9jchg+Wm9KVRH80wPckh14xp6exDlmarHVXqt2RXTf
 IknPCUODpEyb1XMuL/iS9iwyNV1uKH4pxEEFQpdVGxpkDzr5mnIglWC+7Rg2gBqcFL5a
 0rEsF9mnYgW8gKzyWpyfAdFIJ3cIDjvqfXUshAsqimX0JAJ2SRBc8ZWuiLR55SORN7ps
 PvlZDMw85li4QfV9qX25i3YNwbbMiw2BD7OoSmqMvgLGKjC2BxtFfoHTSM2FW60VHCrx
 C129a2sNCpn0K9Md+HI1RTG77nLUrivbE9sCtMpTfeHPz1vdQZrToapecmftNLAuIkE6
 JO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=M3aCjLzoSIL7ixb0kk9ystt7R8xUSVOY/bvuxxJ0uh4=;
 b=S8lY6sN62B1iISESv+9mDH4N104poJk1AEg0Vuh7JEluJdxyLtOeeEjVLRMZIQdKds
 7Z8VacxoyOu3ftd1Eb6mQm4oYR++ppDOMjlrETP1wG1ClrttvBQT8hs/xI7B+LQgKNl+
 eOU+7ch7bdsRBPiJUZhJ1bD9Vpi/woxCaxS4pVDu0hdGRQltK8XZnqkLT7ZdTKEQWNpz
 DEOWQI4J88sXEyiJv+d7X90hY0p3P5cVe9q2sWMMpldptEPpXYyajyN/ClU4nwCimvWR
 EgkIEMit12qM3jQIRQcSK5R0n2ctUZ6sFtrZ3uoJidaQkH94OcOMdqXiijM/X8VreVFW
 hr5w==
X-Gm-Message-State: APjAAAVsyCARRYN07R34b3U6c/oAECfJt5z0TXzVfWjLYiXMXhrn8qcK
 IExEW1sTGXrG3WmeqetrlGj7aO+M
X-Google-Smtp-Source: APXvYqwxrHqbdH7yTo4kSeuX+KqpF26sTgSHv6ohKMUSYKbINZKTGlsIWmJBDTcK20FUWInWxTJxOQ==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr14754388wrx.90.1571658555467; 
 Mon, 21 Oct 2019 04:49:15 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 9/9] linux-user/syscall: Align target_sockaddr fields using
 ABI types
Date: Mon, 21 Oct 2019 13:48:57 +0200
Message-Id: <20191021114857.20538-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Target architectures align types differently for instance m68k
aligns on 16bit whereas others on 32bit).
Use ABI types to keep alignments good.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v8: Use abi_int for target_sockaddr_ll.sll_ifindex
---
 linux-user/syscall_defs.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7694d72446..98c2119de9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -134,22 +134,22 @@
 #define TARGET_IOWRU(type,nr)	TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
 
 struct target_sockaddr {
-    uint16_t sa_family;
+    abi_ushort sa_family;
     uint8_t sa_data[14];
 };
 
 struct target_sockaddr_ll {
-    uint16_t sll_family;   /* Always AF_PACKET */
-    uint16_t sll_protocol; /* Physical layer protocol */
-    int      sll_ifindex;  /* Interface number */
-    uint16_t sll_hatype;   /* ARP hardware type */
-    uint8_t  sll_pkttype;  /* Packet type */
-    uint8_t  sll_halen;    /* Length of address */
-    uint8_t  sll_addr[8];  /* Physical layer address */
+    abi_ushort sll_family;   /* Always AF_PACKET */
+    abi_ushort sll_protocol; /* Physical layer protocol */
+    abi_int    sll_ifindex;  /* Interface number */
+    abi_ushort sll_hatype;   /* ARP hardware type */
+    uint8_t    sll_pkttype;  /* Packet type */
+    uint8_t    sll_halen;    /* Length of address */
+    uint8_t    sll_addr[8];  /* Physical layer address */
 };
 
 struct target_sockaddr_un {
-    uint16_t su_family;
+    abi_ushort su_family;
     uint8_t sun_path[108];
 };
 
@@ -161,24 +161,24 @@ struct target_sockaddr_nl {
 };
 
 struct target_in_addr {
-    uint32_t s_addr; /* big endian */
+    abi_uint s_addr; /* big endian */
 };
 
 struct target_sockaddr_in {
-  uint16_t sin_family;
-  int16_t sin_port; /* big endian */
+  abi_ushort sin_family;
+  abi_short sin_port; /* big endian */
   struct target_in_addr sin_addr;
   uint8_t __pad[sizeof(struct target_sockaddr) -
-                sizeof(uint16_t) - sizeof(int16_t) -
+                sizeof(abi_ushort) - sizeof(abi_short) -
                 sizeof(struct target_in_addr)];
 };
 
 struct target_sockaddr_in6 {
-    uint16_t sin6_family;
-    uint16_t sin6_port; /* big endian */
-    uint32_t sin6_flowinfo; /* big endian */
+    abi_ushort sin6_family;
+    abi_ushort sin6_port; /* big endian */
+    abi_uint sin6_flowinfo; /* big endian */
     struct in6_addr sin6_addr; /* IPv6 address, big endian */
-    uint32_t sin6_scope_id;
+    abi_uint sin6_scope_id;
 };
 
 struct target_sock_filter {
-- 
2.21.0


