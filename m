Received: from eggs.gnu.org ([2001:4830:134:3::10]:33193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csggY-0007Sh-6l
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csggU-0004lj-VG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:16:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1csggU-0004lY-My
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:16:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA30F51452
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:16:33 +0000 (UTC)
Date: Mon, 27 Mar 2017 22:16:32 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170328021632.GN15423@localhost.localdomain>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-7-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490621195-2228-7-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 06/11] rbd: Clean up
 runtime_opts, fix -drive to reject filename
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

On Mon, Mar 27, 2017 at 03:26:30PM +0200, Markus Armbruster wrote:
> runtime_opts is used for three different purposes:
> 
> * qemu_rbd_open() uses it to accept options it recognizes, such as
>   "pool" and "image".  Other .bdrv_open() methods do it similarly.
> 
> * qemu_rbd_open() accepts additional list-valued options
>   auth-supported and server, with the help of qemu_rbd_array_opts().
>   The list elements are again dictionaries.  qemu_rbd_array_opts()
>   uses runtime_opts to accept their members.  Thus, runtime_opts
>   contains recognized sub-sub-options "auth", "host", "port" in
>   addition to recognized options.  No other block driver does that.
> 
> * qemu_rbd_create() uses it to convert the QDict produced by
>   qemu_rbd_parse_filename() to QemuOpts.  No other block driver does
>   that.  The keys produced by qemu_rbd_parse_filename() are "pool",
>   "image", "snapshot", "conf", "user" and "keyvalue-pairs".
>   qemu_rbd_open() accepts these, so no additional ones here.
> 
> This is a confusing mess.  Dates back to commit 0f9d252.  First step
> to clean it up is documenting runtime_opts.desc[]:
> 
> * Reorder entries to match the QAPI schema, like we do in other block
>   drivers.
> 
> * Document why the schema's "server" and "auth-supported" aren't in
>   .desc[].
> 
> * Document why "keyvalue-pairs", "host", "port" and "auth" are in
>   .desc[], but not the schema.
> 
> * Delete "filename", because none of the three users actually uses it.
>   This fixes -drive to reject parameter filename instead of silently
>   ignoring it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/rbd.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 2632533..b2afe07 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -294,21 +294,6 @@ static QemuOptsList runtime_opts = {
>      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>      .desc = {
>          {
> -            .name = "filename",
> -            .type = QEMU_OPT_STRING,
> -            .help = "Specification of the rbd image",
> -        },
> -        {
> -            .name = "password-secret",
> -            .type = QEMU_OPT_STRING,
> -            .help = "ID of secret providing the password",
> -        },
> -        {
> -            .name = "conf",
> -            .type = QEMU_OPT_STRING,
> -            .help = "Rados config file location",
> -        },
> -        {
>              .name = "pool",
>              .type = QEMU_OPT_STRING,
>              .help = "Rados pool name",
> @@ -319,6 +304,11 @@ static QemuOptsList runtime_opts = {
>              .help = "Image name in the pool",
>          },
>          {
> +            .name = "conf",
> +            .type = QEMU_OPT_STRING,
> +            .help = "Rados config file location",
> +        },
> +        {
>              .name = "snapshot",
>              .type = QEMU_OPT_STRING,
>              .help = "Ceph snapshot name",
> @@ -329,6 +319,19 @@ static QemuOptsList runtime_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "Rados id name",
>          },
> +        /*
> +         * server.* and auth-supported.* extracted manually, see
> +         * qemu_rbd_array_opts()
> +         */
> +        {
> +            .name = "password-secret",
> +            .type = QEMU_OPT_STRING,
> +            .help = "ID of secret providing the password",
> +        },
> +
> +        /*
> +         * Keys for qemu_rbd_parse_filename(), not in the QAPI schema
> +         */
>          {
>              /*
>               * HACK: name starts with '=' so that qemu_opts_parse()
> @@ -338,6 +341,13 @@ static QemuOptsList runtime_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "Legacy rados key/value option parameters",
>          },
> +
> +        /*
> +         * The remainder aren't option keys, but option sub-sub-keys,
> +         * so that qemu_rbd_array_opts() can abuse runtime_opts for
> +         * its own purposes
> +         * TODO clean this up
> +         */
>          {
>              .name = "host",
>              .type = QEMU_OPT_STRING,
> -- 
> 2.7.4
> 
