Received: from eggs.gnu.org ([2001:4830:134:3::10]:45533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMDFx-0007Gi-Sr
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMDFx-0006Xx-3d
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:27:29 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-6-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-6-mreitz@redhat.com>
Date: Tue, 05 Dec 2017 14:27:20 +0100
Message-ID: <w51y3mh5mpz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 05/25] block: Respect backing
 bs in bdrv_refresh_filename
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

On Mon 20 Nov 2017 09:09:44 PM CET, Max Reitz wrote:
> @@ -5016,6 +5016,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>  
>          opts = qdict_new();
>          has_open_options = append_open_options(opts, bs);
> +        has_open_options |= bs->backing_overridden;
>  
>          /* If no specific options have been given for this BDS, the filename of
>           * the underlying file should suffice for this one as well */
> @@ -5027,11 +5028,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>           * file BDS. The full options QDict of that file BDS should somehow
>           * contain a representation of the filename, therefore the following
>           * suffices without querying the (exact_)filename of this BDS. */
> -        if (bs->file->bs->full_open_options) {
> +        if (bs->file->bs->full_open_options &&
> +            (!bs->backing || bs->backing->bs->full_open_options))
> +        {

Does this mean that both file. and backing. have to be overriden?

Shouldn't that be a || instead of a && ??

>              qdict_put_str(opts, "driver", drv->format_name);
>              QINCREF(bs->file->bs->full_open_options);
>              qdict_put(opts, "file", bs->file->bs->full_open_options);
>  
> +            if (bs->backing) {
> +                QINCREF(bs->backing->bs->full_open_options);
> +                qdict_put(opts, "backing", bs->backing->bs->full_open_options);
> +            } else if (bs->backing_overridden && !bs->backing) {
> +                qdict_put(opts, "backing", qstring_new());
> +            }

You don't need the !bs->backing in the second if, it's implied from the
previous one.

Berto
