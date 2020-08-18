Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E7C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141B3206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMMqnPtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B3206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82Oy-0003aG-9g
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KF-0003Ju-Tz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KD-0007L4-F6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkPf7PWkNATqrWoFej7IoCO7EhwEBf0hEgUaOFDcyWc=;
 b=LMMqnPtOZ4QpoHJNy19dlE8z+5uDNeNzj9HfSEcyqeQtdMfN2Jjw8gctNbCx0nqRnDMJYa
 boRkykYgkY77iNrJMy0I+0yniPM8uI13GJ1ejNBakLcUfwFYwQd8G6ZPcQib0qF2TOCILr
 4zTerYr3s5ye0O+ejnudFKhE1F+feGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-N690g_OUPpqrj3WP3AGktw-1; Tue, 18 Aug 2020 10:10:51 -0400
X-MC-Unique: N690g_OUPpqrj3WP3AGktw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32B97801ADE
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC08D5D9E2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 023/150] meson: add sparse support
Date: Tue, 18 Aug 2020 10:08:18 -0400
Message-Id: <20200818141025.21608-24-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use cgcc; instead, extract compilation commands from compile_commands.json
and invoke sparse directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                |  1 +
 configure               |  8 ++------
 meson.build             |  7 +++++++
 scripts/check_sparse.py | 25 +++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 scripts/check_sparse.py

diff --git a/Makefile b/Makefile
index 7e9663aeb7..6198236c40 100644
--- a/Makefile
+++ b/Makefile
@@ -1256,6 +1256,7 @@ endif
 	$(call print-help,install,Install QEMU, documentation and tools)
 	$(call print-help,ctags/TAGS,Generate tags file for editors)
 	$(call print-help,cscope,Generate cscope index)
+	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
 	@$(if $(TARGET_DIRS), \
 		echo 'Architecture specific targets:'; \
diff --git a/configure b/configure
index 41c20ade4e..5263ec7d43 100755
--- a/configure
+++ b/configure
@@ -3009,7 +3009,7 @@ fi
 ##########################################
 # Sparse probe
 if test "$sparse" != "no" ; then
-  if has cgcc; then
+  if has sparse; then
     sparse=yes
   else
     if test "$sparse" = "yes" ; then
@@ -7810,11 +7810,7 @@ echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
 if test "$sparse" = "yes" ; then
-  echo "CC           := REAL_CC=\"\$(CC)\" cgcc"       >> $config_host_mak
-  echo "CPP          := REAL_CC=\"\$(CPP)\" cgcc"      >> $config_host_mak
-  echo "CXX          := REAL_CC=\"\$(CXX)\" cgcc"      >> $config_host_mak
-  echo "HOST_CC      := REAL_CC=\"\$(HOST_CC)\" cgcc"  >> $config_host_mak
-  echo "QEMU_CFLAGS  += -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
+  echo "SPARSE_CFLAGS = -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
 fi
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 7f15799933..eb0d2ed992 100644
--- a/meson.build
+++ b/meson.build
@@ -22,6 +22,13 @@ if host_machine.system() == 'darwin'
   add_languages('objc', required: false, native: false)
 endif
 
+if 'SPARSE_CFLAGS' in config_host
+  run_target('sparse',
+             command: [find_program('scripts/check_sparse.py'),
+                       config_host['SPARSE_CFLAGS'].split(),
+                       'compile_commands.json'])
+endif
+
 configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
diff --git a/scripts/check_sparse.py b/scripts/check_sparse.py
new file mode 100644
index 0000000000..0de7aa55d9
--- /dev/null
+++ b/scripts/check_sparse.py
@@ -0,0 +1,25 @@
+#! /usr/bin/env python3
+
+# Invoke sparse based on the contents of compile_commands.json
+
+import json
+import subprocess
+import sys
+import shlex
+
+def extract_cflags(shcmd):
+    cflags = shlex.split(shcmd)
+    return [x for x in cflags
+            if x.startswith('-D') or x.startswith('-I') or x.startswith('-W')
+               or x.startswith('-std=')]
+
+cflags = sys.argv[1:-1]
+with open(sys.argv[-1], 'r') as fd:
+    compile_commands = json.load(fd)
+
+for cmd in compile_commands:
+    cmd = ['sparse'] + cflags + extract_cflags(cmd['command']) + [cmd['file']]
+    print(' '.join((shlex.quote(x) for x in cmd)))
+    r = subprocess.run(cmd)
+    if r.returncode != 0:
+        sys.exit(r.returncode)
-- 
2.26.2



