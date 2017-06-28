Received: from eggs.gnu.org ([2001:4830:134:3::10]:53691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dQEMf-00006N-Ar
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dQEMb-0004E4-6m
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:54:45 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <6df66547-d15a-c986-fa76-33d5e8470ad8@openvz.org>
Date: Wed, 28 Jun 2017 17:54:17 +0300
MIME-Version: 1.0
In-Reply-To: <1498566850-7934-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, mreitz@redhat.com, eblake@redhat.com

On 06/27/2017 03:34 PM, Peter Lieven wrote:
> this patch adds a new compression_algorithm option when creating qcow2 images.
> The current default for the compresison algorithm is zlib and zlib will be
> used when this option is omitted (like before).
>
> If the option is specified e.g. with:
>
>  qemu-img create -f qcow2 -o compression_algorithm=zlib image.qcow2 1G
>
> then a new compression algorithm header extension is added and an incompatible
> feature bit is set. This means that if the header is present it must be parsed
> by Qemu on qcow2_open and it must be validated if the specified compression
> algorithm is supported by the current build of Qemu.
>
> This means if the compression_algorithm option is specified Qemu prior to this
> commit will not be able to open the created image.
>
> Signed-off-by: Peter Lieven <pl@kamp.de>

as general, it is weird to have formatting changes, spec changes and
real code changes in one patch.

[skipped]

> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 80cdfd0..1f165d6 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -85,7 +85,11 @@ in the description of a field.
>                                  be written to (unless for regaining
>                                  consistency).
>  
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      Compress algorithm bit.  If this bit is set then
> +                                the compress algorithm extension must be parsed
> +                                and checked for compatiblity.
Eric is correct here. We should add note that compressed algorithm extension
must present when the bit is sent and must be absent in the other case.

> +
> +                    Bits 3-63:  Reserved (set to 0)
>  
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -135,6 +139,8 @@ be stored. Each extension has a structure like the following:
>                          0xE2792ACA - Backing file format name
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
> +                        0xC0318300 - Compression Algorithm
> +                        0xC03183xx - Reserved for compression algorithm params
>                          other      - Unknown header extension, can be safely
>                                       ignored

I think that there is no need to reserve 255 magics once we will
add opaque container to the extension.

>  
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 15fa602..03a4b8f 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -40,23 +40,24 @@
>  #define BLOCK_FLAG_ENCRYPT          1
>  #define BLOCK_FLAG_LAZY_REFCOUNTS   8
>  
> -#define BLOCK_OPT_SIZE              "size"
> -#define BLOCK_OPT_ENCRYPT           "encryption"
> -#define BLOCK_OPT_COMPAT6           "compat6"
> -#define BLOCK_OPT_HWVERSION         "hwversion"
> -#define BLOCK_OPT_BACKING_FILE      "backing_file"
> -#define BLOCK_OPT_BACKING_FMT       "backing_fmt"
> -#define BLOCK_OPT_CLUSTER_SIZE      "cluster_size"
> -#define BLOCK_OPT_TABLE_SIZE        "table_size"
> -#define BLOCK_OPT_PREALLOC          "preallocation"
> -#define BLOCK_OPT_SUBFMT            "subformat"
> -#define BLOCK_OPT_COMPAT_LEVEL      "compat"
> -#define BLOCK_OPT_LAZY_REFCOUNTS    "lazy_refcounts"
> -#define BLOCK_OPT_ADAPTER_TYPE      "adapter_type"
> -#define BLOCK_OPT_REDUNDANCY        "redundancy"
> -#define BLOCK_OPT_NOCOW             "nocow"
> -#define BLOCK_OPT_OBJECT_SIZE       "object_size"
> -#define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
> +#define BLOCK_OPT_SIZE                  "size"
> +#define BLOCK_OPT_ENCRYPT               "encryption"
> +#define BLOCK_OPT_COMPAT6               "compat6"
> +#define BLOCK_OPT_HWVERSION             "hwversion"
> +#define BLOCK_OPT_BACKING_FILE          "backing_file"
> +#define BLOCK_OPT_BACKING_FMT           "backing_fmt"
> +#define BLOCK_OPT_CLUSTER_SIZE          "cluster_size"
> +#define BLOCK_OPT_TABLE_SIZE            "table_size"
> +#define BLOCK_OPT_PREALLOC              "preallocation"
> +#define BLOCK_OPT_SUBFMT                "subformat"
> +#define BLOCK_OPT_COMPAT_LEVEL          "compat"
> +#define BLOCK_OPT_LAZY_REFCOUNTS        "lazy_refcounts"
> +#define BLOCK_OPT_ADAPTER_TYPE          "adapter_type"
> +#define BLOCK_OPT_REDUNDANCY            "redundancy"
> +#define BLOCK_OPT_NOCOW                 "nocow"
> +#define BLOCK_OPT_OBJECT_SIZE           "object_size"
> +#define BLOCK_OPT_REFCOUNT_BITS         "refcount_bits"
> +#define BLOCK_OPT_COMPRESSION_ALGORITHM "compression_algorithm"
>  
>  #define BLOCK_PROBE_BUF_SIZE        512
>  
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 5b925ec..c0d1bec 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -621,6 +621,16 @@ file which is COW and has data blocks already, it couldn't be changed to NOCOW
>  by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
>  the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
>  
> +@item compression_algorithm
> +Defines which compression algorithm is should be used for compressed clusters.
> +The following options are available if support for the respective libraries
> +has been enabled at compile time:
> +
> +   zlib            Uses standard zlib compression (default)
> +
> +The compression algorithm can only be defined at image create time and cannot
> +be changed later.
> +
>  @end table
>  
>  @item Other
