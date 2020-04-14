Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E6C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BDD2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mt0D0Uyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BDD2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKt8-0007bv-KM
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOKsS-0006lx-0O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOKsQ-0006Sa-LW
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:41:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOKsQ-0006Ry-6q
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:41:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id t14so912429wrw.12
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dU0EsMviPUKy6g+Thgb+evd2D4TN7/38hwuUXpm0vT4=;
 b=Mt0D0UygYbI/n8CKcbv5cq8wYubpUcOjNHouwfjoFyGoZRM2+60F5QIXSAYsOmvOJw
 PmJn7zHrOdIVyO9RAsPV/7NgJFKq2rlFbM5/6URM4VHF1T/f9FDGefLj4ttP6fCJ8uGa
 yDilISgLhAnGNADrglWvrI2PSkPSNG40e/Yv2GZu7yO4D4/8+5sIO7kwU+IQWKNB3D3y
 n7LbeIe+HI7JaXeRXSMH0CnP+nHk4OAN2W6T732SmTO7LNtdXbdcRcWf5ncRbHB3XZOH
 ecgW65/kVrL1yBae8m2LtecZtw4vqUoFhCXOWnmCrb7XYegtFXPC5YUCqYP1RWEW6+Qf
 i1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dU0EsMviPUKy6g+Thgb+evd2D4TN7/38hwuUXpm0vT4=;
 b=iuisJuDfCmhKI4ECcM4cZUMD/3nHc3Ao8ioL3wcNNudRq8c3Cbhqn0hDPbbeIuu9KP
 nrsWM/TF/wEEwk5x4mjO4a8X+/gc1CO6KIrUcpF5DWFAWsZrB91R7YppweOGS75GDnM/
 iT/6IHKhgVgCscl2dHnhionBUCuwVsYjeES/i1MIkdgd9bWqLB3IWWOZZy9ivqpriZAy
 1+Rh0bbAaTELU4s6uKrA6Y6xqJP2BA4aTuBh+ZGzAzhOhPb3dXbHscdvYvdi0t87+d+S
 WcMdqL9BORXtdNk5NQfjLQe58Cf0G/JU3mbyFBwWCmI3L5yJFF4TpMC3nUmcpxtgd7qw
 CrnQ==
X-Gm-Message-State: AGi0PuYjC85EUo0xKDyscatRdbPUxhCQnjy4qY75m0QtAJoknPjEDq3+
 d8BRbLbJnvCy5jq7OobYr8PliQJPxafjlA==
X-Google-Smtp-Source: APiQypKOR1UtLMez70S004pgZPOPh/eBneo/36ZZ0HJ6Jlx8Pn1Px2iw5GYJgfAeLlsJw0mcsyK3rA==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr24116689wrs.339.1586868076585; 
 Tue, 14 Apr 2020 05:41:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a80sm18647791wme.37.2020.04.14.05.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 05:41:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [for-5.0] docs: Require Sphinx 1.6 or better
Date: Tue, 14 Apr 2020 13:41:14 +0100
Message-Id: <20200414124114.5363-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Versions of Sphinx older than 1.6 can't build all of our documentation,
because they are too picky about the syntax of the argument to the
option:: directive; see Sphinx bugs #646, #3366:

  https://github.com/sphinx-doc/sphinx/issues/646
  https://github.com/sphinx-doc/sphinx/issues/3366

Trying to build with a 1.4.x Sphinx fails with
 docs/system/images.rst:4: SEVERE: Duplicate ID: "cmdoption-qcow2-arg-encrypt"
and a 1.5.x Sphinx fails with
 docs/system/invocation.rst:544: WARNING: Malformed option description '[enable=]PATTERN', should look like "opt", "-opt
args", "--opt args", "/opt args" or "+opt args"

Update our needs_sphinx setting to indicate that we require at least
1.6.  This will allow configure to fall back to "don't build the
docs" rather than causing the build to fail entirely, which is
probably what most users building on a host old enough to have such
an old Sphinx would want; if they do want the docs then they'll have
a useful indication of what they need to do (upgrade Sphinx!) rather
than a confusing error message.

In theory our distro support policy would suggest that we should
support building on the Sphinx shipped in those distros, but:
 * EPEL7 has Sphinx 1.2.3 (which we've never supported!)
 * Debian Stretch has Sphinx 1.4.8

Trying to get our docs to work with Sphinx 1.4 is not tractable
for the 5.0 release and I'm not sure it's worthwhile effort anyway;
at least with this change the build as a whole now succeeds.

Thanks to John Snow for doing the investigation and testing to
confirm what Sphinx versions fail in what ways and what distros
shipped what.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 7768611e89c..d6e173ef77b 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -59,8 +59,10 @@ sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
 
 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# 1.3 is where the 'alabaster' theme was shipped with Sphinx.
-needs_sphinx = '1.3'
+# Sphinx 1.5 and earlier can't build our docs because they are too
+# picky about the syntax of the argument to the option:: directive
+# (see Sphinx bugs #646, #3366).
+needs_sphinx = '1.6'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
-- 
2.20.1


