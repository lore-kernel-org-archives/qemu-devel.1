Received: from eggs.gnu.org ([2001:4830:134:3::10]:40673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLjXR-00036f-P4
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLjXN-0003cf-Ol
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:15:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLjXN-0003cZ-KM
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:15:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
Date: Thu, 24 May 2018 08:15:41 +0200
In-Reply-To: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl> (Patryk
	Olszewski's message of "Wed, 23 May 2018 21:50:41 +0200")
Message-ID: <87a7spbmuq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Patryk Olszewski <patryk@fala.ehost.pl>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Patryk Olszewski <patryk@fala.ehost.pl> writes:

> This patch fixes bug in serial that made it almost impossible for guest
> to communicate with devices through host's serial.

Well, "almost impossible" for some applications.  Text works fine.  But
I get what you mean.

> OPOST flag in c_oflag enables output processing letting other flags in
> c_oflag take effect. Usually in c_oflag ONLCR flag is also set, which
> causes crlf to be sent in place of lf. This breaks binary transmissions.
> Unsetting OPOST flag turns off any output processing which fixes the bug.
>
> Bug reports related:
> https://bugs.launchpad.net/qemu/+bug/1772086
> https://bugs.launchpad.net/qemu/+bug/1407813
> https://bugs.launchpad.net/qemu/+bug/1715296
> also
> https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
>
> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
> ---
>  chardev/char-serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index feb52e5..ae548d2 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
>  
>      tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                       | INLCR | IGNCR | ICRNL | IXON);
> -    tty.c_oflag |= OPOST;
> +    tty.c_oflag &= ~OPOST;
>      tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
>      tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
>      switch (data_bits) {

Reviewed-by: Markus Armbruster <armbru@redhat.com>
