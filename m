Received: from eggs.gnu.org ([2001:4830:134:3::10]:52449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwyR-00074E-KI
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwyO-0000gs-UX
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:52:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-3-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c5a595d-ff5b-f1f9-d64b-ed94bd9af410@amsat.org>
Date: Fri, 31 Mar 2017 10:52:12 -0300
MIME-Version: 1.0
In-Reply-To: <20170331120431.1767-3-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] block/curl: Check protocol
 prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 03/31/2017 09:04 AM, Max Reitz wrote:
> If the user has explicitly specified a block driver and thus a protocol,
> we have to make sure the URL's protocol prefix matches. Otherwise the
> latter will silently override the former which might catch some users by
> surprise.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
