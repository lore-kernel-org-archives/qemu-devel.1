Received: from eggs.gnu.org ([2001:4830:134:3::10]:54593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ca2W7-0003tj-65
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ca2W2-00066L-9J
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:44:47 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ca2W2-00066B-1a
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:44:42 -0500
Received: by mail-pg0-x243.google.com with SMTP id 204so4701827pge.2
	for <qemu-devel@nongnu.org>; Sat, 04 Feb 2017 07:44:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1486210863-14924-1-git-send-email-ashijeetacharya@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62131d9c-ff78-789e-a0f9-b97a152270d0@redhat.com>
Date: Sat, 4 Feb 2017 07:44:37 -0800
MIME-Version: 1.0
In-Reply-To: <1486210863-14924-1-git-send-email-ashijeetacharya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] migrate: Introduce a 'dc->vmsd' check
 to avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>, dgilbert@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com



On 04/02/2017 04:21, Ashijeet Acharya wrote:
> Commit a3a3d8c7 introduced a segfault bug while checking for
> 'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
> devices which do no set their 'dc->vmsd' yet while initialization.
> Place a 'dc->vmsd' check prior to it so that we do not segfault for
> such devices.
> 
> NOTE: This doesn't compromise the functioning of --only-migratable
> option as all the unmigratable devices do set their 'dc->vmsd'.
> 
> Also, move the only_migratable check inside device_set_realized() to avoid
> code duplication and fix the bug to display only_migratable error message
> only if the device constructuon is right.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
> Changes is v3:
> - move only_migratable check inside device_set_realized() to avoid code 
> - duplication
> - I have dropped Juan's R-b tag for this one
> Changes in v2:
> - place dc->vmsd check in hw/usb/bus.c as well
> ---
>  hw/core/qdev.c | 10 ++++++++++
>  hw/usb/bus.c   | 19 -------------------
>  qdev-monitor.c |  9 ---------
>  3 files changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5783442..4438cbf 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -37,6 +37,7 @@
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
>  #include "qapi-event.h"
> +#include "migration/migration.h"
>  
>  int qdev_hotplug = 0;
>  static bool qdev_hot_added = false;
> @@ -896,6 +897,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      }
>  
>      if (value && !dev->realized) {
> +        if (only_migratable && dc->vmsd) {
> +            if (dc->vmsd->unmigratable) {
> +                error_setg(&local_err, "Device %s is not migratable, but "
> +                           "--only-migratable was specified",
> +                           object_get_typename(obj));
> +                goto fail;
> +            }
> +        }
> +
>          if (!obj->parent) {
>              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
>  
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 1dcc35c..25913ad 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -8,7 +8,6 @@
>  #include "monitor/monitor.h"
>  #include "trace.h"
>  #include "qemu/cutils.h"
> -#include "migration/migration.h"
>  
>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
>  
> @@ -687,8 +686,6 @@ USBDevice *usbdevice_create(const char *cmdline)
>      const char *params;
>      int len;
>      USBDevice *dev;
> -    ObjectClass *klass;
> -    DeviceClass *dc;
>  
>      params = strchr(cmdline,':');
>      if (params) {
> @@ -723,22 +720,6 @@ USBDevice *usbdevice_create(const char *cmdline)
>          return NULL;
>      }
>  
> -    klass = object_class_by_name(f->name);
> -    if (klass == NULL) {
> -        error_report("Device '%s' not found", f->name);
> -        return NULL;
> -    }
> -
> -    dc = DEVICE_CLASS(klass);
> -
> -    if (only_migratable) {
> -        if (dc->vmsd->unmigratable) {
> -            error_report("Device %s is not migratable, but --only-migratable "
> -                         "was specified", f->name);
> -            return NULL;
> -        }
> -    }
> -
>      if (f->usbdevice_init) {
>          dev = f->usbdevice_init(bus, params);
>      } else {
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 549f45f..5f2fcdf 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -29,7 +29,6 @@
>  #include "qemu/error-report.h"
>  #include "qemu/help_option.h"
>  #include "sysemu/block-backend.h"
> -#include "migration/migration.h"
>  
>  /*
>   * Aliases were a bad idea from the start.  Let's keep them
> @@ -579,14 +578,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>          return NULL;
>      }
>  
> -    if (only_migratable) {
> -        if (dc->vmsd->unmigratable) {
> -            error_setg(errp, "Device %s is not migratable, but "
> -                       "--only-migratable was specified", driver);
> -            return NULL;
> -        }
> -    }
> -
>      /* find bus */
>      path = qemu_opt_get(opts, "bus");
>      if (path != NULL) {
> 

Reviewed-bv: Paolo Bonzini <pbonzinI@redhat.com>
