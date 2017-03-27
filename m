Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cscHG-0007Fa-PW
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 17:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cscHD-0007N3-Gp
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 17:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cscHD-0007Mt-83
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 17:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4869A804F6
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 21:34:10 +0000 (UTC)
Date: Mon, 27 Mar 2017 17:34:07 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170327213407.GJ15423@localhost.localdomain>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490621195-2228-3-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly
 reject -drive without pool or image
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

On Mon, Mar 27, 2017 at 03:26:26PM +0200, Markus Armbruster wrote:
> qemu_rbd_open() neglects to check pool and image are present.
> Reproducer:
> 
>     $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,pool=p
>     Segmentation fault (core dumped)

This reproducer is wrong, I think.  Omitting the image should be caught
earlier, but it is an error caught by the rbd_open() call.

What doesn't work is omitting the pool name, and that causes an abort()
from rados_ioctx_create(), e.g.:


$ qemu-system-x86_64 -nodefaults -drive driver=rbd,id=rbd,image=i,server.0.port=6789,server.0.host=192.168.15.180
terminate called after throwing an instance of 'std::logic_error'
  what():  basic_string::_M_construct null not valid
Aborted (core dumped)


>     $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,image=i
>     qemu-system-x86_64: -drive if=none,driver=rbd,image=i: error opening pool (null)
> 
> Doesn't affect -drive with file=..., because qemu_rbd_parse_filename()
> always sets both pool and image.
> 
> Doesn't affect -blockdev, because pool and image are mandatory in the
> QAPI schema.
> 
> Fix by adding the missing checks.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

With an updated commit message:

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/rbd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index ee13f3d..5ba2a87 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -711,6 +711,12 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>      name           = qemu_opt_get(opts, "image");
>      keypairs       = qemu_opt_get(opts, "keyvalue-pairs");
>  
> +    if (!pool || !name) {
> +        error_setg(errp, "Parameters 'pool' and 'image' are required");
> +        r = -EINVAL;
> +        goto failed_opts;
> +    }
> +
>      r = rados_create(&s->cluster, clientname);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "error initializing");
> @@ -718,9 +724,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      s->snap = g_strdup(snap);
> -    if (name) {
> -        pstrcpy(s->name, RBD_MAX_IMAGE_NAME_SIZE, name);
> -    }
> +    pstrcpy(s->name, RBD_MAX_IMAGE_NAME_SIZE, name);
>  
>      /* try default location when conf=NULL, but ignore failure */
>      r = rados_conf_read_file(s->cluster, conf);
> -- 
> 2.7.4
> 
