Received: from eggs.gnu.org ([2001:4830:134:3::10]:37080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyZi0-0004wm-1n
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyZhw-00034z-Sm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:07:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyZhw-00034j-Nv
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:06:56 -0400
Date: Wed, 21 Mar 2018 17:06:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180321090644.GC20571@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-3-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] migration: stop allocating and freeing
 memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Mar 13, 2018 at 03:57:33PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Current code uses compress2()/uncompress() to compress/decompress
> memory, these two function manager memory allocation and release
> internally, that causes huge memory is allocated and freed very
> frequently
> 
> More worse, frequently returning memory to kernel will flush TLBs
> and trigger invalidation callbacks on mmu-notification which
> interacts with KVM MMU, that dramatically reduce the performance
> of VM
> 
> So, we maintain the memory by ourselves and reuse it for each
> compression and decompression
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/qemu-file.c |  34 ++++++++++--
>  migration/qemu-file.h |   6 ++-
>  migration/ram.c       | 142 +++++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 140 insertions(+), 42 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 2ab2bf362d..1ff33a1ffb 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -658,6 +658,30 @@ uint64_t qemu_get_be64(QEMUFile *f)
>      return v;
>  }
>  
> +/* return the size after compression, or negative value on error */
> +static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
> +                              const uint8_t *source, size_t source_len)
> +{
> +    int err;
> +
> +    err = deflateReset(stream);

I'm not familiar with zlib, but I saw this in manual:

 https://www.zlib.net/manual.html

 This function is equivalent to deflateEnd followed by deflateInit,
 but does not free and reallocate the internal compression state. The
 stream will leave the compression level and any other attributes that
 may have been set unchanged.

I thought it was deflateInit() who is slow?  Can we avoid the reset as
long as we make sure to deflateInit() before doing anything else?

Meanwhile, is there any performance number for this single patch?
Since I thought the old code is calling compress2() which contains
deflateInit() and deflateEnd() too, just like what current patch do?

It would be nice too if we can split the patch into two (decode,
encode) if you want, but that's optional.

Thanks,

-- 
Peter Xu
