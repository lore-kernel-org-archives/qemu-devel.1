Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60AAC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CED320838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjIptEDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CED320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlGy-0002ax-LP
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl0B-0006ye-0g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl07-0006y6-GN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:41 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl07-0006tT-5v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:39 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w12so8230527wrt.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ixvc6L0q2QlOhkl+8cnuUfHjWf1FDH70K9mOZrRaf84=;
 b=UjIptEDNyX6txcgWnDajdndL4iFZ5SbExtDxx7je3tAjFCZSpFV3kO88xtcjtvfPA1
 /aRolpEAZ9JzAcr3y4M9Gj82cAm3f0PuSX2I5YxBVxb1Dix3rTDegrXELXuaYrAim9j9
 oVlg1EBKfr7S5AVr7LmI+UDiuRqA+iYdh0sCQCVxZmftRyu/y+npSH3s+GX4Ro52B1Yz
 2xdCO7LabfbOdaNqjjIqM+6nU39MHwBjM4NhWTRnxCTBqT48B1cXUP9dBmidkvrlt3m8
 q0K+czYKU2X48TIZO+AaxAuAtWhQieyjoHQnVoa3meT0WZWKRq7mOpTfXykbEyu5gOiJ
 Zhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ixvc6L0q2QlOhkl+8cnuUfHjWf1FDH70K9mOZrRaf84=;
 b=I7GWlIX9d4NYWS4zc/sLj/njRR/ZRxTM6QI28Reg4NOlvOZwLJWaBOLKDW5GKrJM0s
 /Z1xLCiKKU0Uv6uF9qubeIFEYIU4MQPjtRIonEVYB84zwLgKiOZ4bU8FIkVoXO1q1N6B
 A1J3zFWikFEu8YZWeINxE9VV9b5RBWHXRb3TavvkSLpQ7UPZwZYSiLReWhaIltv3j6gA
 eZT7dGuZ51dmhxcTX2sqf3thHlXzAktDk+IO4NMa63zZHiT4g0x9upqe7JmTVPHIjnAc
 JLpXouWylQvQGwr7jUcT6Ag0h8Q8LcBf9TlOMFb3gU/SLQFDbPzm0rBTA5+JBRYNBale
 zJtA==
X-Gm-Message-State: APjAAAWp2Vj7QcuBG8PTrJZH3pZZK6GvOrnQv9bj9dk/MvN2kYi1IDpI
 wu0WgGA5y+0r05CxUH7fGfs7M5jy3mw=
X-Google-Smtp-Source: APXvYqxlJJV4B9B/HmZgCoN0EVkTtzYO5G0SxJT/zDsKWDjOCEj3L0ARvmbLDq7oXd+nIAPBqInWBg==
X-Received: by 2002:adf:f850:: with SMTP id d16mr4729690wrq.161.1581010297426; 
 Thu, 06 Feb 2020 09:31:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/29] docs/interop: Convert qemu-qmp-ref to rST
Date: Thu,  6 Feb 2020 17:30:36 +0000
Message-Id: <20200206173040.17337-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                       | 37 +++++-----------
 docs/index.html.in             |  1 -
 docs/interop/conf.py           |  2 +
 docs/interop/index.rst         |  1 +
 docs/interop/qemu-qmp-ref.rst  |  4 ++
 docs/interop/qemu-qmp-ref.texi | 80 ----------------------------------
 6 files changed, 17 insertions(+), 108 deletions(-)
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi

diff --git a/Makefile b/Makefile
index 790e5b2c817..159ac78dd24 100644
--- a/Makefile
+++ b/Makefile
@@ -126,7 +126,6 @@ GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
 GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
 GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_QAPI_FILES += qapi/qapi-doc.texi
 
 generated-files-y += $(GENERATED_QAPI_FILES)
 
@@ -349,8 +348,8 @@ DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-img.1
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
-DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7
+DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-qmp-ref.7
 DOCS+=docs/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
@@ -612,8 +611,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
 qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-commands.c \
-qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-init-commands.c \
-qga/qapi-generated/qga-qapi-doc.texi: \
+qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-init-commands.c: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
@@ -759,11 +757,6 @@ distclean: clean
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
-	rm -f docs/interop/qemu-qmp-qapi.texi
-	rm -f docs/interop/qemu-qmp-ref.7
-	rm -f docs/interop/qemu-qmp-ref.txt
-	rm -f docs/interop/qemu-qmp-ref.pdf
-	rm -f docs/interop/qemu-qmp-ref.html
 	rm -f docs/qemu-cpu-models.7
 	rm -rf .doctrees
 	$(call clean-manual,devel)
@@ -817,7 +810,7 @@ endif
 # and also any sphinx-built manpages.
 define install-manual =
 for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-qmp-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' -name '*.[0-9]'); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
@@ -833,13 +826,11 @@ install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
@@ -1039,7 +1030,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json $(qapi-modules) $(qapi-py)
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1052,7 +1043,7 @@ $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-ga-ref.7 \
        qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-helper.1,\
        $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json \
-       $(qapi-py))
+       $(qapi-modules) $(qapi-py))
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
@@ -1070,17 +1061,14 @@ qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
 qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
-	@cp -p $< $@
-
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html sphinxdocs
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt
+html: qemu-doc.html sphinxdocs
+info: qemu-doc.info
+pdf: qemu-doc.pdf
+txt: qemu-doc.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
@@ -1089,11 +1077,6 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-monitor-info.texi \
 	docs/qemu-cpu-models.texi docs/security.texi
 
-docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
-    docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
-    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
-	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
-
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 
 # Reports/Analysis
diff --git a/docs/index.html.in b/docs/index.html.in
index 92a057101e6..ba7cd611d26 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -8,7 +8,6 @@
         <h1>QEMU @@VERSION@@ Documentation</h1>
         <ul>
             <li><a href="qemu-doc.html">User Documentation</a></li>
-            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="system/index.html">System Emulation User's Guide</a></li>
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 21e1ac74282..55bbae6053a 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -25,6 +25,8 @@ man_pages = [
      ['Fabrice Bellard'], 1),
     ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
      ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
+    ('qemu-qmp-ref', 'qemu-qmp-ref', u'QEMU QMP Reference Manual',
+     [], 7),
     ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
      [], 1),
     ('virtfs-proxy-helper', 'virtfs-proxy-helper',
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 3102eef4add..0997c1ac4ba 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -21,6 +21,7 @@ Contents:
    qemu-ga-ref
    qemu-img
    qemu-nbd
+   qemu-qmp-ref
    qemu-trace-stap
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


