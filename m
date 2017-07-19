Received: from eggs.gnu.org ([2001:4830:134:3::10]:50340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXi0h-0007NQ-Uy
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXi0d-0000wA-4H
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dXi0c-0000vy-Qr
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:58:55 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
Date: Wed, 19 Jul 2017 13:58:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] Unified Datagram Socket Transport -
 raw support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 01:08, anton.ivanov@cambridgegreys=
.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> This adds raw socket support to the unified socket driver.

Interesting, in fact, I've finished a tpacket backend. Let me post it=20
sometime after hardfreeze.

> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   net/Makefile.objs |   2 +-
>   net/clients.h     |   3 ++
>   net/net.c         |   5 +++
>   net/raw.c         | 123 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   qapi-schema.json  |  25 +++++++++--
>   qemu-options.hx   |  33 +++++++++++++++
>   6 files changed, 186 insertions(+), 5 deletions(-)
>   create mode 100644 net/raw.c
>
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index 128164e39b..54cf7dd194 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-y =3D net.o queue.o checksum.o util.o hub.o
>   common-obj-y +=3D socket.o
>   common-obj-y +=3D dump.o
>   common-obj-y +=3D eth.o
> -common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3.o unified.o gre.o
> +common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3.o unified.o gre.o raw.o
>   common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
>   common-obj-$(CONFIG_SLIRP) +=3D slirp.o
>   common-obj-$(CONFIG_VDE) +=3D vde.o
> diff --git a/net/clients.h b/net/clients.h
> index 8f8a59aee3..98d8ae59b7 100644
> --- a/net/clients.h
> +++ b/net/clients.h
> @@ -53,6 +53,9 @@ int net_init_l2tpv3(const Netdev *netdev, const char =
*name,
>   int net_init_gre(const Netdev *netdev, const char *name,
>                       NetClientState *peer, Error **errp);
>  =20
> +int net_init_raw(const Netdev *netdev, const char *name,
> +                    NetClientState *peer, Error **errp);
> +
>   #ifdef CONFIG_VDE
>   int net_init_vde(const Netdev *netdev, const char *name,
>                    NetClientState *peer, Error **errp);
> diff --git a/net/net.c b/net/net.c
> index b75b6e8154..2d988a120c 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -962,6 +962,7 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
>   #ifdef CONFIG_UNIFIED
>           [NET_CLIENT_DRIVER_L2TPV3] =3D net_init_l2tpv3,
>           [NET_CLIENT_DRIVER_GRE] =3D net_init_gre,
> +        [NET_CLIENT_DRIVER_RAW] =3D net_init_raw,
>   #endif
>   };
>  =20
> @@ -1017,6 +1018,10 @@ static int net_client_init1(const void *object, =
bool is_netdev, Error **errp)
>               legacy.type =3D NET_CLIENT_DRIVER_GRE;
>               legacy.u.gre =3D opts->u.gre;
>               break;
> +        case NET_LEGACY_OPTIONS_TYPE_RAW:
> +            legacy.type =3D NET_CLIENT_DRIVER_RAW;
> +            legacy.u.raw =3D opts->u.raw;
> +            break;
>           case NET_LEGACY_OPTIONS_TYPE_SOCKET:
>               legacy.type =3D NET_CLIENT_DRIVER_SOCKET;
>               legacy.u.socket =3D opts->u.socket;
> diff --git a/net/raw.c b/net/raw.c
> new file mode 100644
> index 0000000000..73e2fd9fe3
> --- /dev/null
> +++ b/net/raw.c
> @@ -0,0 +1,123 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2015-2017 Cambridge Greys Limited
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2012-2014 Cisco Systems
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/ip.h>
> +#include <netdb.h>
> +#include <sys/ioctl.h>
> +#include <net/if.h>
> +#include "net/net.h"
> + #include <sys/socket.h>
> +#include <linux/if_packet.h>
> +#include <net/ethernet.h>
> +#include "clients.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/sockets.h"
> +#include "qemu/iov.h"
> +#include "qemu/main-loop.h"
> +#include "unified.h"
> +
> +static int noop(void *us, uint8_t *buf)
> +{
> +    return 0;
> +}
> +
> +int net_init_raw(const Netdev *netdev,
> +                    const char *name,
> +                    NetClientState *peer, Error **errp)
> +{
> +
> +    const NetdevRawOptions *raw;
> +    NetUnifiedState *s;
> +    NetClientState *nc;
> +
> +    int fd =3D -1;
> +    int err;
> +
> +    struct ifreq ifr;
> +    struct sockaddr_ll sock;
> +
> +
> +    nc =3D qemu_new_unified_net_client(name, peer);
> +
> +    s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +
> +    fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> +    if (fd =3D=3D -1) {
> +        err =3D -errno;
> +        error_report("raw_open : raw socket creation failed, errno =3D=
 %d", -err);
> +        goto outerr;
> +    }
> +
> +
> +    s->form_header =3D NULL;
> +    s->verify_header =3D &noop;
> +    s->queue_head =3D 0;
> +    s->queue_tail =3D 0;
> +    s->header_mismatch =3D false;
> +    s->dgram_dst =3D NULL;
> +    s->dst_size =3D 0;
> +
> +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_RAW);
> +    raw =3D &netdev->u.raw;
> +
> +    memset(&ifr, 0, sizeof(struct ifreq));
> +    strncpy((char *) &ifr.ifr_name, raw->ifname, sizeof(ifr.ifr_name) =
- 1);
> +
> +    if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
> +        err =3D -errno;
> +        error_report("SIOCGIFINDEX, failed to get raw interface index =
for %s",
> +            raw->ifname);
> +        goto outerr;
> +    }
> +
> +    sock.sll_family =3D AF_PACKET;
> +    sock.sll_protocol =3D htons(ETH_P_ALL);
> +    sock.sll_ifindex =3D ifr.ifr_ifindex;
> +
> +    if (bind(fd, (struct sockaddr *) &sock, sizeof(struct sockaddr_ll)=
) < 0) {
> +        error_report("raw: failed to bind raw socket");
> +        err =3D -errno;
> +        goto outerr;
> +    }
> +
> +    s->offset =3D 0;
> +
> +    qemu_net_finalize_unified_init(s, fd);
> +
> +    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
> +             "raw: connected");
> +    return 0;
> +outerr:
> +    qemu_del_net_client(nc);
> +    if (fd >=3D 0) {
> +        close(fd);
> +    }
> +    return -1;
> +}
> +
> diff --git a/qapi-schema.json b/qapi-schema.json
> index aec303a14e..cde78ce3a1 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3883,6 +3883,21 @@
>       '*txkey':    'uint32',
>       '*rxkey':    'uint32' } }
>   ##
> +# @NetdevRawOptions:
> +#
> +# Connect the VLAN to an network interface using raw sockets
> +#
> +# @ifname: network interface name
> +#
> +
> +# Since 2.9

