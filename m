Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7968CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C7222CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTVLVkkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C7222CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Ds6-0008Bg-2q
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doj-0000cL-Dv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:40505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dog-0004mW-Lz
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id k20so664917wmi.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hz+PeEHoMI/nagWK3QJjMZ7m/nxfdy6vnQlqCbPtmqA=;
 b=XTVLVkknVZHsgycss2KhFCHJ9NlQZufEQVEi5s8y4K7IHZYReABpAd0sFJkgWTVZWG
 aXpXC1GgoRSYXSVdKo32WE3jlwO7CoeKAQGkUYaJAYHkcd6Wgg4yMOQZNttXDf1qAI81
 c4ZF9EwK8B0LVdz2UjG96KsX13VYH1uSDMXovffLNcWAkE1UPesjiAENaLqmTvEYJhVq
 O9wcQbB6DgX+opF81yXbDT7909i+DZKRcLTucwUVwSKVdUppzSxhs7bwWpsgnOubm3KH
 +/KpyhTUe8GDkXpGp4x7nZaYDxrqju7TUp7pMidsYFlpr4w1v8dJpIah6X8Oysc8skZ0
 ip/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hz+PeEHoMI/nagWK3QJjMZ7m/nxfdy6vnQlqCbPtmqA=;
 b=mjbng3m/RpeE5WEuiVD58Fc6Swo33YwQdCrtb0d2N/Qz9u+kh6A7AUmCp6NH8G+O5n
 DakDoylsrknYnoHu+EN88Tg5l1UM2J523LwgJ1pcMRsM1WOmQz6ehSsv834wFORYrGS0
 Z8RZVcAxJ6fLmMqI3UGa8pI+W+OgX72XRLuktFzZ1I59gr79kgYcy0tcSNunhpaf2/kC
 OUd0y3mzZvn5ica95895yFJO3fVBPXRMzwycKabXmXgxdv5+JTXXODMZi33dpuAW4A2K
 VAabpYyQ5rOZprPVG4Z3EpqcPnStlbTeznxNQuc9ryNR22/6DhmtdGJ4IIGwkqD/4L6M
 onBA==
X-Gm-Message-State: AOAM533jSCuXXDEt3hUu720MGCtUdNKwbDCV1CV6E7dO36RTcIWr1WNJ
 w5Nd2Thx+T1SfsFdKxL2zfg+gNjFkzaNyg==
X-Google-Smtp-Source: ABdhPJw2naqw7uCv91t60VQE39pqW7j3LMWxmuEonGlXxAPo6T911d2qlvcrxoQM5OxATBSH4AXZDQ==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr735586wmy.15.1597089040395; 
 Mon, 10 Aug 2020 12:50:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/20] docs/interop: Convert qemu-qmp-ref to rST
Date: Mon, 10 Aug 2020 20:50:10 +0100
Message-Id: <20200810195019.25427-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Markus Armbruster <armbru@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/index.html.in             |  1 -
 docs/interop/conf.py           |  2 +
 docs/interop/index.rst         |  1 +
 docs/interop/qemu-qmp-ref.rst  |  4 ++
 docs/interop/qemu-qmp-ref.texi | 80 ----------------------------------
 Makefile                       | 38 ++++------------
 6 files changed, 15 insertions(+), 111 deletions(-)
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi

diff --git a/docs/index.html.in b/docs/index.html.in
index 99d4d8075fc..b3dfb7a4611 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -12,7 +12,6 @@
             <li><a href="tools/index.html">Tools Guide</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
-            <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
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
index 738cdbe185e..cd78d679d82 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -19,6 +19,7 @@ Contents:
    pr-helper
    qemu-ga
    qemu-ga-ref
+   qemu-qmp-ref
    vhost-user
    vhost-user-gpu
    vhost-vdpa
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
diff --git a/Makefile b/Makefile
index f0cca10b427..3df1cf68333 100644
--- a/Makefile
+++ b/Makefile
@@ -123,7 +123,6 @@ GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
 GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_QAPI_FILES += qapi/qapi-doc.texi
 
 # The following list considers only the storage daemon main module. All other
 # modules are currently shared with the main schema, so we don't actually
@@ -370,7 +369,6 @@ ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
 DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
 endif
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
-DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
@@ -644,8 +642,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
 qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
-qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-init-commands.c \
-qga/qapi-generated/qga-qapi-doc.texi: \
+qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-init-commands.c: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
@@ -800,11 +797,6 @@ distclean: clean
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
@@ -858,7 +850,7 @@ endif
 # and also any sphinx-built manpages.
 define install-manual =
 for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-qmp-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' -name '*.[0-9]'); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
@@ -874,14 +866,11 @@ install-sphinxdocs: sphinxdocs
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
@@ -1087,7 +1076,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qga/qapi-schema.json $(qapi-modules) $(qapi-py)
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1103,9 +1092,9 @@ $(MANUAL_BUILDDIR)/user/index.html: $(call manual-deps,user)
 	$(call build-manual,user,html)
 
 $(call define-manpage-rule,interop,\
-       qemu-ga.8 qemu-ga-ref.7,\
+       qemu-ga.8 qemu-ga-ref.7 qemu-qmp-ref.7,\
        $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json \
-       $(qapi-py))
+       $(qapi-modules) $(qapi-py))
 
 $(call define-manpage-rule,system,qemu.1 qemu-block-drivers.7 qemu-cpu-models.7)
 
@@ -1119,18 +1108,7 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
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
 
@@ -1271,7 +1249,7 @@ endif
 	$(call print-help,vm-help,Help about targets running tests inside VM)
 	@echo  ''
 	@echo  'Documentation targets:'
-	$(call print-help,html info pdf txt,Build documentation in specified format)
+	$(call print-help,html,Build HTML documentation)
 ifdef CONFIG_GCOV
 	$(call print-help,coverage-report,Create code coverage report)
 endif
-- 
2.20.1


