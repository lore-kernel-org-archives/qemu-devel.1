Received: from eggs.gnu.org ([2001:4830:134:3::10]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwfTM-0005eU-Jr
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwfTJ-0004Ji-E4
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:24:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fwfTJ-0004Ir-6w
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:24:13 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-3-sameeh@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f05e8a81-b52b-b3a1-162b-fa3471c95e02@redhat.com>
Date: Mon, 3 Sep 2018 11:24:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180830142708.14311-3-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 2/6] tap: Add support for bpf ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>



On 2018=E5=B9=B408=E6=9C=8830=E6=97=A5 22:27, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> Starting from kernel v4.16 tun device supports TUNSETSTEERINGEBPF and
> TUNSETFILTEREBPF.
>
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>   include/net/net.h |  3 ++-
>   net/tap-bsd.c     |  5 +++++
>   net/tap-linux.c   | 29 ++++++++++++++++++++++++++++-
>   net/tap-linux.h   |  3 ++-
>   net/tap-solaris.c |  5 +++++
>   net/tap-stub.c    |  5 +++++
>   net/tap.c         |  8 ++++++++
>   net/tap_int.h     |  1 +
>   qapi/net.json     | 11 +++++++++++
>   9 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 1425960f76..e7d1baac10 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -39,7 +39,6 @@ typedef struct NICConf {
>       DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),             =
   \
>       DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
>  =20
> -

Looks unnecessary.

>   /* Net clients */
>  =20
>   typedef void (NetPoll)(NetClientState *, bool enable);
> @@ -60,6 +59,7 @@ typedef int (SetVnetLE)(NetClientState *, bool);
>   typedef int (SetVnetBE)(NetClientState *, bool);
>   typedef struct SocketReadState SocketReadState;
>   typedef void (SocketReadStateFinalize)(SocketReadState *rs);
> +typedef int (SetBPFFilter)(NetClientState *, int, BPFType);

Looks like SetBPFProg is better? Anyway steering prog is not a filter.

>  =20
>   typedef struct NetClientInfo {
>       NetClientDriver type;
> @@ -80,6 +80,7 @@ typedef struct NetClientInfo {
>       SetVnetHdrLen *set_vnet_hdr_len;
>       SetVnetLE *set_vnet_le;
>       SetVnetBE *set_vnet_be;
> +    SetBPFFilter *set_bpf_filter;
>   } NetClientInfo;
>  =20
>   struct NetClientState {
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index 6c9692263d..fccf17bad0 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -259,3 +259,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       return -1;
>   }
> +
> +int tap_fd_load_bpf(int fd, int bpf_fd, BPFType type)
> +{
> +    return -1;
> +}
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 535b1ddb61..e8ee54f3b3 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -305,7 +305,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       struct ifreq ifr;
>  =20
> -    if (ioctl(fd, TUNGETIFF, &ifr) !=3D 0) {
> +    if (ioctl(fd, TUNGETIFF, &ifr) !=3D 0)
> +    {

This looks unnecessary.

>           error_report("TUNGETIFF ioctl() failed: %s",
>                        strerror(errno));
>           return -1;
> @@ -314,3 +315,29 @@ int tap_fd_get_ifname(int fd, char *ifname)
>       pstrcpy(ifname, sizeof(ifr.ifr_name), ifr.ifr_name);
>       return 0;
>   }
> +
> +
> +int tap_fd_load_bpf(int fd, int bpf_fd, BPFType type)
> +{
> +    int ioctl_num =3D 0;
> +    switch (type)
> +    {
> +        case BPF_TYPE_FILTER:
> +        ioctl_num =3D TUNSETFILTEREBPF;
> +        break;
> +
> +        case BPF_TYPE_STEERING:
> +        ioctl_num =3D TUNSETSTEERINGEBPF;
> +        break;
> +
> +        default:
> +        error_report("Unknown bpf_type");
> +        return -1;
> +    }

Indentation looks odd.

> +
> +    if (ioctl(fd, ioctl_num, &bpf_fd) !=3D 0) {
> +        error_report("#%d ioctl() failed: %s", ioctl_num, strerror(err=
no));
> +        return -1;
> +    }
> +    return 0;
> +}
> diff --git a/net/tap-linux.h b/net/tap-linux.h
> index 2f36d100fc..7348169fc2 100644
> --- a/net/tap-linux.h
> +++ b/net/tap-linux.h
> @@ -31,7 +31,8 @@
>   #define TUNSETQUEUE  _IOW('T', 217, int)
>   #define TUNSETVNETLE _IOW('T', 220, int)
>   #define TUNSETVNETBE _IOW('T', 222, int)
> -
> +#define TUNSETSTEERINGEBPF _IOR('T', 224, int)
> +#define TUNSETFILTEREBPF _IOR('T', 225, int)
>   #endif
>  =20
>   /* TUNSETIFF ifr flags */
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index a2a92356c1..a5a6248c7d 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -254,3 +254,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       return -1;
>   }
> +
> +int tap_fd_load_bpf(int fd, int bpf_fd, BPFType type)
> +{
> +    return -1;
> +}
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index a9ab8f8293..d059a32435 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -85,3 +85,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       return -1;
>   }
> +
> +int tap_fd_load_bpf(int fd, int bpf_fd, BPFType type)
> +{
> +    return -1;
> +}
> diff --git a/net/tap.c b/net/tap.c
> index 2126f4882d..ee98fecd40 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -342,6 +342,13 @@ int tap_get_fd(NetClientState *nc)
>       return s->fd;
>   }
>  =20
> +static int tap_set_bpf_filter(NetClientState *nc, int bpf_fd, BPFType =
type)
> +{
> +    TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP);
> +    return tap_fd_load_bpf(s->fd, bpf_fd, type);
> +}
> +
>   /* fd support */
>  =20
>   static NetClientInfo net_tap_info =3D {
> @@ -360,6 +367,7 @@ static NetClientInfo net_tap_info =3D {
>       .set_vnet_hdr_len =3D tap_set_vnet_hdr_len,
>       .set_vnet_le =3D tap_set_vnet_le,
>       .set_vnet_be =3D tap_set_vnet_be,
> +    .set_bpf_filter =3D tap_set_bpf_filter,
>   };
>  =20
>   static TAPState *net_tap_fd_init(NetClientState *peer,
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 9f931d52d6..3e1603a88e 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -45,5 +45,6 @@ int tap_fd_set_vnet_be(int fd, int vnet_is_be);
>   int tap_fd_enable(int fd);
>   int tap_fd_disable(int fd);
>   int tap_fd_get_ifname(int fd, char *ifname);
> +int tap_fd_load_bpf(int fd, int bpf_fd, BPFType type);
>  =20
>   #endif /* NET_TAP_INT_H */
> diff --git a/qapi/net.json b/qapi/net.json
> index 6b7d93cb59..ce0a688444 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -692,3 +692,14 @@
>   ##
>   { 'event': 'NIC_RX_FILTER_CHANGED',
>     'data': { '*name': 'str', 'path': 'str' } }
> +
> +##
> +# @BPFType:
> +#
> +# BPF programs types provided as an argument for tap bpf ioctls
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'enum': 'BPFType',
> +  'data': [ 'filter', 'steering' ] }

I don't get why it needs to be exported as part of qapi.

Thanks
