Received: from eggs.gnu.org ([2001:4830:134:3::10]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBriH-0006KT-RX
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBriE-0000Lo-Ok
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:53:41 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBriE-0000Lk-K0
	for qemu-devel@nongnu.org; Fri, 19 May 2017 19:53:38 -0400
Received: by mail-oi0-x244.google.com with SMTP id m17so14724653oik.2
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 16:53:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6fa15da-e036-5450-2400-46805c170c62@amsat.org>
Date: Fri, 19 May 2017 20:53:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-5-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] io: preserve ipv4/ipv6 flags when
 resolving InetSocketAddress
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
> The original InetSocketAddress struct may have has_ipv4 and
> has_ipv6 fields set, which will control both the ai_family
> used during DNS resolution, and later use of the V6ONLY
> flag.
>
> Currently the standalone DNS resolver code drops the
> has_ipv4 & has_ipv6 flags after resolving, which means
> the later bind() code won't correctly set V6ONLY.
>
> This fixes the following scenarios
>
>   -vnc :0,ipv4=off
>   -vnc :0,ipv6=on
>   -vnc :::0,ipv4=off
>   -vnc :::0,ipv6=on
>
> which all mistakenly accepted IPv4 clients
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  io/dns-resolver.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index 57a8896..c072d12 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -116,8 +116,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
>              .numeric = true,
>              .has_to = iaddr->has_to,
>              .to = iaddr->to,
> -            .has_ipv4 = false,
> -            .has_ipv6 = false,
> +            .has_ipv4 = iaddr->has_ipv4,
> +            .ipv4 = iaddr->ipv4,
> +            .has_ipv6 = iaddr->has_ipv6,
> +            .ipv6 = iaddr->ipv6,
>          };
>
>          (*addrs)[i] = newaddr;
>
