Received: from eggs.gnu.org ([2001:4830:134:3::10]:52923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBre4-0005Lc-TA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBre1-0007er-PX
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:49:20 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBre1-0007en-K6
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:49:17 -0400
Received: by mail-oi0-x244.google.com with SMTP id w10so14725725oif.1
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 16:49:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f47c587-279c-212c-b8c8-08a8168c1b43@amsat.org>
Date: Fri, 19 May 2017 20:49:15 -0300
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-3-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] sockets: don't block IPv4 clients
 when listening on "::"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 05/19/2017 03:03 PM, Daniel P. Berrange wrote:
> When inet_parse() parses the hostname, it is forcing the
> has_ipv6 && ipv6 flags if the address contains a ":". This
> means that if the user had set the ipv4=on flag, to try to
> restrict the listener to just ipv4, an error would not have
> been raised.  eg
>
>    -incoming tcp:[::]:9000,ipv4
>
> should have raised an error because listening for IPv4
> on "::" is a non-sensical combination. With this removed,
> we now call getaddrinfo() on "::" passing PF_INET and
> so getaddrinfo reports an error about the hostname being
> incompatible with the requested protocol.
>
> Likewise it is explicitly setting the has_ipv4 & ipv4
> flags when the address contains only digits + '.'. This
> has no ill-effect, but also has no benefit, so is removed.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/qemu-sockets.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 397212b..b82412e 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -618,16 +618,12 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
>              error_setg(errp, "error parsing IPv6 address '%s'", str);
>              return -1;
>          }
> -        addr->ipv6 = addr->has_ipv6 = true;
>      } else {
>          /* hostname or IPv4 addr */
>          if (sscanf(str, "%64[^:]:%32[^,]%n", host, port, &pos) != 2) {
>              error_setg(errp, "error parsing address '%s'", str);
>              return -1;
>          }
> -        if (host[strspn(host, "0123456789.")] == '\0') {
> -            addr->ipv4 = addr->has_ipv4 = true;
> -        }
>      }
>
>      addr->host = g_strdup(host);
>
