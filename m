Received: from eggs.gnu.org ([2001:4830:134:3::10]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu1l7-0005ep-QQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu1l6-0000zV-V4
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:58:53 -0400
Date: Fri, 31 Mar 2017 14:58:47 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170331185847.GG1135@localhost.localdomain>
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331120431.1767-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9 2/2] block/curl: Check
 protocol prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 31, 2017 at 02:04:31PM +0200, Max Reitz wrote:
> If the user has explicitly specified a block driver and thus a protocol,
> we have to make sure the URL's protocol prefix matches. Otherwise the
> latter will silently override the former which might catch some users by
> surprise.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/curl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 34dbd335f4..2708d57c2f 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -659,6 +659,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>      const char *cookie;
>      double d;
>      const char *secretid;
> +    const char *protocol_delimiter;
>  
>      static int inited = 0;
>  
> @@ -700,6 +701,15 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
>          goto out_noclean;
>      }
>  
> +    if (!strstart(file, bs->drv->protocol_name, &protocol_delimiter) ||
> +        !strstart(protocol_delimiter, "://", NULL))
> +    {
> +        error_setg(errp, "%s curl driver cannot handle the URL '%s' (does not "
> +                   "start with '%s://')", bs->drv->protocol_name, file,
> +                   bs->drv->protocol_name);
> +        goto out_noclean;
> +    }
> +
>      s->username = g_strdup(qemu_opt_get(opts, CURL_BLOCK_OPT_USERNAME));
>      secretid = qemu_opt_get(opts, CURL_BLOCK_OPT_PASSWORD_SECRET);
>  
> -- 
> 2.12.1
> 
> 
