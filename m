Received: from eggs.gnu.org ([2001:4830:134:3::10]:40664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fqKPO-0004vX-J2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fqKPG-0007TZ-NM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:41:56 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fqKPG-0007T9-Fy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:41:50 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so4246415ioj.1
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:41:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534433563-30865-2-git-send-email-yury-kotov@yandex-team.ru>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
	<1534433563-30865-2-git-send-email-yury-kotov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Aug 2018 17:41:49 +0200
Message-ID: <CAMxuvaz8Ji1v69Gq0XvN2kjcSpZ0QCsmsU11gQE6g4ctgKyHxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] chardev: prevent extra connection
 attempt in tcp_chr_machine_done_hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Hi

On Thu, Aug 16, 2018 at 5:32 PM, Yury Kotov <yury-kotov@yandex-team.ru> wro=
te:
> Usually chardev connects to specified address during the initialization.
> But if reconnect_time is specified then connection will be postponed unti=
l
> machine done event.
>
> Thus if reconnect is specified and some device forces connection during
> initialization, tcp_chr_machine_done_hook will do useless connection atte=
mpt.
>
> So add a check to prevent it.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>

It would be better with a test case in tests/test-char.c, but lgtm,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index efbad6e..116dcc4 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1165,7 +1165,10 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>
> -    if (s->reconnect_time) {
> +    /* It's possible that connection was established during the device
> +     * initialization. So check if the socket is already connected to
> +     * prevent extra connection attempt. */
> +    if (!s->connected && s->reconnect_time) {
>          tcp_chr_connect_async(chr);
>      }
>
> --
> 2.7.4
>
