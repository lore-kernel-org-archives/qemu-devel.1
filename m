Received: from eggs.gnu.org ([2001:4830:134:3::10]:53642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7sle-0006eI-Qu
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 20:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7slb-0003e8-Hy
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 20:44:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34446
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7slb-0003dv-BR
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 20:44:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R0df2X004310
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 20:44:52 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dusbctxxn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 20:44:51 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 18:44:51 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <201710260942101848409@zte.com.cn>
References: 1505206466-23361-1-git-send-email-lu.zhipeng@zte.com.cn,
	150897958836.17721.1457890502890375956@sif
	<201710260942101848409@zte.com.cn>
Date: Thu, 26 Oct 2017 19:44:27 -0500
Message-Id: <150906506782.2572.3504601241700390805@sif>
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIIHY3IFJFU0VORF0g?=
 =?utf-8?q?qga=3A_Add_support_network_interface_statistics_inguest-network?=
 =?utf-8?q?-get-interfaces_command?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lu.zhipeng@zte.com.cn
Cc: qemu-devel@nongnu.org

Quoting lu.zhipeng@zte.com.cn (2017-10-25 20:42:10)
> =

> >> +    if (NO_ERROR =3D=3D GetIfEntry(&aMib_ifrow)) {
> =

> =

> thanks,
> =

> I found may be overflow using GetIfEntry,thus GetIfEntry2 instead of =

> GetIfEntry.

I tried your fix-up patch at:
 https://patch-diff.githubusercontent.com/raw/mdroth/qemu/pull/5.patch

but ran into the compile issue below in a Fedora 20 mingw64 build environme=
nt.
It looks like you need MIB_IF_ROW2 instead of MIB_IFROW2, and even then it
looks like the struct fields are different and need to be fixed up.

I'll keep the current patch as it stands, but please send a tested
standalone fix against the qga tree to the list so we can get this case
addressed before rc0. I would also suggest we disable w32 stats completely
if GetIfEntry2() isn't available, since dealing with overflows is painful
from a management perspective.


x86_64-w64-mingw32-gcc -I/home/mdroth/qemu-build-w64/qga -Iqga -I/home/mdro=
th/w/qemu4.git/tcg -I/home/mdroth/w/qemu4.git/tcg/i386 -I. -I/home/mdroth/w=
/qemu4.git -I/home/mdroth/w/qemu4.git/accel/tcg -I/home/mdroth/w/qemu4.git/=
include -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixman-1  -I/home/=
mdroth/w/qemu4.git/dtc/libfdt -Werror -mms-bitfields -I/usr/x86_64-w64-ming=
w32/sys-root/mingw/include/glib-2.0 -I/usr/x86_64-w64-mingw32/sys-root/ming=
w/lib/glib-2.0/include  -m64 -mcx16 -mthreads -D__USE_MINGW_ANSI_STDIO=3D1 =
-DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D=
64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef =
-Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwra=
pv  -Wall -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-ex=
terns -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold=
-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-a=
ll -isystem /home/mdroth/w/vss-win32/ -I/home/mdroth/w/qemu4.git/tests -I q=
ga/qapi-generated -MMD -MP -MT qga/service-win32.o -MF qga/service-win32.d =
-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g   -c -o qga/service-win32.o =
/home/mdroth/w/qemu4.git/qga/service-win32.c
/home/mdroth/w/qemu4.git/qga/commands-win32.c: In function 'guest_get_netwo=
rk_stats':
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1200:20: error: 'MIB_IF_ROW2'=
 has no member named 'dwIndex'
         a_mid_ifrow.dwIndex =3D if_index;
                    ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1202:42: error: 'MIB_IF_ROW2'=
 has no member named 'dwInOctets'
             stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
                                          ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1203:44: error: 'MIB_IF_ROW2'=
 has no member named 'dwInUcastPkts'
             stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
                                            ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1204:41: error: 'MIB_IF_ROW2'=
 has no member named 'dwInErrors'
             stats->rx_errs =3D a_mid_ifrow.dwInErrors;
                                         ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1205:44: error: 'MIB_IF_ROW2'=
 has no member named 'dwInDiscards'
             stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
                                            ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1206:42: error: 'MIB_IF_ROW2'=
 has no member named 'dwOutOctets'
             stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
                                          ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1207:44: error: 'MIB_IF_ROW2'=
 has no member named 'dwOutUcastPkts'
             stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
                                            ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1208:41: error: 'MIB_IF_ROW2'=
 has no member named 'dwOutErrors'
             stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
                                         ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1209:44: error: 'MIB_IF_ROW2'=
 has no member named 'dwOutDiscards'
             stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
                                            ^
make: *** [qga/commands-win32.o] Error 1
make: *** Waiting for unfinished jobs....

> =

> =

> =E4=B8=BA=E4=BA=86=E8=AE=A9=E6=82=A8=E7=9A=84VPlat=E8=99=9A=E6=8B=9F=E6=
=9C=BA=E6=95=85=E9=9A=9C=E5=92=8Cdocker=E6=95=85=E9=9A=9C=E5=BE=97=E5=88=B0=
=E9=AB=98=E6=95=88=E7=9A=84=E5=A4=84=E7=90=86=EF=BC=8C=E8=AF=B7=E4=B8=8A=E6=
=8A=A5=E6=95=85=E9=9A=9C=E5=88=B0: $VPlat=E6=8A=80=E6=9C=AF=E6=94=AF
> =E6=8C=81=E3=80=82
> =

> =E8=8A=A6=E5=BF=97=E6=9C=8B luzhipeng
> =

> =

> IT=E5=BC=80=E5=8F=91=E5=B7=A5=E7=A8=8B=E5=B8=88 IT Development Engineer
> =E6=93=8D=E4=BD=9C=E7=B3=BB=E7=BB=9F=E4=BA=A7=E5=93=81=E9=83=A8/=E4=B8=AD=
=E5=BF=83=E7=A0=94=E7=A9=B6=E9=99=A2/=E7=B3=BB=E7=BB=9F=E4=BA=A7=E5=93=81 O=
S Product Dept./Central R=EF=BC=86D Institute/
> System Product
> =

> =

> [cid]          [cid]
>                =E5=9B=9B=E5=B7=9D=E7=9C=81=E6=88=90=E9=83=BD=E5=B8=82=E5=
=A4=A9=E5=BA=9C=E5=A4=A7=E9=81=93=E4=B8=AD=E6=AE=B5800=E5=8F=B7
>                E: lu.zhipeng@zte.com.cn
>                www.zte.com.cn
> =

> =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A <mdroth@linux.vnet.ibm.com>;
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E8=8A=A6=E5=BF=97=E6=9C=8B10108272;
> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A <qemu-devel@nongnu.org>;=E8=8A=A6=E5=
=BF=97=E6=9C=8B10108272;
> =E6=97=A5=E6=9C=9F=EF=BC=9A2017=E5=B9=B410=E6=9C=8826=E6=97=A5 09:00
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH v7 RESEND] qga: Add support network=
 interface statistics
> inguest-network-get-interfaces command
> =

> =

> Quoting ZhiPeng Lu (2017-09-12 03:54:26)
> > we can get the network interface statistics inside a virtual machine by
> > guest-network-get-interfaces command. it is very useful for us to monit=
or
> > and analyze network traffic.
> > =

> > Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> =

> Thanks, applied to qga tree:
>   https://github.com/mdroth/qemu/commits/qga
> =

> There were a few issues that I noted below, but I tested on linux/windows
> and things seem to be working well so I fixed them up in my tree.
> =

> > =

> > ---
> > v1->v2:
> >  - correct some spelling mistake and add the stats data to the
> >    guest-network-get-interfaces command instead of adding a new command.
> > v2-v3:
> >  - optimize function implementation
> > v3->v4:
> >  - modify compile error
> > v4->v5:
> >  - rename some temporary variables and add str_trim_off function for
> >
>     calculating the space num in front of the string in guest_get_network=
_stats
> > v5->v6:
> >  - use g_strchug instead of str_trim_off implemented by myself
> > v6->v7:
> >  - add implementation for windows
> > ---
> >  qga/commands-posix.c |
>  72 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  qga/commands-win32.c | 48 +++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json | 38 ++++++++++++++++++++++++++-
> >  3 files changed, 156 insertions(+), 2 deletions(-)
> > =

> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index ab0c63d..da5dba0 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -1643,6 +1643,65 @@ guest_find_interface(GuestNetworkInterfaceList *=
head,
> >      return head;
> >  }
> > =

> > +static int guest_get_network_stats(const char *name,
> > +                       GuestNetworkInterfaceStat *stats)
> > +{
> > +    int name_len;
> > +    char const *devinfo =3D "/proc/net/dev";
> > +    FILE *fp;
> > +    char *line =3D NULL, *colon;
> > +    size_t n;
> =

> Not sure if it affects behavior in practice, but getline() documentation
> states that *line is only allocated if *line =3D=3D NULL *and* n =3D=3D 0=
. So we
> should set n to 0 before each call to be safe.
> =

> > +    fp =3D fopen(devinfo, "r");
> > +    if (!fp) {
> > +        return -1;
> > +    }
> > +    name_len =3D strlen(name);
> > +    while (getline(&line, &n, fp) !=3D -1) {
> =

> Since 'line' is being allocated by getline(), we need to free it after
> each call, or rely on it to realloc and then free that value before
> returning. The latter seems simpler in this case.
> =

> > +        long long dummy;
> > +        long long rx_bytes;
> > +        long long rx_packets;
> > +        long long rx_errs;
> > +        long long rx_dropped;
> > +        long long tx_bytes;
> > +        long long tx_packets;
> > +        long long tx_errs;
> > +        long long tx_dropped;
> > +        char *trim_line;
> > +        trim_line =3D g_strchug(line);
> > +        if (trim_line[0] =3D=3D '\0') {
> > +            continue;
> > +        }
> > +        colon =3D strchr(trim_line, ':');
> > +        if (!colon) {
> > +            continue;
> > +        }
> > +        if (colon - name_len  =3D=3D trim_line &&
> > +           strncmp(trim_line, name, name_len) =3D=3D 0) {
> > +            if (sscanf(colon + 1,
> >
>  +                "%lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld=
 %lld %lld %lld %lld %lld",
> > +                  &rx_bytes, &rx_packets, &rx_errs, &rx_dropped,
> > +                  &dummy, &dummy, &dummy, &dummy,
> > +                  &tx_bytes, &tx_packets, &tx_errs, &tx_dropped,
> > +                  &dummy, &dummy, &dummy, &dummy) !=3D 16) {
> > +                continue;
> > +            }
> > +            stats->rx_bytes =3D rx_bytes;
> > +            stats->rx_packets =3D rx_packets;
> > +            stats->rx_errs =3D rx_errs;
> > +            stats->rx_dropped =3D rx_dropped;
> > +            stats->tx_bytes =3D tx_bytes;
> > +            stats->tx_packets =3D tx_packets;
> > +            stats->tx_errs =3D tx_errs;
> > +            stats->tx_dropped =3D tx_dropped;
> > +            fclose(fp);
> > +            return 0;
> > +        }
> > +    }
> > +    fclose(fp);
> > +    g_debug("/proc/net/dev: Interface not found");
> =

> Reporting the specific interface name might be useful here.
> =

> > +    return -1;
> > +}
> > +
> >  /*
> >   * Build information about guest interfaces
> >   */
> >
>  @@ -1659,6 +1718,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_i=
nterfaces
> (Error **errp)
> >      for (ifa =3D ifap; ifa; ifa =3D ifa->ifa_next) {
> >          GuestNetworkInterfaceList *info;
> >          GuestIpAddressList **address_list =3D NULL, *address_item =3D =
NULL;
> > +        GuestNetworkInterfaceStat  *interface_stat =3D NULL;
> >          char addr4[INET_ADDRSTRLEN];
> >          char addr6[INET6_ADDRSTRLEN];
> >          int sock;
> >
>  @@ -1778,7 +1838,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_=
interfaces
> (Error **errp)
> > =

> >          info->value->has_ip_addresses =3D true;
> > =

> > -
> > +        if (!info->value->has_statistics) {
> > +            interface_stat =3D g_malloc0(sizeof(*interface_stat));
> > +            if (guest_get_network_stats(info->value->name,
> > +                interface_stat) =3D=3D -1) {
> > +                info->value->has_statistics =3D false;
> > +                g_free(interface_stat);
> > +            } else {
> > +                info->value->statistics =3D interface_stat;
> > +                info->value->has_statistics =3D true;
> > +            }
> > +        }
> >      }
> > =

> >      freeifaddrs(ifap);
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 619dbd2..e891253 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -1152,6 +1152,42 @@ out:
> >  }
> >  #endif
> > =

