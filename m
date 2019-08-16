Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE3C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD2B2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FpkKZLw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD2B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyjm6-0002RH-A0
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 17:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60088)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3lxxXXQMKCh4M6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1hyjXx-0007QG-7c
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3lxxXXQMKCh4M6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1hyjXv-0007xL-0s
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:14:05 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:46049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3lxxXXQMKCh4M6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1hyjXu-0007ue-8r
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:14:02 -0400
Received: by mail-pf1-x44a.google.com with SMTP id w16so4585261pfn.12
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=kaoIQwDyK8bEoWe907lgLsxXKF/yKmR/QpCyb0YecPA=;
 b=FpkKZLw26t97kT1DqJV3wFVQC1ne4Z0vTB9JHFNdpDvaKSxbY6DKvXMlvgwnQhKn18
 jsq5JRNcm+iqaaXMpeH7MPBupeb8CkZyHAhaRCbrj0sS5awt8Ttge1knv6rgQO+rgINw
 C7bkZjdCmcbL3p5J1pxnTDz696OgvX+uoG5WetWr7yhCrc3UOinN4iBNbdhf1jCeGTNY
 fhw0ah3eSTWEA4dpEIS61S/fQc6EiL8cgT2nzPBK14xqEaldPO+A2BI7ORmyjnkTqo2+
 6QaDT4b/pW7NLLaNeoP1fSkAD0DQASgHNDTTdg2vkp0twmYLkUt/zWKafka4DqAF+sUI
 qp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=kaoIQwDyK8bEoWe907lgLsxXKF/yKmR/QpCyb0YecPA=;
 b=nntsT3a8gRD0HTdW/sSX3qZJz6Wn9MkkpUgKVh/cJzz7Q9+z31/dpLs7pMTp0z6HXK
 TK+e8PPYmmJLatb8MJWRLYuGDj5nfYrTYevFgXmbPpONhgoGVmQaXicoGdZBpAqBfXKw
 GFTJ3+E8ti5FF6Z7+7cxOjK4Ephi9e+9Qu2dz6BByGGiYL8eIdrpIeQMuuIhdRelOoOA
 tKAnmavnd/UHUOIH9jswDvuImFSzNEc21DCpDAooitqFgWH6g1qv0/7aatGUPBNiwR6e
 KEjkYVAUEgZsN2T3srUp1RbFzLWtM/++5fKzi0osS8TAW/IsCjnEKgDAFEWjtUnYfN62
 9QEQ==
X-Gm-Message-State: APjAAAU23ax/pK2uOeWU8q5jWceYfBQUBkYbjFVQYCS4TJzpTXqcJwvG
 1RX0CAzL6jreREYK32NQst6nRRo=
X-Google-Smtp-Source: APXvYqyF8tNT/uphND43ZKM+1/9v9e7K+M2fGVvadLy7zfzIcjJzFUkey9oWT/RwKDbj/1kcSQS8eBg=
X-Received: by 2002:a63:ee08:: with SMTP id e8mr9606242pgi.70.1565990039302;
 Fri, 16 Aug 2019 14:13:59 -0700 (PDT)
Date: Fri, 16 Aug 2019 14:13:56 -0700
Message-Id: <20190816211356.59244-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::44a
X-Mailman-Approved-At: Fri, 16 Aug 2019 17:27:49 -0400
Subject: [Qemu-devel] [PATCH] Add support for ethtool via TARGET_SIOCETHTOOL
 ioctls.
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
Cc: arunkaly@google.com, qemu-devel@nongnu.org, Shu-Chun Weng <scw@google.com>
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


