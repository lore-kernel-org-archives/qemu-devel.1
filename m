Received: from eggs.gnu.org ([2001:4830:134:3::10]:47696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUYuW-0002MW-AN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUYuT-0007fR-3S
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dUYuS-0007eC-R2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:39:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499453787.git.alistair.francis@xilinx.com>
	<2ee8ce037e6db81c575a2d3ff1793754a243b5e2.1499453788.git.alistair.francis@xilinx.com>
Date: Mon, 10 Jul 2017 15:39:29 +0200
In-Reply-To: <2ee8ce037e6db81c575a2d3ff1793754a243b5e2.1499453788.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Fri, 7 Jul 2017 16:21:21 -0700")
Message-ID: <87pod81kdq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/8] error: Implement the warn and free
 Error functions
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

> Implement warn_report_err() and warn_reportf_err() functions which
> are the same as the error_report_err() and error_reportf_err()
> functions except report a warning instead of an error.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  include/qapi/error.h  | 11 +++++++++++
>  scripts/checkpatch.pl |  1 +
>  util/error.c          | 19 +++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 7e532d00e9..af53b34410 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -267,11 +267,22 @@ void error_free(Error *err);
>  void error_free_or_abort(Error **errp);
>  
>  /*
> + * Convenience function to warn_report() and free @err.
> + */
> +void warn_report_err(Error *err);
> +
> +/*
>   * Convenience function to error_report() and free @err.
>   */
>  void error_report_err(Error *err);
>  
>  /*
> + * Convenience function to error_prepend(), warn_report() and free @err.
> + */
> +void warn_reportf_err(Error *err, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
> +
> +/*
>   * Convenience function to error_prepend(), error_report() and free @err.
>   */
>  void error_reportf_err(Error *err, const char *fmt, ...)
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b76fe30ad3..8f5cbaa12e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2533,6 +2533,7 @@ sub process {
>  				error_setg_file_open|
>  				error_set|
>  				error_prepend|
> +				warn_reportf_err|
>  				error_reportf_err|
>  				error_report|
>  				warn_report|
> diff --git a/util/error.c b/util/error.c
> index 020b86b9f0..373566fb77 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -223,6 +223,15 @@ const char *error_get_pretty(const Error *err)
>      return err->msg;
>  }
>  
> +void warn_report_err(Error *err)
> +{
> +    warn_report("%s", error_get_pretty(err));
> +    if (err->hint) {
> +        error_printf_unless_qmp("%s", err->hint->str);
> +    }
> +    error_free(err);
> +}
> +
>  void error_report_err(Error *err)
>  {
>      error_report("%s", error_get_pretty(err));
> @@ -232,6 +241,16 @@ void error_report_err(Error *err)
>      error_free(err);
>  }
>  
> +void warn_reportf_err(Error *err, const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    error_vprepend(&err, fmt, ap);
> +    va_end(ap);
> +    warn_report_err(err);
> +}
> +
>  void error_reportf_err(Error *err, const char *fmt, ...)
>  {
>      va_list ap;

Everywhere else, you put error before warning before info.  Let's do it
here, too.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
