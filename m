Received: from eggs.gnu.org ([2001:4830:134:3::10]:53014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e7HFn-0006go-Hd
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e7HFm-0007cR-SQ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:41:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
References: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
Date: Wed, 25 Oct 2017 10:40:47 +0200
Message-ID: <w5160b3k4c0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] throttle: fix a qemu crash problem when
 calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sochin jiang <sochin.jiang@huawei.com>, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

On Tue 24 Oct 2017 05:33:51 AM CEST, sochin jiang wrote:
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -576,7 +576,9 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
>  
>      /* remove the current tgm from the list */
>      QLIST_REMOVE(tgm, round_robin);
> -    throttle_timers_destroy(&tgm->throttle_timers);
> +    if (throttle_timers_are_initialized(&tgm->throttle_timers)) {
> +        throttle_timers_destroy(&tgm->throttle_timers);
> +    }
>      qemu_mutex_unlock(&tg->lock);
>  
>      throttle_group_unref(&tg->ts);

I don't know what the rest of the people think, but I'm not completely
convinced that it's a good idea to have an active ThrottleState inside a
ThrottleGroupMember without timers.

Perhaps in blk_remove_bs() after detaching the AioContext from the BDS
we can attach the default one (what you would get with
blk_get_aio_context()).

On the other hand I think that Manos's series to remove the legacy
throttling code gets rid of BlockBackend.ThrottleGroupMember completely.

Berto
