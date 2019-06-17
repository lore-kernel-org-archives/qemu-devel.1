Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6914C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA85020863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcx3E-0000VA-Tb
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40429)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwh2-0001cR-11
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwh0-0007sL-Er
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwh0-0007hc-48
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD32F7FDF6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63EA180EB;
 Mon, 17 Jun 2019 18:49:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CC491133007; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:48:55 +0200
Message-Id: <20190617184903.19436-9-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 17 Jun 2019 18:49:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/16] Move monitor.c to monitor/misc.c
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Create a new monitor/ subdirectory and move monitor.c there. As the plan
is to move the monitor core into separate files, use the chance to
rename it to misc.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190613153405.24769-8-kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                         |  4 ++--
 Makefile.objs                       |  1 +
 Makefile.target                     |  3 ++-
 docs/devel/writing-qmp-commands.txt |  2 +-
 monitor/Makefile.objs               |  1 +
 monitor.c =3D> monitor/misc.c         |  2 +-
 monitor/trace-events                | 11 +++++++++++
 trace-events                        | 10 ----------
 8 files changed, 19 insertions(+), 15 deletions(-)
 create mode 100644 monitor/Makefile.objs
 rename monitor.c =3D> monitor/misc.c (99%)
 create mode 100644 monitor/trace-events

diff --git a/MAINTAINERS b/MAINTAINERS
index acbad134ec..575ea6e68d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1918,7 +1918,7 @@ F: qapi/run-state.json
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
-F: monitor.c
+F: monitor/misc.c
 F: hmp.[ch]
 F: hmp-commands*.hx
 F: include/monitor/hmp-target.h
@@ -2040,7 +2040,7 @@ QMP
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qmp.c
-F: monitor.c
+F: monitor/misc.c
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
 F: scripts/qmp/
diff --git a/Makefile.objs b/Makefile.objs
index c8337fa34b..dd39a70b48 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -130,6 +130,7 @@ trace-events-subdirs =3D
 trace-events-subdirs +=3D accel/kvm
 trace-events-subdirs +=3D accel/tcg
 trace-events-subdirs +=3D crypto
+trace-events-subdirs +=3D monitor
 ifeq ($(CONFIG_USER_ONLY),y)
 trace-events-subdirs +=3D linux-user
 endif
diff --git a/Makefile.target b/Makefile.target
index ecd856e3a3..72c267f7dc 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,9 +148,10 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y +=3D arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o num=
a.o
+obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o numa.o
 obj-y +=3D qtest.o
 obj-y +=3D hw/
+obj-y +=3D monitor/
 obj-y +=3D qapi/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index 9dfc62bf5a..cc6ecd6d5d 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -470,7 +470,7 @@ it's good practice to always check for errors.
=20
 Another important detail is that HMP's "info" commands don't go into the
 hmp-commands.hx. Instead, they go into the info_cmds[] table, which is d=
efined
-in the monitor.c file. The entry for the "info alarmclock" follows:
+in the monitor/misc.c file. The entry for the "info alarmclock" follows:
=20
     {
         .name       =3D "alarmclock",
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
new file mode 100644
index 0000000000..e783b0616b
--- /dev/null
+++ b/monitor/Makefile.objs
@@ -0,0 +1 @@
+obj-y +=3D misc.o
diff --git a/monitor.c b/monitor/misc.c
similarity index 99%
rename from monitor.c
rename to monitor/misc.c
index 3015b6e9c7..c5f8483b7e 100644
--- a/monitor.c
+++ b/monitor/misc.c
@@ -64,7 +64,7 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
 #ifdef CONFIG_TRACE_SIMPLE
diff --git a/monitor/trace-events b/monitor/trace-events
new file mode 100644
index 0000000000..abfdf20b14
--- /dev/null
+++ b/monitor/trace-events
@@ -0,0 +1,11 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# misc.c
+monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
+monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
+monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
+handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
+handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
+monitor_suspend(void *ptr, int cnt) "mon %p: %d"
+monitor_qmp_cmd_in_band(const char *id) "%s"
+monitor_qmp_cmd_out_of_band(const char *id) "%s"
diff --git a/trace-events b/trace-events
index 844ee58dd9..aeea3c2bdb 100644
--- a/trace-events
+++ b/trace-events
@@ -41,16 +41,6 @@ system_wakeup_request(int reason) "reason=3D%d"
 qemu_system_shutdown_request(int reason) "reason=3D%d"
 qemu_system_powerdown_request(void) ""
=20
-# monitor.c
-monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
-monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
-monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
-handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
-handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
-monitor_suspend(void *ptr, int cnt) "mon %p: %d"
-monitor_qmp_cmd_in_band(const char *id) "%s"
-monitor_qmp_cmd_out_of_band(const char *id) "%s"
-
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=3D%p b=
s=3D%p offset=3D%" PRId64 " to_dev=3D%d"
 dma_aio_cancel(void *dbs) "dbs=3D%p"
--=20
2.21.0


