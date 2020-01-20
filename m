Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B371C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527A0207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUchL9yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527A0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUpc-00004r-K9
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itUQi-0007ZJ-5P
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itUQf-000365-OT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itUQf-00035l-Jp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sF9PT3VudShxE0wmWXTxFC1tzz8+9eCtUOBba9umQls=;
 b=UUchL9yXrRNuggqPkqsc/GXBQNNYHXrlZ9l2fgaKcIgzUTNtMAlP/PaHVJTiwyGf6wSYuA
 xUQvLrWNBFUY1ZZmRY/aCgu0NQTh4h+PYT2m8eI7iu2GG6UpbHjo1uF9JmOaFghhbu57c/
 drEyNWKQA7+rgeFFYDcuNgziHejx4xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-xz6a7gZ1MsqCyzkwvAzoWQ-1; Mon, 20 Jan 2020 05:37:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97870802563;
 Mon, 20 Jan 2020 10:37:05 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 210FF1BC6D;
 Mon, 20 Jan 2020 10:36:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] migration/multifd: fix destroyed mutex access in
 terminating multifd threads
Date: Mon, 20 Jan 2020 11:33:34 +0100
Message-Id: <20200120103340.25118-24-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xz6a7gZ1MsqCyzkwvAzoWQ-1
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Jiahui Cen <cenjiahui@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiahui Cen <cenjiahui@huawei.com>

One multifd will lock all the other multifds' IOChannel mutex to inform the=
m
to quit by setting p->quit or shutting down p->c. In this senario, if some
multifds had already been terminated and multifd_load_cleanup/multifd_save_=
cleanup
had destroyed their mutex, it could cause destroyed mutex access when tryin=
g
lock their mutex.

Here is the coredump stack:
    #0  0x00007f81a2794437 in raise () from /usr/lib64/libc.so.6
    #1  0x00007f81a2795b28 in abort () from /usr/lib64/libc.so.6
    #2  0x00007f81a278d1b6 in __assert_fail_base () from /usr/lib64/libc.so=
.6
    #3  0x00007f81a278d262 in __assert_fail () from /usr/lib64/libc.so.6
    #4  0x000055eb1bfadbd3 in qemu_mutex_lock_impl (mutex=3D0x55eb1e2d1988,=
 file=3D<optimized out>, line=3D<optimized out>) at util/qemu-thread-posix.=
c:64
    #5  0x000055eb1bb4564a in multifd_send_terminate_threads (err=3D<optimi=
zed out>) at migration/ram.c:1015
    #6  0x000055eb1bb4bb7f in multifd_send_thread (opaque=3D0x55eb1e2d19f8)=
 at migration/ram.c:1171
    #7  0x000055eb1bfad628 in qemu_thread_start (args=3D0x55eb1e170450) at =
util/qemu-thread-posix.c:502
    #8  0x00007f81a2b36df5 in start_thread () from /usr/lib64/libpthread.so=
.0
    #9  0x00007f81a286048d in clone () from /usr/lib64/libc.so.6

To fix it up, let's destroy the mutex after all the other multifd threads h=
ad
been terminated.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 278b2ff87a..7221f54139 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1053,6 +1053,10 @@ void multifd_save_cleanup(void)
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
@@ -1336,6 +1340,10 @@ int multifd_load_cleanup(Error **errp)
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
2.24.1


