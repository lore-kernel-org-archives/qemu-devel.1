Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB443C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9A42082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORhFPc79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9A42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cMy-0007c0-KD
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cKy-0003Hy-Hm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6cKv-0000xg-WC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6cKv-0000x5-PM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:41:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so3627351wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1FKjE5sNT4q2ywmJDIndXZQ5U1oyDqrNzleV/UagBxk=;
 b=ORhFPc790Qw3mdfKxucjlwr81Rzin/Mv0DIpW7/anPyGO+ug8BIb17MY3iCdUa/56O
 SivZgc8MUvAyEsTHuoGeueu1qXIzJ6lkWj/lm9dL6TnEERLsDV7y0wK22dZAwgYv8LYL
 /7ByIAivlGYtPo8PmLsz3qHn883T53EUgUUC4z/B4AZpmeIxMaVMDtJwqDda6iBYJ1NC
 /zu00RWA4Madjmjn8TZcl4p99+lbvz3BAC51Y9JZTc0UiXinTq26qfnxnPrzjFu3rlX8
 4GyhieHluGa0LIyWyAZVtU07OTAsrN0QsC5YLgwLM2LTQEsMHRWdEg5MSgrSo8IhlDly
 gfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1FKjE5sNT4q2ywmJDIndXZQ5U1oyDqrNzleV/UagBxk=;
 b=Y0KNoTNTVF/iS+5rxjOtJ30I3P8Y/kY2hl8zvimi/ArsEJmi6eomuTRL4QsswIaXp5
 hkCoxaZA5B6xq4HrLz++UejiiooH6377/aezUAlS+ZlnoxdE7adJxU58XREK2HhGgd30
 nmgYCAKmkgFt/bO8pFUPS8zH/OixDR+35raKhnArWOyNfH2MuLZmhVfX1c6jVEqXAa+y
 O2SlsJgOrCUvPfeK4R3xi7r1SK1+kxsGLpExmY/VdvVRdD0YbTKOoSZpSmFgb0ntc5uI
 DsxgY/VlsvVNU5Ptp6kxYPnttfeI63zzTWk8Pl9Mk5yEszPxPcDBI697l2LmEyOH5rGG
 KV/Q==
X-Gm-Message-State: APjAAAX2+MyQhJWjS+tB4IlFp2B3GcuuChbpfTs5GL4fuEy/BfhZRfh/
 qLkhm8q0dAr8Mbiq/68v1NqhDfNCEiIEKA==
X-Google-Smtp-Source: APXvYqzopQSytfqZ04vAIWxRIzeDZP1kCEtbT7vfb8q+0AUnYeNL49hCJjYjdAiqKkI5tCVZH2Qa6w==
X-Received: by 2002:a7b:c779:: with SMTP id x25mr5935534wmk.77.1582645288350; 
 Tue, 25 Feb 2020 07:41:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm24438604wrq.44.2020.02.25.07.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:41:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] docs: Convert 'managed start up options' docs to rST
Date: Tue, 25 Feb 2020 15:41:20 +0000
Message-Id: <20200225154121.21116-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225154121.21116-1-peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The only remaining content in qemu-tech.texi is a few paragraphs
about managed start up options; move them to a new rST document
in the system manual.

In the process we fix one typo and format more option and
command names as literal text, but make no significant
changes to the content.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                        |  2 +-
 docs/system/index.rst           |  1 +
 docs/system/managed-startup.rst | 35 +++++++++++++++++++++++++++
 qemu-doc.texi                   |  3 ---
 qemu-tech.texi                  | 42 ---------------------------------
 5 files changed, 37 insertions(+), 46 deletions(-)
 create mode 100644 docs/system/managed-startup.rst
 delete mode 100644 qemu-tech.texi

diff --git a/Makefile b/Makefile
index 5f0f803b471..28749d20401 100644
--- a/Makefile
+++ b/Makefile
@@ -1114,7 +1114,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
-	qemu-tech.texi qemu-option-trace.texi \
+	qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi \
 	qemu-monitor-info.texi \
 	docs/qemu-cpu-models.texi
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 794e5d8de03..887bef92f40 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -14,5 +14,6 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   managed-startup
    qemu-block-drivers
    security
