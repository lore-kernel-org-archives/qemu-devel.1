Received: from [2001:4830:134:3::10] (port=60414 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fpd1J-0006fJ-6o
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fpd1D-0002cR-Hn
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:08 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fpd1D-0002cD-5r
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11-v6so12936931wmc.2
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 10:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180813102037.12097-1-jusual@mail.ru>
In-Reply-To: <20180813102037.12097-1-jusual@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Aug 2018 17:11:13 +0100
Message-ID: <CAJSP0QWWoAzG9Jtfb1mr=OVhf6eozv37GBjgXXMsOZzk=LBFWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On Mon, Aug 13, 2018 at 11:20 AM Julia Suvorova <jusual@mail.ru> wrote:
> New option "websock" added to allow using websocket protocol for
> chardev socket backend.
> Example:
>     -chardev socket,websock,id=...
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  chardev/char-socket.c | 75 ++++++++++++++++++++++++++++++++++++-------
>  chardev/char.c        |  3 ++
>  qapi/char.json        |  3 ++
>  3 files changed, 70 insertions(+), 11 deletions(-)

Is there a tests/test-char.c test case for this?  Transmit, receive,
and closing the connection can be tested.

> +static void tcp_chr_websock_init(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +    QIOChannelWebsock *wioc;
> +    gchar *name;
> +
> +    if (s->is_listen) {
> +        wioc = qio_channel_websock_new_server(s->ioc);
> +    } else {
> +        /* Websocket client is not yet implemented */
> +        return;

What happens in this error case?  Does the user get a useful error?

If not, it may be necessary to pass Error *errp through so this
function can report that initialization failed because client mode is
not implemented.
