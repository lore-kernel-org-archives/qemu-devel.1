Received: from eggs.gnu.org ([2001:4830:134:3::10]:48771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXhqH-00045V-GV
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXhqE-0004c1-Dz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dXhqE-0004bW-41
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:48:10 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <66610532-7bc7-b777-29ae-d6f7d3fe8b23@redhat.com>
Date: Wed, 19 Jul 2017 13:48:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport -
 GRE support
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
> This adds GRETAP support to the unified socket driver.
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   net/Makefile.objs |   2 +-
>   net/clients.h     |   4 +
>   net/gre.c         | 313 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   net/net.c         |   5 +
>   qapi-schema.json  |  46 +++++++-
>   qemu-options.hx   |  63 ++++++++++-
>   6 files changed, 425 insertions(+), 8 deletions(-)
>   create mode 100644 net/gre.c
>
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index 8026ad778a..128164e39b 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-y =3D net.o queue.o checksum.o util.o hub.o
>   common-obj-y +=3D socket.o
>   common-obj-y +=3D dump.o
>   common-obj-y +=3D eth.o
> -common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3.o unified.o
> +common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3.o unified.o gre.o
>   common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
>   common-obj-$(CONFIG_SLIRP) +=3D slirp.o
>   common-obj-$(CONFIG_VDE) +=3D vde.o
> diff --git a/net/clients.h b/net/clients.h
> index 5cae479730..8f8a59aee3 100644
> --- a/net/clients.h
> +++ b/net/clients.h
> @@ -49,6 +49,10 @@ int net_init_bridge(const Netdev *netdev, const char=
 *name,
>  =20
>   int net_init_l2tpv3(const Netdev *netdev, const char *name,
>                       NetClientState *peer, Error **errp);
> +
> +int net_init_gre(const Netdev *netdev, const char *name,
> +                    NetClientState *peer, Error **errp);
> +
>   #ifdef CONFIG_VDE
>   int net_init_vde(const Netdev *netdev, const char *name,
>                    NetClientState *peer, Error **errp);
> diff --git a/net/gre.c b/net/gre.c
> new file mode 100644
> index 0000000000..ee8c36dd4d
> --- /dev/null
> +++ b/net/gre.c
> @@ -0,0 +1,313 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2015-2017 Cambridge GREys Limited
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
> +#include "net/net.h"
> +#include "clients.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/sockets.h"
> +#include "qemu/iov.h"
> +#include "qemu/main-loop.h"
> +#include "unified.h"
> +
> +/* IANA-assigned IP protocol ID for GRE */
> +
> +
> +#ifndef IPPROTO_GRE
> +#define IPPROTO_GRE 0x2F
> +#endif
> +
> +#define GRE_MODE_CHECKSUM     htons(8 << 12)   /* checksum */
> +#define GRE_MODE_RESERVED     htons(4 << 12)   /* unused */
> +#define GRE_MODE_KEY          htons(2 << 12)   /* KEY present */
> +#define GRE_MODE_SEQUENCE     htons(1 << 12)   /* no sequence */
> +
> +
> +/* GRE TYPE for Ethernet in GRE aka GRETAP */
> +
> +#define GRE_IRB htons(0x6558)
> +
> +struct gre_minimal_header {
> +   uint16_t header;
> +   uint16_t arptype;
> +};
> +
> +typedef struct GRETunnelParams {
> +    /*
> +     * GRE parameters
> +     */
> +
> +    uint32_t rx_key;
> +    uint32_t tx_key;
> +    uint32_t sequence;
> +
> +    /* Flags */
> +
> +    bool ipv6;
> +    bool udp;
> +    bool has_sequence;
> +    bool pin_sequence;
> +    bool checksum;
> +    bool key;
> +
> +    /* Precomputed GRE specific offsets */
> +
> +    uint32_t key_offset;
> +    uint32_t sequence_offset;
> +    uint32_t checksum_offset;
> +
> +    struct gre_minimal_header header_bits;
> +
> +} GRETunnelParams;
> +
> +
> +
> +static void gre_form_header(void *us)
> +{
> +    NetUnifiedState *s =3D (NetUnifiedState *) us;
> +    GRETunnelParams *p =3D (GRETunnelParams *) s->params;
> +
> +    uint32_t *sequence;
> +
> +    *((uint32_t *) s->header_buf) =3D *((uint32_t *) &p->header_bits);
> +
> +    if (p->key) {
> +        stl_be_p(
> +            (uint32_t *) (s->header_buf + p->key_offset),
> +            p->tx_key
> +        );
> +    }
> +    if (p->has_sequence) {
> +        sequence =3D (uint32_t *)(s->header_buf + p->sequence_offset);
> +        if (p->pin_sequence) {
> +            *sequence =3D 0;
> +        } else {
> +            stl_be_p(sequence, ++p->sequence);
> +        }
> +    }
> +}
> +
> +static int gre_verify_header(void *us, uint8_t *buf)
> +{
> +
> +    NetUnifiedState *s =3D (NetUnifiedState *) us;
> +    GRETunnelParams *p =3D (GRETunnelParams *) s->params;
> +    uint32_t key;
> +
> +
> +    if (!p->ipv6) {
> +        buf +=3D sizeof(struct iphdr) /* fix for ipv4 raw */;
> +    }
> +
> +    if (*((uint32_t *) buf) !=3D *((uint32_t *) &p->header_bits)) {
> +        if (!s->header_mismatch) {
> +            error_report("header type disagreement, expecting %0x, got=
 %0x",
> +                *((uint32_t *) &p->header_bits), *((uint32_t *) buf));
> +        }
> +        return -1;
> +    }
> +
> +    if (p->key) {
> +        key =3D ldl_be_p(buf + p->key_offset);
> +        if (key !=3D p->rx_key) {
> +            if (!s->header_mismatch) {
> +                error_report("unknown key id %0x, expecting %0x",
> +                    key, p->rx_key);
> +            }
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +int net_init_gre(const Netdev *netdev,
> +                    const char *name,
> +                    NetClientState *peer, Error **errp)
> +{
> +    /* FIXME error_setg(errp, ...) on failure */

Let's do this in next version.

> +    const NetdevGREOptions *gre;
> +    NetUnifiedState *s;
> +    NetClientState *nc;
> +    GRETunnelParams *p;
> +
> +    int fd =3D -1, gairet;
> +    struct addrinfo hints;
> +    struct addrinfo *result =3D NULL;
> +
> +    nc =3D qemu_new_unified_net_client(name, peer);
> +
> +    s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +
> +    p =3D g_malloc(sizeof(GRETunnelParams));
> +
> +    s->params =3D p;
> +    p->header_bits.arptype =3D GRE_IRB;
> +    p->header_bits.header =3D 0;
> +
> +    s->form_header =3D &gre_form_header;
> +    s->verify_header =3D &gre_verify_header;
> +    s->queue_head =3D 0;
> +    s->queue_tail =3D 0;
> +    s->header_mismatch =3D false;
> +
> +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_GRE);
> +    gre =3D &netdev->u.gre;
> +
> +    if (gre->has_ipv6 && gre->ipv6) {
> +        p->ipv6 =3D gre->ipv6;
> +    } else {
> +        p->ipv6 =3D false;
> +    }
> +
> +    s->offset =3D 4;
> +    p->key_offset =3D 4;
> +    p->sequence_offset =3D 4;
> +    p->checksum_offset =3D 4;
> +
> +    if (gre->has_rxkey || gre->has_txkey) {
> +        if (gre->has_rxkey && gre->has_txkey) {
> +            p->key =3D true;
> +            p->header_bits.header |=3D GRE_MODE_KEY;
> +        } else {
> +            goto outerr;
> +        }
> +    } else {
> +        p->key =3D false;
> +    }
> +
> +    if (p->key) {
> +        p->rx_key =3D gre->rxkey;
> +        p->tx_key =3D gre->txkey;
> +        s->offset +=3D 4;
> +        p->sequence_offset +=3D 4;
> +    }
> +
> +
> +    if (gre->has_sequence && gre->sequence) {
> +        s->offset +=3D 4;
> +        p->has_sequence =3D true;
> +        p->header_bits.header |=3D GRE_MODE_SEQUENCE;
> +    } else {
> +        p->sequence =3D false;
> +    }
> +
> +    if (gre->has_pinsequence && gre->pinsequence) {
> +        /* pin sequence implies that there is sequence */
> +        p->has_sequence =3D true;
> +        p->pin_sequence =3D true;
> +    } else {
> +        p->pin_sequence =3D false;
> +    }
> +
> +    memset(&hints, 0, sizeof(hints));
> +
> +    if (p->ipv6) {
> +        hints.ai_family =3D AF_INET6;
> +    } else {
> +        hints.ai_family =3D AF_INET;
> +    }
> +
> +    hints.ai_socktype =3D SOCK_RAW;
> +    hints.ai_protocol =3D IPPROTO_GRE;
> +
> +    gairet =3D getaddrinfo(gre->src, NULL, &hints, &result);
> +
> +    if ((gairet !=3D 0) || (result =3D=3D NULL)) {
> +        error_report(
> +            "gre_open : could not resolve src, errno =3D %s",
> +            gai_strerror(gairet)
> +        );
> +        goto outerr;
> +    }
> +    fd =3D socket(result->ai_family, result->ai_socktype, result->ai_p=
rotocol);
> +    if (fd =3D=3D -1) {
> +        fd =3D -errno;
> +        error_report("gre_open : socket creation failed, errno =3D %d"=
, -fd);
> +        goto outerr;
> +    }
> +    if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrl=
en)) {
> +        error_report("gre_open :  could not bind socket err=3D%i", err=
no);
> +        goto outerr;
> +    }
> +    if (result) {
> +        freeaddrinfo(result);
> +    }
> +
> +    memset(&hints, 0, sizeof(hints));
> +
> +    if (p->ipv6) {
> +        hints.ai_family =3D AF_INET6;
> +    } else {
> +        hints.ai_family =3D AF_INET;
> +    }
> +    hints.ai_socktype =3D SOCK_RAW;
> +    hints.ai_protocol =3D IPPROTO_GRE;
> +
> +    result =3D NULL;
> +    gairet =3D getaddrinfo(gre->dst, NULL, &hints, &result);
> +    if ((gairet !=3D 0) || (result =3D=3D NULL)) {
> +        error_report(
> +            "gre_open : could not resolve dst, error =3D %s",
> +            gai_strerror(gairet)
> +        );
> +        goto outerr;
> +    }
> +
> +    s->dgram_dst =3D g_new0(struct sockaddr_storage, 1);
> +    memcpy(s->dgram_dst, result->ai_addr, result->ai_addrlen);

Use g_memdup() instead?

> +    s->dst_size =3D result->ai_addrlen;
> +
> +    if (result) {
> +        freeaddrinfo(result);
> +    }
> +
> +    if ((p->ipv6) || (p->udp)) {
> +        s->header_size =3D s->offset;
> +    } else {
> +        s->header_size =3D s->offset + sizeof(struct iphdr);
> +    }
> +
> +    qemu_net_finalize_unified_init(s, fd);
> +
> +    p->sequence =3D 0;
> +
> +    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
> +             "gre: connected");
> +    return 0;
> +outerr:
> +    qemu_del_net_client(nc);
> +    if (fd >=3D 0) {
> +        close(fd);
> +    }
> +    if (result) {
> +        freeaddrinfo(result);
> +    }
> +    return -1;
> +}
> diff --git a/net/net.c b/net/net.c
> index 9270b52ac8..b75b6e8154 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -961,6 +961,7 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
>   #endif
>   #ifdef CONFIG_UNIFIED
>           [NET_CLIENT_DRIVER_L2TPV3] =3D net_init_l2tpv3,
> +        [NET_CLIENT_DRIVER_GRE] =3D net_init_gre,
>   #endif
>   };
>  =20
> @@ -1012,6 +1013,10 @@ static int net_client_init1(const void *object, =
bool is_netdev, Error **errp)
>               legacy.type =3D NET_CLIENT_DRIVER_L2TPV3;
>               legacy.u.l2tpv3 =3D opts->u.l2tpv3;
>               break;
> +        case NET_LEGACY_OPTIONS_TYPE_GRE:
> +            legacy.type =3D NET_CLIENT_DRIVER_GRE;
> +            legacy.u.gre =3D opts->u.gre;
> +            break;
>           case NET_LEGACY_OPTIONS_TYPE_SOCKET:
>               legacy.type =3D NET_CLIENT_DRIVER_SOCKET;
>               legacy.u.socket =3D opts->u.socket;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index ab438ead70..aec303a14e 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3847,7 +3847,41 @@
>       'txsession':    'uint32',
>       '*rxsession':   'uint32',
>       '*offset':      'uint32' } }
> -
> +##
> +# @NetdevGREOptions:
> +#
> +# Connect the VLAN to Ethernet over Ethernet over GRE (GRETAP) tunnel
> +#
> +# @src: source address
> +#
> +# @dst: destination address
> +#
> +# @ipv6: force the use of ipv6
> +#
> +# @sequence: have sequence counter
> +#
> +# @pinsequence: pin sequence counter to zero -
> +#              workaround for buggy implementations or
> +#              networks with packet reorder
> +#
> +# @txkey: 32 bit transmit key
> +#
> +# @rxkey: 32 bit receive key
> +#
> +# Note - gre checksums are not supported at present
> +#
> +#
> +# Since 2.9

