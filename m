Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3300624656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeTJ9Ym5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3300624656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD2D-0000L9-Bp
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwCxA-0000Pf-7n
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwCx9-0003Gj-3Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwCx8-0003Fm-TV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQoCp+lsDv7BBjx8uaBMQWgkPzFniwH4ongsNqa/KJM=;
 b=WeTJ9Ym5+Z7dqDZb4pHYzpF/zcvexpltEHhKyCtCG8ChTZJXoCfJvEEGZ18nwIqnBhOVOk
 giK2h8wNHlqDNDYrqhRZExgN9cJKO6NehfPXgJCX61RW3zZ/J49fvukqgOdbAqIRgmCwtU
 srEgYob8+KlP6lO3u3w7bEiT33jjZm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-mXuJI8FwP2q0fK08CN_XFg-1; Mon, 27 Jan 2020 17:33:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7032A18C43C1;
 Mon, 27 Jan 2020 22:33:51 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEBBA451D;
 Mon, 27 Jan 2020 22:33:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] migration/multifd: fix nullptr access in
 multifd_send_terminate_threads
Date: Mon, 27 Jan 2020 23:33:09 +0100
Message-Id: <20200127223321.2742-8-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
References: <20200127223321.2742-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mXuJI8FwP2q0fK08CN_XFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Zhimin Feng <fengzhimin1@huawei.com>, Markus Armbruster <armbru@redhat.com>,
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


