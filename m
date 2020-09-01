Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9265AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3A4206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiqUNDty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3A4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2LC-0004se-Aj
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KL-0003D2-7F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KJ-0006p9-Ka
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXWDLARdHNrpA7a6adejzajvHVlFYS/OZTUmP9eu8pQ=;
 b=LiqUNDtyPgQEwniKUIG9q/7OnqffiRTOWTO/UYrJ/N3dT1ruv5gUp+DUDxo5MnJzdLMe0W
 uLWrKjuhXv0yu+4L1lToaiLxo+kBLEDN4TVnC8IwHCdWO4py08QiQW4UJYd+nlNVF7xeT/
 kRzV1FhpOc/CJYDdEYOLHinxmN5QwvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-nyg_surgOamm4qLCrDFrRg-1; Tue, 01 Sep 2020 05:11:35 -0400
X-MC-Unique: nyg_surgOamm4qLCrDFrRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36F2E8015C5;
 Tue,  1 Sep 2020 09:11:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7EF660C04;
 Tue,  1 Sep 2020 09:11:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] meson: fix SDL2_image detection
Date: Tue,  1 Sep 2020 05:11:11 -0400
Message-Id: <20200901091132.29601-4-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

Configure used to probe for SDL2_image in sdl_image_probe (). Meson
should do the same.

This fixes the following error on my system:

Run-time dependency sdl2 found: YES 2.0.8
Found CMake: /usr/bin/cmake (3.17.0)
Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)

../qemu-master/meson.build:256:2: ERROR: Dependency "sdl-image" not
found, tried pkgconfig and cmake

A full log can be found at /home/ruemelin/rpmbuild/BUILD
/qemu-5.1.50-build/meson-logs/meson-log.txt

ERROR: meson setup failed

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20200829104158.7461-1-vr_qemu@t-online.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1e7aee85e3..3c919e32f1 100644
--- a/meson.build
+++ b/meson.build
@@ -248,7 +248,7 @@ if sdl.found()
   # work around 2.0.8 bug
   sdl = declare_dependency(compile_args: '-Wno-undef',
                            dependencies: sdl)
-  sdl_image = dependency('sdl-image', required: get_option('sdl_image'),
+  sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
                          static: enable_static)
 else
   if get_option('sdl_image').enabled()
-- 
2.26.2



