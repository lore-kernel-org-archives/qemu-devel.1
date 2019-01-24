Received: from eggs.gnu.org ([209.51.188.92]:47873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmjEt-0003Np-F8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmjEr-0001IZ-Gq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:56:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55304
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gmjEr-0001Hh-B7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:56:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OHpRSv092879
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:56:28 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q7guf4xr7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:56:28 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 24 Jan 2019 17:56:27 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190114090324.16176-1-mhines@scalecomputing.com>
References: <20190114090324.16176-1-mhines@scalecomputing.com>
Date: Thu, 24 Jan 2019 11:56:18 -0600
Message-Id: <154835257877.21382.11783971245610071087@sif>
Subject: Re: [Qemu-devel] [PATCH] QGA: Fix guest-get-fsinfo PCI address
 collection in Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mhines@scalecomputing.com, qemu-devel@nongnu.org

Quoting mhines@scalecomputing.com (2019-01-14 03:03:23)
> From: Matt Hines <mhines@scalecomputing.com>
> =

> Signed-off-by: Matt Hines <mhines@scalecomputing.com>
> ---
>  configure            |   2 +-
>  qga/commands-win32.c | 295 +++++++++++++++++++++++++++++++++------------=
------
>  qga/qapi-schema.json |   3 +-
>  3 files changed, 197 insertions(+), 103 deletions(-)
> =

> diff --git a/configure b/configure
> index 5b1d83ea26..46f21c089f 100755
> --- a/configure
> +++ b/configure
> @@ -4694,7 +4694,7 @@ int main(void) {
>  EOF
>    if compile_prog "" "" ; then
>      guest_agent_ntddscsi=3Dyes
> -    libs_qga=3D"-lsetupapi $libs_qga"
> +    libs_qga=3D"-lsetupapi -lcfgmgr32 $libs_qga"
>    fi
>  fi
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 62e1b51dfe..8c8f3a2c65 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -26,6 +26,7 @@
>  #include <winioctl.h>
>  #include <ntddscsi.h>
>  #include <setupapi.h>
> +#include <cfgmgr32.h>
>  #include <initguid.h>
>  #endif
>  #include <lm.h>
> @@ -491,56 +492,29 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_T=
YPE bus)
>      return win2qemu[(int)bus];
>  }
> =

> -/* XXX: The following function is BROKEN!
> - *
> - * It does not work and probably has never worked. When we query for lis=
t of
> - * disks we get cryptic names like "\Device\0000001d" instead of
> - * "\PhysicalDriveX" or "\HarddiskX". Whether the names can be translate=
d one
> - * way or the other for comparison is an open question.
> - *
> - * When we query volume names (the original version) we are able to matc=
h those
> - * but then the property queries report error "Invalid function". (duh!)
> - */
> -
> -/*
> -DEFINE_GUID(GUID_DEVINTERFACE_VOLUME,
> -        0x53f5630dL, 0xb6bf, 0x11d0, 0x94, 0xf2,
> -        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> -*/
>  DEFINE_GUID(GUID_DEVINTERFACE_DISK,
>          0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
>          0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> +DEFINE_GUID(GUID_DEVINTERFACE_STORAGEPORT,
> +        0x2accfe60L, 0xc130, 0x11d2, 0xb0, 0x82,
> +        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
> =

> -
> -static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
> +static GuestPCIAddress *get_pci_info(int number, Error **errp)
>  {
>      HDEVINFO dev_info;
>      SP_DEVINFO_DATA dev_info_data;
> -    DWORD size =3D 0;
> +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> +    HANDLE dev_file;
>      int i;
> -    char dev_name[MAX_PATH];
> -    char *buffer =3D NULL;
>      GuestPCIAddress *pci =3D NULL;
> -    char *name =3D NULL;
>      bool partial_pci =3D false;
> +
>      pci =3D g_malloc0(sizeof(*pci));
>      pci->domain =3D -1;
>      pci->slot =3D -1;
>      pci->function =3D -1;
>      pci->bus =3D -1;
> =

> -    if (g_str_has_prefix(guid, "\\\\.\\") ||
> -        g_str_has_prefix(guid, "\\\\?\\")) {
> -        name =3D g_strdup(guid + 4);
> -    } else {
> -        name =3D g_strdup(guid);
> -    }
> -
> -    if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
> -        error_setg_win32(errp, GetLastError(), "failed to get dos device=
 name");
> -        goto out;
> -    }
> -
>      dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
>                                     DIGCF_PRESENT | DIGCF_DEVICEINTERFACE=
);
>      if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> @@ -550,90 +524,208 @@ static GuestPCIAddress *get_pci_info(char *guid, E=
rror **errp)
> =

>      g_debug("enumerating devices");
>      dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> +    dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);
>      for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
> -        DWORD addr, bus, slot, data, size2;
> -        int func, dev;
> -        while (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_dat=
a,
> -                                            SPDRP_PHYSICAL_DEVICE_OBJECT=
_NAME,
> -                                            &data, (PBYTE)buffer, size,
> -                                            &size2)) {
> -            size =3D MAX(size, size2);
> -            if (GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) {
> -                g_free(buffer);
> -                /* Double the size to avoid problems on
> -                 * W2k MBCS systems per KB 888609.
> -                 * https://support.microsoft.com/en-us/kb/259695 */
> -                buffer =3D g_malloc(size * 2);
> -            } else {
> +        PSP_DEVICE_INTERFACE_DETAIL_DATA pdev_iface_detail_data =3D NULL;
> +        STORAGE_DEVICE_NUMBER sdn;
> +        char *parent_dev_id =3D NULL;
> +        HDEVINFO parent_dev_info;
> +        SP_DEVINFO_DATA parent_dev_info_data;
> +        DWORD j;
> +        DWORD size =3D 0;
> +
> +        g_debug("getting device path");
> +        if (SetupDiEnumDeviceInterfaces(dev_info, &dev_info_data,
> +                                        &GUID_DEVINTERFACE_DISK, 0,
> +                                        &dev_iface_data)) {
> +            while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface=
_data,
> +                                                    pdev_iface_detail_da=
ta,
> +                                                    size, &size,
> +                                                    &dev_info_data)) {
> +                if (GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) {
> +                    pdev_iface_detail_data =3D g_malloc(size);
> +                    pdev_iface_detail_data->cbSize =3D
> +                        sizeof(*pdev_iface_detail_data);
> +                } else {
> +                    error_setg_win32(errp, GetLastError(),
> +                                     "failed to get device interfaces");
> +                    goto free_dev_info;
> +                }
> +            }
> +
> +            dev_file =3D CreateFile(pdev_iface_detail_data->DevicePath, =
0,
> +                                  FILE_SHARE_READ, NULL, OPEN_EXISTING, =
0,
> +                                  NULL);
> +            g_free(pdev_iface_detail_data);
> +
> +            if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMB=
ER,
> +                                 NULL, 0, &sdn, sizeof(sdn), &size, NULL=
)) {
> +                CloseHandle(dev_file);
>                  error_setg_win32(errp, GetLastError(),
> -                        "failed to get device name");
> +                                 "failed to get device slot number");
>                  goto free_dev_info;
>              }
> -        }
> =

