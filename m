Received: from eggs.gnu.org ([2001:4830:134:3::10]:33358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gAFw9-0007tD-QF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gAFw5-0003Sa-MR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:58:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gAFw3-0003Nu-AK
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:58:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id n11-v6so6015702wru.13
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:57:57 -0700 (PDT)
Date: Wed, 10 Oct 2018 16:57:49 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20181010165749.3621ab7e@fiorina>
In-Reply-To: <CAKPgXcF4S9V=nVCxknjK9-SB6As9Qb4nNQJCajTg+cc0V3NR1Q@mail.gmail.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
	<e74ae84ba7361e247da994c56415d52fa03d009f.1538652143.git.tgolembi@redhat.com>
	<CAKPgXcF4S9V=nVCxknjK9-SB6As9Qb4nNQJCajTg+cc0V3NR1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, okrishtal@virtuozzo.com, Sameeh Jubran <sjubran@redhat.com>, marcandre.lureau@redhat.com

On Sun, 7 Oct 2018 15:13:26 +0300
Sameeh Jubran <sameeh@daynix.com> wrote:

> I did a quick scan for the documentation and the code and it seems that t=
he
> name format that you're looking for is provided by the "QueryDosDeviceW"
> function. The function returns multiple names and in the current code we
> only check the first one. I believe that one of these names provided shou=
ld
> be the win32 device name (dos name).
>=20
> Plus I did some googling and found out this similar question:
> https://stackoverflow.com/questions/36199097/list-the-content-of-the-win3=
2-device-namespace

Unfortunately the function QueryDosDevice does not help much with our
situation. Yes, it can tell you that "HarddiskVolume2" is symbolic link
to "\Device\HarddiskVolume2" or that "PhysicalDrive1" is symbolic link
to "\Device\Harddisk1\DR1".

What it does not tell you is that "\Device\Harddisk1\DR1" and
"\Device\0000001c" are two different names for one device.

> Which suggested using the following tool:
> https://docs.microsoft.com/en-us/sysinternals/downloads/winobj

Yes, this is a nice tool for listing the devices.

    Tomas
>=20
>=20
> On Thu, Oct 4, 2018 at 2:43 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com>
> wrote:
>=20
> > Probe the volume for disk extents and return list of all disks.
> > Originally only first disk of composite volume was returned.
> >
> > Note that the patch changes get_pci_info() from one state of brokenness
> > into a different state of brokenness. In other words it still does not =
do
> > what it's supposed to do (see comment in code). If anyone knows how to
> > fix it, please step in.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-win32.c | 126 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 108 insertions(+), 18 deletions(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 1e64642b8a..a591d8221d 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -477,9 +477,26 @@ static GuestDiskBusType
> > find_bus_type(STORAGE_BUS_TYPE bus)
> >      return win2qemu[(int)bus];
> >  }
> >
> > +/* XXX: The following function is BROKEN!
> > + *
> > + * It does not work and probably has never worked. When we query for l=
ist
> > of
> > + * disks we get cryptic names like "\Device\0000001d" instead of
> > + * "\PhysicalDriveX" or "\HarddiskX". Whether the names can be transla=
ted
> > one
> > + * way or the other for comparison is an open question.
> > + *
> > + * When we query volume names (the original version) we are able to ma=
tch
> > those
> > + * but then the property queries report error "Invalid function". (duh=
!)
> > + */
> > +
> > +/*
> >  DEFINE_GUID(GUID_DEVINTERFACE_VOLUME,
> >          0x53f5630dL, 0xb6bf, 0x11d0, 0x94, 0xf2,
> >          0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> > +*/
> > +DEFINE_GUID(GUID_DEVINTERFACE_DISK,
> > +        0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
> > +        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> > +
> >
> >  static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
> >  {
> > @@ -497,7 +514,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Er=
ror
> > **errp)
> >          goto out;
> >      }
> >
> > -    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_VOLUME, 0, 0,
> > +    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> >                                     DIGCF_PRESENT | DIGCF_DEVICEINTERFA=
CE);
> >      if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> >          error_setg_win32(errp, GetLastError(), "failed to get devices
> > tree");
> > @@ -637,20 +654,20 @@ static void get_single_disk_info(char *name,
> > GuestDiskAddress *disk,
> >  {
> >      SCSI_ADDRESS addr, *scsi_ad;
> >      DWORD len;
> > -    HANDLE vol_h;
> > +    HANDLE disk_h;
> >      Error *local_err =3D NULL;
> >
> >      scsi_ad =3D &addr;
> >
> >      g_debug("getting disk info for: %s", name);
> > -    vol_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> > +    disk_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTIN=
G,
> >                         0, NULL);
> > -    if (vol_h =3D=3D INVALID_HANDLE_VALUE) {
> > -        error_setg_win32(errp, GetLastError(), "failed to open volume"=
);
> > -        goto err;
> > +    if (disk_h =3D=3D INVALID_HANDLE_VALUE) {
> > +        error_setg_win32(errp, GetLastError(), "failed to open disk");
> > +        return;
> >      }
> >
> > -    get_disk_properties(vol_h, disk, &local_err);
> > +    get_disk_properties(disk_h, disk, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          goto err_close;
> > @@ -668,7 +685,7 @@ static void get_single_disk_info(char *name,
> > GuestDiskAddress *disk,
> >           * according to Microsoft docs
> >           *
> > https://technet.microsoft.com/en-us/library/ee851589(v=3Dws.10).aspx */
> >          g_debug("getting pci-controller info");
> > -        if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0,
> > scsi_ad,
> > +        if (DeviceIoControl(disk_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0,
> > scsi_ad,
> >                              sizeof(SCSI_ADDRESS), &len, NULL)) {
> >              disk->unit =3D addr.Lun;
> >              disk->target =3D addr.TargetId;
> > @@ -699,8 +716,7 @@ static void get_single_disk_info(char *name,
> > GuestDiskAddress *disk,
> >      }
> >
> >  err_close:
> > -    CloseHandle(vol_h);
> > -err:
> > +    CloseHandle(disk_h);
> >      return;
> >  }
> >
> > @@ -712,6 +728,10 @@ static GuestDiskAddressList
> > *build_guest_disk_info(char *guid, Error **errp)
> >      Error *local_err =3D NULL;
> >      GuestDiskAddressList *list =3D NULL, *cur_item =3D NULL;
> >      GuestDiskAddress *disk =3D NULL;
> > +    int i;
> > +    HANDLE vol_h;
> > +    DWORD size;
> > +    PVOLUME_DISK_EXTENTS extents =3D NULL;
> >
> >      /* strip final backslash */
> >      char *name =3D g_strdup(guid);
> > @@ -719,19 +739,89 @@ static GuestDiskAddressList
> > *build_guest_disk_info(char *guid, Error **errp)
> >          name[strlen(name) - 1] =3D 0;
> >      }
> >
> > -    disk =3D g_malloc0(sizeof(GuestDiskAddress));
> > -    get_single_disk_info(name, disk, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > +    g_debug("opening %s", name);
> > +    vol_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> > +                       0, NULL);
> > +    if (vol_h =3D=3D INVALID_HANDLE_VALUE) {
> > +        error_setg_win32(errp, GetLastError(), "failed to open volume"=
);
> >          goto out;
> >      }
> >
> > -    cur_item =3D g_malloc0(sizeof(*list));
> > -    cur_item->value =3D disk;
> > -    disk =3D NULL;
> > -    list =3D cur_item;
> > +    /* Get list of extents */
> > +    g_debug("getting disk extents");
> > +    size =3D sizeof(VOLUME_DISK_EXTENTS);
> > +    extents =3D g_malloc0(size);
> > +    if (!DeviceIoControl(vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS,
> > NULL,
> > +                         0, extents, size, NULL, NULL)) {
> > +        DWORD last_err =3D GetLastError();
> > +        if (last_err =3D=3D ERROR_MORE_DATA) {
> > +            /* Try once more with big enough buffer */
> > +            size =3D sizeof(VOLUME_DISK_EXTENTS)
> > +                + extents->NumberOfDiskExtents*sizeof(DISK_EXTENT);
> > +            g_free(extents);
> > +            extents =3D g_malloc0(size);
> > +            if (!DeviceIoControl(
> > +                    vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS, NULL,
> > +                    0, extents, size, NULL, NULL)) {
> > +                error_setg_win32(errp, GetLastError(),
> > +                    "failed to get disk extents");
> > +                return NULL;
> > +            }
> > +        } else if (last_err =3D=3D ERROR_INVALID_FUNCTION) {
> > +            /* Possibly CD-ROM or a shared drive. Try to pass the volu=
me
> > */
> > +            g_debug("volume not on disk");
> > +            disk =3D g_malloc0(sizeof(GuestDiskAddress));
> > +            get_single_disk_info(name, disk, &local_err);
> > +            if (local_err) {
> > +                g_debug("failed to get disk info, ignoring error: %s",
> > +                    error_get_pretty(local_err));
> > +                error_free(local_err);
> > +                goto out;
> > +            }
> > +            list =3D g_malloc0(sizeof(*list));
> > +            list->value =3D disk;
> > +            disk =3D NULL;
> > +            list->next =3D NULL;
> > +            goto out;
> > +        } else {
> > +            error_setg_win32(errp, GetLastError(),
> > +                "failed to get disk extents");
> > +            goto out;
> > +        }
> > +    }
> > +    g_debug("Number of extents: %lu", extents->NumberOfDiskExtents);
> > +
> > +    /* Go through each extent */
> > +    for (i =3D 0; i < extents->NumberOfDiskExtents; i++) {
> > +        char *disk_name =3D NULL;
> > +        disk =3D g_malloc0(sizeof(GuestDiskAddress));
> > +
> > +        /* Disk numbers directly correspond to numbers used in UNCs
> > +         *
> > +         * See documentation for DISK_EXTENT:
> > +         *
> > https://docs.microsoft.com/en-us/windows/desktop/api/winioctl/ns-winioc=
tl-_disk_extent
> > +         *
> > +         * See also Naming Files, Paths and Namespaces:
> > +         *
> > https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#w=
in32-device-namespaces
> > +         */
> > +        disk_name =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> > +            extents->Extents[i].DiskNumber);
> > +        get_single_disk_info(disk_name, disk, &local_err);
> > +        g_free(disk_name);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            goto out;
> > +        }
> > +        cur_item =3D g_malloc0(sizeof(*list));
> > +        cur_item->value =3D disk;
> > +        disk =3D NULL;
> > +        cur_item->next =3D list;
> > +        list =3D cur_item;
> > +    }
> > +
> >
> >  out:
> > +    g_free(extents);
> >      g_free(disk);
> >      g_free(name);
> >
> > --
> > 2.19.0
> >
> >
> > =20
>=20
> --=20
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
