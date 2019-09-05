Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577AEC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BBC20820
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BBC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tc7-0002Bp-QJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5taM-0000Sq-Gq
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5taL-0007k8-0x
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5taK-0007jq-O8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 13B84862E;
 Thu,  5 Sep 2019 15:22:08 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 387076060D;
 Thu,  5 Sep 2019 15:22:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Date: Thu,  5 Sep 2019 16:21:36 +0100
Message-Id: <20190905152136.30637-4-stefanha@redhat.com>
In-Reply-To: <20190905152136.30637-1-stefanha@redhat.com>
References: <20190905152136.30637-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 05 Sep 2019 15:22:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 3/3] virtiofsd: add virtiofsctl command-line
 management tool
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtiofsctl can control a running virtiofsd process:

  usage: ./virtiofsctl COMMAND [args...]

  Commands:
    get-log-level       - show current log level
    set-log-level LEVEL - set current log level to one of
                          "err", "warning", "info", "debug"

Make sure it is running in the same DBus session as virtiofsd.  This may
require setting the DBUS_SESSION_BUS_ADDRESS environment variable to the
same value as used by virtiofsd.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile                        |  3 ++
 Makefile.objs                   |  1 +
 contrib/virtiofsd/Makefile.objs |  3 ++
 contrib/virtiofsd/virtiofsctl.c | 55 +++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 contrib/virtiofsd/virtiofsctl.c

diff --git a/Makefile b/Makefile
index 6b1af33348..d7ed9e7669 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ dummy :=3D $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 virtiofsd-obj-y \
+                virtiofsctl-obj-y \
                 rdmacm-mux-obj-y \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
@@ -661,6 +662,8 @@ contrib/virtiofsd/gdbus_generated.c-timestamp: $(SRC_=
PATH)/contrib/virtiofsd/org
=20
 virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
+virtiofsctl$(EXESUF): $(virtiofsctl-obj-y)
+	$(call LINK, $^)
 endif
=20
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) =
libqemuutil.a libqemustub.a
diff --git a/Makefile.objs b/Makefile.objs
index dfdd7d56ea..326a8abb8e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -126,6 +126,7 @@ rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
 vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
 virtiofsd-obj-y =3D contrib/virtiofsd/
+virtiofsctl-obj-y =3D contrib/virtiofsd/
=20
 ######################################################################
 trace-events-subdirs =3D
diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile=
.objs
index d59ab60f3d..3f944d493e 100644
--- a/contrib/virtiofsd/Makefile.objs
+++ b/contrib/virtiofsd/Makefile.objs
@@ -11,6 +11,9 @@ virtiofsd-obj-y =3D buffer.o \
                   gdbus_generated.o \
                   dbus.o
=20
+virtiofsctl-obj-y =3D virtiofsctl.o \
+                    gdbus_generated.o
+
 seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
 seccomp.o-libs :=3D $(SECCOMP_LIBS)
=20
diff --git a/contrib/virtiofsd/virtiofsctl.c b/contrib/virtiofsd/virtiofs=
ctl.c
new file mode 100644
index 0000000000..39bee2b881
--- /dev/null
+++ b/contrib/virtiofsd/virtiofsctl.c
@@ -0,0 +1,55 @@
+#include <stdio.h>
+#include "gdbus_generated.h"
+
+static void get_log_level(Virtiofsd *virtiofsd)
+{
+    const char *value =3D virtiofsd_get_log_level(virtiofsd);
+
+    printf("%s\n", value ? value : "(null)");
+}
+
+static void set_log_level(Virtiofsd *virtiofsd, const char *value)
+{
+    virtiofsd_set_log_level(virtiofsd, value);
+}
+
+static void usage(const char *progname)
+{
+    printf("usage: %s COMMAND [args...]\n", progname);
+    printf("\n");
+    printf("Commands:\n");
+    printf("  get-log-level       - show current log level\n");
+    printf("  set-log-level LEVEL - set current log level to one of\n");
+    printf("                        \"err\", \"warning\", \"info\", \"de=
bug\"\n");
+    exit(0);
+}
+
+int main(int argc, char **argv)
+{
+    Virtiofsd *virtiofsd;
+    GError *error =3D NULL;
+
+    if (argc < 2) {
+        usage(argv[0]);
+    }
+
+    virtiofsd =3D virtiofsd_proxy_new_for_bus_sync(G_BUS_TYPE_SESSION,
+            G_DBUS_PROXY_FLAGS_NONE, "org.qemu.virtiofsd",
+            "/org/qemu/virtiofsd", NULL, &error);
+    if (error) {
+        fprintf(stderr, "%s\n", error->message);
+        g_error_free(error);
+        return 1;
+    }
+
+    if (strcmp(argv[0], "get-log-level") =3D=3D 0) {
+        get_log_level(virtiofsd);
+    } else if (strcmp(argv[0], "set-log-level") =3D=3D 0) {
+        if (argc !=3D 3) {
+            usage(argv[0]);
+        }
+        set_log_level(virtiofsd, argv[2]);
+    }
+    g_object_unref(virtiofsd);
+    return 0;
+}
--=20
2.21.0


