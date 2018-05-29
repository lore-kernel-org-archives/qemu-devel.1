Received: from eggs.gnu.org ([2001:4830:134:3::10]:42064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fNafC-0001ww-Th
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fNafC-00069h-2G
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:11:30 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fNafB-00069M-SF
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:11:30 -0400
Received: by mail-wr0-x244.google.com with SMTP id d2-v6so8726006wrm.10
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 02:11:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529025240.520-1-linzhecheng@huawei.com>
References: <20180529025240.520-1-linzhecheng@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 May 2018 11:11:27 +0200
Message-ID: <CAJ+F1CL66Zt1aCBh6_BO99pRE+t9gYzCHhMUSFHxKmBY8ppj6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, wangxinxin.wang@huawei.com

Hi

On Tue, May 29, 2018 at 4:52 AM, linzhecheng <linzhecheng@huawei.com> wrote=
:
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 159e69c3b1..17519ec589 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -134,8 +134,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
>                                          s->write_msgfds,
>                                          s->write_msgfds_num);
>
> -        /* free the written msgfds, no matter what */
> -        if (s->write_msgfds_num) {
> +        /* free the written msgfds in any cases other than errno=3D=3DEA=
GAIN */
> +        if (EAGAIN !=3D errno && s->write_msgfds_num) {
>              g_free(s->write_msgfds);
>              s->write_msgfds =3D 0;
>              s->write_msgfds_num =3D 0;
> --

It is already fix since v2.12:

commit c863fdec6aff6b5a4ca8fff1537b80d9f8b97726
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Thu Feb 22 12:13:51 2018 +0000

    chardev: fix handling of EAGAIN for TCP chardev

> 2.12.2.windows.2
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
