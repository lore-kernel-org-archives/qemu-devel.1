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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419E020659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iw1L04zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419E020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGhQF-0004W7-Tz
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGhP0-0003qb-Ug; Fri, 11 Sep 2020 07:39:39 -0400
Received: from mail-vi1eur05on2131.outbound.protection.outlook.com
 ([40.107.21.131]:24160 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGhOw-0001w1-C6; Fri, 11 Sep 2020 07:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWlPpVC+MeWnXxJPz9gtw/z1RG+IwB4PVtlka2klYvJiUfl3cJbHmp8f8X4830us5oo/J3718hQbWPugGx4LexkcQBt9/xsVPlH9Mp0YNh0is8KXxQcOnpyROIKH8kF2AUjxfZrNs8ADjCpN7bfFSI8WUN0m0tw6ldvCQOiJRP8HqjtsdSYa9gelcA/NU7wBlgoz2Fs41lvfgss7S0YcgrYaMJm/fRl6eTtG8RXmAN6DUliltfJCZ+jPFUtjqHCU/0tgS7u98vW65QWpEM+iBntZoiXPjTMIai28Qk7e++CFAi5OQy2S8anN8aA1jdTe2So2WGGGltcrUbb/UXNblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uqDZo1gR4HyjMgra6o9C9POPiiVdGJta5rKNzbGt90=;
 b=LYfR/LBKogeKau5t+qVduRtPaqoOvyZy8RwzftYh13cwiLvlyo0gLfLGkrQJKaghapLs90jCf6WvYoLQvEl+MjSvtEm42ZtueCOkL06yZmkAh6Trv2iK+kev/OL3zxK6wbUfpAUocn68zVXNk6YY3SB7A+uCeFA0fokZZqXnVi0/NQT4/2wARfpqw9zJJA60VevbNV4D9EkXb1AMQCVtudPaIPQ8tNzdR1WGTv6NSSU739NpqjCjKphZ0Q+t8TE8UGB/bxImdtSt3TxKrKp7MK6m3CVLM0DecQf+y1Mh5rS6T5x8MX0ivpUnhxt3RRk9AlYz8xEqJlx33PArIoKflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uqDZo1gR4HyjMgra6o9C9POPiiVdGJta5rKNzbGt90=;
 b=iw1L04zBh+maY0BZDVrgSrV8graCPJUdvll3Ri5uw63YGWx6Ou6KUDmP1N3HZol0V7/+Je4N/GxHaQ7OsEDDiotceYApYQWfwX9vklrA46wglYc3Xl/hC4Wq212ktiD7gLHO638FdSXzb7xmaZbss73imA0P/wm5LwffaWQ4efs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 11:39:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 11:39:29 +0000
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
 <2d8099d0-c04c-8b91-fd1e-f988cbba14ce@virtuozzo.com>
 <20200911132152.01855289@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <12a7ab93-6545-a221-e9ff-4328c781fbb3@virtuozzo.com>
Date: Fri, 11 Sep 2020 14:39:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200911132152.01855289@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:208:14::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.150) by
 AM0PR03CA0016.eurprd03.prod.outlook.com (2603:10a6:208:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 11:39:28 +0000
X-Originating-IP: [185.215.60.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7cf6f09-ee20-48ce-40f9-08d85647582d
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-Microsoft-Antispam-PRVS: <AM6PR08MB2984F1C433A20B95F8E2B8C5C1240@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e46LPQFod4oW6ACaYjS0MjyetF+0QHqRve5vKh60H116jQCfEOIqoCj/bg2LzrPTXFeUTUwbkgedXS2Olph8dG+C4VdNXFYKo91tP9KVUZfSFxYAP7YQvujTlN6TatFq9VFvX0vW6yCVoQIGkY7u9Gizv0JE2eX3kMdGgzBW7eLC/qfrKm1WqFmoHb6UxdAgY6s9op+SgrDHS88gS/Km/tXEoRq+VxzasMl/ELYjjStoE4XkSOaOTacwBluU2V5cCz5irfj/HviLQdONBjnJPySlG4dwVXtp4O9Yoof9p/w807Ae2xVIHVD5/aXKvgvFeD5Ry4nuKN6Qo926hP3MmnZQJ2Z8bifJRL4ZkyPkZhUr4qznOFzD9zXYoKU3ZNA9waLDZIyg0GvKdbq8y5EvrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39840400004)(376002)(136003)(396003)(7416002)(316002)(83380400001)(86362001)(66476007)(4326008)(66574015)(19627235002)(6916009)(66556008)(8936002)(956004)(31686004)(478600001)(52116002)(2616005)(66946007)(36756003)(8676002)(26005)(31696002)(186003)(16526019)(16576012)(6486002)(5660300002)(2906002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: puAu4+rzDoSORLDCwF39bKE0SDGgokro32iBMz7WYifrxae6R07NXuss+x5dS12m/W7g3NbcijPHVQeKnbPhyEvDW6rg0ogUr9so38Gxw8hm8vRETIGgnQey15y7xsdhfsXwdfUBHhVyCd9vJqsiuHbjIH17wnTDBoNvbqgVI3llXJDf/rBBXFqZ28R8sqgXbyxTgfeCMAxCwx464aBoAkecXs6lKud4VzHh87sRoM7iQ9JHBGlaOd9BuEkjOFIk63FUPvchDPsfjgT856hkkQhVxQ+smwPbf1CEEH16/WCCF4bFs8vgU5vZR+gObsDmxwkuE4nHrD9jILmy18C2BuptAagOuzPvK2U1BqjMN8dMTdsj3imc6bpTRxlQIwKSpRGApv0aSM7/iMR1CHIUNV7KC6k6EBi5sxCy+fcw5AGDGU9Mhd2JBncwrhrXvdxvWx07SrTfGrrdsSG3ohTeioa35CI9eQ8mfFeYVZwk2In6JGDuOj60PRqEYTNPm6Q7dqlKLs0fspbHLe9IL9qoe3H9NE9j8OzmbY0FXpbsM0Er7dRfQ0shF0Q5d4GgfbLDjhZ8xykPLVosOpgw+tQjU2pU8A23iCL+eZudmGYng3zLv01r4fHmf5GUogpd1bP/PtA75sl3mnHeWQq30g3jKw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cf6f09-ee20-48ce-40f9-08d85647582d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 11:39:29.5848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNO0gkRjl5T8MtShUxfJDZum4Upx4pYZ2E2pxpV48Jz0KoN0gZRHA9ONliZWJ7CndPBQlOJL8r52CL760PxeziGnfS2bfdahJk2x9KYg2gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.21.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 07:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001,
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

11.09.2020 14:21, Greg Kurz wrote:
> On Fri, 11 Sep 2020 13:18:32 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
>> 11.09.2020 12:38, Greg Kurz wrote:
>>> s/startus/status
>>>
>>> On Wed,  9 Sep 2020 21:59:27 +0300
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>>
>>>> It's better to return status together with setting errp. It makes
>>>> possible to avoid error propagation.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block/qcow2.h        |  2 +-
>>>>    block/qcow2-bitmap.c | 13 ++++++-------
>>>>    2 files changed, 7 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>> index e7e662533b..49824be5c6 100644
>>>> --- a/block/qcow2.h
>>>> +++ b/block/qcow2.h
>>>> @@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>>>                                    Qcow2BitmapInfoList **info_list, Error **errp);
>>>>    int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>>>    int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>                                              bool release_stored, Error **errp);
>>>>    int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>>>    bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>> index f58923fce3..5eeff1cb1c 100644
>>>> --- a/block/qcow2-bitmap.c
>>>> +++ b/block/qcow2-bitmap.c
>>>> @@ -1524,9 +1524,10 @@ out:
>>>>     * readonly to begin with, and whether we opened directly or reopened to that
>>>>     * state shouldn't matter for the state we get afterward.
>>>>     */
>>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>                                              bool release_stored, Error **errp)
>>>>    {
>>>> +    ERRP_GUARD();
>>>
>>> Maybe worth mentioning in the changelog that this ERRP_GUARD() fixes
>>> an error_prepend(errp, ...) not visible in the patch context.
>>
>> Ah yes. Actually this is occasional thing I didn't want to include into this patch
>> (and int this part I). So we can just drop it and leave for part II or part III,
>> or add a note into commit message
>>
>>>
>>> Anyway,
>>>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>
>> Thanks a lot for reviewing :)
>>
> 
> Don't mention it :)
> 
>> Hmm.. With this series I understand the following:
>>
>> 1. It's no sense in simple applying scripts/coccinelle/errp-guard.cocci to the whole code-base, because:
>>
>>     - it produces a lot of "if (*errp)" in places where it is really simple to avoid error propagation at all, like in this series
>>     - reviewing is the hardest part of the process
>>
>> So, if we have to review these changes anyway, it's better to invest a bit more time into patch creation, and make code correspond to our modern error API recommendations.
>>
>> 2. So, the process turns into following steps:
>>
>>     - apply scripts/coccinelle/errp-guard.cocci
>>     - look through patches and do obvious refactorings (like this series)
>>     - keep ERRP_GUARD where necessary (appending info to error, or where refactoring of function return status is too invasive and not simple)
>>
> 
> I've started to follow this process for the spapr code and, indeed, I
> can come up with better changes by refactoring some code manually.
> Some of these changes are not that obvious that they could be made
> by someone who doesn't know the code, so I tend to agree with your
> arguments in 1.
> 
> This is also the reason I didn't review patches 10, 13 and 14 because
> they looked like I should understand the corresponding code a bit more.
> 
>> 3. Obviously, that's too much for me :) Of course, I will invest some time into making the series like this one, and reviewing them, but I can't do it for weeks and months. (My original сunning plan to simply push ~100 generated commits with my s-o-b and become the greatest contributor failed:)
>>
> 
> Ha ha :D ... as a consolation prize, maybe we can reach a fair number
> of r-b by reviewing each other's _simple_ cleanups ;-)
> 
>> The good thing is that now, with ERRP_GUARD finally merged, we can produce parallel series like this, and they will be processed in parallel by different maintainers (and Markus will have to merge series for subsystems with unavailable maintainers).
>>
> 
> This sounds nice. My only concern would be to end up fixing code nobody
> uses or cares for, so I guess it would be better that active maintainers
> or supporters give impetus on that.
> 
>> So, everybody is welcome to the process [2]. Probably we want to make a separate announcement in a list with short recommendations and instructions? But who read announcements..
>>
> 
> I don't :) but the very massive series that were posted on the topic
> the last few months look like an announcement to me, at least for
> active maintainers and supporters.

