Received: from eggs.gnu.org ([2001:4830:134:3::10]:39314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb2r4-0006MD-NK
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb2r3-0004ue-O8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:18:34 -0500
Date: Tue, 7 Feb 2017 18:18:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170207101823.GF19280@lemon.lan>
References: <cover.1485365834.git.jcody@redhat.com>
	<ef9a3b39f69b5fb09be970edd1b03659d90d3207.1485365834.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9a3b39f69b5fb09be970edd1b03659d90d3207.1485365834.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] iscsi: Add header-digest option
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
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/iscsi.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 3401b7e..a989b52 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1274,32 +1274,15 @@ static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
>      g_free(secret);
>  }
>  
> -static void parse_header_digest(struct iscsi_context *iscsi, const char *target,
> +static void apply_header_digest(struct iscsi_context *iscsi, QemuOpts *opts,
>                                  Error **errp)
>  {
> -    QemuOptsList *list;
> -    QemuOpts *opts;
>      const char *digest = NULL;
>  
> -    list = qemu_find_opts("iscsi");
> -    if (!list) {
> -        return;
> -    }
> -
> -    opts = qemu_opts_find(list, target);
> -    if (opts == NULL) {
> -        opts = QTAILQ_FIRST(&list->head);
> -        if (!opts) {
> -            return;
> -        }
> -    }
> -
>      digest = qemu_opt_get(opts, "header-digest");
>      if (!digest) {
> -        return;
> -    }
> -
> -    if (!strcmp(digest, "CRC32C")) {
> +        iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
> +    } else if (!strcmp(digest, "CRC32C")) {
>          iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_CRC32C);
>      } else if (!strcmp(digest, "NONE")) {
>          iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE);
> @@ -1565,7 +1548,8 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
>  {
>      QemuOptsList *list;
>      QemuOpts *opts;
> -    const char *user, *password, *password_secret, *initiator_name;
> +    const char *user, *password, *password_secret, *initiator_name,
> +               *header_digest;
>  
>      list = qemu_find_opts("iscsi");
>      if (!list) {
> @@ -1599,6 +1583,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
>      if (initiator_name) {
>          qdict_set_default_str(options, "initiator-name", initiator_name);
>      }
> +
> +    header_digest = qemu_opt_get(opts, "header-digest");
> +    if (header_digest) {
> +        qdict_set_default_str(options, "header-digest", header_digest);
> +    }
>  }
>  
>  /*
> @@ -1687,6 +1676,10 @@ static QemuOptsList runtime_opts = {
>              .name = "initiator-name",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "header-digest",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1778,10 +1771,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
>          goto out;
>      }
>  
> -    iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
> -
>      /* check if we got HEADER_DIGEST via the options */
> -    parse_header_digest(iscsi, target, &local_err);
> +    apply_header_digest(iscsi, opts, &local_err);
>      if (local_err != NULL) {
>          error_propagate(errp, local_err);
>          ret = -EINVAL;
> -- 
> 2.9.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