2.11.

> +##
> +{ 'struct': 'NetdevRawOptions',
> +  'data': {
> +    'ifname':          'str'
> +} }
> +
> +##
>   # @NetdevVdeOptions:
>   #
>   # Connect the VLAN to a vde switch running on the host.
> @@ -4000,7 +4015,7 @@
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', =
'dump',
> -            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre', 'raw' =
] }
>  =20
>   ##
>   # @Netdev:
> @@ -4031,7 +4046,8 @@
>       'hubport':  'NetdevHubPortOptions',
>       'netmap':   'NetdevNetmapOptions',
>       'vhost-user': 'NetdevVhostUserOptions',
> -    'gre':      'NetdevGREOptions' } }
> +    'gre':      'NetdevGREOptions',
> +    'raw':      'NetdevRawOptions' } }
>  =20
>   ##
>   # @NetLegacy:
> @@ -4062,7 +4078,7 @@
>   ##
>   { 'enum': 'NetLegacyOptionsType',
>     'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -           'dump', 'bridge', 'netmap', 'vhost-user', 'gre'] }
> +           'dump', 'bridge', 'netmap', 'vhost-user', 'gre', 'raw'] }
>  =20
>   ##
>   # @NetLegacyOptions:
> @@ -4086,7 +4102,8 @@
>       'bridge':   'NetdevBridgeOptions',
>       'netmap':   'NetdevNetmapOptions',
>       'vhost-user': 'NetdevVhostUserOptions',
> -    'gre':      'NetdevGREOptions' } }
> +    'gre':      'NetdevGREOptions',
> +    'raw':      'NetdevRawOptions' } }
>  =20
>   ##
>   # @NetFilterDirection:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6f8d5cbe21..d9db8b576b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1988,6 +1988,13 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "                use 'txkey=3D0x01234' to specify a txkey\n"
>       "                use 'sequence=3Don' to add frame sequence to eac=
h packet\n"
>       "                use 'pinsequence=3Don' to work around broken seq=
uence handling in peer\n"
> +    "-netdev raw,id=3Dstr,ifname=3Difname\n"
> +    "                configure a network backend with ID 'str' connect=
ed to\n"
> +    "                an Ethernet interface named ifname via raw socket=
.\n"
> +    "                This backend does not change the interface settin=
gs.\n"
> +    "                Most interfaces will require being set into promi=
sc mode,\n"
> +    "                as well having most offloads (TSO, etc) turned of=
f.\n"
> +    "                Some virtual interfaces like tap support only RX.=
\n"

