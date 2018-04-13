Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6xIL-0006QO-Bi
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6xIF-0003oI-9z
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:55:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f6xIF-0003nA-3w
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:55:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50F874000712
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:54:58 +0000 (UTC)
Date: Fri, 13 Apr 2018 12:54:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180413115451.GD16263@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404112731.5922-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/8] qemu-sockets: Export
 SocketAddress_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Apr 04, 2018 at 01:27:24PM +0200, Juan Quintela wrote:
> Migration code needs that function in hmp.c (so we need to export it),
> and it needs it on tests/migration-test.c, so we need to move it to a
> place where it is compiled into the test framework.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  chardev/char-socket.c  | 29 -----------------------------
>  include/qemu/sockets.h |  3 +++
>  util/qemu-sockets.c    | 29 +++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 159e69c3b1..3bbf3a37a0 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -382,35 +382,6 @@ static void tcp_chr_free_connection(Chardev *chr)
>      s->connected = 0;
>  }
>  
> -static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
> -                                  bool is_listen, bool is_telnet)
> -{
> -    switch (addr->type) {
> -    case SOCKET_ADDRESS_TYPE_INET:
> -        return g_strdup_printf("%s%s:%s:%s%s", prefix,
> -                               is_telnet ? "telnet" : "tcp",
> -                               addr->u.inet.host,
> -                               addr->u.inet.port,
> -                               is_listen ? ",server" : "");
> -        break;
> -    case SOCKET_ADDRESS_TYPE_UNIX:
> -        return g_strdup_printf("%sunix:%s%s", prefix,
> -                               addr->u.q_unix.path,
> -                               is_listen ? ",server" : "");
> -        break;
> -    case SOCKET_ADDRESS_TYPE_FD:
> -        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
> -                               is_listen ? ",server" : "");
> -        break;
> -    case SOCKET_ADDRESS_TYPE_VSOCK:
> -        return g_strdup_printf("%svsock:%s:%s", prefix,
> -                               addr->u.vsock.cid,
> -                               addr->u.vsock.port);
> -    default:
> -        abort();
> -    }
> -}
> -
>  static void update_disconnected_filename(SocketChardev *s)
>  {
>      Chardev *chr = CHARDEV(s);
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 8140fea685..efea0ea850 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -110,4 +110,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
>   */
>  SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
>  
> +char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
> +                           bool is_listen, bool is_telnet);
> +
>  #endif /* QEMU_SOCKETS_H */
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 8bd8bb64eb..09f04bf76b 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1333,3 +1333,32 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
>  
>      return addr;
>  }
> +
> +char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
> +                                  bool is_listen, bool is_telnet)
> +{
> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        return g_strdup_printf("%s%s:%s:%s%s", prefix,
> +                               is_telnet ? "telnet" : "tcp",
> +                               addr->u.inet.host,
> +                               addr->u.inet.port,
> +                               is_listen ? ",server" : "");
> +        break;
> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        return g_strdup_printf("%sunix:%s%s", prefix,
> +                               addr->u.q_unix.path,
> +                               is_listen ? ",server" : "");
> +        break;
> +    case SOCKET_ADDRESS_TYPE_FD:
> +        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
> +                               is_listen ? ",server" : "");
> +        break;
> +    case SOCKET_ADDRESS_TYPE_VSOCK:
> +        return g_strdup_printf("%svsock:%s:%s", prefix,
> +                               addr->u.vsock.cid,
> +                               addr->u.vsock.port);
> +    default:
> +        abort();
> +    }
> +}

This code really does not belong in qemu-sockets.h - the syntax being
printed here is the chardev specific syntax, hence those is_listen and
is_telnet parameters. If we want a way to string-ify SocketAddress then
it should be a generic format, not the chardev format.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
