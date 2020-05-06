Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25869C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D617920575
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AYG5M5C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D617920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWM1r-0003j9-VH
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWM0q-0003G9-8t; Wed, 06 May 2020 11:31:08 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com
 ([40.107.21.125]:7433 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWM0n-0002ey-37; Wed, 06 May 2020 11:31:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3VaHi/+pDOAXt4VDUrQnaPnXjOSdNjnKb6QwwZUw2tzePCEUWymOSyc1Of74Z8+BKGk+wd7kHguvqgPuzYtl4NHgCaepi4Ki7bekYTA1OWpbBs7GJ0+ArwgXDzUkgsZHgzPgz/POwV/n0rNFBFHl1fE8r2Znf4B+bYnanjjMxhl3eyslLjIV3EoqfCOyhP1ANGH1fDFx9VRWbkROTLqxcO65b4g0dmIsM8fEZERrSNMtlcjMExVSYm/NdsidOg/cUg10TqhSZXRYdHFuTQ9WGnIaGDxYm46gndCR3Q2QZt6N02x2qMnPj/dsxgTzguW5FqmTjihFjl0ctiS9oPn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4mRnZN+tibY9iSSgWNLttOuX+ZTjIOQCCHOCEnGxMI=;
 b=RC7sUnGVv7PvK959nq7wGGVId7hft9tzjFXxgtL/BwTHQscff6ENYABFoUKbBOloOwJ8nkxht18dS00rzDcklkgITIgeJNTZUYemXwXqHE6QukDBRAPtNGg0XKnauOqBTfohfrfqc6DJz6nXnqzeZyzdWonf6PexeR0IISadVH3SsL0rSYmY8MCMafjysoRZ2nJPJ/6wxVPd9rVt8AZX8CvRcgypoX+wIHb9HVUNsflHKdyN945jCMS5QYfgRUjQdnCExDAVLF7ye6LNiRnKtJ9TrsxmjZDaGHuloFhRzG8j0b3qhJqnPFR1S4BdMU2cN1H8jgg3/I1ohLbaUIJFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4mRnZN+tibY9iSSgWNLttOuX+ZTjIOQCCHOCEnGxMI=;
 b=AYG5M5C/8Izdyhe9838Qe8fTb+kgBvJhHE+pdYpmGqa1gpD6Bl0vXktNY/VH8xCU+OCBW5y3OaK7Cq+o/7l6UVE5SotK8ZNHpiDdpsUelGFinOP3g63rfWcQ3I29XJUECwR8qoPCPtH5RSh52y4pTltL/q/W9XvWjClemejMhg8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5461.eurprd08.prod.outlook.com (2603:10a6:20b:10e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 15:31:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 15:31:01 +0000
Subject: Re: [PATCH 8/8] block: drop unallocated_blocks_are_zero
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-9-vsementsov@virtuozzo.com>
 <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506183059311
Message-ID: <abf7b463-6a6f-6364-3483-9cb13d099d90@virtuozzo.com>
Date: Wed, 6 May 2020 18:30:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 15:31:00 +0000
X-Tagtoolbar-Keys: D20200506183059311
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff1b042-c578-4f96-177d-08d7f1d27b62
X-MS-TrafficTypeDiagnostic: AM7PR08MB5461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5461DB60D0752F0B6DD77CC5C1A40@AM7PR08MB5461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOiMTftohI1W7FwxC6t/AjCnUR0ZbjcosqmkdI3kxAv//MgmeH9GGlFmQLa2p/m7iZ81cZGK39XEah6wM4softdivpP56EwE3Licf1B79Cj517hCaoORIxH9jijH3rJlGcWe/vwzFykuFDpNOc+lcYo8mO8ML3jehqtipVtM3q84wGOZtBtsYAkow4QBVu0ANkyDHcm30lPy2yPxb5KIzpI7wX/W215hkTE2xSutv0p8vtGN5vXv+3OyVj880FH0zQcQ5SPk0HStCAufT205fXSekdbS0mR13NEucjo1Xgxzd/ESCpW4Bdb+WQxEyU9pBChqbANka5Sqerbb+vWLRzFZqgbdOsnFxAmMfkJsw171eIll/mTZq23J4ci6DzgshwRHfPibDqE2BiaYimlhvWfGuRY7q74cUrefJ0sSJDCnRK4fz8csFmabJi9mDy16eaftzBoKMT6e6nmb5O+kAHOSvEnJxO9UvgSK5Q4le8Ncwhmnkw3qnESXcHALrRu0tJgSSPq8c5uO5sp797qGKwBLFy1usin/yC1TgPvQki0wpwNujmdaRkWFklAYUItK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(33430700001)(6486002)(4326008)(31686004)(7416002)(26005)(186003)(956004)(2616005)(16526019)(53546011)(5660300002)(478600001)(33440700001)(36756003)(66946007)(316002)(16576012)(31696002)(8676002)(86362001)(8936002)(66556008)(52116002)(2906002)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 39SJ0C/VlPAMoXGFngmI/e0r7oYvp44laFsQeHqq/z6JO4nmbRFjF4EiTwDCXVReSnrYGd98dHmPN1B0SsLSVmyKkvHn/4h9M389mKa1cEYlWtyyPrwcFiiphG/4SoFudxwDguXCiSvf4r3IHkcBYlGgRpop3FGAVEm6i4baglncPET4A3dupz3p4TYZOl6A77ymV3HoO15nLtySsLVNphih48KFEhlC5P3Qh9r2knR4/BKk4ri25iExQdxCbS9ISXwlz1nWNR+RTkhxIRHFDusbte8Zei6AeHFuiPNzQNs7rwgNKirbZDLoIkhz8jqdT5q0bPRDJsfzUJbO6tJKi4iQTMEcqRlkj7ADSI+roxiIjy7xypYPXpDIz3Ol1mYtKG6MNj3MRD5K8Lwr5Y3AMtM5+n9c4vxpGQv+Leg1mEGDW3HsFxwEi/lhtSvuJ+7fERxaGIvniXp2X9orZ7CKSz5YWk+iHD0qcB7s143gzO01a3atDgnxiJq/p/ZJLKAIYzkXqslpijnSOJsmTioTtBVathaXvHDSXOmxbY6nJxJ4+G5ZtfCnqgru6sok3pEkKK1cThy6bFIYfh8SK8HudF46bhkyPiUgPU1Z/6lMHRH7/C+0+cNdcmDOUDgw0ecrvz/HZAqNUJu/M8sTAOnG02ipNpowqq7+aZY4+nmMQuDti4b1fyUWxpodsUvahs/6d55diD6RqGNIezCzoJxUlw969eRCqLy74If7zl2Ge5q4UtgJgWhc5elGJGJCnrlnOnKgf072dk8/Uf2fsgdULZ5569DSwNd4AUXs+FTc150=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff1b042-c578-4f96-177d-08d7f1d27b62
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 15:31:01.2941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3ilMB1nR5KLEz6UovJXOvFuhYZe6aELr2f+c4bk7QuHUfnpIwOrDATCkFvNIZ7sr2XO3QNwFMUmwY15k6ME+f1tt44P+gddDh6jirYR4O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
Received-SPF: pass client-ip=40.107.21.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 11:31:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.05.2020 18:14, Eric Blake wrote:
> On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Currently this field only set by qed and qcow2.
> 
> Well, only after patches 1-6 (prior to then, it was also set in protocol drivers).  I think you might be able to hoist part of this patch earlier in the series, to make the changes to the protocol drivers easier to review, by rewording this sentence:
> 
> Currently, the only format drivers that set this field are qed and qcow2.
> 
>> But in fact, all
>> backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
>> this semantics: on unallocated blocks, if there is no backing file they
> 
> s/this/these/
> 
>> just memset the buffer with zeroes.
>>
>> So, document this behavior for .supports_backing and drop
>> .unallocated_blocks_are_zero
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block.h     |  6 ------
>>   include/block/block_int.h | 13 ++++++++++++-
>>   block.c                   | 15 ---------------
>>   block/io.c                |  8 ++++----
>>   block/qcow2.c             |  1 -
>>   block/qed.c               |  1 -
>>   6 files changed, 16 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 8b62429aa4..db1cb503ec 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
>>       /* offset at which the VM state can be saved (0 if not possible) */
>>       int64_t vm_state_offset;
>>       bool is_dirty;
>> -    /*
>> -     * True if unallocated blocks read back as zeroes. This is equivalent
>> -     * to the LBPRZ flag in the SCSI logical block provisioning page.
>> -     */
>> -    bool unallocated_blocks_are_zero;
> 
> You can't delete this field until all protocol drivers are cleaned up, so deferring this part of the change to the end of the series makes sense.
> 
>>       /*
>>        * True if this block driver only supports compressed writes
>>        */
>> @@ -431,7 +426,6 @@ int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>>   int bdrv_has_zero_init_1(BlockDriverState *bs);
>>   int bdrv_has_zero_init(BlockDriverState *bs);
>>   int bdrv_has_zero_init_truncate(BlockDriverState *bs);
>> -bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
> 
> Doing this cleanup makes sense: there is only one caller of this function pre-patch, and 0 callers post-patch - but whether the cleanup should be at the same time as you fix the one caller, or deferred to when you also clean up the field, is less important.
> 
> If I were writing the series:
> 
> 1 - fix qemu-img.c to not use the field
> 2 - fix block_status to not use the function
> 3-n - fix protocol drivers that set the field to also return _ZERO
>   during block status (but not delete the field at that time)
> n+1 - delete unused function and field (from ALL drivers)
> 
>>   bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
>>   int bdrv_block_status(BlockDriverState *bs, int64_t offset,
>>                         int64_t bytes, int64_t *pnum, int64_t *map,
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 92335f33c7..c156b22c6b 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -115,7 +115,18 @@ struct BlockDriver {
>>        */
>>       bool bdrv_needs_filename;
>> -    /* Set if a driver can support backing files */
>> +    /*
>> +     * Set if a driver can support backing files. This also implies the
>> +     * following semantics:
>> +     *
>> +     *  - Return status 0 of .bdrv_co_block_status means that corresponding
>> +     *    blocks are not allocated in this layer of backing-chain
>> +     *  - For such (unallocated) blocks, read will:
>> +     *    - read from backing file if there is one and big enough
> 
> s/and/and it is/
> 
>> +     *    - fill buffer with zeroes if there is no backing file
>> +     *    - space after EOF of the backing file considered as zero
>> +     *      (corresponding part of read-buffer must be zeroed by driver)
> 
> Does the driver actually have to do the zeroing?  Looking at qcow2.c, I see:
> static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
> ...
> 
>      case QCOW2_CLUSTER_UNALLOCATED:
>          assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
> 
>          BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
>          return bdrv_co_preadv_part(bs->backing, offset, bytes,
>                                     qiov, qiov_offset, 0);
> 
> which just defers to the block layer to handle read-beyond-EOF, rather than an explicit memset in the driver.

Hmm, yes.

> 
> So maybe you can simplify to:
> - For such (unallocated) blocks, read will:
>    - fill buffer with zeros if there is no backing file
>    - read from the backing file otherwise, where the block layer
>      takes care of reading zeros beyond EOF if backing file is short
> 

OK

> But the effect is the same.
> 
>> +++ b/block/io.c
>> @@ -2385,16 +2385,16 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>>           ret |= BDRV_BLOCK_ALLOCATED;
>> -    } else if (want_zero) {
>> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
>> -            ret |= BDRV_BLOCK_ZERO;
>> -        } else if (bs->backing) {
>> +    } else if (want_zero && bs->drv->supports_backing) {
>> +        if (bs->backing) {
>>               BlockDriverState *bs2 = bs->backing->bs;
>>               int64_t size2 = bdrv_getlength(bs2);
>>               if (size2 >= 0 && offset >= size2) {
>>                   ret |= BDRV_BLOCK_ZERO;
>>               }
>> +        } else {
>> +            ret |= BDRV_BLOCK_ZERO;
>>           }
> 
> I like this part of the change.  But if it is done first in the series, it _does_ have a semantic impact on protocol drivers (previously, protocol drivers that return 0 but set the field .unallocated_blocks_are_zero will be changed to report _ZERO; after this patch, protocol drivers do not do that, because they don't support backing files, and it is now only backing files that do the _ZERO magic).  So doing _just_ this change, along with a better analysis of how it changes the semantics of 'qemu-io -c map' on protocol drivers while mentioning why that is okay, would make a better start to the series, rather than here at the end.  Of course, if you defer it to the end, then none of the protocol drivers set .unallocated_blocks_are_zero anyway, but that cost more review work on each altered protocol driver.
> 

I understand the idea.. Ha, it looks like an optimization issue :) I use greedy algorithm, trying to make each patch to be a simple small step to the result. But greedy algorithm now always optimal as we know. Actually, here, making first step larger and more complicated, we achieve less total review-complexity. Good new experience for me, thanks, I'll try the proposed way.



-- 
Best regards,
Vladimir

