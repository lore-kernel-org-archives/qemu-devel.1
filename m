Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11497C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA5D20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHJ4RDmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA5D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkxM-0006xv-FJ
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkuD-0001sz-Be
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPku7-0005MN-Af
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGlTQyPHetsqq0zL2iZVU9NGjFB1rfxPXu9fGi39RP8=;
 b=BHJ4RDmMT+zU25dlzg3XAc2AWiyWW5T60ESV38bkag0g1bxkBvI0x2779gGWKPkNA5wXZM
 TehDgxzIUfU41hW3NhmfLzX1q8giHvLqx++Xzksj8Pl2mg+9/iQeceCmFmECPhijdm8IRM
 bMOgSnV5q7LWJY8T2ejS/XneVKRgy4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-LbRAOvYaOrykqiW2mYURQw-1; Tue, 06 Oct 2020 07:13:07 -0400
X-MC-Unique: LbRAOvYaOrykqiW2mYURQw-1
Received: by mail-wr1-f69.google.com with SMTP id t17so1899238wrm.13
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UGlTQyPHetsqq0zL2iZVU9NGjFB1rfxPXu9fGi39RP8=;
 b=D12T6z2VD3+2ofm63WSATo7sqTXCdYlLk+bHEqxSWGaGORLA5+70W1St2mlbzn6CO+
 S5m9HKNbCnWhDN+wNjKf7xjCeo5ozBXmwM33GY17KquLzCqQmY05G1xPN7QZtONwQwDw
 fWbyMxHzcsimsS2CtEApvvdP3ksi15mYRn5aukpbgMaTdo2wCEIpNOb7lSaSHCr2BnzO
 WQm/S2KOCAiwPPPasLiD8UqwO7iL0wG9hUlCMylOOCHnNuXjAQaTVKoRk8x0Ji9hINH0
 soaj3/gzK0d/yJLmCMlIRsKGGAXv/6wKBQP/6h+0x/CNgmRzaQohmO6IPtcMdxFbINVb
 bhvg==
X-Gm-Message-State: AOAM532U02AtD8znJiPOBXGLyl2YmCUVusEggEPVGxX1kHA8kwkp93Xz
 d5VMtXUaSkggERlzjFSV79YTgfg/4kuggoQMlg89DJlwCfsJqN2zjcVU9JD5zW8jCa3X5di/w3V
 XaF5Ar5aEqxVdrcs=
X-Received: by 2002:a5d:6409:: with SMTP id z9mr897087wru.391.1601982786278;
 Tue, 06 Oct 2020 04:13:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxBXJAHlzAcMw3p8z9DJfZ2ANL9j5lqmE9paWPuCrC/DN1XW1f1o7e48W0ybuPeRSt9Ku6zQ==
X-Received: by 2002:a5d:6409:: with SMTP id z9mr897068wru.391.1601982786103;
 Tue, 06 Oct 2020 04:13:06 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f189sm3631986wmf.16.2020.10.06.04.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:13:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] authz: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:18 +0200
Message-Id: <20201006111219.2300921-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006111219.2300921-1-philmd@redhat.com>
References: <20201006111219.2300921-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
index 5ded67cb76..9ecfe93503 100644
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