> > +static DWORD get_interface_index(const char *guid)
> > +{
> > +    ULONG index;
> > +    DWORD status;
> > +    wchar_t wbuf[512];
> > +    snwprintf(wbuf, sizeof(wbuf), L"\\device\\tcpip_%s", guid);
> > +    wbuf[sizeof(wbuf) - 1] =3D 0;
> =

> wchar_t can be larger than 1 byte, so using sizeof(wchar_t[]) as an
> index into a wchar_t[] can cause an overrun.
> =

> > +    status =3D GetAdapterIndex (wbuf, &index);
> > +    if (status !=3D NO_ERROR) {
> > +        return (DWORD)~0;
> > +    } else {
> > +        return index;
> > +    }
> > +}
> > +static int guest_get_network_stats(const char *name,
> > +                       GuestNetworkInterfaceStat *stats)
> > +{
> > +    DWORD IfIndex =3D 0;
> > +    MIB_IFROW aMib_ifrow;
> > +    memset(&aMib_ifrow, 0, sizeof(aMib_ifrow));
> > +    IfIndex =3D get_interface_index(name);
> =

> Per CODING_STYLE variable names should be lowercase with "_" for
> separating words
> =

> > +    aMib_ifrow.dwIndex =3D IfIndex;
> > +    if (NO_ERROR =3D=3D GetIfEntry(&aMib_ifrow)) {
> > +        stats->rx_bytes =3D aMib_ifrow.dwInOctets;
> > +        stats->rx_packets =3D aMib_ifrow.dwInUcastPkts;
> > +        stats->rx_errs =3D aMib_ifrow.dwInErrors;
> > +        stats->rx_dropped =3D aMib_ifrow.dwInDiscards;
> > +        stats->tx_bytes =3D aMib_ifrow.dwOutOctets;
> > +        stats->tx_packets =3D aMib_ifrow.dwOutUcastPkts;
> > +        stats->tx_errs =3D aMib_ifrow.dwOutErrors;
> > +        stats->tx_dropped =3D aMib_ifrow.dwOutDiscards;
> > +        return 0;
> > +    }
> > +    return -1;
> > +}
> > +
> >  GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **er=
rp)
> >  {
> >      IP_ADAPTER_ADDRESSES *adptr_addrs, *addr;
> >
>  @@ -1159,6 +1195,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_i=
nterfaces
> (Error **errp)
> >      GuestNetworkInterfaceList *head =3D NULL, *cur_item =3D NULL;
> >      GuestIpAddressList *head_addr, *cur_addr;
> >      GuestNetworkInterfaceList *info;
> > +    GuestNetworkInterfaceStat *interface_stat =3D NULL;
> >      GuestIpAddressList *address_item =3D NULL;
> >      unsigned char *mac_addr;
> >      char *addr_str;
> >
>  @@ -1238,6 +1275,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_=
interfaces
> (Error **errp)
> >              info->value->has_ip_addresses =3D true;
> >              info->value->ip_addresses =3D head_addr;
> >          }
> > +        if (!info->value->has_statistics) {
> > +            interface_stat =3D g_malloc0(sizeof(*interface_stat));
> > +            if (guest_get_network_stats(addr->AdapterName,
> > +                interface_stat) =3D=3D -1) {
> > +                info->value->has_statistics =3D false;
> > +                g_free(interface_stat);
> > +            } else {
> > +                info->value->statistics =3D interface_stat;
> > +                info->value->has_statistics =3D true;
> > +            }
> > +        }
> >      }
> >      WSACleanup();
> >  out:
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 90a0c86..17884c7 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -643,6 +643,38 @@
> >             'prefix': 'int'} }
> > =

