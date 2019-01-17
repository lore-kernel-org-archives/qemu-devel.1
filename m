Received: from eggs.gnu.org ([209.51.188.92]:58081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67k-0006sN-G3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67j-00068M-RS
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk67j-00067v-L2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:56 +0400
Message-Id: <20190117114359.5164-25-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/27] slirp: remove slirp_instances list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Now that polling is done per-instance, we don't need a global list of
slirp instances.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 35630efe5db..98ff23723d9 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -48,9 +48,6 @@ static const uint8_t special_ethaddr[ETH_ALEN] =3D {
=20
 unsigned curtime;
=20
-static QTAILQ_HEAD(, Slirp) slirp_instances =3D
-    QTAILQ_HEAD_INITIALIZER(slirp_instances);
-
 static struct in_addr dns_addr;
 #ifndef _WIN32
 static struct in6_addr dns6_addr;
@@ -333,7 +330,6 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
 #ifdef WITH_QEMU
     slirp_state_register(slirp);
 #endif
-    QTAILQ_INSERT_TAIL(&slirp_instances, slirp, entry);
=20
     return slirp;
 }
@@ -348,7 +344,6 @@ void slirp_cleanup(Slirp *slirp)
         g_free(e);
     }
=20
-    QTAILQ_REMOVE(&slirp_instances, slirp, entry);
 #ifdef WITH_QEMU
     slirp_state_unregister(slirp);
 #endif
--=20
2.20.1.98.gecbdaf0899
