Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLivu-0002xn-NE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLivq-0003Hs-Ho
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:37:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLivq-0003Ha-Cs
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:36:58 -0400
References: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c02439be-e6af-0e10-cb0a-ddb62b48b5de@redhat.com>
Date: Thu, 24 May 2018 07:36:52 +0200
MIME-Version: 1.0
In-Reply-To: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Remove unwanted crlf conversion in
 serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patryk Olszewski <patryk@fala.ehost.pl>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23.05.2018 21:50, Patryk Olszewski wrote:
> This patch fixes bug in serial that made it almost impossible for guest
> to communicate with devices through host's serial.
>=20
> OPOST flag in c_oflag enables output processing letting other flags in
> c_oflag take effect. Usually in c_oflag ONLCR flag is also set, which
> causes crlf to be sent in place of lf. This breaks binary transmissions=
.
> Unsetting OPOST flag turns off any output processing which fixes the bu=
g.
>=20
> Bug reports related:
> https://bugs.launchpad.net/qemu/+bug/1772086
> https://bugs.launchpad.net/qemu/+bug/1407813
> https://bugs.launchpad.net/qemu/+bug/1715296
> also
> https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
>=20
> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
> ---
>  chardev/char-serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index feb52e5..ae548d2 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
> =20
>      tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                       | INLCR | IGNCR | ICRNL | IXON);
> -    tty.c_oflag |=3D OPOST;
> +    tty.c_oflag &=3D ~OPOST;
>      tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
>      tty.c_cflag &=3D ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
>      switch (data_bits) {
>=20

I think this bug has good chances to win the price "Oldest bug of the
year". If we'd wait one more months, it has its 15th anniversary: The
code has originally been added in 2003, see commit 0824d6fc674084519c85,
it has just been moved around to other files afterwards. Thus this is
almost as old as QEMU itself!

Anyway, I think disabling output processing is the right thing to do
here, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
