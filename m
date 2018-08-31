Received: from eggs.gnu.org ([2001:4830:134:3::10]:57006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvcV8-0006FS-UV
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvcV5-0005QG-Kn
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:01:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180830145902.27376-1-cohuck@redhat.com>
	<20180830145902.27376-3-cohuck@redhat.com>
Date: Fri, 31 Aug 2018 08:01:39 +0200
In-Reply-To: <20180830145902.27376-3-cohuck@redhat.com> (Cornelia Huck's
	message of "Thu, 30 Aug 2018 16:59:02 +0200")
Message-ID: <87tvnbvzuk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qemu-error: make use of {error,
 warn}_report_once_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

Cornelia Huck <cohuck@redhat.com> writes:

> {error,warn}_report_once() are a special case of the new functions
> and can simply switch to them.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/qemu/error-report.h | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e415128ac4..918cb936d8 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -53,32 +53,26 @@ bool warn_report_once_cond(bool *printed, const char *fmt, ...)
>   * Similar to error_report(), except it prints the message just once.
>   * Return true when it prints, false otherwise.
>   */
> -#define error_report_once(fmt, ...)             \
> -    ({                                          \
> -        static bool print_once_;                \
> -        bool ret_print_once_ = !print_once_;    \
> -                                                \
> -        if (!print_once_) {                     \
> -            print_once_ = true;                 \
> -            error_report(fmt, ##__VA_ARGS__);   \
> -        }                                       \
> -        unlikely(ret_print_once_);              \
> +#define error_report_once(fmt, ...)                     \
> +    ({                                                  \
> +        static bool print_once_;                        \
> +        bool ret_print_once_ =                          \
> +            error_report_once_cond(&print_once_,        \
> +                                   fmt, ##__VA_ARGS__); \
> +        unlikely(ret_print_once_);                      \
>      })

Do we still need @ret_print_once_?

   #define error_report_once(fmt, ...)                     \
       ({                                                  \
           static bool print_once_;                        \
           unlikely(error_report_once_cond(&print_once_,   \
                                   fmt, ##__VA_ARGS__));   \
       })

Or dispense with the unlikely:

   #define error_report_once(fmt, ...)                     \
       ({                                                  \
           static bool print_once_;                        \
           error_report_once_cond(&print_once_,            \
                                  fmt, ##__VA_ARGS__);     \
       })

Got a preference?

>  
>  /*
>   * Similar to warn_report(), except it prints the message just once.
>   * Return true when it prints, false otherwise.
>   */
> -#define warn_report_once(fmt, ...)              \
> -    ({                                          \
> -        static bool print_once_;                \
> -        bool ret_print_once_ = !print_once_;    \
> -                                                \
> -        if (!print_once_) {                     \
> -            print_once_ = true;                 \
> -            warn_report(fmt, ##__VA_ARGS__);    \
> -        }                                       \
> -        unlikely(ret_print_once_);              \
> +#define warn_report_once(fmt, ...)                      \
> +    ({                                                  \
> +        static bool print_once_;                        \
> +        bool ret_print_once_ =                          \
> +            warn_report_once_cond(&print_once_,         \
> +                                  fmt, ##__VA_ARGS__);  \
> +        unlikely(ret_print_once_);                      \
>      })
>  
>  const char *error_get_progname(void);
