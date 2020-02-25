Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAFFC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873C42082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpLMeaWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873C42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cML-0006L2-N9
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cKw-0003Fp-5P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cKt-0000wE-V3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6cKt-0000vb-OF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:27 -0500
Received: by mail-wm1-x342.google.com with SMTP id i10so1373317wmd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+xQwySRNq9Q0V50hcZNj7lBkaorNu0H4nocAkxCMi8o=;
 b=WpLMeaWkwtbvFRs46zP3fm9F/LI7R+/rbq+fEeNNn1BG+FhqutTQ+Aeacl00rdM/y5
 UE8zgh5qP7TIwV1Ehuo4IMIbXPLP+2gQFCRawmN6GRdtUPbVMrvsrWj5PsekZa02vrJu
 yRBbYs657HMotS7KF5e/XyvIWVpTh+GGnRVVA/JoUh7jDcfoRPFtX0sWxfRFEdVvxZai
 NbgzoQ2/OKhGiJ/eyBo43GYO3DRdenzK4CZbrimlcJpYQHVAM/p8P+ZDTuJTFi6jnfd1
 ErKkIVKy+Srbwy72SchPrAItwjMhTmAUVCO4yE8cBANw0ZcBONCIP7X7Ng6UmB339ToJ
 hvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+xQwySRNq9Q0V50hcZNj7lBkaorNu0H4nocAkxCMi8o=;
 b=XvFWX0vSlx09+OaO04Cj5j7pvJOT7oFyYk64gIo3AOXrHSA9gWk/+c/AvyncFERe4z
 /mqxwwJKw/7UgKhYmR/Hggqa06uGevoEJnNtKUnL85Gp7DlCAj7WXgNAa9sESB5d72X4
 v4DwZkPGRk2Lm6OjVxwNHA7BFxAsvLvoIDddS4rxrBr7lGNTtflXhgSVg6+7hOwK2Cbq
 zzSBgbVpRpZ/r3+Iv4zPUOT63+ZWgcDv6e2+iDRpVuWSYAMOyA4kOGhtdL+SCv+Hhd4M
 NbqUqstwLw5SUvpniRZbL8tQ9fbX/sASwO2Exa3YjftrVugXCLhinIATrK2h0KNjGEi+
 XqGQ==
X-Gm-Message-State: APjAAAUtL5qI0LYIsQklrwMXgY6UF+FNH/NpznAwBQv/mFdDkr8q4fot
 HDed9sOHLl9yyeLNOct566dE+BxFhrFimg==
X-Google-Smtp-Source: APXvYqwGhlmO1Mhrj3Ey66IheZBkflNeQtS3oE7F4Bihg2k6pCOyRV8ilPPV0AsYfmTJ9iGyBKH3aA==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr6218574wme.26.1582645285988; 
 Tue, 25 Feb 2020 07:41:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm24438604wrq.44.2020.02.25.07.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:41:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] docs: Convert security.texi to rST format
Date: Tue, 25 Feb 2020 15:41:18 +0000
Message-Id: <20200225154121.21116-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225154121.21116-1-peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

security.texi is included from qemu-doc.texi but is not used
in the qemu.1 manpage. So we can do a straightforward conversion
of the contents, which go into the system manual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                                    |  2 +-
 docs/system/index.rst                       |  1 +
 docs/{security.texi => system/security.rst} | 82 +++++++++++----------
 qemu-doc.texi                               |  3 -
 4 files changed, 46 insertions(+), 42 deletions(-)
 rename docs/{security.texi => system/security.rst} (77%)

diff --git a/Makefile b/Makefile
index aa9cc0b5847..5f0f803b471 100644
--- a/Makefile
+++ b/Makefile
@@ -1117,7 +1117,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-tech.texi qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi \
 	qemu-monitor-info.texi \
-	docs/qemu-cpu-models.texi docs/security.texi
+	docs/qemu-cpu-models.texi
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/docs/system/index.rst b/docs/system/index.rst
index f66e6ea585c..794e5d8de03 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -15,3 +15,4 @@ Contents:
    :maxdepth: 2
 
    qemu-block-drivers