> -        if (g_strcmp0(buffer, dev_name)) {
> -            continue;
> +            CloseHandle(dev_file);
> +            if (sdn.DeviceNumber !=3D number) {
> +                continue;
> +            }
> +        } else {
> +            error_setg_win32(errp, GetLastError(),
> +                             "failed to get device interfaces");
> +            goto free_dev_info;
>          }
> -        g_debug("found device %s", dev_name);
> =

> -        /* There is no need to allocate buffer in the next functions. Th=
e size
> -         * is known and ULONG according to
> -         * https://support.microsoft.com/en-us/kb/253232
> -         * https://msdn.microsoft.com/en-us/library/windows/hardware/ff5=
43095(v=3Dvs.85).aspx
> -         */
> -        if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
> -                   SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
> -            debug_error("failed to get bus");
> -            bus =3D -1;
> -            partial_pci =3D true;
> +        g_debug("found device slot %d. Getting storage controller", numb=
er);
> +        {
> +            CONFIGRET cr;
> +            DEVINST dev_inst, parent_dev_inst;
> +            ULONG dev_id_size =3D 0;
> +
> +            size =3D 0;
> +            while (!SetupDiGetDeviceInstanceId(dev_info, &dev_info_data,
> +                                               parent_dev_id, size, &siz=
e)) {
> +                if (GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) {
> +                    parent_dev_id =3D g_malloc(size);
> +                } else {
> +                    error_setg_win32(errp, GetLastError(),
> +                                     "failed to get device instance ID");
> +                    goto out;
> +                }
> +            }
> +
> +            /*
> +            * CM API used here as opposed to
> +            * SetupDiGetDeviceProperty(..., DEVPKEY_Device_Parent, ...)
> +            * which exports are only available in mingw-w64 6+
> +            */
> +            cr =3D CM_Locate_DevInst(&dev_inst, parent_dev_id, 0);
> +            if (cr !=3D CR_SUCCESS) {
> +                g_error("CM_Locate_DevInst failed with code %lx", cr);
> +                error_setg_win32(errp, GetLastError(),
> +                                 "failed to get device instance");
> +                goto out;
> +            }
> +            cr =3D CM_Get_Parent(&parent_dev_inst, dev_inst, 0);
> +            if (cr !=3D CR_SUCCESS) {
> +                g_error("CM_Get_Parent failed with code %lx", cr);
> +                error_setg_win32(errp, GetLastError(),
> +                                 "failed to get parent device instance");
> +                goto out;
> +            }
> +
> +            cr =3D CM_Get_Device_ID_Size(&dev_id_size, parent_dev_inst, =
0);
> +            if (cr !=3D CR_SUCCESS) {
> +                g_error("CM_Get_Device_ID_Size failed with code %lx", cr=
);
> +                error_setg_win32(errp, GetLastError(),
> +                                 "failed to get parent device ID length"=
);
> +                goto out;
> +            }
> +
> +            ++dev_id_size;
> +            if (dev_id_size > size) {
> +                g_free(parent_dev_id);
> +                parent_dev_id =3D g_malloc(dev_id_size);
> +            }
> +
> +            cr =3D CM_Get_Device_ID(parent_dev_inst, parent_dev_id, dev_=
id_size,
> +                                  0);
> +            if (cr !=3D CR_SUCCESS) {
> +                g_error("CM_Get_Device_ID failed with code %lx", cr);
> +                error_setg_win32(errp, GetLastError(),
> +                                 "failed to get parent device ID");
> +                goto out;
> +            }
>          }
> =

