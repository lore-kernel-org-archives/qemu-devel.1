Received: from eggs.gnu.org ([2001:4830:134:3::10]:51528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dXk2j-0000XM-Dz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dXk2i-0002d2-Cq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:09:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dXk2i-0002cy-6I
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:09:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id y67so6962131wrb.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:09:12 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1500449614-16811-1-git-send-email-armbru@redhat.com>
References: <1500449614-16811-1-git-send-email-armbru@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 19 Jul 2017 10:08:40 +0200
Message-ID: <CAKmqyKOe794WqeH9bO7g=wsQN05jq3gpFhoHLEZUFttdDo_bPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] error: Revert unwanted change of warning
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jul 19, 2017 at 9:33 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Commit 97f4030 changed warning messages from
>
>     timestamp-if-enabled progname ":" location "warning: " message
>
> to
>
>     "warning: " timestamp-if-enabled progname ":" location message
>
> This regressed qemu-iotests 051.  Put "warning: " right back where it
> was, along with "info: ".
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks for this, I'm still traveling and couldn't have done this until
next week.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair



> ---
>  util/qemu-error.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index c557c6a..a25d3b9 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -201,17 +201,6 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>      GTimeVal tv;
>      gchar *timestr;
>
> -    switch (type) {
> -    case REPORT_TYPE_ERROR:
> -        break;
> -    case REPORT_TYPE_WARNING:
> -        error_printf("warning: ");
> -        break;
> -    case REPORT_TYPE_INFO:
> -        error_printf("info: ");
> -        break;
> -    }
> -
>      if (enable_timestamp_msg && !cur_mon) {
>          g_get_current_time(&tv);
>          timestr = g_time_val_to_iso8601(&tv);
> @@ -220,6 +209,18 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>      }
>
>      print_loc();
> +
> +    switch (type) {
> +    case REPORT_TYPE_ERROR:
> +        break;
> +    case REPORT_TYPE_WARNING:
> +        error_printf("warning: ");
> +        break;
> +    case REPORT_TYPE_INFO:
> +        error_printf("info: ");
> +        break;
> +    }
> +
>      error_vprintf(fmt, ap);
>      error_printf("\n");
>  }
> --
> 2.7.5
>
>
