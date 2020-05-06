Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B9C47256
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 03:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D2A2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 03:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D2A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWAmT-0007AX-9U
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 23:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWAlT-0005fY-82
 for qemu-devel@nongnu.org; Tue, 05 May 2020 23:30:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47864 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWAlS-0006wo-5d
 for qemu-devel@nongnu.org; Tue, 05 May 2020 23:30:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C30DB8F4DD765A0971EB;
 Wed,  6 May 2020 11:30:15 +0800 (CST)
Received: from opensource.huawei.com (10.175.104.212) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 11:30:08 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 1/2] migration/multifd: fix memleaks in
 multifd_new_send_channel_async
Date: Wed, 6 May 2020 05:54:15 -0400
Message-ID: <20200506095416.26099-2-pannengyuan@huawei.com>
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

When error happen in multifd_new_send_channel_async, 'sioc' will not be used
to create the multifd_send_thread. Let's free it to avoid a memleak. And also
do error_free after migrate_set_error() to avoid another leak in the same place.

The leak stack:
Direct leak of 2880 byte(s) in 8 object(s) allocated from:
    #0 0x7f20b5118ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f20b44df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x564133bce18b in object_new_with_type /mnt/sdb/backup/qemu/qom/object.c:683
    #3 0x564133eea950 in qio_channel_socket_new /mnt/sdb/backup/qemu/io/channel-socket.c:56
    #4 0x5641339cfe4f in socket_send_channel_create /mnt/sdb/backup/qemu/migration/socket.c:37
    #5 0x564133a10328 in multifd_save_setup /mnt/sdb/backup/qemu/migration/multifd.c:772
    #6 0x5641339cebed in migrate_fd_connect /mnt/sdb/backup/qemu/migration/migration.c:3530
    #7 0x5641339d15e4 in migration_channel_connect /mnt/sdb/backup/qemu/migration/channel.c:92
    #8 0x5641339cf5b7 in socket_outgoing_migration /mnt/sdb/backup/qemu/migration/socket.c:108

Direct leak of 384 byte(s) in 8 object(s) allocated from:
    #0 0x7f20b5118cf0 in calloc (/lib64/libasan.so.5+0xefcf0)
    #1 0x7f20b44df22d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5322d)
    #2 0x56413406fc17 in error_setv /mnt/sdb/backup/qemu/util/error.c:61
    #3 0x564134070464 in error_setg_errno_internal /mnt/sdb/backup/qemu/util/error.c:109
    #4 0x5641340851be in inet_connect_addr /mnt/sdb/backup/qemu/util/qemu-sockets.c:379
    #5 0x5641340851be in inet_connect_saddr /mnt/sdb/backup/qemu/util/qemu-sockets.c:458
    #6 0x5641340870ab in socket_connect /mnt/sdb/backup/qemu/util/qemu-sockets.c:1105
    #7 0x564133eeaabf in qio_channel_socket_connect_sync /mnt/sdb/backup/qemu/io/channel-socket.c:145
    #8 0x564133eeabf5 in qio_channel_socket_connect_worker /mnt/sdb/backup/qemu/io/channel-socket.c:168

Indirect leak of 360 byte(s) in 8 object(s) allocated from:
    #0 0x7f20b5118ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f20af901817 in __GI___vasprintf_chk (/lib64/libc.so.6+0x10d817)
    #2 0x7f20b451fa6c in g_vasprintf (/lib64/libglib-2.0.so.0+0x93a6c)
    #3 0x7f20b44f8cd0 in g_strdup_vprintf (/lib64/libglib-2.0.so.0+0x6ccd0)
    #4 0x7f20b44f8d8c in g_strdup_printf (/lib64/libglib-2.0.so.0+0x6cd8c)
    #5 0x56413406fc86 in error_setv /mnt/sdb/backup/qemu/util/error.c:65
    #6 0x564134070464 in error_setg_errno_internal /mnt/sdb/backup/qemu/util/error.c:109
    #7 0x5641340851be in inet_connect_addr /mnt/sdb/backup/qemu/util/qemu-sockets.c:379
    #8 0x5641340851be in inet_connect_saddr /mnt/sdb/backup/qemu/util/qemu-sockets.c:458
    #9 0x5641340870ab in socket_connect /mnt/sdb/backup/qemu/util/qemu-sockets.c:1105
    #10 0x564133eeaabf in qio_channel_socket_connect_sync /mnt/sdb/backup/qemu/io/channel-socket.c:145
    #11 0x564133eeabf5 in qio_channel_socket_connect_worker /mnt/sdb/backup/qemu/io/channel-socket.c:168

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index cb6a4a3ab8..197d59294a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -727,6 +727,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
          * its status.
          */
         p->quit = true;
+        object_unref(OBJECT(sioc));
+        error_free(local_err);
     } else {
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
-- 
2.18.2


