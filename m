Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248AAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB88520708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQt1OW6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB88520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlRx-0005wf-4H
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKu-0002XJ-Qa
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKt-0006fP-Ky
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKR-0006Tv-Nl
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQoCp+lsDv7BBjx8uaBMQWgkPzFniwH4ongsNqa/KJM=;
 b=dQt1OW6JULjEI+FDVunLJyxchIRALS0C8pyr1ovYW0DEbg/7wZKpsM94m11k0nuDyQXuu/
 Nz2O2ECW2OdxI40PMXQW1NYxb/SszL8YisxuS4XHCbG/UMjow81iBrGNMcuRnWHid9TJuR
 k6Jn06c2Z13MxgVH21tB+xDGQ9ZGpf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-cLX84KbfNfKPfHX4YlKzBQ-1; Wed, 29 Jan 2020 06:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB168107B7F6;
 Wed, 29 Jan 2020 11:16:11 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94DBB89D2E;
 Wed, 29 Jan 2020 11:15:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] migration/multifd: fix nullptr access in
 multifd_send_terminate_threads
Date: Wed, 29 Jan 2020 12:15:25 +0100
Message-Id: <20200129111536.9497-8-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cLX84KbfNfKPfHX4YlKzBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Zhimin Feng <fengzhimin1@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhimin Feng <fengzhimin1@huawei.com>

If the multifd_send_threads is not created when migration is failed,
multifd_save_cleanup would be called twice. In this senario, the
multifd_send_state is accessed after it has been released, the result
is that the source VM is crashing down.

Here is the coredump stack:
    Program received signal SIGSEGV, Segmentation fault.
    0x00005629333a78ef in multifd_send_terminate_threads (err=3Derr@entry=
=3D0x0) at migration/ram.c:1012
    1012            MultiFDSendParams *p =3D &multifd_send_state->params[i]=
;
    #0  0x00005629333a78ef in multifd_send_terminate_threads (err=3Derr@ent=
ry=3D0x0) at migration/ram.c:1012
    #1  0x00005629333ab8a9 in multifd_save_cleanup () at migration/ram.c:10=
28
    #2  0x00005629333abaea in multifd_new_send_channel_async (task=3D0x5629=
35450e70, opaque=3D<optimized out>) at migration/ram.c:1202
    #3  0x000056293373a562 in qio_task_complete (task=3Dtask@entry=3D0x5629=
35450e70) at io/task.c:196
    #4  0x000056293373a6e0 in qio_task_thread_result (opaque=3D0x562935450e=
70) at io/task.c:111
    #5  0x00007f475d4d75a7 in g_idle_dispatch () from /usr/lib64/libglib-2.=
0.so.0
    #6  0x00007f475d4da9a9 in g_main_context_dispatch () from /usr/lib64/li=
bglib-2.0.so.0
    #7  0x0000562933785b33 in glib_pollfds_poll () at util/main-loop.c:219
    #8  os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loo=
p.c:242
    #9  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main-l=
oop.c:518
    #10 0x00005629334c5acf in main_loop () at vl.c:1810
    #11 0x000056293334d7bb in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4471

If the multifd_send_threads is not created when migration is failed.
In this senario, we don't call multifd_save_cleanup in multifd_new_send_cha=
nnel_async.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 3fd7fdffcf..82c7edb083 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1233,7 +1233,15 @@ static void multifd_new_send_channel_async(QIOTask *=
task, gpointer opaque)
     trace_multifd_new_send_channel_async(p->id);
     if (qio_task_propagate_error(task, &local_err)) {
         migrate_set_error(migrate_get_current(), local_err);
-        multifd_save_cleanup();
+        /* Error happen, we need to tell who pay attention to me */
+        qemu_sem_post(&multifd_send_state->channels_ready);
+        qemu_sem_post(&p->sem_sync);
+        /*
+         * Although multifd_send_thread is not created, but main migration
+         * thread neet to judge whether it is running, so we need to mark
+         * its status.
+         */
+        p->quit =3D true;
     } else {
         p->c =3D QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
--=20
2.24.1


