Received: from eggs.gnu.org ([2001:4830:134:3::10]:40498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eazNc-0005nE-Iz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eazNX-0004Mf-C4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:40:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eazNW-0004LE-Ro
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:40:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D28125D5EA
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 07:40:21 +0000 (UTC)
References: <1515594755-12138-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <73e534aa-ba61-e3ca-6730-3382f1c1ce1a@redhat.com>
Date: Mon, 15 Jan 2018 15:40:17 +0800
MIME-Version: 1.0
In-Reply-To: <1515594755-12138-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Allow hubports to connect to other
 netdevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B401=E6=9C=8810=E6=97=A5 22:32, Thomas Huth wrote:
> QEMU can emulate hubs to connect NICs and netdevs. This is currently
> primarily used for the mis-named 'vlan' feature of the networking
> subsystem. Now the 'vlan' feature has been marked as deprecated, since
> its name is rather confusing and the users often rather mis-configure
> their network when trying to use it. But while the 'vlan' parameter
> should be removed at one point in time, the basic idea of emulating
> a hub in QEMU is still good: It's useful for bundling up the output of
> multiple NICs into one single l2tp netdev for example.
>
> Now to be able to use the hubport feature without 'vlan's, there is one
> missing piece: The possibility to connect a hubport to a netdev, too.
> This patch adds this possibility by introducing a new "netdev=3D..."
> parameter to the hubports.
>
> To bundle up the output of multiple NICs into one socket netdev, you ca=
n
> now run QEMU with these parameters for example:
>
> qemu-system-ppc64 ... -netdev socket,id=3Ds1,connect=3D:11122 \
>      -netdev hubport,hubid=3D1,id=3Dh1,netdev=3Ds1 \
>      -netdev hubport,hubid=3D1,id=3Dh2 -device e1000,netdev=3Dh2 \
>      -netdev hubport,hubid=3D1,id=3Dh3 -device virtio-net-pci,netdev=3D=
h3
>
> For using the socket netdev, you have got to start another QEMU as the
> receiving side first, for example with network dumping enabled:
>
> qemu-system-x86_64 -M isapc -netdev socket,id=3Ds0,listen=3D:11122 \
>      -device ne2k_isa,netdev=3Ds0 \
>      -object filter-dump,id=3Df1,netdev=3Ds0,file=3D/tmp/dump.dat
>
> After the ppc64 guest tried to boot from both NICs, you can see in the
> dump file (using Wireshark, for example), that the output of both NICs
> (the e1000 and the virtio-net-pci) has been successfully transfered
> via the socket netdev in this case.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   See also the original discussion here for some more information:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05650.html
>
>   net/hub.c       | 23 ++++++++++++++++++++++-
>   qapi/net.json   |  4 +++-
>   qemu-options.hx |  8 +++++---
>   3 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/net/hub.c b/net/hub.c
> index 14b4eec..0638729 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -13,6 +13,7 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#include "qapi/error.h"
>   #include "monitor/monitor.h"
>   #include "net/net.h"
>   #include "clients.h"
> @@ -286,12 +287,32 @@ int net_init_hubport(const Netdev *netdev, const =
char *name,
>                        NetClientState *peer, Error **errp)
>   {
>       const NetdevHubPortOptions *hubport;
> +    NetClientState *hubncs;
>  =20
>       assert(netdev->type =3D=3D NET_CLIENT_DRIVER_HUBPORT);
>       assert(!peer);
>       hubport =3D &netdev->u.hubport;
>  =20
> -    net_hub_add_port(hubport->hubid, name);
> +    hubncs =3D net_hub_add_port(hubport->hubid, name);
> +    if (!hubncs) {
> +        error_setg(errp, "failed to add port to hub %i with id '%s'",
> +                   hubport->hubid, name);
> +        return -1;
> +    }
> +
> +    if (hubport->has_netdev) {
> +        NetClientState *hubpeer;
> +
> +        hubpeer =3D qemu_find_netdev(hubport->netdev);
> +        if (!hubpeer) {
> +            error_setg(errp, "netdev '%s' not found", hubport->netdev)=
;
> +            return -1;
> +        }
> +        assert(!hubncs->peer && !hubpeer->peer);
> +        hubncs->peer =3D hubpeer;
> +        hubpeer->peer =3D hubncs;
> +    }
> +

Instead of open coding here, maybe you can pass peer to=20
net_hub_port_new() and let qemu_new_net_client() do this for you.

And since it was a hub, do we need to send to its netdev too inside=20
net_hub_receive()?

Thanks

>       return 0;
>   }
>  =20
> diff --git a/qapi/net.json b/qapi/net.json
> index 4beff5d..e41e046 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -410,12 +410,14 @@
>   # Connect two or more net clients through a software hub.
>   #
>   # @hubid: hub identifier number
> +# @netdev: used to connect hub to a netdev instead of a device (since =
2.12)
>   #
>   # Since: 1.2
>   ##
>   { 'struct': 'NetdevHubPortOptions',
>     'data': {
> -    'hubid':     'int32' } }
> +    'hubid':     'int32',
> +    '*netdev':    'str' } }
>  =20
>   ##
>   # @NetdevNetmapOptions:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 678181c..9ec4af7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2017,7 +2017,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>   #endif
>       "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]\=
n"
>       "                configure a vhost-user network, backed by a char=
dev 'dev'\n"
> -    "-netdev hubport,id=3Dstr,hubid=3Dn\n"
> +    "-netdev hubport,id=3Dstr,hubid=3Dn[,netdev=3Dnd]\n"
>       "                configure a hub port on QEMU VLAN 'n'\n", QEMU_A=
RCH_ALL)
>   DEF("net", HAS_ARG, QEMU_OPTION_net,
>       "-net nic[,vlan=3Dn][,netdev=3Dnd][,macaddr=3Dmac][,model=3Dtype]=
[,name=3Dstr][,addr=3Dstr][,vectors=3Dv]\n"
> @@ -2445,13 +2445,15 @@ vde_switch -F -sock /tmp/myswitch
>   qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
>   @end example
>  =20
> -@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}
> +@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}[,netdev=3D@var=
{nd}]
>  =20
>   Create a hub port on QEMU "vlan" @var{hubid}.
>  =20
>   The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of=
 a single
>   netdev.  @code{-net} and @code{-device} with parameter @option{vlan} =
create the
> -required hub automatically.
> +required hub automatically. Alternatively, you can also connect the hu=
bport
> +to another netdev with ID @var{nd} by using the @option{netdev=3D@var{=
nd}}
> +option.
>  =20
>   @item -netdev vhost-user,chardev=3D@var{id}[,vhostforce=3Don|off][,qu=
eues=3Dn]
>  =20
