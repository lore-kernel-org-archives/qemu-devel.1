Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1ACC2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B902084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B902084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNCVh-0007lQ-3a
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cfontana@suse.de>) id 1jNCUa-0006rj-2b
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cfontana@suse.de>) id 1jNCUY-0005np-B7
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:31:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cfontana@suse.de>) id 1jNCUY-0005mz-2L
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:31:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 96D82ADED;
 Sat, 11 Apr 2020 09:31:55 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe Mathieu-Daude <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RESEND v3 1/2] Makefile: libfdt: build only the strict
 necessary
Date: Sat, 11 Apr 2020 11:31:49 +0200
Message-Id: <20200411093150.4741-2-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200411093150.4741-1-cfontana@suse.de>
References: <20200411093150.4741-1-cfontana@suse.de>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Claudio Fontana <cfontana@suse.de>, Alex Bennee <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

when building dtc/libfdt, we were previously using dtc/Makefile,
which tries to build some artifacts that are not needed,
and can complain on stderr about the absence of tools that
are not required to build just libfdt.

Instead, build only the strict necessary to get libfdt.a .

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 Makefile  | 21 +++++++++++++--------
 configure |  4 ----
 rules.mak |  2 ++
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 84ef881600..7be15eeb7c 100644
--- a/Makefile
+++ b/Makefile
@@ -4,6 +4,10 @@ ifneq ($(words $(subst :, ,$(CURDIR))), 1)
   $(error main directory cannot contain spaces nor colons)
 endif
 
+# some pattern rules in rules.mak are confused by an empty DSOSUF,
+# and UNCHECKED_GOALS for testing (docker-) can run without prior configure.
+DSOSUF ?= ".so"
+
 # Always point to the root of the build tree (needs GNU make).
 BUILD_DIR=$(CURDIR)
 
@@ -526,15 +530,17 @@ $(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
 $(TARGET_DIRS_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
-DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
-DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
-DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
-
+LIBFDT_objdir = dtc/libfdt
+-include $(SRC_PATH)/dtc/libfdt/Makefile.libfdt
+LIBFDT_objects = $(addprefix $(LIBFDT_objdir)/, $(LIBFDT_OBJS))
+# the name dtc/all is for backward compatibility
 .PHONY: dtc/all
-dtc/all: .git-submodule-status dtc/libfdt dtc/tests
-	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
+dtc/all: .git-submodule-status $(LIBFDT_objdir)/libfdt.a
+$(LIBFDT_objdir)/libfdt.a: $(LIBFDT_objects)
+	$(if $(LIBFDT_objects),$(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$(TARGET_DIR)$@"),)
 
-dtc/%: .git-submodule-status
+$(LIBFDT_objects): | $(LIBFDT_objdir)
+$(LIBFDT_objdir): .git-submodule-status
 	@mkdir -p $@
 
 # Overriding CFLAGS causes us to lose defines added in the sub-makefile.
@@ -821,7 +827,6 @@ distclean: clean
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
-	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
 ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
diff --git a/configure b/configure
index 233c671aaa..cf32bfb75b 100755
--- a/configure
+++ b/configure
@@ -4278,10 +4278,6 @@ EOF
       if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
           fdt=git
           mkdir -p dtc
-          if [ "$pwd_is_source_path" != "y" ] ; then
-              symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-              symlink "$source_path/dtc/scripts" "dtc/scripts"
-          fi
           fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
           fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
           fdt_libs="$fdt_libs"
diff --git a/rules.mak b/rules.mak
index 694865b63e..61eb474ba4 100644
--- a/rules.mak
+++ b/rules.mak
@@ -105,6 +105,8 @@ LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
 
 DSO_OBJ_CFLAGS := -fPIC -DBUILD_DSO
 module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
+
+# Note: DSOSUF must not be empty, or these rules will try to match too much
 %$(DSOSUF): QEMU_LDFLAGS += $(LDFLAGS_SHARED)
 %$(DSOSUF): %.mo
 	$(call LINK,$^)
-- 
2.16.4