Pay attention that qemu supports vnet header. So any reason to turn off=20
e.g TSO here?

>   #endif
>       "-netdev socket,id=3Dstr[,fd=3Dh][,listen=3D[host]:port][,connect=
=3Dhost:port]\n"
>       "                configure a network backend to connect to anothe=
r network\n"
> @@ -2463,6 +2470,32 @@ qemu-system-i386 linux.img -net nic -net gre,src=
=3D4.2.3.1,dst=3D1.2.3.4
>  =20
>   @end example
>  =20
> +@item -netdev raw,id=3D@var{id},ifname=3D@var{ifname}
> +@itemx -net raw[,vlan=3D@var{n}][,name=3D@var{name}],ifname=3D@var{ifn=
ame}
> +Connect VLAN @var{n} directly to an Ethernet interface using raw socke=
t.
> +
> +This transport allows a VM to bypass most of the network stack which i=
s
> +extremely useful for tapping.
> +
> +@item ifname=3D@var{ifname}
> +    interface name (mandatory)
> +
> +@example
> +# set up the interface - put it in promiscuous mode and turn off offlo=
ads
> +ifconfig eth0 up
> +ifconfig eth0 promisc
> +
> +/sbin/ethtool -K eth0 gro off
> +/sbin/ethtool -K eth0 tso off
> +/sbin/ethtool -K eth0 gso off
> +/sbin/ethtool -K eth0 tx off

Any reason to turn off tx here?

> +
> +# launch QEMU instance - if your network has reorder or is very lossy =
add ,pincounter
> +
> +qemu-system-i386 linux.img -net nic -net raw,ifname=3Deth0

Can we switch to use -netdev here?

Thanks

> +
> +@end example
> +
>   @item -netdev vde,id=3D@var{id}[,sock=3D@var{socketpath}][,port=3D@va=
r{n}][,group=3D@var{groupname}][,mode=3D@var{octalmode}]
>   @itemx -net vde[,vlan=3D@var{n}][,name=3D@var{name}][,sock=3D@var{soc=
ketpath}] [,port=3D@var{n}][,group=3D@var{groupname}][,mode=3D@var{octalm=
ode}]
>   Connect VLAN @var{n} to PORT @var{n} of a vde switch running on host =
and
