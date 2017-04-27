Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3jhR-0002br-PD
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3jhM-0001xY-PQ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:43:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3jhM-0001wv-Fg
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:43:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3RDclxm113232
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 09:43:06 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3hf4h411-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 09:43:05 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 07:43:03 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1493285103-15769-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1493285103-15769-1-git-send-email-lu.zhipeng@zte.com.cn>
Date: Thu, 27 Apr 2017 08:42:54 -0500
Message-Id: <149330057491.32299.926967066829083805@loki>
Subject: Re: [Qemu-devel] [PATCH v5] qga: Add support network interface
 statistics in guest-network-get-interfaces command
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

Quoting ZhiPeng Lu (2017-04-27 04:25:03)
> we can get the network interface statistics inside a virtual machine by
> guest-network-get-interfaces command. it is very useful for us to monitor
> and analyze network traffic.
> =

> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qga/commands-posix.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  qga/qapi-schema.json | 38 ++++++++++++++++++++++++++++-
>  2 files changed, 104 insertions(+), 2 deletions(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 915df9e..8dbf30e 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1638,6 +1638,61 @@ guest_find_interface(GuestNetworkInterfaceList *he=
ad,
>      return head;
>  }
> =

> + static int guest_get_network_stats(const char *name,
> +                       GuestNetworkInterfaceStat *stats)
> +{
> +    int name_len;
> +    char const *devinfo =3D "/proc/net/dev";
> +    FILE *fp;
> +    char *line =3D NULL, *colon;
> +    size_t n;
> +    fp =3D fopen(devinfo, "r");
> +    if (!fp) {
> +        return -1;
> +    }
> +    name_len =3D strlen(name);
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
> +        colon =3D strchr(line, ':');
> +        if (!colon) {
> +            continue;
> +        }
> +        *colon =3D '\0';
> +        if (colon - name_len >=3D line && strcmp(colon - name_len, name)=
 =3D=3D 0) {

I was off by one the last time I pointed this out, but you really need
to make sure the logic is tightened to check:

  colon - name_len - 1 =3D=3D line

Consider a case where you have devices named, for example: "net0" and
"guest_net0", and you're searching for stats for "net0". If your code
sees the "guest_net0" line first, it will consider it a match because
you are not anchoring your search to the start of the line.

Once you modify that check, you can also change the code to use:

  strncmp(line, name, name_len)

which I think makes the intent clearer. If you do that, you can also
drop the "*colon =3D '\0'".

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
> @@ -1654,6 +1709,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_in=
terfaces(Error **errp)
>      for (ifa =3D ifap; ifa; ifa =3D ifa->ifa_next) {
>          GuestNetworkInterfaceList *info;
>          GuestIpAddressList **address_list =3D NULL, *address_item =3D NU=
LL;
> +        GuestNetworkInterfaceStat  *interface_stat =3D NULL;
>          char addr4[INET_ADDRSTRLEN];
>          char addr6[INET6_ADDRSTRLEN];
>          int sock;
> @@ -1773,7 +1829,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_i=
nterfaces(Error **errp)
> =

>          info->value->has_ip_addresses =3D true;
> =

> -
> +        if (!info->value->has_statistics) {
> +            interface_stat =3D g_malloc0(sizeof(*interface_stat));
> +            if (guest_get_network_stats(info->value->name,
> +                interface_stat) =3D=3D -1) {
> +                info->value->has_statistics =3D false;
> +                g_free(interface_stat);
> +            } else {
> +                info->value->statistics =3D interface_stat;
> +                info->value->has_statistics =3D true;
> +            }
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
