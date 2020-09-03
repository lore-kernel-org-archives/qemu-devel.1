Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C258C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5D320665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8rUORF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5D320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDi4c-0000dC-38
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDi3f-000063-02
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDi3b-0006fR-2e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599111909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=5To05iZyCKjCChYbkY8p3ROFswdIR4gTrfcFvLIeb7w=;
 b=c8rUORF11lndEkvVL16vHe0UmbqYWHRlP5ERSJ9ss8mKLAe/k1iuIMFM1x0Jii/DJYvBC8
 k91QQddxUafHer+sxghbiP9pMdebYobThrk/PdFRmt2gpy4A47q92m9Zd0SDEQhH3ecTz0
 uZN40Uazxkhv5bsXH3FB88cHM88mgjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-yDVDMx2YPna7bCDDFYAAVg-1; Thu, 03 Sep 2020 01:45:07 -0400
X-MC-Unique: yDVDMx2YPna7bCDDFYAAVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 963BB801AE0
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 05:45:06 +0000 (UTC)
Received: from thuth.com (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74E187E670;
 Thu,  3 Sep 2020 05:45:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] stubs: Move qemu_fd_register stub to util/main-loop.c
Date: Thu,  3 Sep 2020 07:45:03 +0200
Message-Id: <20200903054503.425435-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 23:55:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The linker of MinGW sometimes runs into the following problem:

libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register':
/builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of
 `qemu_fd_register'
libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-register.c:5:
 first defined here
collect2: error: ld returned 1 exit status
/builds/huth/qemu/rules.mak:88: recipe for target 'tests/test-timed-average.exe'
 failed

qemu_fd_register() is defined in util/main-loop.c for WIN32, so let's simply
move the stub also there in the #else part of the corresponding #ifndef
to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 stubs/fd-register.c | 6 ------
 stubs/meson.build   | 1 -
 util/main-loop.c    | 4 ++++
 3 files changed, 4 insertions(+), 7 deletions(-)
 delete mode 100644 stubs/fd-register.c

diff --git a/stubs/fd-register.c b/stubs/fd-register.c
deleted file mode 100644
index 63a4abdb20..0000000000
--- a/stubs/fd-register.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/main-loop.h"
-
-void qemu_fd_register(int fd)
-{
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index e2dfedc2a7..e0b322bc28 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -9,7 +9,6 @@ stub_ss.add(files('cpu-get-clock.c'))
 stub_ss.add(files('cpu-get-icount.c'))
 stub_ss.add(files('dump.c'))
 stub_ss.add(files('error-printf.c'))
-stub_ss.add(files('fd-register.c'))
 stub_ss.add(files('fdset.c'))
 stub_ss.add(files('fw_cfg.c'))
 stub_ss.add(files('gdbstub.c'))
diff --git a/util/main-loop.c b/util/main-loop.c
index f69f055013..217c8d6056 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -179,6 +179,10 @@ static int max_priority;
 static int glib_pollfds_idx;
 static int glib_n_poll_fds;
 
+void qemu_fd_register(int fd)
+{
+}
+
 static void glib_pollfds_fill(int64_t *cur_timeout)
 {
     GMainContext *context = g_main_context_default();
-- 
2.18.2


