Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D6C2BC0E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B06320716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8wxX/89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B06320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjxD-0005Gh-EF
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuM-0008Kk-E9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:46 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuI-0003rW-Ch
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:46 -0400
Received: by mail-pj1-x1044.google.com with SMTP id mm21so1098948pjb.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=huTQukiVEQnbnV6oUpHw80TH1WL6GqzC6d5q3yiaZGo=;
 b=l8wxX/89oWmJ+w+iU3vMiZt+6q+eOpGBjvAPuNr4NRtO3yyQKof9+KPFKP3hG7Z5IY
 71aQn7fXvTxZQtisUlj5Rs3ogce/Ha5mtVg+cpUENx83Rv3V5/g1hsQp3d8XwKMbwyM2
 32wYu+DQVvgmAPwFuqZqkpFytUjMwbOwp5F0J/xrUllzdgsFRf3HzAKYszUKqExl7Ofx
 UwSilhsyrzWf8Y2aa921lBFBOOMa44xZA2pieGlBAv0dXZulDbJ5QB3IqfXL0cutx3oO
 qFHBzyNJCARG+pNgGdNpXbU1szGYkwgrSgRlKod8wNwuugPn4Gi/IOMjAyuz0Tl4Ls0S
 hrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=huTQukiVEQnbnV6oUpHw80TH1WL6GqzC6d5q3yiaZGo=;
 b=kyGHCz8Cy4AL7i333ck3TUFGN5OkCtLZ2npG+F94ZIE7uW3G4AZTP70jXCxzuvv5xr
 h6/tC5Mz7e25XSYjQIg5GQtwxFmXhiol4ffMxTyOZbqINsTkaepCy5X3lRW3FTmt2Fjl
 GSs0CT7aVq9ujFyGMBI5w8+bCeULAlM76beB3CraAAz+MoiHJYVVIIP63CUQMsY1kbgi
 HBEKKXp/oVMgDKBjL2V1ZKUlwg+ZTe+fXaIqzNaj6KkNtEP41VrTKNfjyvMGfXpKFbzN
 vJXUt+8OGdQyegvxsYB3QYAfk/mMU9ZtxhUsBlqv7PVHRb+17SxTzMzSZSJnBSjOJgSD
 IgAQ==
X-Gm-Message-State: AOAM531mDQ8usqNHXPeBwz4yvk1lT1/YYfvCgZ+PlcBFqFpppG0UZXtb
 7fQ/tkzgHpU4UyGPfiwYFG07dV/M755xhgtE
X-Google-Smtp-Source: ABdhPJxi5I3vbmjE7EHdfmTr3VoSQFncd3LDkgsP1epfOeOLwOo0iRUdoWa0Kg1ndZY2rO3CXDq3GA==
X-Received: by 2002:a17:90a:a088:: with SMTP id
 r8mr1959182pjp.73.1599119019797; 
 Thu, 03 Sep 2020 00:43:39 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/12] tests: handling signal on win32 properly
Date: Thu,  3 Sep 2020 15:43:05 +0800
Message-Id: <20200903074313.1498-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32

