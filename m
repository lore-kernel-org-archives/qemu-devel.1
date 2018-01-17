Received: from eggs.gnu.org ([2001:4830:134:3::10]:53797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eblBJ-0000lV-Lx
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eblBF-0004Kj-Mn
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:42:57 -0500
Date: Wed, 17 Jan 2018 10:41:43 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20180117104143.vjykdxqayagvi7a6@starbug-vm.ie.oracle.com>
References: <20180117005222.4781-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180117005222.4781-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb-storage: Fix share-rw option parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

The code changes look good. 

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Wed, Jan 17, 2018 at 08:52:22AM +0800, Fam Zheng wrote:
>Because usb-storage creates an internal scsi device, we should propagate
>options. We already do so for bootindex etc, but failed to take care of
>share-rw. Fix it in an apparent way: add a new parameter to
>scsi_bus_legacy_add_drive and pass in s->conf.share_rw.
>
>Cc: qemu-stable@nongnu.org
>Signed-off-by: Fam Zheng <famz@redhat.com>
>
>---
>
>v2: Rebase to master.
>---
> hw/scsi/scsi-bus.c     | 9 ++++++++-
> hw/usb/dev-storage.c   | 3 ++-
> include/hw/scsi/scsi.h | 1 +
> 3 files changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>index 965becf31f..05e501efd3 100644
>--- a/hw/scsi/scsi-bus.c
>+++ b/hw/scsi/scsi-bus.c
>@@ -224,6 +224,7 @@ static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
> /* handle legacy '-drive if=scsi,...' cmd line args */
> SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>                                       int unit, bool removable, int bootindex,
>+                                      bool share_rw,
>                                       const char *serial, Error **errp)
> {
>     const char *driver;
>@@ -254,6 +255,12 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>         object_unparent(OBJECT(dev));
>         return NULL;
>     }
>+    object_property_set_bool(OBJECT(dev), share_rw, "share-rw", &err);
>+    if (err != NULL) {
>+        error_propagate(errp, err);
>+        object_unparent(OBJECT(dev));
>+        return NULL;
>+    }
>     object_property_set_bool(OBJECT(dev), true, "realized", &err);
>     if (err != NULL) {
>         error_propagate(errp, err);
>@@ -288,7 +295,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated)
>             }
>         }
>         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
>-                                  unit, false, -1, NULL, &error_fatal);
>+                                  unit, false, -1, false, NULL, &error_fatal);
>     }
>     loc_pop(&loc);
> }
>diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
>index 9722ac854c..80c03eff35 100644
>--- a/hw/usb/dev-storage.c
>+++ b/hw/usb/dev-storage.c
>@@ -633,7 +633,8 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
>     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>                  &usb_msd_scsi_info_storage, NULL);
>     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
>-                                         s->conf.bootindex, dev->serial,
>+                                         s->conf.bootindex, s->conf.share_rw,
>+                                         dev->serial,
>                                          errp);
>     blk_unref(blk);
>     if (!scsi_dev) {
>diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
>index 23a8ee6a7d..802a647cdc 100644
>--- a/include/hw/scsi/scsi.h
>+++ b/include/hw/scsi/scsi.h
>@@ -151,6 +151,7 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
>
> SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>                                       int unit, bool removable, int bootindex,
>+                                      bool share_rw,
>                                       const char *serial, Error **errp);
> void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated);
> void scsi_legacy_handle_cmdline(void);
>-- 
>2.14.3
>
>
