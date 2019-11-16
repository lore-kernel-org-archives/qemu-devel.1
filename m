Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B12C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 01:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAB72073B
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 01:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAB72073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVn8U-0000tt-Kt
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 20:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iVmYp-0002rj-5T
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iVmYo-0008VV-5e
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:07:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iVmYn-0008VG-W0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:07:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id r18so6724619pgu.13
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=K8kPOaurPWZpN2JVSPx85EWe4YwjuhSewOUfTS82t98=;
 b=OQDrsCpZR+d0q6LcUm2es3HVu3lhjBm3KpJUzHN7XFRkAUHEsRqB5vLG9B+I9j9m/0
 6c8T0hbk743pGa5GCto4i6QJxoAwtYReJ7JsEimQkSq6xCavLNPzp8JhoiFArYjZLcKU
 lQGjN/k9r1kX/ZD7FWdvXSTr2E/b3pBg8VjqtN9PhPoDZhQQkgyLovktGEPdLWQW6LQz
 ZVFxU0aWptW9jQZC7WbEQTiQRFhG8yfAiiqhhtHlusoCvql1wmZE5WwU/d6jwfCDp+pe
 YOD5JaJQ6lnSwRmWF21t0xPUFb+/yDzAK+gGF0OJY0p2KPyyBdsbeesq4eO9quY1idLS
 15lQ==
X-Gm-Message-State: APjAAAVbKC1XgI7kPbjnFBx1hlcX0CWqNV1IqBKGbkK///3iXyZQZdt4
 w9OYskGh1ld7MOC90go3vaAjfSOpUSg=
X-Google-Smtp-Source: APXvYqxpUvTK/rnZ8bf6O6B8a7kXDi9M80zJoILGcM44vF0zFPMD6kA6ihtHPFvCL8tV28wBTrB9ng==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr210846pgs.431.1573866452385;
 Fri, 15 Nov 2019 17:07:32 -0800 (PST)
Received: from localhost ([2620:15c:2d1:100:7901:ead3:b8cd:1c59])
 by smtp.gmail.com with ESMTPSA id y22sm11667202pfn.6.2019.11.15.17.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 17:07:31 -0800 (PST)
Date: Fri, 15 Nov 2019 17:07:31 -0800
From: Fangrui Song <i@maskray.me>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
Message-ID: <20191116010731.3jdxozzfpsqsrcc4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180223-112-0c5bf3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
X-Mailman-Approved-At: Fri, 15 Nov 2019 20:43:48 -0500
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
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The warning will be enabled by default in clang 10. It is not available for clang <= 9.

qemu/migration/migration.c:2038:24: error: implicit conversion from 'long' to 'double' changes value from 9223372036854775807 to 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
...
qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709550592 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]

Signed-off-by: Fangrui Song <i@maskray.me>
---
  migration/migration.c | 4 ++--
  util/cutils.c         | 4 ++--
  2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..ac3ea2934a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -53,6 +53,7 @@
  #include "monitor/monitor.h"
  #include "net/announce.h"
  #include "qemu/queue.h"
+#include <math.h>
  
  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
  
@@ -2035,11 +2036,10 @@ void qmp_migrate_set_downtime(double value, Error **errp)
      }
  
      value *= 1000; /* Convert to milliseconds */
-    value = MAX(0, MIN(INT64_MAX, value));
  
      MigrateSetParameters p = {
          .has_downtime_limit = true,
-        .downtime_limit = value,
+        .downtime_limit = (int64_t)fmin(value, nextafter(0x1p63, 0)),
      };
  
      qmp_migrate_set_parameters(&p, errp);
diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..2b4484c015 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char **end,
          goto out;
      }
      /*
-     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
+     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
       * through double (53 bits of precision).
       */
-    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
+    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
          retval = -ERANGE;
          goto out;
      }
-- 
2.24.0


