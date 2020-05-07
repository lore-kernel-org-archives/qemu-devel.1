Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEB7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3CD2078C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tu8B/cCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3CD2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWc1U-0005c3-Bc
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWc0V-0004ud-Md; Thu, 07 May 2020 04:35:53 -0400
Received: from mail-am6eur05on2126.outbound.protection.outlook.com
 ([40.107.22.126]:10464 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWc0R-0004vQ-UK; Thu, 07 May 2020 04:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCxAetQ0UOINj7mZNHpG1CcMd7TYk9f3gWEhpu31aup6peMuJdzn5zIrrqhq56x5BUPK911J+xNTkQo18Rolne1DnRkSK2FxfMGAE2/L8CROBtqyocBaUZljoXYEo+Yq3l/+QzlRKbRoV6LVYdeSZhAJ926pU1Pj11cecVMUjNNYpGJLqd99ZkGFLuk6ZXv6p1WHotkNbFrtq5FTGQnvrI/cndBfQGwSYF+F0RRtcuVgiEHQFXFco87T0piO5JUidlJp6Q7QUNB60mYMGwvcgDN6OT1hNXoFPoPn5RzAIB+xO0B74VZFBCf/CTuqNBBQaCE0ZQ+XUpEKnt+OliOl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlFAnyZl00dQHlUPITIYMXGOzyxg/3td9VI10ocfV48=;
 b=hbvpnnWM5bhlmFXi+HC3xeAawcP7SxoMGXS3OGj8XoAAnBtm6rxUPwf7OQBc+HxlHWaSWYig3YoOj+/UCK5jG2I8PIab/OC6fLPbVZ+1sojMMsXaHqcQtnrkYaOV+hQvUq9Um9Rg+qJojxbEx1AtnZuwW5d7Zk7KbBcG1rZfTWsH3sxNRaqW0yzmb6ZsI0q+wpSYdv2cSgSGiMk8U/bVQH+m7ynTLh5J8OlP1nZrH3AU90wl0ngzHfPxLoJRKwfIVBQsp6G9nCM2+PnYHFbYzvZurwoy5Gd9Ez7x2fxnlfwZ7RUXcRiA7QNMIem92IXnY6CuXfSVwWvU/+L/6pncBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlFAnyZl00dQHlUPITIYMXGOzyxg/3td9VI10ocfV48=;
 b=Tu8B/cCzQU5OQs2Gq7Rq6axg7QN020OvUqsJSmCOUUuGh0xBy/D3jMz17j5nweFOPnOARtNSksfxtydLNPvN7blyA2eKJv8Hpi2tOfs+ahaMZkxTsNBg8YY7IrTGu3BFtM6jJbxe7Y5kvT/OdsfNrnxW+1IAj7/y5oImIQPo+mE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5528.eurprd08.prod.outlook.com (2603:10a6:20b:dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 08:35:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:35:44 +0000
Subject: Re: [PATCH 8/8] block: drop unallocated_blocks_are_zero
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-9-vsementsov@virtuozzo.com>
 <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507113542734
Message-ID: <1420c058-a67a-ec7b-86b8-2f10efb2f1ba@virtuozzo.com>
Date: Thu, 7 May 2020 11:35:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM0PR01CA0129.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Thu, 7 May 2020 08:35:43 +0000
X-Tagtoolbar-Keys: D20200507113542734
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7baebfe7-3779-402e-0f04-08d7f261a259
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5528FA63FACC62368C8F16D6C1A50@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYYQykUeHK6htVzyteAT7eadY3vB9Dk3qznOgso0r0iyucdOQCLgt1BkW2rnCfezfQziwOZ/uXL6eUev1AfEqascJZuaSw/fxdhNog6Oclqzv/IlLJ2AllrmnxXzxt+yWuLgUlvg/sVGzVFnb1wmuA6dLL3ntBCnPEmLo9V2D+beWp+JqMz5YMz1i4tUzmbtLkSj3e7/jyCDOl5vGvN73WU+C7OZddLxGxP517brnuBoTA7Au+KTNAfPP50iaGZWCCcKzqdmdh/VsNj7C4TBNlrYRxDecCOwwPXnXxjPW6WPaucuk4KVbxHRYrZdvvKyrH5a54r7XtXzBJjWmRcnEdDdV0FnbK/OfAuJBhFn/U4ajJUaG/BbkSkq2iFaJ5nC8yYINxoFlv7IytJH0v41sjpAIQitBv71hjd/bzWv2cNakxvizIlK0LSmlbdMOaMNfl8LeAgtqnQSHqcRgooM1VWgcer/fDE86yVQ8fF3b1vDtY+m8UK34SmHg+dh8hE6uGQJrw0SQtPIVwquq/BAGG/yJpCPMyBA43cFZUb6i4YjlMWP8VieQ8tbFUOZlp73
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39850400004)(136003)(376002)(33430700001)(5660300002)(26005)(316002)(16576012)(31696002)(31686004)(6486002)(33440700001)(8676002)(4326008)(478600001)(8936002)(186003)(86362001)(2906002)(2616005)(956004)(83320400001)(16526019)(66556008)(36756003)(83280400001)(53546011)(66476007)(66946007)(7416002)(52116002)(83300400001)(83310400001)(83290400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +fbxopjTKH5pVce6NEU4V9/h4Wlsnr4DSn9oRjgCy8wBBjnP9G4nvny5QlOmX1OiNVLsTQ+TBX9etvx+3SLSMBJwETTeW6Vi9OXXJ7NHaMvK1Tgc5xCqxy0po7BU39K3E0LFME4WdpNWyPtdBVw1zgHQ5XHJZGXDEU9dOZ2Ydf3hrdPuxyHH/TFKLFtuloF+hvhymThYwO496kmuyiRH8AFxHvl5oFnsC+pzr5uTh0CU+A40MnhbIRyPaqRy7bRzqnT7sWdNcqBt6iSHZYblB6A2eTA7U5qCkAf48UmshEFOzWP4oNjZ+fB7hFUce14lxSrNwC0DF9Fz/5iEGnvCwxTrdCyilXXBtggDqTtuq8uMpx1MrQh5IwSCNbH8vTo31LP5LqpimE0bNc/NLhhPFvXecsudUGV9FmvlHFAcvd6jBhM4Cb/oEDTmWNWhmDjz8vqIVX7dY4ocMABBLTGY28QJipPkF429UbQZbDEVkp/8vCUfuqws8tKsxxDcZ25MvdS3JWeMBmZSqBoHxcrb03o2fPC2No7xczHa6B2RSV9poaFjk1mexl03rOlcO57g6qdySIwURuvMmeec4GoLHUUVNjPRYojXoXTKNx0SYmSVZ/a1alHKoPWivPv67PEQuyyi0r/VEdwEk0OwKslWcb9xAS6xKHKQMl9QxiUwnXPTm193y/WIe86HfTEFiVsze3oYEr9fqH9Ieg35Jik6JduAkOXZBEFJxP+wXMsBUZHAkG+0foLMQ0ESqh4c9joSZvmF/VhD+5GsBXDdFxHIZeCxfaWeTOBXUKJ4FCKGkOk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baebfe7-3779-402e-0f04-08d7f261a259
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:35:44.7073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY4GAIkUsvlspGtGS8sbSLParPdy57Vbg9x9ko8ndRtk/Mrmzny637Z3a7Xqto9dXm98CFzbCVW8eFHlkv5YzaehxO+uv6fNT80A8oLXdII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Received-SPF: pass client-ip=40.107.22.126;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:35:45
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
> 
> So maybe you can simplify to:
> - For such (unallocated) blocks, read will:
>    - fill buffer with zeros if there is no backing file
>    - read from the backing file otherwise, where the block layer
>      takes care of reading zeros beyond EOF if backing file is short
> 
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

Doing just this change prior to patches 1/2  breaks final BDRV_BLOCK_ZERO produced for vdi and vpc.

-- 
Best regards,
Vladimir

