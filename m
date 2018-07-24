Received: from eggs.gnu.org ([2001:4830:134:3::10]:57792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fi4XE-0003ay-QK
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fi4XD-00049Q-MW
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:07:56 -0400
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-3-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3a25812-2296-1e7b-6adc-b3c3b11aa202@redhat.com>
Date: Tue, 24 Jul 2018 16:07:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180724200343.13733-3-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5 for-3.0] qcow2: Options'
 documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On 07/24/2018 03:03 PM, Leonid Bloch wrote:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   docs/qcow2-cache.txt |  3 +++
>   qemu-options.hx      | 15 +++++++++++----
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 8a09a5cc5f..9d261b7da9 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -130,6 +130,9 @@ There are a few things that need to be taken into account:
>      memory as possible to the L2 cache before increasing the refcount
>      cache size.
>   
> +- All three "l2-cache-size", "refcount-cache-size", and "cache-size" options
> +  can not be set simultaneously.

Reads awkwardly; maybe:

At most two of "l2-cache-size", "refcount-cache-size", and "cache-size" 
can be set together on the command line (the omitted options are 
calculated accordingly).

> +++ b/qemu-options.hx
> @@ -752,15 +752,22 @@ image file)
>   
>   @item cache-size
>   The maximum total size of the L2 table and refcount block caches in bytes
> -(default: 1048576 bytes or 8 clusters, whichever is larger)
>   
>   @item l2-cache-size
> -The maximum size of the L2 table cache in bytes
> -(default: 4/5 of the total cache size)
> +The maximum size of the L2 table cache.
> +(default: if cache-size is not defined - 1048576 bytes or 8 clusters,
> +whichever is larger; if cache-size is defined and is large enough to
> +accommodate enough L2 cache to cover the entire virtual size of the image plus
> +the minimal amount of refcount cache - enough to cover the entire image;
> +if cache-size is defined and is not large enough - as much as possible while
> +leaving space for the needed refcount cache)

Wordy; maybe:

(default: if cache-size is not defined - 1048576 bytes or 8 clusters, 
whichever is larger; otherwise, as large as possible within cache-size 
while still permitting the requested or minimum refcount cache size).

>   
>   @item refcount-cache-size
>   The maximum size of the refcount block cache in bytes
> -(default: 1/5 of the total cache size)
> +(default: 4 times the cluster size, or if cache-size is defined and is large
> +enough to accommodate enough L2 cache to cover the entire virtual size of the
> +image plus the minimal amount of refcount cache - the part of cache-size which
> +is left after allocating the full L2 cache)

Maybe:

(default: 4 times the cluster size, plus any portion of a specified 
cache-size left over after sizing the L2 cache large enough to cover the 
entire image)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
