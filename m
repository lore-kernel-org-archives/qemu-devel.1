Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A6C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1F520578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1F520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsxM-0006PS-Sn
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:24:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQsq7-0000eG-R6
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQsq6-0002xE-N4
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hQsq6-0002w5-Fo
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D653BC057EC4
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-37.ams2.redhat.com
	[10.36.116.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCA705C1A3;
	Wed, 15 May 2019 12:16:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:15:44 +0200
Message-Id: <20190515121544.4597-9-quintela@redhat.com>
In-Reply-To: <20190515121544.4597-1-quintela@redhat.com>
References: <20190515121544.4597-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 15 May 2019 12:16:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 8/8] multifd: rest of zlib compression
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is still a work in progress, but get everything sent as expected
and it is faster than the code that is already there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fdb5bf07a5..efbb253c1a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -747,6 +747,100 @@ MultifdMethods multifd_none_ops =3D {
     .recv_pages =3D none_recv_pages
 };
=20
+/* Multifd zlib compression */
+
+static int zlib_send_prepare(MultiFDSendParams *p, uint32_t used)
+{
+    struct iovec *iov =3D p->pages->iov;
+    z_stream *zs =3D &p->zs;
+    uint32_t out_size =3D 0;
+    int ret;
+    int i;
+
+    for (i =3D 0; i < used; i++) {
+        uint32_t available =3D p->zbuff_len - out_size;
+        int flush =3D Z_NO_FLUSH;
+
+        if (i =3D=3D used  - 1) {
+            flush =3D Z_SYNC_FLUSH;
+        }
+
+        zs->avail_in =3D iov[i].iov_len;
+        zs->next_in =3D iov[i].iov_base;
+
+        zs->avail_out =3D available;
+        zs->next_out =3D p->zbuff + out_size;
+
+        ret =3D deflate(zs, flush);
+        if (ret !=3D Z_OK) {
+            printf("problem with deflate? %d\n", ret);
+            qemu_mutex_unlock(&p->mutex);
+            return -1;
+        }
+        out_size +=3D available - zs->avail_out;
+    }
+    p->next_packet_size =3D out_size;
+
+    return 0;
+}
+
+static int zlib_send_write(MultiFDSendParams *p, uint32_t used, Error **=
perr)
+{
+    return qio_channel_write_all(p->c, (void *)p->zbuff, p->next_packet_=
size,
+                                 perr);
+}
+
+static int zlib_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **=
perr)
+{
+    uint32_t in_size =3D p->next_packet_size;
+    uint32_t out_size =3D 0;
+    uint32_t expected_size =3D used * qemu_target_page_size();
+    z_stream *zs =3D &p->zs;
+    int ret;
+    int i;
+
+    ret =3D qio_channel_read_all(p->c, (void *)p->zbuff, in_size, perr);
+
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    zs->avail_in =3D in_size;
+    zs->next_in =3D p->zbuff;
+
+    for (i =3D 0; i < used; i++) {
+        struct iovec *iov =3D &p->pages->iov[i];
+        int flush =3D Z_NO_FLUSH;
+
+        if (i =3D=3D used  - 1) {
+            flush =3D Z_SYNC_FLUSH;
+        }
+
+        zs->avail_out =3D iov->iov_len;
+        zs->next_out =3D iov->iov_base;
+
+        ret =3D inflate(zs, flush);
+        if (ret !=3D Z_OK) {
+            printf("%d: problem with inflate? %d\n", p->id, ret);
+            qemu_mutex_unlock(&p->mutex);
+            return ret;
+        }
+        out_size +=3D iov->iov_len;
+    }
+    if (out_size !=3D expected_size) {
+        printf("out size %d expected size %d\n",
+               out_size, expected_size);
+        return -1;
+    }
+    return 0;
+}
+
+MultifdMethods multifd_zlib_ops =3D {
+    .send_prepare =3D zlib_send_prepare,
+    .send_write =3D zlib_send_write,
+    .recv_pages =3D zlib_recv_pages
+};
+
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
 {
     MultiFDInit_t msg;
@@ -1145,7 +1239,11 @@ static void *multifd_send_thread(void *opaque)
     /* initial packet */
     p->num_packets =3D 1;
=20
-    multifd_send_state->ops =3D &multifd_none_ops;
+    if (migrate_use_multifd_zlib()) {
+        multifd_send_state->ops =3D &multifd_zlib_ops;
+    } else {
+        multifd_send_state->ops =3D &multifd_none_ops;
+    }
=20
     while (true) {
         qemu_sem_wait(&p->sem);
@@ -1399,7 +1497,11 @@ static void *multifd_recv_thread(void *opaque)
     trace_multifd_recv_thread_start(p->id);
     rcu_register_thread();
=20
-    multifd_recv_state->ops =3D &multifd_none_ops;
+    if (migrate_use_multifd_zlib()) {
+        multifd_recv_state->ops =3D &multifd_zlib_ops;
+    } else {
+        multifd_recv_state->ops =3D &multifd_none_ops;
+    }
     while (true) {
         uint32_t used;
         uint32_t flags;
--=20
2.21.0


