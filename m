Received: from eggs.gnu.org ([2001:4830:134:3::10]:48833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoWyt-0008HT-9m
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoWyq-0007Vq-T8
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:10:55 -0500
References: <20180221140849.16068-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b8ce231-8e6a-bb83-91e2-7d7a44c9588f@redhat.com>
Date: Wed, 21 Feb 2018 10:10:30 -0600
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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

Yep, I figured that out independently, although our mails crossed, and I 
didn't notice your fix until after my other email calling out this bug 
in the spec.

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


> +++ b/docs/interop/qcow2.txt
> @@ -426,10 +426,20 @@ Standard Cluster Descriptor:
>   
>   Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>   
> -    Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
> -                    cluster boundary!
> +    Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
> +                    cluster or sector boundary!


This breaks the nice alignment of the ':' character that the rest of the 
section preserves.  You could also have done:

Compressed Clusters Descriptor (x = 61 - (cluster_bits - 8)):
    Bit  0 -  x:  ...
       x+1 - 61:  ...

to preserve the alignment, by shifting the adjustment into the 
calculation of x.  But I'm fine with either approach.

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

Yes, that wording is MUCH nicer.  Thanks for persisting, and for making 
me learn more about qcow2 compression in the process.  So either way on 
the colon alignment issue:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
