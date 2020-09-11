Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B63C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C607320663
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rD6Tn0n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C607320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGg9g-0000IF-OI
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGg8f-0007oW-Iw; Fri, 11 Sep 2020 06:18:41 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:64643 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGg8c-00074J-Dt; Fri, 11 Sep 2020 06:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF4ZY75dwwUDgsssU4W0RsLJ4Z9+vTX2SSLMB1pFumjO59+kziMtAx7O3otbIImc2zivyaKKzkgt9aW2LfoAAMkxVIFfFcO9Zw2ijQSQJjuVN4Yf03dF7nR7EAXGIqDaVtTdeD+1+hNuG2v7p45IhYPtopOtFIVAt0gDUWvU1CnbXdPcehFcbDSC+HEfePpHhuEq/DS7meoNsSjrnOYFZyRpv7lXKanq9oljUfuda/71QqjB5aEVinjbdD+fS22M/IyC6Ywd74cJX/NBpRA40J7zI49wfQo78CXbPM0iUThS1vE3+z6LdB1lrvWX1sn5O1MVjstzj3l7p+sUo28n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtvD1PK7g0TRxYql1DOCK6MVly9x0QkQkGr8iT7KR98=;
 b=jDLCCVNiA76rNCntA/gDr0V0yMA5VUudplSb3c8ZMfOlzF/7N7hdoj3WWDczTC1UgXKrxmSa/GbZ8IZ5vJrQZZVfRCKW/rUcr5yCtJleseRCVXEjBxPRP5pbi349TzL/Np38QO12kg8gJh5gaYmyg6pt2o4qoIeI5LdDjJi9Knj7i+zzYB75QXA6uykaz5Oe9+3/VhreaGM3k0XaZ5ETVOTRoqYSniKjVWRoIHKz7pNovjj42845DwrdN9zgfvT2E3J8i8puy2BPuWT3a9TyOKmbvpbXmaQzgNTvk/5C0ZHIqCWMgzsydamSzhAdos8qP15vUH9OEecauW3Ia61RAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtvD1PK7g0TRxYql1DOCK6MVly9x0QkQkGr8iT7KR98=;
 b=rD6Tn0n1+bBfEzpdISQjgKIVloQtoAzYhoEUbgLfpsJWQy1M4fN7y2oagJR8M+1iOXTqXnbQ9n4NjcIGRHEdfE9ZpkcaxLpZXNV2hcIKGt9STFTukEYG5xh3pxeB1j9rEeCsFmExaz+L2ll1Z66zjgVHEwWTW5h3R+6xWRYbJdU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 10:18:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 10:18:34 +0000
Subject: Re: [PATCH 11/14] block/qcow2-bitmap: return startus from
 qcow2_store_persistent_dirty_bitmaps
To: Greg Kurz <groug@kaod.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 berto@igalia.com, eblake@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, ari@tuxera.com,
 mreitz@redhat.com, kwolf@redhat.com
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-12-vsementsov@virtuozzo.com>
 <20200911113838.482b062e@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2d8099d0-c04c-8b91-fd1e-f988cbba14ce@virtuozzo.com>
