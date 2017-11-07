Received: from eggs.gnu.org ([2001:4830:134:3::10]:46501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eC7Kl-000236-JB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eC7Kg-0004G8-PK
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:06:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eC7Kg-0004Du-GB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:06:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7H5F55020165
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:06:33 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3e62tccn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:06:32 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 10:06:31 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1509720860-10065-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1509720860-10065-1-git-send-email-lu.zhipeng@zte.com.cn>
Date: Tue, 07 Nov 2017 11:06:15 -0600
Message-Id: <151007437551.31225.7183381961531333303@sif>
Subject: Re: [Qemu-devel] [PATCH v2] qga: replace GetIfEntry
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

Quoting ZhiPeng Lu (2017-11-03 09:54:20)
> The data obtained by GetIfEntry is 32 bits, and it may overflow. Thus usi=
ng GetIfEntry2 instead of GetIfEntry.
> =

> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  qga/commands-win32.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0322188..d096dc2 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1173,20 +1173,25 @@ static int guest_get_network_stats(const char *na=
me,
>                         GuestNetworkInterfaceStat *stats)
>  {
>      DWORD if_index =3D 0;
> -    MIB_IFROW a_mid_ifrow;
> -    memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
> +    OSVERSIONINFO OSver;
>      if_index =3D get_interface_index(name);
> -    a_mid_ifrow.dwIndex =3D if_index;
> -    if (NO_ERROR =3D=3D GetIfEntry(&a_mid_ifrow)) {
> -        stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
> -        stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
> -        stats->rx_errs =3D a_mid_ifrow.dwInErrors;
> -        stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
> -        stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
> -        stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
> -        stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
> -        stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
> -        return 0;
> +    OSver.dwOSVersionInfoSize =3D sizeof(OSVERSIONINFO);
> +    GetVersionEx(&OSver);
> +    if (OSver.dwMajorVersion >=3D 6) {
> +        MIB_IF_ROW2 a_mid_ifrow;
> +        memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
> +        a_mid_ifrow.dwIndex =3D if_index;
> +        if (NO_ERROR =3D=3D GetIfEntry2(&a_mid_ifrow)) {
> +            stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
> +            stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
> +            stats->rx_errs =3D a_mid_ifrow.dwInErrors;
> +            stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
> +            stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
> +            stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
> +            stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
> +            stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
> +            return 0;

This fails to build in my fc20 mingw64 environment:

/home/mdroth/w/qemu4.git/qga/commands-win32.c:1184:20: error: 'MIB_IF_ROW2'=
 has no member named 'dwIndex'
         a_mid_ifrow.dwIndex =3D if_index;
                    ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1186:42: error: 'MIB_IF_ROW2'=
 has no member named 'dwInOctets'
             stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
                                          ^
/home/mdroth/w/qemu4.git/qga/commands-win32.c:1187:44: error: 'MIB_IF_ROW2'=
 has no member named 'dwInUcastPkts'
             stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;

etc ...

The patch seems to assume MIB_IFROW and MIB_IF_ROW2 have the same field nam=
es
for the stats, but according to this they're slightly different:

  https://msdn.microsoft.com/en-us/library/windows/desktop/aa814491(v=3Dvs.=
85).aspx

This change on top of your patch seems to work:

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index e17fc3c284..58e470877f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1181,16 +1181,16 @@ static int guest_get_network_stats(const char *name,
     if (os_ver.dwMajorVersion >=3D 6) {
         MIB_IF_ROW2 a_mid_ifrow;
         memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
-        a_mid_ifrow.dwIndex =3D if_index;
+        a_mid_ifrow.InterfaceIndex =3D if_index;
         if (NO_ERROR =3D=3D GetIfEntry2(&a_mid_ifrow)) {
-            stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
-            stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
-            stats->rx_errs =3D a_mid_ifrow.dwInErrors;
-            stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
-            stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
-            stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
-            stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
-            stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
+            stats->rx_bytes =3D a_mid_ifrow.InOctets;
+            stats->rx_packets =3D a_mid_ifrow.InUcastPkts;
+            stats->rx_errs =3D a_mid_ifrow.InErrors;
+            stats->rx_dropped =3D a_mid_ifrow.InDiscards;
+            stats->tx_bytes =3D a_mid_ifrow.OutOctets;
+            stats->tx_packets =3D a_mid_ifrow.OutUcastPkts;
+            stats->tx_errs =3D a_mid_ifrow.OutErrors;
+            stats->tx_dropped =3D a_mid_ifrow.OutDiscards;
             return 0;
         }
     }

I have the modified patch staged here:

  https://github.com/mdroth/qemu/commit/de597a8b27722ce4f9cc660f930f7dccc71=
2712d

Let me know if it looks okay and I'll send a pull request for rc1

> +        }
>      }
>      return -1;
>  }
> -- =

> 1.8.3.1
>=20
