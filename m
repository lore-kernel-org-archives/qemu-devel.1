Received: from eggs.gnu.org ([2001:4830:134:3::10]:39984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb2tY-0007nX-HJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb2tX-0007gt-FQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:21:08 -0500
Date: Tue, 7 Feb 2017 18:21:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170207102101.GG19280@lemon.lan>
References: <cover.1485365834.git.jcody@redhat.com>
	<71fd2883819899ef964826c72c9e0cc41246e8c1.1485365834.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71fd2883819899ef964826c72c9e0cc41246e8c1.1485365834.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] iscsi: Add timeout option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

On Wed, 01/25 12:42, Jeff Cody wrote:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This was previously only available with -iscsi. Again, after this patch,
> the -iscsi option only takes effect if an URL is given. New users are
> supposed to use the new driver-specific option.
> 
> All -iscsi options have a corresponding driver-specific option for the
> iscsi block driver now.
> 
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/iscsi.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index a989b52..4701a27 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1318,29 +1318,6 @@ static char *get_initiator_name(QemuOpts *opts)
>      return iscsi_name;
>  }
>  
> -static int parse_timeout(const char *target)
> -{
> -    QemuOptsList *list;
> -    QemuOpts *opts;
> -    const char *timeout;
> -
> -    list = qemu_find_opts("iscsi");
> -    if (list) {
> -        opts = qemu_opts_find(list, target);
> -        if (!opts) {
> -            opts = QTAILQ_FIRST(&list->head);
> -        }
> -        if (opts) {
> -            timeout = qemu_opt_get(opts, "timeout");
> -            if (timeout) {
> -                return atoi(timeout);
> -            }
> -        }
> -    }
> -
> -    return 0;
> -}
> -
>  static void iscsi_nop_timed_event(void *opaque)
>  {
>      IscsiLun *iscsilun = opaque;
> @@ -1549,7 +1526,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
>      QemuOptsList *list;
>      QemuOpts *opts;
>      const char *user, *password, *password_secret, *initiator_name,
> -               *header_digest;
> +               *header_digest, *timeout;
>  
>      list = qemu_find_opts("iscsi");
>      if (!list) {
> @@ -1588,6 +1565,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
>      if (header_digest) {
>          qdict_set_default_str(options, "header-digest", header_digest);
>      }
> +
> +    timeout = qemu_opt_get(opts, "timeout");
> +    if (timeout) {
> +        qdict_set_default_str(options, "timeout", timeout);
> +    }
>  }
>  
>  /*
> @@ -1639,7 +1621,6 @@ static void iscsi_parse_filename(const char *filename, QDict *options,
>      iscsi_destroy_url(iscsi_url);
>  }
>  
> -/* TODO Add -iscsi options */
>  static QemuOptsList runtime_opts = {
>      .name = "iscsi",
>      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> @@ -1680,6 +1661,10 @@ static QemuOptsList runtime_opts = {
>              .name = "header-digest",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "timeout",
> +            .type = QEMU_OPT_NUMBER,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1780,7 +1765,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      /* timeout handling is broken in libiscsi before 1.15.0 */
> -    timeout = parse_timeout(target);
> +    timeout = qemu_opt_get_number(opts, "timeout", 0);
>  #if LIBISCSI_API_VERSION >= 20150621
>      iscsi_set_timeout(iscsi, timeout);
>  #else
> -- 
> 2.9.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
