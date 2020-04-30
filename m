Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70F8C83009
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952D7214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dwmKGI/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952D7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4eM-0006Az-Mn
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU4dR-00053t-VV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU4dR-0007Lj-9Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:33:33 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:32033 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU4dN-00076c-DL; Thu, 30 Apr 2020 04:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHoMTVG1evbU3kS/sz2Kd4A+jwPLy2ph/1LKNfh9j3n+yJRixm/Qant62OBN9/7538pJxcDFUCFQGnXpeLjgypiOcib/FuUfliEfflorjwCP1pBC+Tg5H/92LrCjJ62ehJR4+0Grbd7P17iDQXNX74XaFL5r7F0RgyXoXM/B9erAuq1GStrDNkOIT6LBwlUCHK3eQpsRAOOSbX/duBT3MY5UTMxG+x5/MPF9GdQ1qiu/fAvU29O3M/e15VlnqLANS+h2M4qArJ59c5MIPygR279j6Zo5wD+N56XYZcbiNKyY07UR5XsNrKOSgnAjufmrwflz6OmmXx9ROmkQeiKhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzSe1ygnoCGzBRZnPz5tP1IK44GMkfA4GV1RiTTN5jc=;
 b=VRGINDKN4Mc09rfdD5I6U5bEABBFIz/AFTOXvTNMqP8iAazg7DyUyl3ISLOlP4AtLWhG1kXUwpYyv2J1y5yyuLqIAukoyfxP53e6FkDyqFR2zTu4QOMKEhU/J3+E2zUV1VwFour7xUBR5VJYFpUUhwGbNQccXC49l5TdC1a+gj5vFflyzOpAiCzva4/jEZoY4Eu5N3ziDWhD16/ihFyTaGdtrcCJB1cVryxDLqGlBDQhtWvTVnIOES9s9P2zzFEjmXsP3sp/6IgBxx6AGfin0e4fg6Vmzq9ZmUJQaKThmVA1ZAEKWEbKDs/yPMj+rrvn8cWshrT+T7SmAYG205LeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzSe1ygnoCGzBRZnPz5tP1IK44GMkfA4GV1RiTTN5jc=;
 b=dwmKGI/2RSgZE42gDBP6QNJJODciKD5MnmZq65XXQQ21dSXOKdyX+EYzgsE5uYgK+flqICRp0LnWDoCHqo0ZoifpMZaeVt9zgBJ04zMvIefv+0vtp4VjaWzLIAMar5VPIupDt5DZ1XzNEuagzpMHzwEkQ6eF720bRLDBWTdOnoA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5461.eurprd08.prod.outlook.com (2603:10a6:20b:10e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 08:33:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 08:33:26 +0000
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
 <5450c309-feec-753d-6eb6-4411e913dfae@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430113323411
Message-ID: <39e332cf-4a03-4ed3-c1e1-fe6c23d6721e@virtuozzo.com>
Date: Thu, 30 Apr 2020 11:33:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5450c309-feec-753d-6eb6-4411e913dfae@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM0PR07CA0001.eurprd07.prod.outlook.com (2603:10a6:208:ac::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 08:33:24 +0000
X-Tagtoolbar-Keys: D20200430113323411
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c83a52b-5091-4444-0d74-08d7ece126de
X-MS-TrafficTypeDiagnostic: AM7PR08MB5461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5461E184D1BE2614280E644CC1AA0@AM7PR08MB5461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXLgkdHMSgndd7709URx2xkd5N1rZgz9LaGXLdVWVIpigidr60J8V62Vg0Spsp2cUvFCMlAYXtC0Y3enkqT28CBqyuSKjbI8DQTzxdWx7qcZG7pCu8wPOSIBID+39HTaBr5AOVN/jq19KzTWUQrQgBcw/4LoCF/Ds/1dkp2n5CXuHRIihX0dJtzr4ilkGoKaGK1AWWOdGYpikEIhuvrgUiyW8142vlQ66fLkjl7Fg1OEaMjpHovIzAD8Q5uKM12f28iyG3s6Cwf+7vLysmAQeB9W6ns/NUkkd/A7oay+n+87uOtnPFvM3DqtqrP1OE7ViP3A6xpMc2EyRVdU6FmAdZTxdGM6nIa++8dNZp4GgaMDRMbPDvZowlUT+BAjtipV39aRV3HyMn+0dxdsEubni075uMYYADB8DEwPNQ5kIBMjeBL0dhVvjm2oly4siSvN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(66946007)(53546011)(16526019)(2906002)(186003)(86362001)(66556008)(66476007)(52116002)(4326008)(2616005)(956004)(31686004)(8676002)(36756003)(26005)(16576012)(478600001)(8936002)(316002)(107886003)(6486002)(5660300002)(7416002)(31696002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iIEfY1C2jwtFvUZKz0dXZAkqnraMohf1zuLG+YHHX7msGqZ3P0vCMYv+gniLDttNeVFHh28uJCMpAMnldJcOrmgJYDnjomvEoEy4Iao1CU+RzNdeWEDJrhy6sA3EbiYXAJ3eCPz0apSuA5fUeBio4zR8klQxKdrPX/590knZsXnxqTZ+hwIR4EEI/E9LtisxDygJZ7O94G5zpOvXYlx4QAgR6f3YMA0cQ52ReBden2kGODa+zbhbCmJnBywnAyJgQ/iW6gSy3ud5F5gCkZIF90t1vTKKBJkV2OBmi/el2BYxrnEYdyQLEX5lS9V1QrcV6VdC7UgEv2+gKw5KNugAGQqkS+m1fyFVAtmlqZhfhTH67PinmJlGo/POuU5Spz0G6AG6LJ0TYQbse5QaNUKC9Xzq7cQL3PndZX6DO19hwrnKdytCKb3w165a/GBL5XBhHJyaKcWwgX8pKpvsIvq+Cz28cV1Uz9FTGipWovycd73pqROeceZk11MB+xmnw2Ycp3YrqB75wa/zhRI24pf5klqQeJZIdVtFyIoaQKWXF4HSKPV5i/VTLTAYxeEz03y4HGTaaH3ja/VP1g2kz6Z9BynrXF0GR27FUNnW9zLqcT4cjw3CRw+A0+taZuQksj+x0/I05ll8Syjzy7RYHLITJCYtGJzaqzwS2RdFnVjc5Fq4Ue6qLhwXzagbcMAJvFlczcLsrSpnXvOBwiL566JOP61adp1H8jIWOFCRH1ElPcxLK/MPbV9zSSIx+gbbf2ILV6g7MYMr1WifSza541bbX2/LWAXVSrgQVe2GCs8iwpI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c83a52b-5091-4444-0d74-08d7ece126de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 08:33:26.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdQXvbxPmTssgNEEa4UmyYvOiUDXOsAfJgYr4YHpjTnMIfEn0zO/Imxe0J9yc+aFB/ZeeQZgzh5X9VTudXQ8QamAsYytxQHF9EGp8qIoax4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
Received-SPF: pass client-ip=40.107.7.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 04:33:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.123
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 18:50, Eric Blake wrote:
> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We are generally moving to int64_t for both offset and bytes parameters
>> on all io paths. Convert tracked requests now.
> 
> As mentioned elsewhere in the thread, this states 'what' but not 'why'; adding a bit more of the 'why' can be useful when revisiting this commit in the future.
> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   include/block/block_int.h |  4 ++--
>>   block/io.c                | 11 ++++++-----
>>   2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 4c3587ea19..c8daba608b 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
>>   typedef struct BdrvTrackedRequest {
>>       BlockDriverState *bs;
>>       int64_t offset;
>> -    uint64_t bytes;
>> +    int64_t bytes;
>>       enum BdrvTrackedRequestType type;
>>       bool serialising;
>>       int64_t overlap_offset;
>> -    uint64_t overlap_bytes;
>> +    int64_t overlap_bytes;
> 
> unsigned values have defined wraparound semantics, signed values have a lower maximum and require careful handling to avoid undefined overflow. So we have to check all clients for any surprises.
> 
> block/file-posix.c:raw_do_pwrite_zeroes() -
>          assert(req->offset + req->bytes >= offset + bytes);
> pre-patch: assert(int64_t + uint64_t >= int64_t + int)
>             assert(uint64_t >= int64_t) - unsigned compare
> post-patch: assert(int64_t >= int64_t) - signed compare
> Risky if adding req->bytes could ever overflow 63 bits but still fit in 64 bits, but I couldn't find any way to trigger that.  I think we're safe because the block layer never calls a driver's .pwrite_zeroes with a bytes that would overflow 63 bits.
> 
> block/write-threshold.c:bdrv_write_threshold_exceeded() -
>          if ((req->offset + req->bytes) > bs->write_threshold_offset) {
> pre-patch: ((int64_t + uint64_t) > uint64_t) - unsigned compare
> post-patch: (int64_t > uint64_t) - still unsigned compare
> 
> Perhaps that function should be changed to return int64_t, but probably as a different patch in the series (I didn't read ahead yet to see if you already did).

No, it's not here... But of course converting write-threshold.c should be separate patch.

I think that if we have BdrvTrackedRequest object, it must be valid, and offset + bytes must fit into INT64_MAX. And object-creator is responsible for this, and tracked_request_begin assert this thing.


-- 
Best regards,
Vladimir

