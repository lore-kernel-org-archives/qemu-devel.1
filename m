Received: from eggs.gnu.org ([208.118.235.92]:45196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS60x-0005Mm-9m
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS60t-0006Lv-Ur
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:56:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS60t-0006KW-Kl
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:56:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B21C16A7D5
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 18:56:14 +0000 (UTC)
References: <20171221155905.3793-1-berrange@redhat.com>
	<20171221155905.3793-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb5ebf8c-64f4-15b5-ec1b-3788e87be2ca@redhat.com>
Date: Thu, 21 Dec 2017 12:56:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171221155905.3793-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] char: allow passing pre-opened
 socket file descriptor at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 12/21/2017 09:59 AM, Daniel P. Berrange wrote:
> When starting QEMU management apps will usually setup a monitor socket, and
> then open it immediately after startup. If not using QEMU's own -daemonize
> arg, this process can be troublesome to handle correctly. The mgmt app will
> need to repeatedly call connect() until it succeeds, because it does not
> know when QEMU has created the listener socket. If can't retry connect()
> forever though, because an error might have caused QEMU to exit before it
> even creates the monitor.
> 
> The obvious way to fix this kind of problem is to just pass in a pre-opened
> socket file descriptor for the QEMU monitor to listen on. The management app
> can now immediately call connect() just once. If connect() fails it knows
> that QEMU has exited with an error.
> 

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   chardev/char-socket.c |  32 ++++++++--
>   chardev/char.c        |   3 +
>   tests/test-char.c     | 173 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   util/qemu-sockets.c   |  42 +++++++++++-
>   4 files changed, 238 insertions(+), 12 deletions(-)
> 

> @@ -983,25 +984,36 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>       const char *path = qemu_opt_get(opts, "path");
>       const char *host = qemu_opt_get(opts, "host");
>       const char *port = qemu_opt_get(opts, "port");
> +    const char *fd = qemu_opt_get(opts, "fd");
>       const char *tls_creds = qemu_opt_get(opts, "tls-creds");
>       SocketAddressLegacy *addr;
>       ChardevSocket *sock;
>   
> +    if ((!!path + !!fd + !!host) != 1) {

I see you liked my suggestion for a compact rendering; the resulting 
line has more symbols than it does alphanumerics ;)


> +/* Syms in libqemustub.a are discarded at .o file granularity.
> + * To replace monitor_get_fd() we must ensure everything in
> + * stubs/monitor.c is defined, to make sure monitor.o is discarded
> + * otherwise we get duplicate syms at link time.
> + */
> +Monitor *cur_mon = NULL;

Patchew is correct that you can omit the ' = NULL'.

With that tweaked,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
