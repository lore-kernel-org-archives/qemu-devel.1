Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D491CC4BA11
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9295E24688
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtvwtJRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9295E24688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uxI-0005x5-P3
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uto-0000ej-00
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utk-0005xk-HF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utk-0005sJ-39
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p9so2630064wmc.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BYBCjZYUtsCB+EF+qyEy5T7SBWWZqU/nVxEGQTJOA/8=;
 b=OtvwtJRgTSkGGo3f3R0z2xGtFBsuC95iZ4FeY+hENZhRdH99LBrmkAkZQ8RvZD9hAy
 vOJuHfksHJ/sIN12n1S/zbkdOhJWwDPnCx7fW7kFCEKOyiWPPlaVC4YFmBjV3/ml8iZc
 ioAUZuRUAi56/L/h5+SpvYVWWGxmkiDWxfFbdOz7xhU/5VI+YibKrMZadpvB/rVTEIe7
 NMu1WQUmPHw3IOh8wRcc1JRVT8QfKN94SyIdQLnQLU5F0GHVSra+pjacmzharCwQ2e7c
 DzHXj312PwKw0ZijIkq2x/8zbgVOz/ZHcoU4q1ib6gbuPc0Qz+Qboj61MFB78xXk8H7g
 mNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BYBCjZYUtsCB+EF+qyEy5T7SBWWZqU/nVxEGQTJOA/8=;
 b=lOjo8F3r5TjdLd0MlXFYmtcPEhFw9ukaagvlNOWvreJn0LTgdgVs9i20ieR+vtVx2s
 nyONtje3j0bGSLXfxC1CVK2Xwgu2lONmRwZA/tUdsIz5P4DKIFjn9hTxVuKQNpykM/Ky
 MvXKXsTv7lkFMzISxrdXmHDjYe9T58Q3ZsqRhN9UgDkLjqAl+PnzRTjAJKYt9LMrQydf
 jWA92X2a+Xz+OQ6HNZI3IIzGcPu8MMPBTn4Rf4UspvxP5/w1p+uTtcq1bISe4u+7xYiH
 P0gKHyQIuqiU2VmoxC04SJgAOxx+yK2yhBUeABxVIE6MJl6XpEnEuDt8oXoje6EqWMmq
 MCZw==
X-Gm-Message-State: APjAAAUiO2ZKBwCHENjVCQI2Bu6N3uRLuwN/YWAyxCpObZScnHxbgBjQ
 tlxT5imfY2b6OXELZLIfmzB6RUHv
X-Google-Smtp-Source: APXvYqwWbgrrvX5aHwRD1nNFTLpaVNv6kyKyetJ7L+rjS6cNGizh8QlE0SsUQ4Xo6zeN8ZF+Jul5XQ==
X-Received: by 2002:a1c:a594:: with SMTP id o142mr4790297wme.146.1582716637982; 
 Wed, 26 Feb 2020 03:30:37 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/18] qemu-doc: split CPU models doc between MIPS and x86
 parts
Date: Wed, 26 Feb 2020 12:30:20 +0100
Message-Id: <20200226113034.6741-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MIPS CPU models end up in the middle of the PC documentation.  Move
them to a separate file so that they can be placed in the right section.

The man page still includes both x86 and MIPS content.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                   |   3 +-
 Makefile                                      |  11 +-
 docs/system/cpu-models-mips.texi              | 157 +++++++++++++
 .../cpu-models-x86.texi}                      | 221 ++----------------
 docs/system/qemu-cpu-models.texi              |  28 +++
 qemu-doc.texi                                 |  12 +-
 6 files changed, 213 insertions(+), 219 deletions(-)
 create mode 100644 docs/system/cpu-models-mips.texi
 rename docs/{qemu-cpu-models.texi => system/cpu-models-x86.texi} (71%)
 create mode 100644 docs/system/qemu-cpu-models.texi

diff --git a/MAINTAINERS b/MAINTAINERS
index 36d94c17a6..574b80498c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -215,6 +215,7 @@ S: Maintained
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
+F: docs/system/cpu-models-mips.texi
 F: hw/intc/mips_gic.c
 F: hw/mips/
 F: hw/misc/mips_*
