Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E12C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FE522242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUkdjHSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE522242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2xJ-0007Ys-IA
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2ud-0005eK-4b
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uS-0001l8-OZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbOo8wEROhvuapUxi+spC7ph9cftlZ0pa+Ca7HtewbE=;
 b=MUkdjHSi1EKhZogjI+nWlKLst0IaB5NhWs8p38f71GdXh9OxCPHNLRMKR5hhH851n/D/PK
 FhO2tzZaIyh01zm6ZUlCCmDVd6rIRAPQmwaB0W5+kTPDIjlVgJcqp3sDIZtVZYR/4sRJz4
 1G9FuSPiHUelC+p82XUZbJgbazBnnNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-2zJMmNioPzKPkXKfCoJg1A-1; Mon, 26 Oct 2020 09:51:36 -0400
X-MC-Unique: 2zJMmNioPzKPkXKfCoJg1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C69188C12D;
 Mon, 26 Oct 2020 13:51:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 384D96EF67;
 Mon, 26 Oct 2020 13:51:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] Makefile: separate meson rerun from the rest of the
 ninja invocation
Date: Mon, 26 Oct 2020 09:51:22 -0400
Message-Id: <20201026135131.3006712-9-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Havard Skinnemoen <hskinnemoen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The rules to build Makefile.mtest are suffering from the "tunnel vision"
problem that is common with recursive makefiles.  Makefile.mtest depends
on build.ninja, but Make does not know when build.ninja needs to be
rebuilt before creating Makefile.mtest.

To fix this, separate the ninja invocation into the "regenerate build
files" phase and the QEMU build phase.  Sentinel files such as
meson-private/coredata.dat or build.ninja are used to figure out the
phases that haven't run yet; however, because those files' timestamps
are not guaranteed to be touched, the usual makefile stamp-file trick
is used on top.

Reported-by: Havard Skinnemoen <hskinnemoen@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 18f026eac3..5236464d1f 100644
--- a/Makefile
+++ b/Makefile
@@ -92,6 +92,8 @@ endif
 ifeq ($(NINJA),)
 .PHONY: config-host.mak
 x := $(shell rm -rf meson-private meson-info meson-logs)
+else
+export NINJA
 endif
 ifeq ($(wildcard build.ninja),)
 .PHONY: config-host.mak
@@ -100,31 +102,44 @@ endif
 
 # 1. ensure config-host.mak is up-to-date
 config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
-	@echo $@ is out-of-date, running configure
+	@echo config-host.mak is out-of-date, running configure
 	@if test -f meson-private/coredata.dat; then \
 	  ./config.status --skip-meson; \
 	else \
-	  ./config.status; \
+	  ./config.status && touch build.ninja.stamp; \
 	fi
 
-# 2. ensure generated build files are up-to-date
+# 2. meson.stamp exists if meson has run at least once (so ninja reconfigure
+# works), but otherwise never needs to be updated
+meson-private/coredata.dat: meson.stamp
+meson.stamp: config-host.mak
+	@touch meson.stamp
+
+# 3. ensure generated build files are up-to-date
 
 ifneq ($(NINJA),)
-# A separate rule is needed for Makefile dependencies to avoid -n
-export NINJA
 Makefile.ninja: build.ninja
-	$(quiet-@){ echo 'ninja-targets = \'; $(NINJA) -t targets all | sed 's/:.*//; $$!s/$$/ \\/'; } > $@
+	$(quiet-@){ \
+	  echo 'ninja-targets = \'; \
+	  $(NINJA) -t targets all | sed 's/:.*//; $$!s/$$/ \\/'; \
+	  echo 'build-files = \'; \
+	  $(NINJA) -t query build.ninja | sed -n '1,/^  input:/d; /^  outputs:/q; s/$$/ \\/p'; \
+	} > $@.tmp && mv $@.tmp $@
 -include Makefile.ninja
+
+# A separate rule is needed for Makefile dependencies to avoid -n
+build.ninja: build.ninja.stamp
+build.ninja.stamp: meson.stamp $(build-files)
+	$(NINJA) $(if $V,-v,) build.ninja && touch $@
 endif
 
 ifneq ($(MESON),)
-# The dependency on config-host.mak ensures that meson has run
-Makefile.mtest: build.ninja scripts/mtest2make.py config-host.mak
+Makefile.mtest: build.ninja scripts/mtest2make.py
 	$(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
 -include Makefile.mtest
 endif
 
-# 3. Rules to bridge to other makefiles
+# 4. Rules to bridge to other makefiles
 
 ifneq ($(NINJA),)
 NINJAFLAGS = $(if $V,-v,) \
@@ -135,7 +150,10 @@ ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach t, $(.tests), $(.test.deps.$t))
 
 makefile-targets := build.ninja ctags TAGS cscope dist clean uninstall
-ninja-targets := $(filter-out $(makefile-targets), $(ninja-targets))
+# "ninja -t targets" also lists all prerequisites.  If build system
+# files are marked as PHONY, however, Make will always try to execute
+# "ninja build.ninja".
+ninja-targets := $(filter-out $(build-files) $(makefile-targets), $(ninja-targets))
 .PHONY: $(ninja-targets) run-ninja
 $(ninja-targets): run-ninja
 
@@ -214,7 +232,7 @@ distclean: clean
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f *-config-target.h *-config-devices.mak *-config-devices.h
 	rm -rf meson-private meson-logs meson-info compile_commands.json
-	rm -f Makefile.ninja Makefile.mtest
+	rm -f Makefile.ninja Makefile.mtest build.ninja.stamp meson.stamp
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -Rf .sdk
-- 
2.26.2



