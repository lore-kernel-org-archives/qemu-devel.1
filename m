Received: from eggs.gnu.org ([2001:4830:134:3::10]:60625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csgdh-0006E6-At
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csgde-0003eV-4p
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1csgdd-0003eB-V5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ACCF5A5D
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:13:37 +0000 (UTC)
Date: Mon, 27 Mar 2017 22:13:36 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170328021336.GL15423@localhost.localdomain>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-5-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490621195-2228-5-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 04/11] rbd: Clean up after
 the previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jdurgin@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

On Mon, Mar 27, 2017 at 03:26:28PM +0200, Markus Armbruster wrote:
> This code in qemu_rbd_parse_filename()
> 
>     found_str = qemu_rbd_next_tok(p, '\0', &p);
>     p = found_str;
> 
> has no effect.  Drop it, and simplify qemu_rbd_next_tok().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/rbd.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 0fea348..182a5a3 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -104,19 +104,17 @@ static char *qemu_rbd_next_tok(char *src, char delim, char **p)
>  
>      *p = NULL;
>  
> -    if (delim != '\0') {
> -        for (end = src; *end; ++end) {
> -            if (*end == delim) {
> -                break;
> -            }
> -            if (*end == '\\' && end[1] != '\0') {
> -                end++;
> -            }
> -        }
> +    for (end = src; *end; ++end) {
>          if (*end == delim) {
> -            *p = end + 1;
> -            *end = '\0';
> +            break;
>          }
> +        if (*end == '\\' && end[1] != '\0') {
> +            end++;
> +        }
> +    }
> +    if (*end == delim) {
> +        *p = end + 1;
> +        *end = '\0';
>      }
>      return src;
>  }
> @@ -177,10 +175,6 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>          goto done;
>      }
>  
> -    found_str = qemu_rbd_next_tok(p, '\0', &p);
> -
> -    p = found_str;
> -
>      /* The following are essentially all key/value pairs, and we treat
>       * 'id' and 'conf' a bit special.  Key/value pairs may be in any order. */
>      while (p) {
> -- 
> 2.7.4
> 
