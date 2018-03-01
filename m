Received: from eggs.gnu.org ([2001:4830:134:3::10]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLB-0006A1-V5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRL8-0000iO-KN
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRL8-0000hn-FC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:54 -0500
Date: Thu, 1 Mar 2018 18:45:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-2-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] vhost-user: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, linzhecheng <linzhecheng@huawei.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jason Wang <jasowang@redhat.com>

From: linzhecheng <linzhecheng@huawei.com>

g_free() was moved from vhost_net_cleanup in commit e6bcb1b, so we should
free net after vhost_net_cleanup

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau < marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 net/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index cb45512..d024573 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -109,6 +109,7 @@ static int vhost_user_start(int queues, NetClientStat=
e *ncs[], CharBackend *be)
 err:
     if (net) {
         vhost_net_cleanup(net);
+        g_free(net);
     }
     vhost_user_stop(i, ncs);
     return -1;
--=20
MST
