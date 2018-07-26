Received: from eggs.gnu.org ([2001:4830:134:3::10]:39486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fid6l-0000Oa-Q1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fid6i-000773-RJ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:02:55 -0400
Date: Thu, 26 Jul 2018 12:02:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726100242.GD4215@localhost.localdomain>
References: <20180725142758.9980-1-lbloch@janustech.com>
	<20180725142758.9980-3-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725142758.9980-3-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4 for-3.0] qcow2: Options'
 documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 25.07.2018 um 16:27 hat Leonid Bloch geschrieben:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  docs/qcow2-cache.txt |  3 +++
>  qemu-options.hx      | 10 ++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 8a09a5cc5f..3673f2be0e 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -130,6 +130,9 @@ There are a few things that need to be taken into account:
>     memory as possible to the L2 cache before increasing the refcount
>     cache size.
>  
> +- At most two of "l2-cache-size", "refcount-cache-size", and "cache-size"
> +  can be set simultaneously.

The indentation is off here, the other list items have one space more.

>  Unlike L2 tables, refcount blocks are not used during normal I/O but
>  only during allocations and internal snapshots. In most cases they are
>  accessed sequentially (even during random guest I/O) so increasing the
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b1bf0f485f..13ece21cb6 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -752,15 +752,17 @@ image file)
>  
>  @item cache-size
>  The maximum total size of the L2 table and refcount block caches in bytes
> -(default: 1048576 bytes or 8 clusters, whichever is larger)

I think it would be good to still say something about the default.
Maybe something like "default: the sum of l2-cache-size and
refcount-cache-size"?

>  @item l2-cache-size
> -The maximum size of the L2 table cache in bytes
> -(default: 4/5 of the total cache size)
> +The maximum size of the L2 table cache.

Why did you remove "in bytes" and add a period which the other options
don't have? I prefer the old version of this line.

> +(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
> +is larger; otherwise, as large as possible or needed within the cache-size,
> +while permitting the requested or the minimal refcount cache size)
>  
>  @item refcount-cache-size
>  The maximum size of the refcount block cache in bytes
> -(default: 1/5 of the total cache size)
> +(default: 4 times the cluster size, or any portion of the cache-size, if it is
> +specified and large enough, left over after allocating the full L2 cache)

I found the second part hard to understand. Maybe "4 times the cluster
size; or if both cache-size and l2-cache-size are given, the part of
the cache-size that is not used for the L2 cache yet."?

Kevin
