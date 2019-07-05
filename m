Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A6C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD652133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpCwa0XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD652133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVJy-0003ih-OI
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkT-0004ZW-EG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkR-00034n-Gz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUkR-0002m1-0W
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id p74so7246064wme.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1Q2/Kno8eBtSRnDs1aukgO8GHqqzId6Tt8OoZfKY3WI=;
 b=GpCwa0XAqILHwkgw3pwQtNifuwZybLcvwyq/aHf3X1x5qCfbFZjCxACGd9WaZXSVqJ
 MjwvhvgcNLSk+aHQQTXYyWLE5T1kruEzSVD5QJuhnLpKd+KbL4QZ8eSPg4sAIWOaAG2a
 G3m6IfQWH2MD5miMvalN4xrkv3z1b2z9qbL032wtE14kyngS6ySpdD+vWL/LYHkPssr2
 mg4ak9WyouhJVC1Uickvv3pLexzySKV8V29ifiBNk1IbTtX80eX0oi00acNzJfFc9HzJ
 Ammt7jjUXYGT91p4Xy+Z4m6pd6bgdQAIrqh+hrwq4xNNkP/g3TE6mXO/FZ5NhAziMGn6
 QLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=1Q2/Kno8eBtSRnDs1aukgO8GHqqzId6Tt8OoZfKY3WI=;
 b=bzWE+eEsgNmCIYl9LZPHZvG3XFQpaLjAmoQ2kAQH+/2VCfJv3+zNGFh/X6xyjkXCEe
 AeplXlVIDf0zB0dzIYOG9/Njm9Rk7QOZPnj6AFNFJ8QMYLzwkk93eLmcrqkB4fZyunRP
 VFi8iAPHsalFt5KKbN0+xtuX3Pehh5XHFT/2iKWEAcZX/6P2eWsKimk/ldWsIviODNiC
 XSp2+dBw+xBMlae8Me8VPRkVTqx33fUYMfmnFUTRQ9TkSjqnMXwuPg+bctZJPXtYecXD
 lh63phk9mBHpHmO6G+VUW2O7c/ncYhlNdCpqq/D4q1XXL1RBM3iEJCDxPNRVhjmOumlR
 wNTw==
X-Gm-Message-State: APjAAAWSACL+JCmEs40+a/nckFfpY4I0HwCcGTyd6Bayhy6CrtkfhZxp
 roLidA8cHaPgnW7DaGo7ZiJ9QXwtfZU=
X-Google-Smtp-Source: APXvYqwJdYkd8oQYoek8/tt4O8IK5Ue9HwJKJTO0S7+EO3kt5dGFi7Zks8p23Og/n3pT+JvskQBmPw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr678085wmk.79.1562358212808;
 Fri, 05 Jul 2019 13:23:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:20 +0200
Message-Id: <1562358202-28008-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 10/12] Makefile: generate header file with the
 list of devices enabled
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
Cc: Julio Montes <julio.montes@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julio Montes <julio.montes@intel.com>

v2: generate config-devices.h which contains the list of devices enabled

Message-Id: <20190705143554.10295-1-julio.montes@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Julio Montes <julio.montes@intel.com>
---
 Makefile.target       | 4 ++++
 scripts/create_config | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index 72c267f..7154e99 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -45,6 +45,9 @@ include $(SRC_PATH)/tests/tcg/Makefile.include
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
 
+config-devices.h: config-devices.h-timestamp
+config-devices.h-timestamp: config-devices.mak
+
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp
 
@@ -168,6 +171,7 @@ obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
 generated-files-y += hmp-commands.h hmp-commands-info.h
+generated-files-y += config-devices.h
 
 endif # CONFIG_SOFTMMU
 
diff --git a/scripts/create_config b/scripts/create_config
index d727e5e..00e86c8 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -58,6 +58,8 @@ case $line in
     name=${line%=*}
     echo "#define $name 1"
     ;;
+ CONFIG_*=n) # configuration
+    ;;
  CONFIG_*=*) # configuration
     name=${line%=*}
     value=${line#*=}
-- 
1.8.3.1



