Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aM-00021E-6t
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83ZL-0000B2-DY
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83ZL-0000Ah-8V
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:31 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so13020560ita.4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<f6d66487b5d9aa0e8e1c3bda856746ba58cabeae.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <f6d66487b5d9aa0e8e1c3bda856746ba58cabeae.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:21:19 +0400
Message-ID: <CAMxuvaza1L2f-HQ7fAMR4+piQEuDrv73uZv7mQ4QuQJJvdDeUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 04/11] qga-win: add debugging information
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
> The windows code generaly lacks debug information (compared to posix
> code). This patch adds some related to HW info in guest-get-fsinfo
> command.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qga/commands-win32.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 49fc747298..2a7a3af614 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -89,6 +89,12 @@ static OpenFlags guest_file_open_modes[] =3D {
>      {"a+b", FILE_GENERIC_APPEND|GENERIC_READ, OPEN_ALWAYS  }
>  };
>
> +#define debug_error(msg) do { \
> +    char *suffix =3D g_win32_error_message(GetLastError()); \
> +    g_debug("%s: %s", (msg), suffix); \
> +    g_free(suffix); \
> +} while (0)
> +
>  static OpenFlags *find_open_flag(const char *mode_str)
>  {
>      int mode;
> @@ -498,6 +504,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
>          goto out;
>      }
>
> +    g_debug("enumerating devices");
>      dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
>      for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
>          DWORD addr, bus, slot, func, dev, data, size2;
> @@ -522,6 +529,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
>          if (g_strcmp0(buffer, dev_name)) {
>              continue;
>          }
> +        g_debug("found device %s", dev_name);
>
>          /* There is no need to allocate buffer in the next functions. Th=
e size
>           * is known and ULONG according to
> @@ -530,6 +538,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
>           */
>          if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
>                     SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
> +            debug_error("failed to get bus");
>              break;
>          }
>
> @@ -537,6 +546,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
>           * transformed into device function and number */
>          if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
>                     SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
> +            debug_error("failed to get address");
>              break;
>          }
>
> @@ -544,6 +554,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
>           * This number is typically a user-perceived slot number. */
>          if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
>                     SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
> +            debug_error("failed to get slot");
>              break;
>          }
>
> @@ -608,6 +619,7 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>      scsi_ad =3D &addr;
>      char *name =3D g_strndup(guid, strlen(guid)-1);
>
> +    g_debug("getting disk info for: %s", name);
>      vol_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
>                         0, NULL);
>      if (vol_h =3D=3D INVALID_HANDLE_VALUE) {
> @@ -615,6 +627,7 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>          goto out_free;
>      }
>
> +    g_debug("getting bus type");
>      bus =3D get_disk_bus_type(vol_h, errp);
>      if (bus < 0) {
>          goto out_close;
> @@ -622,6 +635,7 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>
>      disk =3D g_malloc0(sizeof(*disk));
>      disk->bus_type =3D find_bus_type(bus);
> +    g_debug("bus type %d", disk->bus_type);
>      if (bus =3D=3D BusTypeScsi || bus =3D=3D BusTypeAta || bus =3D=3D Bu=
sTypeRAID
>  #if (_WIN32_WINNT >=3D 0x0600)
>              /* This bus type is not supported before Windows Server 2003=
 SP1 */
> @@ -631,6 +645,7 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>          /* We are able to use the same ioctls for different bus types
>           * according to Microsoft docs
>           * https://technet.microsoft.com/en-us/library/ee851589(v=3Dws.1=
0).aspx */
> +        g_debug("getting pci-controller info");
>          if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi=
_ad,
>                              sizeof(SCSI_ADDRESS), &len, NULL)) {
>              Error *local_err =3D NULL;
> --
> 2.19.0
>
