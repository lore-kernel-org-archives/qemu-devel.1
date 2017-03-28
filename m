Received: from eggs.gnu.org ([2001:4830:134:3::10]:32939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csgfO-0006uv-Js
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csgfL-0004Bf-AX
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1csgfL-0004BU-1w
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2ADD880F90
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:15:22 +0000 (UTC)
Date: Mon, 27 Mar 2017 22:15:20 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170328021520.GM15423@localhost.localdomain>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-6-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490621195-2228-6-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 05/11] rbd: Don't accept
 -drive driver=rbd, keyvalue-pairs=...
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

On Mon, Mar 27, 2017 at 03:26:29PM +0200, Markus Armbruster wrote:
> The way we communicate extra key-value pairs from
> qemu_rbd_parse_filename() to qemu_rbd_open() exposes option parameter
> "keyvalue-pairs" on the command line.  It's not wanted there.  Hack:
> rename the parameter to "=keyvalue-pairs" to make it inaccessible.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/rbd.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 182a5a3..2632533 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -215,7 +215,7 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>      }
>  
>      if (keypairs[0]) {
> -        qdict_put(options, "keyvalue-pairs", qstring_from_str(keypairs));
> +        qdict_put(options, "=keyvalue-pairs", qstring_from_str(keypairs));
>      }
>  
>  
> @@ -330,7 +330,11 @@ static QemuOptsList runtime_opts = {
>              .help = "Rados id name",
>          },
>          {
> -            .name = "keyvalue-pairs",
> +            /*
> +             * HACK: name starts with '=' so that qemu_opts_parse()
> +             * can't set it
> +             */
> +            .name = "=keyvalue-pairs",
>              .type = QEMU_OPT_STRING,
>              .help = "Legacy rados key/value option parameters",
>          },
> @@ -405,7 +409,7 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
>      conf       = qemu_opt_get(rbd_opts, "conf");
>      clientname = qemu_opt_get(rbd_opts, "user");
>      name       = qemu_opt_get(rbd_opts, "image");
> -    keypairs   = qemu_opt_get(rbd_opts, "keyvalue-pairs");
> +    keypairs   = qemu_opt_get(rbd_opts, "=keyvalue-pairs");
>  
>      ret = rados_create(&cluster, clientname);
>      if (ret < 0) {
> @@ -638,7 +642,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>      snap           = qemu_opt_get(opts, "snapshot");
>      clientname     = qemu_opt_get(opts, "user");
>      name           = qemu_opt_get(opts, "image");
> -    keypairs       = qemu_opt_get(opts, "keyvalue-pairs");
> +    keypairs       = qemu_opt_get(opts, "=keyvalue-pairs");
>  
>      if (!pool || !name) {
>          error_setg(errp, "Parameters 'pool' and 'image' are required");
> -- 
> 2.7.4
> 
