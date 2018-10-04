Received: from eggs.gnu.org ([2001:4830:134:3::10]:40910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aN-00022W-3J
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83Z9-0008Vu-DW
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83Z7-0008Ou-MI
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:18 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so1876677ith.1
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<54f53859b73142e6264c948ff8a8e70616baf268.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <54f53859b73142e6264c948ff8a8e70616baf268.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:21:04 +0400
Message-ID: <CAMxuvayRCLWinDZKj44w0TfjZdfe8-k689io_RrF0p7b87mmgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/11] qga: report disk serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomas Golembiovsky <tgolembi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com> wrote:
>
> The feature is implemented for Windows and Linux. Reporting of serial
> number on Linux depends on libudev.
>
> Example from Linux:
>
>     {
>       "name": "dm-2",
>       "mountpoint": "/",
>       ...
>       "disk": [
>         {
>           "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
>           ...
>         }
>       ],
>     }
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/Makefile.objs    |  1 +
>  qga/commands-posix.c | 27 +++++++++++++++++++++++++++
>  qga/commands-win32.c | 24 ++++++++++++++++++++++++
>  qga/qapi-schema.json |  4 +++-
>  4 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/qga/Makefile.objs b/qga/Makefile.objs
> index ed08c5917c..80e6bb3c2e 100644
> --- a/qga/Makefile.objs
> +++ b/qga/Makefile.objs
> @@ -1,3 +1,4 @@
> +commands-posix.o-libs :=3D $(LIBUDEV_LIBS)
>  qga-obj-y =3D commands.o guest-agent-command-state.o main.o
>  qga-obj-$(CONFIG_POSIX) +=3D commands-posix.o channel-posix.o
>  qga-obj-$(CONFIG_WIN32) +=3D commands-win32.o channel-win32.o service-wi=
n32.o
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 37e8a2d791..4d324178f2 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -48,6 +48,10 @@ extern char **environ;
>  #include <net/if.h>
>  #include <sys/statvfs.h>
>
> +#ifdef CONFIG_LIBUDEV
> +#include <libudev.h>
> +#endif
> +
>  #ifdef FIFREEZE
>  #define CONFIG_FSFREEZE
>  #endif
> @@ -872,6 +876,10 @@ static void build_guest_fsinfo_for_real_device(char =
const *syspath,
>      GuestDiskAddressList *list =3D NULL;
>      bool has_ata =3D false, has_host =3D false, has_tgt =3D false;
>      char *p, *q, *driver =3D NULL;
> +#ifdef CONFIG_LIBUDEV
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +#endif
>
>      p =3D strstr(syspath, "/devices/pci");
>      if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
> @@ -936,6 +944,21 @@ static void build_guest_fsinfo_for_real_device(char =
const *syspath,
>      list =3D g_malloc0(sizeof(*list));
>      list->value =3D disk;
>
> +#ifdef CONFIG_LIBUDEV
> +    udev =3D udev_new();
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udev =3D=3D NULL || udevice =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +    } else {
> +        const char *serial;
> +        serial =3D udev_device_get_property_value(udevice, "ID_SERIAL");
> +        if (serial !=3D NULL && *serial !=3D 0) {
> +            disk->serial =3D g_strdup(serial);
> +            disk->has_serial =3D true;
> +        }
> +    }
> +#endif
> +
>      if (strcmp(driver, "ata_piix") =3D=3D 0) {
>          /* a host per ide bus, target*:0:<unit>:0 */
>          if (!has_host || !has_tgt) {
> @@ -1003,6 +1026,10 @@ cleanup:

You correcly free udev context on error, but on normal return, it's leaking

You may want to change the return/cleanup path to have a common path.

(btw the leak is spotted by test/test-qga if you build with --enable-saniti=
zers)

>          qapi_free_GuestDiskAddressList(list);
>      }
>      g_free(driver);
> +#ifdef CONFIG_LIBUDEV
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +#endif
>  }
>
>  static void build_guest_fsinfo_for_device(char const *devpath,
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d7864fc65a..376ca1e288 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -603,6 +603,30 @@ static void get_disk_properties(HANDLE vol_h, GuestD=
iskAddress *disk,
>      }
>      disk->bus_type =3D find_bus_type(dev_desc->BusType);
>      g_debug("bus type %d", disk->bus_type);
> +
> +    /* Query once more. Now with long enough buffer. */
> +    size =3D dev_desc->Size;
> +    dev_desc =3D g_malloc0(size);
> +    if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
> +                         sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
> +                         size, &received, NULL)) {
> +        error_setg_win32(errp, GetLastError(), "failed to get serial num=
ber");
> +        goto out_free;
> +    }
> +    if (dev_desc->SerialNumberOffset > 0) {
> +        if (dev_desc->SerialNumberOffset >=3D received) {
> +            error_setg(errp, "offset outside the buffer");
> +            goto out_free;
> +        }
> +        const char *serial =3D (char *)dev_desc + dev_desc->SerialNumber=
Offset;
> +        size_t len =3D received - dev_desc->SerialNumberOffset;
> +        if (*serial !=3D 0) {
> +            disk->serial =3D g_strndup(serial, len);
> +            disk->has_serial =3D true;
> +            g_debug("serial number %s", disk->serial);
> +        }
> +    }
> +out_free:
>      g_free(dev_desc);
>
>      return;
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index dfbc4a5e32..3bcda6257e 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -834,13 +834,15 @@
>  # @bus: bus id
>  # @target: target id
>  # @unit: unit id
> +# @serial: serial number (since: 3.1)
>  #
>  # Since: 2.2
>  ##
>  { 'struct': 'GuestDiskAddress',
>    'data': {'pci-controller': 'GuestPCIAddress',
>             'bus-type': 'GuestDiskBusType',
> -           'bus': 'int', 'target': 'int', 'unit': 'int'} }
> +           'bus': 'int', 'target': 'int', 'unit': 'int',
> +           '*serial': 'str'} }
>
>  ##
>  # @GuestFilesystemInfo:
> --
> 2.19.0

looks good otherwise
