Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E79214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xee+YX2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E79214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSOa-00062Q-GQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW7-0006WW-TW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW6-00033e-QP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRW6-00032Y-M2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jATh6s0mzb1OGuPD7THwqcKVeVz1fcAINKaP1WcnAFE=;
 b=Xee+YX2tEA79vOBo337hiO7kiAGFytQtmSOsGo1Ua+babpIA+GmnDaJSoxNAMrolj6FJOk
 2UaErYazxxM/h6FBP7ixDuke2XHdIqiJDV272CV3WbO6z0TveAm4ZfUeAjz+NM9eypjHQn
 X4H3LNCVShk40FAknvQkWOFaPuEukIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-umVwNgOgMKGINK0hdulfTQ-1; Thu, 12 Dec 2019 11:40:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 973961800D45
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B46EB60BE1;
 Thu, 12 Dec 2019 16:40:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 060/104] virtiofsd: Add timestamp to the log with
 FUSE_LOG_DEBUG level
Date: Thu, 12 Dec 2019 16:38:20 +0000
Message-Id: <20191212163904.159893-61-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: umVwNgOgMKGINK0hdulfTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

  ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/tmp=
/share0 -o cache=3Dauto
  ...
  [5365943125463727] [ID: 00000002] fv_queue_thread: Start for queue 0 kick=
_fd 9
  [5365943125568644] [ID: 00000002] fv_queue_thread: Waiting for Queue 0 ev=
ent
  [5365943125573561] [ID: 00000002] fv_queue_thread: Got queue event on Que=
ue 0

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/virtiofsd/passthrough_ll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 8e00a90e6f..91d3120033 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -35,6 +35,8 @@
  * \include passthrough_ll.c
  */
=20
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "fuse_virtio.h"
 #include "fuse_log.h"
 #include "fuse_lowlevel.h"
@@ -2258,7 +2260,12 @@ static void log_func(enum fuse_log_level level, cons=
t char *_fmt, va_list ap)
     }
=20
     if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
-        fmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid), _f=
mt);
+        if (!use_syslog) {
+            fmt =3D g_strdup_printf("[%ld] [ID: %08ld] %s", get_clock(),
+                                  syscall(__NR_gettid), _fmt);
+        } else {
+            fmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid)=
, _fmt);
+        }
     }
=20
     if (use_syslog) {
--=20
2.23.0


