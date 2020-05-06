Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E92C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A74D20746
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rrsEcAXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A74D20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLWr-0005fT-D3
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWLVq-00058q-Aj; Wed, 06 May 2020 10:59:06 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com
 ([40.107.5.103]:2894 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWLVn-0003Zq-F3; Wed, 06 May 2020 10:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxDvWQyqSFaAYl//elh2LntiCINmuH78/JqAiTRt0OLDDcO68aNjLT2rMuJl1j+LEIw5TJOwQao6lgqbPxZdqb4WGItwXuu5fT44QZpYVMk7xj9wqcyCxkuJChX3CdXSPMYNVrGYOzNTYhE7XV6IKNwP+9hO0SbS2bqucgz3mjecEr+Zw7uV3BYh55fUWumT0n3+2iZVC/wHJRHJBc81XZ/CymVNABfPisQSf4pqVSOtRajUuGHnjsbgLC1o2j+QyaV3IG/y9CxyWhvX5wC5ABpbTiVCPABe1EbBi94x8+A0Cry5gRi5LmIaESPZi/gz7iTEbrSxwV0O1qT6R/XH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGhsn+MCiTSw4o96jc5+rnuh8Ap7jrIlX6fdNmtw6qA=;
 b=HQDHrl5Khd80Vr1e7QoClYs7dBmwdGJ1w4rDg1CvFt04RrU0xiFpvBFqyy4jNVn35HiHBGifpStZjpggcaG03YcilYEe3wE578nJbE4m+eJsrfSQVs0nwE6eTar8tPW6n7D2OyRQFZUCB3STcRdU4/UI2M62zstuaNaCSygVoC17bRZf1OZ+3c2DR765xucidTac/Y1bEwckdYrUo5hvQfA9jx7ySIwpsShVKipVO0EHjsoNbCVCvd/K5ULlMI1xSG95m3lTvh4hzfoeoCOVbKXfThfUVPcw3ODFJOz056XwcdsUM38G1XyDFMxUwc7MzWiC6UKz7FBjT4ZUI9WRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGhsn+MCiTSw4o96jc5+rnuh8Ap7jrIlX6fdNmtw6qA=;
 b=rrsEcAXupF8Y/m5lw6YkqF+jJI5xfSvBdI4oqTe7ACKMbaTl04QVi2L7PzRz28merdxS7/jwboF1xACpbRMa2F6rCCCUwfDI+ODCW1t6WBfwqBmXmziCmvAt25eur0yQY61y+ksvZx1gaJQYoMk9Soe7j7S6dnqNXmWs45tj3Gw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Wed, 6 May
 2020 14:58:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 14:58:58 +0000
Subject: Re: [PATCH 7/8] qemu-img: convert: don't use
 unallocated_blocks_are_zero
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-8-vsementsov@virtuozzo.com>
 <6e430529-5fe1-65de-6e07-6176d0d9a201@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506175856842
Message-ID: <09fe1e55-ea75-9bf2-505e-15088cdec9e8@virtuozzo.com>
Date: Wed, 6 May 2020 17:58:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <6e430529-5fe1-65de-6e07-6176d0d9a201@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:208:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 14:58:58 +0000
X-Tagtoolbar-Keys: D20200506175856842
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe5ce7f-2a41-4dc4-a612-08d7f1ce0196
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5302CBAE6C5C1B849FE1D5A1C1A40@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnm//jzg6FmtovO6/EFWadEm4fB2k7VcKPvSXEO/mrnrJkOrU42nSXJxfWfv5MMhi8SdeO7H1U3mujDXukQ7W3IyhX8vuyXxu2tbvccnDq+8Bq0vauWkc4SRBIWNomRHKoMQqe9EKmL+0W7pNCv4D4eRLRZ0wRESvaB+NKRLlJ9JAUSfbnI7DZaVm32TxQzcSwgGMrfm1hQZo3S/GExwRI5x6frmXnyXGjJ5wFAnbvCImKaNy7X+yEENcD0gXUBHfXYO8rxwqOrulQmSHXfGF9euyYBlW1TKf4H05NiFKdvthCD7lGebSzr0p7GgxFsjWV2jEmT1N4ITPuMspZZwTauLwZ376ewZJk/QxSvSFSgHL/pU3KUE6YXJwqAg8+fPB7aOanbvZyicun0ZE2xOH80yTu5ejWe5cdytfcoNkOsdQjMp8E/2oSi7HoiAFwPdwrOSydJXFXuAvlrWsLRvkb4ggQiWd8s7YWJLRztvs6ibFSWBXpeiThhTSALnO72tP1BOcdElXhQ24YiEjZepojMGAy9urJbHRPhHpEFYN6Q+FaX6OpLUozB3fjXzKwZt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(33430700001)(8936002)(956004)(2616005)(8676002)(7416002)(4326008)(16576012)(6486002)(31696002)(5660300002)(316002)(16526019)(186003)(36756003)(33440700001)(26005)(86362001)(52116002)(31686004)(66946007)(66476007)(53546011)(2906002)(478600001)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2R3U9g9hX1HR26++5rG0bvwtzp1nzDQ8VFhv83tzlUxQ1S86jcCLKtLrb46sB8rit+fRbCEf3Y3fvUhuhSn+MFinbry5WJelV/x65T5ye0lwQFinBLcHFqfc85LRNWAeJhPyHF6AsyC2uEJWhXavo1FVOiSX6asWOU/9yI1EkxtY4mBmmK/HN66e4irv5mib9s7POBmhY7yZDEMJe5WeRB4mre/Gs/oZhtHujWZQ0SzHnv9q22cuX58g55Z/+JjyP3TIDUpCFYF6+z9ocSzMuGwftzxAXwiXnvD0d5O8cTa568kHnvm5e54W9QhgmMEdKPv5wfbSBr325SCY8sMIEuqEGdpTEJZQTuKEjI1Ns3i1HTM+kaKNwTMIQzYjuSCuLiDdQ1z5csV1LqNeteV3XQK7Z5rKQNraVFXC2NTZqZHcC9OlOImdgxi6iocXFcFpke7fBtpMQy+3dFXj0GDx4YUi+s6/0fNY3CZFb9cg0BFAo8gLFfbHr6eybHRY6nz/fJVkjBkxK7pGp4u54k9cZ02kYF/T07eXWOnfFo95VJGO0rxcrGMtu9tqeQoLj+QiH3rD2OOWKbTf+lxaPYmZE3zHoq7LfyNfClP4DnuQk4u3uzR11+DpdCQCjRv3VoZ4Sqx1Co7SDnTM69cnpxIiUIEmVB2aoMKZWOBK4B5aHnqIm81o6zmAA0dBA5K1fyCwmrPh6vnF/EIZ0H/x9OBgLEMXY4Y5wad0BGk4xXYMS8Mp3ppHzpe6K5fcv2itOGYhC0iVAcntIYUCeQtFID4PBU2JvjX1LUWGG1FP/kx59Yw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe5ce7f-2a41-4dc4-a612-08d7f1ce0196
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 14:58:58.9437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqXPKhZC9X8P02U8MgRFmvTgbjV64la7mxt+176+xPDhHLsKxEFqpyIo3lx7es7Gn+eE0iEY6277g1WiZi9bTz08SDn7iqKPVFcUx3Pf0uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
Received-SPF: pass client-ip=40.107.5.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 10:58:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

06.05.2020 17:49, Eric Blake wrote:
> On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>> qemu-img convert wants to distinguish ZERO which comes from short
>> backing files. unallocated_blocks_are_zero field of bdi is unrelated:
>> space after EOF is always considered to be zero anyway. So, just make
>> post_backing_zero true in case of short backing file.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qemu-img.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> This patch should come first in the series.  It would have saved me a lot of time in reviewing 1/8.

I'm sorry :(

> 
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 6a4327aaba..4fe751878b 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1632,7 +1632,6 @@ typedef struct ImgConvertState {
>>       BlockBackend *target;
>>       bool has_zero_init;
>>       bool compressed;
>> -    bool unallocated_blocks_are_zero;
>>       bool target_is_new;
>>       bool target_has_backing;
>>       int64_t target_backing_sectors; /* negative if unknown */
>> @@ -1677,7 +1676,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>>       if (s->target_backing_sectors >= 0) {
>>           if (sector_num >= s->target_backing_sectors) {
>> -            post_backing_zero = s->unallocated_blocks_are_zero;
>> +            post_backing_zero = true;
>>           } else if (sector_num + n > s->target_backing_sectors) {
>>               /* Split requests around target_backing_sectors (because
>>                * starting from there, zeros are handled differently) */
>> @@ -2580,7 +2579,6 @@ static int img_convert(int argc, char **argv)
>>       } else {
>>           s.compressed = s.compressed || bdi.needs_compressed_writes;
>>           s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
>> -        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
>>       }
> 
> My question in 1/8 about whether we have iotest coverage of this optimization remains, but I concur that the block layer takes care of reading zero when encountering unallocated blocks beyond EOF of a short backing file, and therefore performing this optimization always rather than just when the driver claims that unallocated blocks read as zero should be safe.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir

