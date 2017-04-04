Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvYFp-0007C9-LA
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvYFk-0003GD-K8
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:52:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39800
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cvYFk-0003G7-Dz
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:52:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34Nmx4m103479
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 19:52:47 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29m24bg4qh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 19:52:47 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 19:52:46 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170321135911.22731-1-sameeh@daynix.com>
References: <20170321135911.22731-1-sameeh@daynix.com>
Date: Tue, 04 Apr 2017 18:52:37 -0500
Message-Id: <149134995767.1924.16211993997695941517@loki>
Subject: Re: [Qemu-devel] [PATCH qemu-ga] Fix a bug where qemu-ga service is
 stuck during stop operation
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

Quoting Sameeh Jubran (2017-03-21 08:59:11)
> After triggering a freeze command without any following thaw command,
> qemu-ga will not respond to stop operation. This behaviour is wanted on L=
inux
> as there is no time limit for a freeze command and we want to prevent
> quitting in the middle of freeze, on the other hand on Windows the time
> limit for freeze is 10 seconds, so we should wait for the timeout, thaw
> the file system and quit.
> =

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/main.c                 | 20 ++++++++++++++++++++
>  qga/vss-win32.h            |  1 +
>  qga/vss-win32/vss-common.h |  5 +++++
>  3 files changed, 26 insertions(+)
> =

> diff --git a/qga/main.c b/qga/main.c
> index 92658bc..de37c85 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -130,9 +130,29 @@ static void quit_handler(int sig)
>       * unless all log/pid files are on unfreezable filesystems. there's
>       * also a very likely chance killing the agent before unfreezing
>       * the filesystems is a mistake (or will be viewed as one later).
> +     * On Windows the freeze interval is limited to 10 seconds, so
> +     * we should quit, but first we should wait for the timeout, thaw
> +     * the filesystem and quit.
>       */
>      if (ga_is_frozen(ga_state)) {
> +#ifdef _WIN32
> +        int i =3D 0;
> +        Error *err =3D NULL;
> +        HANDLE hEventTimeout;

Maybe add the following to help explain the added delay:

           g_debug("Thawing filesystems before exiting");

> +
> +        hEventTimeout =3D OpenEvent(EVENT_ALL_ACCESS, FALSE, EVENT_NAME_=
TIMEOUT);
> +        if (hEventTimeout) {
> +            WaitForSingleObject(hEventTimeout, 0);
> +            CloseHandle(hEventTimeout);
> +        }
> +        qga_vss_fsfreeze(&i, &err, false);
> +        if (err) {
> +            g_debug("Error: %s", error_get_pretty(err));

Perhaps: "Error unfreezing filesystems prior to exiting: %s"

> +            error_free(err);
> +        }
> +#else
>          return;
> +#endif
>      }
>      g_debug("received signal num %d, quitting", sig);
> =

> diff --git a/qga/vss-win32.h b/qga/vss-win32.h
> index 4d1d150..5f4ea70 100644
> --- a/qga/vss-win32.h
> +++ b/qga/vss-win32.h
> @@ -13,6 +13,7 @@
>  #ifndef VSS_WIN32_H
>  #define VSS_WIN32_H
> =

> +#include "qga/vss-win32/vss-common.h"
> =

>  bool vss_init(bool init_requester);
>  void vss_deinit(bool deinit_requester);
> diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
> index c81a856..5756d00 100644
> --- a/qga/vss-win32/vss-common.h
> +++ b/qga/vss-win32/vss-common.h
> @@ -12,6 +12,7 @@
> =

>  #ifndef VSS_COMMON_H
>  #define VSS_COMMON_H
> +#ifndef VSS_WIN32_H
> =

>  #define __MIDL_user_allocate_free_DEFINED__
>  #include <windows.h>
> @@ -57,6 +58,7 @@
>  #define L(a) _L(a)
> =

>  /* Constants for QGA VSS Provider */
> +#endif
> =

>  #define QGA_PROVIDER_NAME "QEMU Guest Agent VSS Provider"
>  #define QGA_PROVIDER_LNAME L(QGA_PROVIDER_NAME)
> @@ -66,6 +68,8 @@
>  #define EVENT_NAME_THAW    "Global\\QGAVSSEvent-thaw"
>  #define EVENT_NAME_TIMEOUT "Global\\QGAVSSEvent-timeout"

This is a bit of tangle. I'd rather you just move these out
into a separate header, vss-handles.h or something, and then
include that in main.c and vss-common.h.

> =

> +#ifndef VSS_WIN32_H
> +
>  const GUID g_gProviderId =3D { 0x3629d4ed, 0xee09, 0x4e0e,
>      {0x9a, 0x5c, 0x6d, 0x8b, 0xa2, 0x87, 0x2a, 0xef} };
>  const GUID g_gProviderVersion =3D { 0x11ef8b15, 0xcac6, 0x40d6,
> @@ -126,3 +130,4 @@ public:
>  };
> =

>  #endif
> +#endif
> -- =

> 2.9.3
>=20
