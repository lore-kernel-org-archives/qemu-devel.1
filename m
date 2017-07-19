Received: from eggs.gnu.org ([2001:4830:134:3::10]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXuBa-0004cD-Pk
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXuBZ-0006WF-VU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:59:02 -0400
References: <20170714100029.26288-1-ppandit@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2b6c4c1f-2076-120a-7f97-f6145d84837a@redhat.com>
Date: Wed, 19 Jul 2017 14:49:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170714100029.26288-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide: check BlockBackend object in
 ide_cancel_dma_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Chensongnian <chensongnian@huawei.com>, qemu-block@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>



On 07/14/2017 06:00 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When cancelling pending DMA requests in ide_cancel_dma_sync,
> the s->blk object could be null, leading to a null dereference.
> Add check to avoid it.
> 
> Reported-by: Chensongnian <chensongnian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ide/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64..04474b3 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -681,8 +681,10 @@ void ide_cancel_dma_sync(IDEState *s)
>  #ifdef DEBUG_IDE
>          printf("%s: draining all remaining requests", __func__);
>  #endif
> -        blk_drain(s->blk);
> -        assert(s->bus->dma->aiocb == NULL);
> +        if (s->blk) {
> +            blk_drain(s->blk);
> +            assert(s->bus->dma->aiocb == NULL);
> +        }
>      }
>  }
>  
> 

I guess this occurs through

ide_exec_cmd
  cmd_device_reset
    ide_cancel_dma_sync

though if s->blk does not exist, we should usually not be able to
address this device with a reset command as such. (core.c:2021) -- but
this is only for secondary devices. I guess we don't guard against
nonexistent primary devices......?

Further, how do we have s->bus->dma->aiocb if there's no blk device?
What DMA request did we accept...?

Can you please submit a stack that illustrates the code path followed so
this fix can be properly verified and tested?

Thanks,
--John
