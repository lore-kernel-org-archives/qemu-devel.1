Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSHWs-0001CM-S8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSHWp-0002YQ-PM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:46:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fSHWp-0002Xz-Ko
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:46:15 -0400
References: <20180611070609.9482-1-lma@suse.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <739f8a81-a519-9eb2-8b6e-8e7bf9e2ff81@redhat.com>
Date: Mon, 11 Jun 2018 09:46:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180611070609.9482-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] net: Fix a potential segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

On 11.06.2018 09:06, Lin Ma wrote:
> If user forgets to provide any backend types for '-netdev' in qemu CLI,
> It triggers seg fault.
> 
> e.g.
> 
> Expected:
> $ qemu -netdev id=net0
> qemu-system-x86_64: Parameter 'type' is missing
> 
> Actual:
> $ qemu -netdev id=net0
> Segmentation fault (core dumped)

Ok, thanks for adding the description!

> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  net/net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/net.c b/net/net.c
> index efb9eaf779..f89790be4a 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1093,9 +1093,12 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>      int ret = -1;
>      Visitor *v = opts_visitor_new(opts);
>  
> -    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
> -        show_netdevs();
> -        exit(0);
> +    if (is_netdev) {
> +        const char *type = qemu_opt_get(opts, "type");
> +        if (type && is_help_option(type)) {
> +            show_netdevs();
> +            exit(0);
> +        }
>      } else {
>          /* Parse convenience option format ip6-net=fec0::0[/64] */
>          const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
> 

I think you've got to do it in a slightly different way:

    const char *type = qemu_opt_get(opts, "type");

    if (is_netdev && type && is_help_option(type)) {
        show_netdevs();
        exit(0);
    } else ...

otherwise the "else" branch is not entered anymore in case it is a
non-help netdev option.

 Thomas
