Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1D6C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3952A2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYXF1pfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3952A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dF2-0007RE-Cz
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDm-00060O-D0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6dDj-0004NZ-W1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:10 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:33236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6dDj-0004Mu-Na
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:38:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id m10so2593839wmc.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9et6CYLVOWf/Jq5yLPuq4lJ1LvCdxG33mYzAAZM5hJw=;
 b=qYXF1pfMEWvE6DKJUCEcLx5uvzAMFVYm97etqvVLcOkTP5NzlaEnPVw80iJtYCii8Y
 hPOHP7niBwFTjj3LSAbpCCerHYgpGdWrPAbZwRoGKuCZjufiMs9Nld0VU4t0e5P3Vy0j
 z/n3jnxHHPI6GCUQ+lQ6oJiN8e+PD7v7xxLWvyRswYuCtJaUtZ3aapngutUAFLbnzakF
 7DQ8Im2IUAGPW/w/2aADV1xn6nRzP5bhChXcM1rea39tk782Ua8LET0EX7CjYKwcaTp8
 Y2U9PqwOPXqilSGYQIZmkBg+S22UqwbuBegeEBajQoLiEpCloifQGzNjGV7uJ0gnzO6T
 bCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9et6CYLVOWf/Jq5yLPuq4lJ1LvCdxG33mYzAAZM5hJw=;
 b=jZKF+LaJW7pRA3T3C0/Ck2GDYnoEG51wWGHj0bTsUXdX3cZCwS5yPF8zU4VhARWMAQ
 cTX84yUSMaXXTq0FNlt8bzaWU56kO6m+kVlEQVbf98fmycYq9AO1rKun1ztXp5W61voi
 0OeXX8caxU/ONQWNMHNfSM108kbl8fQ2KouwxTSPCSutR2hgMuY51tqZzECJ1uKw7mzW
 RWNaBhecINE3kTVTt3JfvjFrCqbSQHQfo0Zo0XOL20cguiWT/CDsRHPdcrkBjHLDFX5s
 scdDh5nAGgkgVtlT9LBvoWRGe0cClyokolazaRKFhc6cIXFEPEJHEeGNK+JuvsFqIHs5
 JBmA==
X-Gm-Message-State: APjAAAWz3P1xLcS+EyZaceQQ6Wn3kD30QiCeNirzURSxS8DZAY4pN5Db
 qFFzxUIqMagne5hE5kTI0xvBqEX3
X-Google-Smtp-Source: APXvYqy6iCCTJRQG81tfnRDbvVaig906wEQl3eZZROf0WSGXCocNkUkako3ZtWqSav6J+cnxSNf16w==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr123264wmo.13.1582648681371; 
 Tue, 25 Feb 2020 08:38:01 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id q6sm18171398wrf.67.2020.02.25.08.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 08:38:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] docs: system: split CPU models doc between MIPS and x86
 parts
Date: Tue, 25 Feb 2020 17:37:56 +0100
Message-Id: <20200225163758.12996-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225163758.12996-1-pbonzini@redhat.com>
References: <20200225163758.12996-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 Makefile                                      |  11 +-
 docs/system/cpu-models-mips.texi              | 200 +++++++++++++++
 .../cpu-models-x86.texi}                      | 232 ------------------
 docs/system/qemu-cpu-models.texi              |  28 +++
 qemu-doc.texi                                 |   8 +-
 5 files changed, 238 insertions(+), 241 deletions(-)
 create mode 100644 docs/system/cpu-models-mips.texi
 rename docs/{qemu-cpu-models.texi => system/cpu-models-x86.texi} (71%)
 create mode 100644 docs/system/qemu-cpu-models.texi