We are soft freeze now. So I will target this for 2.11.

> +##
> +{ 'struct': 'NetdevGREOptions',
> +  'data': {
> +    'src':          'str',
> +    'dst':          'str',
> +    '*ipv6':        'bool',
> +    '*sequence':     'bool',
> +    '*pinsequence':  'bool',
> +    '*txkey':    'uint32',
> +    '*rxkey':    'uint32' } }
>   ##
>   # @NetdevVdeOptions:
>   #
> @@ -3966,7 +4000,7 @@
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', =
'dump',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre' ] }
>  =20
>   ##
>   # @Netdev:
> @@ -3996,7 +4030,8 @@
>       'bridge':   'NetdevBridgeOptions',
>       'hubport':  'NetdevHubPortOptions',
>       'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'gre':      'NetdevGREOptions' } }
>  =20
>   ##
>   # @NetLegacy:
> @@ -4027,7 +4062,7 @@
>   ##
>   { 'enum': 'NetLegacyOptionsType',
>     'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -           'dump', 'bridge', 'netmap', 'vhost-user'] }
> +           'dump', 'bridge', 'netmap', 'vhost-user', 'gre'] }
>  =20
>   ##
>   # @NetLegacyOptions:
> @@ -4050,7 +4085,8 @@
>       'dump':     'NetdevDumpOptions',
>       'bridge':   'NetdevBridgeOptions',
>       'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'gre':      'NetdevGREOptions' } }
>  =20
>   ##
>   # @NetFilterDirection:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2cc70b9cfc..6f8d5cbe21 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1945,7 +1945,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "                connected to a bridge (default=3D" DEFAULT_BRIDG=
E_INTERFACE ")\n"
>       "                using the program 'helper (default=3D" DEFAULT_B=
RIDGE_HELPER ")\n"
>   #endif
> -#ifdef __linux__
> +#ifdef CONFIG_UNIFIED
>       "-netdev l2tpv3,id=3Dstr,src=3Dsrcaddr,dst=3Ddstaddr[,srcport=3Ds=
rcport][,dstport=3Ddstport]\n"
>       "         [,rxsession=3Drxsession],txsession=3Dtxsession[,ipv6=3D=
on/off][,udp=3Don/off]\n"
>       "         [,cookie64=3Don/off][,counter][,pincounter][,txcookie=3D=
txcookie]\n"
> @@ -1971,6 +1971,23 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "                use 'counter=3Doff' to force a 'cut-down' L2TPv3=
 with no counter\n"