@@ -319,7 +320,7 @@ F: tests/tcg/i386/
 F: tests/tcg/x86_64/
 F: hw/i386/
 F: disas/i386.c
-F: docs/qemu-cpu-models.texi
+F: docs/system/cpu-models-x86.texi
 T: git https://github.com/ehabkost/qemu.git x86-next
 
 Xtensa TCG CPUs
diff --git a/Makefile b/Makefile
index 73d8ed2b6a..402eab258d 100644
--- a/Makefile
+++ b/Makefile
@@ -354,7 +354,7 @@ endif
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
-DOCS+=docs/qemu-cpu-models.7
+DOCS+=docs/system/qemu-cpu-models.7
 DOCS+=$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
 DOCS+=$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
@@ -780,7 +780,7 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-	rm -f docs/qemu-cpu-models.7
+	rm -f docs/system/qemu-cpu-models.7
 	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
@@ -859,7 +859,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -1104,7 +1104,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
-docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
+docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
@@ -1116,7 +1116,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-tech.texi qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi \
 	qemu-monitor-info.texi \
-	docs/qemu-cpu-models.texi docs/security.texi
+	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
+	docs/security.texi
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/docs/system/cpu-models-mips.texi b/docs/system/cpu-models-mips.texi
new file mode 100644
index 0000000000..6a0370cb69
--- /dev/null
+++ b/docs/system/cpu-models-mips.texi
@@ -0,0 +1,157 @@
+@node recommendations_cpu_models_MIPS
+@section Supported CPU model configurations on MIPS hosts
+
+QEMU supports variety of MIPS CPU models:
+
+@menu
+* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
+* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
+* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS hosts
+* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
+@end menu
+
+@node cpu_models_MIPS32
+@subsection Supported CPU models for MIPS32 hosts
+
+The following CPU models are supported for use on MIPS32 hosts. Administrators /
+applications are recommended to use the CPU model that matches the generation
+of the host CPUs in use. In a deployment with a mixture of host CPU models
+between machines, if live migration compatibility is required, use the newest
+CPU model that is compatible across all desired hosts.
+
+@table @option
+@item @code{mips32r6-generic}
+
+MIPS32 Processor (Release 6, 2015)
+
+
+@item @code{P5600}
+
+MIPS32 Processor (P5600, 2014)
+
+
+@item @code{M14K}
+@item @code{M14Kc}
+
+MIPS32 Processor (M14K, 2009)
+
+
+@item @code{74Kf}
+
+MIPS32 Processor (74K, 2007)
+
+
+@item @code{34Kf}
+
+MIPS32 Processor (34K, 2006)
+
+
+@item @code{24Kc}
+@item @code{24KEc}
+@item @code{24Kf}
+
+MIPS32 Processor (24K, 2003)
+
+
+@item @code{4Kc}
+@item @code{4Km}
+@item @code{4KEcR1}
+@item @code{4KEmR1}
+@item @code{4KEc}
+@item @code{4KEm}
+
+MIPS32 Processor (4K, 1999)
+@end table
+
+@node cpu_models_MIPS64
+@subsection Supported CPU models for MIPS64 hosts
+
+The following CPU models are supported for use on MIPS64 hosts. Administrators /
+applications are recommended to use the CPU model that matches the generation
+of the host CPUs in use. In a deployment with a mixture of host CPU models
+between machines, if live migration compatibility is required, use the newest
+CPU model that is compatible across all desired hosts.
+
+@table @option
+@item @code{I6400}
+
+MIPS64 Processor (Release 6, 2014)
+
+
+@item @code{Loongson-2F}
+
+MIPS64 Processor (Loongson 2, 2008)
+
+
+@item @code{Loongson-2E}
+
+MIPS64 Processor (Loongson 2, 2006)
+
+
+@item @code{mips64dspr2}
+
+MIPS64 Processor (Release 2, 2006)
+
+
+@item @code{MIPS64R2-generic}
+@item @code{5KEc}
+@item @code{5KEf}
+
+MIPS64 Processor (Release 2, 2002)
+
+
+@item @code{20Kc}
+
+MIPS64 Processor (20K, 2000)
+
+
+@item @code{5Kc}
+@item @code{5Kf}
+
+MIPS64 Processor (5K, 1999)
+
+
+@item @code{VR5432}
+
+MIPS64 Processor (VR, 1998)
+
+
+@item @code{R4000}
+
+MIPS64 Processor (MIPS III, 1991)
+@end table
+
+@node cpu_models_nanoMIPS
+@subsection Supported CPU models for nanoMIPS hosts
+
+The following CPU models are supported for use on nanoMIPS hosts. Administrators /
+applications are recommended to use the CPU model that matches the generation
+of the host CPUs in use. In a deployment with a mixture of host CPU models
+between machines, if live migration compatibility is required, use the newest
+CPU model that is compatible across all desired hosts.
+
+@table @option
+@item @code{I7200}
+
+MIPS I7200 (nanoMIPS, 2018)
+
+@end table
+
+@node preferred_cpu_models_MIPS
+@subsection Preferred CPU models for MIPS hosts
+
+The following CPU models are preferred for use on different MIPS hosts:
+
+@table @option
+@item @code{MIPS III}
+R4000
+
+@item @code{MIPS32R2}
+34Kf
+
+@item @code{MIPS64R6}
+I6400
+
+@item @code{nanoMIPS}
+I7200
+@end table
diff --git a/docs/qemu-cpu-models.texi b/docs/system/cpu-models-x86.texi
similarity index 71%
rename from docs/qemu-cpu-models.texi
rename to docs/system/cpu-models-x86.texi
index f88a1def0d..0cd64b0522 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/system/cpu-models-x86.texi
@@ -1,16 +1,5 @@
-@c man begin SYNOPSIS
-QEMU / KVM CPU model configuration
-@c man end
-
-@set qemu_system_x86 qemu-system-x86_64
-
-@c man begin DESCRIPTION
-
-@menu
-* recommendations_cpu_models_x86::  Recommendations for KVM CPU model configuration on x86 hosts
-* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
-* cpu_model_syntax_apps::           Syntax for configuring CPU models
-@end menu
+@node cpu_models_x86
+@section Recommendations for KVM CPU model configuration on x86 hosts
 
 QEMU / KVM virtualization supports two ways to configure CPU models
 
