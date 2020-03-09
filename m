Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DE4C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDE8208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZUTzOf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDE8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKhS-0004kD-5u
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZt-0001v3-38
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZp-0001R3-Ua
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZp-0001Qc-M2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id 6so11824491wre.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E/C3ETynTNluvhCBM4gicRKFu80GsFl4sti73t961ws=;
 b=rZUTzOf8jSUjlLqYMgZ7Ywsb5zA6vtHfxdbEbSbyBtTqIuHTnbvwdWKbS3DMgxBUYw
 shXGLV7wFrWeW2jkRt7BG2mWoVmWsqiLEvw+eJlU+A5FFTIuxvqJXJ2pSsMWd/9Ks5nj
 15zt9YVWn7ccxQ4+64v/uVrvTPHi61Dn31r0Z/v5kFAyrQHNm0kdV8BySHPbOQWd+b0t
 pCdPO2C60uLboTUsx86zyPjFYcdKGEMczgbgvtgqhqiTZdBFaTTpiGV/h3kI9GY8/aje
 ZzNVLn8AAX5DWYB93bat8zIaJu3KSZrrI4gbauQtLmhk2+1g125fGAEmdibMzDXJVUV5
 dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/C3ETynTNluvhCBM4gicRKFu80GsFl4sti73t961ws=;
 b=Yvk00+BDmfOsQcKJ9fbHMJWzGe273lEBNowgxYzFzVa+sjBRhMYj2L+8D7ApmgwwwF
 qb1N7Ib8u8eo4UpebNJTMwUSkSY0N3lz40akbPJOjbA3vOToxJeQd1C85u6eegyUhAz/
 yPC+iOLxEOFQi2+OI5wRAeeYuGo9NtnTWtNPiKslOvnaysQ5zwgp2mGEMaEJbUab6lGi
 m9jO/GPZnDMgAnsbeqdpAiCfmZVXMKbaFUkdq8vtXY185O1zoSrK6q06UOS+TfL4v6Qu
 N8YViqUUXJzVWUjHt3Kw0/HaoDlKS8Xnuom5/LntTaSmBMzIcsJDtVJc9wdZNOaiLUJs
 F9KA==
X-Gm-Message-State: ANhLgQ3AzRY1IjHKicspkp5oQlSWgtxsWYe410TO2m+Uj+jP8buV0HOE
 kGXCTQIfPaKU2N4GFZpQaRJcy2Osz6x9ZA==
X-Google-Smtp-Source: ADFU+vv+KgM0RObT801fxNHKmb2YnGmEXRVoL+FLq7ihp653yMR+oqoHcyuCgn2duc5tv32gWa/JKg==
X-Received: by 2002:a05:6000:185:: with SMTP id
 p5mr4832401wrx.155.1583768659994; 
 Mon, 09 Mar 2020 08:44:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/18] docs/interop: Convert qemu-qmp-ref to rST
Date: Mon,  9 Mar 2020 15:43:56 +0000
Message-Id: <20200309154405.13548-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qemu-qmp-ref to rST format. This includes dropping
the plain-text, pdf and info format outputs for this document;
as with all our other Sphinx-based documentation, we provide
HTML and manpage only.

The qemu-qmp-ref.rst is somewhat more stripped down than
the .texi was, because we do not (currently) attempt to
generate indexes for the commands, events and data types
being documented.

Again, we drop the direct link from index.html.in now that
the QMP ref is part of the interop manual.

This commit removes the 'info', 'txt' and 'pdf' Makefile
targets, because we no longer generate any documentation
except for the Sphinx HTML manuals and the manpages.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                       | 39 ++++-------------
 docs/index.html.in             |  1 -
 docs/interop/conf.py           |  2 +
 docs/interop/index.rst         |  1 +
 docs/interop/qemu-qmp-ref.rst  |  4 ++
 docs/interop/qemu-qmp-ref.texi | 80 ----------------------------------
 6 files changed, 16 insertions(+), 111 deletions(-)
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi

diff --git a/Makefile b/Makefile
index 14780878fad..6dcc39efcee 100644
--- a/Makefile
+++ b/Makefile
@@ -126,7 +126,6 @@ GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
 GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_QAPI_FILES += qapi/qapi-doc.texi
 
 generated-files-y += $(GENERATED_QAPI_FILES)
 