+   security
diff --git a/docs/security.texi b/docs/system/security.rst
similarity index 77%
rename from docs/security.texi
rename to docs/system/security.rst
index 0d6b30edfc0..f2092c8768b 100644
--- a/docs/security.texi
+++ b/docs/system/security.rst
@@ -1,19 +1,22 @@
-@node Security
-@chapter Security
+Security
+========
 
-@section Overview
+Overview
+--------
 
 This chapter explains the security requirements that QEMU is designed to meet
 and principles for securely deploying QEMU.
 
-@section Security Requirements
+Security Requirements
+---------------------
 
 QEMU supports many different use cases, some of which have stricter security
 requirements than others.  The community has agreed on the overall security
 requirements that users may depend on.  These requirements define what is
 considered supported from a security perspective.
 
-@subsection Virtualization Use Case
+Virtualization Use Case
+'''''''''''''''''''''''
 
 The virtualization use case covers cloud and virtual private server (VPS)
 hosting, as well as traditional data center and desktop virtualization.  These
@@ -23,18 +26,17 @@ safely on the physical CPU at close-to-native speed.
 The following entities are untrusted, meaning that they may be buggy or
 malicious:
 
-@itemize
-@item Guest
-@item User-facing interfaces (e.g. VNC, SPICE, WebSocket)
-@item Network protocols (e.g. NBD, live migration)
-@item User-supplied files (e.g. disk images, kernels, device trees)
-@item Passthrough devices (e.g. PCI, USB)
-@end itemize
+- Guest
+- User-facing interfaces (e.g. VNC, SPICE, WebSocket)
+- Network protocols (e.g. NBD, live migration)
+- User-supplied files (e.g. disk images, kernels, device trees)
+- Passthrough devices (e.g. PCI, USB)
 
 Bugs affecting these entities are evaluated on whether they can cause damage in
 real-world use cases and treated as security bugs if this is the case.
 
-@subsection Non-virtualization Use Case
+Non-virtualization Use Case
+'''''''''''''''''''''''''''
 
 The non-virtualization use case covers emulation using the Tiny Code Generator
 (TCG).  In principle the TCG and device emulation code used in conjunction with
@@ -47,12 +49,14 @@ Bugs affecting the non-virtualization use case are not considered security
 bugs at this time.  Users with non-virtualization use cases must not rely on
 QEMU to provide guest isolation or any security guarantees.
 
-@section Architecture
+Architecture
+------------
 
 This section describes the design principles that ensure the security
 requirements are met.
 
-@subsection Guest Isolation
+Guest Isolation
+'''''''''''''''
 
 Guest isolation is the confinement of guest code to the virtual machine.  When
 guest code gains control of execution on the host this is called escaping the
@@ -71,7 +75,8 @@ malicious guest must not gain control of other guests or access their data.
 Disk image files and network traffic must be protected from other guests unless
 explicitly shared between them by the user.
 
-@subsection Principle of Least Privilege
+Principle of Least Privilege
+''''''''''''''''''''''''''''
 
 The principle of least privilege states that each component only has access to
 the privileges necessary for its function.  In the case of QEMU this means that
@@ -84,7 +89,7 @@ the guest.
 
 Following the principle of least privilege immediately fulfills guest isolation
 requirements.  For example, guest A only has access to its own disk image file
-@code{a.img} and not guest B's disk image file @code{b.img}.
+``a.img`` and not guest B's disk image file ``b.img``.
 
 In reality certain resources are inaccessible to the guest but must be
 available to QEMU to perform its function.  For example, host system calls are
@@ -95,7 +100,8 @@ New features must be designed to follow the principle of least privilege.
 Should this not be possible for technical reasons, the security risk must be
 clearly documented so users are aware of the trade-off of enabling the feature.
 
-@subsection Isolation mechanisms
+Isolation mechanisms
+''''''''''''''''''''
 
 Several isolation mechanisms are available to realize this architecture of
 guest isolation and the principle of least privilege.  With the exception of
