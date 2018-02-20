Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eo9TJ-0008GX-U9
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eo9TF-0006zx-7g
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:45 -0500
References: <20180220141531.11770-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a1cabd5-75e4-e41c-3c3c-2ae2d590a97f@redhat.com>
Date: Tue, 20 Feb 2018 09:04:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180220141531.11770-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] specs/qcow2: Fix documentation of the
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/20/2018 08:15 AM, Alberto Garcia wrote:
> The documentation claims that the cluster descriptor contains the
> number of sectors used to store the compressed data, but what it
> actually contains is the number of sectors *minus one*.
> 
> That can be easily seen in qcow2_decompress_cluster(), that adds one
> to the value stored in that field:
> 
>    nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   docs/interop/qcow2.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index d7fdb1fee3..b12972be82 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -429,7 +429,8 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>       Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
>                       cluster boundary!
>   
> -       x+1 - 61:    Compressed size of the images in sectors of 512 bytes
> +       x+1 - 61:    Size of the compressed data in sectors of 512 bytes,
> +                    minus one (that is, a value of n here means n+1 sectors).

Another way to read this field is as the index of the sector that 
includes the tail of the compressed data (so a value of 0 means the data 
ends in sector[0], occupying 1 sector; a value of 10 means the data ends 
in sector[10], occupying 11 sectors...).  But your wording is more compact.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
