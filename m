Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C8C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9379F206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp8+oFrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9379F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkxD-0006mk-HX
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktw-0001mg-2O
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktu-0005L3-4k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQzKP06SroZyy9Zd+qPK43uTNQ+3Ne7R7h8yWx4kCdE=;
 b=Qp8+oFrHTEE5k/541XnAbxKBzU70gTUFnqyb2tvpQ5Qkij8CjZOhaNHGi0qbYnZQaMWwGb
 QRNhzpiPCwR/Tm0a5zwcjU077jRuvai/bbsVZsliT/cyegIQW+RLQlAqqDZ9l8MvdSMOim
 7CF3nAZywg3W5ajiKJcZNcG5YesMzU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-2G3qUXqpOI2hJtjQGrINeQ-1; Tue, 06 Oct 2020 07:12:53 -0400
X-MC-Unique: 2G3qUXqpOI2hJtjQGrINeQ-1
Received: by mail-wm1-f69.google.com with SMTP id u5so582564wme.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eQzKP06SroZyy9Zd+qPK43uTNQ+3Ne7R7h8yWx4kCdE=;
 b=RGqqnnOu3z5AZFpbHM9wubBbntJ+odoj47WxLad7LGVbjvfqxMbbQ9QXojchDE7SGK
 Q8jeTPQXBHPakAn9bnQGR8guYI8+N1WZSh2a33a/CkwTKkteVudmXZ8sxMFr086AHcnD
 lg10GxxomGR8tSoUXR3agh3zPEsBdK804b76jQFlluwjOqTANuIw00QZSX7FoOQ2yQC+
 c7h9+7tYrDxE5Tbbb/5gkc87kBbJHakFNpS0dU7o0MC/ITLIY78NS/fhFfzE6OnGF107
 10Y+nTEoit/ahjVlzehzlXtLqOasp9tFLSYqchlAHNd0HgZJpyWF4jdEmjLD8uvvlPdB
 fs5w==
X-Gm-Message-State: AOAM530dASiFEdsoL3Iid3FlUL49HzSGkhqvjD6mcuW5H8CVCPILR8CE
 M0C8RMWVzjOgToKrpvKZ9p6aAd60pN0K+xWFb4B/oennpF9v/dF7To5d2xRmz25kyZh5gsRXG93
 RTtEo8A9JlkcCUWo=
X-Received: by 2002:a1c:2ed3:: with SMTP id u202mr4236765wmu.162.1601982771602; 
 Tue, 06 Oct 2020 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj2DgMRyJb7iKsEcsydsn4uQUA4ZjVLyj0eRrIFKgvREU9Da1UifcbcZgtCUfZh8IMuk3ZHQ==
X-Received: by 2002:a1c:2ed3:: with SMTP id u202mr4236739wmu.162.1601982771391; 
 Tue, 06 Oct 2020 04:12:51 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u15sm4069841wrm.77.2020.10.06.04.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:12:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] migration: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:15 +0200
Message-Id: <20201006111219.2300921-7-philmd@redhat.com>
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
 meson.build           | 6 ++++++
 migration/meson.build | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 6bec7a0994..55966c3b60 100644
--- a/meson.build
+++ b/meson.build
@@ -1328,6 +1328,12 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+libmigration = static_library('migration', sources: migration_files + genh,
+                              name_suffix: 'fa',
+                              build_by_default: false)
+migration = declare_dependency(link_with: libmigration,
+                               dependencies: [zlib, qom, io])
+
 block_ss = block_ss.apply(config_host, strict: false)
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
diff --git a/migration/meson.build b/migration/meson.build
index 55c9e1329f..980e37865c 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -8,12 +8,6 @@ migration_files = files(
   'qemu-file.c',
   'qjson.c',
 )
-
-libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
-                              build_by_default: false)
-migration = declare_dependency(link_with: libmigration,
-                               dependencies: [zlib, qom, io])
 softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
-- 
2.26.2


