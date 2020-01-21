Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A9FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD3621569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZSjaUTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD3621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittN3-0007CW-Kg
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsfq-0001oY-DR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsfm-00047y-P1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsfm-00047i-KJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Psgch6gQfws+M0NJ1hFNRZjxN6CZdd3GQ5pzx8YG+kA=;
 b=iZSjaUTbQsWhGphhvE6mf/TTsLwd3FNn+Rzq53i/KG2SS5VzVsOJWsHLbM9RCaOwXKCDOu
 yN54F8rTLZiP1F7tjtc097edc6P343bqKCmGsrh112oUOvln13KonicnIA/WF16PFyuEIC
 WvcozyG2ZLp5nfOEDcq48SgqkE4b0ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-f_RQrECcOE6Zcc4wrECY_w-1; Tue, 21 Jan 2020 07:30:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B5A8101FCD2;
 Tue, 21 Jan 2020 12:30:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08E9B60FC4;
 Tue, 21 Jan 2020 12:29:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 061/109] virtiofsd: Add ID to the log with FUSE_LOG_DEBUG
 level
Date: Tue, 21 Jan 2020 12:23:45 +0000
Message-Id: <20200121122433.50803-62-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: f_RQrECcOE6Zcc4wrECY_w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
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

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  added rework as suggested by Daniel P. Berrang=C3=A9 during review
---
 tools/virtiofsd/passthrough_ll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 20b5a242cb..991de69334 100644
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
@@ -2267,10 +2268,17 @@ static void setup_nofile_rlimit(void)
=20
 static void log_func(enum fuse_log_level level, const char *fmt, va_list a=
p)
 {
+    g_autofree char *localfmt =3D NULL;
+
     if (current_log_level < level) {
         return;
     }
=20
+    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
+        localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid=
), fmt);
+        fmt =3D localfmt;
+    }
+
     if (use_syslog) {
         int priority =3D LOG_ERR;
         switch (level) {
--=20
2.24.1