> >  ##
> > +# @GuestNetworkInterfaceStat:
> > +#
> > +# @rx-bytes: total bytes received
> > +#
> > +# @rx-packets: total packets received
> > +#
> > +# @rx-errs: bad packets received
> > +#
> > +# @rx-dropped: receiver dropped packets
> > +#
> > +# @tx-bytes: total bytes transmitted
> > +#
> > +# @tx-packets: total packets transmitted
> > +#
> > +# @tx-errs: packet transmit problems
> > +#
> > +# @tx-dropped: dropped packets transmitted
> > +#
> > +# Since: 2.11
> > +##
> > +{ 'struct': 'GuestNetworkInterfaceStat',
> > +  'data': {'rx-bytes': 'uint64',
> > +            'rx-packets': 'uint64',
> > +            'rx-errs': 'uint64',
> > +            'rx-dropped': 'uint64',
> > +            'tx-bytes': 'uint64',
> > +            'tx-packets': 'uint64',
> > +            'tx-errs': 'uint64',
> > +            'tx-dropped': 'uint64'
> > +           } }
> > +
> > +##
> >  # @GuestNetworkInterface:
> >  #
> >  # @name: The name of interface for which info are being delivered
> > @@ -651,12 +683,16 @@
> >  #
> >  # @ip-addresses: List of addresses assigned to @name
> >  #
> > +# @statistics: various statistic counters related to @name
> > +# (since 2.11)
> > +#
> >  # Since: 1.1
> >  ##
> >  { 'struct': 'GuestNetworkInterface',
> >    'data': {'name': 'str',
> >             '*hardware-address': 'str',
> > -           '*ip-addresses': ['GuestIpAddress'] } }
> > +           '*ip-addresses': ['GuestIpAddress'],
> > +           '*statistics': 'GuestNetworkInterfaceStat' } }
> > =

> >  ##
> >  # @guest-network-get-interfaces:
> > -- =

> > 1.8.3.1
> > =

> =

>=20