> -        /* The function retrieves the device's address. This value will =
be
> -         * transformed into device function and number */
> -        if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
> -                   SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
> -            debug_error("failed to get address");
> -            addr =3D -1;
> -            partial_pci =3D true;
> +        g_debug("querying storage controller %s for PCI information",
> +                parent_dev_id);
> +        parent_dev_info =3D
> +            SetupDiGetClassDevs(&GUID_DEVINTERFACE_STORAGEPORT, parent_d=
ev_id,
> +                                NULL, DIGCF_PRESENT | DIGCF_DEVICEINTERF=
ACE);
> +        g_free(parent_dev_id);
> +
> +        if (parent_dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +            error_setg_win32(errp, GetLastError(),
> +                             "failed to get parent device");
> +            goto out;
>          }
> =

> -        /* This call returns UINumber of DEVICE_CAPABILITIES structure.
> -         * This number is typically a user-perceived slot number. */
> -        if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
> -                   SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
> -            debug_error("failed to get slot");
> -            slot =3D -1;
> -            partial_pci =3D true;
> +        parent_dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> +        if (!SetupDiEnumDeviceInfo(parent_dev_info, 0, &parent_dev_info_=
data)) {
> +            error_setg_win32(errp, GetLastError(),
> +                           "failed to get parent device data");
> +            goto out;
>          }
> =

