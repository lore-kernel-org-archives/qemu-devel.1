Received: from eggs.gnu.org ([209.51.188.92]:60853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj5CN-00025a-UP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj5CM-0001zM-DF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 14 Jan 2019 16:34:15 +0000
Message-Id: <20190114163416.1094-2-stefanha@redhat.com>
In-Reply-To: <20190114163416.1094-1-stefanha@redhat.com>
References: <20190114163416.1094-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] aio-posix: Unregister fd from ctx epoll
 when removing fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Remy Noel <remy.noel@blade-group.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Remy Noel <remy.noel@blade-group.com>

Cleaning the events will cause aio_epoll_update to unregister the fd.
Otherwise, the fd is kept registered until it is destroyed.

Signed-off-by: Remy Noel <remy.noel@blade-group.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20181220152030.28035-2-remy.noel@blade-group.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 51c41ed3c9..a927319d2c 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -245,6 +245,9 @@ void aio_set_fd_handler(AioContext *ctx,
             QLIST_REMOVE(node, node);
             deleted =3D true;
         }
+        /* Clean events in order to unregister fd from the ctx epoll. */
+        node->pfd.events =3D 0;
+
         poll_disable_change =3D -!node->io_poll;
     } else {
         poll_disable_change =3D !io_poll - (node && !node->io_poll);
--=20
2.20.1