The error:
E:/CI-Cor-Ready/xemu/qemu.org/tests/test-replication.c:559:33: error: inval=
id use of undefined type 'struct sigaction'
  559 |     sigact =3D (struct sigaction) {
      |                                 ^

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 1214 +++++++++++++++++++-------------------
 1 file changed, 609 insertions(+), 605 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index e0b03dafc2..9ab3666a90 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -1,605 +1,609 @@
-/*
- * Block replication tests
- *
- * Copyright (c) 2016 FUJITSU LIMITED
- * Author: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * later.  See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-
-#include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qemu/option.h"
-#include "qemu/main-loop.h"
-#include "replication.h"
-#include "block/block_int.h"
-#include "block/qdict.h"
-#include "sysemu/block-backend.h"
-
-#define IMG_SIZE (64 * 1024 * 1024)
-
-/* primary */
-#define P_ID "primary-id"
-static char p_local_disk[] =3D "/tmp/p_local_disk.XXXXXX";
-
-/* secondary */
-#define S_ID "secondary-id"
-#define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] =3D "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] =3D "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] =3D "/tmp/s_hidden_disk.XXXXXX";
-
-/* FIXME: steal from blockdev.c */
-QemuOptsList qemu_drive_opts =3D {
-    .name =3D "drive",
-    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_drive_opts.head),
-    .desc =3D {
-        { /* end of list */ }
-    },
-};
-
-#define NOT_DONE 0x7fffffff
-
-static void blk_rw_done(void *opaque, int ret)
-{
-    *(int *)opaque =3D ret;
-}
-
-static void test_blk_read(BlockBackend *blk, long pattern,
-                          int64_t pattern_offset, int64_t pattern_count,
-                          int64_t offset, int64_t count,
-                          bool expect_failed)
-{
-    void *pattern_buf =3D NULL;
-    QEMUIOVector qiov;
-    void *cmp_buf =3D NULL;
-    int async_ret =3D NOT_DONE;
-
-    if (pattern) {
-        cmp_buf =3D g_malloc(pattern_count);
-        memset(cmp_buf, pattern, pattern_count);
-    }
-
-    pattern_buf =3D g_malloc(count);
-    if (pattern) {
-        memset(pattern_buf, pattern, count);
-    } else {
-        memset(pattern_buf, 0x00, count);
-    }
-
-    qemu_iovec_init(&qiov, 1);
-    qemu_iovec_add(&qiov, pattern_buf, count);
-
-    blk_aio_preadv(blk, offset, &qiov, 0, blk_rw_done, &async_ret);
-    while (async_ret =3D=3D NOT_DONE) {
-        main_loop_wait(false);
-    }
-
-    if (expect_failed) {
-        g_assert(async_ret !=3D 0);
-    } else {
-        g_assert(async_ret =3D=3D 0);
-        if (pattern) {
-            g_assert(memcmp(pattern_buf + pattern_offset,
-                            cmp_buf, pattern_count) <=3D 0);
-        }
-    }
-
-    g_free(pattern_buf);
-    g_free(cmp_buf);
-    qemu_iovec_destroy(&qiov);
-}
-
-static void test_blk_write(BlockBackend *blk, long pattern, int64_t offset,
-                           int64_t count, bool expect_failed)
-{
-    void *pattern_buf =3D NULL;
-    QEMUIOVector qiov;
-    int async_ret =3D NOT_DONE;
-
-    pattern_buf =3D g_malloc(count);
-    if (pattern) {
-        memset(pattern_buf, pattern, count);
-    } else {
-        memset(pattern_buf, 0x00, count);
-    }
-
-    qemu_iovec_init(&qiov, 1);
-    qemu_iovec_add(&qiov, pattern_buf, count);
-
-    blk_aio_pwritev(blk, offset, &qiov, 0, blk_rw_done, &async_ret);
-    while (async_ret =3D=3D NOT_DONE) {
-        main_loop_wait(false);
-    }
-
-    if (expect_failed) {
-        g_assert(async_ret !=3D 0);
-    } else {
-        g_assert(async_ret =3D=3D 0);
-    }
-
-    g_free(pattern_buf);
-    qemu_iovec_destroy(&qiov);
-}
-
-/*
- * Create a uniquely-named empty temporary file.
- */
-static void make_temp(char *template)
-{
-    int fd;
-
-    fd =3D mkstemp(template);
-    g_assert(fd >=3D 0);
-    close(fd);
-}
-
-static void prepare_imgs(void)
-{
-    make_temp(p_local_disk);
-    make_temp(s_local_disk);
-    make_temp(s_active_disk);
-    make_temp(s_hidden_disk);
-
-    /* Primary */
-    bdrv_img_create(p_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &error_abort);
-
-    /* Secondary */
-    bdrv_img_create(s_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &error_abort);
-    bdrv_img_create(s_active_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &error_abort);
-    bdrv_img_create(s_hidden_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, true, &error_abort);
-}
-
-static void cleanup_imgs(void)
-{
-    /* Primary */
-    unlink(p_local_disk);
-
-    /* Secondary */
-    unlink(s_local_disk);
-    unlink(s_active_disk);
-    unlink(s_hidden_disk);
-}
-
-static BlockBackend *start_primary(void)
-{
-    BlockBackend *blk;
-    QemuOpts *opts;
-    QDict *qdict;
-    char *cmdline;
-
-    cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dprimary,node-=
name=3Dxxx,"
-                              "file.driver=3Dqcow2,file.file.filename=3D%s=
,"
-                              "file.file.locking=3Doff"
-                              , p_local_disk);
-    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
-    g_free(cmdline);
-
-    qdict =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
-    qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
-
-    blk =3D blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);
-    g_assert(blk);
-
-    monitor_add_blk(blk, P_ID, &error_abort);
-
-    qemu_opts_del(opts);
-
-    return blk;
-}
-
-static void teardown_primary(void)
-{
-    BlockBackend *blk;
-    AioContext *ctx;
-
-    /* remove P_ID */
-    blk =3D blk_by_name(P_ID);
-    assert(blk);
-
-    ctx =3D blk_get_aio_context(blk);
-    aio_context_acquire(ctx);
-    monitor_remove_blk(blk);
-    blk_unref(blk);
-    aio_context_release(ctx);
-}
-
-static void test_primary_read(void)
-{
-    BlockBackend *blk;
-
-    blk =3D start_primary();
-
-    /* read from 0 to IMG_SIZE */
-    test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);
-
-    teardown_primary();
-}
-
-static void test_primary_write(void)
-{
-    BlockBackend *blk;
-
-    blk =3D start_primary();
-
-    /* write from 0 to IMG_SIZE */
-    test_blk_write(blk, 0, 0, IMG_SIZE, true);
-
-    teardown_primary();
-}
-
-static void test_primary_start(void)
-{
-    BlockBackend *blk =3D NULL;
-
-    blk =3D start_primary();
-
-    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
-
-    /* read from 0 to IMG_SIZE */
-    test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);
-
-    /* write 0x22 from 0 to IMG_SIZE */
-    test_blk_write(blk, 0x22, 0, IMG_SIZE, false);
-
-    teardown_primary();
-}
-
-static void test_primary_stop(void)
-{
-    bool failover =3D true;
-
-    start_primary();
-
-    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
-
-    replication_stop_all(failover, &error_abort);
-
-    teardown_primary();
-}
-
-static void test_primary_do_checkpoint(void)
-{
-    start_primary();
-
-    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
-
-    replication_do_checkpoint_all(&error_abort);
-
-    teardown_primary();
-}
-
-static void test_primary_get_error_all(void)
-{
-    start_primary();
-
-    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
-
-    replication_get_error_all(&error_abort);
-
-    teardown_primary();
-}
-
-static BlockBackend *start_secondary(void)
-{
-    QemuOpts *opts;
-    QDict *qdict;
-    BlockBackend *blk;
-    char *cmdline;
-
-    /* add s_local_disk and forge S_LOCAL_DISK_ID */
-    cmdline =3D g_strdup_printf("file.filename=3D%s,driver=3Dqcow2,"
-                              "file.locking=3Doff",
-                              s_local_disk);
-    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
-    g_free(cmdline);
-
-    qdict =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
-    qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
-
-    blk =3D blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);
-    assert(blk);
-    monitor_add_blk(blk, S_LOCAL_DISK_ID, &error_abort);
-
-    /* format s_local_disk with pattern "0x11" */
-    test_blk_write(blk, 0x11, 0, IMG_SIZE, false);
-
-    qemu_opts_del(opts);
-
-    /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
-    cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dsecondary,top=
-id=3D%s,"
-                              "file.driver=3Dqcow2,file.file.filename=3D%s=
,"
-                              "file.file.locking=3Doff,"
-                              "file.backing.driver=3Dqcow2,"
-                              "file.backing.file.filename=3D%s,"
-                              "file.backing.file.locking=3Doff,"
-                              "file.backing.backing=3D%s"
-                              , S_ID, s_active_disk, s_hidden_disk
-                              , S_LOCAL_DISK_ID);
-    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
-    g_free(cmdline);
-
-    qdict =3D qemu_opts_to_qdict(opts, NULL);
-    qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
-    qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
-
-    blk =3D blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);
-    assert(blk);
-    monitor_add_blk(blk, S_ID, &error_abort);
-
-    qemu_opts_del(opts);
-
-    return blk;
-}
-
-static void teardown_secondary(void)
-{
-    /* only need to destroy two BBs */
-    BlockBackend *blk;
-    AioContext *ctx;
-
-    /* remove S_LOCAL_DISK_ID */
-    blk =3D blk_by_name(S_LOCAL_DISK_ID);
-    assert(blk);
-
-    ctx =3D blk_get_aio_context(blk);
-    aio_context_acquire(ctx);
-    monitor_remove_blk(blk);
-    blk_unref(blk);
-    aio_context_release(ctx);
-
-    /* remove S_ID */
-    blk =3D blk_by_name(S_ID);
-    assert(blk);
-
-    ctx =3D blk_get_aio_context(blk);
-    aio_context_acquire(ctx);
-    monitor_remove_blk(blk);
-    blk_unref(blk);
-    aio_context_release(ctx);
-}
-
-static void test_secondary_read(void)
-{
-    BlockBackend *blk;
-
-    blk =3D start_secondary();
-
-    /* read from 0 to IMG_SIZE */
-    test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);
-
-    teardown_secondary();
-}
-
-static void test_secondary_write(void)
-{
-    BlockBackend *blk;
-
-    blk =3D start_secondary();
-
-    /* write from 0 to IMG_SIZE */
-    test_blk_write(blk, 0, 0, IMG_SIZE, true);
-
-    teardown_secondary();
-}
-
-static void test_secondary_start(void)
-{
-    BlockBackend *top_blk, *local_blk;
-    bool failover =3D true;
-
-    top_blk =3D start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
-
-    /* read from s_local_disk (0, IMG_SIZE) */
-    test_blk_read(top_blk, 0x11, 0, IMG_SIZE, 0, IMG_SIZE, false);
-
-    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
-    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
-    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);
-
-    /* replication will backup s_local_disk to s_hidden_disk */
-    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
-    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
-
-    /* read from s_active_disk (0, IMG_SIZE/2) */
-    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
-                  0, IMG_SIZE / 2, false);
-
-    /* unblock top_bs */
-    replication_stop_all(failover, &error_abort);
-
-    teardown_secondary();
-}
-
-
-static void test_secondary_stop(void)
-{
-    BlockBackend *top_blk, *local_blk;
-    bool failover =3D true;
-
-    top_blk =3D start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
-
-    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
-    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
-    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);
-
-    /* replication will backup s_local_disk to s_hidden_disk */
-    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
-    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
-
-    /* do active commit */
-    replication_stop_all(failover, &error_abort);
-
-    /* read from s_local_disk (0, IMG_SIZE / 2) */
-    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
-                  0, IMG_SIZE / 2, false);
-
-
-    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
-    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    teardown_secondary();
-}
-
-static void test_secondary_continuous_replication(void)
-{
-    BlockBackend *top_blk, *local_blk;
-
-    top_blk =3D start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
-
-    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
-    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
-    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);
-
-    /* replication will backup s_local_disk to s_hidden_disk */
-    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */
-    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);
-
-    /* do failover (active commit) */
-    replication_stop_all(true, &error_abort);
-
-    /* it should ignore all requests from now on */
-
-    /* start after failover */
-    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);
-
-    /* checkpoint */
-    replication_do_checkpoint_all(&error_abort);
-
-    /* stop */
-    replication_stop_all(true, &error_abort);
-
-    /* read from s_local_disk (0, IMG_SIZE / 2) */
-    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,
-                  0, IMG_SIZE / 2, false);
-
-
-    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
-    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    teardown_secondary();
-}
-
-static void test_secondary_do_checkpoint(void)
-{
-    BlockBackend *top_blk, *local_blk;
-    bool failover =3D true;
-
-    top_blk =3D start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
-
-    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */
-    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);
-    test_blk_write(local_blk, 0x22, IMG_SIZE / 2,
-                   IMG_SIZE / 2, false);
-
-    /* replication will backup s_local_disk to s_hidden_disk */
-    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    replication_do_checkpoint_all(&error_abort);
-
-    /* after checkpoint, read pattern 0x22 from s_local_disk */
-    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,
-                  IMG_SIZE / 2, 0, IMG_SIZE, false);
-
-    /* unblock top_bs */
-    replication_stop_all(failover, &error_abort);
-
-    teardown_secondary();
-}
-
-static void test_secondary_get_error_all(void)
-{
-    bool failover =3D true;
-
-    start_secondary();
-    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);
-
-    replication_get_error_all(&error_abort);
-
-    /* unblock top_bs */
-    replication_stop_all(failover, &error_abort);
-
-    teardown_secondary();
-}
-
-static void sigabrt_handler(int signo)
-{
-    cleanup_imgs();
-}
-
-static void setup_sigabrt_handler(void)
-{
-    struct sigaction sigact;
-
-    sigact =3D (struct sigaction) {
-        .sa_handler =3D sigabrt_handler,
-        .sa_flags =3D SA_RESETHAND,
-    };
-    sigemptyset(&sigact.sa_mask);
-    sigaction(SIGABRT, &sigact, NULL);
-}
-
-int main(int argc, char **argv)
-{
-    int ret;
-    qemu_init_main_loop(&error_fatal);
-    bdrv_init();
-
-    g_test_init(&argc, &argv, NULL);
-    setup_sigabrt_handler();
-
-    prepare_imgs();
-
-    /* Primary */
-    g_test_add_func("/replication/primary/read",    test_primary_read);
-    g_test_add_func("/replication/primary/write",   test_primary_write);
-    g_test_add_func("/replication/primary/start",   test_primary_start);
-    g_test_add_func("/replication/primary/stop",    test_primary_stop);
-    g_test_add_func("/replication/primary/do_checkpoint",
-                    test_primary_do_checkpoint);
-    g_test_add_func("/replication/primary/get_error_all",
-                    test_primary_get_error_all);
-
-    /* Secondary */
-    g_test_add_func("/replication/secondary/read",  test_secondary_read);
-    g_test_add_func("/replication/secondary/write", test_secondary_write);
-    g_test_add_func("/replication/secondary/start", test_secondary_start);
-    g_test_add_func("/replication/secondary/stop",  test_secondary_stop);
-    g_test_add_func("/replication/secondary/continuous_replication",
-                    test_secondary_continuous_replication);
-    g_test_add_func("/replication/secondary/do_checkpoint",
-                    test_secondary_do_checkpoint);
-    g_test_add_func("/replication/secondary/get_error_all",
-                    test_secondary_get_error_all);
-
-    ret =3D g_test_run();
-
-    cleanup_imgs();
-
-    return ret;
-}
+/*=0D
+ * Block replication tests=0D
+ *=0D
+ * Copyright (c) 2016 FUJITSU LIMITED=0D
+ * Author: Changlong Xie <xiecl.fnst@cn.fujitsu.com>=0D
+ *=0D
+ * This work is licensed under the terms of the GNU GPL, version 2 or=0D
+ * later.  See the COPYING file in the top-level directory.=0D
+ */=0D
+=0D
+#include "qemu/osdep.h"=0D
+=0D
+#include "qapi/error.h"=0D
+#include "qapi/qmp/qdict.h"=0D
+#include "qemu/option.h"=0D
+#include "qemu/main-loop.h"=0D
+#include "replication.h"=0D
+#include "block/block_int.h"=0D
+#include "block/qdict.h"=0D
+#include "sysemu/block-backend.h"=0D
+=0D
+#define IMG_SIZE (64 * 1024 * 1024)=0D
+=0D
+/* primary */=0D
+#define P_ID "primary-id"=0D
+static char p_local_disk[] =3D "/tmp/p_local_disk.XXXXXX";=0D
+=0D
+/* secondary */=0D
+#define S_ID "secondary-id"=0D
+#define S_LOCAL_DISK_ID "secondary-local-disk-id"=0D
+static char s_local_disk[] =3D "/tmp/s_local_disk.XXXXXX";=0D
+static char s_active_disk[] =3D "/tmp/s_active_disk.XXXXXX";=0D
+static char s_hidden_disk[] =3D "/tmp/s_hidden_disk.XXXXXX";=0D
+=0D
+/* FIXME: steal from blockdev.c */=0D
+QemuOptsList qemu_drive_opts =3D {=0D
+    .name =3D "drive",=0D
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_drive_opts.head),=0D
+    .desc =3D {=0D
+        { /* end of list */ }=0D
+    },=0D
+};=0D
+=0D
+#define NOT_DONE 0x7fffffff=0D
+=0D
+static void blk_rw_done(void *opaque, int ret)=0D
+{=0D
+    *(int *)opaque =3D ret;=0D
+}=0D
+=0D
+static void test_blk_read(BlockBackend *blk, long pattern,=0D
+                          int64_t pattern_offset, int64_t pattern_count,=0D
+                          int64_t offset, int64_t count,=0D
+                          bool expect_failed)=0D
+{=0D
+    void *pattern_buf =3D NULL;=0D
+    QEMUIOVector qiov;=0D
+    void *cmp_buf =3D NULL;=0D
+    int async_ret =3D NOT_DONE;=0D
+=0D
+    if (pattern) {=0D
+        cmp_buf =3D g_malloc(pattern_count);=0D
+        memset(cmp_buf, pattern, pattern_count);=0D
+    }=0D
+=0D
+    pattern_buf =3D g_malloc(count);=0D
+    if (pattern) {=0D
+        memset(pattern_buf, pattern, count);=0D
+    } else {=0D
+        memset(pattern_buf, 0x00, count);=0D
+    }=0D
+=0D
+    qemu_iovec_init(&qiov, 1);=0D
+    qemu_iovec_add(&qiov, pattern_buf, count);=0D
+=0D
+    blk_aio_preadv(blk, offset, &qiov, 0, blk_rw_done, &async_ret);=0D
+    while (async_ret =3D=3D NOT_DONE) {=0D
+        main_loop_wait(false);=0D
+    }=0D
+=0D
+    if (expect_failed) {=0D
+        g_assert(async_ret !=3D 0);=0D
+    } else {=0D
+        g_assert(async_ret =3D=3D 0);=0D
+        if (pattern) {=0D
+            g_assert(memcmp(pattern_buf + pattern_offset,=0D
+                            cmp_buf, pattern_count) <=3D 0);=0D
+        }=0D
+    }=0D
+=0D
+    g_free(pattern_buf);=0D
+    g_free(cmp_buf);=0D
+    qemu_iovec_destroy(&qiov);=0D
+}=0D
+=0D
+static void test_blk_write(BlockBackend *blk, long pattern, int64_t offset=
,=0D
+                           int64_t count, bool expect_failed)=0D
+{=0D
+    void *pattern_buf =3D NULL;=0D
+    QEMUIOVector qiov;=0D
+    int async_ret =3D NOT_DONE;=0D
+=0D
+    pattern_buf =3D g_malloc(count);=0D
+    if (pattern) {=0D
+        memset(pattern_buf, pattern, count);=0D
+    } else {=0D
+        memset(pattern_buf, 0x00, count);=0D
+    }=0D
+=0D
+    qemu_iovec_init(&qiov, 1);=0D
+    qemu_iovec_add(&qiov, pattern_buf, count);=0D
+=0D
+    blk_aio_pwritev(blk, offset, &qiov, 0, blk_rw_done, &async_ret);=0D
+    while (async_ret =3D=3D NOT_DONE) {=0D
+        main_loop_wait(false);=0D
+    }=0D
+=0D
+    if (expect_failed) {=0D
+        g_assert(async_ret !=3D 0);=0D
+    } else {=0D
+        g_assert(async_ret =3D=3D 0);=0D
+    }=0D
+=0D
+    g_free(pattern_buf);=0D
+    qemu_iovec_destroy(&qiov);=0D
+}=0D
+=0D
+/*=0D
+ * Create a uniquely-named empty temporary file.=0D
+ */=0D
+static void make_temp(char *template)=0D
+{=0D
+    int fd;=0D
+=0D
+    fd =3D mkstemp(template);=0D
+    g_assert(fd >=3D 0);=0D
+    close(fd);=0D
+}=0D
+=0D
+static void prepare_imgs(void)=0D
+{=0D
+    make_temp(p_local_disk);=0D
+    make_temp(s_local_disk);=0D
+    make_temp(s_active_disk);=0D
+    make_temp(s_hidden_disk);=0D
+=0D
+    /* Primary */=0D
+    bdrv_img_create(p_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,=0D
+                    BDRV_O_RDWR, true, &error_abort);=0D
+=0D
+    /* Secondary */=0D
+    bdrv_img_create(s_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,=0D
+                    BDRV_O_RDWR, true, &error_abort);=0D
+    bdrv_img_create(s_active_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,=0D
+                    BDRV_O_RDWR, true, &error_abort);=0D
+    bdrv_img_create(s_hidden_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,=0D
+                    BDRV_O_RDWR, true, &error_abort);=0D
+}=0D
+=0D
+static void cleanup_imgs(void)=0D
+{=0D
+    /* Primary */=0D
+    unlink(p_local_disk);=0D
+=0D
+    /* Secondary */=0D
+    unlink(s_local_disk);=0D
+    unlink(s_active_disk);=0D
+    unlink(s_hidden_disk);=0D
+}=0D
+=0D
+static BlockBackend *start_primary(void)=0D
+{=0D
+    BlockBackend *blk;=0D
+    QemuOpts *opts;=0D
+    QDict *qdict;=0D
+    char *cmdline;=0D
+=0D
+    cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dprimary,node-=
name=3Dxxx,"=0D
+                              "file.driver=3Dqcow2,file.file.filename=3D%s=
,"=0D
+                              "file.file.locking=3Doff"=0D
+                              , p_local_disk);=0D
+    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);=0D
+    g_free(cmdline);=0D
+=0D
+    qdict =3D qemu_opts_to_qdict(opts, NULL);=0D
+    qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");=0D
+    qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");=0D
+=0D
+    blk =3D blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);=0D
+    g_assert(blk);=0D
+=0D
+    monitor_add_blk(blk, P_ID, &error_abort);=0D
+=0D
+    qemu_opts_del(opts);=0D
+=0D
+    return blk;=0D
+}=0D
+=0D
+static void teardown_primary(void)=0D
+{=0D
+    BlockBackend *blk;=0D
+    AioContext *ctx;=0D
+=0D
+    /* remove P_ID */=0D
+    blk =3D blk_by_name(P_ID);=0D
+    assert(blk);=0D
+=0D
+    ctx =3D blk_get_aio_context(blk);=0D
+    aio_context_acquire(ctx);=0D
+    monitor_remove_blk(blk);=0D
+    blk_unref(blk);=0D
+    aio_context_release(ctx);=0D
+}=0D
+=0D
+static void test_primary_read(void)=0D
+{=0D
+    BlockBackend *blk;=0D
+=0D
+    blk =3D start_primary();=0D
+=0D
+    /* read from 0 to IMG_SIZE */=0D
+    test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);=0D
+=0D
+    teardown_primary();=0D
+}=0D
+=0D
+static void test_primary_write(void)=0D
+{=0D
+    BlockBackend *blk;=0D
+=0D
+    blk =3D start_primary();=0D
+=0D
+    /* write from 0 to IMG_SIZE */=0D
+    test_blk_write(blk, 0, 0, IMG_SIZE, true);=0D
+=0D
+    teardown_primary();=0D
+}=0D
+=0D
+static void test_primary_start(void)=0D
+{=0D
+    BlockBackend *blk =3D NULL;=0D
+=0D
+    blk =3D start_primary();=0D
+=0D
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);=0D
+=0D
+    /* read from 0 to IMG_SIZE */=0D
+    test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);=0D
+=0D
+    /* write 0x22 from 0 to IMG_SIZE */=0D
+    test_blk_write(blk, 0x22, 0, IMG_SIZE, false);=0D
+=0D
+    teardown_primary();=0D
+}=0D
+=0D
+static void test_primary_stop(void)=0D
+{=0D
+    bool failover =3D true;=0D
+=0D
+    start_primary();=0D
+=0D
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);=0D
+=0D
+    replication_stop_all(failover, &error_abort);=0D
+=0D
+    teardown_primary();=0D
+}=0D
+=0D
+static void test_primary_do_checkpoint(void)=0D
+{=0D
+    start_primary();=0D
+=0D
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);=0D
+=0D
+    replication_do_checkpoint_all(&error_abort);=0D
+=0D
+    teardown_primary();=0D
+}=0D
+=0D
+static void test_primary_get_error_all(void)=0D
+{=0D
+    start_primary();=0D
+=0D
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);=0D
+=0D
+    replication_get_error_all(&error_abort);=0D
+=0D
+    teardown_primary();=0D
+}=0D
+=0D
+static BlockBackend *start_secondary(void)=0D
+{=0D
+    QemuOpts *opts;=0D
+    QDict *qdict;=0D
+    BlockBackend *blk;=0D
+    char *cmdline;=0D
+=0D
+    /* add s_local_disk and forge S_LOCAL_DISK_ID */=0D
+    cmdline =3D g_strdup_printf("file.filename=3D%s,driver=3Dqcow2,"=0D
+                              "file.locking=3Doff",=0D
+                              s_local_disk);=0D
+    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);=0D
+    g_free(cmdline);=0D
+=0D
+    qdict =3D qemu_opts_to_qdict(opts, NULL);=0D
+    qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");=0D
+    qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");=0D
+=0D
+    blk =3D blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);=0D
+    assert(blk);=0D
+    monitor_add_blk(blk, S_LOCAL_DISK_ID, &error_abort);=0D
+=0D
+    /* format s_local_disk with pattern "0x11" */=0D
+    test_blk_write(blk, 0x11, 0, IMG_SIZE, false);=0D
+=0D
+    qemu_opts_del(opts);=0D
+=0D
+    /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */=0D
+    cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dsecondary,top=
-id=3D%s,"=0D
+                              "file.driver=3Dqcow2,file.file.filename=3D%s=
,"=0D
+                              "file.file.locking=3Doff,"=0D
+                              "file.backing.driver=3Dqcow2,"=0D
+                              "file.backing.file.filename=3D%s,"=0D
+                              "file.backing.file.locking=3Doff,"=0D
+                              "file.backing.backing=3D%s"=0D
+                              , S_ID, s_active_disk, s_hidden_disk=0D
+                              , S_LOCAL_DISK_ID);=0D
+    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);=0D
+    g_free(cmdline);=0D
+=0D
+    qdict =3D qemu_opts_to_qdict(opts, NULL);=0D
+    qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");=0D
+    qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");=0D
+=0D
+    blk =3D blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &error_abort);=0D
+    assert(blk);=0D
+    monitor_add_blk(blk, S_ID, &error_abort);=0D
+=0D
+    qemu_opts_del(opts);=0D
+=0D
+    return blk;=0D
+}=0D
+=0D
+static void teardown_secondary(void)=0D
+{=0D
+    /* only need to destroy two BBs */=0D
+    BlockBackend *blk;=0D
+    AioContext *ctx;=0D
+=0D
+    /* remove S_LOCAL_DISK_ID */=0D
+    blk =3D blk_by_name(S_LOCAL_DISK_ID);=0D
+    assert(blk);=0D
+=0D
+    ctx =3D blk_get_aio_context(blk);=0D
+    aio_context_acquire(ctx);=0D
+    monitor_remove_blk(blk);=0D
+    blk_unref(blk);=0D
+    aio_context_release(ctx);=0D
+=0D
+    /* remove S_ID */=0D
+    blk =3D blk_by_name(S_ID);=0D
+    assert(blk);=0D
+=0D
+    ctx =3D blk_get_aio_context(blk);=0D
+    aio_context_acquire(ctx);=0D
+    monitor_remove_blk(blk);=0D
+    blk_unref(blk);=0D
+    aio_context_release(ctx);=0D
+}=0D
+=0D
+static void test_secondary_read(void)=0D
+{=0D
+    BlockBackend *blk;=0D
+=0D
+    blk =3D start_secondary();=0D
+=0D
+    /* read from 0 to IMG_SIZE */=0D
+    test_blk_read(blk, 0, 0, IMG_SIZE, 0, IMG_SIZE, true);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+static void test_secondary_write(void)=0D
+{=0D
+    BlockBackend *blk;=0D
+=0D
+    blk =3D start_secondary();=0D
+=0D
+    /* write from 0 to IMG_SIZE */=0D
+    test_blk_write(blk, 0, 0, IMG_SIZE, true);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+static void test_secondary_start(void)=0D
+{=0D
+    BlockBackend *top_blk, *local_blk;=0D
+    bool failover =3D true;=0D
+=0D
+    top_blk =3D start_secondary();=0D
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);=0D
+=0D
+    /* read from s_local_disk (0, IMG_SIZE) */=0D
+    test_blk_read(top_blk, 0x11, 0, IMG_SIZE, 0, IMG_SIZE, false);=0D
+=0D
+    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */=0D
+    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);=0D
+    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);=0D
+=0D
+    /* replication will backup s_local_disk to s_hidden_disk */=0D
+    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */=0D
+    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);=0D
+=0D
+    /* read from s_active_disk (0, IMG_SIZE/2) */=0D
+    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,=0D
+                  0, IMG_SIZE / 2, false);=0D
+=0D
+    /* unblock top_bs */=0D
+    replication_stop_all(failover, &error_abort);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+=0D
+static void test_secondary_stop(void)=0D
+{=0D
+    BlockBackend *top_blk, *local_blk;=0D
+    bool failover =3D true;=0D
+=0D
+    top_blk =3D start_secondary();=0D
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);=0D
+=0D
+    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */=0D
+    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);=0D
+    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);=0D
+=0D
+    /* replication will backup s_local_disk to s_hidden_disk */=0D
+    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */=0D
+    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);=0D
+=0D
+    /* do active commit */=0D
+    replication_stop_all(failover, &error_abort);=0D
+=0D
+    /* read from s_local_disk (0, IMG_SIZE / 2) */=0D
+    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,=0D
+                  0, IMG_SIZE / 2, false);=0D
+=0D
+=0D
+    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */=0D
+    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+static void test_secondary_continuous_replication(void)=0D
+{=0D
+    BlockBackend *top_blk, *local_blk;=0D
+=0D
+    top_blk =3D start_secondary();=0D
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);=0D
+=0D
+    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */=0D
+    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);=0D
+    test_blk_write(local_blk, 0x22, IMG_SIZE / 2, IMG_SIZE / 2, false);=0D
+=0D
+    /* replication will backup s_local_disk to s_hidden_disk */=0D
+    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    /* write 0x33 to s_active_disk (0, IMG_SIZE / 2) */=0D
+    test_blk_write(top_blk, 0x33, 0, IMG_SIZE / 2, false);=0D
+=0D
+    /* do failover (active commit) */=0D
+    replication_stop_all(true, &error_abort);=0D
+=0D
+    /* it should ignore all requests from now on */=0D
+=0D
+    /* start after failover */=0D
+    replication_start_all(REPLICATION_MODE_PRIMARY, &error_abort);=0D
+=0D
+    /* checkpoint */=0D
+    replication_do_checkpoint_all(&error_abort);=0D
+=0D
+    /* stop */=0D
+    replication_stop_all(true, &error_abort);=0D
+=0D
+    /* read from s_local_disk (0, IMG_SIZE / 2) */=0D
+    test_blk_read(top_blk, 0x33, 0, IMG_SIZE / 2,=0D
+                  0, IMG_SIZE / 2, false);=0D
+=0D
+=0D
+    /* read from s_local_disk (IMG_SIZE / 2, IMG_SIZE) */=0D
+    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+static void test_secondary_do_checkpoint(void)=0D
+{=0D
+    BlockBackend *top_blk, *local_blk;=0D
+    bool failover =3D true;=0D
+=0D
+    top_blk =3D start_secondary();=0D
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);=0D
+=0D
+    /* write 0x22 to s_local_disk (IMG_SIZE / 2, IMG_SIZE) */=0D
+    local_blk =3D blk_by_name(S_LOCAL_DISK_ID);=0D
+    test_blk_write(local_blk, 0x22, IMG_SIZE / 2,=0D
+                   IMG_SIZE / 2, false);=0D
+=0D
+    /* replication will backup s_local_disk to s_hidden_disk */=0D
+    test_blk_read(top_blk, 0x11, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    replication_do_checkpoint_all(&error_abort);=0D
+=0D
+    /* after checkpoint, read pattern 0x22 from s_local_disk */=0D
+    test_blk_read(top_blk, 0x22, IMG_SIZE / 2,=0D
+                  IMG_SIZE / 2, 0, IMG_SIZE, false);=0D
+=0D
+    /* unblock top_bs */=0D
+    replication_stop_all(failover, &error_abort);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+static void test_secondary_get_error_all(void)=0D
+{=0D
+    bool failover =3D true;=0D
+=0D
+    start_secondary();=0D
+    replication_start_all(REPLICATION_MODE_SECONDARY, &error_abort);=0D
+=0D
+    replication_get_error_all(&error_abort);=0D
+=0D
+    /* unblock top_bs */=0D
+    replication_stop_all(failover, &error_abort);=0D
+=0D
+    teardown_secondary();=0D
+}=0D
+=0D
+static void sigabrt_handler(int signo)=0D
+{=0D
+    cleanup_imgs();=0D
+}=0D
+=0D
+static void setup_sigabrt_handler(void)=0D
+{=0D
+#ifdef _WIN32=0D
+    signal(SIGABRT, sigabrt_handler);=0D
+#else=0D
+    struct sigaction sigact;=0D
+=0D
+    sigact =3D (struct sigaction) {=0D
+        .sa_handler =3D sigabrt_handler,=0D
+        .sa_flags =3D SA_RESETHAND,=0D
+    };=0D
+    sigemptyset(&sigact.sa_mask);=0D
+    sigaction(SIGABRT, &sigact, NULL);=0D
+#endif=0D
+}=0D
+=0D
+int main(int argc, char **argv)=0D
+{=0D
+    int ret;=0D
+    qemu_init_main_loop(&error_fatal);=0D
+    bdrv_init();=0D
+=0D
+    g_test_init(&argc, &argv, NULL);=0D
+    setup_sigabrt_handler();=0D
+=0D
+    prepare_imgs();=0D
+=0D
+    /* Primary */=0D
+    g_test_add_func("/replication/primary/read",    test_primary_read);=0D
+    g_test_add_func("/replication/primary/write",   test_primary_write);=0D
+    g_test_add_func("/replication/primary/start",   test_primary_start);=0D
+    g_test_add_func("/replication/primary/stop",    test_primary_stop);=0D
+    g_test_add_func("/replication/primary/do_checkpoint",=0D
+                    test_primary_do_checkpoint);=0D
+    g_test_add_func("/replication/primary/get_error_all",=0D
+                    test_primary_get_error_all);=0D
+=0D
+    /* Secondary */=0D
+    g_test_add_func("/replication/secondary/read",  test_secondary_read);=
=0D
+    g_test_add_func("/replication/secondary/write", test_secondary_write);=
=0D
+    g_test_add_func("/replication/secondary/start", test_secondary_start);=
=0D
+    g_test_add_func("/replication/secondary/stop",  test_secondary_stop);=
=0D
+    g_test_add_func("/replication/secondary/continuous_replication",=0D
+                    test_secondary_continuous_replication);=0D
+    g_test_add_func("/replication/secondary/do_checkpoint",=0D
+                    test_secondary_do_checkpoint);=0D
+    g_test_add_func("/replication/secondary/get_error_all",=0D
+                    test_secondary_get_error_all);=0D
+=0D
+    ret =3D g_test_run();=0D
+=0D
+    cleanup_imgs();=0D
+=0D
+    return ret;=0D
+}=0D
--=20
2.28.0.windows.1


