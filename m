Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2F4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7C12051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihNuaUcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7C12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGlr-0007ph-Gf
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZY-000514-1l
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZV-00086S-2m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34933
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZU-00081T-5p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAdGozCUiT9wTlI7LKH9TYN3Qhxet0wekiglsfecSKo=;
 b=ihNuaUcN8mAodKLvReAEnj63bChbKhCGYpMhfrz1119KlbOHjevu3o+aZbc3zX1QCw8kMS
 rMsxMA2CZtJwXQWCZo+aa5LDCWGDgS+48LQyXEoXQuq+KsClFgJm1KwOcgSs9Sjn06+fp0
 UDma32tOjm5wuowFnCECl2mO2WeWYhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-4B0KVNpwOD-HIrEVEW0ZZw-1; Fri, 06 Mar 2020 12:15:30 -0500
X-MC-Unique: 4B0KVNpwOD-HIrEVEW0ZZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 242A2107ACCD;
 Fri,  6 Mar 2020 17:15:29 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2C073892;
 Fri,  6 Mar 2020 17:15:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/29] qemu-storage-daemon: Add main loop
Date: Fri,  6 Mar 2020 18:14:47 +0100
Message-Id: <20200306171458.1848-19-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Message-Id: <20200224143008.13362-13-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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
index bacbdb55bc..2554e331d5 100644
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


