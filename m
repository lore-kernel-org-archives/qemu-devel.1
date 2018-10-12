Received: from eggs.gnu.org ([2001:4830:134:3::10]:47920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAsSD-0004MT-DE
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAsS8-0001rw-EB
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAsS8-0001rB-5g
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:05:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7952550CD
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 08:05:42 +0000 (UTC)
References: <20181012002217.2864-1-philmd@redhat.com>
	<20181012002217.2864-12-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <786ca1d4-f874-e643-b85a-20652f1c84d8@redhat.com>
Date: Fri, 12 Oct 2018 10:05:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181012002217.2864-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] chardev: FDChardev::max_size be
 unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/10/2018 02:22, Philippe Mathieu-Daud=C3=A9 wrote:
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  chardev/char-fd.c         | 2 +-
>  include/chardev/char-fd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index bb426fa4b1..900da2f935 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -43,7 +43,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCond=
ition cond, void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
>      FDChardev *s =3D FD_CHARDEV(opaque);
> -    int len;
> +    size_t len;
>      uint8_t buf[CHR_READ_BUF_LEN];
>      ssize_t ret;
> =20
> diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
> index e7c2b176f9..36c6b89cee 100644
> --- a/include/chardev/char-fd.h
> +++ b/include/chardev/char-fd.h
> @@ -31,7 +31,7 @@ typedef struct FDChardev {
>      Chardev parent;
> =20
>      QIOChannel *ioc_in, *ioc_out;
> -    int max_size;
> +    size_t max_size;
>  } FDChardev;
> =20
>  #define TYPE_CHARDEV_FD "chardev-fd"
>=20

This shouldn't be just for max_size, it should be for all variables that
are set in the *_read_poll functions (those that you touch in patch 3).

These variables are than used very little, basically only in a

    len =3D MAX(s->max_size, sizeof(buf))

statement, so this switch is safe.  However, the order of the patches
should be first 4, then this one (the assertion shows that the switch to
unsigned is safe), then 5-6-9-10, then 7-8.  If you convert
implementations before users, the users could in principle overflow
"int" when passing an arguments or storing its value.

All this of course should be documented in commit messages, which are a
bit... scant in this series. :)  I'm usually okay with very short commit
messages when the changes are spread across many commits (in that case,
I usually document what all the repetitive changes are in the patches
before and/or after those changes), but in this case you are leaving out
completely the "why" for the changes, and that's not really a good idea.

Finally, can you please include a patch to adjust the assertions in the
USB smartcard code, as mentioned in my original reply to Prasad?

Thanks,

Paolo
