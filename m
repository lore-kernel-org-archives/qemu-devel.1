Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B9620661
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqVS8n+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B9620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuchz-0000ix-VW
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9a-00036w-Tu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9Z-0005ad-Qg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9Z-0005aV-NK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCzeNHVQYeQzqHFX9R7K9wyt51BbDBU9nAmL+c6dKAo=;
 b=BqVS8n+9bhqZfYsvEA1u1w2HYr27nap80KAiDQbAT4dNWUyDrigCjvnHtTp3/pWDMBFJBi
 w7O0WVlWD7L07Mih6afhDzExAcXjSxh9QRD0ncVq8RdzYCdGIwhxZ8oB6fAKRiKtbrumij
 9y0sMFOKGRDHUsPhKDeuHWeFY+QYfp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-n8gH8sqVM1yvebocXryKuw-1; Thu, 23 Jan 2020 07:00:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2AF7107ACC5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 034DE85750;
 Thu, 23 Jan 2020 12:00:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 063/111] virtiofsd: Add timestamp to the log with
 FUSE_LOG_DEBUG level
Date: Thu, 23 Jan 2020 11:57:53 +0000
Message-Id: <20200123115841.138849-64-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: n8gH8sqVM1yvebocXryKuw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

virtiofsd has some threads, so we see a lot of logs with debug option.
It would be useful for debugging if we can see the timestamp.

Add nano second timestamp, which got by get_clock(), to the log with
FUSE_LOG_DEBUG level if the syslog option isn't set.

The log is like as:

  # ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/tmp/=
share0 -o cache=3Dauto
  ...
  [5365943125463727] [ID: 00000002] fv_queue_thread: Start for queue 0 kick=
_fd 9
  [5365943125568644] [ID: 00000002] fv_queue_thread: Waiting for Queue 0 ev=
ent
  [5365943125573561] [ID: 00000002] fv_queue_thread: Got queue event on Que=
ue 0

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index f08324f000..98114a3f4a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -36,6 +36,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "fuse_virtio.h"
 #include "fuse_log.h"
 #include "fuse_lowlevel.h"
@@ -2276,7 +2277,13 @@ static void log_func(enum fuse_log_level level, cons=
t char *fmt, va_list ap)
     }
=20
     if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
-        localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid=
), fmt);
+        if (!use_syslog) {
+            localfmt =3D g_strdup_printf("[%" PRId64 "] [ID: %08ld] %s",
+                                       get_clock(), syscall(__NR_gettid), =
fmt);
+        } else {
+            localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_ge=
ttid),
+                                       fmt);
+        }
         fmt =3D localfmt;
     }
=20
--=20
2.24.1


