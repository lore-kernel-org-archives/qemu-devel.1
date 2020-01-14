Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C54C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8525D2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTps+s1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8525D2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMxF-0001Kg-NR
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1irMsh-0003O8-DA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1irMsf-0008BN-Og
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:09:19 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1irMsf-0008Au-Hv
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:09:17 -0500
Received: by mail-pg1-x542.google.com with SMTP id k197so6440439pga.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+o2xLjvifsgfa/4owhRKctXKFUi1fuVO/+UjjYkEsiY=;
 b=rTps+s1HILr49CSsa8JsYe9iQPcU9H7Go2nk6yfOE5IU9gf+WGFwSoPXo2j8Ijj+u0
 hsdAvGwxuh/jW2rUkuPmsN1kF/XeYfYUJAR39EdegTT4JueTVQp5HlAtapSKht/LsKT1
 BBVujYNKJxAWOEJZhyEESQibC+iCSP5QrYGKb8myfYFV9c2Idj0utt2TzZIL3uihVflK
 YI0X61nSFdlNWRW2CuV9tmoUyHUgu37Nx/6B7QTnO+syuWwlmIdwDzboiKk3LcAeYwoZ
 XdeWwxkQJf6v3zDhPb6eQw1bWJwd8PWN+gSa0gN0JUxsJezl9ED1umfK2EDLRrbsAbEU
 3zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+o2xLjvifsgfa/4owhRKctXKFUi1fuVO/+UjjYkEsiY=;
 b=RiBhMv9oVyfTuWljiUHTdNkL1PmyziEhNxPa98gmbnqMSnhUb0LeX43l+6c1xFGqjZ
 nc2HO8sx1Dq8GCvsMgi6BVTBYYWNYcpqJerWtnf9XjHCEfGC/BMB2TDpCjytUZZYkdv0
 PJDJQTbc0AURjd1CkRzJ5GoTVv9/dRlLddMgsrjOBRFdcBczfNTp3dxwtK3VZuCJthKH
 ovzGJJMVjAWn3FgdPO+FQfY+WJGGJKtdfeDeFYOgenDchE4zuFq55LzrViXOWcXlxn7y
 GBnre/x4NtjVpxBz9bWu/eRlaaQkZlatWBKDvpwEgwUOETlqSVx+RHbE79csz1sVIShG
 aPkA==
X-Gm-Message-State: APjAAAVurOq3DAkDOynVCy5piPe19Nw+PBdCoPtbPCHdhm9N//qZLt0q
 QmZSx1yjA4xABY1XaO6GtcnfzDi6hreSBg==
X-Google-Smtp-Source: APXvYqy9zdN2rwFup0b/mUBSq8YUwEYFlZyQIvaerB7xFOqlCRawvBuO5BhR0c4kYRhlQDhkVrtbZw==
X-Received: by 2002:a63:5162:: with SMTP id r34mr27675600pgl.227.1579010956172; 
 Tue, 14 Jan 2020 06:09:16 -0800 (PST)
Received: from localhost.localdomain ([175.124.145.172])
 by smtp.googlemail.com with ESMTPSA id a17sm17264773pjv.6.2020.01.14.06.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 06:09:15 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] a standone-alone tool to directly share disk image
 file via vhost-user protocol
Date: Tue, 14 Jan 2020 22:06:18 +0800
Message-Id: <20200114140620.10385-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114140620.10385-1-coiby.xu@gmail.com>
References: <20200114140620.10385-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

vhost-user-blk can have played as vhost-user backend but it only supports raw file and don't support VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES operations on raw file (ioctl(fd, BLKDISCARD) is only valid for real block device).

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 qemu-vu.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)
 create mode 100644 qemu-vu.c

diff --git a/qemu-vu.c b/qemu-vu.c
new file mode 100644
index 0000000000..25c32c2c6d
--- /dev/null
+++ b/qemu-vu.c
@@ -0,0 +1,264 @@
+/*
+ *  Copyright (C) 2020  Coiby Xu <coiby.xu@gmail.com>
+ *
+ *  Vhost-user-blk device backend
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
+#include "block/vhost-user.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "sysemu/block-backend.h"
+#include "block/block_int.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/error-report.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qom/object_interfaces.h"
+#include "io/net-listener.h"
+#include "qemu-version.h"
+
+#define QEMU_VU_OPT_CACHE         256
+
+#define QEMU_VU_OPT_AIO           257
+
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
+static VubDev *vub_device;
+
+static void vus_shutdown(void)
+{
+    job_cancel_sync_all();
+    bdrv_close_all();
+    vub_free(vub_device, false);
+}
+
+int main(int argc, char **argv)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    bool readonly = false;
+    char *sockpath = NULL;
+    int64_t fd_size;
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
+    bool exit_panic = false;
+
+    error_init(argv[0]);
+
+    module_call_init(MODULE_INIT_QOM);
+    qemu_init_exec_dir(argv[0]);
+
+    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
+        switch (ch) {
+        case 'e':
+            exit_panic = true;
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
+
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
+    blk_set_enable_write_cache(blk, !writethrough);
+
+    fd_size = blk_getlength(blk);
+    if (fd_size < 0) {
+        error_report("Failed to determine the image length: %s",
+                     strerror(-fd_size));
+        exit(EXIT_FAILURE);
+    }
+
+    AioContext *ctx = bdrv_get_aio_context(bs);
+    bdrv_invalidate_cache(bs, NULL);
+
+    vub_device = g_new0(VubDev, 1);
+    vub_device->unix_socket = g_strdup(sockpath);
+    vub_device->writable = !readonly;
+    vub_device->blkcfg.wce = !writethrough;
+    vub_device->backend = blk;
+    vub_device->ctx = ctx;
+    vub_initialize_config(bs, &vub_device->blkcfg);
+    vub_device->listener = qio_net_listener_new();
+    vub_device->exit_panic = exit_panic;
+
+    qio_net_listener_set_name(vub_device->listener,
+                              "vhost-user-backend-listener");
+
+    SocketAddress *addr = g_new0(SocketAddress, 1);
+    addr->u.q_unix.path = (char *) sockpath;
+    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    Error **errp = NULL;
+    if (qio_net_listener_open_sync(vub_device->listener, addr, 1, errp) < 0) {
+        goto error;
+    }
+
+    qio_net_listener_set_client_func(vub_device->listener,
+                                     vub_accept,
+                                     vub_device,
+                                     NULL);
+
+    QTAILQ_INIT(&vub_device->clients);
+
+    do {
+        main_loop_wait(false);
+    } while (!vub_device->exit_panic || !vub_device->close);
+
+ error:
+    vus_shutdown();
+    exit(EXIT_SUCCESS);
+}
--
2.24.1


