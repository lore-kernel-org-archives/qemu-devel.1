Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B4EC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7D320721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7D320721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqUb-00074H-6p
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipq08-0007ta-3u
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipq06-0000Yf-M3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:50:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50740 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipq06-0008Sf-AY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:50:38 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5C936D408E790205BA53;
 Fri, 10 Jan 2020 16:50:30 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 16:50:23 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH] migration/multifd: fix nullptr access in
 multifd_send_terminate_threads
Date: Fri, 10 Jan 2020 16:50:19 +0800
Message-ID: <20200110085019.876-1-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Fri, 10 Jan 2020 04:20:35 -0500
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
Cc: Zhimin Feng <fengzhimin1@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the multifd_send_threads is not created when migration is failed,
multifd_save_cleanup would be called twice. In this senario, the
multifd_send_state is accessed after it has been released, the result
is that the source VM is crashing down.

Here is the coredump stack:
    Program received signal SIGSEGV, Segmentation fault.
    0x00005629333a78ef in multifd_send_terminate_threads (err=3Derr@entry=
=3D0x0) at migration/ram.c:1012
    1012            MultiFDSendParams *p =3D &multifd_send_state->params[=
i];
    #0  0x00005629333a78ef in multifd_send_terminate_threads (err=3Derr@e=
ntry=3D0x0) at migration/ram.c:1012
    #1  0x00005629333ab8a9 in multifd_save_cleanup () at migration/ram.c:=
1028
    #2  0x00005629333abaea in multifd_new_send_channel_async (task=3D0x56=
2935450e70, opaque=3D<optimized out>) at migration/ram.c:1202
    #3  0x000056293373a562 in qio_task_complete (task=3Dtask@entry=3D0x56=
2935450e70) at io/task.c:196
    #4  0x000056293373a6e0 in qio_task_thread_result (opaque=3D0x56293545=
0e70) at io/task.c:111
    #5  0x00007f475d4d75a7 in g_idle_dispatch () from /usr/lib64/libglib-=
2.0.so.0
    #6  0x00007f475d4da9a9 in g_main_context_dispatch () from /usr/lib64/=
libglib-2.0.so.0
    #7  0x0000562933785b33 in glib_pollfds_poll () at util/main-loop.c:21=
9
    #8  os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-l=
oop.c:242
    #9  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main=
-loop.c:518
    #10 0x00005629334c5acf in main_loop () at vl.c:1810
    #11 0x000056293334d7bb in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at vl.c:4471

If the multifd_send_threads is not created when migration is failed.
In this senario, we don't call multifd_save_cleanup in multifd_new_send_c=
hannel_async.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/ram.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 96feb40..f931279 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1200,7 +1200,15 @@ static void multifd_new_send_channel_async(QIOTask=
 *task, gpointer opaque)
     trace_multifd_new_send_channel_async(p->id);
     if (qio_task_propagate_error(task, &local_err)) {
         migrate_set_error(migrate_get_current(), local_err);
-        multifd_save_cleanup();
+        /* Error happen, we need to tell who pay attention to me */
+        qemu_sem_post(&multifd_send_state->channels_ready);
+        qemu_sem_post(&p->sem_sync);
+        /*
+         * Although multifd_send_thread is not created, but main migrati=
on
+         * thread neet to judge whether it is running, so we need to mar=
k
+         * its status.
+         */
+        p->quit =3D true;
     } else {
         p->c =3D QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
--=20
1.8.3.1



