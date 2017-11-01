Received: from eggs.gnu.org ([2001:4830:134:3::10]:43489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9xV6-0002PR-5d
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9xV5-0002cp-9g
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:12:28 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:53338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e9xV5-0002cG-4Z
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:12:27 -0400
Received: by mail-vk0-x241.google.com with SMTP id k195so1952699vke.10
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 11:12:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171101142526.1006-5-ross.lagerwall@citrix.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-5-ross.lagerwall@citrix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 1 Nov 2017 19:12:25 +0100
Message-ID: <CAJ+F1CJiijFFUVSdhVMh81ULPzgCWgsZmR_q-xCer5++S5zRVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] io: Add /dev/fdset/ support to
 QIOChannelFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, Nov 1, 2017 at 3:25 PM, Ross Lagerwall
<ross.lagerwall@citrix.com> wrote:
> Add /dev/fdset/ support to QIOChannelFile by calling qemu_open() instead
> of open() and qemu_close() instead of close(). There is a subtle
> semantic change since qemu_open() automatically sets O_CLOEXEC, but this
> doesn't affect any of the users of the function.
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Changed in v2:
> * Split into separate patch.
>
>  io/channel-file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 1f2f710..db948ab 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -50,7 +50,7 @@ qio_channel_file_new_path(const char *path,
>
>      ioc =3D QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
>
> -    ioc->fd =3D open(path, flags, mode);
> +    ioc->fd =3D qemu_open(path, flags, mode);
>      if (ioc->fd < 0) {
>          object_unref(OBJECT(ioc));
>          error_setg_errno(errp, errno,
> @@ -74,7 +74,7 @@ static void qio_channel_file_finalize(Object *obj)
>  {
>      QIOChannelFile *ioc =3D QIO_CHANNEL_FILE(obj);
>      if (ioc->fd !=3D -1) {
> -        close(ioc->fd);
> +        qemu_close(ioc->fd);
>          ioc->fd =3D -1;
>      }
>  }
> @@ -173,7 +173,7 @@ static int qio_channel_file_close(QIOChannel *ioc,
>  {
>      QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(ioc);
>
> -    if (close(fioc->fd) < 0) {
> +    if (qemu_close(fioc->fd) < 0) {
>          error_setg_errno(errp, errno,
>                           "Unable to close file");
>          return -1;
> --
> 2.9.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
