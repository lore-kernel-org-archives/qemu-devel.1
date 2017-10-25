Received: from eggs.gnu.org ([2001:4830:134:3::10]:53894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7UaB-0000DU-3M
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7Ua6-0005Lb-6e
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:55:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35174
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7Ua6-0005Kv-0Z
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:55:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PMsINS135663
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:55:22 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2du0k1yu4a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:55:21 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 16:55:21 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170822135504.21612-1-bishara@daynix.com>
References: <20170822135504.21612-1-bishara@daynix.com>
Date: Wed, 25 Oct 2017 17:55:09 -0500
Message-Id: <150897210930.17721.1680868416724067795@sif>
Subject: Re: [Qemu-devel] [PATCH v2] qga-win: Updating guest_set_time action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bishara AbuHattoum <bishara@daynix.com>, qemu-devel@nongnu.org
Cc: Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>

Quoting Bishara AbuHattoum (2017-08-22 08:55:04)
>   At the moment, Windows libraries don't provide a way to access
>   RTC, so, a workaround is to use the Windows w32tm command to
>   resync the time.
>   Related bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1183874
> =

> Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  configure            |  2 +-
>  qga/commands-win32.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)
> =

> diff --git a/configure b/configure
> index dd73cce62f..2c044ba2ca 100755
> --- a/configure
> +++ b/configure
> @@ -824,7 +824,7 @@ if test "$mingw32" =3D "yes" ; then
>    sysconfdir=3D"\${prefix}"
>    local_statedir=3D
>    confsuffix=3D""
> -  libs_qga=3D"-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -liphlpapi -lnetapi=
32 $libs_qga"
> +  libs_qga=3D"-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpap=
i -lnetapi32 $libs_qga"
>  fi
> =

>  werror=3D""
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 619dbd2bc2..fbd7eb7bbb 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -29,6 +29,7 @@
>  #endif
>  #include <lm.h>
>  #include <wtsapi32.h>
> +#include <wininet.h>
> =

>  #include "qga/guest-agent-core.h"
>  #include "qga/vss-win32.h"
> @@ -1277,8 +1278,41 @@ void qmp_guest_set_time(bool has_time, int64_t tim=
e_ns, Error **errp)
>           * RTC yet:
>           *
>           * https://msdn.microsoft.com/en-us/library/aa908981.aspx
> +         *
> +         * Instead, a workaround is to use the Windows win32tm command to
> +         * resync the time using the Windows Time service.
>           */
> -        error_setg(errp, "Time argument is required on this platform");
> +        LPVOID msg_buffer;
> +        DWORD ret_flags;
> +
> +        HRESULT hr =3D system("w32tm /resync /nowait");
> +
> +        if (GetLastError() !=3D 0) {
> +            strerror_s((LPTSTR) & msg_buffer, 0, errno);
> +            error_setg(errp, "system(...) failed: %s", (LPCTSTR)msg_buff=
er);
> +        } else if (hr !=3D 0) {
> +            if (hr =3D=3D HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)) {
> +                error_setg(errp, "Windows Time service not running on th=
e "
> +                                 "guest");
> +            } else {
> +                if (!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
> +                                   FORMAT_MESSAGE_FROM_SYSTEM |
> +                                   FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
> +                                   (DWORD)hr, MAKELANGID(LANG_NEUTRAL,
> +                                   SUBLANG_DEFAULT), (LPTSTR) & msg_buff=
er, 0,
> +                                   NULL)) {
> +                    error_setg(errp, "w32tm failed with error (0x%lx), c=
ouldn'"
> +                                     "t retrieve error message", hr);
> +                } else {
> +                    error_setg(errp, "w32tm failed with error (0x%lx): %=
s", hr,
> +                               (LPCTSTR)msg_buffer);
> +                    LocalFree(msg_buffer);
> +                }
> +            }
> +        } else if (!InternetGetConnectedState(&ret_flags, 0)) {
> +            error_setg(errp, "No internet connection on guest, sync not "
> +                             "accurate");
> +        }
>          return;
>      }
> =

> -- =

> 2.13.5
>=20
