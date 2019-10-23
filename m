Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E76CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 04:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626C12064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 04:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626C12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN8Iq-0008Tt-F7
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 00:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cenjiahui@huawei.com>) id 1iN8IA-00082P-Pk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 00:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cenjiahui@huawei.com>) id 1iN8I9-0005kc-EJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 00:30:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2181 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cenjiahui@huawei.com>)
 id 1iN8I9-0005hG-30
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 00:30:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2AB8EFCEF0CF53FA6933;
 Wed, 23 Oct 2019 12:30:32 +0800 (CST)
Received: from localhost (10.173.220.89) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 12:30:26 +0800
From: cenjiahui <cenjiahui@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 1/3] migration/multifd: fix nullptr access in terminating
 multifd threads
Date: Wed, 23 Oct 2019 12:30:02 +0800
Message-ID: <20191023043002.8788-1-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.89]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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

One multifd channel will shutdown all the other multifd's IOChannel when =
it
fails to receive an IOChannel. In this senario, if some multifds had not
received its IOChannel yet, it would try to shutdown its IOChannel which =
could
cause nullptr access at qio_channel_shutdown.

Here is the coredump stack:
    #0  object_get_class (obj=3Dobj@entry=3D0x0) at qom/object.c:908
    #1  0x00005563fdbb8f4a in qio_channel_shutdown (ioc=3D0x0, how=3DQIO_=
CHANNEL_SHUTDOWN_BOTH, errp=3D0x0) at io/channel.c:355
    #2  0x00005563fd7b4c5f in multifd_recv_terminate_threads (err=3D<opti=
mized out>) at migration/ram.c:1280
    #3  0x00005563fd7bc019 in multifd_recv_new_channel (ioc=3Dioc@entry=3D=
0x556400255610, errp=3Derrp@entry=3D0x7ffec07dce00) at migration/ram.c:14=
78
    #4  0x00005563fda82177 in migration_ioc_process_incoming (ioc=3Dioc@e=
ntry=3D0x556400255610, errp=3Derrp@entry=3D0x7ffec07dce30) at migration/m=
igration.c:605
    #5  0x00005563fda8567d in migration_channel_process_incoming (ioc=3D0=
x556400255610) at migration/channel.c:44
    #6  0x00005563fda83ee0 in socket_accept_incoming_migration (listener=3D=
0x5563fff6b920, cioc=3D0x556400255610, opaque=3D<optimized out>) at migra=
tion/socket.c:166
    #7  0x00005563fdbc25cd in qio_net_listener_channel_func (ioc=3D<optim=
ized out>, condition=3D<optimized out>, opaque=3D<optimized out>) at io/n=
et-listener.c:54
    #8  0x00007f895b6fe9a9 in g_main_context_dispatch () from /usr/lib64/=
libglib-2.0.so.0
    #9  0x00005563fdc18136 in glib_pollfds_poll () at util/main-loop.c:21=
8
    #10 0x00005563fdc181b5 in os_host_main_loop_wait (timeout=3D100000000=
0) at util/main-loop.c:241
    #11 0x00005563fdc183a2 in main_loop_wait (nonblocking=3Dnonblocking@e=
ntry=3D0) at util/main-loop.c:517
    #12 0x00005563fd8edb37 in main_loop () at vl.c:1791
    #13 0x00005563fd74fd45 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at vl.c:4473

To fix it up, let's check p->c before calling qio_channel_shutdown.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94..dc63692 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1280,7 +1280,9 @@ static void multifd_recv_terminate_threads(Error *e=
rr)
            - normal quit, i.e. everything went fine, just finished
            - error quit: We close the channels so the channel threads
              finish the qio_channel_read_all_eof() */
-        qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        if (p->c) {
+            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        }
         qemu_mutex_unlock(&p->mutex);
     }
 }
--=20
1.8.3.1



