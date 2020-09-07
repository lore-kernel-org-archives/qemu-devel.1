Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890CAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBFE20732
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbhB4jg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBFE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG3l-0003D8-CP
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzw-00048M-Iz
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzu-0007wO-Nc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0mdgO4ptw3LGbOSK/aFgpqjv7blp43YXgnObnFOKAs=;
 b=BbhB4jg8LwZ41eKPS7HxP7XihPUYmKCVPphkQp7nykd3ApVYJPlvS9u9GMYdXI1uBi0jFS
 OnDjF1Wq9+k+iO0hJRlGY1zNurYV2MSW2Gg3c20sc+7WSCjE9agMIDFwW2F9PhBxj7LggJ
 iw9d2VqZk/ltdzBpQtXLIB8gvEZlq7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-YlaE_bEBNA2q5shE6_-4kw-1; Mon, 07 Sep 2020 08:11:43 -0400
X-MC-Unique: YlaE_bEBNA2q5shE6_-4kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E2491084D69;
 Mon,  7 Sep 2020 12:11:42 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B2D5C1BB;
 Mon,  7 Sep 2020 12:11:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/14] stubs: Move qemu_timer_notify_cb() and remove
 qemu_notify_event() stub
Date: Mon,  7 Sep 2020 14:11:21 +0200
Message-Id: <20200907121127.136243-9-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
References: <20200907121127.136243-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When cross-compiling with MinGW, there are sometimes some weird linker
errors like:

ibqemuutil.a(util_main-loop.c.obj): In function `qemu_notify_event':
/builds/huth/qemu/build/../util/main-loop.c:139: multiple definition of
 `qemu_notify_event'
libqemuutil.a(stubs_notify-event.c.obj):/builds/huth/qemu/stubs/notify-event.c:5:
 first defined here
collect2: error: ld returned 1 exit status
/builds/huth/qemu/rules.mak:88: recipe for target 'tests/test-timed-average.exe'
 failed

It seems like it works better when the qemu_timer_notify_cb() stub (which
calls qemu_notify_event()) is in a separate file - then we can also even
remove the qemu_notify_event() stub now.

This patch is based on ideas from the patch "stubs: Remove qemu_notify_event()"
by Philippe Mathieu-Daudé and the patch "cpu-timers, icount: new modules" from
Claudio Fontana.

Message-Id: <20200902102433.304737-1-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 stubs/cpu-get-icount.c       | 5 -----
 stubs/meson.build            | 2 +-
 stubs/notify-event.c         | 6 ------
 stubs/qemu-timer-notify-cb.c | 8 ++++++++
 4 files changed, 9 insertions(+), 12 deletions(-)
 delete mode 100644 stubs/notify-event.c
 create mode 100644 stubs/qemu-timer-notify-cb.c

diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
index b35f844638..4001613240 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -14,8 +14,3 @@ int64_t cpu_get_icount_raw(void)
 {
     abort();
 }
-
-void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
-{
-    qemu_notify_event();
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 019bd79c7a..e2dfedc2a7 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -24,9 +24,9 @@ stub_ss.add(files('machine-init-done.c'))
 stub_ss.add(files('migr-blocker.c'))
 stub_ss.add(files('monitor.c'))
 stub_ss.add(files('monitor-core.c'))
-stub_ss.add(files('notify-event.c'))
 stub_ss.add(files('pci-bus.c'))
 stub_ss.add(files('pci-host-piix.c'))
+stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('qmp_memory_device.c'))
 stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
diff --git a/stubs/notify-event.c b/stubs/notify-event.c
deleted file mode 100644
index 827bb52d1a..0000000000
--- a/stubs/notify-event.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/main-loop.h"
-
-void qemu_notify_event(void)
-{
-}
diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb.c
new file mode 100644
index 0000000000..054b408b1c
--- /dev/null
+++ b/stubs/qemu-timer-notify-cb.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "sysemu/cpus.h"
+#include "qemu/main-loop.h"
+
+void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
+{
+    qemu_notify_event();
+}
-- 
2.18.2


