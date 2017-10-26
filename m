Received: from eggs.gnu.org ([2001:4830:134:3::10]:46016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7WWx-0006dM-HM
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7WWu-0001jS-Bm
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:00:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7WWu-0001iW-32
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:00:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9Q0xaZL120783
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 21:00:11 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2du0k0m2nv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 21:00:10 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 21:00:08 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1505206466-23361-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1505206466-23361-1-git-send-email-lu.zhipeng@zte.com.cn>
Date: Wed, 25 Oct 2017 19:59:48 -0500
Message-Id: <150897958836.17721.1457890502890375956@sif>
Subject: Re: [Qemu-devel] [PATCH v7 RESEND] qga: Add support network
 interface statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: qemu-devel@nongnu.org

Quoting ZhiPeng Lu (2017-09-12 03:54:26)
> we can get the network interface statistics inside a virtual machine by
> guest-network-get-interfaces command. it is very useful for us to monitor
> and analyze network traffic.
> =

> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

There were a few issues that I noted below, but I tested on linux/windows
and things seem to be working well so I fixed them up in my tree.

> =

> ---
> v1->v2:
>  - correct some spelling mistake and add the stats data to the
>    guest-network-get-interfaces command instead of adding a new command.
> v2-v3:
>  - optimize function implementation
> v3->v4:
>  - modify compile error
> v4->v5:
>  - rename some temporary variables and add str_trim_off function for
>    calculating the space num in front of the string in guest_get_network_=
stats
> v5->v6:
>  - use g_strchug instead of str_trim_off implemented by myself
> v6->v7:
>  - add implementation for windows
> ---
>  qga/commands-posix.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  qga/commands-win32.c | 48 +++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 38 ++++++++++++++++++++++++++-
>  3 files changed, 156 insertions(+), 2 deletions(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index ab0c63d..da5dba0 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1643,6 +1643,65 @@ guest_find_interface(GuestNetworkInterfaceList *he=
ad,
>      return head;
>  }
> =

> +static int guest_get_network_stats(const char *name,
> +                       GuestNetworkInterfaceStat *stats)
> +{
> +    int name_len;
> +    char const *devinfo =3D "/proc/net/dev";
> +    FILE *fp;
> +    char *line =3D NULL, *colon;
> +    size_t n;

Not sure if it affects behavior in practice, but getline() documentation
states that *line is only allocated if *line =3D=3D NULL *and* n =3D=3D 0. =
So we
should set n to 0 before each call to be safe.

> +    fp =3D fopen(devinfo, "r");
> +    if (!fp) {
> +        return -1;
> +    }
> +    name_len =3D strlen(name);
> +    while (getline(&line, &n, fp) !=3D -1) {

Since 'line' is being allocated by getline(), we need to free it after
each call, or rely on it to realloc and then free that value before
returning. The latter seems simpler in this case.

> +        long long dummy;
> +        long long rx_bytes;
> +        long long rx_packets;
> +        long long rx_errs;
> +        long long rx_dropped;
> +        long long tx_bytes;
> +        long long tx_packets;
> +        long long tx_errs;
> +        long long tx_dropped;
> +        char *trim_line;
> +        trim_line =3D g_strchug(line);
> +        if (trim_line[0] =3D=3D '\0') {
> +            continue;
> +        }
> +        colon =3D strchr(trim_line, ':');
> +        if (!colon) {
> +            continue;
> +        }
> +        if (colon - name_len  =3D=3D trim_line &&
> +           strncmp(trim_line, name, name_len) =3D=3D 0) {
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

Reporting the specific interface name might be useful here.

> +    return -1;
> +}
> +
>  /*
>   * Build information about guest interfaces
>   */
> @@ -1659,6 +1718,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_in=
terfaces(Error **errp)
>      for (ifa =3D ifap; ifa; ifa =3D ifa->ifa_next) {
>          GuestNetworkInterfaceList *info;
>          GuestIpAddressList **address_list =3D NULL, *address_item =3D NU=
LL;
> +        GuestNetworkInterfaceStat  *interface_stat =3D NULL;
>          char addr4[INET_ADDRSTRLEN];
>          char addr6[INET6_ADDRSTRLEN];
>          int sock;
> @@ -1778,7 +1838,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_i=
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
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 619dbd2..e891253 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1152,6 +1152,42 @@ out:
>  }
>  #endif
> =

> +static DWORD get_interface_index(const char *guid)
> +{
> +    ULONG index;
> +    DWORD status;
> +    wchar_t wbuf[512];
> +    snwprintf(wbuf, sizeof(wbuf), L"\\device\\tcpip_%s", guid);
> +    wbuf[sizeof(wbuf) - 1] =3D 0;

wchar_t can be larger than 1 byte, so using sizeof(wchar_t[]) as an
index into a wchar_t[] can cause an overrun.

> +    status =3D GetAdapterIndex (wbuf, &index);
> +    if (status !=3D NO_ERROR) {
> +        return (DWORD)~0;
> +    } else {
> +        return index;
> +    }
> +}
> +static int guest_get_network_stats(const char *name,
> +                       GuestNetworkInterfaceStat *stats)
> +{
> +    DWORD IfIndex =3D 0;
> +    MIB_IFROW aMib_ifrow;
> +    memset(&aMib_ifrow, 0, sizeof(aMib_ifrow));
> +    IfIndex =3D get_interface_index(name);

Per CODING_STYLE variable names should be lowercase with "_" for
separating words

> +    aMib_ifrow.dwIndex =3D IfIndex;
> +    if (NO_ERROR =3D=3D GetIfEntry(&aMib_ifrow)) {
> +        stats->rx_bytes =3D aMib_ifrow.dwInOctets;
> +        stats->rx_packets =3D aMib_ifrow.dwInUcastPkts;
> +        stats->rx_errs =3D aMib_ifrow.dwInErrors;
> +        stats->rx_dropped =3D aMib_ifrow.dwInDiscards;
> +        stats->tx_bytes =3D aMib_ifrow.dwOutOctets;
> +        stats->tx_packets =3D aMib_ifrow.dwOutUcastPkts;
> +        stats->tx_errs =3D aMib_ifrow.dwOutErrors;
> +        stats->tx_dropped =3D aMib_ifrow.dwOutDiscards;
> +        return 0;
> +    }
> +    return -1;
> +}
> +
>  GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
>  {
>      IP_ADAPTER_ADDRESSES *adptr_addrs, *addr;
> @@ -1159,6 +1195,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_in=
terfaces(Error **errp)
>      GuestNetworkInterfaceList *head =3D NULL, *cur_item =3D NULL;
>      GuestIpAddressList *head_addr, *cur_addr;
>      GuestNetworkInterfaceList *info;
> +    GuestNetworkInterfaceStat *interface_stat =3D NULL;
>      GuestIpAddressList *address_item =3D NULL;
>      unsigned char *mac_addr;
>      char *addr_str;
> @@ -1238,6 +1275,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_i=
nterfaces(Error **errp)
>              info->value->has_ip_addresses =3D true;
>              info->value->ip_addresses =3D head_addr;
>          }
> +        if (!info->value->has_statistics) {
> +            interface_stat =3D g_malloc0(sizeof(*interface_stat));
> +            if (guest_get_network_stats(addr->AdapterName,
> +                interface_stat) =3D=3D -1) {
> +                info->value->has_statistics =3D false;
> +                g_free(interface_stat);
> +            } else {
> +                info->value->statistics =3D interface_stat;
> +                info->value->has_statistics =3D true;
> +            }
> +        }
>      }
>      WSACleanup();
>  out:
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 90a0c86..17884c7 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -643,6 +643,38 @@
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
> +# Since: 2.11
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
> @@ -651,12 +683,16 @@
>  #
>  # @ip-addresses: List of addresses assigned to @name
>  #
> +# @statistics: various statistic counters related to @name
> +# (since 2.11)
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
>=20
