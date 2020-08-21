Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B85C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D8920639
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCQbb7A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D8920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94YO-0002uZ-N5
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dn-00020I-0v
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dc-0001c2-Vv
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9HTeGilyaI7wJRI+sU9G7H/jdDDHwvS3kZ8oUXnhBM=;
 b=KCQbb7A5oO/NGLqI3bFTCRdg7O8XUbDhccauwRtvJ1aA4iGKRLrfrlENtrwX+mCR081KXh
 QNTJfk/ZYe5BCVqN01O5VpKhC+kb5gEYwyG8Fq58OXkbK4JiiAz+p7iQXRFu7b3XVuPjMP
 z5vSlmvGXv9sZ1YKi3mC1lr4wHPTVlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-43mEPy-JMwqyLfWQ63W4fw-1; Fri, 21 Aug 2020 06:24:17 -0400
X-MC-Unique: 43mEPy-JMwqyLfWQ63W4fw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C6A2191E2A0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD4B660BF1;
 Fri, 21 Aug 2020 10:24:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 053/152] meson: handle edk2 bios and descriptors
Date: Fri, 21 Aug 2020 06:21:50 -0400
Message-Id: <20200821102329.29777-54-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                        | 29 -----------------------------
 meson.build                     |  1 +
 pc-bios/descriptors/meson.build | 14 ++++++++++++++
 pc-bios/meson.build             | 27 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 29 deletions(-)
 create mode 100644 pc-bios/descriptors/meson.build
 create mode 100644 pc-bios/meson.build

diff --git a/Makefile b/Makefile
index 13df463e33..bc7647d37b 100644
--- a/Makefile
+++ b/Makefile
@@ -127,10 +127,6 @@ generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
-pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
-	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
-
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -274,9 +270,6 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
-ifdef DECOMPRESS_EDK2_BLOBS
-$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
-endif
 
 SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
 $(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
@@ -384,7 +377,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
@@ -461,13 +453,8 @@ edk2-licenses.txt \
 hppa-firmware.img \
 opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
 opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
-
-
-DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
 else
 BLOBS=
-DESCS=
 endif
 
 # Note that we manually filter-out the non-Sphinx documentation which
@@ -544,7 +531,6 @@ install-includedir:
 export DESTDIR
 install: all $(if $(BUILD_DOCS),install-doc) \
 	install-datadir install-localstatedir install-includedir \
-	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
 ifneq ($(TOOLS),)
 	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
@@ -567,21 +553,6 @@ ifneq ($(BLOBS),)
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
-endif
-ifdef INSTALL_BLOBS
-	set -e; for x in $(edk2-decompressed); do \
-		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
-	done
-endif
-ifneq ($(DESCS),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
-	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
-	for x in $(DESCS); do \
-		sed -e 's,@DATADIR@,$(qemu_datadir),' \
-			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
-		$(INSTALL_DATA) "$$tmpf" \
-			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
-	done
 endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
diff --git a/meson.build b/meson.build
index 222b0d0e77..528198b6bd 100644
--- a/meson.build
+++ b/meson.build
@@ -383,6 +383,7 @@ if have_tools
 endif
 
 subdir('tools')
+subdir('pc-bios')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
new file mode 100644
index 0000000000..7c715bace8
--- /dev/null
+++ b/pc-bios/descriptors/meson.build
@@ -0,0 +1,14 @@
+foreach f: [
+  '50-edk2-i386-secure.json',
+  '50-edk2-x86_64-secure.json',
+  '60-edk2-aarch64.json',
+  '60-edk2-arm.json',
+  '60-edk2-i386.json',
+  '60-edk2-x86_64.json'
+]
+  configure_file(input: files(f),
+                 output: f,
+                 configuration: {'DATADIR': config_host['qemu_datadir']},
+                 install: install_blobs,
+                 install_dir: config_host['qemu_datadir'] / 'firmware')
+endforeach
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
new file mode 100644
index 0000000000..6e3bfe3ca4
--- /dev/null
+++ b/pc-bios/meson.build
@@ -0,0 +1,27 @@
+bzip2 = find_program('bzip2')
+
+install_blobs = 'INSTALL_BLOBS' in config_host
+if 'DECOMPRESS_EDK2_BLOBS' in config_host
+  fds = [
+    'edk2-aarch64-code.fd',
+    'edk2-arm-code.fd',
+    'edk2-arm-vars.fd',
+    'edk2-i386-code.fd',
+    'edk2-i386-secure-code.fd',
+    'edk2-i386-vars.fd',
+    'edk2-x86_64-code.fd',
+    'edk2-x86_64-secure-code.fd',
+  ]
+
+  foreach f : fds
+    custom_target(f,
+                  output: f,
+                  input: '@0@.bz2'.format(f),
+                  capture: true,
+                  install: install_blobs,
+                  install_dir: config_host['qemu_datadir'],
+                  command: [ bzip2, '-dc', '@INPUT0@' ])
+  endforeach
+endif
+
+subdir('descriptors')
-- 
2.26.2



