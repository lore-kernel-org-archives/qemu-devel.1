Received: from eggs.gnu.org ([2001:4830:134:3::10]:38438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpu6v-0006mV-Ty
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpu6q-0002DU-Lw
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:37:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpu6n-0002CP-2F
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:37:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180815095328.32414-1-peterx@redhat.com>
	<20180815095328.32414-2-peterx@redhat.com>
Date: Wed, 15 Aug 2018 13:36:52 +0200
In-Reply-To: <20180815095328.32414-2-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 17:53:26 +0800")
Message-ID: <871sazn9nv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/3] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> There are many error_report()s that can be used in frequently called
> functions, especially on IO paths.  That can be unideal in that
> malicious guest can try to trigger the error tons of time which might
> use up the log space on the host (e.g., libvirt can capture the stderr
> of QEMU and put it persistently onto disk).  In VT-d emulation code, we
> have trace_vtd_error() tracer.  AFAIU all those places can be replaced
> by something like error_report() but trace points are mostly used to
> avoid the DDOS attack that mentioned above.  However using trace points
> mean that errors are not dumped if trace not enabled.
>
> It's not a big deal in most modern server managements since we have
> things like logrotate to maintain the logs and make sure the quota is
> expected.  However it'll still be nice that we just provide another way
> to restrict message generations.  In most cases, this kind of
> error_report()s will only provide valid information on the first message
> sent, and all the rest of similar messages will be mostly talking about
> the same thing.  This patch introduces *_report_once() helpers to allow
> a message to be dumped only once during one QEMU process's life cycle.
> It will make sure: (1) it's on by deffault, so we can even get something
> without turning the trace on and reproducing, and (2) it won't be
> affected by DDOS attack.
>
> To implement it, I stole the printk_once() macro from Linux.
>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/error-report.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e1c8ae1a52..c7ec54cb97 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -44,6 +44,38 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
> +/*
> + * Similar to error_report(), but it only prints the message once.  It
> + * returns true when it prints the first time, otherwise false.
> + */
> +#define error_report_once(fmt, ...)             \
> +    ({                                          \
> +        static bool print_once_;               \
> +        bool ret_print_once_ = !print_once_;  \
> +                                                \
> +        if (!print_once_) {                    \
> +            print_once_ = true;                \
> +            error_report(fmt, ##__VA_ARGS__);   \
> +        }                                       \
> +        unlikely(ret_print_once_);             \
> +    })
> +
> +/*
> + * Similar to warn_report(), but it only prints the message once.  It
> + * returns true when it prints the first time, otherwise false.
> + */
> +#define warn_report_once(fmt, ...)              \
> +    ({                                          \
> +        static bool print_once_;               \
> +        bool ret_print_once_ = !print_once_;  \
> +                                                \
> +        if (!print_once_) {                    \
> +            print_once_ = true;                \
> +            warn_report(fmt, ##__VA_ARGS__);   \
> +        }                                       \
> +        unlikely(ret_print_once_);             \
> +    })
> +
>  const char *error_get_progname(void);
>  extern bool enable_timestamp_msg;

With the touch-ups from my review of v4 squashed in (fixup patch
appended):
Reviewed-by: Markus Armbruster <armbru@redhat.com>


>From f57a2317c75bea5396a589b2d65933312850bb05 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Aug 2018 13:29:03 +0200
Subject: [PATCH] fixup! intel-iommu: start to use error_report_once

[Whitespace adjusted, comments improved]
---
 include/qemu/error-report.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index c7ec54cb97..72fab2b031 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -45,35 +45,35 @@ void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /*
- * Similar to error_report(), but it only prints the message once.  It
- * returns true when it prints the first time, otherwise false.
+ * Similar to error_report(), except it prints the message just once.
+ * Return true when it prints, false otherwise.
  */
 #define error_report_once(fmt, ...)             \
     ({                                          \
-        static bool print_once_;               \
-        bool ret_print_once_ = !print_once_;  \
+        static bool print_once_;                \
+        bool ret_print_once_ = !print_once_;    \
                                                 \
-        if (!print_once_) {                    \
-            print_once_ = true;                \
+        if (!print_once_) {                     \
+            print_once_ = true;                 \
             error_report(fmt, ##__VA_ARGS__);   \
         }                                       \
-        unlikely(ret_print_once_);             \
+        unlikely(ret_print_once_);              \
     })
 
 /*
- * Similar to warn_report(), but it only prints the message once.  It
- * returns true when it prints the first time, otherwise false.
+ * Similar to warn_report(), except it prints the message just once.
+ * Return true when it prints, false otherwise.
  */
 #define warn_report_once(fmt, ...)              \
     ({                                          \
-        static bool print_once_;               \
-        bool ret_print_once_ = !print_once_;  \
+        static bool print_once_;                \
+        bool ret_print_once_ = !print_once_;    \
                                                 \
-        if (!print_once_) {                    \
-            print_once_ = true;                \
-            warn_report(fmt, ##__VA_ARGS__);   \
+        if (!print_once_) {                     \
+            print_once_ = true;                 \
+            warn_report(fmt, ##__VA_ARGS__);    \
         }                                       \
-        unlikely(ret_print_once_);             \
+        unlikely(ret_print_once_);              \
     })
 
 const char *error_get_progname(void);
-- 
2.17.1
