Received: from eggs.gnu.org ([2001:4830:134:3::10]:36260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ennzd-0007Kw-Hh
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ennzZ-0001hf-FD
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:08:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ennzZ-0001hQ-9M
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:08:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F158B8D742
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:08:36 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-3-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c180c02b-878e-4277-1851-ece19b8f8d27@redhat.com>
Date: Mon, 19 Feb 2018 17:08:33 +0100
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/8] net: List available netdevs with
 "-netdev help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 19/02/2018 10:15, Thomas Huth wrote:
> Other options like "-chardev" or "-device" feature a nice help text
> with the available devices when being called with "help" or "?".
> Since it is quite useful, especially if you want to see which network
> backends have been compiled into the QEMU binary, let's provide such
> a help text for "-netdev", too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index e213a61..08049d9 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1086,6 +1086,38 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
>      return 0;
>  }
>  
> +static void show_netdevs(void)
> +{
> +    int idx;
> +    const char *available_netdevs[] = {
> +        "socket",
> +        "hubport",
> +        "tap",
> +#ifdef CONFIG_SLIRP
> +        "user",
> +#endif
> +#ifdef CONFIG_L2TPV3
> +        "l2tpv3",
> +#endif
> +#ifdef CONFIG_VDE
> +        "vde",
> +#endif
> +#ifdef CONFIG_NET_BRIDGE
> +        "bridge",
> +#endif
> +#ifdef CONFIG_NETMAP
> +        "netmap",
> +#endif
> +#ifdef CONFIG_POSIX
> +        "vhost-user",
> +#endif
> +    };
> +
> +    printf("Available netdev backend types:\n");
> +    for (idx = 0; idx < ARRAY_SIZE(available_netdevs); idx++) {
> +        puts(available_netdevs[idx]);
> +    }
> +}
>  
>  int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>  {
> @@ -1094,7 +1126,10 @@ int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>      int ret = -1;
>      Visitor *v = opts_visitor_new(opts);
>  
> -    {
> +    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
> +        show_netdevs();
> +        exit(1);
> +    } else {
>          /* Parse convenience option format ip6-net=fec0::0[/64] */
>          const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