diff --git a/Makefile b/Makefile
index 15f8e53d05..1facf0ce18 100644
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
@@ -857,7 +857,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -1098,7 +1098,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
-docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
+docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
@@ -1110,7 +1110,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
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
index 0000000000..4cfa9118ed
--- /dev/null
+++ b/docs/system/cpu-models-mips.texi
@@ -0,0 +1,200 @@
+@node recommendations_cpu_models_MIPS
+@subsection Supported CPU model configurations on MIPS hosts
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
+@subsubsection Supported CPU models for MIPS32 hosts
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
+@subsubsection Supported CPU models for MIPS64 hosts
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
+@subsubsection Supported CPU models for nanoMIPS hosts
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
+@subsubsection Preferred CPU models for MIPS hosts
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
+
+@node cpu_model_syntax_apps
+@subsection Syntax for configuring CPU models
+
+The example below illustrate the approach to configuring the various
+CPU models / features in QEMU and libvirt
+
+@menu
+* cpu_model_syntax_qemu::    QEMU command line
+* cpu_model_syntax_libvirt:: Libvirt guest XML
+@end menu
+
+@node cpu_model_syntax_qemu
+@subsubsection QEMU command line
+
+@table @option
+
+@item Host passthrough
+
+@example
+   $ @value{qemu_system_x86} -cpu host
+@end example
+
+With feature customization:
+
+@example
+   $ @value{qemu_system_x86} -cpu host,-vmx,...
+@end example
+
+@item Named CPU models
+
+@example
+   $ @value{qemu_system_x86} -cpu Westmere
+@end example
+
+With feature customization:
+
+@example
+   $ @value{qemu_system_x86} -cpu Westmere,+pcid,...
+@end example
+
+@end table
+
diff --git a/docs/qemu-cpu-models.texi b/docs/system/cpu-models-x86.texi
similarity index 71%
rename from docs/qemu-cpu-models.texi
rename to docs/system/cpu-models-x86.texi
index f88a1def0d..9d832da0d3 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/system/cpu-models-x86.texi
@@ -1,17 +1,3 @@
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
-
 QEMU / KVM virtualization supports two ways to configure CPU models
 
 @table @option
@@ -403,206 +389,6 @@ hardware assisted virtualization, that should thus not be required for
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
-@node cpu_model_syntax_apps
-@subsection Syntax for configuring CPU models
-
-The example below illustrate the approach to configuring the various
-CPU models / features in QEMU and libvirt
-
-@menu
-* cpu_model_syntax_qemu::    QEMU command line
-* cpu_model_syntax_libvirt:: Libvirt guest XML
-@end menu
-
-@node cpu_model_syntax_qemu
-@subsubsection QEMU command line
-
-@table @option
-
-@item Host passthrough
-
-@example
-   $ @value{qemu_system_x86} -cpu host
-@end example
-
-With feature customization:
-
-@example
-   $ @value{qemu_system_x86} -cpu host,-vmx,...
-@end example
-
-@item Named CPU models
-
-@example
-   $ @value{qemu_system_x86} -cpu Westmere
-@end example
-
-With feature customization:
-
-@example
-   $ @value{qemu_system_x86} -cpu Westmere,+pcid,...
-@end example
-
-@end table
-
 @node cpu_model_syntax_libvirt
 @subsubsection Libvirt guest XML
 
@@ -657,21 +443,3 @@ With feature customization:
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
index 56d3e57cfb..41581e7996 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -615,10 +615,7 @@ The monitor understands integers expressions for every integer
 argument. You can use register names to get the value of specifics
 CPU registers by prefixing them with @emph{$}.
 
-@node cpu_models
-@section CPU models
-
-@include docs/qemu-cpu-models.texi
+@include docs/system/cpu-models-x86.texi
 
 @node disk_images
 @section Disk Images
@@ -1865,6 +1862,7 @@ Set the emulated machine type. The default is sun4u.
 @cindex system emulation (MIPS)
 
 @menu
+* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
 * nanoMIPS System emulator ::
 @end menu
 
@@ -1981,6 +1979,8 @@ PC style serial port
 MIPSnet network emulation
 @end itemize
 
+@include docs/system/cpu-models-mips.texi
+
 @node nanoMIPS System emulator
 @subsection nanoMIPS System emulator
 @cindex system emulation (nanoMIPS)
-- 
2.21.1



