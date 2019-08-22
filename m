Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08652173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="h1xznDfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08652173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wMj-0008Qv-SN
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53997)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <38iFfXQMKCqMVFZJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--scw.bounces.google.com>)
 id 1i0wII-0003dt-AZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <38iFfXQMKCqMVFZJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--scw.bounces.google.com>)
 id 1i0wIH-0007nb-Av
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:15:02 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:33716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <38iFfXQMKCqMVFZJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--scw.bounces.google.com>)
 id 1i0wIG-0007mP-5K
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:15:01 -0400
Received: by mail-pf1-x44a.google.com with SMTP id r130so5104670pfc.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ohZHbdryKXSynjo681jhUMl4RCCWauFt1xkFVh1KbPw=;
 b=h1xznDfpJa+SzNBk6jmopaHlF8rLmA3ldeZ5xQubxAyFEYY/s6dRm5XcGp0soBOC8k
 CWT+D+zCafv7ay58U1J+LQupUYiBLCttL5APz1iFhw70A1kEpU5rXHvTm8Hsr9axTzu4
 D/d5gWnTJE4ryRmst5TuZQqfVTb8FTPccwVUAaMj9JEI5ILuO53C2TDRRQYBSfHWzyAN
 QOEytPxGJ3k9aspTRBoQYTxUOJxz9wUn5zhsjrIMaFeqKgNszlXK2NMgnm0dUZrZpX6i
 G4+Dv0fqDc0ZHlOZzrkKGmgfldMgWRKevjBUuKX6WOJnXtK2gtRb2+AHHMdNtWQstID7
 iMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ohZHbdryKXSynjo681jhUMl4RCCWauFt1xkFVh1KbPw=;
 b=t35zQVlA7EYUC6ynhT+e6YblsAUnoCXx7cXga91RM4F5whZEJMj0ogWGE9x0+SLmSQ
 tD5bOFJ6KkDEOF7Jj+dyJ5rY2SWDLxpz/B9IoGDGBycNwJkD4vA73RQ/BtvAFkO1QUiZ
 R4dt1DAbl6hhBDt65OVmxEFM5uUnN35ZBWiJA7xCSi7gaFo4n3QHowtzGgED7R4A+ur9
 dr91LdJQtMtxVEwuWgmwPBIgo+ezNuCaRrqFNALP/8rDkDsnNbvoHfE9JVsNYF5KB8Gb
 MGscOXxQmvfjQMc0PDsjVHRsMep537YS1Zd9R4L2xmcbXQtihf4iT2iqTjoAvA4hmBBj
 9hNg==
X-Gm-Message-State: APjAAAX2jWE8DpyV2SfctFCcYELnMWlRseDN9H6pHmdkifQo5mwT5Qrj
 xR6qzuHmaq6mJW5sGihmK2/YI4Q=
X-Google-Smtp-Source: APXvYqw+P9k2vez698x4M7kWpp0xm8fcWXI3wOSh/ZQXh7VG/SdR54XSSnqvwlDFdVZj4w7O46j/+7U=
X-Received: by 2002:a65:6713:: with SMTP id u19mr1269816pgf.403.1566515698241; 
 Thu, 22 Aug 2019 16:14:58 -0700 (PDT)
Date: Thu, 22 Aug 2019 16:14:43 -0700
In-Reply-To: <20190822231443.172099-1-scw@google.com>
Message-Id: <20190822231443.172099-3-scw@google.com>
Mime-Version: 1.0
References: <20190822231443.172099-1-scw@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::44a
Subject: [Qemu-devel] [PATCH 2/2] linux-user: time stamping options for
 setsockopt()
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change supports SO_TIMESTAMPNS and SO_TIMESTAMPING for
setsocketopt() with SOL_SOCKET.

The TARGET_SO_TIMESTAMP{NS,ING} constants are already defined for
alpha, hppa, and sparc. In include/uapi/asm-generic/socket.h:

In arch/mips/include/uapi/asm/socket.h:

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/generic/sockbits.h |  4 ++++
 linux-user/mips/sockbits.h    |  4 ++++
 linux-user/syscall.c          | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index e44733c601..5cbafdb49b 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -51,6 +51,10 @@
 #define TARGET_SO_PEERNAME             28
 #define TARGET_SO_TIMESTAMP            29
 #define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
+#define TARGET_SO_TIMESTAMPNS          35
+#define TARGET_SCM_TIMESTAMPNS         TARGET_SO_TIMESTAMPNS
+#define TARGET_SO_TIMESTAMPING         37
+#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
 
 #define TARGET_SO_ACCEPTCONN           30
 
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 0f022cd598..1246b7d988 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -63,6 +63,10 @@
 #define TARGET_SO_PEERNAME             28
 #define TARGET_SO_TIMESTAMP            29
 #define SCM_TIMESTAMP          SO_TIMESTAMP
+#define TARGET_SO_TIMESTAMPNS          35
+#define SCM_TIMESTAMPNS         SO_TIMESTAMPNS
+#define TARGET_SO_TIMESTAMPING         37
+#define SCM_TIMESTAMPING        SO_TIMESTAMPING
 
 #define TARGET_SO_PEERSEC              30
 #define TARGET_SO_SNDBUFFORCE          31
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8dc4255f12..bac00d3fd4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2230,8 +2230,14 @@ set_timeout:
                 optname = SO_PASSSEC;
                 break;
         case TARGET_SO_TIMESTAMP:
-		optname = SO_TIMESTAMP;
-		break;
+                optname = SO_TIMESTAMP;
+                break;
+        case TARGET_SO_TIMESTAMPNS:
+                optname = SO_TIMESTAMPNS;
+                break;
+        case TARGET_SO_TIMESTAMPING:
+                optname = SO_TIMESTAMPING;
+                break;
         case TARGET_SO_RCVLOWAT:
 		optname = SO_RCVLOWAT;
 		break;
-- 
2.23.0.187.g17f5b7556c-goog


