Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2AA206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z+VlDn4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2AA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvgj-0007f6-8Z
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juvfc-0006eL-L9; Mon, 13 Jul 2020 06:26:48 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com
 ([40.107.14.112]:49687 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juvfa-0007Wu-RT; Mon, 13 Jul 2020 06:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnB1B98ngscUUK1zLC6a9SRrF+tepwQCxEP0ACX4AQTCPC9fEfgCbnVbHO2ls3TNo3ENuPEfUTnXWoqcaqeOYeLxedqMEg07+Au839onQDQjDc6EEy68o53OIhUUu6eU6cqwH27dB1s5vc23czUwy13x/H5qP+dysREKBAQm47RzHZ7nZUWWGyDDsO+RfAxD4xYVfQIUY0tXSINhwTzgE1g+wDFWWu4hhXTW68wXTd20unlpBYQZDyDGM75+5J2AQg1wCOU9/8dLIgM2QpOtZQatj+vCbHn4ORNUl9ZjGPOOUYr5zoRqU2pJejzUDoMoq0sDdqYBo0nMv0yUFJnW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0T7HDGONYNUBgaK9voqzpnOGU6dp+3sSPKCGpKgYUA=;
 b=UdUsFQ5irfdj4jbdvbW+oLCBb4Z9RQDzGQc6lPlTbAB+Izd6+MKUjd7ak6fOf1C6SKQIdx/N4xbMMagAAQSAUA1db0TEAqbo0L8iObZqEHmUZES1oNQzcZb1Syiq6dvZkUQEnFP/4l+XUyOwVpWMEKFLUZLac7Le3ABaTK6ueDAM2b435/6AClhyZ6tvPlnXSRNCqIC+fatHmBo0u0BNgM0fN0/c36OxBpft+KE0FuvD9TjX3EgzJXSV9OdUG1665QZUFir64WbUOQPgZgh4XLqTSKVQlmuvMnd7/SXehKfDFqaWDRUP3nKKWxtQ2uRje+1pXS46BjgbgixDLOUzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0T7HDGONYNUBgaK9voqzpnOGU6dp+3sSPKCGpKgYUA=;
 b=Z+VlDn4P2ueTORwiIyyYgkhdQCGZfEdljSmZh5wzSSk0jGlgfjawpwHT6d1YPRKFZq2/jAnZ/Ulk9bFX/WsYpmNvZ1Y9cQRWpmivOtjhXmnWDPdtm7RW6YswJbjYnsmKNbemd34Y9OJKXogYPVmMuCPw3IYcZd0octeqLH6ruTQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB5208.eurprd08.prod.outlook.com (2603:10a6:20b:eb::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 10:26:43 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 10:26:43 +0000
Subject: Re: [PATCH v2] scripts/simplebench: compare write request performance
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73ac42ec-dc28-c4e6-a555-d9cf11cbeed0@virtuozzo.com>
 <f19f4323-94cb-4404-1530-279d256be46b@virtuozzo.com>
 <ab34ca3e-087f-9040-9927-43902281b453@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <5dc513ae-a425-43e5-e257-acb73a02af7d@virtuozzo.com>
Date: Mon, 13 Jul 2020 13:26:38 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <ab34ca3e-087f-9040-9927-43902281b453@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0134.eurprd05.prod.outlook.com
 (2603:10a6:207:3::12) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR05CA0134.eurprd05.prod.outlook.com (2603:10a6:207:3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Mon, 13 Jul 2020 10:26:41 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f666ce8c-52d2-48e2-7f07-08d827173cf6
X-MS-TrafficTypeDiagnostic: AM6PR08MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52085AE31B5AEF650FEDAC92F4600@AM6PR08MB5208.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laCE1cIc3cbP94BlLmneKz/sm5gyvU8pYQCnHPF3iLHGBIpDzCnnfhiyUTdB3VXae/SpluHh8HfnToLLS0VYpm52BMsdsSD5JoRybmcytNoNHWoxz0l4uG9Ug3EN0IxQkHPkOrYV2HPC36u/Vcf9a9hi6PzS+8tCUOhXolUWY48Xk9ObS0AWxU60oMmzW9y4dYLX27Lu7b8n/RPQBA+W8buY7zBvQgpnMqcL5I6YVrN2Q89PIz4OjcvLOVZT1aC/Msus/1A0sPrFrefAhMaxYqhhQoQ3eZ8j12DIxsOGNjgeCJ8zIjbwcJ64htOInDmeZSrsl4MCpSxzFZDb4qRYMVjWOf98zburhFwQbXR5blAtwfCy7RoduLKqgjk5/KOl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39840400004)(5660300002)(6666004)(86362001)(8676002)(66946007)(52116002)(26005)(66556008)(36756003)(316002)(4326008)(478600001)(66476007)(16526019)(186003)(2616005)(956004)(2906002)(107886003)(83380400001)(53546011)(6512007)(31686004)(8936002)(31696002)(6486002)(6506007)(44832011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PO+fYPXCdpX7ztFCrpDroYj2WYVecgPvf3IwMhfawYwJzV3dzeGXzX8PU58VdSItwLeY9OFVN08BEnBU2vrOnhRT0RIajRmqik+L4+4dswF4ik09hlrFwinTrxT4EblwFJA35ELeWfUnWMZj+zhIZ48kic+KsEx1OzVg6QsCjlLoHcCzfp8N4HecHgJVRnj7U7F5tjACO9CQ4T9m/KqqNvsMFIEdxRe0ik8K6RTRY7tzQsk35b851xBpYR6dTsqfgXc/ce3nCVb0r5bQqQhe/DwZsfRKu2yX9wUPIZA0CJ3XOw1/2EYBKo5eNMKnP1LejnIIZ+cKs5O+i0Ru24AwLJAnpMcnKiPT9LPzkhX6nrrENpE/8YWvxMmJyip4gdWSfF00Tuweuc87bNZ5Gl6EFEX0VM15WMdiMdlyF0X5stE3aoZ5RU9gFrvoRtsi5ZFyYf0rvrrRtGNRBtfJ0+KVJnesauaCq0Dr/cOvN2Hd+4aDumQMG4f5S+Cn+6IuqBmi
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f666ce8c-52d2-48e2-7f07-08d827173cf6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:26:43.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjM52Aw56cLilhVI8QmKYm3jKpyMluwnZjR1hNpyKAnybTlPxn0PsrneBAzPfgp0TjDQgsZI1h0aziV15cQJ6y43XBL7TraEJ567/TvmJXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5208
Received-SPF: pass client-ip=40.107.14.112;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:26:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13.07.2020 11:43, Vladimir Sementsov-Ogievskiy wrote:
> 12.07.2020 19:07, Andrey Shinkevich wrote:
>> On 11.07.2020 16:05, Vladimir Sementsov-Ogievskiy wrote:
>>> 26.06.2020 17:31, Andrey Shinkevich wrote:
>>>> The script 'bench_write_req.py' allows comparing performances of write
>>>> request for two qemu-img binary files.
>>>> An example with (qemu-img binary 1) and without (qemu-img binary 2) 
>>>> the
>>>> applied patch "qcow2: skip writing zero buffers to empty COW areas"
>>>> (git commit ID: c8bb23cbdbe32f5)
>>>> The <unaligned> case does not involve the COW optimization.
>>>>
>>> Good, this proves that c8bb23cbdbe32f5 makes sense.
>>>
>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>> v2:
>>>>    01: Three more test cases added to the script:
>>>>        <simple case>
>>>>        <general case>
>>>>        <unaligned>
>>>>
>>>>   scripts/simplebench/bench_write_req.py | 201 
>>>> +++++++++++++++++++++++++++++++++
>>>>   1 file changed, 201 insertions(+)
>>>>   create mode 100755 scripts/simplebench/bench_write_req.py
>>>>
>>>> diff --git a/scripts/simplebench/bench_write_req.py 
>>>> b/scripts/simplebench/bench_write_req.py
>>>> new file mode 100755
>>>> index 0000000..fe92d01
>>>> --- /dev/null
>>>> +++ b/scripts/simplebench/bench_write_req.py
>>>> @@ -0,0 +1,201 @@
>>>
>>> Next, I don't understand, are you trying to fill qcow2 image by dd 
>>> directly? This is strange. Even if you don't break metadata, you 
>>> don't change it, so all cluster will remain empty.
>>>
>>>
>> I have tested and it works as designed.
>>
>
> But how is it designed? You just filled unallocated clusters with some 
> data. When you read from qcow2, you'll still read zeros, because L1/L2 
> tables are not filled. The random data will lay untouched.
>
>

Sounds reasonable. But why do QEMU-ING INFO shows the actual size 
increased after the dd command?

Andrey


>> This dd command doesn't hurt the metadata and fills the image with 
>> random data. The actual disk size becomes about 1G after the dd command.
>>
>
>