@@ -45,9 +34,6 @@ stepping, etc will precisely match the host CPU, as they would with "Host
 passthrough", but gives much of the benefit of passthrough, while making
 live migration safe.
 
-@node recommendations_cpu_models_x86
-@subsection Recommendations for KVM CPU model configuration on x86 hosts
-
 The information that follows provides recommendations for configuring
 CPU models on x86 hosts. The goals are to maximise performance, while
 protecting guest OS against various CPU hardware flaws, and optionally
@@ -60,10 +46,11 @@ enabling live migration between hosts with heterogeneous CPU models.
 * important_cpu_features_amd_x86::       Important CPU features for AMD x86 hosts
 * default_cpu_models_x86::               Default x86 CPU models
 * other_non_recommended_cpu_models_x86:: Other non-recommended x86 CPUs
+* cpu_model_syntax_apps::                Syntax for configuring CPU models
 @end menu
 
 @node preferred_cpu_models_intel_x86
-@subsubsection Preferred CPU models for Intel x86 hosts
+@subsection Preferred CPU models for Intel x86 hosts
 
 The following CPU models are preferred for use on Intel hosts. Administrators /
 applications are recommended to use the CPU model that matches the generation
@@ -136,7 +123,7 @@ Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
 @end table
 
 @node important_cpu_features_intel_x86
-@subsubsection Important CPU features for Intel x86 hosts
+@subsection Important CPU features for Intel x86 hosts
 
 The following are important CPU features that should be used on Intel x86
 hosts, when available in the host CPU. Some of them require explicit
@@ -218,7 +205,7 @@ can be used for guest CPUs.
 
 
 @node preferred_cpu_models_amd_x86
-@subsubsection Preferred CPU models for AMD x86 hosts
+@subsection Preferred CPU models for AMD x86 hosts
 
 The following CPU models are preferred for use on Intel hosts. Administrators /
 applications are recommended to use the CPU model that matches the generation
@@ -260,7 +247,7 @@ AMD Opteron 240 (Gen 1 Class Opteron, 2004)
 @end table
 
 @node important_cpu_features_amd_x86
