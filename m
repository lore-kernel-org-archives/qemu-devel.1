Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB8CECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FFE20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FFE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5fT-0000vn-Ld
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SB-0000o3-HN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5SA-0008UU-9L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5S3-0008Q0-LT; Thu, 17 Oct 2019 09:04:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DFC9FC0546D5;
 Thu, 17 Oct 2019 13:04:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ED4D1001938;
 Thu, 17 Oct 2019 13:04:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 09/18] qemu-storage-daemon: Add main loop
Date: Thu, 17 Oct 2019 15:01:55 +0200
Message-Id: <20191017130204.16131-10-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 17 Oct 2019 13:04:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
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
index 9e5f474fd0..099388f645 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -45,10 +45,18 @@
 #include "qemu/option.h"
 #include "qom/object_interfaces.h"
=20
+#include "sysemu/runstate.h"
 #include "trace/control.h"
=20
 #include <getopt.h>
=20
+static bool exit_requested =3D false;
+
+void qemu_system_killed(int signal, pid_t pid)
+{
+    exit_requested =3D true;
+}
+
 static void help(void)
 {
     printf(
@@ -238,6 +246,7 @@ int main(int argc, char *argv[])
=20
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
+    os_setup_signal_handling();
=20
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_TRACE);
@@ -256,5 +265,9 @@ int main(int argc, char *argv[])
         return EXIT_FAILURE;
     }
=20
+    while (!exit_requested) {
+        main_loop_wait(false);
+    }
+
     return EXIT_SUCCESS;
 }
diff --git a/Makefile.objs b/Makefile.objs
index cc262e445f..b667d3f07b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -43,6 +43,8 @@ io-obj-y =3D io/
=20
 storage-daemon-obj-y =3D block/
 storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
+storage-daemon-obj-$(CONFIG_WIN32) +=3D os-win32.o
+storage-daemon-obj-$(CONFIG_POSIX) +=3D os-posix.o
=20
 ######################################################################
 # Target independent part of system emulation. The long term path is to
--=20
2.20.1


