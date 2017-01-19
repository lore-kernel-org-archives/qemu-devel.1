Received: from eggs.gnu.org ([2001:4830:134:3::10]:34553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUHp6-0004Hr-P1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUHp2-0002xY-TZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:52:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUHp2-0002xQ-Lg
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:52:32 -0500
Date: Thu, 19 Jan 2017 18:52:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170119185225.GJ2085@work-vm>
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
	<1484566314-3987-4-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484566314-3987-4-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/5] migration: Allow "device add"
 options to only add migratable devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Introduce checks for the unmigratable flag in the VMStateDescription
> structs of respective devices when user attempts to add them. If the
> "--only-migratable" was specified, all unmigratable devices will
> rightly fail to add. This feature is made compatible for both "-device"
> and "-usbdevice" command line options and covers their hmp and qmp
> counterparts as well.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/usb/bus.c   | 19 +++++++++++++++++++
>  qdev-monitor.c |  9 +++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 25913ad..1dcc35c 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -8,6 +8,7 @@
>  #include "monitor/monitor.h"
>  #include "trace.h"
>  #include "qemu/cutils.h"
> +#include "migration/migration.h"
>  
>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
>  
> @@ -686,6 +687,8 @@ USBDevice *usbdevice_create(const char *cmdline)
>      const char *params;
>      int len;
>      USBDevice *dev;
> +    ObjectClass *klass;
> +    DeviceClass *dc;
>  
>      params = strchr(cmdline,':');
>      if (params) {
> @@ -720,6 +723,22 @@ USBDevice *usbdevice_create(const char *cmdline)
>          return NULL;
>      }
>  
> +    klass = object_class_by_name(f->name);
> +    if (klass == NULL) {
> +        error_report("Device '%s' not found", f->name);
> +        return NULL;
> +    }
> +
> +    dc = DEVICE_CLASS(klass);
> +
> +    if (only_migratable) {
> +        if (dc->vmsd->unmigratable) {
> +            error_report("Device %s is not migratable, but --only-migratable "
> +                         "was specified", f->name);
> +            return NULL;
> +        }
> +    }
> +
>      if (f->usbdevice_init) {
>          dev = f->usbdevice_init(bus, params);
>      } else {
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index c73410c..81d01df 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -29,6 +29,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/help_option.h"
>  #include "sysemu/block-backend.h"
> +#include "migration/migration.h"
>  
>  /*
>   * Aliases were a bad idea from the start.  Let's keep them
> @@ -577,6 +578,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>          return NULL;
>      }
>  
> +    if (only_migratable) {
> +        if (dc->vmsd->unmigratable) {
> +            error_setg(errp, "Device %s is not migratable, but "
> +                       "--only-migratable was specified", driver);
> +            return NULL;
> +        }
> +    }
> +
>      /* find bus */
>      path = qemu_opt_get(opts, "bus");
>      if (path != NULL) {
> -- 
> 2.6.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
