Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902FC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A202073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kDaP5Y/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A202073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4Sd-00078I-IC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU4S2-0006dc-2j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU4S1-0000eL-Gw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:21:45 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com
 ([40.107.21.100]:22112 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU4Rx-0000cy-7v; Thu, 30 Apr 2020 04:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiUAB7jAItRe+ouYPijuwCcnQwspNe3ymqF3rvUxylXdm8T6eYU7LlHnu1Rc9as5K6/WYp2A62LQZ04I8U6Q4oYtaTUulUbTT2ZAQjeBKuQoPNBpx2NcJ2VP8eNgopEuHsNNAeMAHF0GaanbDgi3nJ2sQ1VsWfBnmAc998gAiEr8Xis+bkP6cdBeIrPsnOVgcMY+Gk7kRX8VG5Jqc0eULRxvtKhCVHCpdTKX5hdbCCIEqDsi//w3QGJu5Rr+sYWg9boEQKPSmhsEsuJM7wFxK8Y0ssTFEJqeTGVGKfJD0CX1euCJ/PgVSpMNWj4mYFWzpyDKp6Xl9enPVOk57Aa59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm/O8NEhGVuURPxZyB7qwvd7Lr7Z66EcX4ci/mgtSHU=;
 b=iUi6jge9hboRVw2DQR688+w+SSZzNL9gktlwzigSouc6w5k3a1txKGQBk8fj9o37d0qdp7UYm3Gq4wvCgGfQTBmOpUrrXAr7B6HabVoawX+gqTwPIAXFMQrYj/qquBk96VBqUjAVmmIh1MESwLnoLPWPcVs/JprZI5boW8+V7nB570hkwAR0jJEiWB8Rys2FPlPG/IXObgKJiEgGSzF3ZmfsRazNIgwtnaJysCD8eErWjv82Gdi/+dlhwPbkQo1MgWXTd9M6qq2Cz0nO0gOD6yFVU2wlsYWzatGCs10v/QxB060j5r6FUxSCyyteOmqq0TnajggEmCRZYNTohE3eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm/O8NEhGVuURPxZyB7qwvd7Lr7Z66EcX4ci/mgtSHU=;
 b=kDaP5Y/mlDeCAMAl45anskr14ixvvAfV2xdDRa/DiVcyg9S5/InRlwv3AYPgLw/kx2sezaAmFtbGZ9JARp2q+jOxIu0jVSyiitO5wn6vdieLKUy+uGrh1fmtdtZFhjK7eU+HcODx7M3QEbnatK6R/SwEgqfmoCeT6K/sOeyvyPM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5509.eurprd08.prod.outlook.com (2603:10a6:20b:10c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 08:21:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 08:21:37 +0000
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
 <5450c309-feec-753d-6eb6-4411e913dfae@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430112135749
Message-ID: <f012cda3-097e-00fa-df4e-5a291eac14e9@virtuozzo.com>
Date: Thu, 30 Apr 2020 11:21:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5450c309-feec-753d-6eb6-4411e913dfae@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 08:21:36 +0000
X-Tagtoolbar-Keys: D20200430112135749
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27496d96-ba28-4e43-ba5a-08d7ecdf80a1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55098C952971F58A8D7DDD0BC1AA0@AM7PR08MB5509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp5PLthwOMSsD74wM02OR86WtXaz+df3gLtYm8Rm3mS+e/vqfCFqCx2vmmQp4Hff8zUD/3mJfk8B126SgYLHPSeddNKgEQl7fFlcUmSksnWezcOccl5SqodKtsFchRWzk8xe2/DgmqVxFMDBWQBczD/ni/F3RNYt0n+lIfobTOPYj2pIfQoKr67N3geEuBIhtQKyRE7cSOrrdiRoRcjJ/cuIWywrhXCnb73zlGMjvrGTaWct+FDgYGQ9fQU3Xk0BCr/M9ZkDoGH+iuC/QXvOf6njzFwmroFlo7txtbWOJ3mbMtKb08XLG8nPiPSJHIBx/nAbaO53/x4QFiZLEOYwLwJS6EsHfhzegsYPiCoSEwK7Y63Lz47hy8kccXIyFIaci1IMgvly6JLlYEFXvLYeaxBzfvqNCm/yp/Tj9OnUILdXHtug3pVkkmGAecDbE/hW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39840400004)(346002)(316002)(6486002)(16526019)(53546011)(26005)(8936002)(52116002)(5660300002)(4326008)(31686004)(107886003)(956004)(2906002)(36756003)(186003)(2616005)(86362001)(66476007)(66556008)(8676002)(66946007)(31696002)(7416002)(16576012)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FEId6SeD3T9y1funxLyDQV0+LzvhBKiVR2r8kFa2Bbg2bEuZjlZcbJV9LleejyEm8soRpt8KYEhG0cBpT/Y4BHx5jyqmGgY8tX5/AjI2oS1xa1NtJfRpGHXQPw+hZaZzsP/a5yr6RBciSdvm9zDINpfgCVLjw1tGcYXsALzqs6JzbkiMgJGLTv4yo3WqrqYGcHLqwMTgPKH95dYTojDIYy6lIgBnwJG0gT6L43/dWTfliCgOuwr74LMdnI3fkSYo4zhcM9GUE/nFCXzzYu68qD4O4pOY2ktdyNGI3COjLL6NBhzD+jnVXySFchIBE5/MWXk801r8UArZEryiiW9PnXrvPWdDLpA2LR8OvK1Q8p0iF25Mts0SOh2QIcn7nU7VR6jakV244OiE6tCRIHu6ccS9y6W3azmqaNMuLa2gtHI4f5Swg0WvED/eZYleTQiIl1WutKGJTusgHU699BiErORrFvUiWKBKmbxQrIvAKDZ6yOB+NSqWEsc3LPkBwK+n2U2HRxM9Vp2A42CU9clF5m/IsE3ubjFKmWJrrNqUmmLJBjxHjE1Oh2KWCj+yxJDPnvhc2HZSpbdbfbW0t8JMn+yVvgMp3ZwyVuyF5hftPO9JutTEz2WD/RXlzgwDRyGHA461mQeoC53zppsZrqWvRnw4ToNXN4R1TlNOMrL1euJFreQYr80R75BtthZROQKixd3GoZqkmJKQjpnrCCqOe/QKUYZV0IXC8kgYklA26RmhtUFsBUTQBjDET3WufeAEZggt+Jxzo40CVmrlIpF1OmByNmjicitbg8k9Gt1HUHE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27496d96-ba28-4e43-ba5a-08d7ecdf80a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 08:21:37.8588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgWOXHuNhCv0lu5m6TJYnZMvVTMBYALErQV++YER2vdmDefQQm83mvdCrSTY/Q1HsyS/d091QBtw31NJTTgjZc1V38OwCck2zGY4tTM0KBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
Received-SPF: pass client-ip=40.107.21.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 04:21:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.100
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
> 
>>       QLIST_ENTRY(BdrvTrackedRequest) list;
>>       Coroutine *co; /* owner, used for deadlock detection */
>> diff --git a/block/io.c b/block/io.c
>> index aba67f66b9..7cbb80bd24 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
>>   static void tracked_request_begin(BdrvTrackedRequest *req,
>>                                     BlockDriverState *bs,
>>                                     int64_t offset,
>> -                                  uint64_t bytes,
>> +                                  int64_t bytes,
>>                                     enum BdrvTrackedRequestType type)
>>   {
>> -    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
>> +    assert(offset >= 0 && bytes >= 0 &&
>> +           bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
> 
> This part is nice - it makes it very easy to prove all other uses of BdrvTrackedRequest.bytes were already in range (both pre- and post-patch).
> 
>>       *req = (BdrvTrackedRequest){
>>           .bs = bs,
>> @@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
>>   }
>>   static bool tracked_request_overlaps(BdrvTrackedRequest *req,
>> -                                     int64_t offset, uint64_t bytes)
>> +                                     int64_t offset, int64_t bytes)
>>   {
>>       /*        aaaa   bbbb */
>>       if (offset >= req->overlap_offset + req->overlap_bytes) {
>> @@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
>>   {
>>       BlockDriverState *bs = req->bs;
>>       int64_t overlap_offset = req->offset & ~(align - 1);
> 
> While here, should we use QEMU_ALIGN_DOWN instead of open-coding?

But then, also s/ROUND_UP/QEMU_ALIGN_UP/ for consistency? But ROUND_UP is faster. Still, we tend to generally use QEMU_ALIGN_UP everywhere.. So, may be better to refactor these thing alltogether in some good way. Maybe, add ROUND_DOWN macro for symmetry?

> 
>> -    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
>> -                               - overlap_offset;
>> +    int64_t overlap_bytes =
>> +            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;
>>       bool waited;
>>       qemu_co_mutex_lock(&bs->reqs_lock);
>>
> 
> Looking through uses of BdrvTrackedRequest in io.c, I couldn't find any other surprises (it seems everything starts with tracked_request_begin, and while you did switch between unsigned and signed, you did not switch width, so it's easier to reason about once we know things don't overflow).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> 


-- 
Best regards,
Vladimir

