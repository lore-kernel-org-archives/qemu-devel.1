Received: from eggs.gnu.org ([209.51.188.92]:45502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOS-0004v6-Pj
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOR-00078D-Oh
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOR-00073h-GR
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:20 +0100
Message-Id: <20190130073426.11525-3-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/8] usb: dev-mtp: close fd in
 usb_mtp_object_readdir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Spotted by Coverity: CID 1397070

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190103133113.49599-1-liq3ea@163.com

[ kraxel: dropped chunk which adds close() after successful
          fdopendir() call, that is not needed according to
          POSIX even though Coverity flags it as bug ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 68c5eb8eaa..837c9d9449 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -666,6 +666,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPOb=
ject *o)
     }
     dir =3D fdopendir(fd);
     if (!dir) {
+        close(fd);
         return;
     }
 #ifdef CONFIG_INOTIFY1
--=20
2.9.3
