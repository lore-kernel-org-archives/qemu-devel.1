Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8714C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 19:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAE8222D0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 19:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAE8222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAg6G-0005gG-Iy
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 15:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAg5B-00055J-HL
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 15:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAg5A-0006Ff-6t
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 15:57:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAg55-0006AC-3U; Wed, 18 Sep 2019 15:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 469CF307D88C;
 Wed, 18 Sep 2019 19:57:35 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14E8C6012E;
 Wed, 18 Sep 2019 19:57:33 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190917160731.10895-1-vsementsov@virtuozzo.com>
 <20190917160731.10895-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4122264a-f7db-8b76-6930-87e2287c49b8@redhat.com>
Date: Wed, 18 Sep 2019 15:57:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917160731.10895-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 18 Sep 2019 19:57:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v12 1/2] block/backup: fix max_transfer
 handling for copy_range
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/19 12:07 PM, Vladimir Sementsov-Ogievskiy wrote:
> Of course, QEMU_ALIGN_UP is a typo, it should be QEMU_ALIGN_DOWN, as we
> are trying to find aligned size which satisfy both source and target.
> Also, don't ignore too small max_transfer. In this case seems safer to
> disable copy_range.
> 
> Fixes: 9ded4a0114968e
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/backup.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 763f0d7ff6..d8fdbfadfe 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -741,12 +741,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>       job->cluster_size = cluster_size;
>       job->copy_bitmap = copy_bitmap;
>       copy_bitmap = NULL;
> -    job->use_copy_range = !compress; /* compression isn't supported for it */
>       job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
>                                           blk_get_max_transfer(job->target));
> -    job->copy_range_size = MAX(job->cluster_size,
> -                               QEMU_ALIGN_UP(job->copy_range_size,
> -                                             job->cluster_size));
> +    job->copy_range_size = QEMU_ALIGN_DOWN(job->copy_range_size,
> +                                           job->cluster_size);
> +    /*
> +     * Compression is not supported for copy_range. Also, we don't want to
> +     * handle small max_transfer for copy_range (which currently don't
> +     * handle max_transfer at all).
> +     */
> +    job->use_copy_range = !compress && job->copy_range_size > 0;
>   
>       /* Required permissions are already taken with target's blk_new() */
>       block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
> 

I'm clear on the alignment fix, I'm not clear on the comment about 
max_transfer and how it relates to copy_range_size being non-zero.

"small max transfer" -- what happens when it's zero? we're apparently OK 
with a single cluster, but when it's zero, what happens?

