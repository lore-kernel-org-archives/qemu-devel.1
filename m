Received: from eggs.gnu.org ([2001:4830:134:3::10]:37008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68r-0005bN-MA
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68o-0004S0-FD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du68o-0004RY-8c
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:54 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Sep 2017 20:11:35 -0400
Message-Id: <20170919001147.23182-3-jsnow@redhat.com>
In-Reply-To: <20170919001147.23182-1-jsnow@redhat.com>
References: <20170919001147.23182-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] ide: ahci: unparent children buses before
 freeing their memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Fixes read after freeing error reported
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04243.html
  Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>

ich9-ahci device creates ide buses and attaches them as QOM children
at realize time, however it forgets to properly clean them up
at unrealize time and frees memory containing these children,
with following call-chain:

   qdev_device_add()
     object_property_set_bool('realized', true)
       device_set_realized()
          ...
          pci_qdev_realize() -> pci_ich9_ahci_realize() -> ahci_realize()
               ...
               s->dev =3D g_new0(AHCIDevice, ports);
               ...
                  AHCIDevice *ad =3D &s->dev[i];
                  ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
                  ^^^ creates bus in memory allocated by above gnew()
                      and adds it as child propety to ahci device
          ...
          hotplug_handler_plug(); -> goto post_realize_fail;
          pci_qdev_unrealize() -> pci_ich9_uninit() -> ahci_uninit()
              ...
               g_free(s->dev);
               ^^^ free memory that holds children busses

          return with error from device_set_realized()

As result later when qdev_device_add() tries to unparent ich9-ahci
after failed device_set_realized(),
    object_unparent() -> object_property_del_child()
iterates over existing QOM children including buses added by
ide_bus_new() and tries to unparent them, which causes access to
freed memory where they where located.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 1503938085-169486-1-git-send-email-imammedo@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 406a1b5..ccbe091 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1495,6 +1495,7 @@ void ahci_uninit(AHCIState *s)
=20
             ide_exit(s);
         }
+        object_unparent(OBJECT(&ad->port));
     }
=20
     g_free(s->dev);
--=20
2.9.5
