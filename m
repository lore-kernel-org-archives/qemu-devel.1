Received: from eggs.gnu.org ([2001:4830:134:3::10]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g97wK-0003Nz-I1
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 08:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g97wI-0007Ip-H9
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 08:13:40 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1g97wH-0007HI-SP
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 08:13:38 -0400
Received: by mail-ed1-x530.google.com with SMTP id w19-v6so77867eds.1
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 05:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<e74ae84ba7361e247da994c56415d52fa03d009f.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <e74ae84ba7361e247da994c56415d52fa03d009f.1538652143.git.tgolembi@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 7 Oct 2018 15:13:26 +0300
Message-ID: <CAKPgXcF4S9V=nVCxknjK9-SB6As9Qb4nNQJCajTg+cc0V3NR1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/11] qga-win: handle multi-disk volumes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tgolembi@redhat.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, okrishtal@virtuozzo.com, Sameeh Jubran <sjubran@redhat.com>, marcandre.lureau@redhat.com

I did a quick scan for the documentation and the code and it seems that the
name format that you're looking for is provided by the "QueryDosDeviceW"
function. The function returns multiple names and in the current code we
only check the first one. I believe that one of these names provided should
be the win32 device name (dos name).

Plus I did some googling and found out this similar question:
https://stackoverflow.com/questions/36199097/list-the-content-of-the-win32-=
device-namespace

Which suggested using the following tool:
https://docs.microsoft.com/en-us/sysinternals/downloads/winobj


On Thu, Oct 4, 2018 at 2:43 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com>
wrote:

