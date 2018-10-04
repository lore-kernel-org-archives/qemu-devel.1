Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aM-0002W5-6K
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83ZL-0000As-60
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83ZJ-000071-Ux
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:30 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so7843959ioa.9
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<f52540791edaf07805d9acaa8b5e795e847904a7.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <f52540791edaf07805d9acaa8b5e795e847904a7.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:21:15 +0400
Message-ID: <CAMxuvawNdyBjCBbWhF2kN_A+A310Hw0Q0e1ofUSL7HTGRRQcmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 05/11] qga-win: refactor disk properties
 (bus)
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
> Refactor code that queries bus type to be more generic. The function
> get_disk_bus_type() has been renamed to build_guest_disk_info().
> Following commit(s) will extend this function.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 46 +++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 2a7a3af614..d7864fc65a 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -583,25 +583,29 @@ out:
>      return pci;
>  }
>
> -static int get_disk_bus_type(HANDLE vol_h, Error **errp)
> +static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
> +    Error **errp)
>  {
>      STORAGE_PROPERTY_QUERY query;
>      STORAGE_DEVICE_DESCRIPTOR *dev_desc, buf;
>      DWORD received;
> +    ULONG size =3D sizeof(buf);
>
>      dev_desc =3D &buf;
> -    dev_desc->Size =3D sizeof(buf);
>      query.PropertyId =3D StorageDeviceProperty;
>      query.QueryType =3D PropertyStandardQuery;
>
>      if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
>                           sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
> -                         dev_desc->Size, &received, NULL)) {
> +                         size, &received, NULL)) {
>          error_setg_win32(errp, GetLastError(), "failed to get bus type")=
;
> -        return -1;
> +        return;
>      }
> +    disk->bus_type =3D find_bus_type(dev_desc->BusType);
> +    g_debug("bus type %d", disk->bus_type);
> +    g_free(dev_desc);

bad free(), dev_desc =3D &buf.

looks good otherwise

>
> -    return dev_desc->BusType;
> +    return;
>  }
>
>  /* VSS provider works with volumes, thus there is no difference if
> @@ -613,8 +617,8 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>      GuestDiskAddress *disk;
>      SCSI_ADDRESS addr, *scsi_ad;
>      DWORD len;
> -    int bus;
>      HANDLE vol_h;
> +    Error *local_err =3D NULL;
>
>      scsi_ad =3D &addr;
>      char *name =3D g_strndup(guid, strlen(guid)-1);
> @@ -624,22 +628,22 @@ static GuestDiskAddressList *build_guest_disk_info(=
char *guid, Error **errp)
>                         0, NULL);
>      if (vol_h =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg_win32(errp, GetLastError(), "failed to open volume");
> -        goto out_free;
> +        goto err;
>      }
>
> -    g_debug("getting bus type");
> -    bus =3D get_disk_bus_type(vol_h, errp);
> -    if (bus < 0) {
> -        goto out_close;
> +    disk =3D g_malloc0(sizeof(*disk));
> +    get_disk_properties(vol_h, disk, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto err_close;
>      }
>
> -    disk =3D g_malloc0(sizeof(*disk));
> -    disk->bus_type =3D find_bus_type(bus);
> -    g_debug("bus type %d", disk->bus_type);
> -    if (bus =3D=3D BusTypeScsi || bus =3D=3D BusTypeAta || bus =3D=3D Bu=
sTypeRAID
> +    if (disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_SCSI
> +            || disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_IDE
> +            || disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_RAID
>  #if (_WIN32_WINNT >=3D 0x0600)
>              /* This bus type is not supported before Windows Server 2003=
 SP1 */
> -            || bus =3D=3D BusTypeSas
> +            || disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_SAS
>  #endif
>          ) {
>          /* We are able to use the same ioctls for different bus types
> @@ -679,11 +683,17 @@ static GuestDiskAddressList *build_guest_disk_info(=
char *guid, Error **errp)
>      list =3D g_malloc0(sizeof(*list));
>      list->value =3D disk;
>      list->next =3D NULL;
> -out_close:
>      CloseHandle(vol_h);
> -out_free:
>      g_free(name);
>      return list;
> +
> +err_close:
> +    g_free(disk);
> +    CloseHandle(vol_h);
> +err:
> +    g_free(name);
> +
> +    return NULL;
>  }
>
>  #else
> --
> 2.19.0
>
