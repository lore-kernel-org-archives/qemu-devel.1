Received: from eggs.gnu.org ([2001:4830:134:3::10]:43093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9BLp-0000p3-Hw
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9BLo-0001WE-RC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:47:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-10-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-10-mreitz@redhat.com>
Date: Mon, 30 Oct 2017 15:47:30 +0100
Message-ID: <w51h8ugk7zx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 09/25] block: Fix
 bdrv_find_backing_image()
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

On Fri 29 Sep 2017 06:53:31 PM CEST, Max Reitz wrote:
> @@ -4096,22 +4086,31 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>          } else {
>              /* If not an absolute filename path, make it relative to the current
>               * image's filename path */
> -            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->filename,
> -                                    backing_file);
> +            filename_tmp = bdrv_make_absolute_filename(curr_bs, backing_file,
> +                                                       NULL);
> +            if (!filename_tmp) {
> +                continue;
> +            }
>  
>              /* We are going to compare absolute pathnames */
>              if (!realpath(filename_tmp, filename_full)) {
> +                g_free(filename_tmp);
>                  continue;
>              }
> +            g_free(filename_tmp);

This feels a bit too verbose, doesn't it? (especially because you're
doing the same thing twice, see below). It could be made a bit shorter,
something like:

    bool have_filename = filename_tmp && realpath(filename_tmp, filename_full);
    g_free(filename_tmp);
    if (!have_filename) {
         continue;
    }

> -            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->filename,
> -                                    curr_bs->backing_file);
> +            filename_tmp = bdrv_get_full_backing_filename(curr_bs, NULL);
> +            if (!filename_tmp) {
> +                continue;
> +            }
>  
>              if (!realpath(filename_tmp, backing_file_full)) {
> +                g_free(filename_tmp);
>                  continue;
>              }
> +            g_free(filename_tmp);

Berto