-@subsubsection Important CPU features for AMD x86 hosts
+@subsection Important CPU features for AMD x86 hosts
 
 The following are important CPU features that should be used on AMD x86
 hosts, when available in the host CPU. Some of them require explicit
@@ -349,7 +336,7 @@ Note that not all CPU hardware will support this feature.
 
 
 @node default_cpu_models_x86
-@subsubsection Default x86 CPU models
+@subsection Default x86 CPU models
 
 The default QEMU CPU models are designed such that they can run on all hosts.
 If an application does not wish to do perform any host compatibility checks
@@ -372,7 +359,7 @@ qemu64 is used for x86_64 guests and qemu32 is used for i686 guests, when no
 
 
 @node other_non_recommended_cpu_models_x86
-@subsubsection Other non-recommended x86 CPUs
+@subsection Other non-recommended x86 CPUs
 
 The following CPUs models are compatible with most AMD and Intel x86 hosts, but
 their usage is discouraged, as they expose a very limited featureset, which
@@ -403,177 +390,13 @@ hardware assisted virtualization, that should thus not be required for
 running virtual machines.
 @end table
 
-@node recommendations_cpu_models_MIPS
-@subsection Supported CPU model configurations on MIPS hosts
-
-QEMU supports variety of MIPS CPU models:
-
-@menu
-* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
-* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
-* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS hosts
-* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
-@end menu
-
-@node cpu_models_MIPS32
-@subsubsection Supported CPU models for MIPS32 hosts
-
-The following CPU models are supported for use on MIPS32 hosts. Administrators /
-applications are recommended to use the CPU model that matches the generation
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the newest
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{mips32r6-generic}
-
-MIPS32 Processor (Release 6, 2015)
-
-
-@item @code{P5600}
-
-MIPS32 Processor (P5600, 2014)
-
-
-@item @code{M14K}
-@item @code{M14Kc}
-
-MIPS32 Processor (M14K, 2009)
-
-
-@item @code{74Kf}
-
-MIPS32 Processor (74K, 2007)
-
-
-@item @code{34Kf}
-
-MIPS32 Processor (34K, 2006)
-
-
-@item @code{24Kc}
-@item @code{24KEc}
-@item @code{24Kf}
-
-MIPS32 Processor (24K, 2003)
-
-
-@item @code{4Kc}
-@item @code{4Km}
-@item @code{4KEcR1}
-@item @code{4KEmR1}
-@item @code{4KEc}
-@item @code{4KEm}
-
-MIPS32 Processor (4K, 1999)
-@end table
-
-@node cpu_models_MIPS64
-@subsubsection Supported CPU models for MIPS64 hosts
-
-The following CPU models are supported for use on MIPS64 hosts. Administrators /
-applications are recommended to use the CPU model that matches the generation
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the newest
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{I6400}
-
-MIPS64 Processor (Release 6, 2014)
-
-
-@item @code{Loongson-2F}
-
-MIPS64 Processor (Loongson 2, 2008)
-
-
-@item @code{Loongson-2E}
-
-MIPS64 Processor (Loongson 2, 2006)
-
-
-@item @code{mips64dspr2}
-
-MIPS64 Processor (Release 2, 2006)
-
-
-@item @code{MIPS64R2-generic}
-@item @code{5KEc}
-@item @code{5KEf}
-
-MIPS64 Processor (Release 2, 2002)
-
-
-@item @code{20Kc}
-
-MIPS64 Processor (20K, 2000)
-
-
-@item @code{5Kc}
-@item @code{5Kf}
-
-MIPS64 Processor (5K, 1999)
-
-
-@item @code{VR5432}
-
-MIPS64 Processor (VR, 1998)
-
-
-@item @code{R4000}
-
-MIPS64 Processor (MIPS III, 1991)
-@end table
-
-@node cpu_models_nanoMIPS
-@subsubsection Supported CPU models for nanoMIPS hosts
-
-The following CPU models are supported for use on nanoMIPS hosts. Administrators /
-applications are recommended to use the CPU model that matches the generation
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the newest
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{I7200}
-
-MIPS I7200 (nanoMIPS, 2018)
-
-@end table
-
-@node preferred_cpu_models_MIPS
-@subsubsection Preferred CPU models for MIPS hosts
-
-The following CPU models are preferred for use on different MIPS hosts:
-
-@table @option
-@item @code{MIPS III}
-R4000
-
-@item @code{MIPS32R2}
-34Kf
-
-@item @code{MIPS64R6}
-I6400
-
-@item @code{nanoMIPS}
-I7200
-@end table
-
 @node cpu_model_syntax_apps
 @subsection Syntax for configuring CPU models
 
 The example below illustrate the approach to configuring the various
