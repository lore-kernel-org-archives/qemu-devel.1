Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A1FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8A520760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zk8YOeo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8A520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkxG-0006pY-Fm
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkto-0001js-9J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkti-0005KM-5C
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HCla72Ii7oikn9r1xa5R26+ZMQNPzJ2LVPz4WtA74I=;
 b=Zk8YOeo5bgxTYK/jqetSwbwn2VQTRXngRPUswoZ+qp83NkLvh+R9zCJnI/K6DQhcQDkxrm
 Ske3BM/q4QMmtrOJ/oOdvc011Sv+ryODPoNnB5fwDCKhL6GSmiJaOJyGmlkJTwGxvG8+xd
 BbXjsr3d8ptNYk3AP0XatxJ6sy4ieGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-xq9k0j18OQWFh-bBf7X2bg-1; Tue, 06 Oct 2020 07:12:43 -0400
X-MC-Unique: xq9k0j18OQWFh-bBf7X2bg-1
Received: by mail-wm1-f71.google.com with SMTP id 73so579921wma.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8HCla72Ii7oikn9r1xa5R26+ZMQNPzJ2LVPz4WtA74I=;
 b=EAhyeDv8PF1s9EA9Gp9mafSAAzLRlFlVRxIxVGfZWaP9l/RPCGqMZBnmQ43dKxZQu0
 RTvwp3nSVEPP3NzRZ14Mik0ggpnhEIWLOJzoheaBvgEKyiVFoCdNsp17eBrPp09gK5OH
 EAWzT2h8fAGYlzHXyGbey7zAcyPFf4HQwLr+4W7s66+nlerC72CIlvpsePhn+jTMiJdH
 /qzj+MjuB4VCWPMMJRF09hIIVOz6GrOsvWkdcQzA6Q02vM8rFSVy3Gd8CcycNE1TQctW
 S9NzSSZHLrKCkiINk7L2R4UIbUJN6ehbBQB1WExHY0DL9OV/mZXutss1llTK5VXAgf3r
 22+A==
X-Gm-Message-State: AOAM533bwZrr9hGaI6180zNb3KV7ryrYu/KPGUbFm+6woaVahtB2Skgm
 hBbE1S1fhuYlhCkhsOO31TN57Y4kTaH2SWmUYajlCJVx94CiujM+Rc86nfw48Cv1l+Srg6BfS4d
 zZUFAMH55GTnaUbM=
X-Received: by 2002:a1c:c908:: with SMTP id f8mr2390575wmb.28.1601982761861;
 Tue, 06 Oct 2020 04:12:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlneto9wIwjvwYY63A2wQ5BaGTqaKUG2HUWPejnDShumhTXIWs8vBeDDYbU6Ra3PjrBL1Yhw==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr2390549wmb.28.1601982761662;
 Tue, 06 Oct 2020 04:12:41 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a5sm4026965wrp.37.2020.10.06.04.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:12:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] hw/core: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:13 +0200
Message-Id: <20201006111219.2300921-5-philmd@redhat.com>
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
 meson.build         | 7 +++++++
 hw/core/meson.build | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index fc7792b769..ccfa3e9531 100644
--- a/meson.build
+++ b/meson.build
@@ -1346,6 +1346,13 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
 
 qmp = declare_dependency(link_whole: [libqmp])
 
+libhwcore = static_library('hwcore', sources: hwcore_files + genh,
+                           name_suffix: 'fa',
+                           build_by_default: false)
+hwcore = declare_dependency(link_whole: libhwcore)
+common_ss.add(hwcore)
+
+
 foreach m : block_mods + softmmu_mods
   shared_module(m.name(),
                 name_prefix: '',
diff --git a/hw/core/meson.build b/hw/core/meson.build
index fc91f98075..4a744f3b5e 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -14,12 +14,6 @@ hwcore_files = files(
   'qdev-clock.c',
 )
 
-libhwcore = static_library('hwcore', sources: hwcore_files + genh,
-                           name_suffix: 'fa',
-                           build_by_default: false)
-hwcore = declare_dependency(link_whole: libhwcore)
-common_ss.add(hwcore)
-
 common_ss.add(files('cpu.c'))
 common_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
 common_ss.add(when: 'CONFIG_GENERIC_LOADER', if_true: files('generic-loader.c'))
-- 
2.26.2


