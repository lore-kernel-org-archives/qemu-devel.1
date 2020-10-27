Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFBC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A54C22202
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wggcN1ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A54C22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXS71-0006C4-A6
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXS5B-0004hK-OC; Tue, 27 Oct 2020 12:44:25 -0400
Received: from mail-db8eur05on2138.outbound.protection.outlook.com
 ([40.107.20.138]:43753 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXS59-0003Rg-8D; Tue, 27 Oct 2020 12:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOu7FNYe4guTPRE84sxX7UqUFEf6FhkVPirO8Ne22nH1mAZi7hsXpmrvlbKpyLcuOlQ6YNrTdFdcsnbDH4d/17+Fel8bV5CXbVjza3rbaYWbbEmKg7MvL13I4OadpATtkB1iQdG3KItuuhFBfN+2BeoUHEBNs1PlVmy1Zu3TYlh69N4FzaDgrvtRTtVHnla+SG8r18eXGceg4UNs2USN0dhUxBeKwi6sH89e20nBtZX/7utfQSifOoyzC2lExR//l/2BvSagL4bErT75IZS7ZRyylDzH5NZ+ynWjH3YRxRQ/SkrfpDC2ofpybO4EpcBYRD3sjTdzJF3ljS5StJzE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQid3qGFFOoc4EJnNwOaNl/ungLYaEyJ/kdtLF1yVz4=;
 b=nfYgOsArxCRD5V/fgXFYFWJbhmDR/TRWYL5z/sNiLYNbahzdOMMlTBPrsethcKCjnPgQ+t4LlnIpu472bHMmF2T+aM4pVmtzBK7anZ37XK+7Ird+1BUZjVULaUJO5qnSTTp/xSxiConuTgRRTwp817JuTjnOWYJbmx1QeXgBeS+NRIi6wQB7Xd4kpg3xGILcTDYZzQKGJjE4Lo5FcQ+XvbAW4TVWFBGtBPA/G66M6JmLXIgIDvkQyzWAjb7SbEfIHbW+uQQlu9VzaR+4GnwFulGvBGlmQVX2WG6qsKzi5+y7P6VCvQgIA/JkgeNwP4xIfOClAB8NMzWt5KrvTWS4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQid3qGFFOoc4EJnNwOaNl/ungLYaEyJ/kdtLF1yVz4=;
 b=wggcN1ck0Pt/28chUAklccetYZ4CxS+d7No/RuPZlZaA+du3XAIU3u3mq08aG0UzGz2hmEa35XFmEaPO0H6rtvlt8njU2obW52eLGTYeLlgckkSSgrRocjhQWEawZcrywsC1AVfKMGq3ZYxZmkZJiJ217V5d56Zh8SxD3IHwSPs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2861.eurprd08.prod.outlook.com (2603:10a6:802:19::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 16:44:15 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 16:44:15 +0000
Subject: Re: [PATCH v12 13/14] stream: skip filters when writing backing file
 name to QCOW2 header
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4dadeb14-0744-1cbd-04c5-516ba509cc14@virtuozzo.com>
 <fbcca331-9cca-12c8-d829-4fae360c8ef4@virtuozzo.com>
 <5703e680-a731-2aec-33da-26c431f4b89b@virtuozzo.com>
 <e751c20d-7cf0-6e31-80cd-1f6a827a5243@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c471dd26-35af-94fe-4c22-e042fe94084f@virtuozzo.com>
Date: Tue, 27 Oct 2020 19:44:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <e751c20d-7cf0-6e31-80cd-1f6a827a5243@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM4PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:200:42::22) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM4PR0701CA0012.eurprd07.prod.outlook.com (2603:10a6:200:42::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend
 Transport; Tue, 27 Oct 2020 16:44:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: debbd4df-423c-434f-8f26-08d87a978a39
X-MS-TrafficTypeDiagnostic: VI1PR08MB2861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2861BE0CFCE8AFFCA09C587BC1160@VI1PR08MB2861.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yuuAaZ7yAsfFQCNWAAthv20jpRj8pmmECpqRDbDI0ELujhQVHIrPNZhOB2rUfKBqhPUD2s0+EWX1KKZ9DYcS0QxWPomyyPctO068zcjfsTzOh4sNR3BTovWmngIKkqXk2KRE8dPcBnfNtl1v6x4Acf0SvRQn5jXlglsFSMXqEiWSUUg9lgdEzk0mMQ38IMcDo4csSOLmcMNOSo25HcXgXyC3baap1TxHIHTvPTT9YILfEA7S417dikAbka+NMBvt//1YQGUDt5kRsRQuSkWWqoAguDQV8Y5A2Zbl63HTRk81Gjz6y16ZCbTR+FE9bYOr9cK498OgyRWyGxChjIqApRJZcqkmaX+2rMcXwr95a8DSfNzAlP8eBsx3OO3obMx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39840400004)(366004)(136003)(8936002)(26005)(36756003)(52116002)(5660300002)(86362001)(83380400001)(186003)(4326008)(31686004)(53546011)(31696002)(8676002)(66946007)(66556008)(66476007)(107886003)(2906002)(16526019)(16576012)(6486002)(316002)(2616005)(956004)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yZ1BO6oTrg+AaRw6UQXHPJkox2c5Gw3sDmcK5Us34xQ7Q5DYypmIIrgWAqZ8dBM3ktivTZ38YAEuw2qW69Ukl3w/esLsdzr6wHeOkuvlcgLaoaznZ2bTkRkZ9Ps77nDz4KDXxQ/vn7ZwqGyq8NwMLtFIC6GeYe+kikD3b2gwMMH3d618f8H5XnkAd89onIKI6/DgTkhfykefynx7rxJXmA5FO0h3SbZl8b68/wJ7vYGIluGsDeLEMIJ8Phh2DHSn3tauWH11Qe0/9mKoSjkmhiK5TB4FKuzq0McToQNt3HFAd68wO1q2ydM0o3rdh8wEum0fwmEfG+mm8kRrSY7vM4mjOP8OWEG0m1Di+6931tAuRucM4DfmVNqEkOecwY+4YXksxX9wuOWJLSjID9/maO5JrDGp4MTCBw2XXbw4593U5ldFqLCPWF+Fv5kYuVG1t+EZtSWjAVqFY/BebwzvJbn9jaWFKqRBlsczKqurWjEc0UksJcBh9NUyJzQXEuBQ4daZ5tjUWKaSGHZ8Eerlk8Kwa0vd1kmHDgodXGWNQ40xYQCees5LCSCAyQkydcdE473dKZW8vu7lbWqDLI3kWrNq3IIs/i8FcnsDd06b4fb7enXHkCw6dGMVunJGDbraBXiK/c73pe4c4K6KgN1S+A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debbd4df-423c-434f-8f26-08d87a978a39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 16:44:15.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTf01FNMP9D3xGvlg94ICsOSRwJoDLI+hJIUzoa9zJmLRzGvLOxlM/9bkiYwTDjTXXWMwvW/S28O29bEuh7n1WGYgMs5FjgmUX8hVwJo5tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2861
Received-SPF: pass client-ip=40.107.20.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:44:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

27.10.2020 19:42, Andrey Shinkevich wrote:
> On 27.10.2020 19:21, Vladimir Sementsov-Ogievskiy wrote:
>> 27.10.2020 19:01, Andrey Shinkevich wrote:
>>> On 27.10.2020 18:09, Vladimir Sementsov-Ogievskiy wrote:
>>>> 22.10.2020 21:13, Andrey Shinkevich wrote:
>>>>> Avoid writing a filter JSON file name and a filter format name to QCOW2
>>>>> image when the backing file is changed after the block stream job.
>>>>> A user is still able to assign the 'backing-file' parameter for a
>>>>> block-stream job keeping in mind the possible issue mentioned above.
>>>>> If the user does not specify the 'backing-file' parameter, QEMU will
>>>>> assign it automatically.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>>   block/stream.c | 15 +++++++++++++--
>>>>>   blockdev.c     |  9 ++-------
>>>>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/block/stream.c b/block/stream.c
>>>>> index e0540ee..1ba74ab 100644
>>>>> --- a/block/stream.c
>>>>> +++ b/block/stream.c
>>>>> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>>>>>       BlockDriverState *bs = blk_bs(bjob->blk);
>>>>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>>>>> +    BlockDriverState *base_unfiltered = NULL;
>>>>>       Error *local_err = NULL;
>>>>>       int ret = 0;
>>>>> @@ -75,8 +76,18 @@ static int stream_prepare(Job *job)
>>>>>           const char *base_id = NULL, *base_fmt = NULL;
>>>>>           if (base) {
>>>>>               base_id = s->backing_file_str;
>>>>> -            if (base->drv) {
>>>>> -                base_fmt = base->drv->format_name;
>>>>> +            if (base_id) {
>>>>> +                if (base->drv) {
>>>>> +                    base_fmt = base->drv->format_name;
>>>>
>>>> hmm. this doesn't make real sense: so, we assume that user specified backing_file_str, which may not relate to base, but we use base->drv->format_name? But it may be name of the filter driver, which would be wrong..
>>>>
>>>> Any ideas?
>>>>
>>>> 1. we can use base_fmt=NULL, to provoke probing on next open of the qcow2 file..
>>>
>>> I would choose this item #1 but have to check the probing code logic... Particularly, I do not remember now if the probing is able to recognize a protocol.
>>> The logic for the format_name in the QEMU existent code (I has kept it here in the patch) is a slippery way for an imprudent user. That's why I staked on the backing_file_str deprication in the previous version.
>>>
>>>> 2. we can do probing now
>>>> 3. we can at least check, if backing_file_str == 
>>>
>>> Not bad for the sanity check but we will search a node by the file name again - not good ((
>>
>> Not search, but only check one very likely option.
> 
> Yes, just strcmp(). And why a user may not merely specify a desired backing file as the base?

*shrung*

> 
>>
>> Additionally to 1. or 3. (or combined), or even keeping things as is (i.e. wrong, but it is preexisting), we can:
>>
>>   - add backing-format argument to qapi as pair for backing-file
>>   - deprecate using backing-file without backing-format.
>>
>> Then, after deprecation period we'll have correct code. This may be done in separate.
>>
>>>
>>>> base_unfiltered->filename, in this case we can use base_unfiltered->drv->format_name
>>>>
>>>>
>>>>> +                }
>>>>> +            } else {
>>>>> +                base_unfiltered = bdrv_skip_filters(base);
>>>>> +                if (base_unfiltered) {
>>>>> +                    base_id = base_unfiltered->filename;
>>>>> +                    if (base_unfiltered->drv) {
>>>>> +                        base_fmt = base_unfiltered->drv->format_name;
>>>>> +                    }
>>>>> +                }
>>>>>               }
>>>>>           }
>>>>>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>>>>> diff --git a/blockdev.c b/blockdev.c
>>>>> index c917625..0e9c783 100644
>>>>> --- a/blockdev.c
>>>>> +++ b/blockdev.c
>>>
>>> [...]
>>>
>>>>> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>>>>> +    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
>>>>> +                 has_backing_file ? backing_file : NULL,
>>>>
>>>> backing_file should be NULL if has_backing_file is false, so you can use just backing_file instead of ternary operator.
>>>>
>>>
>>> Yes, if reliable. I has kept the conformation with the ternary operator at the first parameter above.
>>>
>>> Andrey
>>>
>>>>>                    job_flags, has_speed ? speed : 0, on_error,
>>>>>                    filter_node_name, &local_err);
>>>>>       if (local_err) {
>>>>>
>>>>
>>>>
>>
>>


-- 
Best regards,
Vladimir

