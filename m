Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA90ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8A420640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8A420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5YY-0001R1-8s
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SD-0000qy-CW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5S8-0008TN-9n
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5S5-0008RL-Ez; Thu, 17 Oct 2019 09:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7DDF18C4287;
 Thu, 17 Oct 2019 13:04:24 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 374AA10098FB;
 Thu, 17 Oct 2019 13:04:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 10/18] qemu-storage-daemon: Add --chardev option
Date: Thu, 17 Oct 2019 15:01:56 +0200
Message-Id: <20191017130204.16131-11-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 17 Oct 2019 13:04:24 +0000 (UTC)
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

This adds a --chardev option to the storage daemon that works the same
as the -chardev option of the system emulator.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 19 +++++++++++++++++++
 Makefile              |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 099388f645..46e0a6ea56 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -26,6 +26,7 @@
=20
 #include "block/block.h"
 #include "block/nbd.h"
+#include "chardev/char.h"
 #include "crypto/init.h"
=20
 #include "qapi/error.h"
@@ -75,6 +76,9 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --chardev <options>    configure a character device backend\n"
+"                         (see the qemu(1) man page for possible options=
)\n"
+"\n"
 "  --export [type=3D]nbd,device=3D<node-name>[,name=3D<export-name>]\n"
 "           [,writable=3Don|off][,bitmap=3D<name>]\n"
 "                         export the specified block node over NBD\n"
@@ -96,10 +100,13 @@ QEMU_HELP_BOTTOM "\n",
 enum {
     OPTION_OBJECT =3D 256,
     OPTION_BLOCKDEV,
+    OPTION_CHARDEV,
     OPTION_NBD_SERVER,
     OPTION_EXPORT,
 };
=20
+extern QemuOptsList qemu_chardev_opts;
+
 static QemuOptsList qemu_object_opts =3D {
     .name =3D "object",
     .implied_opt_name =3D "qom-type",
@@ -130,6 +137,7 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
         {"help", no_argument, 0, 'h'},
         {"object", required_argument, 0, OPTION_OBJECT},
         {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
+        {"chardev", required_argument, 0, OPTION_CHARDEV},
         {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
         {"export", required_argument, 0, OPTION_EXPORT},
         {"version", no_argument, 0, 'V'},
@@ -189,6 +197,17 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
                 qapi_free_BlockdevOptions(options);
                 break;
             }
+        case OPTION_CHARDEV:
+            {
+                QemuOpts *opts =3D qemu_opts_parse(&qemu_chardev_opts,
+                                                 optarg, true, &error_fa=
tal);
+                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
+                    /* No error, but NULL returned means help was printe=
d */
+                    exit(EXIT_SUCCESS);
+                }
+                qemu_opts_del(opts);
+                break;
+            }
         case OPTION_NBD_SERVER:
             {
                 Visitor *v;
diff --git a/Makefile b/Makefile
index b913d4d736..0e3e98582d 100644
--- a/Makefile
+++ b/Makefile
@@ -561,7 +561,7 @@ qemu-img.o: qemu-img-cmds.h
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y=
) $(COMMON_LDADDS)
+qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(sto=
rage-daemon-obj-y) $(COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
=20
--=20
2.20.1


