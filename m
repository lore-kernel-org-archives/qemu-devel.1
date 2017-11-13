Received: from eggs.gnu.org ([2001:4830:134:3::10]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eES72-0000pT-T8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 22:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eES6x-0000Ge-TY
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 22:42:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eES6x-0000G2-Jw
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 22:42:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADNvIYC067619
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 18:57:18 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e7nh1001d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 18:57:17 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 16:57:17 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <201711091926153814085@zte.com.cn>
References: 1509720860-10065-1-git-send-email-lu.zhipeng@zte.com.cn,
	151007437551.31225.7183381961531333303@sif,
	201711081054264975328@zte.com.cn <201711091926153814085@zte.com.cn>
Date: Mon, 13 Nov 2017 17:57:09 -0600
Message-Id: <151061742918.31225.7414533990256735419@sif>
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIIHYyXSBxZ2E6IHJl?=
 =?utf-8?q?place_GetIfEntry?=
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

Quoting lu.zhipeng@zte.com.cn (2017-11-09 05:26:15)
>  i think the code is better
> =

>  if (OSver.dwMajorVersion >=3D 6) {
>       MIB_IF_ROW2 aMib_ifrow;
>       typedef NETIOAPI_API (WINAPI *getifentry2_t)(PMIB_IF_ROW2 Row);
>       memset(&aMib_ifrow, 0, sizeof(aMib_ifrow));
>       aMib_ifrow.InterfaceIndex =3D nicId;
>       HMODULE module =3D GetModuleHandle("iphlpapi");
>       PVOID fun =3D GetProcAddress(module, "GetIfEntry2");
>       if (fun =3D=3D NULL) {
>           error_setg(errp, QERR_QGA_COMMAND_FAILED,
>                      "Failed to get address of GetIfEntry2");
>           return NULL;
>       }
>     getifentry2_t getifentry2_ex =3D (getifentry2_t)fun;
>     if (NO_ERROR =3D=3D getifentry2_ex(&aMib_ifrow)){
>     }

I've updated the patch with this change:
  https://github.com/mdroth/qemu/commits/qga-if-stats

But I'm a bit confused now: when I tried to test this on XP I realized that
that qemu-ga no longer works on XP, and generates the following error
when I try to start it (even without your stats patch):

  "The procedure entry point AcquireSRWLockExclusive could not be located
   in the dynamic link library KERNEL32.dll"

I think this may be due to the following commit, which notes that Vista+
are now required as a result:

commit 12f8def0e02232d7c6416ad9b66640f973c531d1
Author: Andrey Shedel <ashedel@microsoft.com>
Date:   Fri Mar 24 15:01:41 2017 -0700

    win32: replace custom mutex and condition variable with native
    primitives

So, are you actually able to run on XP currently? If so, how? And if
not, I think we have other issues that need to be addressed if we
want to support XP still; I'm not even sure that's realistic at this
point.

Unless there's actually a way to test QGA on XP right now I think I
we should just get in the updated patch minus the dynamic DLL stuff,
i.e.:
  https://github.com/mdroth/qemu/commit/de597a8b27722ce4f9cc660f930f7dccc71=
2712d

Make sense?

> =

> =

> =

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
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E8=8A=A6=E5=BF=97=E6=9C=8B10108272
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A <mdroth@linux.vnet.ibm.com>;
> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A <qemu-devel@nongnu.org>;
> =E6=97=A5=E6=9C=9F=EF=BC=9A2017=E5=B9=B411=E6=9C=8808=E6=97=A5 10:54
> =E4=B8=BB=E9=A2=98=EF=BC=9A=E7=AD=94=E5=A4=8D: Re: [PATCH v2] qga: replac=
e GetIfEntry
> =

> =

> >I have the modified patch staged here:
> =

> >  https://github.com/mdroth/qemu/commit/
> de597a8b27722ce4f9cc660f930f7dccc712712d
> >Let me know if it looks okay and I'll send a pull request for rc1
> =

>  =

> =

> the code right, but running QGA on the Windows XP, error: can not find th=
e link
> to  GetIfEntry2 in iphlpapi.DLL.
> =

> =

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

> =

> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A <mdroth@linux.vnet.ibm.com>;
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E8=8A=A6=E5=BF=97=E6=9C=8B10108272;
> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A <qemu-devel@nongnu.org>;=E8=8A=A6=E5=
=BF=97=E6=9C=8B10108272;
> =E6=97=A5=E6=9C=9F=EF=BC=9A2017=E5=B9=B411=E6=9C=8808=E6=97=A5 01:07
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH v2] qga: replace GetIfEntry
> =

> =

> Quoting ZhiPeng Lu (2017-11-03 09:54:20)
> >
>  The data obtained by GetIfEntry is 32 bits, and it may overflow. Thus us=
ing GetIfEntry2 instead of GetIfEntry.
> > =

> > Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> > ---
> >  qga/commands-win32.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > =

> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 0322188..d096dc2 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -1173,20 +1173,25 @@ static int guest_get_network_stats(const char *=
name,
> >                         GuestNetworkInterfaceStat *stats)
> >  {
> >      DWORD if_index =3D 0;
> > -    MIB_IFROW a_mid_ifrow;
> > -    memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
> > +    OSVERSIONINFO OSver;
> >      if_index =3D get_interface_index(name);
> > -    a_mid_ifrow.dwIndex =3D if_index;
> > -    if (NO_ERROR =3D=3D GetIfEntry(&a_mid_ifrow)) {
> > -        stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
> > -        stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
> > -        stats->rx_errs =3D a_mid_ifrow.dwInErrors;
> > -        stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
> > -        stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
> > -        stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
> > -        stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
> > -        stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
> > -        return 0;
> > +    OSver.dwOSVersionInfoSize =3D sizeof(OSVERSIONINFO);
> > +    GetVersionEx(&OSver);
> > +    if (OSver.dwMajorVersion >=3D 6) {
> > +        MIB_IF_ROW2 a_mid_ifrow;
> > +        memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
> > +        a_mid_ifrow.dwIndex =3D if_index;
> > +        if (NO_ERROR =3D=3D GetIfEntry2(&a_mid_ifrow)) {
> > +            stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
> > +            stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
> > +            stats->rx_errs =3D a_mid_ifrow.dwInErrors;
> > +            stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
> > +            stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
> > +            stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
> > +            stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
> > +            stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
> > +            return 0;
> =

> This fails to build in my fc20 mingw64 environment:
> =

> /home/mdroth/w/qemu4.git/qga/
> commands-win32.c:1184:20: error: 'MIB_IF_ROW2' has no member named 'dwInd=
ex'
>          a_mid_ifrow.dwIndex =3D if_index;
>                     ^
> /home/mdroth/w/qemu4.git/qga/
> commands-win32.c:1186:42: error: 'MIB_IF_ROW2' has no member named 'dwInO=
ctets'
>              stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
>                                           ^
> /home/mdroth/w/qemu4.git/qga/
> commands-win32.c:1187:44: error: 'MIB_IF_ROW2' has no member named 'dwInU=
castPkts'
>              stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
> =

> etc ...
> =

> The patch seems to assume MIB_IFROW and MIB_IF_ROW2 have the same field n=
ames
> for the stats, but according to this they're slightly different:
> =

>   https://msdn.microsoft.com/en-us/library/windows/desktop/aa814491(v=3D
> vs.85).aspx
> =

> This change on top of your patch seems to work:
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index e17fc3c284..58e470877f 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1181,16 +1181,16 @@ static int guest_get_network_stats(const char *na=
me,
>      if (os_ver.dwMajorVersion >=3D 6) {
>          MIB_IF_ROW2 a_mid_ifrow;
>          memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
> -        a_mid_ifrow.dwIndex =3D if_index;
> +        a_mid_ifrow.InterfaceIndex =3D if_index;
>          if (NO_ERROR =3D=3D GetIfEntry2(&a_mid_ifrow)) {
> -            stats->rx_bytes =3D a_mid_ifrow.dwInOctets;
> -            stats->rx_packets =3D a_mid_ifrow.dwInUcastPkts;
> -            stats->rx_errs =3D a_mid_ifrow.dwInErrors;
> -            stats->rx_dropped =3D a_mid_ifrow.dwInDiscards;
> -            stats->tx_bytes =3D a_mid_ifrow.dwOutOctets;
> -            stats->tx_packets =3D a_mid_ifrow.dwOutUcastPkts;
> -            stats->tx_errs =3D a_mid_ifrow.dwOutErrors;
> -            stats->tx_dropped =3D a_mid_ifrow.dwOutDiscards;
> +            stats->rx_bytes =3D a_mid_ifrow.InOctets;
> +            stats->rx_packets =3D a_mid_ifrow.InUcastPkts;
> +            stats->rx_errs =3D a_mid_ifrow.InErrors;
> +            stats->rx_dropped =3D a_mid_ifrow.InDiscards;
> +            stats->tx_bytes =3D a_mid_ifrow.OutOctets;
> +            stats->tx_packets =3D a_mid_ifrow.OutUcastPkts;
> +            stats->tx_errs =3D a_mid_ifrow.OutErrors;
> +            stats->tx_dropped =3D a_mid_ifrow.OutDiscards;
>              return 0;
>          }
>      }
> =

> I have the modified patch staged here:
> =

>   https://github.com/mdroth/qemu/commit/
> de597a8b27722ce4f9cc660f930f7dccc712712d
> =

> Let me know if it looks okay and I'll send a pull request for rc1
> =

> > +        }
> >      }
> >      return -1;
> >  }
> > -- =

> > 1.8.3.1
> > =

> =

>=20
