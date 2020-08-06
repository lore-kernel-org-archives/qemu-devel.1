Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC481C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFEF2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDRO+xZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFEF2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lll-0005FC-1Z
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lP5-0006Ih-RJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lP2-0006ZJ-VH
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=pr4QTt/HZPr7zUdK92jy0446eeaM5JTvvBfGRq/mcyo=;
 b=bDRO+xZaL+YZ6WxiTpCdAkurXmxk0U7diauNkHfE3b11IejaEmRoGU2gGve+55ni11yUeE
 nMZIsR4q3NfuUaSDBDkQoWDJ2Cyqx7PchsWsUaApqldSXot/4N46ywAKVnvvEXjQTrfGJ8
 oTMgVNf6mV9NqyahmSk0537I3mGvotE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-q2e8piDGOGuv0iml4cyoTw-1; Thu, 06 Aug 2020 15:18:10 -0400
X-MC-Unique: q2e8piDGOGuv0iml4cyoTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FFC100AA21
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:09 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2FCC5F9DC
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 061/143] configure, Makefile;
 remove TOOLS and HELPERS-y variable
Date: Thu,  6 Aug 2020 21:14:57 +0200
Message-Id: <1596741379-12902-62-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 12:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Everything involving tools is now done by meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 22 ++--------------------
 configure |  7 -------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 50e02c0..6e8e541 100644
--- a/Makefile
+++ b/Makefile
@@ -123,8 +123,6 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y =
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -173,7 +171,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
@@ -284,7 +282,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
+	rm -f TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 
@@ -439,12 +437,6 @@ install: all $(if $(BUILD_DOCS),install-doc) \
 	install-datadir install-localstatedir install-includedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
-ifneq ($(TOOLS),)
-	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
-endif
-ifneq ($(HELPERS-y),)
-	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
@@ -719,16 +711,6 @@ endif
 				$(call print-help-run,$(t)/fuzz,Build fuzzer for $(t)); \
 		))) \
 		echo '')
-	@$(if $(HELPERS-y), \
-		echo 'Helper targets:'; \
-		$(foreach t, $(HELPERS-y), \
-		$(call print-help-run,$(t),Build $(shell basename $(t)));) \
-		echo '')
-	@$(if $(TOOLS), \
-		echo 'Tools targets:'; \
-		$(foreach t, $(TOOLS), \
-		$(call print-help-run,$(t),Build $(shell basename $(t)) tool);) \
-		echo '')
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/configure b/configure
index 962e314..f99b7ee 100755
--- a/configure
+++ b/configure
@@ -6641,12 +6641,6 @@ if [ "$eventfd" = "yes" ]; then
   ivshmem=yes
 fi
 
-tools=""
-if test "$want_tools" = "yes" ; then
-  if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
-    tools="qemu-storage-daemon\$(EXESUF) $tools"
-  fi
-fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
@@ -7740,7 +7734,6 @@ else
   QEMU_INCLUDES="-iquote ${source_path}/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
 
-echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "INSTALL=$install" >> $config_host_mak
-- 
1.8.3.1



