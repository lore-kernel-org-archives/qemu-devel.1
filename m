Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA2C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5997F20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYmmx94q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5997F20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjd8-0000Bz-HP
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jBjb4-0004xJ-Tt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jBjb2-00022b-Kv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jBjb2-00020n-F1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id s2so6681695pgv.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gBa/eZgenJryGWjkA8q6oRG/FDhBu8JGwHX1oWSrDEI=;
 b=DYmmx94qb8D05NaSaEY1Bq3iYKyYtEGvuyJE8AGczrBiN85W/yVdvUq9mgfELxAgub
 BWZTd1ZVLcZUkmmleaDa2A0RB6aTGqNL0zBHxqrR4f2N1bPeDdGObbQMQaz5T+Jl47aN
 gjFnmryC6Q6jmMPHF6zVeVL5OoJjCPnBsEV0Hq+7AfhDqBLZ54fsyy1SwrNwxndrl8+U
 ndWN8vNOwO66wbKcr+T4ixPjUebsVIqVKKBFov0C+QRF5Rz3PT6LMjZqN1HHLWxuTJbB
 d0C/cJ8g6t0lSF9Sn51xSGgfg5vXkaMElXpbHYw+HKn6AFyyX/p57J+dXtmp6CTcOD5E
 bXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gBa/eZgenJryGWjkA8q6oRG/FDhBu8JGwHX1oWSrDEI=;
 b=ArIG2A3yi8Di9hf7Ti74GEtnkTX6DpuERlZUc+Fgi74VOrH7icjnT1L23m336m1DrT
 Z15L96XFIbOQfT8VKODThxb11AgvIx6hn71zn036s644NFW9euXom0tr+5ZiPkH7mUWW
 vdIWRkD1e/hVW3vuqkC2lVKvbhoWqL33zwG7LDv6ZIviJG7S02E4+TKyfnxw0GT6tCIV
 WQKCL4l9qkpAQZYyVQPjfbXRPRHAe4Qnflf21R4bqtgkRivMdhdsUR1BztoyO2K04h0G
 ShCJaQaLTrl/lsdzLpbTm5MeKX4qttz5POyb/oleDgigMrhB4Ko6/d4K1l91jIRzGi+D
 gtUw==
X-Gm-Message-State: ANhLgQ2VcvDaYNHrlrMqKM+ssQO2fhguIvS9P6O516joMqGwxUBnUbRa
 gyGEfnSt9z+AX/WYDz52KGGBQNk0eUk=
X-Google-Smtp-Source: ADFU+vuUvscJG8gx7WCLvW6mz+AybyvnIVDW/ar6iy53aFartoKQPEL200HGOn/xsI8wo4W8o26lAw==
X-Received: by 2002:a63:a35a:: with SMTP id v26mr23060473pgn.40.1583864835169; 
 Tue, 10 Mar 2020 11:27:15 -0700 (PDT)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p1sm8730692pfq.114.2020.03.10.11.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:27:14 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/10] tests/vm: Add validation of target
Date: Tue, 10 Mar 2020 14:25:27 -0400
Message-Id: <20200310182536.11137-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310182536.11137-1-robert.foley@linaro.org>
References: <20200310182536.11137-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This validation is now useful since some targets
may not be valid if their dependencies are not installed.
Instead of allowing the scripts to fail with missing dependencies
we will fail earlier with a helpful error message.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/Makefile.include | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 1bf9693d19..835e3f3549 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,7 @@
 
 .PHONY: vm-build-all vm-clean-all
 
-IMAGES := freebsd netbsd openbsd centos fedora
+IMAGES := freebsd netbsd openbsd fedora
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
 endif
@@ -49,9 +49,20 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
 vm-clean-all:
 	rm -f $(IMAGE_FILES)
 
+# Validate the target since some targets will not
+# be valid if their software dependencies are not installed.
+define validate_target
+	@echo $(1) | grep $(2) || \
+	(echo "Invalid target ($(2))"; \
+	echo "Valid Targets are: $(1)"; \
+	echo "See make vm-help for more information."; \
+	exit 1;)
+endef
+
 $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 			$(SRC_PATH)/tests/vm/basevm.py \
 			$(SRC_PATH)/tests/vm/Makefile.include
+	$(call validate_target,${IMAGES},$*)
 	@mkdir -p $(IMAGES_DIR)
 	$(call quiet-command, \
 		$(PYTHON) $< \
@@ -64,6 +75,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 
 # Build in VM $(IMAGE)
 vm-build-%: $(IMAGES_DIR)/%.img
+	$(call validate_target,${IMAGES},$*)
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(V)$(DEBUG), --debug) \
@@ -79,6 +91,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		"  VM-BUILD $*")
 
 vm-boot-serial-%: $(IMAGES_DIR)/%.img
+	$(call validate_target,${IMAGES},$*)
 	qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nographic \
 		-drive if=none,id=vblk,cache=writeback,file="$<" \
 		-netdev user,id=vnet \
@@ -87,6 +100,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 	|| true
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
+	$(call validate_target,${IMAGES},$*)
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
-- 
2.17.1


