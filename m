Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD33C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349E520674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK516x8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349E520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFIZ-0003n0-Br
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFHL-00023D-3J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFHJ-0008Ee-6P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:55 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1jBFHI-0008EK-U8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:53 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a16so4222476pju.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eoWTkg9RP/Ne3BvQ1PvrWsx/dFnp1ZYmLM2v/TTJ4c8=;
 b=UK516x8llT1W8zIa7InnNDNwyPLNB3PtbgXDRltrMwGJYhPXTPVWpnYqKveszBhGqh
 0G9UpwJTTXRn6zsAueU09SJ19VC8uKhO+V5xjFbaby1MXbKH60OvdkvWPt880eeRfutl
 ig6FqQKc7FhGTA3dUndLPtCgcps1L1VBpYsner9L3iQcGBsNaW+Dy1Z7Ydg5TrRSomrl
 6QeOjiMDjI2AZKZ4Hfdhjcmh4CgikrSyFbwRc3rJi8fE+dUFprPoUXfF2MZY0XNAl+hb
 WJ+FqQRaCBdfMyWb6FysuCrq5zTKNV36ql+sqi7JLe1fKcMR4Ei8FjpshWCSd6lBYq/a
 Pf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eoWTkg9RP/Ne3BvQ1PvrWsx/dFnp1ZYmLM2v/TTJ4c8=;
 b=M8NFkrDeqfASEBdnjBx5i5JbKO1qetyTVVdK+GVDoA+dIVi61w62551sGgctPOndmh
 lVuQV23J8fAdjumlrWjIoz/mHa6ScEx2KUTP83eqlwHqvvzvhMFbI727pRza1/VBvZui
 TYG7pMpJYRflaeNJNA1k7R7pCkhyaDWX8/80kwzVrU3jbBbdbQt+4oRyIB49KHJFykcd
 sBY4lq0n16wrpmqDeWd27t3uYMDjeDGACl+/SX2ujc6VlpdGokRQ1bUhfeyIdr3ypOHZ
 rZdWzf4Y2mNNHE+RE3Z0vewVaNElQRctHjdIN1/t5EPpxunC6ZYCJ4+Wzy/wUh/DGgsj
 eVgQ==
X-Gm-Message-State: ANhLgQ27eJKZvv1Q11JGdWsi3UXrG2VZwvipn3AT6OLgVtZkJtSh+uP1
 iF2O5hRomOqCfoOiexnzsMN8c4e5Vz8QBg==
X-Google-Smtp-Source: ADFU+vufRJzYKc6qz8mQ/rIH5S0S2KFxJl8UtPIumvH2GynV1VFxA0ejQyPAWticI5yx7rf0VN00Ew==
X-Received: by 2002:a17:902:a710:: with SMTP id
 w16mr15112774plq.43.1583748291674; 
 Mon, 09 Mar 2020 03:04:51 -0700 (PDT)
Received: from localhost.localdomain
 (tunnel571398-pt.tunnel.tserv14.sea1.ipv6.he.net. [2001:470:a:247::2])
 by smtp.googlemail.com with ESMTPSA id s21sm16077377pfd.99.2020.03.09.03.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 03:04:51 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/5] a standone-alone tool to directly share disk image
 file via vhost-user protocol
Date: Mon,  9 Mar 2020 18:03:41 +0800
Message-Id: <20200309100342.14921-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309100342.14921-1-coiby.xu@gmail.com>
References: <20200309100342.14921-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost-user-blk could have played as vhost-user backend but it only supports raw
file and don't support VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES
operations on raw file (ioctl(fd, BLKDISCARD) is only valid for real
block device).

Kevin's qemu-storage-daemon will be used to replace this
tool after his patches are merged into the mainline QEMU.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Makefile  |   4 +
 configure |   3 +
 qemu-vu.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 qemu-vu.c