>       "                use 'pincounter=3Don' to work around broken coun=
ter handling in peer\n"
>       "                use 'offset=3DX' to add an extra offset between =
header and data\n"
> +    "-netdev gre,id=3Dstr,src=3Dsrcaddr,dst=3Ddstaddr[,rxkey=3Drxkey],=
txkey=3Dtxkey[,ipv6=3Don/off]\n"
> +    "         [,sequence][,pinsequence]\n"
> +    "                configure a network backend with ID 'str' connect=
ed to\n"
> +    "                an Ethernet over GRE pseudowire (aka GRE TAP).\n"
> +    "                Linux kernel 3.3+ as well as most routers and som=
e switches\n"
> +    "                can talk GRETAP. This transport allows connecting=
 a VM to a VM,\n"
> +    "                VM to a router and even VM to Host. It is a nearl=
y-universal\n"
> +    "                standard (RFC1701).\n"
> +    "                use 'src=3D' to specify source address\n"
> +    "                use 'dst=3D' to specify destination address\n"
> +    "                use 'ipv6=3Don' to force v6\n"
> +    "                GRE may use keys to prevent misconfiguration as\n=
"
> +    "                well as a weak security measure\n"
> +    "                use 'rxkey=3D0x01234' to specify a rxkey\n"
> +    "                use 'txkey=3D0x01234' to specify a txkey\n"
> +    "                use 'sequence=3Don' to add frame sequence to each=
 packet\n"
