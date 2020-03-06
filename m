Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8CEC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8EB2051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hludl8Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8EB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGkc-0005iw-QA
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZZ-00054J-2c
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZV-000886-Gk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZV-00083c-2k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8YVDvVFqQIT95kwr2BE34qHbwlUBLPq55rX00vvnig=;
 b=Hludl8Ku/5CyW1PXndSm+hcm8pPR7gqPtJkhYttWy4CQrXyRQXwqjQ+xww9J/WHw9oYSrF
 XWAwD/MBHUsRoaP0rmyOINb0XHUl41nKPn3UQwgvf4hTNnJOWo0yQdnYefI2C7Jr6/ftvV
 8gPxYp4GDLu/CnsH9mNf3bLB1fYCZv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-MlUnSV9kPn6qEW699dH-Ug-1; Fri, 06 Mar 2020 12:15:31 -0500
X-MC-Unique: MlUnSV9kPn6qEW699dH-Ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68521184C801;
 Fri,  6 Mar 2020 17:15:30 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D11073873;
 Fri,  6 Mar 2020 17:15:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 19/29] qemu-storage-daemon: Add --chardev option
Date: Fri,  6 Mar 2020 18:14:48 +0100
Message-Id: <20200306171458.1848-20-kwolf@redhat.com>
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a --chardev option to the storage daemon that works the same
as the -chardev option of the system emulator.

The syntax of the --chardev option is still considered unstable. We want
to QAPIfy it and will potentially make changes to its syntax while
converting it. However, we haven't decided yet on a design for the
QAPIfication, so QemuOpts will have to do for now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-14-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 24 ++++++++++++++++++++++++
 Makefile              |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 14093ac3a0..82fe6cd5f2 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -29,6 +29,7 @@
=20
 #include "block/block.h"
 #include "block/nbd.h"
+#include "chardev/char.h"
 #include "crypto/init.h"
=20
 #include "qapi/error.h"
@@ -78,6 +79,9 @@ static void help(void)
 "             [,driver specific parameters...]\n"
 "                         configure a block backend\n"
 "\n"
+"  --chardev <options>    configure a character device backend\n"
+"                         (see the qemu(1) man page for possible options)\=
n"
+"\n"
 "  --export [type=3D]nbd,device=3D<node-name>[,name=3D<export-name>]\n"
 "           [,writable=3Don|off][,bitmap=3D<name>]\n"
 "                         export the specified block node over NBD\n"
@@ -104,11 +108,14 @@ QEMU_HELP_BOTTOM "\n",
=20
 enum {
     OPTION_BLOCKDEV =3D 256,
+    OPTION_CHARDEV,
     OPTION_EXPORT,
     OPTION_NBD_SERVER,
     OPTION_OBJECT,
 };
=20
+extern QemuOptsList qemu_chardev_opts;
+
 static QemuOptsList qemu_object_opts =3D {
     .name =3D "object",
     .implied_opt_name =3D "qom-type",
@@ -135,6 +142,7 @@ static void process_options(int argc, char *argv[])
=20
     static const struct option long_options[] =3D {
         {"blockdev", required_argument, NULL, OPTION_BLOCKDEV},
+        {"chardev", required_argument, NULL, OPTION_CHARDEV},
         {"export", required_argument, NULL, OPTION_EXPORT},
         {"help", no_argument, NULL, 'h'},
         {"nbd-server", required_argument, NULL, OPTION_NBD_SERVER},
@@ -182,6 +190,22 @@ static void process_options(int argc, char *argv[])
                 qapi_free_BlockdevOptions(options);
                 break;
             }
+        case OPTION_CHARDEV:
+            {
+                /* TODO This interface is not stable until we QAPIfy it */
+                QemuOpts *opts =3D qemu_opts_parse_noisily(&qemu_chardev_o=
pts,
+                                                         optarg, true);
+                if (opts =3D=3D NULL) {
+                    exit(EXIT_FAILURE);
+                }
+
+                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
+                    /* No error, but NULL returned means help was printed =
*/
+                    exit(EXIT_SUCCESS);
+                }
+                qemu_opts_del(opts);
+                break;
+            }
         case OPTION_EXPORT:
             {
                 Visitor *v;
diff --git a/Makefile b/Makefile
index 7c75440182..05a74c77b2 100644
--- a/Makefile
+++ b/Makefile
@@ -589,7 +589,7 @@ qemu-img.o: qemu-img-cmds.h
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) =
$(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(=
COMMON_LDADDS)
+qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block=
-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage=
-daemon-obj-y) $(COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
=20
--=20
2.20.1


