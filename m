Received: from eggs.gnu.org ([2001:4830:134:3::10]:40280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCmDr-00017h-Fn
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCmDo-0006dY-8R
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gCmDo-0006bT-26
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:50:48 -0400
Date: Wed, 17 Oct 2018 15:50:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181017135043.GE31479@localhost.localdomain>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-4-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/38] block: Use warn_report() &
 friends to report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

Am 17.10.2018 um 10:26 hat Markus Armbruster geschrieben:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  Convert a few that are actually warnings to
> warn_report().
> 
> While there, split warnings consisting of multiple sentences to
> conform to conventions spelled out in warn_report()'s contract, and
> improve a rather useless warning in sheepdog.c.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
> Cc: Liu Yuan <namei.unix@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/bochs.c    |  8 ++++----
>  block/cloop.c    |  8 ++++----
>  block/dmg.c      |  8 ++++----
>  block/iscsi.c    |  2 +-
>  block/rbd.c      | 12 ++++++------
>  block/sheepdog.c |  2 +-
>  block/vvfat.c    |  8 ++++----
>  7 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/block/bochs.c b/block/bochs.c
> index 50c630047b..36c1b45bd2 100644
> --- a/block/bochs.c
> +++ b/block/bochs.c
> @@ -112,10 +112,10 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      if (!bdrv_is_read_only(bs)) {
> -        error_report("Opening bochs images without an explicit read-only=on "
> -                     "option is deprecated. Future versions will refuse to "
> -                     "open the image instead of automatically marking the "
> -                     "image read-only.");
> +        warn_report("Opening bochs images without an explicit read-only=on "
> +                    "option is deprecated");
> +        error_printf("Future versions may refuse to open the image "
> +                     "instead of automatically marking it read-only.\n");
>          ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
>          if (ret < 0) {
>              return ret;

While I agree with your intention, it would be best to leave all of the
!bdrv_is_read_only() warnings alone. My series "[PATCH v2 0/8] block:
Add auto-read-only option" gets rid of the message entirely, so this
would only add a merge conflict.

Kevin
