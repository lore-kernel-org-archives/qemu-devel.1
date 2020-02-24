Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE853C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7845F20828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AergLALY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7845F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6EqN-00038D-Kq
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6ElB-0002As-2m
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6ElA-0002Om-1C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:31:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44931
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6El9-0002OU-TC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgvMrZAaJrX0VNGwKnG9ok2caqv8FZvIia/6tr1q6bE=;
 b=AergLALY3rBnJVIfTTegb0QTgpN9+Bb9L92jY+TYa14V15NUvwuOxkraO6cY+u+4VH8A2X
 nhSCbHvAg3ghqh6Lkhb3L40y2JHkYAXl4v92OjEHtX1DAs3Mwb8qHlvdCJK5Tq/X/Ebxnr
 g7soJX4Vnx4FpeRu8s4plfqoqb0ni+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-yKRUOOUpMuiBudEvYkhhsA-1; Mon, 24 Feb 2020 09:30:57 -0500
X-MC-Unique: yKRUOOUpMuiBudEvYkhhsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DCDFDB6E;
 Mon, 24 Feb 2020 14:30:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-134.ams2.redhat.com
 [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9BE5C114;
 Mon, 24 Feb 2020 14:30:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 12/20] qemu-storage-daemon: Add main loop
Date: Mon, 24 Feb 2020 15:30:00 +0100
Message-Id: <20200224143008.13362-13-kwolf@redhat.com>
In-Reply-To: <20200224143008.13362-1-kwolf@redhat.com>
References: <20200224143008.13362-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 coiby.xu@gmail.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of exiting after processing all command line options, start a
main loop and keep processing events until exit is requested with a
signal (e.g. SIGINT).

Now qemu-storage-daemon can be used as an alternative for qemu-nbd that
provides a few features that were previously only available from QMP,
such as access to options only available with -blockdev and the socket
types 'vsock' and 'fd'.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 13 +++++++++++++
 Makefile.objs         |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 5904d3c5b4..14093ac3a0 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -50,8 +50,16 @@
 #include "qemu/option.h"
 #include "qom/object_interfaces.h"
=20
+#include "sysemu/runstate.h"
 #include "trace/control.h"
=20
+static volatile bool exit_requested =3D false;
+
+void qemu_system_killed(int signal, pid_t pid)
+{
+    exit_requested =3D true;
+}
+
 static void help(void)
 {
     printf(
@@ -241,6 +249,7 @@ int main(int argc, char *argv[])
=20
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
+    os_setup_signal_handling();
=20
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_TRACE);
@@ -256,5 +265,9 @@ int main(int argc, char *argv[])
     qemu_init_main_loop(&error_fatal);
     process_options(argc, argv);
=20
+    while (!exit_requested) {
+        main_loop_wait(false);
+    }
+
     return EXIT_SUCCESS;
 }
diff --git a/Makefile.objs b/Makefile.objs
index 25ab313690..5b30537fd9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -33,6 +33,8 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
=20
 storage-daemon-obj-y =3D block/ qom/
 storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
+storage-daemon-obj-$(CONFIG_WIN32) +=3D os-win32.o
+storage-daemon-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
 ######################################################################
 # Target independent part of system emulation. The long term path is to
--=20
2.20.1


