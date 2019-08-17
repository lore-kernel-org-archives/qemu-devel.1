Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B4DC3A59D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 00:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3871D2077C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 00:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rA75Q+No"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3871D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hymGZ-0001RE-DQ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 20:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55154)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3NkVXXQMKCg87rBv33v0t.r315t19-stAt0232v29.36v@flex--scw.bounces.google.com>)
 id 1hymFe-0000yW-Ky
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3NkVXXQMKCg87rBv33v0t.r315t19-stAt0232v29.36v@flex--scw.bounces.google.com>)
 id 1hymFd-0006Ah-Jp
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:07:22 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:51429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3NkVXXQMKCg87rBv33v0t.r315t19-stAt0232v29.36v@flex--scw.bounces.google.com>)
 id 1hymFd-0006AD-F6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:07:21 -0400
Received: by mail-pg1-x549.google.com with SMTP id c9so3876587pgm.18
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kaoIQwDyK8bEoWe907lgLsxXKF/yKmR/QpCyb0YecPA=;
 b=rA75Q+No3aLpli5WnM4P2J+us7aucoc1gud1rnyD+XZQ6NBuon9m8jy1i8v/J3dNyu
 xBWsCSQ1yNJwJGgHD89G9XzgtfVYouBnuP3fkiMaIywK0J/muPv/dobS/MfTEjWNQIFb
 2GI/g+0kZKeym71a14mFszP5tk9j4E7NTw4M+qmRGGxhF68U8lOXvOSKOHS/ShktsJDh
 +0jkizxPt32FzdCNbBtcOW1sW25IjVzeO1w80sMyJUSZNYgN3WwZLXOhgE72FJfxD2MM
 Q1RXztk+BOjJumiGN2Wm9imHHm7+07+X6Cs6UYZl2ITzA0cp7iTuQCNu9USf2FiLQYSp
 09DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kaoIQwDyK8bEoWe907lgLsxXKF/yKmR/QpCyb0YecPA=;
 b=mhpNdLN96wtVUlfuYJHL3txal6B1GVLhpC2J+ZbZpLKB30ODOLUW9MNNqQ4ECoAcGl
 h8J86alorzB7dp4xj+Nc5y3tOvM2lwR3gU2AlVNznAhTab17qe2hEsTGlC1RCsGyr+Rv
 i637/MY1eVGIWt1z2ogL9PL+valfVnKgcOsb8h9E+wIlr9m2Bu5NJ2yUWuaCmhhYWGE9
 ZSMvEXplZvqscuP4tY8ttAG+xxd5EmQxOQKaFagzpEON2RKfbiN8hj55dwYTcVMEa8zE
 f3lc7AQheHA6SHcP8AE6Ge1TvmgKWb9g4umhUL3ecpnAmI2/nZmZh/JN0hsxyHcIPW6F
 mG4w==
X-Gm-Message-State: APjAAAXfUhvwEv3oxLOTTdb+KGmruphNzXksVDHD9N+6MxbEmn9JFEZR
 e4y6TYx1wW+N6JhjG8J6dq+hYpY=
X-Google-Smtp-Source: APXvYqw04ALrqSE0XUSO5JAIi0eAnyhefczwV77zTR72FDwKjX3i1+8wCtqAUfJdhw1YxGjApyrikqY=
X-Received: by 2002:a63:7887:: with SMTP id t129mr9953912pgc.309.1566000438046; 
 Fri, 16 Aug 2019 17:07:18 -0700 (PDT)
Date: Fri, 16 Aug 2019 17:07:14 -0700
In-Reply-To: <CAL1e-=hMssOVfvGWsyWmUgPyG-1ovMva9W5-T+GJgoyn_29-VQ@mail.gmail.com>
Message-Id: <20190817000714.142802-1-scw@google.com>
Mime-Version: 1.0
References: <CAL1e-=hMssOVfvGWsyWmUgPyG-1ovMva9W5-T+GJgoyn_29-VQ@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::549
Subject: [Qemu-devel] [PATCH v2] linux-user: Add support for SIOCETHTOOL
 ioctl
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: arunkaly@google.com, qemu-devel@nongnu.org, aleksandar.m.mail@gmail.com,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ioctl numeric values are platform-independent and determined by
the file include/uapi/linux/sockios.h in Linux kernel source code:

  #define SIOCETHTOOL   0x8946

These ioctls get (or set) the field ifr_data of type char* in the
structure ifreq. Such functionality is achieved in QEMU by using
MK_STRUCT() and MK_PTR() macros with an appropriate argument, as
it was done for existing similar cases.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/ioctls.h       | 1 +
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3281c97ca2..9d231df665 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -208,6 +208,7 @@
   IOCTL(SIOCGIFINDEX, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCSIFPFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCGIFPFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(SIOCETHTOOL, IOC_R | IOC_W, MK_PTR(MK_STRUCT(STRUCT_ptr_ifreq)))
   IOCTL(SIOCSIFLINK, 0, TYPE_NULL)
   IOCTL_SPECIAL(SIOCGIFCONF, IOC_W | IOC_R, do_ioctl_ifconf,
                 MK_PTR(MK_STRUCT(STRUCT_ifconf)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0662270300..276f96039f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -819,6 +819,8 @@ struct target_pollfd {
 #define TARGET_SIOCGIFTXQLEN   0x8942          /* Get the tx queue length      */
 #define TARGET_SIOCSIFTXQLEN   0x8943          /* Set the tx queue length      */
 
+#define TARGET_SIOCETHTOOL     0x8946          /* Ethtool interface            */
+
 /* ARP cache control calls. */
 #define TARGET_OLD_SIOCDARP    0x8950          /* old delete ARP table entry   */
 #define TARGET_OLD_SIOCGARP    0x8951          /* old get ARP table entry      */
-- 
2.23.0.rc1.153.gdeed80330f-goog


