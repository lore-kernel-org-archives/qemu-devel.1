Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B003C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2972051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctaaXbxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2972051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGlA-0006yi-0F
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZV-0004zS-2W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZR-0007y4-RK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZP-0007VP-Hk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uz+t4NULkIj3ANM4K1/RWUZJ0mrDSlSsJKcoPA3FThY=;
 b=ctaaXbxTl4/KQnILLBl7/btn3RmQVw7WxS+vbwVPbZjmetnPdLGWJqEVfQwmCynX7V0veW
 M37P3gTRipe17n9JKnzX4uQ6Slt1GyP9Zj0grGv5sA7G3pvVdPcLGZwcubMuHv4jgWRO9+
 f3K0un90qrCyHvYmpJ2ApRgnUKx7KIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-BKoAb4DSP8iEfXBiiO-G8A-1; Fri, 06 Mar 2020 12:15:22 -0500
X-MC-Unique: BKoAb4DSP8iEfXBiiO-G8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EF8A100726D;
 Fri,  6 Mar 2020 17:15:21 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84CFC73873;
 Fri,  6 Mar 2020 17:15:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/29] qemu-storage-daemon: Add --blockdev option
Date: Fri,  6 Mar 2020 18:14:41 +0100
Message-Id: <20200306171458.1848-13-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

This adds a --blockdev option to the storage daemon that works the same
as the -blockdev option of the system emulator.

In order to be able to link with blockdev.o, we also need to change
stream.o from common-obj to block-obj, which is where all other block
jobs already are.

In contrast to the system emulator, qemu-storage-daemon options will be
processed in the order they are given. The user needs to take care to
refer to other objects only after defining them.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-7-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
 Makefile              |  5 ++++-
 Makefile.objs         |  7 +++++++
 block/Makefile.objs   |  2 +-
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index fc4aef572b..c30caaf59e 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -31,6 +31,10 @@
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
@@ -52,15 +56,27 @@ static void help(void)
 "                         specify tracing options\n"
 "  -V, --version          output version information and exit\n"
 "\n"
+"  --blockdev [driver=3D]<driver>[,node-name=3D<N>][,discard=3Dignore|unma=
p]\n"
+"             [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
+"             [,read-only=3Don|off][,auto-read-only=3Don|off]\n"
+"             [,force-share=3Don|off][,detect-zeroes=3Don|off|unmap]\n"
+"             [,driver specific parameters...]\n"
+"                         configure a block backend\n"
+"\n"
 QEMU_HELP_BOTTOM "\n",
     error_get_progname());
 }
=20
+enum {
+    OPTION_BLOCKDEV =3D 256,
+};
+
 static void process_options(int argc, char *argv[])
 {
     int c;
=20
     static const struct option long_options[] =3D {
+        {"blockdev", required_argument, NULL, OPTION_BLOCKDEV},
         {"help", no_argument, NULL, 'h'},
         {"trace", required_argument, NULL, 'T'},
         {"version", no_argument, NULL, 'V'},
@@ -90,6 +106,21 @@ static void process_options(int argc, char *argv[])
             printf("qemu-storage-daemon version "
                    QEMU_FULL_VERSION "\n" QEMU_COPYRIGHT "\n");
             exit(EXIT_SUCCESS);
+        case OPTION_BLOCKDEV:
+            {
+                Visitor *v;
+                BlockdevOptions *options;
+
+                v =3D qobject_input_visitor_new_str(optarg, "driver",
+                                                  &error_fatal);
+
+                visit_type_BlockdevOptions(v, NULL, &options, &error_fatal=
);
+                visit_free(v);
+
+                qmp_blockdev_add(options, &error_fatal);
+                qapi_free_BlockdevOptions(options);
+                break;
+            }
         default:
             g_assert_not_reached();
         }
diff --git a/Makefile b/Makefile
index 2bf59d4f42..7c75440182 100644
--- a/Makefile
+++ b/Makefile
@@ -450,6 +450,8 @@ dummy :=3D $(call unnest-vars,, \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
+                storage-daemon-obj-y \
+                storage-daemon-obj-m \
                 crypto-obj-y \
                 qom-obj-y \
                 io-obj-y \
@@ -482,6 +484,7 @@ TARGET_DIRS_RULES :=3D $(foreach t, all fuzz clean inst=
all, $(addsuffix /$(t), $(T
 SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
 $(SOFTMMU_ALL_RULES): $(block-obj-y)
+$(SOFTMMU_ALL_RULES): $(storage-daemon-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
@@ -586,7 +589,7 @@ qemu-img.o: qemu-img-cmds.h
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) =
$(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(=
COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
=20
diff --git a/Makefile.objs b/Makefile.objs
index 8a1cbe8000..3db3a7db6e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -27,6 +27,13 @@ io-obj-y =3D io/
=20
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
=20
+#######################################################################
+# storage-daemon-obj-y is code used by qemu-storage-daemon (these objects =
are
+# used for system emulation, too, but specified separately there)
+
+storage-daemon-obj-y =3D block/
+storage-daemon-obj-y +=3D blockdev.o iothread.o
+
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. a
diff --git a/block/Makefile.objs b/block/Makefile.objs
index e06cf0b284..cb36ae2503 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -46,7 +46,7 @@ block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
 block-obj-y +=3D filter-compress.o
=20
-common-obj-y +=3D stream.o
+block-obj-y +=3D stream.o
=20
 common-obj-y +=3D qapi-sysemu.o
=20
--=20
2.20.1


