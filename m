Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E054C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C592D20684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLaLj8SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C592D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSWz-000157-Vl
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMT-00068H-L3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMQ-00077s-NZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8S3oXxz3JeO9vktC9+EDUO3DZiEVkn457DPI+0QHaY=;
 b=SLaLj8SEVV17P75Ilqazz0UoPgMyoxfPRQqVRjWG3W9cHZVTrcwV92xGFFc9MVw9wXV72g
 GHOdII67wb08UXEVUc3v6y74gSHOHD2z/aRWKblIkDerP9yKJkn99HTae/RUJaI7PpOVDv
 1ihzpGmL7izC9v142T0rnbZzzr8tvHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-fL_5i71HPKq8eGxAWOtKaQ-1; Wed, 02 Sep 2020 08:59:32 -0400
X-MC-Unique: fL_5i71HPKq8eGxAWOtKaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D31E5873073
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9076576E01;
 Wed,  2 Sep 2020 12:59:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/39] meson: fix migration/stress compilation with glibc>=2.30
Date: Wed,  2 Sep 2020 08:59:02 -0400
Message-Id: <20200902125917.26021-25-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

gettid() was introduced with glibc 2.30.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-16-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              | 3 +++
 tests/migration/stress.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 7c714bb49c..b71f561c96 100644
--- a/meson.build
+++ b/meson.build
@@ -413,6 +413,8 @@ endif
 keyutils = dependency('libkeyutils', required: false,
                       method: 'pkg-config', static: enable_static)
 
+has_gettid = cc.has_function('gettid')
+
 # Create config-host.h
 
 config_host_data.set('CONFIG_SDL', sdl.found())
@@ -423,6 +425,7 @@ config_host_data.set('CONFIG_VNC_PNG', png.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
+config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index 05d85051e3..0c72a420be 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -29,10 +29,12 @@ const char *argv0;
 
 #define PAGE_SIZE 4096
 
+#ifndef CONFIG_GETTID
 static int gettid(void)
 {
     return syscall(SYS_gettid);
 }
+#endif
 
 static __attribute__((noreturn)) void exit_failure(void)
 {
-- 
2.26.2



