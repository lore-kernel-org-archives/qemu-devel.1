Received: from eggs.gnu.org ([2001:4830:134:3::10]:40233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eLV7n-0007E5-10
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eLV7m-0003JC-7y
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:20:07 -0500
MIME-Version: 1.0
In-Reply-To: <20171201232433.25193-4-eblake@redhat.com>
References: <20171201232433.25193-1-eblake@redhat.com>
	<20171201232433.25193-4-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 3 Dec 2017 15:20:04 +0100
Message-ID: <CAJ+F1CJCuH5r12mpuzHgUjA0MqhE38CtiVwYoiimo667zwXg5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] chardev: Use goto/label instead of
 do/break/while(0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Sat, Dec 2, 2017 at 12:24 AM, Eric Blake <eblake@redhat.com> wrote:
> Use of a do/while(0) control flow in order to permit an early break
> is an unusual paradigm, and triggers a false positive with a planned
> future syntax check against 'while (0);'.  Rewrite the code to use a
> goto instead.  This patch temporarily keeps an extra level of
> indentation to highlight the change; the next patch cleans it up.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  chardev/char-serial.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 2f8f83821d..10162f9fa3 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -64,9 +64,14 @@ static void tty_serial_init(int fd, int speed,
>  #endif
>      tcgetattr(fd, &tty);
>
> -#define check_speed(val) if (speed <=3D val) { spd =3D B##val; break; }
> +#define check_speed(val) \
> +    if (speed <=3D val) {  \
> +        spd =3D B##val;    \
> +        goto done;       \
> +    }
> +
>      speed =3D speed * 10 / 11;
> -    do {
> +    {
>          check_speed(50);
>          check_speed(75);
>          check_speed(110);
> @@ -125,8 +130,10 @@ static void tty_serial_init(int fd, int speed,
>          check_speed(4000000);
>  #endif
>          spd =3D B115200;
> -    } while (0);
> +    }
>
> +#undef check_speed
> + done:
>      cfsetispeed(&tty, spd);
>      cfsetospeed(&tty, spd);
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
