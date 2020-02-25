Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF30C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB6021744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDLlX9Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB6021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6asO-0003bu-ST
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apZ-0006qT-5f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apU-0005Jf-DO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:05:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apU-0005Ir-6O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p17so3285141wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h8KcToOpNdvd1jAEU1XTyzSES2UTXwJrY4z+tY0Zjnk=;
 b=wDLlX9Up0gY5JX32oABoOtiNrnL/AN7dlHcI9lmmJ7P+WZqYD0RcwQhig7NKmkh5Kw
 BkZ564/B8+Ef77/uwxQdTdtLnFrW++SIJWIoYm0P63AWD8J6NPcpAF+WQ9yAcPCbjaH7
 uod5DjDIobZf9YgM8s/TgOBiZ7KMipolNXO+VmrrgI4dvPNGA1Bj/80BkM1sFc0HwsTR
 9urXcnYJ0yz2DCB5G0KyQGVfxeqqVoao+UM+xD2VqDpDTz6Z84Lr5UmNMYXCtBqTIl8C
 FSsbt6mVFBATx2qvcI8jkcmyOnCVvnW82hqQbwL3yfCddwKVg7RSo8mBbZgJT6+51iD6
 debw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h8KcToOpNdvd1jAEU1XTyzSES2UTXwJrY4z+tY0Zjnk=;
 b=U+Jls0yJaY7xP7vqZ2xIrB6F2YTR1CnE86SH+Pz2xz6HRf346UQTIBFFuyf01uqCOE
 0hxJmkR0+V4EMFNqmKC/i3QbazZD1kZMA7MsDIOteyhBVNDtOFoX4EzReyEbOTLoVpqS
 uA/Zp1P8sMV8FISKDIB3n3y2+YEQlbTumbgBMY+0SPsPJFFQ/ceBVChWK/40Jk86vXZw
 toA4V0yCaaj7UOfavzCvwW4QELJuB18W3s6D6TmHZdBFp6P8di4nRAxSYJkrdnMWtDux
 bEKS0kzSviFpPXDPIdJyq4J+hYDz73DutdOvtB1yYjYTLQ3SgDVDuD1YLUm4sm+v94EC
 9u/g==
X-Gm-Message-State: APjAAAVgXwmRXTTKVfOnRUXFPp2isQ8IN2z92I/p7uhpfhhr9Qf444ul
 cRfdctUYXa9I5iGBohcLrslB2RATNOeB6g==
X-Google-Smtp-Source: APXvYqzqpbwfLgvYjmgpSnDz3pvv/oFhrPXj05PaJp/Ab+sjmiy0MRtB+Pn9hJbVDP6OOzod78CdVw==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr5639680wme.56.1582639492270; 
 Tue, 25 Feb 2020 06:04:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] docs/interop: Convert qemu-ga-ref to rST
Date: Tue, 25 Feb 2020 14:04:32 +0000
Message-Id: <20200225140437.20609-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
References: <20200225140437.20609-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                      | 41 ++++++++----------
 MAINTAINERS                   |  2 +-
 docs/index.html.in            |  1 -
 docs/interop/conf.py          |  2 +
 docs/interop/index.rst        |  1 +
 docs/interop/qemu-ga-ref.rst  |  4 ++
 docs/interop/qemu-ga-ref.texi | 80 -----------------------------------
 7 files changed, 25 insertions(+), 106 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi

diff --git a/Makefile b/Makefile
index aa9cc0b5847..bdda1232b27 100644
--- a/Makefile
+++ b/Makefile
@@ -353,7 +353,7 @@ DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
 endif
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
-DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
+DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
@@ -775,11 +775,11 @@ distclean: clean
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
-	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
-	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
-	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
+	rm -f docs/interop/qemu-qmp-qapi.texi
+	rm -f docs/interop/qemu-qmp-ref.7
+	rm -f docs/interop/qemu-qmp-ref.txt
+	rm -f docs/interop/qemu-qmp-ref.pdf
+	rm -f docs/interop/qemu-qmp-ref.html
 	rm -f docs/qemu-cpu-models.7
 	rm -rf .doctrees
 	$(call clean-manual,devel)
@@ -834,7 +834,7 @@ endif
 # and also any sphinx-built manpages.
 define install-manual =
 for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-qmp-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
@@ -870,9 +870,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
 endif
 endif
 ifdef CONFIG_VIRTFS
@@ -1062,7 +1060,7 @@ endef
 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel,html)
 
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call build-manual,interop,html)
 
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
@@ -1074,7 +1072,10 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
 	$(call build-manual,tools,html)
 
-$(call define-manpage-rule,interop,qemu-ga.8)
+$(call define-manpage-rule,interop,\
+       qemu-ga.8 qemu-ga-ref.7,\
+       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json \
+       $(qapi-py))
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
@@ -1100,17 +1101,14 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
-docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
-	@cp -p $< $@
-
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
+html: qemu-doc.html docs/interop/qemu-qmp-ref.html sphinxdocs
+info: qemu-doc.info docs/interop/qemu-qmp-ref.info
+pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf
+txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
@@ -1119,11 +1117,6 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-monitor-info.texi \
 	docs/qemu-cpu-models.texi docs/security.texi
 
-docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
-    docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
-    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
-	docs/interop/qemu-ga-ref.texi docs/interop/qemu-ga-qapi.texi
-
 docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
     docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
     docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
diff --git a/MAINTAINERS b/MAINTAINERS
index ea93a69611b..2bf8744a9ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2137,9 +2137,9 @@ M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
 F: docs/interop/qemu-ga.rst
+F: docs/interop/qemu-ga-ref.rst
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
-F: docs/interop/qemu-ga-ref.texi
 T: git https://github.com/mdroth/qemu.git qga
 
 QOM
diff --git a/docs/index.html.in b/docs/index.html.in
index cf61b1cf448..ce10ce55a23 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -9,7 +9,6 @@
         <ul>
             <li><a href="qemu-doc.html">User Documentation</a></li>
             <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
-            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="system/index.html">System Emulation User's Guide</a></li>
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
index 049387ac6de..f3af38dce17 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,5 +18,6 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
+   qemu-ga-ref
    vhost-user
    vhost-user-gpu
diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
new file mode 100644
index 00000000000..013eac0bb53
--- /dev/null
+++ b/docs/interop/qemu-ga-ref.rst
@@ -0,0 +1,4 @@
+QEMU Guest Agent Protocol Reference
+===================================
+
+.. qapi-doc:: qga/qapi-schema.json
diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
deleted file mode 100644
index ddb76ce1c2a..00000000000
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
-@include qemu-ga-qapi.texi
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


