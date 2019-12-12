Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF43C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC01214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By+FAKOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC01214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSPq-0007vc-R2
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW6-0006UQ-Hd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW5-00030D-8N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRW5-0002z5-3o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wtW03wKduanTOuj8YbTNu2WRG1KP4JxkSYDlZB6z1I=;
 b=By+FAKOO1mvlcbT3CpPZIpUis6zVlmHDvIjaeOhmfHS0h3KHg29IH0BB81FqIYHPwkQYtS
 jW0OiSG/tJhouVu5yPz8ApAePB+BWOYbnpe30uGbC5FG0OgaPcl0WaNKshQLKqa851IpSU
 MBFSS47vk6jx77wNmIGx3vzAgePrIhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-esZvh4y3NBCOrwq4LPFVJQ-1; Thu, 12 Dec 2019 11:40:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AB751005502
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:38 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9118960BE1;
 Thu, 12 Dec 2019 16:40:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 059/104] virtiofsd: Add ID to the log with FUSE_LOG_DEBUG level
Date: Thu, 12 Dec 2019 16:38:19 +0000
Message-Id: <20191212163904.159893-60-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: esZvh4y3NBCOrwq4LPFVJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
It would be useful for debugging if we can identify the specific thread
from the log.

Add ID, which is got by gettid(), to the log with FUSE_LOG_DEBUG level
so that we can grep the specific thread.

The log is like as:

  ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/tmp=
/share0 -o cache=3Dauto
  ...
  [ID: 00000097]    unique: 12696, success, outsize: 120
  [ID: 00000097] virtio_send_msg: elem 18: with 2 in desc of length 120
  [ID: 00000003] fv_queue_thread: Got queue event on Queue 1
  [ID: 00000003] fv_queue_thread: Queue 1 gave evalue: 1 available: in: 655=
52 out: 80
  [ID: 00000003] fv_queue_thread: Waiting for Queue 1 event
  [ID: 00000071] fv_queue_worker: elem 33: with 2 out desc of length 80 bad=
_in_num=3D0 bad_out_num=3D0
  [ID: 00000071] unique: 12694, opcode: READ (15), nodeid: 2, insize: 80, p=
id: 2014
  [ID: 00000071] lo_read(ino=3D2, size=3D65536, off=3D131072)

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/virtiofsd/passthrough_ll.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 6f398a7ff2..8e00a90e6f 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -42,6 +42,7 @@
 #include <cap-ng.h>
 #include <dirent.h>
 #include <errno.h>
+#include <glib.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
@@ -2248,12 +2249,18 @@ static void setup_nofile_rlimit(void)
     }
 }
=20
-static void log_func(enum fuse_log_level level, const char *fmt, va_list a=
p)
+static void log_func(enum fuse_log_level level, const char *_fmt, va_list =
ap)
 {
+    char *fmt =3D (char *)_fmt;
+
     if (current_log_level < level) {
         return;
     }
=20
+    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
+        fmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid), _f=
mt);
+    }
+
     if (use_syslog) {
         int priority =3D LOG_ERR;
         switch (level) {
@@ -2286,6 +2293,10 @@ static void log_func(enum fuse_log_level level, cons=
t char *fmt, va_list ap)
     } else {
         vfprintf(stderr, fmt, ap);
     }
+
+    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
+        g_free(fmt);
+    }
 }
=20
 int main(int argc, char *argv[])
--=20
2.23.0


