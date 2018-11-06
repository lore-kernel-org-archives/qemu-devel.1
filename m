Received: from eggs.gnu.org ([2001:4830:134:3::10]:49788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gKB5m-0007PQ-Ky
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gKAxn-0005uK-Gq
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:40:52 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-8-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e13e3b16-7efc-6560-41f6-10e54e2b27da@redhat.com>
Date: Wed, 7 Nov 2018 00:40:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181101182738.70462-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/7] qcow2: do decompression in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 01/11/2018 19:27, Vladimir Sementsov-Ogievskiy wrote:
> -/* See qcow2_compress definition for parameters description */
> -static ssize_t qcow2_co_compress(BlockDriverState *bs,
> -                                 void *dest, size_t dest_size,
> -                                 const void *src, size_t src_size)
> +static ssize_t qcow2_co_do_compress(BlockDriverState *bs,
> +                                    void *dest, size_t dest_size,
> +                                    const void *src, size_t src_size,
> +                                    Qcow2CompressFunc func)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      BlockAIOCB *acb;
> @@ -3838,6 +3842,7 @@ static ssize_t qcow2_co_compress(BlockDriverState *bs,
>          .dest_size = dest_size,
>          .src = src,
>          .src_size = src_size,
> +        .func = func,
>      };
>  
>      while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
> @@ -3860,6 +3865,22 @@ static ssize_t qcow2_co_compress(BlockDriverState *bs,
>      return arg.ret;
>  }
>  

Not a blocker for this patch, but I'll note that qcow2_co_do_compress
could use thread_pool_submit_co.  Also, qcow2_co_do_compress should be a
"coroutine_fn".

Paolo
