Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E30C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468382173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468382173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4nB4-0007n1-AB
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i4n9h-0007Gl-Vl
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i4n9g-00057n-KR
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:18:05 -0400
Received: from kerio.kamp.de ([195.62.97.192]:34613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1i4n9g-000514-9p; Mon, 02 Sep 2019 10:18:04 -0400
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Mon, 2 Sep 2019 16:17:55 +0200
To: Kevin Wolf <kwolf@redhat.com>
References: <20190829133615.29873-1-pl@kamp.de>
 <20190902130701.GE13140@localhost.localdomain>
 <7992af97-086e-b1c1-2b1a-fa72727e04c1@kamp.de>
 <20190902134622.GH13140@localhost.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <644e6e56-828a-120f-35de-1e738327a8bd@kamp.de>
Date: Mon, 2 Sep 2019 16:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902134622.GH13140@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: Re: [Qemu-devel] [PATCH] block/vhdx: add check for truncated image
 files
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
Cc: codyprime@gmail.com, Jan-Hendrik Frintrop <jhf@kamp.de>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.09.19 um 15:46 schrieb Kevin Wolf:
> Am 02.09.2019 um 15:15 hat Peter Lieven geschrieben:
>> Am 02.09.19 um 15:07 schrieb Kevin Wolf:
>>> Am 29.08.2019 um 15:36 hat Peter Lieven geschrieben:
>>>> qemu is currently not able to detect truncated vhdx image files.
>>>> Add a basic check if all allocated blocks are reachable to vhdx_co_check.
>>>>
>>>> Signed-off-by: Jan-Hendrik Frintrop <jhf@kamp.de>
>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>>> ---
>>>>    block/vhdx.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/block/vhdx.c b/block/vhdx.c
>>>> index 6a09d0a55c..4382b1375d 100644
>>>> --- a/block/vhdx.c
>>>> +++ b/block/vhdx.c
>>>> @@ -2068,10 +2068,29 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
>>>>                                          BdrvCheckMode fix)
>>>>    {
>>>>        BDRVVHDXState *s = bs->opaque;
>>>> +    VHDXSectorInfo sinfo;
>>>> +    int64_t file_size = bdrv_get_allocated_file_size(bs);
>>> Don't you mean bdrv_getlength()?
>>>
>>> bdrv_get_allocated_file_size() is only the allocated size, i.e. without
>>> holes. So a higher offset may actually be present.
>>
>> Isn't bdrv_getlength the virtual disk size? I need to check if a block
>> points to a location after EOF of the underlying physical file.
> Yes, it would have to be bdrv_getlength(bs->file->bs), i.e. call it on
> the protocol layer, not on the format layer.
>
>>>> +    int64_t sector_num;
>>>>        if (s->log_replayed_on_open) {
>>>>            result->corruptions_fixed++;
>>>>        }
>>>> +
>>>> +    for (sector_num = 0; sector_num < bs->total_sectors;
>>>> +         sector_num += s->block_size / BDRV_SECTOR_SIZE) {
>>>> +        int nb_sectors = MIN(bs->total_sectors - sector_num,
>>>> +                             s->block_size / BDRV_SECTOR_SIZE);
>>>> +        vhdx_block_translate(s, sector_num, nb_sectors, &sinfo);
>>>> +        if ((s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) ==
>>>> +            PAYLOAD_BLOCK_FULLY_PRESENT) {
>>>> +            if (sinfo.file_offset +
>>>> +                sinfo.sectors_avail * BDRV_SECTOR_SIZE > file_size) {
>>> Do we need to protect against integer overflows here? I think
>>> sinfo.file_offset comes directly from the image file and might be
>>> corrupted.
>>>
>>> Or has it already been check somewhere?
>>
>> The headers are being checked in vhdx_open.  sinfo.file_offset +
>> sinfo.sectors_avail * BDRV_SECTOR_SIZE is exactly what is being passed
>> to bdrv_pread when reading from the image file.
> Fair enough, though if I'm not missing anything, we only check that BAT
> entries don't overlap with other regions, not that they aren't too high.
> And vhdx_block_translate() doesn't seem to check for overflows either
> before it sets sinfo->sectors_avail.
>
> So maybe this is actually a bug that should be fixed in
> vhdx_block_translate() so that normal accesses get the fix, too.


Or maybe already or also check in vhdx_open when we already iterate over all BAT entries?

vhdx_block_translate cannot return an error at the moment.


Peter