-CPU models / features in QEMU and libvirt
-
-@menu
-* cpu_model_syntax_qemu::    QEMU command line
-* cpu_model_syntax_libvirt:: Libvirt guest XML
-@end menu
+CPU models / features in QEMU and libvirt.
 
-@node cpu_model_syntax_qemu
-@subsubsection QEMU command line
+QEMU command line:
 
 @table @option
 
@@ -603,8 +426,8 @@ With feature customization:
 
 @end table
 
-@node cpu_model_syntax_libvirt
-@subsubsection Libvirt guest XML
+
+Libvirt guest XML:
 
 @table @option
 
@@ -657,21 +480,3 @@ With feature customization:
 @end example
 
 @end table
-
-@c man end
-
-@ignore
-
-@setfilename qemu-cpu-models
-@settitle QEMU / KVM CPU model configuration
-
-@c man begin SEEALSO
-The HTML documentation of QEMU for more precise information and Linux
-user mode emulator invocation.
-@c man end
-
-@c man begin AUTHOR
-Daniel P. Berrange
-@c man end
-
-@end ignore
diff --git a/docs/system/qemu-cpu-models.texi b/docs/system/qemu-cpu-models.texi
new file mode 100644
index 0000000000..f399daf944
--- /dev/null
+++ b/docs/system/qemu-cpu-models.texi
@@ -0,0 +1,28 @@
+@c man begin SYNOPSIS
+QEMU / KVM CPU model configuration
+@c man end
+
+@set qemu_system_x86 qemu-system-x86_64
+
+@c man begin DESCRIPTION
+
+@include cpu-models-x86.texi
+@include cpu-models-mips.texi
+
+@c man end
+
+@ignore
+
+@setfilename qemu-cpu-models
+@settitle QEMU / KVM CPU model configuration
+
+@c man begin SEEALSO
+The HTML documentation of QEMU for more precise information and Linux
+user mode emulator invocation.
+@c man end
+
+@c man begin AUTHOR
+Daniel P. Berrange
+@c man end
+
+@end ignore
diff --git a/qemu-doc.texi b/qemu-doc.texi
index e555dea4ef..617a701b67 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -139,7 +139,7 @@ accelerator is required to use more than one host CPU for emulation.
 * pcsys_keys::         Keys in the graphical frontends
 * mux_keys::           Keys in the character backend multiplexer
 * pcsys_monitor::      QEMU Monitor
-* cpu_models::         CPU models
+* cpu_models_x86::     Supported CPU model configurations on x86 hosts
 * disk_images::        Disk Images
 * pcsys_network::      Network emulation
 * pcsys_other_devs::   Other Devices
@@ -614,10 +614,7 @@ The monitor understands integers expressions for every integer
 argument. You can use register names to get the value of specifics
 CPU registers by prefixing them with @emph{$}.
 
-@node cpu_models
-@section CPU models
-
-@include docs/qemu-cpu-models.texi
+@include docs/system/cpu-models-x86.texi
 
 @node disk_images
 @section Disk Images
@@ -1864,6 +1861,7 @@ Set the emulated machine type. The default is sun4u.
 @cindex system emulation (MIPS)
 
 @menu
+* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
 * nanoMIPS System emulator ::
 @end menu
 
@@ -1980,6 +1978,10 @@ PC style serial port
 MIPSnet network emulation
 @end itemize
 
+@lowersections
+@include docs/system/cpu-models-mips.texi
+@raisesections
+
 @node nanoMIPS System emulator
 @subsection nanoMIPS System emulator
 @cindex system emulation (nanoMIPS)
-- 
2.21.1