Aha, I know. Better than announcement is improving checkpatch.

> 
>>>
>>>>        BdrvDirtyBitmap *bitmap;
>>>>        BDRVQcow2State *s = bs->opaque;
>>>>        uint32_t new_nb_bitmaps = s->nb_bitmaps;
>>>> @@ -1546,7 +1547,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>            bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>>>>                                       s->bitmap_directory_size, errp);
>>>>            if (bm_list == NULL) {
>>>> -            return;
>>>> +            return false;
>>>>            }
>>>>        }
>>>>    
>>>> @@ -1661,7 +1662,7 @@ success:
>>>>        }
>>>>    
>>>>        bitmap_list_free(bm_list);
>>>> -    return;
>>>> +    return true;
>>>>    
>>>>    fail:
>>>>        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>>>> @@ -1679,16 +1680,14 @@ fail:
>>>>        }
>>>>    
>>>>        bitmap_list_free(bm_list);
>>>> +    return false;
>>>>    }
>>>>    
>>>>    int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>>>>    {
>>>>        BdrvDirtyBitmap *bitmap;
>>>> -    Error *local_err = NULL;
>>>>    
>>>> -    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
>>>> -    if (local_err != NULL) {
>>>> -        error_propagate(errp, local_err);
>>>> +    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
>>>>            return -EINVAL;
>>>>        }
>>>>    
>>>
>>
>>
> 


-- 
Best regards,
Vladimir

