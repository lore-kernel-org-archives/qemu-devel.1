Received: from eggs.gnu.org ([2001:4830:134:3::10]:57852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8L5-0007ip-4g
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8L4-0004NN-5O
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fI8L4-0004NH-0t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:10 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 May 2018 15:55:57 +0800
Message-Id: <1526284560-20266-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
References: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] net: Fix memory leak in net_param_nic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The early exits in case of errors leak the memory allocated for nd_id.
Fix it by using a "goto out" to the cleanup at the end of the function
instead.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/net.c b/net/net.c
index 29f8398..65457b7 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1502,11 +1502,12 @@ static int net_param_nic(void *dummy, QemuOpts *o=
pts, Error **errp)
         g_free(mac);
         if (ret) {
             error_setg(errp, "invalid syntax for ethernet address");
-            return -1;
+            goto out;
         }
         if (is_multicast_ether_addr(ni->macaddr.a)) {
             error_setg(errp, "NIC cannot have multicast MAC address");
-            return -1;
+            ret =3D -1;
+            goto out;
         }
     }
     qemu_macaddr_default_if_unset(&ni->macaddr);
@@ -1518,6 +1519,7 @@ static int net_param_nic(void *dummy, QemuOpts *opt=
s, Error **errp)
         nb_nics++;
     }
=20
+out:
     g_free(nd_id);
     return ret;
 }
--=20
2.7.4
