Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC6BC8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578C02137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PUv3diyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578C02137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5TV-0007Ah-Gd
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU5Si-0006Ly-7F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU5Sh-0004U5-P8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:26:32 -0400
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com
 ([40.107.21.138]:26209 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU5Se-0004SQ-BA; Thu, 30 Apr 2020 05:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnPAq3Xr1EvA84ln0oQOqhBaO/lhd1dNKTUm9tSCnJ0+VCJJwRXJDmAR4KvgARc3H7vvGwyteEw2xmT5OGwdXj2s7I/nxWs5Nv/8ApeDP712IlYvbY3QfwtefqJxpzMbr8+ss5hK2frq2n7YK8V9ET5jJEr2u2AjaR7dkER3relr72EJKNXC3TxVQqZjmODhJ4cl2W5rWC8PjdEJt12+AwewGo2xUENab0gL6VXDgyAyWuEFYMyM1fv1iulHfmGfb+X53BbPltKOI5gSHOka8TThUaHqyYBvbjm+Yl03hPIuwQkqds+KdJwS5RFmmdWvBvmzJwKTeZqSSCcAzq7p9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz0gjtgWULdOofzXfKnrIHytqEmX/Umdut8fsY2btiY=;
 b=Q5fUs6JwErx4NnXhPdTPzklo0flX0uhhTISBxIdE04rx3tgeCngVQ7Xk/VFWDZ9l6yjuJBVkwGzgoaF96QBah8J+idQ53gFOdra+geLSx/yTpkGY8tgFrvRUF9yP5UKgObX9f3M/sUVfhi6YXs6hL8CccGVP6gc/Wd5A/1U4clX1h9NCJXFW25vlwV+OgzehC4mznewmb40oYBvDVqD635HjSmccFrwUkkaC7tQgKpjPqIZB9/7sN7g59XkCSAwxgNlJMZC11IxrWUMrpZr8DfZnhTm2Rmd+L+Q3viBWEpXuDEpwp7kmUyGWOtw2aMm6OikRN24XgsnvDjxw7RhqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz0gjtgWULdOofzXfKnrIHytqEmX/Umdut8fsY2btiY=;
 b=PUv3diygJElUDlRii6H0+2RMf0bj9y2q4Ynn2zU8Otkrb16GVm89nI+nscJSP0j/OigB3db5miIjXIQbMB10FWAEvT600OEI0lxQNwHpecE62mU2/RTsRDsxL/OMn8B+oOITtNtklZj21f3OUB8GcH7IIJ5G3x7NBcPo2peLGlU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 09:26:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 09:26:24 +0000
Subject: Re: [PATCH v2 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-7-vsementsov@virtuozzo.com>
 <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430122618570
Message-ID: <a3238ffb-b059-3652-4885-18aea838a6b3@virtuozzo.com>
Date: Thu, 30 Apr 2020 12:26:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0139.eurprd07.prod.outlook.com
 (2603:10a6:207:8::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM3PR07CA0139.eurprd07.prod.outlook.com (2603:10a6:207:8::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.12 via Frontend Transport; Thu, 30 Apr 2020 09:26:19 +0000
X-Tagtoolbar-Keys: D20200430122618570
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a827382-ec26-49a1-e3c3-08d7ece88ce6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478A5EE65C7CED03DE0DB93C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxiXrv2G0ysh3QZT3miBuryFef/2gwxuptW0Mt6jx3IHr354a/zKpu8wBhVwc4IbzJKxp79Tg5dNPUWQDme2EAKPiTCFAeKPEM2jFHCZW//sLshHuusmcX8eeUaWd3EshuK40tfKWjdLU47U2LbMAcfkhSg2zyFjo/sv1R8ukQ+RgC+YFemszTM4V2bC6wdteXp4uV9MtMMmWAv8MDic3fFnoi/gTq/Fuwh+JkRz78jw/sCNUI2mqVEdgBVjsf1vsDajGZsJRpSnn1jiiWpu3Vs4Ugze9lN5+LjWKnXLOkSB36N4SK/PvOVbOTaXS+VZ1NfojGyQ2jCVRSQGEa6RoGd3XHU6QEVkUm4TzsdYdJQcyXQkIULd2/1DRh0mMAKqFk2UzcQ68SmAoJAQjnxWfSZ1+Nu4V3HQ183Lf7DVJY5yMKSlHTuXVcCoMIEn1+lh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39840400004)(8676002)(52116002)(8936002)(53546011)(16526019)(186003)(26005)(5660300002)(956004)(2616005)(478600001)(31696002)(2906002)(7416002)(31686004)(16576012)(316002)(66476007)(66556008)(66946007)(86362001)(36756003)(107886003)(4326008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XJnWQt19NQhrd6LaWdvaMnc0ko0CrVQcbi8eHAIkFNcvJDLQHpMdqd9kkYvXb4chgl60xIKPvca5dqN+bgpv/kB+npOQkbvowES5/3rDnEgr1zrRgomvN8k6EzWIKEdawlUSDPDt7UJI6I5iBi9AgNEyPzVnLsF32vAZcl2URBhpesgTQxAu2QOBY5jmg4t0yvksQre9+LoiJ7diwajLnEG65utfWw5U95FG9eL5NQlU/WOQ9CG6EyNF9/WwfMOmVZXXVnTfYMGV57P1fYW5VXMb137IlWf42cIdSO/A7DaLxH4lRbPjlS/P2+CY79YJfPp5aMvHEuROjO2FCz8QIjndkFlh/Wx1Ec3kJO2LIvpR3YHqSCB/lciXNR2RoeH1FrUQC0/vx1BgUgLe9acGSw7fz6JgR+kFfDxnyGyI7NtnH92Crp9p7ixOMevItsLlVMEh7L0+xbj6wHjRcExjWrowHWV2XckaCw2cLArxdb8P27flfPndnyXjHviyvVAuSK2SI/1za0M8fKGgtzrGNQFrP06llZ3FxAsyArF52PUG50QfGEBG7F2RkYmw8q5lQgUZ6ishl3n+IOAETKwz2cEQJMYknNhSNp+ZJdO8+SJopz8JBLNRKivkLdFYqj5z2HfAQdQ6VKuGIfs8mSv74gNlkRxcxx6csop6LIU9tVWQitjlHBdXhXCus1KVzxnk1YP7FM8Dj4XvTzXSdGmyQ5wn97cuLmrubkThiCL1gVQQP9blnZ59Cx6Kjrvk5DH1he4d0cLsSIJ6UqN3tKTMU+qOVFcQeqt2oUD9e8WvBUM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a827382-ec26-49a1-e3c3-08d7ece88ce6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:26:24.0119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZkG8lrbZwhbPvKMj0ImTDu9SQIzfNvF/fhzuMDObsgO7rIsLaQRvjl/C9b4Fm0MMFo8sgzS8Duo35+CUCeVwfdBHRkZKhq3ddffRwfT3p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 05:26:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.138
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

30.04.2020 1:04, Eric Blake wrote:
> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We are generally moving to int64_t for both offset and bytes parameters
>> on all io paths. Prepare bdrv_aligned_pwritev() now (and convert the
>> dependencies: bdrv_co_write_req_prepare() and
>> bdrv_co_write_req_finish() to signed type bytes)
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index c8c30e3699..fe19e09034 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1854,7 +1854,7 @@ fail:
>>   }
>>   static inline int coroutine_fn
>> -bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>> +bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
>>                             BdrvTrackedRequest *req, int flags)
>>   {
> 
> No change in size.  First, check usage within function:
>      int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);

this variable used only for assertion, it's simple to refactor to avoid the problem.

> Changes computation from uint64_t to int64_t.  This causes a borderline bug on images between INT64_MAX-511 and INT64_MAX (nbdkit can produce such images over NBD, although they are atypical on disk), where DIV_ROUND_UP() would give the right answer as uint64_t but a negative answer with int64_t.  As those images are not sector-aligned, maybe we don't need to care?
> all other uses appear to be within asserts related to offset+bytes being positive, so that's what we should check for.
> 
> Callers:
> bdrv_aligned_pwritev() - changed in this patch to 'int64_t', analyzed below [1]
> bdrv_co_pdiscard() - already passes 'int64_t', also checks for offset+bytes overflow - safe
> bdrv_co_copy_range_internal() - 'uint64_t', but already analyzed for 3/17 how it was capped < 2M - safe
> bdrv_co_truncate() - already passes 'int64_t', passes new_bytes computed by subtracting from a positive 'int64_t offset' - safe
> 
> 
> [1] except I hit the end of my work day, so my analysis will have to continue tomorrow...
> 
> 


-- 
Best regards,
Vladimir

