Received: from eggs.gnu.org ([2001:4830:134:3::10]:60755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8g0-000322-6G
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8fv-000228-IR
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8fv-00021Z-6L
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:43 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:09 +0800
Message-Id: <1504836324-4871-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/18] net/rocker: Plug memory leak in
 pci_rocker_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

pci_rocker_init() leaks a World when the name more than 9 chars,
then return a negative value directly, doesn't make a correct
cleanup. So add a new goto label to fix it.

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rocker/rocker.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 7496752..9a538a9 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1355,7 +1355,8 @@ static int pci_rocker_init(PCIDevice *dev)
         fprintf(stderr,
                 "rocker: name too long; please shorten to at most %d cha=
rs\n",
                 MAX_ROCKER_NAME_LEN);
-        return -EINVAL;
+        err =3D -EINVAL;
+        goto err_name_too_long;
     }
=20
     if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) =3D=3D 0) {
@@ -1414,6 +1415,7 @@ static int pci_rocker_init(PCIDevice *dev)
=20
     return 0;
=20
+err_name_too_long:
 err_duplicate:
     rocker_msix_uninit(r);
 err_msix_init:
--=20
2.7.4
