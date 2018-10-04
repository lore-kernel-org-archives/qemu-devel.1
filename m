Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aR-0002W5-E7
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83Z5-0008OS-Ow
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:19 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83Z2-0008I3-Vq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:14 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so13949781itd.1
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<fe8e4352f962e5f4b720338b2742a01c29674ee7.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <fe8e4352f962e5f4b720338b2742a01c29674ee7.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:20:59 +0400
Message-ID: <CAMxuvax8wGLwRSD3sE1JeB-pdd4ecqVJJXJ9iBwecdK9X3-8Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/11] qga: return disk device in
 guest-get-fsinfo
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
> Report device node of the disk. It is implemented for Linux (needs
> libudev) and Windows. The node is reported e.g. as "/dev/sda2" on Linux
> and as "\\.\PhysicalDriveX" on Windows.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c |  7 ++++++-
>  qga/commands-win32.c | 21 +++++++++++----------
>  qga/qapi-schema.json |  3 ++-
>  3 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 4d324178f2..31952b07f4 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -950,7 +950,12 @@ static void build_guest_fsinfo_for_real_device(char =
const *syspath,
>      if (udev =3D=3D NULL || udevice =3D=3D NULL) {
>          g_debug("failed to query udev");
>      } else {
> -        const char *serial;
> +        const char *devnode, *serial;
> +        devnode =3D udev_device_get_devnode(udevice);
> +        if (devnode !=3D NULL) {
> +            disk->dev =3D g_strdup(devnode);
> +            disk->has_dev =3D true;
> +        }

ack the posix/linux part.

You may want to split the Windows part..

>          serial =3D udev_device_get_property_value(udevice, "ID_SERIAL");
>          if (serial !=3D NULL && *serial !=3D 0) {
>              disk->serial =3D g_strdup(serial);
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index a591d8221d..d0d969d0ce 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -649,8 +649,7 @@ out_free:
>      return;
>  }
>
> -static void get_single_disk_info(char *name, GuestDiskAddress *disk,
> -    Error **errp)
> +static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
>  {
>      SCSI_ADDRESS addr, *scsi_ad;
>      DWORD len;
> @@ -659,8 +658,8 @@ static void get_single_disk_info(char *name, GuestDis=
kAddress *disk,
>
>      scsi_ad =3D &addr;
>
> -    g_debug("getting disk info for: %s", name);
> -    disk_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> +    g_debug("getting disk info for: %s", disk->dev);
> +    disk_h =3D CreateFile(disk->dev, 0, FILE_SHARE_READ, NULL, OPEN_EXIS=
TING,
>                         0, NULL);
>      if (disk_h =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg_win32(errp, GetLastError(), "failed to open disk");
> @@ -692,7 +691,7 @@ static void get_single_disk_info(char *name, GuestDis=
kAddress *disk,
>              disk->bus =3D addr.PathId;
>              g_debug("unit=3D%lld target=3D%lld bus=3D%lld",
>                  disk->unit, disk->target, disk->bus);
> -            disk->pci_controller =3D get_pci_info(name, &local_err);
> +            disk->pci_controller =3D get_pci_info(disk->dev, &local_err)=
;
>
>              if (local_err) {
>                  g_debug("failed to get PCI controller info: %s",
> @@ -771,7 +770,9 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>              /* Possibly CD-ROM or a shared drive. Try to pass the volume=
 */
>              g_debug("volume not on disk");
>              disk =3D g_malloc0(sizeof(GuestDiskAddress));
> -            get_single_disk_info(name, disk, &local_err);
> +            disk->has_dev =3D true;
> +            disk->dev =3D g_strdup(name);
> +            get_single_disk_info(disk, &local_err);
>              if (local_err) {
>                  g_debug("failed to get disk info, ignoring error: %s",
>                      error_get_pretty(local_err));
> @@ -793,7 +794,6 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>
>      /* Go through each extent */
>      for (i =3D 0; i < extents->NumberOfDiskExtents; i++) {
> -        char *disk_name =3D NULL;
>          disk =3D g_malloc0(sizeof(GuestDiskAddress));
>
>          /* Disk numbers directly correspond to numbers used in UNCs
> @@ -804,10 +804,11 @@ static GuestDiskAddressList *build_guest_disk_info(=
char *guid, Error **errp)
>           * See also Naming Files, Paths and Namespaces:
>           * https://docs.microsoft.com/en-us/windows/desktop/FileIO/namin=
g-a-file#win32-device-namespaces
>           */
> -        disk_name =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> +        disk->has_dev =3D true;
> +        disk->dev =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
>              extents->Extents[i].DiskNumber);
> -        get_single_disk_info(disk_name, disk, &local_err);
> -        g_free(disk_name);
> +
> +        get_single_disk_info(disk, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              goto out;
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 3bcda6257e..c6725b3ec8 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -835,6 +835,7 @@
>  # @target: target id
>  # @unit: unit id
>  # @serial: serial number (since: 3.1)
> +# @dev: device node (POSIX) or device UNC (Windows) (since: 3.1)
>  #
>  # Since: 2.2
>  ##
> @@ -842,7 +843,7 @@
>    'data': {'pci-controller': 'GuestPCIAddress',
>             'bus-type': 'GuestDiskBusType',
>             'bus': 'int', 'target': 'int', 'unit': 'int',
> -           '*serial': 'str'} }
> +           '*serial': 'str', '*dev': 'str'} }
>
>  ##
>  # @GuestFilesystemInfo:
> --
> 2.19.0
>
