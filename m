Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B442320760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLW/e10+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B442320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmh1-0006Sr-Fn
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmWE-0003JC-7n
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmWC-0001uf-2c
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+civm+lmzYKDJ7YA3YOOXf6dQ0UsRfqcLEm+1Urmtw8=;
 b=OLW/e10+fSJ/45baSf2sFapzm+2/oVzBhJKpblczy1NBm0f8d9oh1KRiDKpKxQiS2Vkt1k
 m9zomJXj+mrcky2UI8CEw8MGPTvcX9ME9yPVf8VX/7gkVpbBZ/FsFgf2iOKf0cFAZ54pNc
 2rkafATuT16gjSqFgmc5MU+VudlqwH4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-dftFtcGbMzWDQzC_sCY6QQ-1; Tue, 06 Oct 2020 08:56:32 -0400
X-MC-Unique: dftFtcGbMzWDQzC_sCY6QQ-1
Received: by mail-wr1-f72.google.com with SMTP id i10so5301869wrq.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+civm+lmzYKDJ7YA3YOOXf6dQ0UsRfqcLEm+1Urmtw8=;
 b=nZJgdZArbFabqeXrXHCkT1FMwz9E+3Uw8L4dv1NF1WyVvTBveeXgC/mvqh9ZB6B2BO
 +iMl2ZkQ4LV9WqnrIOT5EHYejrA4WbHVEP733WiMCTmIwJV6H9+8M8NYgeyNsemlnndv
 0zYRTYK+seG+s2dV8WOrtrA2pHZhgl3y/0z26Tt1ayFYjoVrYTjNj9nDYWySvaMR9TK9
 OlBUNAYcurXxX3F9SG8LX24K+LsOpY6yBQasqYOCYnjnDogHk2Z+xylPdfrMdPziK2SU
 NWoQVwQ+EZ59YZa7DxV2x7Fk7yF5b1eDE2tjv+XNcSsFO9mYs7cAhHQWMjybkXZi/Je8
 V9Mw==
X-Gm-Message-State: AOAM532NKyeDIFR3rVFLydejsMl4+hdmWZzqAlBYlnC39kUc11XC+fF0
 7N6O28Fa7XWl6deX4+z5c1279IqV0xqCGmzN18yEnmpuOQOr8wJqOZRSwsrHE12qHvktTf8Glbz
 vzTT8Sks9ELpbOtI=
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr4621346wmm.14.1601988990456; 
 Tue, 06 Oct 2020 05:56:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBBR0nks+OH7sHMF017w1FYq4pUfMy/bUhEy3McUfY03FAVeOwyySBY/4nz4VfzW+Btxe7zA==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr4621334wmm.14.1601988990293; 
 Tue, 06 Oct 2020 05:56:30 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b11sm4322492wrt.38.2020.10.06.05.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] migration: Move the creation of the library to the
 main meson.build
Date: Tue,  6 Oct 2020 14:55:58 +0200
Message-Id: <20201006125602.2311423-6-philmd@redhat.com>
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
 meson.build           | 7 +++++++
 migration/meson.build | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 3c0d7b4d44..0e3598e267 100644
--- a/meson.build
+++ b/meson.build
@@ -1328,6 +1328,13 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+libmigration = static_library('migration', sources: migration_files + genh,
+                              name_suffix: 'fa',
+                              build_by_default: false)
+migration = declare_dependency(link_with: libmigration,
+                               dependencies: [zlib, qom, io])
+softmmu_ss.add(migration)
+
 block_ss = block_ss.apply(config_host, strict: false)
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
diff --git a/migration/meson.build b/migration/meson.build
index b5b71c8060..980e37865c 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -8,13 +8,7 @@ migration_files = files(
   'qemu-file.c',
   'qjson.c',
 )
-
-libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
-                              build_by_default: false)
-migration = declare_dependency(link_with: libmigration,
-                               dependencies: [zlib, qom, io])
-softmmu_ss.add(migration)
+softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
   'block-dirty-bitmap.c',
-- 
2.26.2


