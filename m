Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C8DC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6014721582
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qF1E6epT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6014721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWmJO-0000ho-CM
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWmIK-00080Y-Mt; Thu, 07 May 2020 15:34:56 -0400
Received: from mail-eopbgr00125.outbound.protection.outlook.com
 ([40.107.0.125]:43342 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWmIH-0001Ht-Fq; Thu, 07 May 2020 15:34:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvt8E+LoxI0tDFHbwYB9n8/t+uvKML9rV2xRbyR6FA/6jphnQC1V82i4qp7k1z0kuyDsRhg8OvHdJIwVo9YNo4hfhl09wEx3Bf6tJhkXnejFa32ubFSvr6FFsGkbAfEFhFh8Lh91oXOYN9/amj7wBRJPQSZxG+87FJJzypFqRzTyS/CcODE5GWTcMHiLJShwX02DTySi0q3Is1tRYiYUrAm9uucQFJNPvYfs983JKOSptyfoAQDzP4tHxEXjhIAVOBNkkseAbzb1GKqQPE2pukIaJkZ5hNWjroC822R8NefkBtxDYzCc3PtmHKxpu2c/WMHT9mwsuvRdyxETCK62Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGmsobX8S5ijZa08FvRWYzKyI0fvh2R+tiT1fV89MNo=;
 b=C81YlqprkNw5mU8Q0ODh7Rx9lQDv9x63/T+2YOyjRykSRrujP3/u0zRekWqGBLd8npPJcXG9J5J0pO63ZmpXEIKhydUvgF6fP47ZpGY/x52O+zffS6W7XknvmoztqeB1ZBfkxqmKnau8NDMz0EcKX+94WHgk51MtlLYSSux+VsgC3Sr5OWVZVWlP9V1ijwvW083qrHU3lRyA1+cZrUu7Y6dPwh5UMHWD5Ssi7u3vFeuYL+/T1mJB87zxy53DxY3QQ0EUnRhiSljpMzmD0pWtdHTJt6iXgul1vSZ0iN+kCNXKMuLHcpL0E4m7WC7F1Hp/dSpXLB8v2ec+Op+YI6iYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGmsobX8S5ijZa08FvRWYzKyI0fvh2R+tiT1fV89MNo=;
 b=qF1E6epT97GJ9mOOLE5PIuo/7kr/As9Ogowjwb/4jKuZdC89HormPEYGAoUTHQXofw2wAEHn6h/vYgqTKVKFoqCymIgsRxZUNRW1+NSWF6FsmQX38eUmB+98AORzdovVmE71lVMhevQS2pICj1Ttwp8yfw10C0cCC+VTwCLn+O4=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5304.eurprd08.prod.outlook.com (2603:10a6:20b:10e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 19:34:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 19:34:49 +0000
Subject: Re: backing chain & block status & filters
To: Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
 <9b5b1114-9a45-9cad-bc25-d3c10df45dc1@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507223448020
Message-ID: <629b67eb-b4ac-dc46-a372-3ea5b8ef3cbd@virtuozzo.com>
Date: Thu, 7 May 2020 22:34:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <9b5b1114-9a45-9cad-bc25-d3c10df45dc1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 19:34:49 +0000
X-Tagtoolbar-Keys: D20200507223448020
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9f011f-bca4-4831-07b5-08d7f2bdb4f8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530425E6EF5DBD53EFAADE5BC1A50@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCbobJ8oGDGKpU9vqb7wRGgA31xu9b51gWA0RWT+9BAIOsJ1wO5pzm8lHt+5oCnNC015YszJvTHrqaw7MFBx/OcxpzpYzLAJoiSQnXVXLFTfZWTnZ3yyfj7HIGh90X5G7UOIoIBXGq0/3dtRJ03Wv6PCJuSV/2+M0KbUQROH4ssm7GHP8ZzyPye1aknl2JHXlEv40N7p08ZMUp2E5PczDU0XU1zqP/Pvp771eoMFEHnEi6PIQFLIi6oMQu5orC+Zy4DfE8P0zKGUH+ep3/zEy/Qr+9jHCCMqBPIBLsqmtlmSyxiqxQ8p3HDFkUx7ynLCMMqV0EtbAtL9MRDz8nvpVc1KWA77vL6/dv+dqV5K47aVcoNsfGIsaiC4cS/DWrCBqhxs8nUdp91kwCwCJuLIu/yEdMwNlUnh6bh9cfjHFqGyh5aiqH08NKgK/jfDQyXUpeAo0qoC6EK8n/qwbSR+2IAr2ZGjG+APDOrhqQUVTmAGJeLA3/jxRmUhlVeygZm4tL1dqoNm9ukHa3DCKHXHKt2pCkFJ5qr28ANRLZqzlBDhYJ87AtA464+7Lu/tRKMb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39850400004)(33430700001)(53546011)(186003)(16526019)(956004)(26005)(2616005)(52116002)(2906002)(16576012)(86362001)(6486002)(83300400001)(83310400001)(31686004)(36756003)(316002)(83280400001)(83320400001)(83290400001)(31696002)(110136005)(5660300002)(8676002)(54906003)(66574014)(33440700001)(8936002)(4326008)(66476007)(66556008)(66946007)(478600001)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wGu+8/z/J6dG+UXniJbO+TsjEGqERg1dYrYwx6uLRaSwkFJYYfjhizNwj3HUyKkQeo0lR5npwlPf8YLDrCAg2DsGLRSwrz0A9/vlizgJIRz7RrnwBFpAm4hFQE0qEsluZjUuJ04w21Hvw7R2S/sZILs2Z5VgmZrxoQr3PfeZyiY6M0k0e7aOoe49ZTQaSIuJgPBx1NnCz0kFHx/HBr1WQO5WUAnhTBbGOpjP9T/bu8UP9JyzTS5odMMDLemU2By+PxILQGHzTSLrg//cMAJwncREmn1HBx35GR6IRvGXocIT6ZeVS+TtEJrKHmoNlgMuFezxcOXHxE33+VjEr6oEv/RVxopS0Sd5DctCiN43FLe/8KrscRsEE9szOLAhRv/pO81oPQ1uPC3VRIIVZZTe2yjkZo4NXtIjM6xPfGr8WrWLSixyHUufLx9EjFYQLuy5Ue9jYFB2aj70zyYFRoUmYsJZzA+Rxm0VR9oJ9x1ZJbGF8jGvn75FP0vxL9ONp+qDLG06acS1RrOl1oYQR/nQHnXrOxhnLTG0bxtRe0EnXhjPLukbKbDwLXhxxVIfO7da9SAAEGRf0BLy+dxXcTj5zclk0QeS0xCrY6mKHBLeBHIH99aIB2j6ojduF+XsZho+CFJSY7vggutC55qQyMlRd3GVo4WxYMwC1YUH7MwJAeXpCgbF8Vqpn+ro6aUSS50m5LMwn7uB29/2TuQBBubnUMbbS1aWP6qYk1Dw0l58i96Jf4+S/IDLWBxJLDslMXvltPj0mz8BPINyg9eJ1jfsoPFL7BiC1i7Mc5pbDDN3ZM0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9f011f-bca4-4831-07b5-08d7f2bdb4f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 19:34:49.6652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ubmi/xSzCHrYKCwtkTwvUdwwDJCxp7ken1IubZpb88MqjFxKMdM+k2TbsZS10lqiK4+nfzVfMxd+a5Q0iwqdZ5Mh2dNcGMaMtDwCwfc20bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
Received-SPF: pass client-ip=40.107.0.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:34:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.05.2020 15:58, Max Reitz wrote:
> On 28.04.20 16:51, Vladimir Sementsov-Ogievskiy wrote:
>> 28.04.2020 14:08, Max Reitz wrote:
>>> On 28.04.20 10:55, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi!
>>>>
>>>> I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and
>>>> is_allocated_above", and returned to all the inconsistencies about
>>>> block-status. I keep in mind Max's series about child-access functions,
>>>> and Andrey's work about using COR filter in block-stream, which depends
>>>> on Max's series (because, without them COR fitler with file child breaks
>>>> backing chains).. And, it seems that it's better to discuss some
>>>> questions before resending.
>>>>
>>>> First, problems about block-status:
>>>>
>>>> 1. We consider ALLOCATED = ZERO | DATA, and documented as follows:
>>>>
>>>>      * BDRV_BLOCK_DATA: allocation for data at offset is tied to this
>>>> layer
>>>>      * BDRV_BLOCK_ZERO: offset reads as zero
>>>>      * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing
>>>> raw data
>>>>      * BDRV_BLOCK_ALLOCATED: the content of the block is determined by
>>>> this
>>>>      *                       layer rather than any backing, set by block
>>>> layer
>>>>
>>>> This actually means, that we should always have BDRV_BLOCK_ALLOCATED for
>>>> formats which doesn't support backing. So, all such format drivers must
>>>> return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, for
>>>> example, iscsi - doesn't.
>>>
>>> Hm.  I could imagine that there are formats that have non-zero holes
>>> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
>>> ZERO or DATA then.
>>>
>>> But OTOH we don’t care about such cases, do we?  We need to know whether
>>> ranges are zero, data, or unallocated.  If they aren’t zero, we only
>>> care about whether reading from it will return data from this layer or
>>> not.
>>>
>>> So I suppose that anything that doesn’t support backing files (or
>>> filtered children) should always return ZERO and/or DATA.
>>>
>>>> 2. ZERO. The meaning differs a bit for generic block_status and for
>>>> drivers.. I think, we at least should document it like this:
>>>>
>>>> BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>>>> BDRV_BLOCK_ZERO: if driver return ZERO, than the region is allocated at
>>>> this layer and read as ZERO. If generic block_status returns ZERO, it
>>>> only mean that it reads as zero, but the region may be allocated on
>>>> underlying level.
>>>
>>> Hm.  What does that mean?
>>>
>>> One of the problems is that “allocated” has two meanings:
>>> (1) reading data returns data defined at this backing layer,
>>> (2) actually allocated, i.e. takes up space on the file represented by
>>> this BDS.
>>>
>>> As far as I understand, we actually don’t care about (2) in the context
>>> of block_status, but just about (1).
>>>
>>> So if a layer returns ZERO, it is by definition (1)-allocated.  (It
>>> isn’t necessarily (2)-allocated.)
>>>
>>>> 3. bdi.unallocated_blocks_are_zero
>>>>
>>>> I think it's very bad, that we have formats, that supports backing, but
>>>> doesn't report bdi.unallocated_blocks_are_zero as true. It means that
>>>> UNALLOCATED region reads as zero if we have short backing file, and not
>>>> as zero if we remove this short backing file.
>>>
>>> What do you mean by “remove this short backing file”?  Because generally
>>> one can’t just drop a backing file.
>>>
>>> So maybe a case like block-stream?  Wouldn’t that be a bug in
>>> block-stream them, i.e. shouldn’t it stream zeros after the end of the
>>> backing file?
>>>
>>>> I can live with it but
>>>> this is weird logic. These bad drivers are qcow (not qcow2), parallels
>>>> and vmdk. I hope, they actually just forget to set
>>>> unallocated_blocks_are_zero to true.
>>>
>>> qcow definitely sounds like it.
>>>
>>>> Next. But what about drivers which doesn't support backing? As we
>>>> considered above, they should always return ZERO or DATA, as everything
>>>> is allocated in this backing-chain level (last level, of course).. So
>>>> again unallocated_blocks_are_zero is meaningless. So, I think, that
>>>> driver which doesn't support backings, should be fixed to return always
>>>> ZERO or DATA, than we don't need this unallocated_blocks_are_zero at
>>>> all.
>>>
>>> Agreed.
>>>
>>>> 3.
>>>
>>> The second 3.? :)
>>>
>>>> Short backing files in allocated_above: we must consider space after
>>>> EOF as ALLOCATED, if short backing file is inside requested
>>>> backing-chain part, as it produced exactly because of this short file
>>>> (and we never go to backing).
>>>
>>> Sounds correct.
>>>
>>>> (current realization of allocated_above is
>>>> buggy, see my outdated series "[PATCH 0/4] fix & merge
>>>> block_status_above and is_allocated_above")
>>>>
>>>> 4. Long ago we've discussed problems about BDRV_BLOCK_RAW, when we have
>>>> a backing chain of non-backing child.. I just remember that we didn't
>>>> reach the consensus.
>>>
>>> Possible? :)
>>>
>>>> 5. Filters.. OK we have two functions for them:
>>>> bdrv_co_block_status_from_file and bdrv_co_block_status_from_backing. I
>>>> think both are wrong:
>>>>
>>>> bdrv_co_block_status_from_file leads to problem [4], when we can report
>>>> UNALLOCATED, which refers not to the current backing chain, but to sub
>>>> backing chain of file child, which is inconsistent with
>>>> block_status_above and is_allocated_above iteration.
>>>>
>>>> bdrv_co_block_status_from_backing is also is not consistent with
>>>> block_status_above iteration.. At least at leads to querying the same
>>>> node twice.
>>>
>>> Well, yes.
>>>
>>>> So, about filters and backing chains. Keeping (OK, just, trying to keep)
>>>> all these things in mind, I think that it's better to keep backing
>>>> chains exactly *backing* chains, so that "backing" child is the only
>>>> "not own" child of the node. So, its close to current behavior and we
>>>> don't need child-access functions. Then how filters should work:
>>>>
>>>> Filter with backing child, should always return UNALLOCATED (i.e. no
>>>> DATA, no ZERO), it is honest: everything is on the other level of
>>>> backing chain.
>>>
>>> I disagree, because filters with or without backing children should work
>>> exactly the same way and just not appear in the backing chain.
>>
>> They work the same way in my variant too. The only difference is that if
>> you use file-child-based filters, you can't do stream/commit around
>> them.
> 
> Which is a bug that’s been know for a long time, and the primary cause
> for the “Deal with filters” series.
> 
>> I just think, that binding the concept to the "backing" link of
>> the node is simpler and more generic. In blockdev era, when all nodes
>> will be named and libvirt will take care of all nodes including filters,
>> we will not need any filter-skipping magic, libvirt will directly point
>> to exact nodes it means. And we can deprecate "file" children of
>> existing filters,
> 
> One thing to note is that all user-creatable filter drivers currently
> use “file”, so this would change them all.
> 
> The idea of just using backing for filters just always seems to me like
> trying to take the easy way out.  It seems to me like many things around
> filters are broken because we weren’t careful enough when introducing
> them (mostly a combination of “let’s see whether it just works” and “it
> seems to mostly work”), and the “Deal with filters” series attempts to
> rectify that.  As evidenced by the reviews that required even more
> preliminary work (like the still on-list and under-discussion
> BdrvChildRole series), there is really a ton of design that should be
> improved.
> 
> That makes me very hesitant to just switch filters over to backing,
> because I feel that might alleviate some of the most pressing symptoms,
> while not addressing the underlying issues.  And without symptoms that
> hurt, nobody might want to fix the issues.  Basically, it feels like
> more of the same “Let’s try whether it mostly works” and “it seems to
> mostly work”.
> 
> (Also, my naïve feeling is that if just treating backing and file the
> same for filter drivers, the deal with filters series would be ten
> patches long and v1 would have been uncontroversial.)
> 

Hmm. OK, I don't know. Probably it's not a big difference: use CAF vs
move filters to backing child. And anyway we may move them later.
Probably it's simpler to fix all the issues, if move the filters to
backing child first, but we already have you series and rebasing it
on another concept is an extra work, not worth doing.

-- 
Best regards,
Vladimir

