Received: from eggs.gnu.org ([209.51.188.92]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDUAJ-0005uh-Tp
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDUAI-0005t9-QK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDUAI-0005rl-G4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24D13C066447
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 13:18:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-12-armbru@redhat.com>
Date: Mon, 08 Apr 2019 15:18:14 +0200
In-Reply-To: <20190408083627.7479-12-armbru@redhat.com> (Markus Armbruster's
	message of "Mon, 8 Apr 2019 10:36:23 +0200")
Message-ID: <87pnpwpre1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/15] monitor error: Make printf()-like
 functions return a value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> printf() & friends return the number of characters written on success,
> negative value on error.
>
> monitor_printf(), monitor_vfprintf(), monitor_vprintf(),
> error_printf(), error_printf_unless_qmp(), error_vprintf(), and
> error_vprintf_unless_qmp() return void.  Some of them carry a TODO
> comment asking for int instead.
>
> Improve them to return int like printf() does.
>
> This makes our use of monitor_printf() as fprintf_function slightly
> less dirty: the function cast no longer adds a return value that isn't
> there.  It still changes a parameter's pointer type.  That will be
> addressed in a future commit.
>
> monitor_vfprintf() always returns zero.  Improve it to return the
> proper value.
>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/stubs/error-printf.c b/stubs/error-printf.c
> index 99c6406668..537298209d 100644
> --- a/stubs/error-printf.c
> +++ b/stubs/error-printf.c
> @@ -2,19 +2,19 @@
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  
> -void error_vprintf(const char *fmt, va_list ap)
> +int error_vprintf(const char *fmt, va_list ap)
>  {
>      if (g_test_initialized() && !g_test_subprocess() &&
>          getenv("QTEST_SILENT_ERRORS")) {
>          char *msg = g_strdup_vprintf(fmt, ap);
>          g_test_message("%s", msg);
>          g_free(msg);
> -    } else {
> -        vfprintf(stderr, fmt, ap);
> +        return strlen(msg);

Use after free.  Obvious fixup appended.

>      }
> +    return vfprintf(stderr, fmt, ap);
>  }
>  
> -void error_vprintf_unless_qmp(const char *fmt, va_list ap)
> +int error_vprintf_unless_qmp(const char *fmt, va_list ap)
>  {
> -    error_vprintf(fmt, ap);
> +    return error_vprintf(fmt, ap);
>  }
[...]

diff --git a/stubs/error-printf.c b/stubs/error-printf.c
index 537298209d..1f9d3b3714 100644
--- a/stubs/error-printf.c
+++ b/stubs/error-printf.c
@@ -4,12 +4,15 @@
 
 int error_vprintf(const char *fmt, va_list ap)
 {
+    int ret;
+
     if (g_test_initialized() && !g_test_subprocess() &&
         getenv("QTEST_SILENT_ERRORS")) {
         char *msg = g_strdup_vprintf(fmt, ap);
         g_test_message("%s", msg);
+        ret = strlen(msg);
         g_free(msg);
-        return strlen(msg);
+        return ret;
     }
     return vfprintf(stderr, fmt, ap);
 }