> +    "                use 'pinsequence=3Don' to work around broken sequ=
ence handling in peer\n"
>   #endif
>       "-netdev socket,id=3Dstr[,fd=3Dh][,listen=3D[host]:port][,connect=
=3Dhost:port]\n"
>       "                configure a network backend to connect to anothe=
r network\n"
> @@ -2394,12 +2411,54 @@ ip l2tp add session tunnel_id 1 name vmtunnel0 =
session_id \
>   ifconfig vmtunnel0 mtu 1500
>   ifconfig vmtunnel0 up
>   brctl addif br-lan vmtunnel0
> +@end example
> +
> +Alternatively, it is possible to assign an IP address to vmtunnel0, wh=
ich allows
> +the VM to connect to the host directly without using Linux bridging.
> +
> +
> +@item -netdev gre,id=3D@var{id},src=3D@var{srcaddr},dst=3D@var{dstaddr=
}[,ipv6][,sequence][,pinsequence][,txkey=3D@var{txkey}][,rxkey=3D@var{rxk=
ey}]
> +@itemx -net gre[,vlan=3D@var{n}][,name=3D@var{name}],src=3D@var{srcadd=
r},dst=3D@var{dstaddr}[,ipv6][,sequence][,pinsequence][,txkey=3D@var{txke=
y}][,rxkey=3D@var{rxkey}]
> +Connect VLAN @var{n} to a GRE pseudowire. GRE (RFC1701) is a popular
> +protocol to transport various data frames between two systems.
> +We are interested in a specific GRE variety where the transported
> +frames are Ethernet. This GRE type is usually referred to as GRETAP.
> +It is present in routers, firewalls, switches and the Linux kernel
> +(from version 3.3 onwards).
> +
> +This transport allows a VM to communicate to another VM, router or fir=
ewall directly.
> +
> +@item src=3D@var{srcaddr}
> +    source address (mandatory)
> +@item dst=3D@var{dstaddr}
> +    destination address (mandatory)
> +@item ipv6
> +    force v6, otherwise defaults to v4.
> +@item rxkey=3D@var{rxkey}
> +@itemx txkey=3D@var{txkey}
> +    Keys are a weak form of security in the gre specification.
> +Their function is mostly to prevent misconfiguration.
> +@item sequence=3Don
> +    Add frame sequence to GRE frames
> +@item pinsequence=3Don
> +    Work around broken sequence handling in peer. This may also help o=
n
> +networks which have packet reorder.
> +
> +For example, to attach a VM running on host 4.3.2.1 via GRETAP to the =
bridge br-lan
> +on the remote Linux host 1.2.3.4:
> +@example
> +# Setup tunnel on linux host using raw ip as encapsulation
> +# on 1.2.3.4
> +ip link add gt0 type gretap local 1.2.3.4 remote 4.3.2.1
> +ifconfig gt0 mtu 1500
> +ifconfig gt0 up
> +brctl addif br-lan gt0
>  =20
>  =20
>   # on 4.3.2.1
>   # launch QEMU instance - if your network has reorder or is very lossy=
 add ,pincounter
>  =20
> -qemu-system-i386 linux.img -net nic -net l2tpv3,src=3D4.2.3.1,dst=3D1.=
2.3.4,udp,srcport=3D16384,dstport=3D16384,rxsession=3D0xffffffff,txsessio=
n=3D0xffffffff,counter
> +qemu-system-i386 linux.img -net nic -net gre,src=3D4.2.3.1,dst=3D1.2.3=
.4
>  =20
>  =20
>   @end example
