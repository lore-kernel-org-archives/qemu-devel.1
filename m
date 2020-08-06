Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1550A2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGe/sACc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1550A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lfa-0008PW-R7
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOf-0005JY-Ja
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43059
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOd-0006VG-PJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YqaMLtGfOgB3dU4xVatVkX2maMcVKw80//hZqF7h2U=;
 b=WGe/sACc/O/3cZAN3NHExnu6lxDJtsQvOGMMy5l+brriuEV9OopoN3b2DdjgzgMwEny5AD
 5VPOOluVLOCUX9JlTLpYOe4QNCA3Wj2Io7Et7gWIvvlmEJXoiRyHkxB13htARwK1zj+L/Z
 3mFq4bKApBsY7BWrd6VV0b0bhVySJW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-FNHCbfCiOpyNHES5A8Ni_g-1; Thu, 06 Aug 2020 15:17:45 -0400
X-MC-Unique: FNHCbfCiOpyNHES5A8Ni_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E567100AA21
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:44 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A03CB5FC3B;
 Thu,  6 Aug 2020 19:17:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 045/143] meson: uncompress edk2 bios
Date: Thu,  6 Aug 2020 21:14:41 +0200
Message-Id: <1596741379-12902-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 Makefile            |  7 -------
 meson.build         |  1 +
 pc-bios/meson.build | 23 +++++++++++++++++++++++
 3 files changed, 24 insertions(+), 7 deletions(-)
 create mode 100644 pc-bios/meson.build

diff --git a/Makefile b/Makefile
index 984f784..d277681 100644
--- a/Makefile
+++ b/Makefile
@@ -112,9 +112,6 @@ generated-files-y += module_block.h
 generated-files-y += .git-submodule-status
 
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
-pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
-	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
-
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -258,9 +255,6 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
-ifdef DECOMPRESS_EDK2_BLOBS
-$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
-endif
 
 SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
 $(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
@@ -367,7 +361,6 @@ clean: recurse-clean
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
diff --git a/meson.build b/meson.build
index 892bb62..d287e06 100644
--- a/meson.build
+++ b/meson.build
@@ -354,6 +354,7 @@ if have_tools
 endif
 
 subdir('tools')
+subdir('pc-bios')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
new file mode 100644
index 0000000..8a3d335
--- /dev/null
+++ b/pc-bios/meson.build
@@ -0,0 +1,23 @@
+bzip2 = find_program('bzip2')
+
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
+                  build_by_default: true,
+                  command: [ bzip2, '-dc', '@INPUT0@' ])
+  endforeach
+endif
-- 
1.8.3.1



