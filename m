Received: from eggs.gnu.org ([2001:4830:134:3::10]:49489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cuZzw-0004LN-FU
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cuZzt-0000i1-87
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:32:28 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:36355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cuZzt-0000hv-3j
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:32:25 -0400
Received: by mail-ua0-x241.google.com with SMTP id j29so2176500uaa.3
	for <qemu-devel@nongnu.org>; Sun, 02 Apr 2017 00:32:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170321135911.22731-1-sameeh@daynix.com>
References: <20170321135911.22731-1-sameeh@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 2 Apr 2017 10:32:24 +0300
Message-ID: <CAKPgXcE6XOpgJ=PEYTydf8TbFXzOpPF4daeaq9pn+1Ds4ZbTXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Ping.

On Tue, Mar 21, 2017 at 4:59 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> After triggering a freeze command without any following thaw command,
> qemu-ga will not respond to stop operation. This behaviour is wanted on
> Linux
> as there is no time limit for a freeze command and we want to prevent
> quitting in the middle of freeze, on the other hand on Windows the time
> limit for freeze is 10 seconds, so we should wait for the timeout, thaw
> the file system and quit.
>
> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/main.c                 | 20 ++++++++++++++++++++
>  qga/vss-win32.h            |  1 +
>  qga/vss-win32/vss-common.h |  5 +++++
>  3 files changed, 26 insertions(+)
>
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
> +        int i = 0;
> +        Error *err = NULL;
> +        HANDLE hEventTimeout;
> +
> +        hEventTimeout = OpenEvent(EVENT_ALL_ACCESS, FALSE,
> EVENT_NAME_TIMEOUT);
> +        if (hEventTimeout) {
> +            WaitForSingleObject(hEventTimeout, 0);
> +            CloseHandle(hEventTimeout);
> +        }
> +        qga_vss_fsfreeze(&i, &err, false);
> +        if (err) {
> +            g_debug("Error: %s", error_get_pretty(err));
> +            error_free(err);
> +        }
> +#else
>          return;
> +#endif
>      }
>      g_debug("received signal num %d, quitting", sig);
>
> diff --git a/qga/vss-win32.h b/qga/vss-win32.h
> index 4d1d150..5f4ea70 100644
> --- a/qga/vss-win32.h
> +++ b/qga/vss-win32.h
> @@ -13,6 +13,7 @@
>  #ifndef VSS_WIN32_H
>  #define VSS_WIN32_H
>
> +#include "qga/vss-win32/vss-common.h"
>
>  bool vss_init(bool init_requester);
>  void vss_deinit(bool deinit_requester);
> diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
> index c81a856..5756d00 100644
> --- a/qga/vss-win32/vss-common.h
> +++ b/qga/vss-win32/vss-common.h
> @@ -12,6 +12,7 @@
>
>  #ifndef VSS_COMMON_H
>  #define VSS_COMMON_H
> +#ifndef VSS_WIN32_H
>
>  #define __MIDL_user_allocate_free_DEFINED__
>  #include <windows.h>
> @@ -57,6 +58,7 @@
>  #define L(a) _L(a)
>
>  /* Constants for QGA VSS Provider */
> +#endif
>
>  #define QGA_PROVIDER_NAME "QEMU Guest Agent VSS Provider"
>  #define QGA_PROVIDER_LNAME L(QGA_PROVIDER_NAME)
> @@ -66,6 +68,8 @@
>  #define EVENT_NAME_THAW    "Global\\QGAVSSEvent-thaw"
>  #define EVENT_NAME_TIMEOUT "Global\\QGAVSSEvent-timeout"
>
> +#ifndef VSS_WIN32_H
> +
>  const GUID g_gProviderId = { 0x3629d4ed, 0xee09, 0x4e0e,
>      {0x9a, 0x5c, 0x6d, 0x8b, 0xa2, 0x87, 0x2a, 0xef} };
>  const GUID g_gProviderVersion = { 0x11ef8b15, 0xcac6, 0x40d6,
> @@ -126,3 +130,4 @@ public:
>  };
>
>  #endif
> +#endif
> --
> 2.9.3
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
