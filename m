Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF6C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791012075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VObRGxsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791012075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmdi-00036W-9q
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmWT-0003gB-6S
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmWQ-0001xn-86
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601989009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbwAwPx3ANbvemm3sKJq8R8pcWj7ZDfAwWyPc+pq4Mw=;
 b=VObRGxsmjDIcGnx1JRo0d2jgf+eK403X6EqXOsZWip7CK+wFTh8W1Fguxq9A/fSUVyFJE3
 dOwyl+7Eg7PxmfnRbxJoYVH1cYXPWulkWQRjXNpWaj6RkmPVuIjzsSepNF6wPU0AwymW++
 IkH4dsD7Tf7YeW6yJU/NBQN8mDKF08Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-hvVKA6eoMZyAgApUsAiR_A-1; Tue, 06 Oct 2020 08:56:46 -0400
X-MC-Unique: hvVKA6eoMZyAgApUsAiR_A-1
Received: by mail-wm1-f70.google.com with SMTP id p17so660612wmi.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZbwAwPx3ANbvemm3sKJq8R8pcWj7ZDfAwWyPc+pq4Mw=;
 b=kzBjg85XvYTuenAkUFx9y2vUyxoXHL3PbHQK0NsnQtMe742xBsBOq7mRgygoSKfAu2
 ZtBZDK84omCSQAmMfXQ1cAhRGD2O2bcFJko18MJ7dG5tWc7+v9DHK/XzfFl9BNx1rVJJ
 QbZtw90pIKhSilJoDQW9MD2lfvJM5v7hXlDNRZBNqCx+iQ9R2/nfbQJmiTDRvdGS86QR
 Rq6HSSrZg37pKIxrYvhcndxwu1p96fbHBNbhG752RW4FR7jO7uQRyIFXIQiEuQmt/Fyl
 qeTyp+ALePq1D2IqQxA52YyTWMHhziuE9OVMsdRnr47ky7Xyl6orBb8BODGKZcjMmN2x
 nYrw==
X-Gm-Message-State: AOAM533hPxtcgR4CBzXHLCstq94/fwY8sHLZ3LggjXCID+bjvlbmsLiJ
 IrXR4eacdxAWCYrE26Nb94oP1ZhA6KvjDO34Kngx5e8uoi5HUBjX7eRumh575NvNPEC3yOoKTbm
 Q3zCFsYyXCDFNbG4=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr4590424wmh.78.1601989005459;
 Tue, 06 Oct 2020 05:56:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2atI0g0njW4x5KCvdzBpMWVn388OIIV8mTdOt8DT92+Kcm9+fdZCGGE1BfDRf3vPJEHbH9A==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr4590408wmh.78.1601989005296;
 Tue, 06 Oct 2020 05:56:45 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u5sm5299722wru.63.2020.10.06.05.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] authz: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 14:56:01 +0200
Message-Id: <20201006125602.2311423-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006125602.2311423-1-philmd@redhat.com>
References: <20201006125602.2311423-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Be consistent creating all the libraries in the main meson.build file.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build       | 10 ++++++++++
 authz/meson.build | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index d064d07dae..73838d1d4f 100644
--- a/meson.build
+++ b/meson.build
@@ -1059,6 +1059,7 @@ sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
 
 # Collect sourcesets.
 
+authz_ss = ss.source_set()
 blockdev_ss = ss.source_set()
 block_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
@@ -1330,6 +1331,15 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+authz_ss = authz_ss.apply(config_host, strict: false)
+libauthz = static_library('authz', authz_ss.sources() + genh,
+                          dependencies: [authz_ss.dependencies()],
+                          name_suffix: 'fa',
+                          build_by_default: false)
+
+authz = declare_dependency(link_whole: libauthz,
+                           dependencies: qom)
+
 crypto_ss = crypto_ss.apply(config_host, strict: false)
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
diff --git a/authz/meson.build b/authz/meson.build
index 516d71f2e2..88fa7769cb 100644
--- a/authz/meson.build
+++ b/authz/meson.build
@@ -1,4 +1,3 @@
-authz_ss = ss.source_set()
 authz_ss.add(genh)
 authz_ss.add(files(
   'base.c',
@@ -8,12 +7,3 @@ authz_ss.add(files(
 ))
 
 authz_ss.add(when: ['CONFIG_AUTH_PAM', pam], if_true: files('pamacct.c'))
-
-authz_ss = authz_ss.apply(config_host, strict: false)
-libauthz = static_library('authz', authz_ss.sources() + genh,
-                          dependencies: [authz_ss.dependencies()],
-                          name_suffix: 'fa',
-                          build_by_default: false)
-
-authz = declare_dependency(link_whole: libauthz,
-                           dependencies: qom)
-- 
2.26.2


