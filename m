Received: from eggs.gnu.org ([2001:4830:134:3::10]:33630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dk9fi-0002z3-7p
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dk9fb-00045V-UC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:56:46 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:36373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dk9fb-000448-Nv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:56:39 -0400
Received: by mail-io0-x236.google.com with SMTP id p141so20198918iop.3
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 06:56:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822135504.21612-1-bishara@daynix.com>
References: <20170822135504.21612-1-bishara@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 22 Aug 2017 16:56:38 +0300
Message-ID: <CAKPgXcEaR3sLdxAko45noC20wWy2XB-_q2aJ4Ju9C5CA8aSs7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] qga-win: Updating guest_set_time action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bishara AbuHattoum <bishara@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>

Reviewed-by: Sameeh Jubran <sameeh@daynix.com>

On Tue, Aug 22, 2017 at 4:55 PM, Bishara AbuHattoum <bishara@daynix.com>
wrote:

>   At the moment, Windows libraries don't provide a way to access
>   RTC, so, a workaround is to use the Windows w32tm command to
>   resync the time.
>   Related bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1183874
>
> Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
> ---
>  configure            |  2 +-
>  qga/commands-win32.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index dd73cce62f..2c044ba2ca 100755
> --- a/configure
> +++ b/configure
> @@ -824,7 +824,7 @@ if test "$mingw32" = "yes" ; then
>    sysconfdir="\${prefix}"
>    local_statedir=
>    confsuffix=""
> -  libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -liphlpapi -lnetapi32
> $libs_qga"
> +  libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi
> -lnetapi32 $libs_qga"
>  fi
>
>  werror=""
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 619dbd2bc2..fbd7eb7bbb 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -29,6 +29,7 @@
>  #endif
>  #include <lm.h>
>  #include <wtsapi32.h>
> +#include <wininet.h>
>
>  #include "qga/guest-agent-core.h"
>  #include "qga/vss-win32.h"
> @@ -1277,8 +1278,41 @@ void qmp_guest_set_time(bool has_time, int64_t
> time_ns, Error **errp)
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
> +        HRESULT hr = system("w32tm /resync /nowait");
> +
> +        if (GetLastError() != 0) {
> +            strerror_s((LPTSTR) & msg_buffer, 0, errno);
> +            error_setg(errp, "system(...) failed: %s",
> (LPCTSTR)msg_buffer);
> +        } else if (hr != 0) {
> +            if (hr == HRESULT_FROM_WIN32(ERROR_SERVICE_NOT_ACTIVE)) {
> +                error_setg(errp, "Windows Time service not running on the
> "
> +                                 "guest");
> +            } else {
> +                if (!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
> +                                   FORMAT_MESSAGE_FROM_SYSTEM |
> +                                   FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
> +                                   (DWORD)hr, MAKELANGID(LANG_NEUTRAL,
> +                                   SUBLANG_DEFAULT), (LPTSTR) &
> msg_buffer, 0,
> +                                   NULL)) {
> +                    error_setg(errp, "w32tm failed with error (0x%lx),
> couldn'"
> +                                     "t retrieve error message", hr);
> +                } else {
> +                    error_setg(errp, "w32tm failed with error (0x%lx):
> %s", hr,
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
>
> --
> 2.13.5
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
