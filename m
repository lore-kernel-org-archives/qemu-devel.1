Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jy1-0007uV-Db
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jy0-0006c2-Gy
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:36:45 -0400
Date: Fri, 5 May 2017 17:36:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505203620.GN3482@thinpad.lan.raisama.net>
References: <20170503203604.31462-1-ehabkost@redhat.com>
	<20170503203604.31462-3-ehabkost@redhat.com>
	<20170505093622.37902dea.cornelia.huck@de.ibm.com>
	<20170505165419.GF3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505165419.GF3482@thinpad.lan.raisama.net>
Subject: [Qemu-devel] [PATCH] fixup! sysbus: Set user_creatable=false by
 default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Juergen Gross <jgross@suse.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Rob Herring <robh@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>, sstabellini@kernel.org, Yi Min Zhao <zyimin@linux.vnet.ibm.com>


On Fri, May 05, 2017 at 01:54:19PM -0300, Eduardo Habkost wrote:
> On Fri, May 05, 2017 at 09:36:22AM +0200, Cornelia Huck wrote:
> [...]
> > > diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> > > index c0f560b289..6a2eec8dd0 100644
> > > --- a/hw/core/sysbus.c
> > > +++ b/hw/core/sysbus.c
> > > @@ -326,6 +326,17 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
> > >      DeviceClass *k = DEVICE_CLASS(klass);
> > >      k->init = sysbus_device_init;
> > >      k->bus_type = TYPE_SYSTEM_BUS;
> > > +    /*
> > > +     * device_add plugs devices into suitable bus.  For "real" buses,
> > 
> > s/suitable/a suitable/
> 
> Thanks, I will fix it.
> 
> > 
> > > +     * that actually connects the device.  For sysbus, the connections
> > > +     * need to be made separately, and device_add can't do that.  The
> > > +     * device would be left unconnected, and will probably not work
> > > +     *
> > > +     * However, a few machines and a few devices can handle a few sysbus
> > > +     * devices. In this case, the device subclass needs to override
> > 
> > Should that rather be "a few machines can handle a few specific sysbus
> > devices"?
> 
> I will extend it to "a few machines can handle device_add for a
> few specific sysbus devices". Thanks for spotting it.

Fixup will be included in v3, or can be applied by maintainer:

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/sysbus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 6a2eec8dd0..5d0887f499 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -327,14 +327,14 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
     k->init = sysbus_device_init;
     k->bus_type = TYPE_SYSTEM_BUS;
     /*
-     * device_add plugs devices into suitable bus.  For "real" buses,
+     * device_add plugs devices into a suitable bus.  For "real" buses,
      * that actually connects the device.  For sysbus, the connections
      * need to be made separately, and device_add can't do that.  The
      * device would be left unconnected, and will probably not work
      *
-     * However, a few machines and a few devices can handle a few sysbus
-     * devices. In this case, the device subclass needs to override
-     * it and set user_creatable=true.
+     * However, a few machines can handle device_add/-device with
+     * a few specific sysbus devices. In those cases, the device
+     * subclass needs to override it and set user_creatable=true.
      */
     k->user_creatable = false;
 }
-- 
2.11.0.259.g40922b1
