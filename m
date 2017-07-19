Received: from eggs.gnu.org ([2001:4830:134:3::10]:51141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dXi4k-0000IC-6X
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dXi4f-0002dT-3y
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:03:10 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42424
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1dXi4e-0002bY-Nc
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:03:05 -0400
Date: Wed, 19 Jul 2017 08:02:44 +0200
In-Reply-To: <e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
	<e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
MIME-Version: 1.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <23E7EBB9-E398-4404-B64B-6D82731F26AA@kot-begemot.co.uk>
Content-Type: text/plain;
 charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>, anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org

I tried tpacket long ago when I started working on this=2E It was slower as=
 there was no way to turn off timestamps on the packet ring=2E They are qui=
te expensive=2E=20

I have not looked at it lately=2E It will be interesting to compare=2E

On 19 July 2017 07:58:48 CEST, Jason Wang <jasowang@redhat=2Ecom> wrote:
>
>
>On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 01:08, anton=2Eivanov@cambridgegre=
ys=2Ecom wrote:
>> From: Anton Ivanov <anton=2Eivanov@cambridgegreys=2Ecom>
>>
>> This adds raw socket support to the unified socket driver=2E
>
>Interesting, in fact, I've finished a tpacket backend=2E Let me post it=
=20
>sometime after hardfreeze=2E
>
>> Signed-off-by: Anton Ivanov <anton=2Eivanov@cambridgegreys=2Ecom>
>> ---
>>   net/Makefile=2Eobjs |   2 +-
>>   net/clients=2Eh     |   3 ++
>>   net/net=2Ec         |   5 +++
>>   net/raw=2Ec         | 123
>++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   qapi-schema=2Ejson  |  25 +++++++++--
>>   qemu-options=2Ehx   |  33 +++++++++++++++
>>   6 files changed, 186 insertions(+), 5 deletions(-)
>>   create mode 100644 net/raw=2Ec
>>
>> diff --git a/net/Makefile=2Eobjs b/net/Makefile=2Eobjs
>> index 128164e39b=2E=2E54cf7dd194 100644
>> --- a/net/Makefile=2Eobjs
>> +++ b/net/Makefile=2Eobjs
>> @@ -2,7 +2,7 @@ common-obj-y =3D net=2Eo queue=2Eo checksum=2Eo util=2E=
o hub=2Eo
>>   common-obj-y +=3D socket=2Eo
>>   common-obj-y +=3D dump=2Eo
>>   common-obj-y +=3D eth=2Eo
>> -common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3=2Eo unified=2Eo gre=2Eo
>> +common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3=2Eo unified=2Eo gre=2Eo raw=
=2Eo
>>   common-obj-$(CONFIG_POSIX) +=3D vhost-user=2Eo
>>   common-obj-$(CONFIG_SLIRP) +=3D slirp=2Eo
>>   common-obj-$(CONFIG_VDE) +=3D vde=2Eo
>> diff --git a/net/clients=2Eh b/net/clients=2Eh
>> index 8f8a59aee3=2E=2E98d8ae59b7 100644
>> --- a/net/clients=2Eh
>> +++ b/net/clients=2Eh
>> @@ -53,6 +53,9 @@ int net_init_l2tpv3(const Netdev *netdev, const
>char *name,
>>   int net_init_gre(const Netdev *netdev, const char *name,
>>                       NetClientState *peer, Error **errp);
>>  =20
>> +int net_init_raw(const Netdev *netdev, const char *name,
>> +                    NetClientState *peer, Error **errp);
>> +
>>   #ifdef CONFIG_VDE
>>   int net_init_vde(const Netdev *netdev, const char *name,
>>                    NetClientState *peer, Error **errp);
>> diff --git a/net/net=2Ec b/net/net=2Ec
>> index b75b6e8154=2E=2E2d988a120c 100644
>> --- a/net/net=2Ec
>> +++ b/net/net=2Ec
>> @@ -962,6 +962,7 @@ static int (* const
>net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
>>   #ifdef CONFIG_UNIFIED
>>           [NET_CLIENT_DRIVER_L2TPV3] =3D net_init_l2tpv3,
>>           [NET_CLIENT_DRIVER_GRE] =3D net_init_gre,
>> +        [NET_CLIENT_DRIVER_RAW] =3D net_init_raw,
>>   #endif
>>   };
>>  =20
>> @@ -1017,6 +1018,10 @@ static int net_client_init1(const void
>*object, bool is_netdev, Error **errp)
>>               legacy=2Etype =3D NET_CLIENT_DRIVER_GRE;
>>               legacy=2Eu=2Egre =3D opts->u=2Egre;
>>               break;
>> +        case NET_LEGACY_OPTIONS_TYPE_RAW:
>> +            legacy=2Etype =3D NET_CLIENT_DRIVER_RAW;
>> +            legacy=2Eu=2Eraw =3D opts->u=2Eraw;
>> +            break;
>>           case NET_LEGACY_OPTIONS_TYPE_SOCKET:
>>               legacy=2Etype =3D NET_CLIENT_DRIVER_SOCKET;
>>               legacy=2Eu=2Esocket =3D opts->u=2Esocket;
>> diff --git a/net/raw=2Ec b/net/raw=2Ec
>> new file mode 100644
>> index 0000000000=2E=2E73e2fd9fe3
>> --- /dev/null
>> +++ b/net/raw=2Ec
>> @@ -0,0 +1,123 @@
>> +/*
>> + * QEMU System Emulator
>> + *
>> + * Copyright (c) 2015-2017 Cambridge Greys Limited
>> + * Copyright (c) 2003-2008 Fabrice Bellard
>> + * Copyright (c) 2012-2014 Cisco Systems
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>obtaining a copy
>> + * of this software and associated documentation files (the
>"Software"), to deal
>> + * in the Software without restriction, including without limitation
>the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense,
>and/or sell
>> + * copies of the Software, and to permit persons to whom the
>Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>included in
>> + * all copies or substantial portions of the Software=2E
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT
>SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
>OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>DEALINGS IN
>> + * THE SOFTWARE=2E
>> + */
>> +
>> +#include "qemu/osdep=2Eh"
>> +#include <linux/ip=2Eh>
>> +#include <netdb=2Eh>
>> +#include <sys/ioctl=2Eh>
>> +#include <net/if=2Eh>
>> +#include "net/net=2Eh"
>> + #include <sys/socket=2Eh>
>> +#include <linux/if_packet=2Eh>
>> +#include <net/ethernet=2Eh>
>> +#include "clients=2Eh"
>> +#include "qemu-common=2Eh"
>> +#include "qemu/error-report=2Eh"
>> +#include "qemu/option=2Eh"
>> +#include "qemu/sockets=2Eh"
>> +#include "qemu/iov=2Eh"
>> +#include "qemu/main-loop=2Eh"
>> +#include "unified=2Eh"
>> +
>> +static int noop(void *us, uint8_t *buf)
>> +{
>> +    return 0;
>> +}
>> +
>> +int net_init_raw(const Netdev *netdev,
>> +                    const char *name,
>> +                    NetClientState *peer, Error **errp)
>> +{
>> +
>> +    const NetdevRawOptions *raw;
>> +    NetUnifiedState *s;
>> +    NetClientState *nc;
>> +
>> +    int fd =3D -1;
>> +    int err;
>> +
>> +    struct ifreq ifr;
>> +    struct sockaddr_ll sock;
>> +
>> +
>> +    nc =3D qemu_new_unified_net_client(name, peer);
>> +
>> +    s =3D DO_UPCAST(NetUnifiedState, nc, nc);
>> +
>> +    fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>> +    if (fd =3D=3D -1) {
>> +        err =3D -errno;
>> +        error_report("raw_open : raw socket creation failed, errno =3D
>%d", -err);
>> +        goto outerr;
>> +    }
>> +
>> +
>> +    s->form_header =3D NULL;
>> +    s->verify_header =3D &noop;
>> +    s->queue_head =3D 0;
>> +    s->queue_tail =3D 0;
>> +    s->header_mismatch =3D false;
>> +    s->dgram_dst =3D NULL;
>> +    s->dst_size =3D 0;
>> +
>> +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_RAW);
>> +    raw =3D &netdev->u=2Eraw;
>> +
>> +    memset(&ifr, 0, sizeof(struct ifreq));
>> +    strncpy((char *) &ifr=2Eifr_name, raw->ifname,
>sizeof(ifr=2Eifr_name) - 1);
>> +
>> +    if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
>> +        err =3D -errno;
>> +        error_report("SIOCGIFINDEX, failed to get raw interface
>index for %s",
>> +            raw->ifname);
>> +        goto outerr;
>> +    }
>> +
>> +    sock=2Esll_family =3D AF_PACKET;
>> +    sock=2Esll_protocol =3D htons(ETH_P_ALL);
>> +    sock=2Esll_ifindex =3D ifr=2Eifr_ifindex;
>> +
>> +    if (bind(fd, (struct sockaddr *) &sock, sizeof(struct
>sockaddr_ll)) < 0) {
>> +        error_report("raw: failed to bind raw socket");
>> +        err =3D -errno;
>> +        goto outerr;
>> +    }
>> +
>> +    s->offset =3D 0;
>> +
>> +    qemu_net_finalize_unified_init(s, fd);
>> +
>> +    snprintf(s->nc=2Einfo_str, sizeof(s->nc=2Einfo_str),
>> +             "raw: connected");
>> +    return 0;
>> +outerr:
>> +    qemu_del_net_client(nc);
>> +    if (fd >=3D 0) {
>> +        close(fd);
>> +    }
>> +    return -1;
>> +}
>> +
>> diff --git a/qapi-schema=2Ejson b/qapi-schema=2Ejson
>> index aec303a14e=2E=2Ecde78ce3a1 100644
>> --- a/qapi-schema=2Ejson
>> +++ b/qapi-schema=2Ejson
>> @@ -3883,6 +3883,21 @@
>>       '*txkey':    'uint32',
>>       '*rxkey':    'uint32' } }
>>   ##
>> +# @NetdevRawOptions:
>> +#
>> +# Connect the VLAN to an network interface using raw sockets
>> +#
>> +# @ifname: network interface name
>> +#
>> +
>> +# Since 2=2E9
>
>2=2E11=2E
>
>> +##
>> +{ 'struct': 'NetdevRawOptions',
>> +  'data': {
>> +    'ifname':          'str'
>> +} }
>> +
>> +##
>>   # @NetdevVdeOptions:
>>   #
>>   # Connect the VLAN to a vde switch running on the host=2E
>> @@ -4000,7 +4015,7 @@
>>   ##
>>   { 'enum': 'NetClientDriver',
>>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket',
>'vde', 'dump',
>> -            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre' ] }
>> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre',
>'raw' ] }
>>  =20
>>   ##
>>   # @Netdev:
>> @@ -4031,7 +4046,8 @@
>>       'hubport':  'NetdevHubPortOptions',
>>       'netmap':   'NetdevNetmapOptions',
>>       'vhost-user': 'NetdevVhostUserOptions',
>> -    'gre':      'NetdevGREOptions' } }
>> +    'gre':      'NetdevGREOptions',
>> +    'raw':      'NetdevRawOptions' } }
>>  =20
>>   ##
>>   # @NetLegacy:
>> @@ -4062,7 +4078,7 @@
>>   ##
>>   { 'enum': 'NetLegacyOptionsType',
>>     'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
>> -           'dump', 'bridge', 'netmap', 'vhost-user', 'gre'] }
>> +           'dump', 'bridge', 'netmap', 'vhost-user', 'gre', 'raw'] }
>>  =20
>>   ##
>>   # @NetLegacyOptions:
>> @@ -4086,7 +4102,8 @@
>>       'bridge':   'NetdevBridgeOptions',
>>       'netmap':   'NetdevNetmapOptions',
>>       'vhost-user': 'NetdevVhostUserOptions',
>> -    'gre':      'NetdevGREOptions' } }
>> +    'gre':      'NetdevGREOptions',
>> +    'raw':      'NetdevRawOptions' } }
>>  =20
>>   ##
>>   # @NetFilterDirection:
>> diff --git a/qemu-options=2Ehx b/qemu-options=2Ehx
>> index 6f8d5cbe21=2E=2Ed9db8b576b 100644
>> --- a/qemu-options=2Ehx
>> +++ b/qemu-options=2Ehx
>> @@ -1988,6 +1988,13 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>       "                use 'txkey=3D0x01234' to specify a txkey\n"
>>       "                use 'sequence=3Don' to add frame sequence to
>each packet\n"
>>       "                use 'pinsequence=3Don' to work around broken
>sequence handling in peer\n"
>> +    "-netdev raw,id=3Dstr,ifname=3Difname\n"
>> +    "                configure a network backend with ID 'str'
>connected to\n"
>> +    "                an Ethernet interface named ifname via raw
>socket=2E\n"
>> +    "                This backend does not change the interface
>settings=2E\n"
>> +    "                Most interfaces will require being set into
>promisc mode,\n"
>> +    "                as well having most offloads (TSO, etc) turned
>off=2E\n"
>> +    "                Some virtual interfaces like tap support only
>RX=2E\n"
>
>Pay attention that qemu supports vnet header=2E So any reason to turn off
>
>e=2Eg TSO here?
>
>>   #endif
>>       "-netdev
>socket,id=3Dstr[,fd=3Dh][,listen=3D[host]:port][,connect=3Dhost:port]\n"
>>       "                configure a network backend to connect to
>another network\n"
>> @@ -2463,6 +2470,32 @@ qemu-system-i386 linux=2Eimg -net nic -net
>gre,src=3D4=2E2=2E3=2E1,dst=3D1=2E2=2E3=2E4
>>  =20
>>   @end example
>>  =20
>> +@item -netdev raw,id=3D@var{id},ifname=3D@var{ifname}
>> +@itemx -net raw[,vlan=3D@var{n}][,name=3D@var{name}],ifname=3D@var{ifn=
ame}
>> +Connect VLAN @var{n} directly to an Ethernet interface using raw
>socket=2E
>> +
>> +This transport allows a VM to bypass most of the network stack which
>is
>> +extremely useful for tapping=2E
>> +
>> +@item ifname=3D@var{ifname}
>> +    interface name (mandatory)
>> +
>> +@example
>> +# set up the interface - put it in promiscuous mode and turn off
>offloads
>> +ifconfig eth0 up
>> +ifconfig eth0 promisc
>> +
>> +/sbin/ethtool -K eth0 gro off
>> +/sbin/ethtool -K eth0 tso off
>> +/sbin/ethtool -K eth0 gso off
>> +/sbin/ethtool -K eth0 tx off
>
>Any reason to turn off tx here?
>
>> +
>> +# launch QEMU instance - if your network has reorder or is very
>lossy add ,pincounter
>> +
>> +qemu-system-i386 linux=2Eimg -net nic -net raw,ifname=3Deth0
>
>Can we switch to use -netdev here?
>
>Thanks
>
>> +
>> +@end example
>> +
>>   @item -netdev
>vde,id=3D@var{id}[,sock=3D@var{socketpath}][,port=3D@var{n}][,group=3D@va=
r{groupname}][,mode=3D@var{octalmode}]
>>   @itemx -net
>vde[,vlan=3D@var{n}][,name=3D@var{name}][,sock=3D@var{socketpath}]
>[,port=3D@var{n}][,group=3D@var{groupname}][,mode=3D@var{octalmode}]
>>   Connect VLAN @var{n} to PORT @var{n} of a vde switch running on
>host and

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
