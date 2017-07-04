Received: from eggs.gnu.org ([2001:4830:134:3::10]:60183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSOsB-0001KJ-LY
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSOs9-00018W-Mh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:32:15 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dSOs9-00016O-9Z
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:32:13 -0400
Received: by mail-lf0-x241.google.com with SMTP id z78so5778660lff.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1499186732-32417-1-git-send-email-lu.zhipeng@zte.com.cn>
In-Reply-To: <1499186732-32417-1-git-send-email-lu.zhipeng@zte.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 04 Jul 2017 14:32:01 +0000
Message-ID: <CAJ+F1CJ3bsqGYe4wNW4oxdObukAcRUo0sPn9T8FDLC8s0OfesQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v6] qga: Add support network
 interface statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

Hi

On Tue, Jul 4, 2017 at 10:51 AM ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:

> we can get the network interface statistics inside a virtual machine by
> guest-network-get-interfaces command. it is very useful for us to monitor
> and analyze network traffic.
>
>
It's nicer if you give v1->v2->..->v6 change summary at each revision


> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  qga/commands-posix.c | 80
> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  qga/qapi-schema.json | 38 ++++++++++++++++++++++++-
>  2 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 915df9e..233b024 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1638,6 +1638,73 @@ guest_find_interface(GuestNetworkInterfaceList
> *head,
>      return head;
>  }
>
> +
> +static int str_trim_off(const char *s, int off, int lmt)
> +{
> +    for (; off < lmt; ++off) {
> +        if (!isspace(s[off])) {
> +            break;
> +        }
> +    }
> +    return off;
> +}
> +
> +static int guest_get_network_stats(const char *name,
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
>

 Why have local variables, and not pass stats->filed directly?

+        int trim_off;
> +        colon =3D strchr(line, ':');
> +        if (!colon) {
> +            continue;
> +        }
> +        trim_off =3D str_trim_off(line, 0, strlen(line));
>

Couldn't you  call g_strchomp() ?


> +        if (colon - name_len - trim_off =3D=3D line &&
> +           strncmp(line + trim_off, name, colon - line - trim_off) =3D=
=3D 0) {
> +            if (sscanf(colon + 1,
> +                "%lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld
> %lld %lld %lld %lld %lld",
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
> @@ -1654,6 +1721,7 @@ GuestNetworkInterfaceList
> *qmp_guest_network_get_interfaces(Error **errp)
>      for (ifa =3D ifap; ifa; ifa =3D ifa->ifa_next) {
>          GuestNetworkInterfaceList *info;
>          GuestIpAddressList **address_list =3D NULL, *address_item =3D NU=
LL;
> +        GuestNetworkInterfaceStat  *interface_stat =3D NULL;
>          char addr4[INET_ADDRSTRLEN];
>          char addr6[INET6_ADDRSTRLEN];
>          int sock;
> @@ -1773,7 +1841,17 @@ GuestNetworkInterfaceList
> *qmp_guest_network_get_interfaces(Error **errp)
>
>          info->value->has_ip_addresses =3D true;
>
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
>
>      freeifaddrs(ifap);
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..948219b 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -635,6 +635,38 @@
>             'prefix': 'int'} }
>
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
>
>  ##
>  # @guest-network-get-interfaces:
> --
> 1.8.3.1
>

looks good to me otherwise,

--=20
Marc-Andr=C3=A9 Lureau
