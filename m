Received: from eggs.gnu.org ([2001:4830:134:3::10]:35736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1covTC-0003Vg-KR
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1covT9-0006dv-HG
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:15:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1covT9-0006db-7n
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:15:15 -0400
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<f8f478b3-70a0-b67b-c4df-3f68ac66308a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d54e7c6e-d261-dff0-9038-8f62283c91a4@redhat.com>
Date: Fri, 17 Mar 2017 18:15:11 +0100
MIME-Version: 1.0
In-Reply-To: <f8f478b3-70a0-b67b-c4df-3f68ac66308a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Assertion failure taking external snapshot with
 virtio drive + iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org



On 17/03/2017 18:11, Paolo Bonzini wrote:
> 
> 
> On 17/03/2017 17:55, Ed Swierk wrote:
>> I'm running into the same problem taking an external snapshot with a
>> virtio-blk drive with iothread, so it's not specific to virtio-scsi.
>> Run a Linux guest on qemu master
>>
>>   qemu-system-x86_64 -nographic -enable-kvm -monitor
>> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
>> iothread,id=iothread1 -drive file=/x/drive.qcow2,if=none,id=drive0
>> -device virtio-blk-pci,iothread=iothread1,drive=drive0
>>
>> Then in the monitor
>>
>>   snapshot_blkdev drive0 /x/snap1.qcow2
>>
>> qemu bombs with
>>
>>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
>> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.
>>
>> whereas without the iothread the assertion failure does not occur.
> 
> Please try this patch:

Hmm, no.  I'll post the full fix on top of John Snow's patches.

Paolo

> diff --git a/block/block-backend.c b/block/block-backend.c
> index 5742c09..1d95879 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1876,6 +1876,7 @@ static void blk_root_drained_begin(BdrvChild *child)
>      if (blk->public.io_limits_disabled++ == 0) {
>          throttle_group_restart_blk(blk);
>      }
> +    aio_disable_external(bdrv_get_aio_context(bs));
>  }
>  
>  static void blk_root_drained_end(BdrvChild *child)
> @@ -1883,5 +1884,6 @@ static void blk_root_drained_end(BdrvChild *child)
>      BlockBackend *blk = child->opaque;
>  
>      assert(blk->public.io_limits_disabled);
> +    aio_enable_external(bdrv_get_aio_context(bs));
>      --blk->public.io_limits_disabled;
>  }
> diff --git a/block/io.c b/block/io.c
> index 2709a70..a6dcef5 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -224,7 +224,6 @@ void bdrv_drained_begin(BlockDriverState *bs)
>      }
>  
>      if (!bs->quiesce_counter++) {
> -        aio_disable_external(bdrv_get_aio_context(bs));
>          bdrv_parent_drained_begin(bs);
>      }
>  
> @@ -239,7 +238,6 @@ void bdrv_drained_end(BlockDriverState *bs)
>      }
>  
>      bdrv_parent_drained_end(bs);
> -    aio_enable_external(bdrv_get_aio_context(bs));
>  }
>  
>  /*
> 
> This is not a proper fix, the right one would move the calls into
> virtio-blk and virtio-scsi, but it might be a start.  I think the
> issue is that you have one call to aio_disable_external for drive.qcow2
> before the snapshot, and two calls to aio_enable_external (one for
> drive.qcow2 and one for snap1.qcow2) after.
> 
> Paolo
> 
