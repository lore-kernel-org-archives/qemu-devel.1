Received: from eggs.gnu.org ([2001:4830:134:3::10]:41648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eijMF-0002AB-VE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eijMF-0003Rv-03
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:11:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eijME-0003Py-R0
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:11:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21210C051694
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 16:11:02 +0000 (UTC)
Date: Mon, 5 Feb 2018 17:10:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205171027.3bdacf54.cohuck@redhat.com>
In-Reply-To: <20180205152455.12088-2-berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
	<20180205152455.12088-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/9] char: don't silently skip tn3270
 protocol init when TLS is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon,  5 Feb 2018 15:24:47 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Even if common tn3270 implementations do not support TLS, it is trivial to
> have them proxied over a proxy like stunnel which adds TLS at the sockets
> layer. We should thus not silently skip tn3270 protocol initialization
> when TLS is enabled.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 77cdf487eb..5c46a89200 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -634,8 +634,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
>      if (qio_task_propagate_error(task, NULL)) {
>          tcp_chr_disconnect(chr);
>      } else {
> -        /* tn3270 does not support TLS yet */
> -        if (s->do_telnetopt && !s->is_tn3270) {
> +        if (s->do_telnetopt) {
>              tcp_chr_telnet_init(chr);
>          } else {
>              tcp_chr_connect(chr);

Acked-by: Cornelia Huck <cohuck@redhat.com>
