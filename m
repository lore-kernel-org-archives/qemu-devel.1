Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBD021655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYkhY3in"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBD021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOyz-0007vu-Mj
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz7-0004gW-5n
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz5-0008AX-Ue
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:25 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz5-00089I-Nu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id z3so2635594wru.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=17AHPCiKqOOmjq+krq1JE+g+YqSwYJy649/fcGzFxRw=;
 b=VYkhY3inx5x7P26CbLw2wwpMxtGniyObKYem5/Km0o0InA1707HORqugSpaqkWVJB6
 ML6iJE679x1QpOVDpXFRws+izClEyo6g06XBiDDhGcWzBe2vs884n3/jOiaGrRtlHN19
 UoqiTH8NUMY2UIFw6SvQZcQ7FYvXaXey8db9mqV8zDgzA4x8U14I1ThFriD6PDIX1WrN
 jZxGqyMtrgsr35wdxzMCOtPRikkYjjBwFywxw1LDxMHcNbtgkxcblQEMnu3wMBP1DKvJ
 5lGoJ/+PnDOdHCfMkXD+tRfy8Kfq31wDG2U1Pvpb3gZuVyjANvPe+FLntkDMNDD429nq
 IEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=17AHPCiKqOOmjq+krq1JE+g+YqSwYJy649/fcGzFxRw=;
 b=cJD9B3YvhQuLXOzphVuLYMlNxvLWnTytdqe+FYRePzKfNQAR2A+95nFATTnCXiCsLW
 73OwRmbbTQDz4OXogl5VjU8EfbZyQHv3By1lQhAbwRmLGrKguYXZCPtpPB05ahFLfB5b
 bfUeM9vZVPfxVq5Mcojd+aTh0MCBv/o3NvVSKrOVfAqsj5OTiIsx+Pmx6Bioil+YT8zg
 iZRnseWDjOCCnOS4Q6wBrWrjbLfvb5+h58DkOIErL0LyDUfKUJGNVbtCCbbN3CBa4NfF
 mGjldfbzxIY4kkkB0kZshnS0kpl9ZGvn3sMeK3kpTwN5P14uAC9yUi2Ad/KSs+98b94Y
 GHTA==
X-Gm-Message-State: APjAAAVJh5VTmc9T2npw8V7yuXD0QYzs/9EtQErnddYcHWSLGsmjFWX/
 uMG3ufIQ2XZkBh15vD1cnaCOgUWI
X-Google-Smtp-Source: APXvYqxzUzfN/8aNbM6k4GBe/blJQ9BedXM8d5r26BRaJxVU6ZVpxk8Pnbmj9wZbxMkNsAmjVel7Og==
X-Received: by 2002:a05:6000:12c9:: with SMTP id
 l9mr6528904wrx.304.1576155262573; 
 Thu, 12 Dec 2019 04:54:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 085/132] meson: convert hw/isa
Date: Thu, 12 Dec 2019 13:52:09 +0100
Message-Id: <1576155176-2464-86-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     |  1 -
 hw/isa/Makefile.objs | 10 ----------
 hw/isa/meson.build   |  9 +++++++++
 hw/meson.build       |  1 +
 4 files changed, 10 insertions(+), 11 deletions(-)
 delete mode 100644 hw/isa/Makefile.objs
 create mode 100644 hw/isa/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e630c54..1dd9f63 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -17,7 +17,6 @@ devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
-devices-dirs-y += isa/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
deleted file mode 100644
index 9e106df..0000000
--- a/hw/isa/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
-common-obj-$(CONFIG_APM) += apm.o
-common-obj-$(CONFIG_I82378) += i82378.o
-common-obj-$(CONFIG_PC87312) += pc87312.o
-common-obj-$(CONFIG_PIIX4) += piix4.o
-common-obj-$(CONFIG_VT82C686) += vt82c686.o
-common-obj-$(CONFIG_SMC37C669) += smc37c669-superio.o
-
-obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
new file mode 100644
index 0000000..729f799
--- /dev/null
+++ b/hw/isa/meson.build
@@ -0,0 +1,9 @@
+softmmu_ss.add(when: 'CONFIG_APM', if_true: files('apm.c'))
+softmmu_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c', 'isa-superio.c'))
+softmmu_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
+softmmu_ss.add(when: 'CONFIG_PIIX4', if_true: files('piix4.c'))
+softmmu_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
+softmmu_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
+
+specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
diff --git a/hw/meson.build b/hw/meson.build
index c83f37c..db35232 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('isa')
 subdir('mem')
 subdir('misc')
 subdir('net')
-- 
1.8.3.1