> -        /* SetupApi gives us the same information as driver with
> -         * IoGetDeviceProperty. According to Microsoft
> -         * https://support.microsoft.com/en-us/kb/253232
> -         * FunctionNumber =3D (USHORT)((propertyAddress) & 0x0000FFFF);
> -         * DeviceNumber =3D (USHORT)(((propertyAddress) >> 16) & 0x0000F=
FFF);
> -         * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
> -
> -        if (partial_pci) {
> -            pci->domain =3D -1;
> -            pci->slot =3D -1;
> -            pci->function =3D -1;
> -            pci->bus =3D -1;
> -        } else {
> -            func =3D ((int) addr =3D=3D -1) ? -1 : addr & 0x0000FFFF;
> -            dev =3D ((int) addr =3D=3D -1) ? -1 : (addr >> 16) & 0x0000F=
FFF;
> -            pci->domain =3D dev;
> -            pci->slot =3D (int) slot;
> -            pci->function =3D func;
> -            pci->bus =3D (int) bus;
> +        for (j =3D 0;
> +             SetupDiEnumDeviceInfo(parent_dev_info, j, &parent_dev_info_=
data);
> +             j++) {
> +            DWORD addr, bus, slot, type;
> +            int func, dev;
> +
> +            /* There is no need to allocate buffer in the next functions=
. The size
> +            * is known and ULONG according to
> +            * https://msdn.microsoft.com/en-us/library/windows/hardware/=
ff543095(v=3Dvs.85).aspx
> +            */
> +            if (!SetupDiGetDeviceRegistryProperty(
> +                  parent_dev_info, &parent_dev_info_data, SPDRP_BUSNUMBE=
R,
> +                  &type, (PBYTE)&bus, size, NULL)) {
> +                debug_error("failed to get PCI bus");
> +                bus =3D -1;
> +                partial_pci =3D true;
> +            }
> +
> +            /* The function retrieves the device's address. This value w=
ill be
> +            * transformed into device function and number */
> +            if (!SetupDiGetDeviceRegistryProperty(
> +                    parent_dev_info, &parent_dev_info_data, SPDRP_ADDRES=
S,
> +                    &type, (PBYTE)&addr, size, NULL)) {
> +                debug_error("failed to get PCI address");
> +                addr =3D -1;
> +                partial_pci =3D true;
> +            }
> +
> +            /* This call returns UINumber of DEVICE_CAPABILITIES structu=
re.
> +            * This number is typically a user-perceived slot number. */
> +            if (!SetupDiGetDeviceRegistryProperty(
> +                    parent_dev_info, &parent_dev_info_data, SPDRP_UI_NUM=
BER,
> +                    &type, (PBYTE)&slot, size, NULL)) {
> +                debug_error("failed to get PCI slot");
> +                slot =3D -1;
> +                partial_pci =3D true;
> +            }
> +
> +            /* SetupApi gives us the same information as driver with
> +            * IoGetDeviceProperty. According to Microsoft
> +            * https://docs.microsoft.com/en-us/windows/desktop/api/setup=
api/nf-setupapi-setupdigetdeviceregistrypropertya
> +            * FunctionNumber =3D (USHORT)((propertyAddress) & 0x0000FFFF=
);
> +            * DeviceNumber =3D (USHORT)(((propertyAddress) >> 16) & 0x00=
00FFFF);
> +            * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
> +
> +            if (partial_pci) {
> +                pci->domain =3D -1;
> +                pci->slot =3D -1;
> +                pci->function =3D -1;
> +                pci->bus =3D -1;
> +                continue;
> +            } else {
> +                func =3D ((int)addr =3D=3D -1) ? -1 : addr & 0x0000FFFF;
> +                dev =3D ((int)addr =3D=3D -1) ? -1 : (addr >> 16) & 0x00=
00FFFF;
> +                pci->domain =3D dev;
> +                pci->slot =3D (int)slot;
> +                pci->function =3D func;
> +                pci->bus =3D (int)bus;
> +                break;
> +            }
>          }
> +        SetupDiDestroyDeviceInfoList(parent_dev_info);
>          break;
>      }
> =

>  free_dev_info:
>      SetupDiDestroyDeviceInfoList(dev_info);
>  out:
> -    g_free(buffer);
> -    g_free(name);
>      return pci;
>  }
> =

> @@ -720,7 +812,7 @@ static void get_single_disk_info(GuestDiskAddress *di=
sk, Error **errp)
>       * if that doesn't hold since that suggests some other unexpected
>       * breakage
>       */
> -    disk->pci_controller =3D get_pci_info(disk->dev, &local_err);
> +    disk->pci_controller =3D get_pci_info(disk->number, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto err_close;
> @@ -736,7 +828,7 @@ static void get_single_disk_info(GuestDiskAddress *di=
sk, Error **errp)
>          /* We are able to use the same ioctls for different bus types
>           * according to Microsoft docs
>           * https://technet.microsoft.com/en-us/library/ee851589(v=3Dws.1=
0).aspx */
> -        g_debug("getting pci-controller info");
> +        g_debug("getting SCSI info");
>          if (DeviceIoControl(disk_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scs=
i_ad,
>                              sizeof(SCSI_ADDRESS), &len, NULL)) {
>              disk->unit =3D addr.Lun;
> @@ -838,8 +930,9 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>           * https://docs.microsoft.com/en-us/windows/desktop/FileIO/namin=
g-a-file#win32-device-namespaces
>           */
>          disk->has_dev =3D true;
> +        disk->number =3D extents->Extents[i].DiskNumber;
>          disk->dev =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> -            extents->Extents[i].DiskNumber);
> +                                    extents->Extents[i].DiskNumber);

Do we really need an additional OS-specific 'number' field if it is already
encoded in the OS-specific disk->dev path?

Also this part seems like a seperate patch that is unrelated to fixing PCI
address reporting. If the 2 cannot be seperated please explain why in
the commit log.

Also please provide a basic summary of what your patch is doing in the comm=
it
log. We generally expect this for anything other than trivial patches.

Thank you for working on fixing this.

> =

>          get_single_disk_info(disk, &local_err);
>          if (local_err) {
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c6725b3ec8..0a78fb2e3a 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -836,6 +836,7 @@
>  # @unit: unit id
>  # @serial: serial number (since: 3.1)
>  # @dev: device node (POSIX) or device UNC (Windows) (since: 3.1)
> +# @number: device slot index (Windows)
>  #
>  # Since: 2.2
>  ##
> @@ -843,7 +844,7 @@
>    'data': {'pci-controller': 'GuestPCIAddress',
>             'bus-type': 'GuestDiskBusType',
>             'bus': 'int', 'target': 'int', 'unit': 'int',
> -           '*serial': 'str', '*dev': 'str'} }
> +           '*serial': 'str', '*dev': 'str', 'number':'int'} }
> =

>  ##
>  # @GuestFilesystemInfo:
> -- =

> 2.11.0.windows.1
>=20