diff --git a/Makefile b/Makefile
index 9d4b224126..6da192222d 100644
--- a/Makefile
+++ b/Makefile
@@ -585,6 +585,10 @@ qemu-img.o: qemu-img-cmds.h
 
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+
+ifdef CONFIG_LINUX
+qemu-vu$(EXESUF): qemu-vu.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+endif
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
diff --git a/configure b/configure
index fab6281eb7..53dd9fb88f 100755
--- a/configure
+++ b/configure
@@ -6318,6 +6318,9 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
+  if [ "$linux" = "yes" ] ; then
+    tools="qemu-vu\$(EXESUF) $tools"
+  fi
   if [ "$ivshmem" = "yes" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
diff --git a/qemu-vu.c b/qemu-vu.c
new file mode 100644
index 0000000000..3d2e4df5eb
--- /dev/null
+++ b/qemu-vu.c
@@ -0,0 +1,252 @@
+/*
+ *  Copyright (C) 2020  Coiby Xu <coiby.xu@gmail.com>
+ *
+ *  standone-alone vhost-user-blk device server backend
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; under version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include <getopt.h>
+#include <libgen.h>
+#include "block/export/vhost-user-blk-server.h"
+#include "block/block_int.h"
+#include "io/net-listener.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/config-file.h"
+#include "qemu/cutils.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu-common.h"
+#include "qemu-version.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/block-backend.h"
+#define QEMU_VU_OPT_CACHE         256
+#define QEMU_VU_OPT_AIO           257
+#define QEMU_VU_OBJ_ID   "vu_disk"
+static QemuOptsList qemu_object_opts = {
+    .name = "object",
+    .implied_opt_name = "qom-type",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
+    .desc = {
+        { }
+    },
+};
+static char *srcpath;
+
+static void usage(const char *name)
+{
+    (printf) (
+"Usage: %s [OPTIONS] FILE\n"
+"  or:  %s -L [OPTIONS]\n"
+"QEMU Vhost-user Server Utility\n"
+"\n"
+"  -h, --help                display this help and exit\n"
+"  -V, --version             output version information and exit\n"
+"\n"
+"Connection properties:\n"
+"  -k, --socket=PATH         path to the unix socket\n"
+"\n"
+"General purpose options:\n"
+"  -e, -- exit-panic         When the panic callback is called, the program\n"
+"                            will exit. Useful for make check-qtest.\n"
+"\n"
+"Block device options:\n"
+"  -f, --format=FORMAT       set image format (raw, qcow2, ...)\n"
+"  -r, --read-only           export read-only\n"
+"  -n, --nocache             disable host cache\n"
+"      --cache=MODE          set cache mode (none, writeback, ...)\n"
+"      --aio=MODE            set AIO mode (native or threads)\n"
+"\n"
+QEMU_HELP_BOTTOM "\n"
+    , name, name);
+}
+
+static void version(const char *name)
+{
+    printf(
+"%s " QEMU_FULL_VERSION "\n"
+"Written by Coiby Xu, based on qemu-nbd by Anthony Liguori\n"
+"\n"
+QEMU_COPYRIGHT "\n"
+"This is free software; see the source for copying conditions.  There is NO\n"
+"warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n"
+    , name);
+}
+
+static VuBlockDev *vu_block_device;
+
+static void vus_shutdown(void)
+{
+
+    Error *local_err = NULL;
+    job_cancel_sync_all();
+    bdrv_close_all();
+    user_creatable_del(QEMU_VU_OBJ_ID, &local_err);
+}
+
+int main(int argc, char **argv)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    bool readonly = false;
+    char *sockpath = NULL;
+    const char *sopt = "hVrnvek:f:";
+    struct option lopt[] = {
+        { "help", no_argument, NULL, 'h' },
+        { "version", no_argument, NULL, 'V' },
+        { "exit-panic", no_argument, NULL, 'e' },
+        { "socket", required_argument, NULL, 'k' },
+        { "read-only", no_argument, NULL, 'r' },
+        { "nocache", no_argument, NULL, 'n' },
+        { "cache", required_argument, NULL, QEMU_VU_OPT_CACHE },
+        { "aio", required_argument, NULL, QEMU_VU_OPT_AIO },
+        { "format", required_argument, NULL, 'f' },
+        { NULL, 0, NULL, 0 }
+    };
+    int ch;
+    int opt_ind = 0;
+    int flags = BDRV_O_RDWR;
+    bool seen_cache = false;
+    bool seen_aio = false;
+    const char *fmt = NULL;
+    Error *local_err = NULL;
+    QDict *options = NULL;
+    bool writethrough = true;
+    bool exit_when_panic = false;
+
+    error_init(argv[0]);
+
+    module_call_init(MODULE_INIT_QOM);
+    qemu_init_exec_dir(argv[0]);
+
+    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
+        switch (ch) {
+        case 'e':
+            exit_when_panic = true;
+            break;
+        case 'n':
+            optarg = (char *) "none";
+            /* fallthrough */
+        case QEMU_VU_OPT_CACHE:
+            if (seen_cache) {
+                error_report("-n and --cache can only be specified once");
+                exit(EXIT_FAILURE);
+            }
+            seen_cache = true;
+            if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) == -1) {
+                error_report("Invalid cache mode `%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case QEMU_VU_OPT_AIO:
+            if (seen_aio) {
+                error_report("--aio can only be specified once");
+                exit(EXIT_FAILURE);
+            }
+            seen_aio = true;
+            if (!strcmp(optarg, "native")) {
+                flags |= BDRV_O_NATIVE_AIO;
+            } else if (!strcmp(optarg, "threads")) {
+                /* this is the default */
+            } else {
+               error_report("invalid aio mode `%s'", optarg);
+               exit(EXIT_FAILURE);
+            }
+            break;
+        case 'r':
+            readonly = true;
+            flags &= ~BDRV_O_RDWR;
+            break;
+        case 'k':
+            sockpath = optarg;
+            if (sockpath[0] != '/') {
+                error_report("socket path must be absolute");
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 'f':
+            fmt = optarg;
+            break;
+        case 'V':
+            version(argv[0]);
+            exit(0);
+            break;
+        case 'h':
+            usage(argv[0]);
+            exit(0);
+            break;
+        case '?':
+            error_report("Try `%s --help' for more information.", argv[0]);
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    if ((argc - optind) != 1) {
+        error_report("Invalid number of arguments");
+        error_printf("Try `%s --help' for more information.\n", argv[0]);
+        exit(EXIT_FAILURE);
+    }
+    if (qemu_init_main_loop(&local_err)) {
+        error_report_err(local_err);
+        exit(EXIT_FAILURE);
+    }
+    bdrv_init();
+
+    srcpath = argv[optind];
+    if (fmt) {
+        options = qdict_new();
+        qdict_put_str(options, "driver", fmt);
+    }
+    blk = blk_new_open(srcpath, NULL, options, flags, &local_err);
+
+    if (!blk) {
+        error_reportf_err(local_err, "Failed to blk_new_open '%s': ",
+                          argv[optind]);
+        exit(EXIT_FAILURE);
+    }
+    bs = blk_bs(blk);
+
+    char buf[300];
+    snprintf(buf, 300, "%s,id=%s,node-name=%s,unix-socket=%s,writable=%s",
+             TYPE_VHOST_USER_BLK_SERVER, QEMU_VU_OBJ_ID, bdrv_get_node_name(bs),
+             sockpath, !readonly ? "on" : "off");
+    /* While calling user_creatable_del, 'object' group is required */
+    qemu_add_opts(&qemu_object_opts);
+    QemuOpts *opts = qemu_opts_parse(&qemu_object_opts, buf, true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        goto error;
+    }
+
+    Object *obj = user_creatable_add_opts(opts, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        goto error;
+    }
+
+    vu_block_device = VHOST_USER_BLK_SERVER(obj);
+    vu_block_device->exit_when_panic = exit_when_panic;
+
+    do {
+        main_loop_wait(false);
+    } while (!vu_block_device->exit_when_panic || !vu_block_device->vu_server->close);
+
+ error:
+    vus_shutdown();
+    exit(EXIT_SUCCESS);
+}
-- 
2.25.1


