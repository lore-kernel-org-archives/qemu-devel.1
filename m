Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C70C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AC12080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDxCLWQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AC12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl1x-0003rB-Fn
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkuI-0001zF-7i
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkuD-0005Mk-Nq
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHE0euJosau7rC4y0W3F/SPC4SETHEhDg1f1N9tjW8w=;
 b=MDxCLWQhbXknEy+8YIkkEY69XsCjQdhK0RZInB2dHVTb8e490k2xpA78LwWFPoc9CfYCfT
 KuqrmQ2hvjedidQ22bcPNCeKzbvvIo2VuJiceai0yWL+VPorhpbtmN62uOyEp0VvHIHJr8
 kYo2/d467pGzNvjrDkHDSca3HVQ8svc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-Xsu15Ee6PN-3Xz9TBSPs_A-1; Tue, 06 Oct 2020 07:13:12 -0400
X-MC-Unique: Xsu15Ee6PN-3Xz9TBSPs_A-1
Received: by mail-wm1-f70.google.com with SMTP id r19so977560wmh.9
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zHE0euJosau7rC4y0W3F/SPC4SETHEhDg1f1N9tjW8w=;
 b=Bd/j1XGX9Bq+oouN5xHivuCHp62KUZ544hZBbEnaP/g5w8JOzlz54UKxGPNdVYxqzK
 Lg11sGTrNkaOC5v4O1NCcxPeUf6E01jbKZx1KaJVNQqUug0rR6GFVz9JN2Cee45gJn4M
 U0rjhOBwZJL/p6c81IXZr3qonmJq/848V1xKume8GfHygPgvFLgSE/k11SmhrL86Luio
 lFP2j0JXwMAv/5ZtCcqlvmkqWnGrAEz6iTL/nC3DYZKmcjuhBSxVEmlxtt8QlShqVLVl
 OKIqyD0m0IKRPupfGEdiJ36ZRRhKktngekwA0UOfOxqzpKF85qOAB2XGwZaaZH4TFYoO
 24SQ==
X-Gm-Message-State: AOAM532A47gVBnzf8lTCsWz8PMCy47UD7EdgIvmOj4xuzxWUI5NCXcHP
 kzBZ/yjDR31QA7rBMgkKIRgClVMQeZPH1MT7eDNt3IdbNO0ojKTM2SqHxQGtWoWGqKtMAgt1TUN
 MsS/bHq8oJpUSjyg=
X-Received: by 2002:adf:e802:: with SMTP id o2mr4220702wrm.309.1601982791378; 
 Tue, 06 Oct 2020 04:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6jWQHDML3fi5h/wIrbokDwSQgimm0127XS5oL31MDFZKP4gAxEKEhWCq7bQ+POWPZDfQQHg==
X-Received: by 2002:adf:e802:: with SMTP id o2mr4220689wrm.309.1601982791175; 
 Tue, 06 Oct 2020 04:13:11 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j134sm3800716wmj.7.2020.10.06.04.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:13:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] qom: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:19 +0200
Message-Id: <20201006111219.2300921-11-philmd@redhat.com>
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
 meson.build     | 8 ++++++++
 qom/meson.build | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 9ecfe93503..29e397f285 100644
--- a/meson.build
+++ b/meson.build
@@ -1069,6 +1069,7 @@ crypto_ss = ss.source_set()
 io_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
+qom_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
@@ -1331,6 +1332,13 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+qom_ss = qom_ss.apply(config_host, strict: false)
+libqom = static_library('qom', qom_ss.sources() + genh,
+                        dependencies: [qom_ss.dependencies()],
+                        name_suffix: 'fa')
+
+qom = declare_dependency(link_whole: libqom)
+
 authz_ss = authz_ss.apply(config_host, strict: false)
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
diff --git a/qom/meson.build b/qom/meson.build
index a1cd03c82c..062a3789d8 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -1,4 +1,3 @@
-qom_ss = ss.source_set()
 qom_ss.add(genh)
 qom_ss.add(files(
   'container.c',
@@ -9,10 +8,3 @@ qom_ss.add(files(
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
 softmmu_ss.add(files('qom-hmp-cmds.c'))
-
-qom_ss = qom_ss.apply(config_host, strict: false)
-libqom = static_library('qom', qom_ss.sources() + genh,
-                        dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa')
-
-qom = declare_dependency(link_whole: libqom)
-- 
2.26.2


