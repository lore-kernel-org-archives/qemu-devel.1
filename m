Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B19C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD302075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELjbGuMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD302075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG24-0000b4-Rm
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzs-0003vu-5d
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzq-0007uZ-13
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=kbG6xG5pn9C0ADYNHatpYB+8Z95DeeTLDPLSMxyXI+g=;
 b=ELjbGuMSjY6BIULTTPfQpmR6vs22kdWlAhOqiTMmUTgFvTot2UeGw9htB89KEGEowzAvAB
 nudfa9YLkpYUl81jdM9TdLd+A8U0Zj6XsWWSFq+G6wcuIXlTib68xroxELzEavhwJyYXLh
 t/QSGexjXRqnFelIr5gLkDMxgzGYan8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-mfIZIu_JMzOBW6gDoXfNOA-1; Mon, 07 Sep 2020 08:11:37 -0400
X-MC-Unique: mfIZIu_JMzOBW6gDoXfNOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 502A6640E3;
 Mon,  7 Sep 2020 12:11:36 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5468E5C1BB;
 Mon,  7 Sep 2020 12:11:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/14] tests: Fixes building test-util-filemonitor.c on
 msys2/mingw
Date: Mon,  7 Sep 2020 14:11:17 +0200
Message-Id: <20200907121127.136243-5-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
References: <20200907121127.136243-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
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

From: Yonggang Luo <luoyonggang@gmail.com>

Fixes the following compiling error:
../tests/test-util-filemonitor.c: In function 'test_file_monitor_events':
../tests/test-util-filemonitor.c:620:17: error: too many arguments to function 'mkdir'
  620 |             if (mkdir(pathsrc, 0700) < 0) {
      |                 ^~~~~
In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/unistd.h:10,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:93,
                 from ../tests/test-util-filemonitor.c:21:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/io.h:282:15: note: declared here
  282 |   int __cdecl mkdir (const char *) __MINGW_ATTRIB_DEPRECATED_MSVC2005;
      |               ^~~~~

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20200905203425.1470-1-luoyonggang@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-util-filemonitor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 8f0eff3d03..b629e10857 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -23,6 +23,8 @@
 #include "qapi/error.h"
 #include "qemu/filemonitor.h"
 
+#include <glib/gstdio.h>
+
 #include <utime.h>
 
 enum {
@@ -617,7 +619,7 @@ test_file_monitor_events(void)
             if (debug) {
                 g_printerr("Mkdir %s\n", pathsrc);
             }
-            if (mkdir(pathsrc, 0700) < 0) {
+            if (g_mkdir_with_parents(pathsrc, 0700) < 0) {
                 g_printerr("Unable to mkdir %s: %s",
                            pathsrc, strerror(errno));
                 goto cleanup;
-- 
2.18.2


