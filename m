Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37792C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A842065C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzwUezHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A842065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bez-0001uP-QK
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJi-0007vq-CB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJf-0002tj-9K
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQrkgKjG8LCrNKK/Hk46+rS84jqD20L7o4hLhkWF7oM=;
 b=OzwUezHDLctunnriXGR1b2Qj9POwuRAyEM+UBZafOeS343Kl2Bmit5QnpyI9gmm0v2xT+V
 vvxYeu9BAGnW8bm6ln+4HflRiBw09o4b5EtvM3YRqwxNwCPjhSD8+ek1DCuvGfo/4T+VSH
 gs1k8KnpstTHc8ptWbuOUtpvNFB5gEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-RpUULCj-OJO15gbecTZ-0g-1; Mon, 10 Aug 2020 13:10:28 -0400
X-MC-Unique: RpUULCj-OJO15gbecTZ-0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 971A419067E1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:27 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A456D5F1E9;
 Mon, 10 Aug 2020 17:10:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 047/147] meson: generate hxtool files
Date: Mon, 10 Aug 2020 19:07:25 +0200
Message-Id: <1597079345-42801-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 13:09:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile        |  8 +-------
 Makefile.target |  6 ------
 meson.build     | 22 ++++++++++++++++++++++
 scripts/hxtool  |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/Makefile b/Makefile
index f7af925..b9260a1 100644
--- a/Makefile
+++ b/Makefile
@@ -105,7 +105,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y = config-host.h qemu-options.def
+generated-files-y = config-host.h
 
 generated-files-y += module_block.h
 
@@ -247,8 +247,6 @@ all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all mo
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
@@ -355,9 +353,6 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
@@ -375,7 +370,6 @@ clean: recurse-clean
 	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
-	rm -f qemu-img-cmds.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 	rm -f $(SUBDIR_DEVICES_MAK)
diff --git a/Makefile.target b/Makefile.target
index 0b32364..257afc2 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -225,12 +225,6 @@ endif
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
-hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
-
-hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
-
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
diff --git a/meson.build b/meson.build
index e007c98..0c4988a 100644
--- a/meson.build
+++ b/meson.build
@@ -138,6 +138,7 @@ have_block = have_system or have_tools
 # Generators
 
 genh = []
+hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
@@ -175,6 +176,27 @@ qemu_version = custom_target('qemu-version.h',
                              build_always_stale: true)
 genh += qemu_version
 
+hxdep = []
+hx_headers = [
+  ['qemu-options.hx', 'qemu-options.def'],
+  ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
+]
+if have_system
+  hx_headers += [
+    ['hmp-commands.hx', 'hmp-commands.h'],
+    ['hmp-commands-info.hx', 'hmp-commands-info.h'],
+  ]
+endif
+foreach d : hx_headers
+  custom_target(d[1],
+                input: files(d[0]),
+                output: d[1],
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                command: [hxtool, '-h', '@INPUT0@'])
+endforeach
+genh += hxdep
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
diff --git a/scripts/hxtool b/scripts/hxtool
old mode 100644
new mode 100755
index 7b1452f..80516b9
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -19,6 +19,6 @@ hxtoh()
 case "$1" in
 "-h") hxtoh ;;
 *) exit 1 ;;
-esac
+esac < "$2"
 
 exit 0
-- 
1.8.3.1



