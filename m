Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1691C43468
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 09:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AE8214F1
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T26mQPt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AE8214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJvhN-0000Ic-Cm
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJvfs-00070E-5y
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 05:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJvfp-0002jX-PS
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 05:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600594220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zD9jBe1EmwDBcxarRI11aTqgdpuDo9LGHH5SQT5KW94=;
 b=T26mQPt3+nxEAlM65bmJN54Ig7XyVrgN2teMg8s9ccQn7r0NE3XOGjnh3OlAreQ4vofW2g
 NxVHjaYSVf/A5ETYh3cW54utRKDh3YccnO7qGAEn37dNiblZBi1evkWH21O+vfNsc9wfxk
 u08y+Cl3ko85sZGLjI34IxsNbRmYVRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Gp-Z_fanN96gh_kbumXb9Q-1; Sun, 20 Sep 2020 05:30:18 -0400
X-MC-Unique: Gp-Z_fanN96gh_kbumXb9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9F7710066FF
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 09:30:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E13D1002C04
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 09:30:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] configure: cleanup invocation of submodule Make
Date: Sun, 20 Sep 2020 05:30:13 -0400
Message-Id: <20200920093016.1150346-2-pbonzini@redhat.com>
In-Reply-To: <20200920093016.1150346-1-pbonzini@redhat.com>
References: <20200920093016.1150346-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 03:58:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Move common command line options to SUBDIR_MAKEFLAGS, thus simplifying
the rules themselves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 897246d77c..57fb63832f 100644
--- a/Makefile
+++ b/Makefile
@@ -137,7 +137,12 @@ configure: ;
 .PHONY: all clean distclean install \
 	recurse-all dist msi FORCE
 
-SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
+SUBMODULE_CFLAGS = $(QEMU_CFLAGS) $(CFLAGS)
+SUBDIR_MAKEFLAGS = $(if $(V),,--no-print-directory --quiet)		\
+	PKG_CONFIG="$(PKG_CONFIG)" 					\
+	CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)"		\
+	CFLAGS="$(SUBMODULE_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)"		\
+	ARFLAGS="$(ARFLAGS)"
 
 include $(SRC_PATH)/tests/Makefile.include
 
@@ -146,12 +151,12 @@ Makefile: $(addsuffix /all, $(SUBDIRS))
 
 # LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
-DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
 DTC_CPPFLAGS=-I$(SRC_PATH)/dtc/libfdt
 
 .PHONY: dtc/all
 dtc/all: .git-submodule-status dtc/libfdt
-	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt,)
+	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS)			\
+            CPPFLAGS="$(DTC_CPPFLAGS)" $(SUBDIR_MAKEFLAGS) libfdt,)
 
 dtc/%: .git-submodule-status
 	@mkdir -p $@
@@ -161,7 +166,7 @@ dtc/%: .git-submodule-status
 # Therefore we replicate some of the logic in the sub-makefile.
 # Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
 # no need to annoy QEMU developers with such things.
-CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)
+CAP_CFLAGS := $(patsubst -W%,,$(SUBMODULE_CFLAGS)) $(CAPSTONE_CFLAGS)
 CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
@@ -169,16 +174,17 @@ CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 .PHONY: capstone/all
+capstone/all: SUBMODULE_CFLAGS = $(CAP_CFLAGS)
 capstone/all: .git-submodule-status
-	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone 		\
+            CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" 	\
+            $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
 
 .PHONY: slirp/all
 slirp/all: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
-		BUILD_DIR="$(BUILD_DIR)/slirp" 			\
-		PKG_CONFIG="$(PKG_CONFIG)" 				\
-		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
-		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
+		BUILD_DIR="$(BUILD_DIR)/slirp" 				\
+		$(SUBDIR_MAKEFLAGS))
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
-- 
2.26.2



