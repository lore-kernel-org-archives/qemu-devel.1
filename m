Received: from eggs.gnu.org ([2001:4830:134:3::10]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHf8-0008D2-JB
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHf3-0000Mt-DS
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:47:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZHf3-0000Ll-3L
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:47:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C619AA3276
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:47:23 +0000 (UTC)
References: <1515594755-12138-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a4ce09b-560b-1ef7-492c-aa88cf805fcc@redhat.com>
Date: Wed, 10 Jan 2018 15:47:18 +0100
MIME-Version: 1.0
In-Reply-To: <1515594755-12138-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 10/01/2018 15:32, Thomas Huth wrote:
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
> This patch adds this possibility by introducing a new "netdev=..."
> parameter to the hubports.
> 
> To bundle up the output of multiple NICs into one socket netdev, you can
> now run QEMU with these parameters for example:
> 
> qemu-system-ppc64 ... -netdev socket,id=s1,connect=:11122 \
>     -netdev hubport,hubid=1,id=h1,netdev=s1 \
>     -netdev hubport,hubid=1,id=h2 -device e1000,netdev=h2 \
>     -netdev hubport,hubid=1,id=h3 -device virtio-net-pci,netdev=h3
> 
> For using the socket netdev, you have got to start another QEMU as the
> receiving side first, for example with network dumping enabled:
> 
> qemu-system-x86_64 -M isapc -netdev socket,id=s0,listen=:11122 \
>     -device ne2k_isa,netdev=s0 \
>     -object filter-dump,id=f1,netdev=s0,file=/tmp/dump.dat
> 
> After the ppc64 guest tried to boot from both NICs, you can see in the
> dump file (using Wireshark, for example), that the output of both NICs
> (the e1000 and the virtio-net-pci) has been successfully transfered
> via the socket netdev in this case.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  See also the original discussion here for some more information:
>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05650.html
> 
>  net/hub.c       | 23 ++++++++++++++++++++++-
>  qapi/net.json   |  4 +++-
>  qemu-options.hx |  8 +++++---
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/net/hub.c b/net/hub.c
> index 14b4eec..0638729 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "monitor/monitor.h"
>  #include "net/net.h"
>  #include "clients.h"
> @@ -286,12 +287,32 @@ int net_init_hubport(const Netdev *netdev, const char *name,
>                       NetClientState *peer, Error **errp)
>  {
>      const NetdevHubPortOptions *hubport;
> +    NetClientState *hubncs;
>  
>      assert(netdev->type == NET_CLIENT_DRIVER_HUBPORT);
>      assert(!peer);
>      hubport = &netdev->u.hubport;
>  
> -    net_hub_add_port(hubport->hubid, name);
> +    hubncs = net_hub_add_port(hubport->hubid, name);
> +    if (!hubncs) {
> +        error_setg(errp, "failed to add port to hub %i with id '%s'",
> +                   hubport->hubid, name);
> +        return -1;
> +    }
> +
> +    if (hubport->has_netdev) {
> +        NetClientState *hubpeer;
> +
> +        hubpeer = qemu_find_netdev(hubport->netdev);
> +        if (!hubpeer) {
> +            error_setg(errp, "netdev '%s' not found", hubport->netdev);
> +            return -1;
> +        }
> +        assert(!hubncs->peer && !hubpeer->peer);
> +        hubncs->peer = hubpeer;
> +        hubpeer->peer = hubncs;
> +    }
> +
>      return 0;
>  }
>  
> diff --git a/qapi/net.json b/qapi/net.json
> index 4beff5d..e41e046 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -410,12 +410,14 @@
>  # Connect two or more net clients through a software hub.
>  #
>  # @hubid: hub identifier number
> +# @netdev: used to connect hub to a netdev instead of a device (since 2.12)
>  #
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevHubPortOptions',
>    'data': {
> -    'hubid':     'int32' } }
> +    'hubid':     'int32',
> +    '*netdev':    'str' } }
>  
>  ##
>  # @NetdevNetmapOptions:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 678181c..9ec4af7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2017,7 +2017,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>  #endif
>      "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
>      "                configure a vhost-user network, backed by a chardev 'dev'\n"
> -    "-netdev hubport,id=str,hubid=n\n"
> +    "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
>      "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
>  DEF("net", HAS_ARG, QEMU_OPTION_net,
>      "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
> @@ -2445,13 +2445,15 @@ vde_switch -F -sock /tmp/myswitch
>  qemu-system-i386 linux.img -net nic -net vde,sock=/tmp/myswitch
>  @end example
>  
> -@item -netdev hubport,id=@var{id},hubid=@var{hubid}
> +@item -netdev hubport,id=@var{id},hubid=@var{hubid}[,netdev=@var{nd}]
>  
>  Create a hub port on QEMU "vlan" @var{hubid}.
>  
>  The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of a single
>  netdev.  @code{-net} and @code{-device} with parameter @option{vlan} create the
> -required hub automatically.
> +required hub automatically. Alternatively, you can also connect the hubport
> +to another netdev with ID @var{nd} by using the @option{netdev=@var{nd}}
> +option.
>  
>  @item -netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
>  
> 

Thank you very much!

What is the next step for deprecating vlans?  I guess

1) removing the vlan property from DEFINE_NIC_PROPERTIES

2) removing the vlan property from -net, defaulting to vlan 0

3) only allow exactly two -net options, one for the backend (creating a
netdev) and one from the front-end (filling in nd_table)

?

Thanks,

Paolo
