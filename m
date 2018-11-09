Received: from eggs.gnu.org ([2001:4830:134:3::10]:55040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL7vz-0001A4-C4
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL7vy-00044R-2W
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gL7vx-000407-QW
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:53 -0500
Received: by mail-ot1-x342.google.com with SMTP id n46so1763728otb.9
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 06:38:48 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181103130143.7179-1-marcandre.lureau@redhat.com>
References: <20181103130143.7179-1-marcandre.lureau@redhat.com>
Message-ID: <154177429388.30260.10684103416808682445@sif>
Date: Fri, 09 Nov 2018 08:38:13 -0600
Subject: Re: [Qemu-devel] [PATCH] qga-win: fix leaks of
 build_guest_disk_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: tgolembi@redhat.com

Quoting Marc-Andr=C3=A9 Lureau (2018-11-03 08:01:43)
> Introduced in commit b1ba8890e63ce9432c41c5c3fc229f54c87c9c99, vol_h
> handle should be closed, and "out" cleanup should be done after
> DeviceIoControl() fails.
> =

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands-win32.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index ef1d7d48d2..62e1b51dfe 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -797,7 +797,7 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
>                      0, extents, size, NULL, NULL)) {
>                  error_setg_win32(errp, GetLastError(),
>                      "failed to get disk extents");
> -                return NULL;
> +                goto out;
>              }
>          } else if (last_err =3D=3D ERROR_INVALID_FUNCTION) {
>              /* Possibly CD-ROM or a shared drive. Try to pass the volume=
 */
> @@ -855,6 +855,9 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
> =

> =

>  out:
> +    if (vol_h !=3D INVALID_HANDLE_VALUE) {
> +        CloseHandle(vol_h);
> +    }
>      qapi_free_GuestDiskAddress(disk);
>      g_free(extents);
>      g_free(name);
> -- =

> 2.19.1.708.g4ede3d42df
>=20