> Probe the volume for disk extents and return list of all disks.
> Originally only first disk of composite volume was returned.
>
> Note that the patch changes get_pci_info() from one state of brokenness
> into a different state of brokenness. In other words it still does not do
> what it's supposed to do (see comment in code). If anyone knows how to
> fix it, please step in.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 126 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 108 insertions(+), 18 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 1e64642b8a..a591d8221d 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -477,9 +477,26 @@ static GuestDiskBusType
> find_bus_type(STORAGE_BUS_TYPE bus)
>      return win2qemu[(int)bus];
>  }
>
> +/* XXX: The following function is BROKEN!
> + *
> + * It does not work and probably has never worked. When we query for lis=
t
> of
> + * disks we get cryptic names like "\Device\0000001d" instead of
> + * "\PhysicalDriveX" or "\HarddiskX". Whether the names can be translate=
d
> one
> + * way or the other for comparison is an open question.
> + *
> + * When we query volume names (the original version) we are able to matc=
h
> those
> + * but then the property queries report error "Invalid function". (duh!)
> + */
> +
> +/*
>  DEFINE_GUID(GUID_DEVINTERFACE_VOLUME,
>          0x53f5630dL, 0xb6bf, 0x11d0, 0x94, 0xf2,
>          0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> +*/
> +DEFINE_GUID(GUID_DEVINTERFACE_DISK,
> +        0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
> +        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> +
>
>  static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
>  {
> @@ -497,7 +514,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r
> **errp)
>          goto out;
>      }
>
> -    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_VOLUME, 0, 0,
> +    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
>                                     DIGCF_PRESENT | DIGCF_DEVICEINTERFACE=
);
>      if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg_win32(errp, GetLastError(), "failed to get devices
> tree");
> @@ -637,20 +654,20 @@ static void get_single_disk_info(char *name,
> GuestDiskAddress *disk,
>  {
>      SCSI_ADDRESS addr, *scsi_ad;
>      DWORD len;
> -    HANDLE vol_h;
> +    HANDLE disk_h;
>      Error *local_err =3D NULL;
>
>      scsi_ad =3D &addr;
>
>      g_debug("getting disk info for: %s", name);
> -    vol_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> +    disk_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
>                         0, NULL);
> -    if (vol_h =3D=3D INVALID_HANDLE_VALUE) {
> -        error_setg_win32(errp, GetLastError(), "failed to open volume");
> -        goto err;
> +    if (disk_h =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg_win32(errp, GetLastError(), "failed to open disk");
> +        return;
>      }
>
> -    get_disk_properties(vol_h, disk, &local_err);
> +    get_disk_properties(disk_h, disk, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto err_close;
> @@ -668,7 +685,7 @@ static void get_single_disk_info(char *name,
> GuestDiskAddress *disk,
>           * according to Microsoft docs
>           *
> https://technet.microsoft.com/en-us/library/ee851589(v=3Dws.10).aspx */
>          g_debug("getting pci-controller info");
> -        if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0,
> scsi_ad,
> +        if (DeviceIoControl(disk_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0,
> scsi_ad,
>                              sizeof(SCSI_ADDRESS), &len, NULL)) {
>              disk->unit =3D addr.Lun;
>              disk->target =3D addr.TargetId;
> @@ -699,8 +716,7 @@ static void get_single_disk_info(char *name,
> GuestDiskAddress *disk,
>      }
>
>  err_close:
> -    CloseHandle(vol_h);
> -err:
> +    CloseHandle(disk_h);
>      return;
>  }
>
> @@ -712,6 +728,10 @@ static GuestDiskAddressList
> *build_guest_disk_info(char *guid, Error **errp)
>      Error *local_err =3D NULL;
>      GuestDiskAddressList *list =3D NULL, *cur_item =3D NULL;
>      GuestDiskAddress *disk =3D NULL;
> +    int i;
> +    HANDLE vol_h;
> +    DWORD size;
> +    PVOLUME_DISK_EXTENTS extents =3D NULL;
>
>      /* strip final backslash */
>      char *name =3D g_strdup(guid);
> @@ -719,19 +739,89 @@ static GuestDiskAddressList
> *build_guest_disk_info(char *guid, Error **errp)
>          name[strlen(name) - 1] =3D 0;
>      }
>
> -    disk =3D g_malloc0(sizeof(GuestDiskAddress));
> -    get_single_disk_info(name, disk, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    g_debug("opening %s", name);
> +    vol_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> +                       0, NULL);
> +    if (vol_h =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg_win32(errp, GetLastError(), "failed to open volume");
>          goto out;
>      }
>
> -    cur_item =3D g_malloc0(sizeof(*list));
> -    cur_item->value =3D disk;
> -    disk =3D NULL;
> -    list =3D cur_item;
> +    /* Get list of extents */
> +    g_debug("getting disk extents");
> +    size =3D sizeof(VOLUME_DISK_EXTENTS);
> +    extents =3D g_malloc0(size);
> +    if (!DeviceIoControl(vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS,
> NULL,
> +                         0, extents, size, NULL, NULL)) {
> +        DWORD last_err =3D GetLastError();
> +        if (last_err =3D=3D ERROR_MORE_DATA) {
> +            /* Try once more with big enough buffer */
> +            size =3D sizeof(VOLUME_DISK_EXTENTS)
> +                + extents->NumberOfDiskExtents*sizeof(DISK_EXTENT);
> +            g_free(extents);
> +            extents =3D g_malloc0(size);
> +            if (!DeviceIoControl(
> +                    vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS, NULL,
> +                    0, extents, size, NULL, NULL)) {
> +                error_setg_win32(errp, GetLastError(),
> +                    "failed to get disk extents");
> +                return NULL;
> +            }
> +        } else if (last_err =3D=3D ERROR_INVALID_FUNCTION) {
> +            /* Possibly CD-ROM or a shared drive. Try to pass the volume
> */
> +            g_debug("volume not on disk");
> +            disk =3D g_malloc0(sizeof(GuestDiskAddress));
> +            get_single_disk_info(name, disk, &local_err);
> +            if (local_err) {
> +                g_debug("failed to get disk info, ignoring error: %s",
> +                    error_get_pretty(local_err));
> +                error_free(local_err);
> +                goto out;
> +            }
> +            list =3D g_malloc0(sizeof(*list));
> +            list->value =3D disk;
> +            disk =3D NULL;
> +            list->next =3D NULL;
> +            goto out;
> +        } else {
> +            error_setg_win32(errp, GetLastError(),
> +                "failed to get disk extents");
> +            goto out;
> +        }
> +    }
> +    g_debug("Number of extents: %lu", extents->NumberOfDiskExtents);
> +
> +    /* Go through each extent */
> +    for (i =3D 0; i < extents->NumberOfDiskExtents; i++) {
> +        char *disk_name =3D NULL;
> +        disk =3D g_malloc0(sizeof(GuestDiskAddress));
> +
> +        /* Disk numbers directly correspond to numbers used in UNCs
> +         *
> +         * See documentation for DISK_EXTENT:
> +         *
> https://docs.microsoft.com/en-us/windows/desktop/api/winioctl/ns-winioctl=
-_disk_extent
> +         *
> +         * See also Naming Files, Paths and Namespaces:
> +         *
> https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#win=
32-device-namespaces
> +         */
> +        disk_name =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> +            extents->Extents[i].DiskNumber);
> +        get_single_disk_info(disk_name, disk, &local_err);
> +        g_free(disk_name);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            goto out;
> +        }
> +        cur_item =3D g_malloc0(sizeof(*list));
> +        cur_item->value =3D disk;
> +        disk =3D NULL;
> +        cur_item->next =3D list;
> +        list =3D cur_item;
> +    }
> +
>
>  out:
> +    g_free(extents);
>      g_free(disk);
>      g_free(name);
>
> --
> 2.19.0
>
>
>

--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
