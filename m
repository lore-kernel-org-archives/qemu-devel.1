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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF19C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496CE207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ta8LOFGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496CE207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTZv-0002z6-CJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXTED-0006G5-N8; Tue, 27 Oct 2020 13:57:49 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com
 ([40.107.6.132]:61927 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXTEA-00076X-Du; Tue, 27 Oct 2020 13:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI9QUxRNlEbpgGvwu5cDmw813HH3ZPmSLiQiXfrdkolyX2eVSsCiccPEJSBtJbAlHd5XNMyIq0duj3SeEySP2+ec3eI5qtpy7xcYOsFmnQaspXtzpcgVZjnmtUCnVkLj3yckGKQL5ZJ1CVRfbT33VYx0Bl9x8G7Q/RIrC8YrKiqijna6/gvxrqJKn7C7zoIkm66Cz9IT7NLaYsgSLxC+X6xqWEmBiqH5RXsvkRwBCFg6lEBbWqbyl+xNCNyKCMK//choZn2/f26PrUHgQyyg9bt5vYpkUWtFrLQWo7nLKqZiKsllatw77ojfBQ9y586x5La3iiDLcxoxK/XQXHag7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCUh+1XLDOb15rtc4pGx5JUZbXJQ+CFSTUlqZTc+Bew=;
 b=JOHxspEy/Ek5m8uaiUPPeog/wSHLAd2d26Z3yBI899Qno398KcUVSWu52KLkQLsWvPd8c5Cmv7IOMV7aKGm/J6nnRcwQr8KNB+CHmfUW6VqfyXqrLHty+2oLgVKD6+n/C74SBKWJXAOwGaCJy/79brNsDSwS7wNo6/he21rqxtH282eVFFKCSYk4qsEKoIryC3M28TaF7VDZ0+los5dR1LXSlJD4jlOeSvXB+aNK1wimRg2TnGAlTRGrliI+IrnSIeuirV7gyQsTitRqGiTb+P+Md4H0XIsHSbJBDjrqs5K7r6+5LHRxJyz2Gj7rXWWp5iby6t4uWDO6mVT0kYEp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCUh+1XLDOb15rtc4pGx5JUZbXJQ+CFSTUlqZTc+Bew=;
 b=ta8LOFGviPcidFe/rIhDReWEi3JFPTGnH9FpGJX4jqIhQWfowvk1oSr61B8h/PTqgR5WmCgMGf3hqdXWqQgCmQGCnTwAtWlQcW67QH+hT77d8hf7DG6IUg+Nm19J06n5Zw0A7xVvWnL6FTaurat/EFAcn/VWfJnZyV14mFie3KA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3095.eurprd08.prod.outlook.com (2603:10a6:209:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 17:57:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 17:57:41 +0000
Subject: Re: [PATCH v12 14/14] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-15-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a8405ebc-8dc3-4520-1e35-2bae6a962f79@virtuozzo.com>
 <467434b5-abaa-fdac-bfcb-844626e1d5f4@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f8a956c7-c2dc-29c7-14b4-8e0d1b2ca9f8@virtuozzo.com>
Date: Tue, 27 Oct 2020 20:57:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <467434b5-abaa-fdac-bfcb-844626e1d5f4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM3PR05CA0116.eurprd05.prod.outlook.com
 (2603:10a6:207:2::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM3PR05CA0116.eurprd05.prod.outlook.com (2603:10a6:207:2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 17:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159eff1a-839e-4914-dfeb-08d87aa1ccb3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3095CFC911B3281FB0ED654DC1160@AM6PR08MB3095.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9oEYxCOxKJiczsuafV8RZktHIUsQLmHtwKSaW0vZE+BgVhSKj6xDc8raM0uvkZOfj3sf6p94BbRTOGJl9qkUvxHJONliLFKq80/6GHs6/f5JVi0gnPMfOl4/EnV2VmNP7sS18nsYE6bE+CVf1Av6iFTyxKZ04zXKmowXX0vL9IGOdQS+l8vfth2K8Z+eA2neolxtqapfNmijXXnx2wIVB8OhIJhwiEHiUSffEuC4flk9c3eNwTh/9v32dHFUpJmMlxKoK6Bl0q/yTUVQIBleokaqVxKUOlBDMbSZwfl9Bt0w8ds+fqswDCiMEUe3ViMEVutacrurVdhcvHG46c07W12fYzqCXoLzWrl9InfIB4jO93tVAAQuSm8IBdVRzKF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(16576012)(107886003)(52116002)(53546011)(6486002)(2616005)(956004)(36756003)(498600001)(26005)(186003)(16526019)(83380400001)(31696002)(86362001)(2906002)(66946007)(5660300002)(66556008)(66476007)(8676002)(8936002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CVrBe4jWTy/fdlRCX6tzv2pOVuoZQyoteyBL5iv3+Ev9aQtHFFDJ3+CnVFZCkaeNfX5kVwupM1QjL5RMTBvSXwy642VB+8HZZtSxXp27EPq6elq+Ybvc5UbXF27Fta8YSF8XDq7rCbraYJha7j+Rv2E3Pe8hC7QA4MT9+n6FBsLTAT6UDjaEqMzzfh7XU1mLBEsJevTWDjv5al/2NaEGijekoi/952JXbE2hkUZC9/lBBOh0gbQPvrijJzQiSFo8ee9a2LzylPa1+XYQvNGh+dVUJClqqCWMC9DcRTQJhHZc2stb7yVf7dbMuyYAXyIgvLyKuuvtMD/JDtcua3+7yIJWNwFMPsPpxP4PdDY8u45L9boa0KyCLiThQGz4WdQ9U+yoRCJaGQPupHf6ikjBwMI5DUzAvCPsl9ud63jthd0vWSsjFSD2N9PVGTgQyILpaJu04wcFhK9wBi2/6QHa4q7mRE3Y+7x/A0u56gM57XtKYRd6/QhKOq6of5IzAgEn7tBDwcAWyBHx8HS/vUOGj6imfZ21XFKlGlL7WSMhgTQ2ka1WkofrJ3VpbDRC6pgmQN3zvsoelYoNUwvTO4Xpmv7jC5YkJLxfZhmf6djOO+9dmtBpA5/cnEoDcE+s3g0cT3Yh6xTzjstL9ivrzr4iGA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159eff1a-839e-4914-dfeb-08d87aa1ccb3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 17:57:41.6634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DTV8uybvV9L2ji/8ym6JxK5UmbZY/dufkpU6/dFOfjdqbpTBrB4kdi2hwcq/0cedAXEEsTikaQ1mFwwDMpvvGqdCqLQ6gO5xDaSBEtnYbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3095
Received-SPF: pass client-ip=40.107.6.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 13:57:42
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

27.10.2020 20:48, Andrey Shinkevich wrote:
> 
> On 27.10.2020 19:13, Vladimir Sementsov-Ogievskiy wrote:
>> 22.10.2020 21:13, Andrey Shinkevich wrote:
>>> This patch completes the series with the COR-filter insertion for
>>> block-stream operations. Adding the filter makes it possible for copied
>>> regions to be discarded in backing files during the block-stream job,
>>> what will reduce the disk overuse.
>>> The COR-filter insertion incurs changes in the iotests case
>>> 245:test_block_stream_4 that reopens the backing chain during a
>>> block-stream job. There are changes in the iotests #030 as well.
>>> The iotests case 030:test_stream_parallel was deleted due to multiple
>>> conflicts between the concurrent job operations over the same backing
>>> chain. The base backing node for one job is the top node for another
>>> job. It may change due to the filter node inserted into the backing
>>> chain while both jobs are running. Another issue is that the parts of
>>> the backing chain are being frozen by the running job and may not be
>>> changed by the concurrent job when needed. The concept of the parallel
>>> jobs with common nodes is considered vital no more.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/stream.c             | 98 ++++++++++++++++++++++++++++++----------------
>>>   tests/qemu-iotests/030     | 51 +++---------------------
>>>   tests/qemu-iotests/030.out |  4 +-
>>>   tests/qemu-iotests/141.out |  2 +-
>>>   tests/qemu-iotests/245     | 22 +++++++----
>>>   5 files changed, 87 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/block/stream.c b/block/stream.c
> 
> 
> [...]
> 
>>> +    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
>>> +                         BLK_PERM_CONSISTENT_READ,
>>> +                         basic_flags | BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD,
>>
>> I think that BLK_PERM_GRAPH_MOD is something outdated. We have chain-feeze, what BLK_PERM_GRAPH_MOD adds to it? I don't know, and doubt that somebody knows.
>>
> 
> That is true for the commit/mirror jobs also. If we agree to remove the flag BLK_PERM_GRAPH_MOD from all these jobs, it will be made in a separate series, won't it?

Hmm. At least, let's not implement new logic based on BLK_PERM_GRAPH_MOD. In original code it's only block_job_create's perm, not in shared_perm, not somewhere else.. So, if we keep it, let's keep it as is: only in perm in block_job_create, not implementing additional perm/shared_perm logic.

> 
>>>                            speed, creation_flags, NULL, NULL, errp);
>>>       if (!s) {
>>>           goto fail;
>>>       }
>>> +    /*
>>> +     * Prevent concurrent jobs trying to modify the graph structure here, we
>>> +     * already have our own plans. Also don't allow resize as the image size is
>>> +     * queried only at the job start and then cached.
>>> +     */
>>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
>>
>> why not 0, like for other nodes? We don't use this BdrvChild at all, why to requre permissions?
>>
> 
> Yes, '0' s right.
> 
>>> +                           basic_flags | BLK_PERM_WRITE, &error_abort)) {
>>> +        goto fail;
>>> +    }
>>> +
>>>       /* Block all intermediate nodes between bs and base, because 
> 
> 
> [...]
> 
>>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>>> index dcb4b5d..0064590 100755
>>> --- a/tests/qemu-iotests/030
>>> +++ b/tests/qemu-iotests/030
>>> @@ -227,61 +227,20 @@ class TestParallelOps(iotests.QMPTestCase):
>>>           for img in self.imgs:
>>>               os.remove(img)
>>> -    # Test that it's possible to run several block-stream operations
>>> -    # in parallel in the same snapshot chain
>>> -    @unittest.skipIf(os.environ.get('QEMU_CHECK_BLOCK_AUTO'), 'disabled in CI')
>>> -    def test_stream_parallel(self):
>>
>> Didn't we agree to add "bottom" paramter to qmp? Than this test-case can be rewritten using
>> node-names and new "bottom" stream argument.
>>
> 
> I guess it will not help for the whole test. Particularly, there is an issue with freezing the child link to COR-filter of the cuncurrent job, then it fails to finish first.

We should not have such frozen link, as our bottom node should be above COR-filter of concurrent job.


-- 
Best regards,
Vladimir

