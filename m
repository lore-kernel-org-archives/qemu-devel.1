Received: from eggs.gnu.org ([2001:4830:134:3::10]:36154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ennzK-00075x-7V
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ennzG-0001XM-3a
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:08:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ennzF-0001Wg-U3
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:08:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E7E280401C1
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:08:05 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-2-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f318077-0e70-df8e-dd50-9ca3def2caee@redhat.com>
Date: Mon, 19 Feb 2018 17:07:57 +0100
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/8] net: Move error reporting from
 net_init_client/netdev to the calling site
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
> It looks strange that net_init_client() and net_init_netdev() both
> take an "Error **errp" parameter, but then do the error reporting
> with "error_report_err(local_err)" on their own. Let's move the
> error reporting to the calling site instead to simplify this code
> a little bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/net/net.h |  2 +-
>  net/net.c         | 29 +++++------------------------
>  vl.c              |  3 ++-
>  3 files changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 3fc48e4..bdd4d9f 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -206,7 +206,7 @@ extern const char *legacy_bootp_filename;
>  
>  int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp);
>  int net_client_parse(QemuOptsList *opts_list, const char *str);
> -int net_init_clients(void);
> +int net_init_clients(Error **errp);
>  void net_check_clients(void);
>  void net_cleanup(void);
>  void hmp_host_net_add(Monitor *mon, const QDict *qdict);
> diff --git a/net/net.c b/net/net.c
> index 7d42925..e213a61 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1520,46 +1520,27 @@ void net_check_clients(void)
>  
>  static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
>  {
> -    Error *local_err = NULL;
> -
> -    net_client_init(opts, false, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return -1;
> -    }
> -
> -    return 0;
> +    return net_client_init(opts, false, errp);
>  }
>  
>  static int net_init_netdev(void *dummy, QemuOpts *opts, Error **errp)
>  {
> -    Error *local_err = NULL;
> -    int ret;
> -
> -    ret = net_client_init(opts, true, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return -1;
> -    }
> -
> -    return ret;
> +    return net_client_init(opts, true, errp);
>  }
>  
> -int net_init_clients(void)
> +int net_init_clients(Error **errp)
>  {
> -    QemuOptsList *net = qemu_find_opts("net");
> -
>      net_change_state_entry =
>          qemu_add_vm_change_state_handler(net_vm_change_state_handler, NULL);
>  
>      QTAILQ_INIT(&net_clients);
>  
>      if (qemu_opts_foreach(qemu_find_opts("netdev"),
> -                          net_init_netdev, NULL, NULL)) {
> +                          net_init_netdev, NULL, errp)) {
>          return -1;
>      }
>  
> -    if (qemu_opts_foreach(net, net_init_client, NULL, NULL)) {
> +    if (qemu_opts_foreach(qemu_find_opts("net"), net_init_client, NULL, errp)) {
>          return -1;
>      }
>  
> diff --git a/vl.c b/vl.c
> index 7a5554b..7e95711 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4487,7 +4487,8 @@ int main(int argc, char **argv, char **envp)
>  
>      colo_info_init();
>  
> -    if (net_init_clients() < 0) {
> +    if (net_init_clients(&err) < 0) {
> +        error_report_err(err);
>          exit(1);
>      }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
