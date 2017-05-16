Received: from eggs.gnu.org ([2001:4830:134:3::10]:38835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWLn-0005ww-JU
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWLk-0000fu-GT
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:52:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAWLk-0000eQ-6O
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:52:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CEA237E67
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 06:52:51 +0000 (UTC)
References: <1494855176-11127-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b2038184-d924-5c6a-585c-376b8e16d341@redhat.com>
Date: Tue, 16 May 2017 14:52:45 +0800
MIME-Version: 1.0
In-Reply-To: <1494855176-11127-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp / net: Mark host_net_add/remove as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com



On 2017=E5=B9=B405=E6=9C=8815=E6=97=A5 21:32, Thomas Huth wrote:
> The netdev_add and netdev_del commands should be used nowadays instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hmp-commands.hx |  8 ++++----
>   net/net.c       | 13 +++++++++++++
>   2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 0aca984..baeac47 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1296,7 +1296,7 @@ ETEXI
>           .name       =3D "host_net_add",
>           .args_type  =3D "device:s,opts:s?",
>           .params     =3D "tap|user|socket|vde|netmap|bridge|vhost-user=
|dump [options]",
> -        .help       =3D "add host VLAN client",
> +        .help       =3D "add host VLAN client (deprecated, use netdev_=
add instead)",
>           .cmd        =3D hmp_host_net_add,
>           .command_completion =3D host_net_add_completion,
>       },
> @@ -1304,14 +1304,14 @@ ETEXI
>   STEXI
>   @item host_net_add
>   @findex host_net_add
> -Add host VLAN client.
> +Add host VLAN client. Deprecated, please use @code{netdev_add} instead=
.
>   ETEXI
>  =20
>       {
>           .name       =3D "host_net_remove",
>           .args_type  =3D "vlan_id:i,device:s",
>           .params     =3D "vlan_id name",
> -        .help       =3D "remove host VLAN client",
> +        .help       =3D "remove host VLAN client (deprecated, use netd=
ev_del instead)",
>           .cmd        =3D hmp_host_net_remove,
>           .command_completion =3D host_net_remove_completion,
>       },
> @@ -1319,7 +1319,7 @@ ETEXI
>   STEXI
>   @item host_net_remove
>   @findex host_net_remove
> -Remove host VLAN client.
> +Remove host VLAN client. Deprecated, please use @code{netdev_del} inst=
ead.
>   ETEXI
>  =20
>       {
> diff --git a/net/net.c b/net/net.c
> index 0ac3b9e..6235aab 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -45,6 +45,7 @@
>   #include "qapi-visit.h"
>   #include "qapi/opts-visitor.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
>   #include "net/filter.h"
>   #include "qapi/string-output-visitor.h"
>  =20
> @@ -1149,6 +1150,12 @@ void hmp_host_net_add(Monitor *mon, const QDict =
*qdict)
>       const char *opts_str =3D qdict_get_try_str(qdict, "opts");
>       Error *local_err =3D NULL;
>       QemuOpts *opts;
> +    static bool warned;
> +
> +    if (!warned && !qtest_enabled()) {
> +        error_report("host_net_add is deprecated, use netdev_add inste=
ad");
> +        warned =3D true;
> +    }
>  =20
>       if (!net_host_check_device(device)) {
>           monitor_printf(mon, "invalid host network device %s\n", devic=
e);
> @@ -1175,6 +1182,12 @@ void hmp_host_net_remove(Monitor *mon, const QDi=
ct *qdict)
>       NetClientState *nc;
>       int vlan_id =3D qdict_get_int(qdict, "vlan_id");
>       const char *device =3D qdict_get_str(qdict, "device");
> +    static bool warned;
> +
> +    if (!warned && !qtest_enabled()) {
> +        error_report("host_net_remove is deprecated, use netdev_del in=
stead");
> +        warned =3D true;
> +    }
>  =20
>       nc =3D net_hub_find_client_by_name(vlan_id, device);
>       if (!nc) {

Applied, thanks.
