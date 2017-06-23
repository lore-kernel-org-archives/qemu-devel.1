Received: from eggs.gnu.org ([2001:4830:134:3::10]:38517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dOReR-0002xz-TS
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dOReQ-00080q-Vt
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:41:43 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1494585229-9119-1-git-send-email-thuth@redhat.com>
Message-ID: <70fb29e7-2c18-2aaf-8682-716f7808eab9@redhat.com>
Date: Fri, 23 Jun 2017 18:41:34 +0200
MIME-Version: 1.0
In-Reply-To: <1494585229-9119-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

On 12.05.2017 12:33, Thomas Huth wrote:
> We likely do not want to carry these legacy -drive options along foreve=
r.
> Let's emit a deprecation warning for the -drive options that have a
> replacement with the -device option, so that the (hopefully few) remain=
ing
> users are aware of this and can adapt their scripts / behaviour accordi=
ngly.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Check for !qtest_enabled() since tests/hd-geo-test still uses these
>  - Added "addr" to the list, too
>  - Also mark the options as deprecated in the documentation
>=20
>  blockdev.c      | 14 ++++++++++++++
>  qemu-options.hx |  5 ++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>=20
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
> @@ -797,6 +798,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInter=
faceType block_default_type)
>      const char *filename;
>      Error *local_err =3D NULL;
>      int i;
> +    const char *deprecated[] =3D {
> +        "serial", "trans", "secs", "heads", "cyls", "addr"
> +    };
> =20
>      /* Change legacy command line options into QMP ones */
>      static const struct {
> @@ -880,6 +884,16 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInte=
rfaceType block_default_type)
>                  "update your scripts.\n");
>      }
> =20
> +    /* Other deprecated options */
> +    if (!qtest_enabled()) {
> +        for (i =3D 0; i < ARRAY_SIZE(deprecated); i++) {
> +            if (qemu_opt_get(legacy_opts, deprecated[i]) !=3D NULL) {
> +                error_report("'%s' is deprecated, please use the corre=
sponding "
> +                             "option of '-device' instead", deprecated=
[i]);
> +            }
> +        }
> +    }
> +
>      /* Media type */
>      value =3D qemu_opt_get(legacy_opts, "media");
>      if (value) {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9d7964d..2f66f1a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -615,6 +615,8 @@ of available connectors of a given interface type.
>  This option defines the type of the media: disk or cdrom.
>  @item cyls=3D@var{c},heads=3D@var{h},secs=3D@var{s}[,trans=3D@var{t}]
>  These options have the same definition as they have in @option{-hdachs=
}.
> +These parameters are deprecated, use the corresponding parameters
> +of @code{-device} instead.
>  @item snapshot=3D@var{snapshot}
>  @var{snapshot} is "on" or "off" and controls snapshot mode for the giv=
en drive
>  (see @option{-snapshot}).
> @@ -631,7 +633,8 @@ an untrusted format header.
>  @item serial=3D@var{serial}
>  This option specifies the serial number to assign to the device.
>  @item addr=3D@var{addr}
> -Specify the controller's PCI address (if=3Dvirtio only).
> +Specify the controller's PCI address (if=3Dvirtio only). This paramete=
r is
> +deprecated, use the corresponding parameter of @code{-device} instead.
>  @item werror=3D@var{action},rerror=3D@var{action}
>  Specify which @var{action} to take on write and read errors. Valid act=
ions are:
>  "ignore" (ignore the error and try to continue), "stop" (pause QEMU),
>=20

ping=C2=B2

Any takers?

 Thomas
