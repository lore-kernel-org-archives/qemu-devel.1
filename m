Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ckdFU-0003ZB-L6
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 15:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ckdFT-0005E5-PX
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 15:59:24 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ckdFT-0005Dj-ET
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 15:59:23 -0500
Received: by mail-lf0-x244.google.com with SMTP id g70so10553519lfh.3
	for <qemu-devel@nongnu.org>; Sun, 05 Mar 2017 12:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20170304185533.10618-1-f4bug@amsat.org>
	<20170304185533.10618-4-f4bug@amsat.org>
In-Reply-To: <20170304185533.10618-4-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 05 Mar 2017 20:59:08 +0000
Message-ID: <CAJ+F1C+sBZ0PB5w-5bRKAAhRfATEh5ZbMq0T4zyri_Vh+KGY+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qga: fix compiler warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Sat, Mar 4, 2017 at 10:58 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> static code analyzer complain:
>
> qga/commands-posix.c:2127:9: warning: Null pointer passed as an argument
> to a 'nonnull' parameter
>         closedir(dp);
>         ^~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qga/commands-posix.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index ea37c097cf..9c4ef2d640 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2119,9 +2119,11 @@ static void transfer_memory_block(GuestMemoryBlock
> *mem_blk, bool sys2memblk,
>           * we think this VM does not support online/offline memory block=
,
>           * any other solution?
>           */
> -        if (!dp && errno =3D=3D ENOENT) {
> -            result->response =3D
> -                GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED=
;
> +        if (!dp) {
> +            if (errno =3D=3D ENOENT) {
> +                result->response =3D
> +
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
> +            }
>              goto out1;
>          }
>          closedir(dp);
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
