Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B4220760
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ev7kJhp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B4220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hHI-0007ad-GK
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gLD-0003fy-Qg
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gLB-0006w2-NV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/fODn4v4AYiOCnBLbWR2W6/Nc+bZU0GgOOKRamlgF0=;
 b=ev7kJhp6wJLxOXeTXkKxT3kneOwUUSyZFJo6IXJPV3bT7vGpyW6cIIGC0LrxSbq0O9Tv12
 BV+hCCUdejR7iIYcMLqHSax+huiOlqxUNGZ6/YUtnPUdIraaOsAhW2CF1VEWfZOrH8HQVu
 tXNcUstb0wdR3xJpPtnnijMCN22E0Uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-aPfWG8HsPfe9UfajwSZD-w-1; Mon, 17 Aug 2020 10:42:22 -0400
X-MC-Unique: aPfWG8HsPfe9UfajwSZD-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0B1185E524
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:42:21 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01BA5756B5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:42:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 138/150] docs: automatically track manual dependencies
Date: Mon, 17 Aug 2020 16:40:41 +0200
Message-Id: <20200817144053.345107-43-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/conf.py           |  2 +-
 docs/meson.build       | 21 ++++++++++-------
 docs/sphinx/depfile.py | 51 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 docs/sphinx/depfile.py

diff --git a/docs/conf.py b/docs/conf.py
index d6e173ef77..0dbd90dc11 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -67,7 +67,7 @@ needs_sphinx = '1.6'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool']
+extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
diff --git a/docs/meson.build b/docs/meson.build
index 20fc92e2fe..08c9139fbe 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -34,16 +34,21 @@ if build_docs
   sphinxmans = []
   foreach manual : manuals
     private_dir = meson.current_build_dir() / (manual + '.p')
+    output_dir = meson.current_build_dir() / manual
     input_dir = meson.current_source_dir() / manual
-    sphinxdocs += custom_target(manual + ' manual',
-                build_always_stale: true,
+
+    this_manual = custom_target(manual + ' manual',
                 build_by_default: build_docs,
-                output: manual,
-                command: [SPHINX_ARGS, '-b', 'html', '-d', private_dir,
-                          input_dir, meson.current_build_dir() / manual])
+                output: [manual + '.stamp', manual],
+                input: [files('conf.py'), files(manual / 'conf.py')],
+                depfile: manual + '.d',
+                command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
+                          '-Ddepfile_stamp=@OUTPUT0@',
+                          '-b', 'html', '-d', private_dir,
+                          input_dir, output_dir])
+    sphinxdocs += this_manual
     if build_docs and manual != 'devel'
-      install_subdir(meson.current_build_dir() / manual,
-                     install_dir: config_host['qemu_docdir'])
+      install_subdir(output_dir, install_dir: config_host['qemu_docdir'])
     endif
 
     these_man_pages = []
@@ -54,9 +59,9 @@ if build_docs
     endforeach
     if these_man_pages.length() > 0
       sphinxmans += custom_target(manual + ' man pages',
-                         build_always_stale: true,
                          build_by_default: build_docs,
                          output: these_man_pages,
+                         input: this_manual,
                          install: build_docs,
                          install_dir: install_dirs,
                          command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
new file mode 100644
index 0000000000..277fdf0f56
--- /dev/null
+++ b/docs/sphinx/depfile.py
@@ -0,0 +1,51 @@
+# coding=utf-8
+#
+# QEMU depfile generation extension
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPLv2 or later.
+# See the COPYING file in the top-level directory.
+
+"""depfile is a Sphinx extension that writes a dependency file for
+   an external build system"""
+
+import os
+import sphinx
+
+__version__ = '1.0'
+
+def get_infiles(env):
+    for x in env.found_docs:
+        yield env.doc2path(x)
+        yield from ((os.path.join(env.srcdir, dep)
+                    for dep in env.dependencies[x]))
+
+def write_depfile(app, env):
+    if not env.config.depfile:
+        return
+
+    # Using a directory as the output file does not work great because
+    # its timestamp does not necessarily change when the contents change.
+    # So create a timestamp file.
+    if env.config.depfile_stamp:
+        with open(env.config.depfile_stamp, 'w') as f:
+            pass
+
+    with open(env.config.depfile, 'w') as f:
+        print((env.config.depfile_stamp or app.outdir) + ": \\", file=f)
+        print(*get_infiles(env), file=f)
+        for x in get_infiles(env):
+            print(x + ":", file=f)
+
+
+def setup(app):
+    app.add_config_value('depfile', None, 'env')
+    app.add_config_value('depfile_stamp', None, 'env')
+    app.connect('env-updated', write_depfile)
+
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
-- 
2.26.2



