Received: from eggs.gnu.org ([2001:4830:134:3::10]:54337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRU-0002Rz-LC
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRT-0000gh-TF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:00 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 16 Nov 2018 15:53:21 +0000
Message-Id: <20181116155325.22428-3-berrange@redhat.com>
In-Reply-To: <20181116155325.22428-1-berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6 for-3.1] nbd: stop waiting for a NBD
 response with NBD_CMD_DISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When sending a NBD_CMD_DISC message there is no reply expected,
however, the nbd_read_eof() coroutine is still waiting for a reply.
In a plain NBD connection this doesn't matter as it will just get an
EOF, however, on a TLS connection it will get an interrupted TLS data
packet. The nbd_read_eof() will then print an error message on the
console due to missing reply to NBD_CMD_DISC.

This can be seen with qemu-img

  $ qemu-img info \
      --object tls-creds-x509,dir=3Dtlsdir,id=3Dtls0,endpoint=3Dclient \
      --image-opts driver=3Dnbd,host=3D127.0.0.1,port=3D9000,tls-creds=3D=
tls0
  qemu-img: Cannot read from TLS channel: Input/output error
  image: nbd://127.0.0.1:9000
  file format: nbd
  virtual size: 10M (10485760 bytes)
  disk size: unavailable

Simply setting the 'quit' flag after sending NBD_CMD_DISC is enough to
get the coroutine to stop waiting for a reply and thus supress the error
message. This fixes a regression introduced in

  commit be41c100c0d67f6072ddd4910c4b6f7d239f025f
  Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
  Date:   Fri May 26 14:09:13 2017 +0300

    nbd/client.c: use errp instead of LOG

    Move to modern errp scheme from just LOGging errors.

    Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
    Message-Id: <20170526110913.89098-1-vsementsov@virtuozzo.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/nbd-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 76e9ca3abe..5f63e4b8f1 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -961,6 +961,7 @@ void nbd_client_close(BlockDriverState *bs)
     }
=20
     nbd_send_request(client->ioc, &request);
+    client->quit =3D true;
=20
     nbd_teardown_connection(bs);
 }
--=20
2.19.1
