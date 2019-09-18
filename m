Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9635C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F744218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F744218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAgMd-0005Gy-FX
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAgLO-0004bK-Jv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAgLN-0005Ar-Jz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:14:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAgLJ-00059U-SZ; Wed, 18 Sep 2019 16:14:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B885981DE0;
 Wed, 18 Sep 2019 20:14:24 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7828F5C21A;
 Wed, 18 Sep 2019 20:14:23 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190917160731.10895-1-vsementsov@virtuozzo.com>
 <20190917160731.10895-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d5144da7-687c-f37e-4e6a-0687605aca0b@redhat.com>
Date: Wed, 18 Sep 2019 16:14:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917160731.10895-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 18 Sep 2019 20:14:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v12 2/2] block/backup: fix
 backup_cow_with_offload for last cluster
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
> We shouldn't try to copy bytes beyond EOF. Fix it.
> 
> Fixes: 9ded4a0114968e
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/backup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index d8fdbfadfe..89f7f89200 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -161,7 +161,7 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
>   
>       assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
>       assert(QEMU_IS_ALIGNED(start, job->cluster_size));
> -    nbytes = MIN(job->copy_range_size, end - start);
> +    nbytes = MIN(job->copy_range_size, MIN(end, job->len) - start);

I'm a little confused. I think the patch as written is correct, but I 
don't know what problem it solves.

If we're going to allow the caller to pass in an end that's beyond EOF, 
does that mean we are *requiring* the caller to pass in a value that's 
aligned?

We should probably assert what kind of a value we're accepted here, 
right? We do for start, but should we for 'end' as well?

Then ...

>       nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);

Don't we just round this right back up immediately anyway? Does that 
mean we have callers that are passing in an 'end' that's more than 1 
job-cluster beyond EOF? That seems like something that should be fixed 
in the caller, surely?

>       bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
>                               job->cluster_size * nr_clusters);
> 


