Received: from eggs.gnu.org ([2001:4830:134:3::10]:43963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSJRV-0005b7-Jh
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSJRQ-0008Bg-Ns
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:48:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fSJRQ-0008BW-I0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:48:48 -0400
References: <20180611092305.2542-1-lma@suse.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5cac7e34-4f6f-99f1-a75f-7a2b57d3cb34@redhat.com>
Date: Mon, 11 Jun 2018 11:48:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180611092305.2542-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] net: Fix a potential segfault
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

On 11.06.2018 11:23, Lin Ma wrote:
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
> 
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  net/net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index efb9eaf779..2a3133990c 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1093,7 +1093,9 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>      int ret = -1;
>      Visitor *v = opts_visitor_new(opts);
>  
> -    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
> +    const char *type = qemu_opt_get(opts, "type");
> +
> +    if (is_netdev && type && is_help_option(type)) {
>          show_netdevs();
>          exit(0);
>      } else {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
