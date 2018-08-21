Received: from eggs.gnu.org ([2001:4830:134:3::10]:34273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1frxUk-0005QE-4P
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1frxJt-0001H0-Rz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:27:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1frxJt-0001GL-Lu
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:27:01 -0400
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-16-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f5b85e98-29ed-86e0-4497-7a63b61a663b@redhat.com>
Date: Tue, 21 Aug 2018 11:26:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180811205924.4113-16-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 15/20] net/net.c: Add net client type
 check function for COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>



On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> We add is_colo_support_client_type() to check the net client type for
> COLO-compare. Currently we just support TAP.
> Suggested by Jason.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---

This needs more works:

- Forbid vhost
- Deal with hotplug

Looks not a must for this series, so to speed up the process, you may do=20
it on top.

Thanks

>   include/net/net.h  |  1 +
>   net/colo-compare.c |  5 +++++
>   net/net.c          | 14 ++++++++++++++
>   3 files changed, 20 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 1425960f76..dcbc7ba9c0 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -212,6 +212,7 @@ void hmp_host_net_add(Monitor *mon, const QDict *qd=
ict);
>   void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
>   void netdev_add(QemuOpts *opts, Error **errp);
>   void qmp_netdev_add(QDict *qdict, QObject **ret, Error **errp);
> +bool is_colo_support_client_type(void);
>  =20
>   int net_hub_id_for_client(NetClientState *nc, int *id);
>   NetClientState *net_hub_port_find(int hub_id);
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 426eab5973..b8c0240725 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -996,6 +996,11 @@ static void colo_compare_complete(UserCreatable *u=
c, Error **errp)
>           return;
>       }
>  =20
> +    if (!is_colo_support_client_type()) {
> +        error_setg(errp, "COLO-compare: Net client type is not support=
ed");
> +        return;
> +    }
> +
>       net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_h=
dr);
>       net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_h=
dr);
>  =20
> diff --git a/net/net.c b/net/net.c
> index 2a3133990c..a77ea88fff 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1733,3 +1733,17 @@ int net_fill_rstate(SocketReadState *rs, const u=
int8_t *buf, int size)
>       assert(size =3D=3D 0);
>       return 0;
>   }
> +
> +/* Currently, COLO just support TAP */
> +bool is_colo_support_client_type(void)
> +{
> +    NetClientState *nc;
> +
> +    QTAILQ_FOREACH(nc, &net_clients, next) {
> +        if (nc->info->type !=3D NET_CLIENT_DRIVER_TAP) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