diff --git a/docs/system/managed-startup.rst b/docs/system/managed-startup.rst
new file mode 100644
index 00000000000..9bcf98ea790
--- /dev/null
+++ b/docs/system/managed-startup.rst
@@ -0,0 +1,35 @@
+Managed start up options
+========================
+
+In system mode emulation, it's possible to create a VM in a paused
+state using the ``-S`` command line option. In this state the machine
+is completely initialized according to command line options and ready
+to execute VM code but VCPU threads are not executing any code. The VM
+state in this paused state depends on the way QEMU was started. It
+could be in:
+
+- initial state (after reset/power on state)
+- with direct kernel loading, the initial state could be amended to execute
+  code loaded by QEMU in the VM's RAM and with incoming migration
+- with incoming migration, initial state will be amended with the migrated
+  machine state after migration completes
+
+This paused state is typically used by users to query machine state and/or
+additionally configure the machine (by hotplugging devices) in runtime before
+allowing VM code to run.
+
+However, at the ``-S`` pause point, it's impossible to configure options
+that affect initial VM creation (like: ``-smp``/``-m``/``-numa`` ...) or
+cold plug devices. The experimental ``--preconfig`` command line option
+allows pausing QEMU before the initial VM creation, in a "preconfig" state,
+where additional queries and configuration can be performed via QMP
+before moving on to the resulting configuration startup. In the
+preconfig state, QEMU only allows a limited set of commands over the
+QMP monitor, where the commands do not depend on an initialized
+machine, including but not limited to:
+
+- ``qmp_capabilities``
+- ``query-qmp-schema``
+- ``query-commands``
+- ``query-status``
+- ``x-exit-preconfig``
diff --git a/qemu-doc.texi b/qemu-doc.texi
index c11b1a5d5ad..7798e072a1c 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -40,7 +40,6 @@
 * QEMU System emulator for non PC targets::
 * QEMU User space emulator::
 * System requirements::
-* Implementation notes::
 * Deprecated features::
 * Recently removed features::
 * Supported build platforms::
@@ -2835,8 +2834,6 @@ added with Linux 4.5 which is supported by the major distros. And even
 if RHEL7 has kernel 3.10, KVM there has the required functionality there
 to make it close to a 4.5 or newer kernel.
 
-@include qemu-tech.texi
-
 @include qemu-deprecated.texi
 
 @node Supported build platforms
diff --git a/qemu-tech.texi b/qemu-tech.texi
deleted file mode 100644
index 35da6a40af1..00000000000
--- a/qemu-tech.texi
+++ /dev/null
@@ -1,42 +0,0 @@
-@node Implementation notes
-@appendix Implementation notes
-
-@menu
-* Managed start up options::
-@end menu
-
-@node Managed start up options
-@section Managed start up options
-
-In system mode emulation, it's possible to create a VM in a paused state using
-the -S command line option. In this state the machine is completely initialized
-according to command line options and ready to execute VM code but VCPU threads
-are not executing any code. The VM state in this paused state depends on the way
-QEMU was started. It could be in:
-@table @asis
-@item initial state (after reset/power on state)
-@item with direct kernel loading, the initial state could be amended to execute
-code loaded by QEMU in the VM's RAM and with incoming migration
-@item with incoming migration, initial state will by amended with the migrated
-machine state after migration completes.
-@end table
-
-This paused state is typically used by users to query machine state and/or
-additionally configure the machine (by hotplugging devices) in runtime before
-allowing VM code to run.
-
-However, at the -S pause point, it's impossible to configure options that affect
-initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. The
-experimental --preconfig command line option  allows pausing QEMU
-before the initial VM creation, in a ``preconfig'' state, where additional
-queries and configuration can be performed via QMP before moving on to
-the resulting configuration startup. In the preconfig state, QEMU only allows
-a limited set of commands over the QMP monitor, where the commands do not
-depend on an initialized machine, including but not limited to:
-@table @asis
-@item qmp_capabilities
-@item query-qmp-schema
-@item query-commands
-@item query-status
-@item x-exit-preconfig
-@end table
-- 
2.20.1


