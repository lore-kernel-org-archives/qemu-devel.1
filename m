Received: from eggs.gnu.org ([2001:4830:134:3::10]:59892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFNER-0007vQ-AP
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFNEQ-0008JV-1e
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:09:23 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1494585229-9119-1-git-send-email-thuth@redhat.com>
Message-ID: <8471eebf-e872-6dc6-f3e4-b2709de12bfb@redhat.com>
Date: Mon, 29 May 2017 18:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <1494585229-9119-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org

On 12.05.2017 12:33, Thomas Huth wrote:
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
>  
>      /* Change legacy command line options into QMP ones */
>      static const struct {
> @@ -880,6 +884,16 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>                  "update your scripts.\n");
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
> 

Ping ... any comments on this version of my patch?

 Thomas
