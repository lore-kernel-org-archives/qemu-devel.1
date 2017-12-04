Received: from eggs.gnu.org ([2001:4830:134:3::10]:54288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtk3-0004dp-W6
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtk3-0004yO-8I
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:37:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-22-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-22-mreitz@redhat.com>
Date: Mon, 04 Dec 2017 17:37:07 +0100
Message-ID: <w51shcq30wc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 21/25] block: Purify
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 20 Nov 2017 09:10:00 PM CET, Max Reitz wrote:
> -static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
> +static void blkdebug_refresh_filename(BlockDriverState *bs)
>  {
>      BDRVBlkdebugState *s = bs->opaque;
> -    QDict *opts;
>      const QDictEntry *e;
> -    bool force_json = false;
> -
> -    for (e = qdict_first(options); e; e = qdict_next(options, e)) {
> -        if (strcmp(qdict_entry_key(e), "config") &&
> -            strcmp(qdict_entry_key(e), "x-image"))
> -        {
> -            force_json = true;
> -            break;
> -        }
> -    }
> +    int ret;
>  
> -    if (force_json && !bs->file->bs->full_open_options) {
> -        /* The config file cannot be recreated, so creating a plain filename
> -         * is impossible */
> +    if (!bs->file->bs->exact_filename[0]) {
>          return;
>      }
>  
> -    if (!force_json && bs->file->bs->exact_filename[0]) {
> -        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                           "blkdebug:%s:%s", s->config_file ?: "",
> -                           bs->file->bs->exact_filename);
> -        if (ret >= sizeof(bs->exact_filename)) {
> -            /* An overflow makes the filename unusable, so do not report any */
> -            bs->exact_filename[0] = 0;
> +    for (e = qdict_first(bs->full_open_options); e;
> +         e = qdict_next(bs->full_open_options, e))
> +    {
> +        if (strcmp(qdict_entry_key(e), "config") &&
> +            strcmp(qdict_entry_key(e), "image") &&

Shouldn't this be "x-image" ?

Berto
