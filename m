Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA7BC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AC721D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmyiWnKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AC721D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqcX-0007BA-07
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVP-0006fp-PE
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVN-0006oP-Lk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id k15so4191862wrn.10
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qZjS93MWQ0G71t+DqqJoLIdR9lVhsNLA2fYrKCp5a3E=;
 b=YmyiWnKR67V/nnqTI08fBwyY2aG9QjvqdXg7LXwRIIMIns2Cnp612d5qsu9Ovqa3mD
 Kw114xiOI4fsYB8c3YmYJRHHflUEVOkIl63uaEMgC825icgZ7mSMlP7ZOLCXONzFHabJ
 9rLXFelgiodzX/oqxwVIeS/JJ8g4VJO8G9uR7sO7MalOzAIyJ0EgpIYHQsqCqtCX5GBa
 SpalLXhZ5xHcCSLjMI3yx6QmOvrzY5xW6cepbtQVEN2JHaj0arfZBj7AFiiyVHfF5WOt
 xfdu8vOSrfo7oDZQhMckfB7CDHctmeuZthRbzsDs6QuencwJjzml6RyobtjfKJJXhP08
 I/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qZjS93MWQ0G71t+DqqJoLIdR9lVhsNLA2fYrKCp5a3E=;
 b=DZfW/FqAVAjXTgiP1reFcxi9uoesFD/uMrHGkwjchOfqFiWc0RE+rUgt8hB+h07ggL
 XB3JorjIEk5naI30PQVQcNse2jy2iMBlKsJy8MT6dpCQHgRXV8uZc4pr3SBgZTm5DQxr
 ZRdNX4QMIQq4sap1qauy+faoXmV6nLSs/4gYgeGxs64LI3WiJ9RaecnWkL7JHKjMXP/j
 L5bT4Zecg3eq4CvuZV+qKXrTogarLqcJN3PRgDypCETXqKGUeDB2giwNKjrajJjuDVlw
 5wAdDJv/1QPuuxovafhTJrz9ZVURt7//iz2URE5iJCqce0lTOtKkIAbJ9EqhvWEKnhRr
 SkvA==
X-Gm-Message-State: AOAM531Q7eH8YdTBf3j1bUHPRzKJMenT6PEYsuAqZ5QRg552PQn1bGH/
 q/MPAB2Dr0tgu/wzpvMgnYuTnCo6+zrygSGL
X-Google-Smtp-Source: ABdhPJyASieccQz0m+0M+R0adWTkBzmrtTRclnwAERRx3o5rszbE1Fi/rL5ALXfyMZbhFkF8kQwzig==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr4885072wrs.388.1601051007870; 
 Fri, 25 Sep 2020 09:23:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/21] docs/interop: Convert qemu-ga-ref to rST
Date: Fri, 25 Sep 2020 17:23:03 +0100
Message-Id: <20200925162316.21205-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qemu-ga-ref to rST format. This includes dropping
the plain-text, pdf and info format outputs for this document;
as with all our other Sphinx-based documentation, we provide
HTML and manpage only.

The qemu-ga-ref.rst is somewhat more stripped down than
the .texi was, because we do not (currently) attempt to
generate indexes for the commands, events and data types
being documented.

As the GA ref is now part of the Sphinx 'interop' manual,
we can delete the direct link from index.html.in.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/index.html.in            |  1 -
 docs/interop/conf.py          |  2 +
 docs/interop/index.rst        |  1 +
 docs/interop/qemu-ga-ref.rst  |  9 ++++
 docs/interop/qemu-ga-ref.texi | 80 -----------------------------------
 docs/meson.build              |  1 +
 meson.build                   |  3 --
 MAINTAINERS                   |  2 +-
 qga/meson.build               |  3 +-
 9 files changed, 15 insertions(+), 87 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi

diff --git a/docs/index.html.in b/docs/index.html.in
index ca28047881e..5b0f4e2bc2c 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -13,7 +13,6 @@
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
-            <li><a href="interop/qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 42ce7e3d365..e83632e0108 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -19,4 +19,6 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
 man_pages = [
     ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
      ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
+    ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
+     [], 7),
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 006f9864208..738cdbe185e 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,6 +18,7 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
+   qemu-ga-ref
    vhost-user
    vhost-user-gpu
    vhost-vdpa
diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
new file mode 100644
index 00000000000..669019de71d
--- /dev/null
+++ b/docs/interop/qemu-ga-ref.rst
@@ -0,0 +1,9 @@
+QEMU Guest Agent Protocol Reference
+===================================
+
+..
+   TODO: the old texinfo manual used to note that this manual
+   is GPL-v2-or-later. We should make that reader-visible
+   both here and in our Sphinx manuals more generally.
+
+.. qapi-doc:: qga/qapi-schema.json
diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
deleted file mode 100644
index a23cc2ed7f6..00000000000
--- a/docs/interop/qemu-ga-ref.texi
+++ /dev/null
@@ -1,80 +0,0 @@
-\input texinfo
-@setfilename qemu-ga-ref.info
-
-@include version.texi
-
-@exampleindent 0
-@paragraphindent 0
-
-@settitle QEMU Guest Agent Protocol Reference
-
-@iftex
-@center @image{docs/qemu_logo}
-@end iftex
-
-@copying
-This is the QEMU Guest Agent Protocol reference manual.
-
-Copyright @copyright{} 2016 The QEMU Project developers
-
-@quotation
-This manual is free documentation: you can redistribute it and/or
-modify it under the terms of the GNU General Public License as
-published by the Free Software Foundation, either version 2 of the
-License, or (at your option) any later version.
-
-This manual is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this manual.  If not, see http://www.gnu.org/licenses/.
-@end quotation
-@end copying
-
-@dircategory QEMU
-@direntry
-* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
-@end direntry
-
-@titlepage
-@title Guest Agent Protocol Reference Manual
-@subtitle QEMU version @value{VERSION}
-@page
-@vskip 0pt plus 1filll
-@insertcopying
-@end titlepage
-
-@contents
-
-@ifnottex
-@node Top
-@top QEMU Guest Agent protocol reference
-@end ifnottex
-
-@menu
-* API Reference::
-* Commands and Events Index::
-* Data Types Index::
-@end menu
-
-@node API Reference
-@chapter API Reference
-
-@c for texi2pod:
-@c man begin DESCRIPTION
-
-@include qga/qga-qapi-doc.texi
-
-@c man end
-
-@node Commands and Events Index
-@unnumbered Commands and Events Index
-@printindex fn
-
-@node Data Types Index
-@unnumbered Data Types Index
-@printindex tp
-
-@bye
diff --git a/docs/meson.build b/docs/meson.build
index 50f367349b8..2569dd52ad6 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -15,6 +15,7 @@ if build_docs
   man_pages = {
     'interop' : {
         'qemu-ga.8': (have_tools ? 'man8' : ''),
+        'qemu-ga-ref.7': 'man7',
     },
     'tools': {
         'qemu-img.1': (have_tools ? 'man1' : ''),
diff --git a/meson.build b/meson.build
index f4d1ab10968..c01c6230b3f 100644
--- a/meson.build
+++ b/meson.build
@@ -1220,9 +1220,6 @@ if build_docs
   texi = {
     'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, version_texi],
   }
-  if 'CONFIG_GUEST_AGENT' in config_host
-    texi += {'qemu-ga-ref': ['docs/interop/qemu-ga-ref.texi', qga_qapi_doc_texi, version_texi]}
-  endif
 
   if makeinfo.found()
     cmd = [
diff --git a/MAINTAINERS b/MAINTAINERS
index dbddb0a7635..4b2705fc143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2418,9 +2418,9 @@ M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
 F: docs/interop/qemu-ga.rst
+F: docs/interop/qemu-ga-ref.rst
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
-F: docs/interop/qemu-ga-ref.texi
 T: git https://github.com/mdroth/qemu.git qga
 
 QOM
diff --git a/qga/meson.build b/qga/meson.build
index e5c5778a3e0..1c312b50cc9 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -16,7 +16,7 @@ qga_qapi_outputs = [
 ]
 
 qga_qapi_files = custom_target('QGA QAPI files',
-                               output: qga_qapi_outputs + ['qga-qapi-doc.texi'],
+                               output: qga_qapi_outputs,
                                input: 'qapi-schema.json',
                                command: [ qapi_gen, '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
                                depend_files: qapi_gen_depends)
@@ -27,7 +27,6 @@ foreach output: qga_qapi_outputs
   qga_ss.add(qga_qapi_files[i])
   i = i + 1
 endforeach
-qga_qapi_doc_texi = qga_qapi_files[i]
 
 qga_ss.add(files(
   'commands.c',
-- 
2.20.1


