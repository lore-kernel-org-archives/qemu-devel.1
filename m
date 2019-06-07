Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C5C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0662067C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0662067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNSn-0007ob-IJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZN7s-0002rU-0q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 18:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZN7q-0004JR-Dm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 18:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hZN7q-0004GX-4p
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 18:14:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D064308339A
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 22:14:17 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB544600C0;
 Fri,  7 Jun 2019 22:14:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 17:14:14 -0500
Message-Id: <20190607221414.15962-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 22:14:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] RFC: qio: Improve corking of TLS sessions
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current implementation of qio_channel_set_cork() is pointless for
TLS sessions: we block the underlying channel, but still hand things
piecemeal to gnutls which then produces multiple encryption packets.
Better is to directly use gnutls corking, which collects multiple
inputs into a single encryption packet.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

RFC because unfortunately, I'm not sure I like the results.  My test
case (using latest nbdkit.git) involves sending 10G of random data
over NBD using parallel writes (and doing nothing on the server end;
this is all about timing the data transfer):

$ dd if=3D/dev/urandom of=3Drand bs=3D1M count=3D10k
$ time nbdkit -p 10810 --tls=3Drequire --tls-verify-peer \
   --tls-psk=3D/tmp/keys.psk --filter=3Dstats null 10g statsfile=3D/dev/s=
tderr \
   --run '~/qemu/qemu-img convert -f raw -W -n --target-image-opts \
     --object tls-creds-psk,id=3Dtls0,endpoint=3Dclient,dir=3D/tmp,userna=
me=3Deblake \
     rand driver=3Dnbd,server.type=3Dinet,server.host=3Dlocalhost,server.=
port=3D10810,tls-creds=3Dtls0'

Pre-patch, I measured:
real	0m34.536s
user	0m29.264s
sys	0m4.014s

while post-patch, it changed to:
real	0m36.055s
user	0m27.685s
sys	0m10.138s

Less time spent in user space, but for this particular qemu-img
behavior (writing 2M chunks at a time), gnutls is now uncorking huge
packets and the kernel is doing enough extra work that the overall
program actually takes longer. :(

For smaller I/O patterns, the effects of corking are more likely to be
beneficial, but I don't have a ready test case to produce that pattern
(short of creating a guest running fio on a device backed by nbd).

Ideas for improvements are welcome; see my recent thread on the
libguestfs about how TCP_CORK is already a painful interface (it
requires additional syscalls), and that we may be better off teaching
qio_channel_writev about taking a flag similar to send(,MSG_MORE),
which can achieve the same effect as setsockopt(TCP_CORK) but in fewer
syscalls:
https://www.redhat.com/archives/libguestfs/2019-June/msg00078.html
https://www.redhat.com/archives/libguestfs/2019-June/msg00081.html

Another idea might be teaching channel-tls.c to be smarter about the
maximum size of data it is willing to cork, as well as to autocork
during writev (it's a shame that gnutls doesn't have a sendmsg
counterpart for sending vectors).  And after all, writev already
auto-corks for sockets, which is why we already went to the effort of
allowing clients to use writev-like interfaces to qio channels,
whether or not we also add in an ability to exploit MSG_MORE when we
have back-to-back writevs to further group where it makes sense.
---
 include/crypto/tlssession.h | 15 +++++++++++++++
 include/io/channel.h        |  4 ++--
 crypto/tlssession.c         | 16 ++++++++++++++++
 io/channel-socket.c         |  3 ++-
 io/channel-tls.c            |  9 ++++++---
 io/channel-websock.c        |  3 ++-
 io/channel.c                | 11 ++++++++++-
 7 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 1c7414e4ffdd..451f58c2c742 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -319,4 +319,19 @@ int qcrypto_tls_session_get_key_size(QCryptoTLSSessi=
on *sess,
  */
 char *qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess);

+/**
+ * qcrypto_tls_session_cork:
+ * @sess: the TLS session object
+ * @enabled: the desired cork status
+ *
+ * Update the cork status of the session. If @enabled is true, this is
+ * a hint that the next few writes should be batched together until
+ * the session is uncorked again. If false, then proceed to write
+ * batched data, and it is safe to call this in a loop in case
+ * flushing the queue would block.
+ *
+ * Returns: 0 for success, or -EAGAIN if uncorking is incomplete.
+ */
+int qcrypto_tls_session_cork(QCryptoTLSSession *sess, bool enabled);
+
 #endif /* QCRYPTO_TLSSESSION_H */
diff --git a/include/io/channel.h b/include/io/channel.h
index 59460cb1ec7a..e9565b9f7d65 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -129,8 +129,8 @@ struct QIOChannelClass {
     int (*io_shutdown)(QIOChannel *ioc,
                        QIOChannelShutdown how,
                        Error **errp);
-    void (*io_set_cork)(QIOChannel *ioc,
-                        bool enabled);
+    int (*io_set_cork)(QIOChannel *ioc,
+                       bool enabled);
     void (*io_set_delay)(QIOChannel *ioc,
                          bool enabled);
     off_t (*io_seek)(QIOChannel *ioc,
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index c3a920dfe80e..6ef5d9001375 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -547,6 +547,17 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession =
*session)
     return NULL;
 }

+int qcrypto_tls_session_cork(QCryptoTLSSession *session, bool enabled)
+{
+    return 0;
+    if (enabled) {
+        gnutls_record_cork(session->handle);
+    } else if (gnutls_record_uncork(session->handle, 0) < 0) {
+        return -EAGAIN;
+    }
+    return 0;
+}
+

 #else /* ! CONFIG_GNUTLS */

@@ -639,4 +650,9 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession *=
sess)
     return NULL;
 }

