Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCC9C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF4F21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sp55rzD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4F21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhz3-0005wE-4T
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrH-0005Jw-1T
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrF-0003IX-NS
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrF-0003Hm-HN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id r19so7971682wmh.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OfES0nT3k6Z9LTQ7lYjY3cIAvS5cOEPfvSwDFax1+oI=;
 b=sp55rzD4mHywNngoU3mlFw0WfGRnvEfa6IoPKvHFS3fMPXXVDk5BTEcfcZfzoa82mX
 +h85Q5XKmok0hiDnfgx+sqscYk3qA1XKS5v5/874qBjHwm/yWLy51E4FGzWkxTKzvZNM
 boiNhWIkuMTNY9AXxK6TPZmdsPpQwwE3gotq3lRf5KEjIn5tSsWd/ckboLRJIAuGmeM3
 HOwy8KyGZUrBjFgas48zKeNUOwoQxWWnYBIF3yH1WGWDOkk63aulI5tIGvCYfJl/xqdc
 gLEDAdcmG7zl8br7k1zhi0Ub2sGKN+WCBk7zGEurGne2CBqb9gpbBW70YEcm8nFEe1Ox
 454Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OfES0nT3k6Z9LTQ7lYjY3cIAvS5cOEPfvSwDFax1+oI=;
 b=oKN6gSDWDBnQH3aqUIwW6DJVjdxxaiAkz/HOUE35RZN9xgEp1oXblaLHqmeLNbk2yF
 xbY5ksvkT5KJpBlZvRb40kfu3qzLhC3w43UjrtVfw8urtciMDeo5Uj9SCGq6f0eAV/4b
 Qj89nsD1O3ZrWR9yOkaBV4JvZOJrPop3n8Xy42+R57htk6f1/XZ0osBbBT9Mknc05E+e
 mlidmsSETmthi1pAe7gmOkM2T6/U9kgkrC15YR7xlyEEKUoazGVq393IMAnQlrDUGpp7
 utB0T5p0fzfkU+Y5gkI/pgy84GBGw6B3XhjUrHHKORp1vW3zzq5zRGvJnvqWciEQFLpJ
 LhXQ==
X-Gm-Message-State: APjAAAWDcDfFCWLM39xbWo71T6gEOMnab+pw9qj65I1FYiIAqZ2/cjnT
 A5TvHc6o8b6gh5QR0qIr5GM1lluY
X-Google-Smtp-Source: APXvYqzktRvSs54ozypdhBgAjRyW34oohMdJDQlTbQk6il5ofaTuTr9DVedQMASJVA5HOW7FQXYFmg==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr3486276wmf.72.1570035128153; 
 Wed, 02 Oct 2019 09:52:08 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for
 isa-superio.c
Date: Wed,  2 Oct 2019 18:51:36 +0200
Message-Id: <1570035113-56848-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Currently, isa-superio.c is always compiled as soon as CONFIG_ISA_BUS
is enabled. But there are also machines that have an ISA BUS without
any of the superio chips attached to it, so we should not compile
isa-superio.c in case we only compile a QEMU for such a machine.
Thus add a proper CONFIG_ISA_SUPERIO switch so that this file only gets
compiled when we really, really need it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/Kconfig       | 10 +++++++---
 hw/isa/Makefile.objs |  2 +-
 hw/mips/Kconfig      |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 6db0d79..98a2899 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -13,9 +13,13 @@ config I82378
     select MC146818RTC
     select PCSPK
 
-config PC87312
+config ISA_SUPERIO
     bool
     select ISA_BUS
+
+config PC87312
+    bool
+    select ISA_SUPERIO
     select I8259
     select I8254
     select I8257
@@ -34,14 +38,14 @@ config PIIX4
 
 config VT82C686
     bool
-    select ISA_BUS
+    select ISA_SUPERIO
     select ACPI_SMBUS
     select SERIAL_ISA
     select FDC
 
 config SMC37C669
     bool
-    select ISA_BUS
+    select ISA_SUPERIO
     select SERIAL_ISA
     select PARALLEL
     select FDC
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index 9e106df..ff97485 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
+common-obj-$(CONFIG_ISA_SUPERIO) += isa-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 62aa01b..2c2adbc 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -13,6 +13,7 @@ config R4K
 
 config MALTA
     bool
+    select ISA_SUPERIO
 
 config MIPSSIM
     bool
-- 
1.8.3.1