@@ -105,46 +111,46 @@ described briefly for Linux here.
 
 The fundamental isolation mechanism is that QEMU processes must run as
 unprivileged users.  Sometimes it seems more convenient to launch QEMU as
-root to give it access to host devices (e.g. @code{/dev/net/tun}) but this poses a
+root to give it access to host devices (e.g. ``/dev/net/tun``) but this poses a
 huge security risk.  File descriptor passing can be used to give an otherwise
 unprivileged QEMU process access to host devices without running QEMU as root.
 It is also possible to launch QEMU as a non-root user and configure UNIX groups
-for access to @code{/dev/kvm}, @code{/dev/net/tun}, and other device nodes.
+for access to ``/dev/kvm``, ``/dev/net/tun``, and other device nodes.
 Some Linux distros already ship with UNIX groups for these devices by default.
 
-@itemize
-@item SELinux and AppArmor make it possible to confine processes beyond the
-traditional UNIX process and file permissions model.  They restrict the QEMU
-process from accessing processes and files on the host system that are not
-needed by QEMU.
+- SELinux and AppArmor make it possible to confine processes beyond the
+  traditional UNIX process and file permissions model.  They restrict the QEMU
+  process from accessing processes and files on the host system that are not
+  needed by QEMU.
 
-@item Resource limits and cgroup controllers provide throughput and utilization
-limits on key resources such as CPU time, memory, and I/O bandwidth.
+- Resource limits and cgroup controllers provide throughput and utilization
+  limits on key resources such as CPU time, memory, and I/O bandwidth.
 
-@item Linux namespaces can be used to make process, file system, and other system
-resources unavailable to QEMU.  A namespaced QEMU process is restricted to only
-those resources that were granted to it.
+- Linux namespaces can be used to make process, file system, and other system
+  resources unavailable to QEMU.  A namespaced QEMU process is restricted to only
+  those resources that were granted to it.
 
-@item Linux seccomp is available via the QEMU @option{--sandbox} option.  It disables
-system calls that are not needed by QEMU, thereby reducing the host kernel
-attack surface.
-@end itemize
+- Linux seccomp is available via the QEMU ``--sandbox`` option.  It disables
+  system calls that are not needed by QEMU, thereby reducing the host kernel
+  attack surface.
 
-@section Sensitive configurations
+Sensitive configurations
+------------------------
 
 There are aspects of QEMU that can have security implications which users &
 management applications must be aware of.
 
-@subsection Monitor console (QMP and HMP)
+Monitor console (QMP and HMP)
+'''''''''''''''''''''''''''''
 
 The monitor console (whether used with QMP or HMP) provides an interface
 to dynamically control many aspects of QEMU's runtime operation. Many of the
 commands exposed will instruct QEMU to access content on the host file system
 and/or trigger spawning of external processes.
 
-For example, the @code{migrate} command allows for the spawning of arbitrary
+For example, the ``migrate`` command allows for the spawning of arbitrary
 processes for the purpose of tunnelling the migration data stream. The
-@code{blockdev-add} command instructs QEMU to open arbitrary files, exposing
+``blockdev-add`` command instructs QEMU to open arbitrary files, exposing
 their content to the guest as a virtual disk.
 
 Unless QEMU is otherwise confined using technologies such as SELinux, AppArmor,
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 33b9597b1dc..c11b1a5d5ad 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -40,7 +40,6 @@
 * QEMU System emulator for non PC targets::
 * QEMU User space emulator::
 * System requirements::
-* Security::
 * Implementation notes::
 * Deprecated features::
 * Recently removed features::
@@ -2836,8 +2835,6 @@ added with Linux 4.5 which is supported by the major distros. And even
 if RHEL7 has kernel 3.10, KVM there has the required functionality there
 to make it close to a 4.5 or newer kernel.
 
-@include docs/security.texi
-
 @include qemu-tech.texi
 
 @include qemu-deprecated.texi
-- 
2.20.1