+int qcrypto_tls_session_cork(QCryptoTLSSession *sess, bool enabled)
+{
+    return 0;
+}
+
 #endif
diff --git a/io/channel-socket.c b/io/channel-socket.c
index bc5f80e780eb..44eb85cd2ba4 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -669,7 +669,7 @@ qio_channel_socket_set_delay(QIOChannel *ioc,
 }


-static void
+static int
 qio_channel_socket_set_cork(QIOChannel *ioc,
                             bool enabled)
 {
@@ -677,6 +677,7 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
     int v =3D enabled ? 1 : 0;

     socket_set_cork(sioc->fd, v);
+    return 0;
 }


diff --git a/io/channel-tls.c b/io/channel-tls.c
index c98ead21b01e..93162d5ecc85 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -346,12 +346,15 @@ static void qio_channel_tls_set_delay(QIOChannel *i=
oc,
     qio_channel_set_delay(tioc->master, enabled);
 }

-static void qio_channel_tls_set_cork(QIOChannel *ioc,
-                                     bool enabled)
+static int qio_channel_tls_set_cork(QIOChannel *ioc,
+                                    bool enabled)
 {
     QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);

-    qio_channel_set_cork(tioc->master, enabled);
+    if (qcrypto_tls_session_cork(tioc->session, enabled) =3D=3D -EAGAIN)=
 {
+        return QIO_CHANNEL_ERR_BLOCK;
+    }
+    return 0;
 }

 static int qio_channel_tls_shutdown(QIOChannel *ioc,
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 77d30f0e4aa4..a288e21a2a75 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -1186,12 +1186,13 @@ static void qio_channel_websock_set_delay(QIOChan=
nel *ioc,
     qio_channel_set_delay(tioc->master, enabled);
 }

-static void qio_channel_websock_set_cork(QIOChannel *ioc,
+static int qio_channel_websock_set_cork(QIOChannel *ioc,
                                          bool enabled)
 {
     QIOChannelWebsock *tioc =3D QIO_CHANNEL_WEBSOCK(ioc);

     qio_channel_set_cork(tioc->master, enabled);
+    return 0;
 }

 static int qio_channel_websock_shutdown(QIOChannel *ioc,
diff --git a/io/channel.c b/io/channel.c
index 2a26c2a2c0b9..3510912465ac 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -379,7 +379,16 @@ void qio_channel_set_cork(QIOChannel *ioc,
     QIOChannelClass *klass =3D QIO_CHANNEL_GET_CLASS(ioc);

     if (klass->io_set_cork) {
-        klass->io_set_cork(ioc, enabled);
+        int r =3D klass->io_set_cork(ioc, enabled);
+
+        while (r =3D=3D QIO_CHANNEL_ERR_BLOCK) {
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_OUT);
+            } else {
+                qio_channel_wait(ioc, G_IO_OUT);
+            }
+            r =3D klass->io_set_cork(ioc, enabled);
+        }
     }
 }

--=20
2.20.1


