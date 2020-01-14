Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497A3C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FB224676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhDBw/9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FB224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irM2v-0003m2-3O
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLkB-00041a-Vb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLk5-0002FS-J9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLk5-0002FD-E1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCvNgXqg3YNciEEz4bwYVicJE+TkN+xTZTIh75LexRo=;
 b=NhDBw/9FkzHVHOZllh9jPOAHOVXP2XLTBEglvmYYar+JJwBbnIYVNOUuGMcHcQdUiWlD7a
 1iV1CZo8iyGKBw4wGoTor/A8nWWKfLDJFM7dYOn6Vr/xt/HuxFFOC24MF89UnRnDhXmZc0
 QD4ZSqWO/5ZAiAW46crrZL1gY6cWUKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-LgSCKFThNZqpzVtJSuMUPA-1; Tue, 14 Jan 2020 07:56:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68A85801E72;
 Tue, 14 Jan 2020 12:56:17 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFA415D9E5;
 Tue, 14 Jan 2020 12:56:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/30] migration/multifd: fix nullptr access in terminating
 multifd threads
Date: Tue, 14 Jan 2020 13:52:48 +0100
Message-Id: <20200114125254.4515-25-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
References: <20200114125254.4515-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LgSCKFThNZqpzVtJSuMUPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Jason Wang <jasowang@redhat.com>,
 Jiahui Cen <cenjiahui@huawei.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiahui Cen <cenjiahui@huawei.com>

One multifd channel will shutdown all the other multifd's IOChannel when it
fails to receive an IOChannel. In this senario, if some multifds had not
received its IOChannel yet, it would try to shutdown its IOChannel which co=
uld
cause nullptr access at qio_channel_shutdown.

Here is the coredump stack:
    #0  object_get_class (obj=3Dobj@entry=3D0x0) at qom/object.c:908
    #1  0x00005563fdbb8f4a in qio_channel_shutdown (ioc=3D0x0, how=3DQIO_CH=
ANNEL_SHUTDOWN_BOTH, errp=3D0x0) at io/channel.c:355
    #2  0x00005563fd7b4c5f in multifd_recv_terminate_threads (err=3D<optimi=
zed out>) at migration/ram.c:1280
    #3  0x00005563fd7bc019 in multifd_recv_new_channel (ioc=3Dioc@entry=3D0=
x556400255610, errp=3Derrp@entry=3D0x7ffec07dce00) at migration/ram.c:1478
    #4  0x00005563fda82177 in migration_ioc_process_incoming (ioc=3Dioc@ent=
ry=3D0x556400255610, errp=3Derrp@entry=3D0x7ffec07dce30) at migration/migra=
tion.c:605
    #5  0x00005563fda8567d in migration_channel_process_incoming (ioc=3D0x5=
56400255610) at migration/channel.c:44
    #6  0x00005563fda83ee0 in socket_accept_incoming_migration (listener=3D=
0x5563fff6b920, cioc=3D0x556400255610, opaque=3D<optimized out>) at migrati=
on/socket.c:166
    #7  0x00005563fdbc25cd in qio_net_listener_channel_func (ioc=3D<optimiz=
ed out>, condition=3D<optimized out>, opaque=3D<optimized out>) at io/net-l=
istener.c:54
    #8  0x00007f895b6fe9a9 in g_main_context_dispatch () from /usr/lib64/li=
bglib-2.0.so.0
    #9  0x00005563fdc18136 in glib_pollfds_poll () at util/main-loop.c:218
    #10 0x00005563fdc181b5 in os_host_main_loop_wait (timeout=3D1000000000)=
 at util/main-loop.c:241
    #11 0x00005563fdc183a2 in main_loop_wait (nonblocking=3Dnonblocking@ent=
ry=3D0) at util/main-loop.c:517
    #12 0x00005563fd8edb37 in main_loop () at vl.c:1791
    #13 0x00005563fd74fd45 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4473

To fix it up, let's check p->c before calling qio_channel_shutdown.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index aee057f7da..e7cd522173 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1308,7 +1308,9 @@ static void multifd_recv_terminate_threads(Error *err=
)
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
2.24.1