Date: Fri, 11 Sep 2020 13:18:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200911113838.482b062e@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.150) by
 AM4PR0902CA0014.eurprd09.prod.outlook.com (2603:10a6:200:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 10:18:33 +0000
X-Originating-IP: [185.215.60.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb625127-7808-45a4-21c2-08d8563c0a23
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-Microsoft-Antispam-PRVS: <AM6PR08MB29821DAC70609B342CE89966C1240@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ls6DS2UrEysl7fPbSV94r+7lyLEsd0f92EX9Mh8T5haLM9r1VbhwkfZrsha2EJPCE9qG337f8HS3bRPcrpVVRFySz2F8WYxXbzuUlBsGplnToSnze+xKPYTdn5lHS0Z55KmANMZTmFlmmdLsgrkQnORZ6HhKLApvJYVQ5E4H8/wPqx7QmEykMs/P1UEHb9v7e6aeF66dihe+NfBu+sDbMr/z6O1HKedxutojUTqVv5nLab9kapz6u/eBhPalzLWOIoU/Ey7DTUGS4lnQLT/ahJQibpY+2X+c1Oh3zA390Pu3vf7Dwtmlb0TslwDfW5HGUYVR04xIDbE2C8RSqooIMxew8i1KGmPf3iI6Rp+uVwWQXh8xOu6D+7icN2CuA7jTZP7c+5rxRBnb/jxVTNPpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(376002)(346002)(366004)(31696002)(316002)(66574015)(5660300002)(8936002)(19627235002)(66946007)(6916009)(66556008)(4326008)(31686004)(66476007)(956004)(86362001)(478600001)(2616005)(2906002)(36756003)(16576012)(6486002)(7416002)(16526019)(26005)(83380400001)(52116002)(186003)(8676002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4KPvCCn/51MSbbNof8hmxez2YuQ/dffXAIsTpUljkzpWCuy+k0aLhs6UgwMzTVAecb+OeqynD4d0QDCARENGR13GJCt+3gQrAYB/iQngf32yCNswSVYHjmu4l7nuVBdHe2IOeFahStOxXJOSyaS5LsCoG6YQNka6+a23WWDA9TV7HpUqcB4/KltJ5y6O1nMXXkMDEv1f7efooQ7ClcH7zht4itJN/TNef2jxl/Z2o3uaHcL/Hpig5eSgyd/xGvHTRyJ9xLGSX93GbVxyZNhEBxL18qLSyHhgAAyD/QWSUQpm2STQuMFpFsiQMvEJQnnjAGdRe2rI2+jyC5C0YMGc+5X43NlUjptsNFPqrEj6uvWHk4U/eXaKMkZHGheHiYj0qgkES2+5L9OLF8mhdJB7P0zCQCPCT+tczhY3a9sR07oBCNxhhEs+O8uboNf2J3T211qfeFc6cyRf1QPXGT0s0gA6AvZT5J21riLGSs8J9xmLnsCUpsNoQaMGC5BbCVowY7qJ4XI0LrDIAVweKPSbnKwELqIoXjAx5jrara8YJOhXM2WG74npIhnd1ipGpPY7W41rduxNZjxZWnCb9Aj5LXH5VpXZ7/Tspwl4uiGthlYmT8N/QBh2T7/wtr/wuBR37dAtOwp6hf/5qhFhUpxpGg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb625127-7808-45a4-21c2-08d8563c0a23
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 10:18:34.2529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE5qFRfZ7KcKno3p7RREQmwmOl9e5J1KVXqOrM8EDKvg+ieGbVHMRuOQyT2r1n4cGdDFriGW820RkpOWJP7YKj1ddMxTF7qlRy6o6UxojUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Received-SPF: pass client-ip=40.107.1.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 06:18:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.09.2020 12:38, Greg Kurz wrote:
> s/startus/status
> 
> On Wed,  9 Sep 2020 21:59:27 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
>> It's better to return status together with setting errp. It makes
>> possible to avoid error propagation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.h        |  2 +-
>>   block/qcow2-bitmap.c | 13 ++++++-------
>>   2 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index e7e662533b..49824be5c6 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>                                   Qcow2BitmapInfoList **info_list, Error **errp);
>>   int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>   int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>                                             bool release_stored, Error **errp);
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>   bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index f58923fce3..5eeff1cb1c 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1524,9 +1524,10 @@ out:
>>    * readonly to begin with, and whether we opened directly or reopened to that
>>    * state shouldn't matter for the state we get afterward.
>>    */
>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>                                             bool release_stored, Error **errp)
>>   {
>> +    ERRP_GUARD();
> 
> Maybe worth mentioning in the changelog that this ERRP_GUARD() fixes
> an error_prepend(errp, ...) not visible in the patch context.

Ah yes. Actually this is occasional thing I didn't want to include into this patch
(and int this part I). So we can just drop it and leave for part II or part III,
or add a note into commit message

> 
> Anyway,
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks a lot for reviewing :)

Hmm.. With this series I understand the following:

1. It's no sense in simple applying scripts/coccinelle/errp-guard.cocci to the whole code-base, because:

   - it produces a lot of "if (*errp)" in places where it is really simple to avoid error propagation at all, like in this series
   - reviewing is the hardest part of the process

So, if we have to review these changes anyway, it's better to invest a bit more time into patch creation, and make code correspond to our modern error API recommendations.

2. So, the process turns into following steps:

   - apply scripts/coccinelle/errp-guard.cocci
   - look through patches and do obvious refactorings (like this series)
   - keep ERRP_GUARD where necessary (appending info to error, or where refactoring of function return status is too invasive and not simple)

3. Obviously, that's too much for me :) Of course, I will invest some time into making the series like this one, and reviewing them, but I can't do it for weeks and months. (My original сunning plan to simply push ~100 generated commits with my s-o-b and become the greatest contributor failed:)

The good thing is that now, with ERRP_GUARD finally merged, we can produce parallel series like this, and they will be processed in parallel by different maintainers (and Markus will have to merge series for subsystems with unavailable maintainers).

So, everybody is welcome to the process [2]. Probably we want to make a separate announcement in a list with short recommendations and instructions? But who read announcements..

> 
>>       BdrvDirtyBitmap *bitmap;
>>       BDRVQcow2State *s = bs->opaque;
>>       uint32_t new_nb_bitmaps = s->nb_bitmaps;
>> @@ -1546,7 +1547,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>           bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>>                                      s->bitmap_directory_size, errp);
>>           if (bm_list == NULL) {
>> -            return;
>> +            return false;
>>           }
>>       }
>>   
>> @@ -1661,7 +1662,7 @@ success:
>>       }
>>   
>>       bitmap_list_free(bm_list);
>> -    return;
>> +    return true;
>>   
>>   fail:
>>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> @@ -1679,16 +1680,14 @@ fail:
>>       }
>>   
>>       bitmap_list_free(bm_list);
>> +    return false;
>>   }
>>   
>>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>>   {
>>       BdrvDirtyBitmap *bitmap;
>> -    Error *local_err = NULL;
>>   
>> -    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
>> -    if (local_err != NULL) {
>> -        error_propagate(errp, local_err);
>> +    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
>>           return -EINVAL;
>>       }
>>   
> 


-- 
Best regards,
Vladimir

