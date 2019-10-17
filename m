Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13881ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5E520640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5E520640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5Wy-0007Tz-Dx
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5S0-0000ZQ-Ra
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5Rz-0008Nu-Dk
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Rw-0008Lb-AL; Thu, 17 Oct 2019 09:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89F7C19D04A;
 Thu, 17 Oct 2019 13:04:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 097521001B11;
 Thu, 17 Oct 2019 13:04:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 05/18] qemu-storage-daemon: Add --blockdev option
Date: Thu, 17 Oct 2019 15:01:51 +0200
Message-Id: <20191017130204.16131-6-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 17 Oct 2019 13:04:15 +0000 (UTC)
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

This adds a --blockdev option to the storage daemon that works the same
as the -blockdev option of the system emulator.

In order to be able to link with blockdev.o, we also need to change
stream.o from common-obj to block-obj, which is where all other block
jobs already are.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 29 +++++++++++++++++++++++++++++
 Makefile              |  5 ++++-
 Makefile.objs         |  7 +++++++
 block/Makefile.objs   |  2 +-
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 48d6af43a6..904e3c3a46 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -28,6 +28,10 @@
 #include "crypto/init.h"
=20
 #include "qapi/error.h"
+#include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "qapi/qobject-input-visitor.h"
+
 #include "qemu-common.h"
 #include "qemu-version.h"
 #include "qemu/config-file.h"
@@ -53,6 +57,13 @@ static void help(void)
 "                         specify tracing options\n"
 "  -V, --version          output version information and exit\n"
 "\n"
+"  --blockdev [driver=3D]<driver>[,node-name=3D<N>][,discard=3Dignore|un=
map]\n"
+"             [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
+"             [,read-only=3Don|off][,auto-read-only=3Don|off]\n"
+"             [,force-share=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
+"             [,driver specific parameters...]\n"
+"                         configure a block backend\n"
+"\n"
 "  --object <properties>  define a QOM object such as 'secret' for\n"
 "                         passwords and/or encryption keys\n"
 "\n"
@@ -62,6 +73,7 @@ QEMU_HELP_BOTTOM "\n",
=20
 enum {
     OPTION_OBJECT =3D 256,
+    OPTION_BLOCKDEV,
 };
=20
 static QemuOptsList qemu_object_opts =3D {
@@ -82,6 +94,7 @@ static int process_options(int argc, char *argv[], Erro=
r **errp)
     static const struct option long_options[] =3D {
         {"help", no_argument, 0, 'h'},
         {"object", required_argument, 0, OPTION_OBJECT},
+        {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
         {"version", no_argument, 0, 'V'},
         {"trace", required_argument, NULL, 'T'},
         {0, 0, 0, 0}
@@ -123,6 +136,22 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
                 qemu_opts_del(opts);
                 break;
             }
+            break;
+        case OPTION_BLOCKDEV:
+            {
+                Visitor *v;
+                BlockdevOptions *options;
+
+                v =3D qobject_input_visitor_new_str(optarg, "driver",
+                                                  &error_fatal);
+
+                visit_type_BlockdevOptions(v, NULL, &options, &error_fat=
al);
+                visit_free(v);
+
+                qmp_blockdev_add(options, &error_fatal);
+                qapi_free_BlockdevOptions(options);
+                break;
+            }
         }
     }
     if (optind !=3D argc) {
diff --git a/Makefile b/Makefile
index 76338d0ab4..b913d4d736 100644
--- a/Makefile
+++ b/Makefile
@@ -432,6 +432,8 @@ dummy :=3D $(call unnest-vars,, \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
+                storage-daemon-obj-y \
+                storage-daemon-obj-m \
                 crypto-obj-y \
                 crypto-user-obj-y \
                 qom-obj-y \
@@ -469,6 +471,7 @@ TARGET_DIRS_RULES :=3D $(foreach t, all clean install=
, $(addsuffix /$(t), $(TARGET
 SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
 $(SOFTMMU_ALL_RULES): $(block-obj-y)
+$(SOFTMMU_ALL_RULES): $(storage-daemon-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
@@ -558,7 +561,7 @@ qemu-img.o: qemu-img-cmds.h
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y=
) $(COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
=20
diff --git a/Makefile.objs b/Makefile.objs
index abcbd89654..00fdf54500 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -37,6 +37,13 @@ qom-obj-y =3D qom/
=20
 io-obj-y =3D io/
=20
+#######################################################################
+# storage-daemon-obj-y is code used by qemu-storage-daemon (these object=
s are
+# used for system emulation, too, but specified separately there)
+
+storage-daemon-obj-y =3D block/
+storage-daemon-obj-y +=3D blockdev.o iothread.o
+
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. =
a
diff --git a/block/Makefile.objs b/block/Makefile.objs
index e394fe0b6c..d24fc93b7f 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -44,7 +44,7 @@ block-obj-y +=3D crypto.o
 block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
=20
-common-obj-y +=3D stream.o
+block-obj-y +=3D stream.o
=20
 nfs.o-libs         :=3D $(LIBNFS_LIBS)
 iscsi.o-cflags     :=3D $(LIBISCSI_CFLAGS)
--=20
2.20.1


