Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16672C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67C1246AC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhPb59Z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67C1246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hy4-0005ZW-2M
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhT-0001pn-GC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhR-0005BW-WC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:15 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:34139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhR-0005Av-OB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id i10so8499663wmd.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Tk1f0J2M6m4DwoqxhwTk4P79z+XBBUKyB5/ILOj45I=;
 b=lhPb59Z2nbvNlFEwW6gBkgXGQmzcWjq/3Haj4vHw2Yl3IlId1zOeb1k18gyA0orYBd
 yoe/roSgiv9R+eWIeQAe63BmCh7JZWSMhp1Mg4QzPo0hIiPik2veUYCunfu5IFjKQQI7
 G2nDYmGRlBRIYd1RotKwmkEGl3lph30VaxInYc0d3X/B9uppudmx1KXyclp6Vs1HXtAn
 ohdfaBFOQU2UQxc+D1t/cKa9Dl0ChZMPh0ZJEEBl1nJZZpSdfZRRDCv5abAdfeWLSIKr
 W1XviDv3SGmyt25ifth1t4yGvh6BM36IYY0Yr1pWZa2N5MJg1pu1vutN1uLXcOh64WNr
 4sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Tk1f0J2M6m4DwoqxhwTk4P79z+XBBUKyB5/ILOj45I=;
 b=Noidy67WBunFayEZNuiZC+k71y1HMiUFuFCbb14tkTlocYUlsFkoqp+Q++WeKj9RrT
 0VZbu59Vmwj7bVxz/fo8tpse+EeHp5O3erNm+dRODEaowoM1/W+iCs4veP6aSfT2859W
 4jkJ4cOBql43wvC0Lk3ELc+N7guo9+x2TBjGOZ3U+HkyrQnBy93E4OL5A32vn5CcNq2Z
 glsyZPOV46qa5RERmUDYV+1hHIPjFaIkl5C+sjcN8om8CERshM0byCy2j7mYNTm26NLp
 mzNJt8DZ3ElW6GEY7LKLFIhJRXGm+ewgBBK/2d+WaVaxOJgXA5ohbMbMG/rIXkzINC4/
 bCog==
X-Gm-Message-State: APjAAAVdmdWJD8TPQc6BWUoG6jkdyBrUStRNkKVNhiIRD23Bf/AS1dCd
 VMoNfp1xGWkAB6aA4n4ugXftXjtL9V6dag==
X-Google-Smtp-Source: APXvYqxC4xwA1G2J8GI2HWPFpwuya/iG5apSCZWgvAiIl6hdJeDfOSoKoqwV0X+Q7Z6o3tNbaKj/hA==
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr61049wmj.20.1582904232301;
 Fri, 28 Feb 2020 07:37:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:37:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/33] docs: Stop building qemu-doc
Date: Fri, 28 Feb 2020 15:36:17 +0000
Message-Id: <20200228153619.9906-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stop building the old texinfo qemu-doc; all its contents are
now available in the Sphinx-generated manuals and manpages.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/ivshmem-spec.txt |  4 ++--
 Makefile                    | 39 ++++---------------------------------
 .gitignore                  |  3 ---
 docs/index.html.in          |  1 -
 4 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/docs/specs/ivshmem-spec.txt b/docs/specs/ivshmem-spec.txt
index 042f7eae225..1beb3a01ec3 100644
--- a/docs/specs/ivshmem-spec.txt
+++ b/docs/specs/ivshmem-spec.txt
@@ -38,8 +38,8 @@ There are two basic configurations:
   Interrupts are message-signaled (MSI-X).  vectors=N configures the
   number of vectors to use.
 
-For more details on ivshmem device properties, see The QEMU Emulator
-User Documentation (qemu-doc.*).
+For more details on ivshmem device properties, see the QEMU Emulator
+user documentation.
 
 
 == The ivshmem PCI device's guest interface ==
diff --git a/Makefile b/Makefile
index ef10b9a031d..9d4b2241265 100644
--- a/Makefile
+++ b/Makefile
@@ -344,7 +344,6 @@ MANUAL_BUILDDIR := docs
 endif
 
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu.1
 DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-img.1
 DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
@@ -768,10 +767,6 @@ distclean: clean
 	rm -f $(SUBDIR_DEVICES_MAK)
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
-	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
-	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
-	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
@@ -851,8 +846,6 @@ install-sphinxdocs: sphinxdocs
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
@@ -1110,34 +1103,10 @@ docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-
-qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-options.texi \
-	qemu-monitor.texi \
-	qemu-monitor-info.texi \
-        docs/system/quickstart.texi \
-        docs/system/invocation.texi \
-        docs/system/keys.texi \
-        docs/system/mux-chardev.texi \
-        docs/system/monitor.texi \
-        docs/system/cpu-models-x86.texi \
-        docs/system/images.texi \
-        docs/system/net.texi \
-        docs/system/usb.texi \
-        docs/system/ivshmem.texi \
-        docs/system/linuxboot.texi \
-        docs/system/vnc-security.texi \
-        docs/system/tls.texi \
-        docs/system/gdb.texi \
-        docs/system/build-platforms.texi \
-        docs/system/license.texi \
-	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
-	docs/system/deprecated.texi docs/system/qemu-option-trace.texi \
-	docs/system/security.texi
+html: docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
+info: docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
+pdf: docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
+txt: docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/.gitignore b/.gitignore
index bc0a035f9cc..0c5af83aa74 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,9 +46,6 @@
 !/qapi/qapi-visit-core.c
 /qapi/qapi-visit.[ch]
 /qapi/qapi-doc.texi
-/qemu-doc.html
-/qemu-doc.info
-/qemu-doc.txt
 /qemu-edid
 /qemu-img
 /qemu-nbd
diff --git a/docs/index.html.in b/docs/index.html.in
index a576ace8a27..cc19aad2ec5 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -7,7 +7,6 @@
     <body>
         <h1>QEMU @@VERSION@@ Documentation</h1>
         <ul>
-            <li><a href="qemu-doc.html">User Documentation</a></li>
             <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
             <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
-- 
2.20.1


