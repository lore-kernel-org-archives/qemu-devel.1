Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019CBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDB42173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW0lJV7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDB42173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWID-0008Tk-VF
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8G-0004gI-TW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8F-0000nz-Ol
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8F-0000l6-Gh
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so17116627wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iq04Q8iXl0fdIsz4N/T/ro7/7J4llBrEYyewQ0WC0y0=;
 b=KW0lJV7uR32t3q7j0KwAw3TGsLpajCv/MCQMWsC+GwYz3ccg7AvS+TnQNV9By/sF73
 duvWOz53bNhtWflsEDUwyTdANzr8kJYL5u8pR6iOnq73mXtHOabRDAh/FOfRZJ2M9xRx
 qzqJzSCM1DfYaSDRd5R/vbk3q0Frfw9unQmuaJxIkQylhrmVdvIMCD4Gp0hotCCQmTxA
 VmXeqvofj6x8H25PCCaL5vs9itGDjb9vNlqw479F1mg6jfb3wJp95k3bIhVPtXyPYufx
 76FtQlb9twiAtcLK1B1JoFCO0Mu27xAqDciwEWL+ziN6IsZymfWwRW55FQZiwwYV6HMR
 uwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Iq04Q8iXl0fdIsz4N/T/ro7/7J4llBrEYyewQ0WC0y0=;
 b=dr13GdluFP9/fiEPI4PiP1ciSng665Tjulpxg5qMgdPxMgZyuzWV6Yer5MZLuBzQCN
 hDWLEsn3Wp4qeYB+XhZxfvU3DtZgeO0/Piy6Z08R7NxBPNBHoO9zbMr9vunKjlZV3hzz
 FYcDRg/yMJJUt+S7rij1p/cRhElCBBhoiLvhJhO70tl/EWqdp1U3096zyagn6mNshjWG
 mVwF6TzmE3rDjrqgcXgEmmjnOEtgwFYnBUgYFYJOmXm1q/h7blztloq+oiT9xKXTOEsh
 PjNW1iCd34GT4QCqN62tc1Djy+Sj8oziw2Rzh582MLdLc70BUZ3sD2YLYLOp+6bNa8sY
 CMNg==
X-Gm-Message-State: APjAAAVUhTmlX3zkPs4AHwa+YvHsSHRQEdlXdlasXdMJXn+2ELGn3OF6
 lJFoY72fn6/pUyCVDzdPB29QSuPS
X-Google-Smtp-Source: APXvYqzGSJr9kQLrku6/Ca0timlBlo/pQOMrxP6Zr0uiWAVlKSp2S7zcgUU312jH5aWff6bCPMJBVA==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr31059640wrs.326.1580234314350; 
 Tue, 28 Jan 2020 09:58:34 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 121/142] build-sys/rules.mak: remove version.o
Date: Tue, 28 Jan 2020 18:53:21 +0100
Message-Id: <20200128175342.9066-122-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Makefile      | 5 -----
 Makefile.objs | 4 ----
 rules.mak     | 4 +---
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 91fa9025c9..ddcd39fad5 100644
--- a/Makefile
+++ b/Makefile
@@ -228,11 +228,6 @@ recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
 
-$(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
-	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")
-
-Makefile: $(version-obj-y)
-
 ######################################################################
 
 clean: recurse-clean
diff --git a/Makefile.objs b/Makefile.objs
index 76326e9d22..9fd3932ae0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -55,7 +55,3 @@ common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
 common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 endif
-
-######################################################################
-# Resource file for Windows executables
-version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
diff --git a/rules.mak b/rules.mak
index 162ecb5635..6c6b9098e7 100644
--- a/rules.mak
+++ b/rules.mak
@@ -78,8 +78,6 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
 	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
 	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-%.o: %.rc
-	$(call quiet-command,$(WINDRES) -I. -o $@ $<,"RC","$(TARGET_DIR)$@")
 
 # If we have a CXX we might have some C++ objects, in which case we
 # must link with the C++ compiler, not the plain C compiler.
@@ -87,7 +85,7 @@ LINKPROG = $(or $(CXX),$(CC))
 
 LINK = $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ \
        $(call process-archive-undefs, $1) \
-       $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
+       $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
 %.o: %.S
 	$(call quiet-command,$(CCAS) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-- 
2.21.0



