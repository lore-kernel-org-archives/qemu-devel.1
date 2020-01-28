Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D88214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI/nj3n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D88214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVyK-0004Mz-65
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7C-0002oQ-RE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7B-0006rz-2G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7A-0006mA-O0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:28 -0500
Received: by mail-wr1-x42e.google.com with SMTP id d16so17103969wre.10
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jTtxJQkBDu70X/POU8aSyGlM22aA2+trvcXY6kTrxiA=;
 b=tI/nj3n326gNAWfjxP7cuhpEtVZfM5AOnl+oO3RVrSmEZuS865UrW9uLFb7gqApu+j
 3B2zg0XUPu9WHKPAoVbevyS4zhB1LS3NRw332RQTAAysSclM7jlxd9AnkxRi2+KxuEAj
 wmVJledjbk6D7VF/ZZf1/9hzT+Ww0naWGGcIEy1lDnoGIJmkqd28Rr5YxPqN1380y3CY
 5QW8H7/MT9wY+0FWTXqhcyXRlHu6fQqOZTBArZV3RX7Cx1VJ+Im6cUKaCoAjAaA24kH8
 yQ96ken3qUIk6YpR7qm0ZVgP8qT//nCf8zhyOIKBKGsaXkOmdhAdtCCkPVvHVqken+fA
 0z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jTtxJQkBDu70X/POU8aSyGlM22aA2+trvcXY6kTrxiA=;
 b=P5eHrn3xDJ9NMbS6AIMdgytA/tiBq+tyDy4648Y33X5PnD/fR8TO3cNgC1042tPN5h
 S9Nu6gm3rCYNof+7lSswf6cF37vJBmmG8m0k/v6cl1zryV6SAggYTX1IN2RrSZkZFJsx
 WD157cEMB/d7EGCV5spnQYyvEwyXsl822z67nHOeJ/zlvLL3ZMcWpLR1o7jyhxeAGWSr
 JAeygq/jTCbEdqfFM/w5MMcfVqan9u7sPjCiijfEK2bXqzSVgw0ZqkS85osijY/H5qzt
 qBch5V74rnMlE4fRthiLO00h66ZSnGnYi9WiJl+iAMa0Ch8/qnseDIjXpAQ8bPSvmQq4
 TEIw==
X-Gm-Message-State: APjAAAUsjAokySxDf9W8snaPsa4UJrhwgttMhMX66LIzNhp9gLGLgSDQ
 2s2/3vWCReH29PTg3NSUCygT/seW
X-Google-Smtp-Source: APXvYqy6Pcb3TyLRrieEP1UrQvNDv00r0qf+pr3x/jgPJuIS8Ny9N+Gc5VJMcDBpljgzPNyY3nUlAw==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr31054531wrs.326.1580234246482; 
 Tue, 28 Jan 2020 09:57:26 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 093/142] meson: convert hw/isa
Date: Tue, 28 Jan 2020 18:52:53 +0100
Message-Id: <20200128175342.9066-94-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     |  1 -
 hw/isa/Makefile.objs | 11 -----------
 hw/isa/meson.build   | 11 +++++++++++
 hw/meson.build       |  1 +
 4 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 hw/isa/Makefile.objs
 create mode 100644 hw/isa/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ea808bc4f4..e5f4308436 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -16,7 +16,6 @@ devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
-devices-dirs-y += isa/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
deleted file mode 100644
index 8e73960a75..0000000000
--- a/hw/isa/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_SUPERIO) += isa-superio.o
-common-obj-$(CONFIG_APM) += apm.o
-common-obj-$(CONFIG_I82378) += i82378.o
-common-obj-$(CONFIG_PC87312) += pc87312.o
-common-obj-$(CONFIG_PIIX3) += piix3.o
-common-obj-$(CONFIG_PIIX4) += piix4.o
-common-obj-$(CONFIG_VT82C686) += vt82c686.o
-common-obj-$(CONFIG_SMC37C669) += smc37c669-superio.o
-
-obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
new file mode 100644
index 0000000000..8bf678ca0a
--- /dev/null
+++ b/hw/isa/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(when: 'CONFIG_APM', if_true: files('apm.c'))
+softmmu_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
+softmmu_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX3', if_true: files('piix3.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX4', if_true: files('piix4.c'))
+softmmu_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
+softmmu_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
+
+specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 6ca82b0375..86598544e6 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('isa')
 subdir('mem')
 subdir('misc')
 subdir('net')
-- 
2.21.0



