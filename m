Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C9C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86EB2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86EB2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0P9k-0008GR-8N
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1k0P97-0007ak-2J; Tue, 28 Jul 2020 08:55:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1k0P95-0004gN-CA; Tue, 28 Jul 2020 08:55:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B63D7ACB5;
 Tue, 28 Jul 2020 12:55:59 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/2] block: Fix bdrv_aligned_p*v() for qiov_offset
 != 0
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200728120806.265916-1-mreitz@redhat.com>
 <20200728120806.265916-2-mreitz@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <2f952cb9-36dc-7dd1-d64e-402259829311@suse.de>
Date: Tue, 28 Jul 2020 14:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200728120806.265916-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 01:54:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Claudio Fontana <cfontana@suse.de>

On 7/28/20 2:08 PM, Max Reitz wrote:
> Since these functions take a @qiov_offset, they must always take it into
> account when working with @qiov.  There are a couple of places where
> they do not, but they should.
> 
> Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
> Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Bruce Rogers <brogers@suse.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index b6564e34c5..ad3a51ed53 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1524,12 +1524,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>              assert(num);
>  
>              ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
> -                                     num, qiov, bytes - bytes_remaining, 0);
> +                                     num, qiov,
> +                                     qiov_offset + bytes - bytes_remaining, 0);
>              max_bytes -= num;
>          } else {
>              num = bytes_remaining;
> -            ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
> -                                    bytes_remaining);
> +            ret = qemu_iovec_memset(qiov, qiov_offset + bytes - bytes_remaining,
> +                                    0, bytes_remaining);
>          }
>          if (ret < 0) {
>              goto out;
> @@ -2032,7 +2033,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>              }
>  
>              ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
> -                                      num, qiov, bytes - bytes_remaining,
> +                                      num, qiov,
> +                                      qiov_offset + bytes - bytes_remaining,
>                                        local_flags);
>              if (ret < 0) {
>                  break;
> 


