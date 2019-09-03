Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD68C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146AB2341E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146AB2341E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58b5-0003Sw-WC
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i58Zp-0002tx-45
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i58Zn-0002z2-Qu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:10:28 -0400
Received: from kerio.kamp.de ([195.62.97.192]:47672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1i58Zn-0002yb-KS; Tue, 03 Sep 2019 09:10:27 -0400
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Tue, 3 Sep 2019 15:10:20 +0200
To: Kevin Wolf <kwolf@redhat.com>
References: <20190902152413.14070-1-pl@kamp.de>
 <20190903130254.GG4582@localhost.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <95ed6572-b423-ddf2-c2a1-53ae09d9f767@kamp.de>
Date: Tue, 3 Sep 2019 15:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903130254.GG4582@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: Re: [Qemu-devel] [PATCH V2] block/vhdx: add check for truncated
 image files
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
Cc: codyprime@gmail.com, mreitz@redhat.com, jhf@kamp.de, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.19 um 15:02 schrieb Kevin Wolf:
> Am 02.09.2019 um 17:24 hat Peter Lieven geschrieben:
>> qemu is currently not able to detect truncated vhdx image files.
>> Add a basic check if all allocated blocks are reachable at open and
>> report all errors during bdrv_co_check.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> V2: - add error reporting [Kevin]
>>      - use bdrv_getlength instead of bdrv_get_allocated_file_size [Kevin]
>>      - factor out BAT entry check and add error reporting for region
>>        overlaps
>>      - already check on vhdx_open
>>
>>   block/vhdx.c | 85 +++++++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 68 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/vhdx.c b/block/vhdx.c
>> index 6a09d0a55c..6afba5e8c2 100644
>> --- a/block/vhdx.c
>> +++ b/block/vhdx.c
>> @@ -24,6 +24,7 @@
>>   #include "qemu/option.h"
>>   #include "qemu/crc32c.h"
>>   #include "qemu/bswap.h"
>> +#include "qemu/error-report.h"
>>   #include "vhdx.h"
>>   #include "migration/blocker.h"
>>   #include "qemu/uuid.h"
>> @@ -235,6 +236,9 @@ static int vhdx_region_check(BDRVVHDXState *s, uint64_t start, uint64_t length)
>>       end = start + length;
>>       QLIST_FOREACH(r, &s->regions, entries) {
>>           if (!((start >= r->end) || (end <= r->start))) {
>> +            error_report("VHDX region %" PRIu64 "-%" PRIu64 " overlaps with "
>> +                         "region %" PRIu64 "-%." PRIu64, start, end, r->start,
>> +                         r->end);
>>               ret = -EINVAL;
>>               goto exit;
>>           }
>> @@ -877,6 +881,60 @@ static void vhdx_calc_bat_entries(BDRVVHDXState *s)
>>   
>>   }
>>   
>> +static int vhdx_check_bat_entries(BlockDriverState *bs, int *errcnt)
>> +{
>> +    BDRVVHDXState *s = bs->opaque;
>> +    int64_t image_file_size = bdrv_getlength(bs->file->bs);
>> +    uint64_t payblocks = s->chunk_ratio;
>> +    int i, ret = 0;
> bdrv_getlength() can fail. It's probably better to error out immediately
> instead of reporting that every BAT entry is > -1.
>
>> +    for (i = 0; i < s->bat_entries; i++) {
> s->bat_entries is uint32_t, so i should probably be the same.
>
>> +        if ((s->bat[i] & VHDX_BAT_STATE_BIT_MASK) ==
>> +            PAYLOAD_BLOCK_FULLY_PRESENT) {
>> +            /*
>> +             * Check if fully allocated BAT entries do not reside after
>> +             * end of the image file.
>> +             */
>> +            if ((s->bat[i] & VHDX_BAT_FILE_OFF_MASK) + s->block_size >
>> +                image_file_size) {
> Didn't we want to introduce an overflow check before making this check?
> Something like if (bat_offset > UINT64_MAX - s->block_size)?


Sorry, i missed that.


The bat entries are UINT64_T so this check will always be false for the

default block size of 1MB. In fact we should check for


bat_offset > INT64_MAX - s->block_size


right?


Peter




