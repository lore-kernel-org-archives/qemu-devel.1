Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOjp5-0004G2-Td
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOjoz-0002Ie-44
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:42:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gOjoy-0002Hu-TB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:42:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3077D30917A1
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 13:42:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 19 Nov 2018 13:42:28 +0000
Message-Id: <20181119134228.11031-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] io: return 0 for EOF in TLS session read after
 shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

GNUTLS takes a paranoid approach when seeing 0 bytes returned by the
underlying OS read() function. It will consider this an error and
return GNUTLS_E_PREMATURE_TERMINATION instead of propagating the 0
return value. It expects apps to arrange for clean termination at
the protocol level and not rely on seeing EOF from a read call to
detect shutdown. This is to harden apps against a malicious 3rd party
causing termination of the sockets layer.

This is unhelpful for the QEMU NBD code which does have a clean
protocol level shutdown, but still relies on seeing 0 from the I/O
channel read in the coroutine handling incoming replies.

The upshot is that when using a plain NBD connection shutdown is
silent, but when using TLS, the client spams the console with

  Cannot read from TLS channel: Broken pipe

The NBD connection has, however, called qio_channel_shutdown()
at this point to indicate that it is done with I/O. This gives
the opportunity to optimize the code such that when the channel
has been shutdown in the read direction, the error code
GNUTLS_E_PREMATURE_TERMINATION gets turned into a '0' return
instead of an error.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/tlssession.c      | 3 +++
 include/io/channel-tls.h | 1 +
 include/io/channel.h     | 6 +++---
 io/channel-tls.c         | 5 +++++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 2f28fa7f71..0dedd4af52 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -473,6 +473,9 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
         case GNUTLS_E_INTERRUPTED:
             errno =3D EINTR;
             break;
+        case GNUTLS_E_PREMATURE_TERMINATION:
+            errno =3D ECONNABORTED;
+            break;
         default:
             errno =3D EIO;
             break;
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 87fcaf9146..fdbdf12feb 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -48,6 +48,7 @@ struct QIOChannelTLS {
     QIOChannel parent;
     QIOChannel *master;
     QCryptoTLSSession *session;
+    QIOChannelShutdown shutdown;
 };
=20
 /**
diff --git a/include/io/channel.h b/include/io/channel.h
index e8cdadb0b0..da2f138200 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -51,9 +51,9 @@ enum QIOChannelFeature {
 typedef enum QIOChannelShutdown QIOChannelShutdown;
=20
 enum QIOChannelShutdown {
-    QIO_CHANNEL_SHUTDOWN_BOTH,
-    QIO_CHANNEL_SHUTDOWN_READ,
-    QIO_CHANNEL_SHUTDOWN_WRITE,
+    QIO_CHANNEL_SHUTDOWN_READ =3D 1,
+    QIO_CHANNEL_SHUTDOWN_WRITE =3D 2,
+    QIO_CHANNEL_SHUTDOWN_BOTH =3D 3,
 };
=20
 typedef gboolean (*QIOChannelFunc)(QIOChannel *ioc,
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 9628e6fa47..c98ead21b0 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -275,6 +275,9 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
                 } else {
                     return QIO_CHANNEL_ERR_BLOCK;
                 }
+            } else if (errno =3D=3D ECONNABORTED &&
+                       (tioc->shutdown & QIO_CHANNEL_SHUTDOWN_READ)) {
+                return 0;
             }
=20
             error_setg_errno(errp, errno,
@@ -357,6 +360,8 @@ static int qio_channel_tls_shutdown(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);
=20
+    tioc->shutdown |=3D how;
+
     return qio_channel_shutdown(tioc->master, how, errp);
 }
=20
--=20
2.19.1
