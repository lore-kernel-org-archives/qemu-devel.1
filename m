Received: from eggs.gnu.org ([2001:4830:134:3::10]:49179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoX0D-0000YT-2W
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoX0B-0008Cz-St
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:12:17 -0500
References: <20180221140849.16068-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9269b44f-c561-3eb3-f423-296f7f693c4f@redhat.com>
Date: Wed, 21 Feb 2018 10:12:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180221140849.16068-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

CC: qemu-stable@nongnu.org

Incorrect docs make for difficult interoperability.

On 02/21/2018 08:08 AM, Alberto Garcia wrote:
> This patch fixes several mistakes in the documentation of the
> compressed cluster descriptor:
> 
> 1) the documentation claims that the cluster descriptor contains the
>     number of sectors used to store the compressed data, but what it
>     actually contains is the number of sectors *minus one* or, in other
>     words, the number of additional sectors after the first one.
> 
> 2) the width of the fields is incorrectly specified. The number of bits
>     used by each field is
> 
>        x = 62 - (cluster_bits - 8)   for the offset field
>        y = (cluster_bits - 8)        for the size field
> 
>     So the offset field's location is [0, x-1], not [0, x] as stated.
> 
> 3) the size field does not contain the size of the compressed data,
>     but rather the number of sectors where that data is stored. The
>     compressed data starts at the exact point specified in the offset
>     field and ends when there's enough data to produce a cluster of
>     decompressed data. Both points can be in the middle of a sector,
>     allowing several compressed clusters to be stored next to one
>     another, sharing sectors if necessary.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> 
> v3: Fix the specification of the width of the fields, and update the
>      explanation of how the compressed data is stored [Eric].
> 
> v2: I realized that the documentation is not completely clear about
>      the exact location and size of the compressed data, so I updated
>      the patch to clarify this.
> 
> ---
>   docs/interop/qcow2.txt | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index d7fdb1fee3..feb711fb6a 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -426,10 +426,20 @@ Standard Cluster Descriptor:
>   
>   Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>   
> -    Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
> -                    cluster boundary!
> +    Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
> +                    cluster or sector boundary!
>   
> -       x+1 - 61:    Compressed size of the images in sectors of 512 bytes
> +         x - 61:    Number of additional 512-byte sectors used for the
> +                    compressed data, beyond the sector containing the offset
> +                    in the previous field. Some of these sectors may reside
> +                    in the next contiguous host cluster.
> +
> +                    Note that the compressed data does not necessarily occupy
> +                    all of the bytes in the final sector; rather, decompression
> +                    stops when it has produced a cluster of data.
> +
> +                    Another compressed cluster may map to the tail of the final
> +                    sector used by this compressed cluster.
>   
>   If a cluster is unallocated, read requests shall read the data from the backing
>   file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
