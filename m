Received: from eggs.gnu.org ([2001:4830:134:3::10]:44435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d37ph-0002fN-Uo
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 17:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d37pd-00032m-Tm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 17:17:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57505
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d37pd-00031F-NY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 17:17:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PLDird002834
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 17:17:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a26s5eabn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 17:17:07 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 17:17:07 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1493107940-29950-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1493107940-29950-1-git-send-email-lu.zhipeng@zte.com.cn>
Date: Tue, 25 Apr 2017 16:16:52 -0500
Message-Id: <149315501241.11573.3299495533468354978@loki>
Subject: Re: [Qemu-devel] [PATCH v4] qga: Add support network interface
 statistics in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: berrange@redhat.com, qemu-devel@nongnu.org

Quoting ZhiPeng Lu (2017-04-25 03:12:20)
> we can get the network interface statistics inside a virtual machine by
> guest-network-get-interfaces command. it is very useful for us to monitor
> and analyze network traffic.
> =

> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qga/commands-posix.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  qga/qapi-schema.json | 38 +++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 2 deletions(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 915df9e..1e35340 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1638,6 +1638,65 @@ guest_find_interface(GuestNetworkInterfaceList *he=
ad,
>      return head;
>  }
> =

> + static int guest_get_network_stats(const char *path,

Path is a little misleading. Isn't this the device name?

> +                       GuestNetworkInterfaceStat *stats)
> +{
> +    int path_len;
> +    char const *devinfo =3D "/proc/net/dev";
> +    FILE *fp;
> +    char *line =3D NULL, *colon;
> +    size_t n;
> +    fp =3D fopen(devinfo, "r");
> +    if (!fp) {
> +        return -1;
> +    }
> +    path_len =3D strlen(path);

name_len?

> +    while (getline(&line, &n, fp) !=3D -1) {
> +        long long dummy;
> +        long long rx_bytes;
> +        long long rx_packets;
> +        long long rx_errs;
> +        long long rx_dropped;
> +        long long tx_bytes;
> +        long long tx_packets;
> +        long long tx_errs;
> +        long long tx_dropped;
> +
> +  /* The line looks like:
> +   *"   eth0:..."
> +   *Split it at the colon.

Space after the "*". Indentation seems to wrong too.

> +   */
> +        colon =3D strchr(line, ':');
> +        if (!colon) {
> +            continue;
> +        }
> +        *colon =3D '\0';
> +        if (colon - path_len >=3D line && strcmp(colon - path_len, path)=
 =3D=3D 0) {

colon - path_len > line would imply the current line isn't a match
either, so i think that can be tightened to colon - path_len =3D=3D line.

> +            if (sscanf(colon + 1,
> +                "%lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld =
%lld %lld %lld %lld %lld",
> +                  &rx_bytes, &rx_packets, &rx_errs, &rx_dropped,
> +                  &dummy, &dummy, &dummy, &dummy,
> +                  &tx_bytes, &tx_packets, &tx_errs, &tx_dropped,
> +                  &dummy, &dummy, &dummy, &dummy) !=3D 16) {
> +                continue;
> +            }
> +            stats->rx_bytes =3D rx_bytes;
> +            stats->rx_packets =3D rx_packets;
> +            stats->rx_errs =3D rx_errs;
> +            stats->rx_dropped =3D rx_dropped;
> +            stats->tx_bytes =3D tx_bytes;
> +            stats->tx_packets =3D tx_packets;
> +            stats->tx_errs =3D tx_errs;
> +            stats->tx_dropped =3D tx_dropped;
> +            fclose(fp);
> +            return 0;
> +        }
> +    }
> +    fclose(fp);
> +    g_debug("/proc/net/dev: Interface not found");
> +    return -1;
> +}
> +
>  /*
>   * Build information about guest interfaces
>   */
> @@ -1654,6 +1713,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_in=
terfaces(Error **errp)
>      for (ifa =3D ifap; ifa; ifa =3D ifa->ifa_next) {
>          GuestNetworkInterfaceList *info;
>          GuestIpAddressList **address_list =3D NULL, *address_item =3D NU=
LL;
> +        GuestNetworkInterfaceStat  *interface_stat =3D NULL;
>          char addr4[INET_ADDRSTRLEN];
>          char addr6[INET6_ADDRSTRLEN];
>          int sock;
> @@ -1773,7 +1833,16 @@ GuestNetworkInterfaceList *qmp_guest_network_get_i=
nterfaces(Error **errp)
> =

>          info->value->has_ip_addresses =3D true;
> =

> -
> +        if (!info->value->has_statistics) {
> +            interface_stat =3D g_malloc0(sizeof(*interface_stat));
> +            if (guest_get_network_stats(info->value->name,
> +                interface_stat) =3D=3D -1) {
> +                error_setg_errno(errp, errno, "guest_get_network_stats f=
ailed");

Need to free interface_stat here else you'll leak memory.

Since it's an optional field I'm not sure we should treat cases where
/proc/net/dev doesn't exist as a failure either. We should probably just
set has_statistics =3D false to maintain the existing support.

> +                goto error;
> +            }
> +            info->value->statistics =3D interface_stat;
> +            info->value->has_statistics =3D true;
> +        }
>      }
> =

>      freeifaddrs(ifap);
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..948219b 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -635,6 +635,38 @@
>             'prefix': 'int'} }
> =

>  ##
> +# @GuestNetworkInterfaceStat:
> +#
> +# @rx-bytes: total bytes received
> +#
> +# @rx-packets: total packets received
> +#
> +# @rx-errs: bad packets received
> +#
> +# @rx-dropped: receiver dropped packets
> +#
> +# @tx-bytes: total bytes transmitted
> +#
> +# @tx-packets: total packets transmitted
> +#
> +# @tx-errs: packet transmit problems
> +#
> +# @tx-dropped: dropped packets transmitted
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestNetworkInterfaceStat',
> +  'data': {'rx-bytes': 'uint64',
> +            'rx-packets': 'uint64',
> +            'rx-errs': 'uint64',
> +            'rx-dropped': 'uint64',
> +            'tx-bytes': 'uint64',
> +            'tx-packets': 'uint64',
> +            'tx-errs': 'uint64',
> +            'tx-dropped': 'uint64'
> +           } }
> +
> +##
>  # @GuestNetworkInterface:
>  #
>  # @name: The name of interface for which info are being delivered
> @@ -643,12 +675,16 @@
>  #
>  # @ip-addresses: List of addresses assigned to @name
>  #
> +# @statistics: various statistic counters related to @name
> +# (since 2.10)
> +#
>  # Since: 1.1
>  ##
>  { 'struct': 'GuestNetworkInterface',
>    'data': {'name': 'str',
>             '*hardware-address': 'str',
> -           '*ip-addresses': ['GuestIpAddress'] } }
> +           '*ip-addresses': ['GuestIpAddress'],
> +           '*statistics': 'GuestNetworkInterfaceStat' } }
> =

>  ##
>  # @guest-network-get-interfaces:
> -- =

> 1.8.3.1
> =

>=20
