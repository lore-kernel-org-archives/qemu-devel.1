Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5490D222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5490D222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVSK-0004Fp-1a
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kVVJ7-0005la-OF; Thu, 22 Oct 2020 03:46:47 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:26742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kVVJ4-0000Ma-8l; Thu, 22 Oct 2020 03:46:45 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2316345EC0;
 Thu, 22 Oct 2020 09:46:33 +0200 (CEST)
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix larger granularity
 bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 quintela@redhat.com, dgilbert@redhat.com
References: <20201021144456.1072-1-s.reiter@proxmox.com>
 <0f3e0eba-28a3-7c6d-d8db-6831ab6a54f5@virtuozzo.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <f7ad1bf2-067e-5de2-8ba4-6000761c7367@proxmox.com>
Date: Thu, 22 Oct 2020 09:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0f3e0eba-28a3-7c6d-d8db-6831ab6a54f5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 03:46:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, qemu-block@nongnu.org, jsnow@redhat.com,
 qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 5:17 PM, Vladimir Sementsov-Ogievskiy wrote:
> 21.10.2020 17:44, Stefan Reiter wrote:
>> sectors_per_chunk is a 64 bit integer, but the calculation is done in 32
>> bits, leading to an overflow for coarse bitmap granularities.
>>
>> If that results in the value 0, it leads to a hang where no progress is
>> made but send_bitmap_bits is constantly called with nr_sectors being 0.
>>
>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>> ---
>>   migration/block-dirty-bitmap.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c 
>> b/migration/block-dirty-bitmap.c
>> index 5bef793ac0..5398869e2b 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -562,8 +562,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, 
>> BlockDriverState *bs,
>>           dbms->bitmap_alias = g_strdup(bitmap_alias);
>>           dbms->bitmap = bitmap;
>>           dbms->total_sectors = bdrv_nb_sectors(bs);
>> -        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
>> +        dbms->sectors_per_chunk = CHUNK_SIZE * 8lu *
> 
> I'd prefer 8llu for absolute safety.
> 
>>               bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
>> +        assert(dbms->sectors_per_chunk != 0);
> 
> I doubt that we need this assertion. Bug fixed, and it's obviously 
> impossible.
> And if we really want to assert that there is no overflow (assuming 
> future changes),
> it should look like this:
> 
>    assert(bdrv_dirty_bitmap_granularity(bitmap) < (1ull << 63) / 
> CHUNK_SIZE / 8 >> BDRV_SECTOR_BITS);
> 
> to cover not only corner case but any overflow.. And of course we should 
> modify original expression
> to do ">> BDRV_SECTOR_BITS" earlier than all multiplies, like
> 
>    dbms->sectors_per_chunk = CHUNK_SIZE * 8llu * 
> (bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS);
> 
> 
> But I think that only s/8/8ull/ change is enough.
>

I agree, and I wouldn't mind removing the assert, but just to clarify it 
was mostly meant to prevent the case where the migration gets stuck 
entirely. Even if the calculation is wrong, it would at least do 
_something_ instead of endlessly looping.

Maybe an

     assert(nr_sectors != 0);

in send_bitmap_bits instead for that?

>>           if (bdrv_dirty_bitmap_enabled(bitmap)) {
>>               dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
>>           }
>>
> 
> 
> With 8llu and with or without assertion:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 


