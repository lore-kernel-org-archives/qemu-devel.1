Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2D4C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A6620684
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdq/Z3Vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A6620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hl9-0000s7-5P
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hh5-0000yH-TR
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hh4-0004yW-J3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hh4-0004xs-D2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so3381199wrx.11
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DcfqCgUZHlnjMNnIpq2LHXlCmbSL3XxrstwKCbLM91U=;
 b=cdq/Z3VomzrEkBE3oStCtbx5LYQPMFEAv22KR1QN5EmOJ3+UvTWyW7umCu4a6OhNHv
 /iu8IKcG4wur5DjmPx35VvFMLkdnm+D/P1Tegak/tqhIkpyov8KoBeRLCSnXqpzRK6EQ
 BEEWMJt/4ZyqNkAcKwTKkwBvpNzPZELXe1ylm8BMi3l8IOr77RhwpPPi+kvyJ5d2/B/C
 FRkqsA1KU3O/o4f7hEntsW4hBo+sjhXn6KtziuNL/xsu/RCZLYOp3Fea1+/qtkrWacTV
 I3upPuCdSDvHIc9irpNAIjkoqwNwf2mTdy6N/4ldDCQHHX2bq+27sPqHamZlDdyGfEmO
 kn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DcfqCgUZHlnjMNnIpq2LHXlCmbSL3XxrstwKCbLM91U=;
 b=HlOlgd+1T7B5Qic6zo7YW2nUrWBzIMQmoCO+ervz4zfNZrUkraP3734Pw4O6q47TYY
 I+nW33KsjhNPd1sBjksukPEsyqdo1FqSFrbb15V2lci/0o7MA8B/xSgNpO6+jtS3R/Cm
 pCNfyoiTKLPE61rwExDWARo8BzpXOmis+g5gm+AOQePiIwi4qpw4t56AGJR4RkQsOnoS
 TTOYPeGL+19dN5aWRpZ947jasUOMhVaYGFew6aCzcnXG8K10jnskfrSmGjWuJ/Dvh83j
 KdNvSIKx1ej2T2Hke0XWfYqBJcjdXKSP23MMmteHDmtYQWXLtMNRVN1Lgfjtmkeo5i4g
 P8Tw==
X-Gm-Message-State: APjAAAVeVYINiJF9gelc4f9z4y5JXUBnRzrrxHpSHp76h1LE9BcftmrY
 xwNn4wa7aB04UNYZSrq169PGqo4fqi1wFA==
X-Google-Smtp-Source: APXvYqwAFYmBgQvHzgLCbAH76ZKSXKeUleXYKCDMZKKzrTwNFvN3fnr5sUg057zmwjkMDHzDmG8TBA==
X-Received: by 2002:a05:6000:1147:: with SMTP id
 d7mr5484850wrx.142.1582904208950; 
 Fri, 28 Feb 2020 07:36:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/33] docs/system: convert managed startup to rST.
Date: Fri, 28 Feb 2020 15:36:03 +0000
Message-Id: <20200228153619.9906-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Fix one typo in the process and format more option and
command names as literal text, but make no significant
changes to the content.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200226113034.6741-17-pbonzini@redhat.com
---
 docs/system/index.rst           |  2 +-
 docs/system/managed-startup.rst | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/managed-startup.rst

diff --git a/docs/system/index.rst b/docs/system/index.rst
index 5034f903407..d655344fffd 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -13,6 +13,6 @@ Contents:
 
 .. toctree::
    :maxdepth: 2
-
+   managed-startup
    security
    vfio-ap
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
-- 
2.20.1


