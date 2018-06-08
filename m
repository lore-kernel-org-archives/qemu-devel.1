Received: from eggs.gnu.org ([2001:4830:134:3::10]:38544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRAFN-0001PX-BO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRAFJ-0000de-5J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:47:37 -0400
References: <20180607210818.12727-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9abdaa17-d6d1-0c34-2a20-43078b487bef@redhat.com>
Date: Fri, 8 Jun 2018 07:47:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180607210818.12727-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: Restore CR,LF on stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Patryk Olszewski <patryk@fala.ehost.pl>, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 07.06.2018 23:08, Philippe Mathieu-Daud=C3=A9 wrote:
> Remove the 'stair-step output' on stdio.
>=20
> This partially reverts commit 12fb0ac05, which was correct
> on the mailing list but got corrupted by the maintainer :p
>=20
> Introduced-by: 3b876140-c035-dd39-75d0-d54c48128fac@redhat.com
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> See:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06202.html (=
bug)
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01309.html (=
report)
>=20
> Peter, Can this enters directly as bug-fix?
>=20
>  chardev/char-stdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index d83e60e787..96375f2ab8 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, boo=
l echo)
>      if (!echo) {
>          tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                           | INLCR | IGNCR | ICRNL | IXON);
> -        tty.c_oflag &=3D ~OPOST;
> +        tty.c_oflag |=3D OPOST;
>          tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN);
>          tty.c_cflag &=3D ~(CSIZE | PARENB);
>          tty.c_cflag |=3D CS8;
>=20

I think this is the right way to go.

Reviewed-by: Thomas Huth <thuth@redhat.com>
