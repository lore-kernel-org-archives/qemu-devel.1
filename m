Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EAFCA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927B8214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927B8214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN7e5-0006aL-PF
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cenjiahui@huawei.com>) id 1iN7dM-0005tG-Tk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cenjiahui@huawei.com>) id 1iN7dL-0005gl-HB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:48:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53700 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cenjiahui@huawei.com>)
 id 1iN7dL-0005fw-6v
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:48:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 35A227F6A93A8B086DAF;
 Wed, 23 Oct 2019 11:48:22 +0800 (CST)
Received: from localhost (10.173.220.89) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 11:48:11 +0800
From: cenjiahui <cenjiahui@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 2/3] migration/multifd: fix destroyed mutex access in
 terminating multifd threads
Date: Wed, 23 Oct 2019 11:47:37 +0800
Message-ID: <20191023034738.10309-2-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191023034738.10309-1-cenjiahui@huawei.com>
References: <20191023034738.10309-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.89]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: fangying1@huawei.com, Jiahui Cen <cenjiahui@huawei.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, zhouyibo3@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiahui Cen <cenjiahui@huawei.com>

One multifd will lock all the other multifds' IOChannel mutex to inform t=
hem
to quit by setting p->quit or shutting down p->c. In this senario, if som=
e
multifds had already been terminated and multifd_load_cleanup/multifd_sav=
e_cleanup
had destroyed their mutex, it could cause destroyed mutex access when try=
ing
lock their mutex.

Here is the coredump stack:
    #0  0x00007f81a2794437 in raise () from /usr/lib64/libc.so.6
    #1  0x00007f81a2795b28 in abort () from /usr/lib64/libc.so.6
    #2  0x00007f81a278d1b6 in __assert_fail_base () from /usr/lib64/libc.=
so.6
    #3  0x00007f81a278d262 in __assert_fail () from /usr/lib64/libc.so.6
    #4  0x000055eb1bfadbd3 in qemu_mutex_lock_impl (mutex=3D0x55eb1e2d198=
8, file=3D<optimized out>, line=3D<optimized out>) at util/qemu-thread-po=
six.c:64
    #5  0x000055eb1bb4564a in multifd_send_terminate_threads (err=3D<opti=
mized out>) at migration/ram.c:1015
    #6  0x000055eb1bb4bb7f in multifd_send_thread (opaque=3D0x55eb1e2d19f=
8) at migration/ram.c:1171
    #7  0x000055eb1bfad628 in qemu_thread_start (args=3D0x55eb1e170450) a=
t util/qemu-thread-posix.c:502
    #8  0x00007f81a2b36df5 in start_thread () from /usr/lib64/libpthread.=
so.0
    #9  0x00007f81a286048d in clone () from /usr/lib64/libc.so.6

To fix it up, let's destroy the mutex after all the other multifd threads=
 had
been terminated.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 migration/ram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index dc63692..24a8906 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1032,6 +1032,10 @@ void multifd_save_cleanup(void)
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
         socket_send_channel_destroy(p->c);
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
@@ -1308,6 +1312,10 @@ int multifd_load_cleanup(Error **errp)
             qemu_sem_post(&p->sem_sync);
             qemu_thread_join(&p->thread);
         }
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
         object_unref(OBJECT(p->c));
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
--=20
1.8.3.1