@@ -352,7 +351,6 @@ ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
 DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
 endif
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
-DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
@@ -628,8 +626,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
 qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
-qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-init-commands.c \
-qga/qapi-generated/qga-qapi-doc.texi: \
+qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-init-commands.c: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
@@ -771,11 +768,6 @@ distclean: clean
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
-	rm -f docs/interop/qemu-qmp-qapi.texi
-	rm -f docs/interop/qemu-qmp-ref.7
-	rm -f docs/interop/qemu-qmp-ref.txt
-	rm -f docs/interop/qemu-qmp-ref.pdf
-	rm -f docs/interop/qemu-qmp-ref.html
 	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
@@ -830,7 +822,7 @@ endif
 # and also any sphinx-built manpages.
 define install-manual =
 for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-qmp-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' -name '*.[0-9]'); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
@@ -846,13 +838,11 @@ install-sphinxdocs: sphinxdocs
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
@@ -1058,7 +1048,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qga/qapi-schema.json $(qapi-modules) $(qapi-py)
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1074,9 +1064,9 @@ $(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
 	$(call build-manual,user,html)
 
 $(call define-manpage-rule,interop,\
-       qemu-ga.8 qemu-ga-ref.7,\
+       qemu-ga.8 qemu-ga-ref.7 qemu-qmp-ref.7,\
        $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json \
-       $(qapi-py))
+       $(qapi-modules) $(qapi-py))
 
 $(call define-manpage-rule,system,qemu.1 qemu-block-drivers.7 qemu-cpu-models.7)
 
@@ -1090,18 +1080,7 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
              "GEN","$@")
 
-docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
-	@cp -p $< $@
-
-html: docs/interop/qemu-qmp-ref.html sphinxdocs
-info: docs/interop/qemu-qmp-ref.info
-pdf: docs/interop/qemu-qmp-ref.pdf
-txt: docs/interop/qemu-qmp-ref.txt
-
-docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
-    docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
-    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
-	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
+html: sphinxdocs
 
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 
@@ -1225,8 +1204,8 @@ endif
 	@echo  '  vm-help         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
-	@echo  '  html info pdf txt'
-	@echo  '                  - Build documentation in specified format'
+	@echo  '  html'
+	@echo  '                  - Build HTML documentation'
 ifdef CONFIG_GCOV
 	@echo  '  coverage-report - Create code coverage report'
 endif
diff --git a/docs/index.html.in b/docs/index.html.in
index f180770b052..b3dfb7a4611 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -12,7 +12,6 @@
             <li><a href="tools/index.html">Tools Guide</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
-            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index e83632e0108..43de386d33d 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -21,4 +21,6 @@ man_pages = [
      ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
     ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
      [], 7),
+    ('qemu-qmp-ref', 'qemu-qmp-ref', u'QEMU QMP Reference Manual',
+     [], 7),
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index f3af38dce17..2cd97c6ff42 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -19,5 +19,6 @@ Contents:
    pr-helper
    qemu-ga
    qemu-ga-ref
+   qemu-qmp-ref
    vhost-user
    vhost-user-gpu
diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
new file mode 100644
index 00000000000..e640903abaf
--- /dev/null
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -0,0 +1,4 @@
+QEMU QMP Reference Manual
+=========================
+
+.. qapi-doc:: qapi/qapi-schema.json
diff --git a/docs/interop/qemu-qmp-ref.texi b/docs/interop/qemu-qmp-ref.texi
deleted file mode 100644
index bb25758bd02..00000000000
--- a/docs/interop/qemu-qmp-ref.texi
+++ /dev/null
@@ -1,80 +0,0 @@
-\input texinfo
-@setfilename qemu-qmp-ref.info
-
-@include version.texi
-
-@exampleindent 0
-@paragraphindent 0
-
-@settitle QEMU QMP Reference Manual
-
-@iftex
-@center @image{docs/qemu_logo}
-@end iftex
-
-@copying
-This is the QEMU QMP reference manual.
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
-* QEMU-QMP-Ref: (qemu-qmp-ref). QEMU QMP Reference Manual
-@end direntry
-
-@titlepage
-@title QMP Reference Manual
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
-@top QEMU QMP reference
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
-@include qemu-qmp-qapi.texi
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
-- 
2.20.1


