Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8F821655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R30gJOHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8F821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP1A-0002AJ-D1
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz8-0004i3-2i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz6-0008CF-Sl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz6-0008Ax-L3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id c9so2605270wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QbFWObULJeybCtcZDHjGFRdt1cmo+SNSIWE0SWmIUxY=;
 b=R30gJOHd+zEQfutd4N7javH9AFuK4VuCEjrbu6Mo17AwTwuJS/uydQtKgG5c+Sjj6o
 i/KgZDmfSCV+9awLXewXcAUdxEjaEQy0+EZoCMROMTIt8nT+qDFKbfmapTQ6gxdGvTOC
 pwZjeStvBNCixHDhuFL8lbRoTrPtKdg73xOaAMAQmzLJaGk+/RubvFrd3o9tCklwYQdt
 Qnx9Soc79cSZN6R5UThHFyNBMp+jCh55WfTSk2EPEEKYgyU+y3Py94xt5q5l8+sZP1v5
 9kFWVp2gIp7ydN7fuuYNr++r3gqOYuaLbPbnXkXRGdqG64K428nNPm+eKNPSPWNDAqVD
 QAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QbFWObULJeybCtcZDHjGFRdt1cmo+SNSIWE0SWmIUxY=;
 b=uOuGkf+QMYND9jdNB3XaBwkZ4A+UMs+QjrOqsJrzPSw8adNVI+qj6W8SF7rK+ru6gJ
 N2qqusMIRhXTYKtzzTuoWTdt84F1GYDP29jjgRTlkpk/Njr4TACrjjxP0ZRxJEsfT6Xg
 UH31mfglMCLCKCUCMPFMsbaFT670cbZN9qS4TJsIqn7u3sBJjvvSyXydbWEZBBPQJ7T7
 J3pVjP35hU7sQBRN4zFrbN9P+QgmtV2jxf4w7F4gNWPQV6403qkw50RngZLdpfCYHI1k
 kH1fwHNSp3OtSMmJ3D4LK71mAOdqEift5dGxE7uRjqotSO/RJl5tP+bqGVRTVVK2yiQ0
 evEg==
X-Gm-Message-State: APjAAAXnOYDV7ZlhNN2NJzfBwFN0E148efnvaa9okOHEPlziEA38PK7p
 inFfoLGOC7+zpD+PidtgHMO99pKc
X-Google-Smtp-Source: APXvYqyWFxsamZMXHwlydJuAtApJEXL3rrfix4N/57EEyBv3JkVXg3Ma4qxiQg6LnXmsB0d6OMT4cw==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr6193378wrr.116.1576155263491; 
 Thu, 12 Dec 2019 04:54:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 086/132] meson: convert hw/ipmi
Date: Thu, 12 Dec 2019 13:52:10 +0100
Message-Id: <1576155176-2464-87-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      | 1 -
 hw/ipmi/Makefile.objs | 5 -----
 hw/ipmi/meson.build   | 8 ++++++++
 hw/meson.build        | 1 +
 4 files changed, 9 insertions(+), 6 deletions(-)
 delete mode 100644 hw/ipmi/Makefile.objs
 create mode 100644 hw/ipmi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 1dd9f63..7d85aba 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -16,7 +16,6 @@ devices-dirs-y += ide/
 devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
-devices-dirs-$(CONFIG_IPMI) += ipmi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
deleted file mode 100644
index 1b422bb..0000000
--- a/hw/ipmi/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-common-obj-$(CONFIG_IPMI) += ipmi.o
-common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
-common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
-common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
-common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
diff --git a/hw/ipmi/meson.build b/hw/ipmi/meson.build
new file mode 100644
index 0000000..47671ba
--- /dev/null
+++ b/hw/ipmi/meson.build
@@ -0,0 +1,8 @@
+ipmi_ss = ss.source_set()
+ipmi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_LOCAL', if_true: files('ipmi_bmc_sim.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_EXTERN', if_true: files('ipmi_bmc_extern.c'))
+ipmi_ss.add(when: 'CONFIG_ISA_IPMI_KCS', if_true: files('isa_ipmi_kcs.c'))
+ipmi_ss.add(when: 'CONFIG_ISA_IPMI_BT', if_true: files('isa_ipmi_bt.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_IPMI', if_true: ipmi_ss)
diff --git a/hw/meson.build b/hw/meson.build
index db35232..276f9ed 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ipmi')
 subdir('isa')
 subdir('mem')
 subdir('misc')
-- 
1.8.3.1



