Received: from eggs.gnu.org ([2001:4830:134:3::10]:37684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSla-0007PS-1H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSlZ-0007S8-1h
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:20:38 -0400
References: <20180509154949.8206-1-mreitz@redhat.com>
	<20180509154949.8206-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ae9cbd6-d5c9-6e67-a713-d22c34ac206f@redhat.com>
Date: Wed, 9 May 2018 12:20:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180509154949.8206-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: Resolve relative backing
 paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

On 05/09/2018 10:49 AM, Max Reitz wrote:
> Currently, rebase interprets a relative path for the new backing image
> as follows:
> (1) Open the new backing image with the given relative path (thus relative to
>      qemu-img's working directory).
> (2) Write it directly into the overlay's backing path field (thus
>      relative to the overlay).
> 
> If the overlay is not in qemu-img's working directory, both will be
> different interpretations, which may either lead to an error somewhere
> (either rebase fails because it cannot open the new backing image, or
>   your overlay becomes unusable because its backing path does not point
>   to a file), or, even worse, it may result in your rebase being
> performed for a different backing file than what your overlay will point
> to after the rebase.
> 
> Fix this by interpreting the target backing path as relative to the
> overlay, like qemu-img does everywhere else.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1569835
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> -            blk_new_backing = blk_new_open(out_baseimg, NULL,
> +            overlay_filename = bs->exact_filename[0] ? bs->exact_filename
> +                                                     : bs->filename;
> +            out_real_path = g_malloc(PATH_MAX);
> +
> +            bdrv_get_full_backing_filename_from_filename(overlay_filename,
> +                                                         out_baseimg,
> +                                                         out_real_path,
> +                                                         PATH_MAX,
> +                                                         &local_err);
> +            if (local_err) {
> +                error_reportf_err(local_err,
> +                                  "Could not resolve backing filename: ");
> +                ret = -1;
> +                goto out;

Leaks out_real_path.

> +            }
> +
> +            blk_new_backing = blk_new_open(out_real_path, NULL,
>                                              options, src_flags, &local_err);
> +            g_free(out_real_path);

Otherwise looks good.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
