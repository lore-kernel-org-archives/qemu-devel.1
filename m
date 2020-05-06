Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 03:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5ED02073B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 03:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ED02073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWAmR-000760-0v
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 23:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWAlR-0005fK-RZ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 23:30:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47866 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWAlQ-0006ws-9G
 for qemu-devel@nongnu.org; Tue, 05 May 2020 23:30:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CAEFA667C04D7198064D;
 Wed,  6 May 2020 11:30:15 +0800 (CST)
Received: from opensource.huawei.com (10.175.104.212) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 11:30:09 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 2/2] migration/multifd: Do error_free after migrate_set_error
 to avoid memleaks
Date: Wed, 6 May 2020 05:54:16 -0400
Message-ID: <20200506095416.26099-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200506095416.26099-1-pannengyuan@huawei.com>
References: <20200506095416.26099-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:30:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When error happen in multifd_send_thread, it use error_copy to set migrate error in
multifd_send_terminate_threads(). We should call error_free after it.

Similarly, fix another two places in multifd_recv_thread/multifd_save_cleanup.

The leak stack:
Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f781af07cf0 in calloc (/lib64/libasan.so.5+0xefcf0)
    #1 0x7f781a2ce22d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5322d)
    #2 0x55ee1d075c17 in error_setv /mnt/sdb/backup/qemu/util/error.c:61
    #3 0x55ee1d076464 in error_setg_errno_internal /mnt/sdb/backup/qemu/util/error.c:109
    #4 0x55ee1cef066e in qio_channel_socket_writev /mnt/sdb/backup/qemu/io/channel-socket.c:569
    #5 0x55ee1cee806b in qio_channel_writev /mnt/sdb/backup/qemu/io/channel.c:207
    #6 0x55ee1cee806b in qio_channel_writev_all /mnt/sdb/backup/qemu/io/channel.c:171
    #7 0x55ee1cee8248 in qio_channel_write_all /mnt/sdb/backup/qemu/io/channel.c:257
    #8 0x55ee1ca12c9a in multifd_send_thread /mnt/sdb/backup/qemu/migration/multifd.c:657
    #9 0x55ee1d0607fc in qemu_thread_start /mnt/sdb/backup/qemu/util/qemu-thread-posix.c:519
    #10 0x7f78159ae2dd in start_thread (/lib64/libpthread.so.0+0x82dd)
    #11 0x7f78156df4b2 in __GI___clone (/lib64/libc.so.6+0xfc4b2)

Indirect leak of 52 byte(s) in 1 object(s) allocated from:
    #0 0x7f781af07f28 in __interceptor_realloc (/lib64/libasan.so.5+0xeff28)
    #1 0x7f78156f07d9 in __GI___vasprintf_chk (/lib64/libc.so.6+0x10d7d9)
    #2 0x7f781a30ea6c in g_vasprintf (/lib64/libglib-2.0.so.0+0x93a6c)
    #3 0x7f781a2e7cd0 in g_strdup_vprintf (/lib64/libglib-2.0.so.0+0x6ccd0)
    #4 0x7f781a2e7d8c in g_strdup_printf (/lib64/libglib-2.0.so.0+0x6cd8c)
    #5 0x55ee1d075c86 in error_setv /mnt/sdb/backup/qemu/util/error.c:65
    #6 0x55ee1d076464 in error_setg_errno_internal /mnt/sdb/backup/qemu/util/error.c:109
    #7 0x55ee1cef066e in qio_channel_socket_writev /mnt/sdb/backup/qemu/io/channel-socket.c:569
    #8 0x55ee1cee806b in qio_channel_writev /mnt/sdb/backup/qemu/io/channel.c:207
    #9 0x55ee1cee806b in qio_channel_writev_all /mnt/sdb/backup/qemu/io/channel.c:171
    #10 0x55ee1cee8248 in qio_channel_write_all /mnt/sdb/backup/qemu/io/channel.c:257
    #11 0x55ee1ca12c9a in multifd_send_thread /mnt/sdb/backup/qemu/migration/multifd.c:657
    #12 0x55ee1d0607fc in qemu_thread_start /mnt/sdb/backup/qemu/util/qemu-thread-posix.c:519
    #13 0x7f78159ae2dd in start_thread (/lib64/libpthread.so.0+0x82dd)
    #14 0x7f78156df4b2 in __GI___clone (/lib64/libc.so.6+0xfc4b2)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 migration/multifd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 197d59294a..35ae3180d2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -550,6 +550,7 @@ void multifd_save_cleanup(void)
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
+            error_free(local_err);
         }
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
@@ -688,6 +689,7 @@ out:
     if (local_err) {
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
+        error_free(local_err);
     }
 
     /*
@@ -965,6 +967,7 @@ static void *multifd_recv_thread(void *opaque)
 
     if (local_err) {
         multifd_recv_terminate_threads(local_err);
+        error_free(local_err);
     }
     qemu_mutex_lock(&p->mutex);
     p->running = false;
-- 
2.18.2


