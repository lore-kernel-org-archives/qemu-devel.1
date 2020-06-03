Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA874C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C46205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C46205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgPqC-0004fx-Vi
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 05:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jgPpd-0004Fz-09
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:37:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45406)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jgPpb-0000A1-AC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:37:08 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 068E4CD464;
 Wed,  3 Jun 2020 12:37:04 +0300 (MSK)
Subject: Re: [PATCH v2] icount: make dma reads deterministic
To: Kevin Wolf <kwolf@redhat.com>
References: <158823737122.27545.13132967751052120169.stgit@pasha-ThinkPad-X280>
 <20200602155440.GK5940@linux.fritz.box>
 <ed02a968-88f1-edc4-46f9-1b69c1e06d70@ispras.ru>
 <20200603081527.GA5127@linux.fritz.box>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <1cffedf7-e0f9-e5c9-cc64-47cf3d741246@ispras.ru>
Date: Wed, 3 Jun 2020 12:37:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200603081527.GA5127@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.45; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:56:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, pavel.dovgaluk@ispras.ru,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 03.06.2020 11:15, Kevin Wolf wrote:
> Am 03.06.2020 um 07:57 hat Pavel Dovgalyuk geschrieben:
>> On 02.06.2020 18:54, Kevin Wolf wrote:
>>> Am 30.04.2020 um 11:02 hat Pavel Dovgalyuk geschrieben:
>>>> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
>>>>
>>>> Windows guest sometimes makes DMA requests with overlapping
>>>> target addresses. This leads to the following structure of iov for
>>>> the block driver:
>>>>
>>>> addr size1
>>>> addr size2
>>>> addr size3
>>>>
>>>> It means that three adjacent disk blocks should be read into the same
>>>> memory buffer. Windows does not expects anything from these bytes
>>>> (should it be data from the first block, or the last one, or some mix),
>>>> but uses them somehow. It leads to non-determinism of the guest execution,
>>>> because block driver does not preserve any order of reading.
>>>>
>>>> This situation was discusses in the mailing list at least twice:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
>>>> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05185.html
>>>>
>>>> This patch makes such disk reads deterministic in icount mode.
>>>> It splits the whole request into several parts. Parts may overlap,
>>>> but SGs inside one part do not overlap.
>>>> Parts that are processed later overwrite the prior ones in case
>>>> of overlapping.
>>>>
>>>> Examples for different SG part sequences:
>>>>
>>>> 1)
>>>> A1 1000
>>>> A2 1000
>>>> A1 1000
>>>> A3 1000
>>>> ->
>>>> One request is split into two.
>>>> A1 1000
>>>> A2 1000
>>>> --
>>>> A1 1000
>>>> A3 1000
>>>>
>>>> 2)
>>>> A1 800
>>>> A2 1000
>>>> A1 1000
>>>> ->
>>>> A1 800
>>>> A2 1000
>>>> --
>>>> A1 1000
>>>>
>>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>
>>>> --
>>>>
>>>> v2:
>>>>    - Rewritten the loop to split the request instead of skipping the parts
>>>>      (suggested by Kevin Wolf)
>>>> ---
>>>>    dma-helpers.c |   20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/dma-helpers.c b/dma-helpers.c
>>>> index e8a26e81e1..a49f9a0e34 100644
>>>> --- a/dma-helpers.c
>>>> +++ b/dma-helpers.c
>>>> @@ -13,6 +13,8 @@
>>>>    #include "trace-root.h"
>>>>    #include "qemu/thread.h"
>>>>    #include "qemu/main-loop.h"
>>>> +#include "sysemu/cpus.h"
>>>> +#include "qemu/range.h"
>>>>    /* #define DEBUG_IOMMU */
>>>> @@ -142,6 +144,24 @@ static void dma_blk_cb(void *opaque, int ret)
>>>>            cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
>>>>            cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
>>>>            mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir);
>>>> +        /*
>>>> +         * Make reads deterministic in icount mode. Windows sometimes issues
>>>> +         * disk read requests with overlapping SGs. It leads
>>>> +         * to non-determinism, because resulting buffer contents may be mixed
>>>> +         * from several sectors. This code splits all SGs into several
>>>> +         * groups. SGs in every group do not overlap.
>>>> +         */
>>>> +        if (use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
>>>> +            int i;
>>>> +            for (i = 0 ; i < dbs->iov.niov ; ++i) {
>>>> +                if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
>>>> +                                   dbs->iov.iov[i].iov_len, (intptr_t)mem,
>>>> +                                   cur_len)) {
>>>> +                    mem = NULL;
>>> Doesn't this leak mem, i.e. should we call dma_memory_unmap()?
>> Thanks, I missed, that the memory is unmapped on request finish.
>>
>>> Did you verify that it is guaranteed that mapping the same guest memory
>>> twice results in the same host address? v1 compared the SG list (which
>>> has guest addresses) rather than the resulting QEMUIOVector (which has
>>> host addresses).
>> We don't need the host addresses to be equivalent in different runs.
>>
>> The order of the SG list entries is deterministic. This is enough for
>> successful exclusion of the duplicate entries.
> I'm not talking about different runs, but just a single one. You only
> correctly detect an overlap if mapping the same guest address returns
> the same host address for both entries.
>
> Let me see...
>
> address_space_map() has a path where it allocates a bounce buffer rather
> than directly mapping guest memory. We're lucky there because it has
> only one global bounce buffer and if it's already in use, it returns
> NULL instead, which means that we split the request. This is good, but
> if it ever changes to allow more than one bounce buffer, the code would
> break. If we rely on it, maybe better add a comment to the bounce.in_use
> code in address_space_map().
>
> The other code path just translates according to the FlatView of the
> AddressSpace. Do we need some kind of locking to make sure that the
> FlatView doesn't change between both dma_memory_map() calls? On the
> other hand, use_icount is probably not something that you would use
> together with iothreads, so maybe running in the main thread is enough
> to protect it.
>
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>> +        }
>>>>            if (!mem)
>>>>                break;
> Now that I talked about how a NULL return saves us, I wonder, shouldn't
> this check actually come before the overlap checking?

I missed this one.

With unmap, we should check only non-null case. I'll add the comparison.



