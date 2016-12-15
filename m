Received: from eggs.gnu.org ([2001:4830:134:3::10]:37952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHZ2E-0003vl-Qh
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHZ2B-0001vh-Kv
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:37:34 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHZ2B-0001vQ-FZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:37:31 -0500
Received: by mail-io0-f195.google.com with SMTP id f73so8976057ioe.2
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 08:37:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161215161923.GO2509@work-vm>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<1481742422-15969-3-git-send-email-ashijeetacharya@gmail.com>
	<20161215160510.GM2509@work-vm>
	<CAC2QTZY7NBtCuMoPaXK0XNb+iHCZNFO_TrJr4y+XFXnV+T2hPQ@mail.gmail.com>
	<20161215161923.GO2509@work-vm>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 15 Dec 2016 22:06:30 +0530
Message-ID: <CAC2QTZaw-OoWciFSLV6hBsjJHE0N+vQ+fiVWWKBF-8bCm0AY-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Allow "device add" options
 to only add migratable devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: John Snow <jsnow@redhat.com>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 15, 2016 at 9:49 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
>> On Thu, Dec 15, 2016 at 9:35 PM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>> > * Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
>> >> Introduce checks for the unmigratable flag in the VMStateDescription
>> >> structs of respective devices when user attempts to add them. If the
>> >> "--only-migratable" was specified, all unmigratable devices will
>> >> rightly fail to add. This feature is made compatible for both "-device"
>> >> and "-usbdevice" command line options and covers their hmp and qmp
>> >> counterparts as well.
>> >>
>> >> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> >> ---
>> >>  hw/usb/bus.c   | 15 +++++++++++++++
>> >>  qdev-monitor.c |  9 +++++++++
>> >>  2 files changed, 24 insertions(+)
>> >>
>> >> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
>> >> index 25913ad..8796788 100644
>> >> --- a/hw/usb/bus.c
>> >> +++ b/hw/usb/bus.c
>> >> @@ -8,6 +8,7 @@
>> >>  #include "monitor/monitor.h"
>> >>  #include "trace.h"
>> >>  #include "qemu/cutils.h"
>> >> +#include "migration/migration.h"
>> >>
>> >>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
>> >>
>> >> @@ -686,6 +687,8 @@ USBDevice *usbdevice_create(const char *cmdline)
>> >>      const char *params;
>> >>      int len;
>> >>      USBDevice *dev;
>> >> +    ObjectClass *klass;
>> >> +    DeviceClass *dc;
>> >>
>> >>      params = strchr(cmdline,':');
>> >>      if (params) {
>> >> @@ -720,6 +723,18 @@ USBDevice *usbdevice_create(const char *cmdline)
>> >>          return NULL;
>> >>      }
>> >>
>> >> +    klass = object_class_by_name(f->name);
>> >
>> >> +    dc = DEVICE_CLASS(klass);
>> >
>> > Would qdev_get_device_class work here instead of that pair?
>>
>> No, because I believe that is defined as static in qdev_monitor.c
>> which was one of the reasons I faced a difficulty with this one.
>
> Hmm, I wonder if Markus can suggest a better way; qdev_get_device_class
> seems a lot more complex dealing iwth aliases and stuff, if we need that
> type of stuff.

Okay. I have grepped around for other uses of the macro DEVICE_CLASS
which is mostly during the initialization of the various devices and
we are not dealing with aliases probably because the device name is
rightly there. But similarly here, I am trusting the device name
stored in "f->name" more so after following the function call flow to
the lowest level and finding a similar call to object_class_by_name()
to get the ObjectClass of the device which passes the same name as
stored in f->name.

Ashijeet
>
> Dave
>
>> > (I was thinking you needed to check klass to make sure it wasn't null)
>>
>> Right. I will include the check in v2.
>>
>> Ashijeet
>> >
>> >> +    if (only_migratable) {
>> >> +        if (dc->vmsd->unmigratable) {
>> >> +            error_report("Device %s is not migratable, but --only-migratable "
>> >> +                         "was specified", f->name);
>> >> +            return NULL;
>> >> +        }
>> >> +    }
>> >> +
>> >>      if (f->usbdevice_init) {
>> >>          dev = f->usbdevice_init(bus, params);
>> >>      } else {
>> >> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> >> index c73410c..81d01df 100644
>> >> --- a/qdev-monitor.c
>> >> +++ b/qdev-monitor.c
>> >> @@ -29,6 +29,7 @@
>> >>  #include "qemu/error-report.h"
>> >>  #include "qemu/help_option.h"
>> >>  #include "sysemu/block-backend.h"
>> >> +#include "migration/migration.h"
>> >>
>> >>  /*
>> >>   * Aliases were a bad idea from the start.  Let's keep them
>> >> @@ -577,6 +578,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>> >>          return NULL;
>> >>      }
>> >>
>> >> +    if (only_migratable) {
>> >> +        if (dc->vmsd->unmigratable) {
>> >> +            error_setg(errp, "Device %s is not migratable, but "
>> >> +                       "--only-migratable was specified", driver);
>> >> +            return NULL;
>> >> +        }
>> >> +    }
>> >> +
>> >>      /* find bus */
>> >>      path = qemu_opt_get(opts, "bus");
>> >>      if (path != NULL) {
>> >> --
>> >> 2.6.2
>> >>
>> > --
>> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
