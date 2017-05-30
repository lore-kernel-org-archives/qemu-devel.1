Received: from eggs.gnu.org ([2001:4830:134:3::10]:44633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFZaG-00049t-Kk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 01:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFZaF-0000oy-91
	for qemu-devel@nongnu.org; Tue, 30 May 2017 01:20:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494585229-9119-1-git-send-email-thuth@redhat.com>
Date: Tue, 30 May 2017 07:20:34 +0200
In-Reply-To: <1494585229-9119-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Fri, 12 May 2017 12:33:49 +0200")
Message-ID: <87k24yudi5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: Print a warning for legacy
 drive options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> We likely do not want to carry these legacy -drive options along forever.
> Let's emit a deprecation warning for the -drive options that have a
> replacement with the -device option, so that the (hopefully few) remaining
> users are aware of this and can adapt their scripts / behaviour accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Check for !qtest_enabled() since tests/hd-geo-test still uses these
>  - Added "addr" to the list, too
>  - Also mark the options as deprecated in the documentation
>
>  blockdev.c      | 14 ++++++++++++++
>  qemu-options.hx |  5 ++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/blockdev.c b/blockdev.c
> index 0b38c3d..aef38f0 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -50,6 +50,7 @@
>  #include "qmp-commands.h"
>  #include "block/trace.h"
>  #include "sysemu/arch_init.h"
> +#include "sysemu/qtest.h"
>  #include "qemu/cutils.h"
>  #include "qemu/help_option.h"
>  #include "qemu/throttle-options.h"
> @@ -797,6 +798,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>      const char *filename;
>      Error *local_err = NULL;
>      int i;
> +    const char *deprecated[] = {
> +        "serial", "trans", "secs", "heads", "cyls", "addr"
> +    };

I know I worked on turning (some of?) these into qdev properties, but
I've since forgotten the details, so let me review their current state
real quick:

* "serial": Silently ignored unless the device model chooses to pick it
  up.  Device models with a serial number should pick it up as a
  compatibility fallback for their qdev property, with blkconf_serial().
  Goes back to 2010-2011:

  a8686a9 virtio-blk: Turn drive serial into a qdev property
  c3a90cb usb-storage: Turn drive serial into a qdev property usb-storage.serial
  a0fef65 scsi: Turn drive serial into a qdev property scsi-disk.serial
  6ced55a ide: Turn drive serial into a qdev property ide-drive.serial

* "trans", "secs", "heads", "cyls": Similar, with blkconf_geometry().
  Goes back to 2012.

  6e6f61a ide: qdev property for BIOS CHS translation
  ba80196 ide: qdev properties for disk geometry
  e63e7fd virtio-blk: qdev properties for disk geometry
  d252df4 scsi-hd: qdev properties for disk geometry

* "addr": Only accepted with if=virtio.  drive_new() desugars it into
  the qdev property.

Okay.

>  
>      /* Change legacy command line options into QMP ones */
>      static const struct {
> @@ -880,6 +884,16 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
       if (qemu_opt_get(legacy_opts, "boot") != NULL) {
           fprintf(stderr, "qemu-kvm: boot=on|off is deprecated and will be "
                   "ignored. Future versions will reject this parameter. Please "
>                  "update your scripts.\n");

Unrelated to this patch: this is ugly.  It's also almost three years
old.  Can we bury the corpse already?

>      }
>  
> +    /* Other deprecated options */
> +    if (!qtest_enabled()) {
> +        for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
> +            if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
> +                error_report("'%s' is deprecated, please use the corresponding "
> +                             "option of '-device' instead", deprecated[i]);
> +            }
> +        }
> +    }
> +
>      /* Media type */
>      value = qemu_opt_get(legacy_opts, "media");
>      if (value) {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9d7964d..2f66f1a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -615,6 +615,8 @@ of available connectors of a given interface type.
>  This option defines the type of the media: disk or cdrom.
>  @item cyls=@var{c},heads=@var{h},secs=@var{s}[,trans=@var{t}]
>  These options have the same definition as they have in @option{-hdachs}.
> +These parameters are deprecated, use the corresponding parameters
> +of @code{-device} instead.
>  @item snapshot=@var{snapshot}
>  @var{snapshot} is "on" or "off" and controls snapshot mode for the given drive
>  (see @option{-snapshot}).
> @@ -631,7 +633,8 @@ an untrusted format header.
>  @item serial=@var{serial}
>  This option specifies the serial number to assign to the device.
>  @item addr=@var{addr}
> -Specify the controller's PCI address (if=virtio only).
> +Specify the controller's PCI address (if=virtio only). This parameter is
> +deprecated, use the corresponding parameter of @code{-device} instead.
>  @item werror=@var{action},rerror=@var{action}
>  Specify which @var{action} to take on write and read errors. Valid actions are:
>  "ignore" (ignore the error and try to continue), "stop" (pause QEMU),

Reviewed-by: Markus Armbruster <armbru@redhat.com>
