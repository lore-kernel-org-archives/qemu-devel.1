Received: from eggs.gnu.org ([2001:4830:134:3::10]:38053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT055-0000uv-AI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT050-0006Fy-NB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT050-0006ER-DY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:15:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499276048.git.alistair.francis@xilinx.com>
	<2c9645b5dce991f7a324dc2b61e2553e08230a9f.1499276048.git.alistair.francis@xilinx.com>
Date: Thu, 06 Jul 2017 08:15:54 +0200
In-Reply-To: <2c9645b5dce991f7a324dc2b61e2553e08230a9f.1499276048.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Wed, 5 Jul 2017 10:36:28 -0700")
Message-ID: <87r2xuay5h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v3 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net

Alistair Francis <alistair.francis@xilinx.com> writes:

> This patch converts the existing error_vreport() function into a generic
> qmesg_vreport() function that takes an enum describing the
> information to be reported.
>
> As part of this change a new qmesg_report() function is added as well with the
> same capability.
>
> To maintain full compatibility the original error_report() function is
> maintained and no changes to the way errors are printed have been made.
> To improve access to the new informaiton and warning options wrapper functions
> similar to error_report() have been added for warnings and information
> printing.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

In addition to the typos Thomas pointed out, please wrap your lines at
column 70 or so.

> ---
> RFC V3:
>  - Change the function and enum names to be more descriptive
>  - Add wrapper functions for *_report() and *_vreport()
>
>  include/qemu/error-report.h | 16 +++++++++
>  scripts/checkpatch.pl       |  8 ++++-
>  util/qemu-error.c           | 80 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 100 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index 3001865896..62fc167ace 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -21,6 +21,12 @@ typedef struct Location {
>      struct Location *prev;
>  } Location;
>  
> +typedef enum {
> +    REPORT_TYPE_ERROR,
> +    REPORT_TYPE_WARNING,
> +    REPORT_TYPE_INFO,
> +} report_type;
> +
>  Location *loc_push_restore(Location *loc);
>  Location *loc_push_none(Location *loc);
>  Location *loc_pop(Location *loc);
> @@ -30,13 +36,23 @@ void loc_set_none(void);
>  void loc_set_cmdline(char **argv, int idx, int cnt);
>  void loc_set_file(const char *fname, int lno);
>  
> +void qmsg_vreport(report_type type, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
> +void qmsg_report(report_type type, const char *fmt, ...)  GCC_FMT_ATTR(2, 3);
> +

Let's keep these hidden in qemu-error.c until we have users outside of
qemu-error.c.  @report_type, too.  No need for qmsg_report() then.  Not
sure we need the qmsg_ prefix; I find it ugly.  I'd prefer vreport(),
msg_vreport() or maybe do_vreport().

Suggest to update the commit message to put less emphasis on the
(static) generic functions, and more on the functions we're actually
going to use, starting with your PATCH 3, perhaps like this:

    error: Functions to report warnings and informational messages

    Add warn_report(), warn_vreport() for reporting warnings, and
    info_report(), info_vreport() for informational messages.

    Implement them with a helper function factored out of
    error_vreport(), suitably generalized.  Take care not to change the
    way error messages are printed.


>  void error_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
>  void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
>  void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void error_set_progname(const char *argv0);
> +
>  void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
> +void warn_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
> +void info_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
> +
>  void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> +void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> +void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
> +
>  const char *error_get_progname(void);
>  extern bool enable_timestamp_msg;
>  
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 45027b9281..8b02621739 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2530,8 +2530,14 @@ sub process {
>  				error_set|
>  				error_prepend|
>  				error_reportf_err|
> +				qmsg_vreport|
>  				error_vreport|
> -				error_report}x;
> +				warn_vreport|
> +				info_vreport|
> +				qmsg_report|
> +				error_report|
> +				warn_report|
> +				info_report}x;
>  
>  	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>  		ERROR("Error messages should not contain newlines\n" . $herecurr);

Extra points for updating checkpatch.pl :)

> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index 1c5e35ecdb..63fdc0e174 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -179,17 +179,29 @@ static void print_loc(void)
>  
>  bool enable_timestamp_msg;
>  /*
> - * Print an error message to current monitor if we have one, else to stderr.
> + * Print a message to current monitor if we have one, else to stderr.
>   * Format arguments like vsprintf().  The resulting message should be
>   * a single phrase, with no newline or trailing punctuation.
>   * Prepend the current location and append a newline.
>   * It's wrong to call this in a QMP monitor.  Use error_setg() there.
>   */
> -void error_vreport(const char *fmt, va_list ap)
> +void qmsg_vreport(report_type type, const char *fmt, va_list ap)
>  {
>      GTimeVal tv;
>      gchar *timestr;
>  
> +    switch (type) {
> +    case REPORT_TYPE_ERROR:
> +        /* To maintain compatibility we don't add anything here */

I feel the comment isn't going to be useful in the future.  Let's drop
it.

> +        break;
> +    case REPORT_TYPE_WARNING:
> +        error_printf("warning: ");
> +        break;
> +    case REPORT_TYPE_INFO:
> +        error_printf("info: ");
> +        break;

       default:
           assert(0);

> +    }
> +
>      if (enable_timestamp_msg && !cur_mon) {
>          g_get_current_time(&tv);
>          timestr = g_time_val_to_iso8601(&tv);
> @@ -204,16 +216,78 @@ void error_vreport(const char *fmt, va_list ap)
>  
>  /*
>   * Print an error message to current monitor if we have one, else to stderr.
> + */
> +void error_vreport(const char *fmt, va_list ap)
> +{
> +    qmsg_vreport(REPORT_TYPE_ERROR, fmt, ap);
> +}
> +
> +/*
> + * Print a warning message to current monitor if we have one, else to stderr.
> + */
> +void warn_vreport(const char *fmt, va_list ap)
> +{
> +    qmsg_vreport(REPORT_TYPE_WARNING, fmt, ap);
> +}
> +
> +/*
> + * Print an information message to current monitor if we have one, else to
> + * stderr.
> + */
> +void info_vreport(const char *fmt, va_list ap)
> +{
> +    qmsg_vreport(REPORT_TYPE_INFO, fmt, ap);
> +}
> +
> +/*
> + * Print a message to current monitor if we have one, else to stderr.
>   * Format arguments like sprintf().  The resulting message should be a
>   * single phrase, with no newline or trailing punctuation.
>   * Prepend the current location and append a newline.
>   * It's wrong to call this in a QMP monitor.  Use error_setg() there.
>   */
> +void qmsg_report(report_type type, const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    qmsg_vreport(type, fmt, ap);
> +    va_end(ap);
> +}
> +
> +/*
> + * Print an error message to current monitor if we have one, else to stderr.
> + */
>  void error_report(const char *fmt, ...)
>  {
>      va_list ap;
>  
>      va_start(ap, fmt);
> -    error_vreport(fmt, ap);
> +    qmsg_vreport(REPORT_TYPE_ERROR, fmt, ap);
> +    va_end(ap);
> +}
> +
> +/*
> + * Print a warning message to current monitor if we have one, else to stderr.
> + */
> +void warn_report(const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    qmsg_vreport(REPORT_TYPE_WARNING, fmt, ap);
> +    va_end(ap);
> +}
> +
> +/*
> + * Print an information message to current monitor if we have one, else to
> + * stderr.
> + */
> +void info_report(const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    qmsg_vreport(REPORT_TYPE_INFO, fmt, ap);
>      va_end(ap);
>  }
