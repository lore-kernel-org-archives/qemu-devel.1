Received: from eggs.gnu.org ([2001:4830:134:3::10]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSbS-0000Lc-LM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSbR-0002WZ-Pe
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:24:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622201122.9358-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63db09f9-1f4a-15d3-cd5b-f1f5006e3eac@amsat.org>
Date: Fri, 22 Jun 2018 17:24:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180622201122.9358-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: Appease coverity,
 skip empty block trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 06/22/2018 05:11 PM, John Snow wrote:
> If a tree consists exclusively of implicit filter nodes, we might crash
> QEMU. This configuration should not exist in practice, but if it did,
> skipping it would be fine.
> 
> For the purposes of debug builds, throw an assert to remind us that
> this configuration is truly unexpected, but if it's compiled out we
> will cope just fine.

Well... with your explanation, your patch is correct.
But do we really want to maintain a 'debug with assert' vs 'production
without assertions' codebase?

$ git grep g_assert_not_reached | egrep -v '^tests/' | wc -l
406

Does Coverity require all these 406 lines to behave with a
"configuration [that] should not exist in practice"?

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  migration/block-dirty-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 3bafbbdc4c..02725293dd 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -287,6 +287,10 @@ static int init_dirty_bitmap_migration(void)
>          while (bs && bs->drv && bs->implicit) {
>              bs = backing_bs(bs);
>          }
> +        if (!bs) {
> +            g_assert_not_reached();
> +            continue;

Can we choose one or the other?

> +        }
>  
>          for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>               bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
> 
