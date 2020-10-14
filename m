Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6908DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C49B2072C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Irntvq0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C49B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkpb-0008SF-9e
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSkoX-0007uZ-OR; Wed, 14 Oct 2020 13:43:49 -0400
Received: from mail-eopbgr30098.outbound.protection.outlook.com
 ([40.107.3.98]:24479 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSkoU-00060r-Rr; Wed, 14 Oct 2020 13:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgrSk7Pb6ibvATFvcwwa06r7pHxk8F4RWPkuVqZZjo36w1qSySvjkQQ+VOTnbQ9kfQ3cJgWT/XuHtGgqWCQfwF+zBL9euCCQbmRJZ5CN/sKeIQ66tqrC88nJutsmYDEzeFK+12b5xIWh/k8GUT33rjdtgEXbjYoDuDbPMKHL5CUEyNCIKXUS+/oBschgQpXVvnC7jHAgIRTHfFz1au3TA2phblxOygIN7/5LTer4orfVaqT7iANGEGFoUpZiUebNI9NP5vLeMriaLIh1Hr3mmb9kLAfFBiIE2w1cJ6mNfBS7n+LRxACbkajdrYR9xGc3ZPIbfBJBueg9kGZ7s+bY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLQxo5v/KzYvjiXLV/kYmzObBkVZuoT+W1B0ZXI4zog=;
 b=XPIMQ6FOtWuu9tYu0OOts8KeXXbXa69OAmuILD9Joiov/VETEqeNUIrQ+wWyrPF49X4EAgUq4sciGEVOwAJnxmFep8fS8d48YHzt40JBfWabHZaCbBm6lwMRCXNhATF5Olc5ovx/m4KInnGrdBhTIwO7XLIgykr9MF8GRz5NBHPA7+R0raQQ/vDcOAJCy16hvK05KnbY1+ZW+MJS9yUhRN3Lu5MVJ29k8Q9vd/EcdxQ9f9aJ+NUtd6OXspZaTgDJqUGhqZyutkmQTYS9OPUORe6La28G04r2iTDyuGExiK6PIRBlwkhX1z9Y0XSrxPGW921ozOjYqX+XaJJQhhAGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLQxo5v/KzYvjiXLV/kYmzObBkVZuoT+W1B0ZXI4zog=;
 b=Irntvq0XfMCMLxAfNXJ+PhoRbthggIjM3ni9Sde1yUfemb2gLFgDX63gLW+AVLWhhT0+QYCOxFW5OROzZalDhxwsElc2GUVEhZq379DQ8IFIrD5EIe4OkHtZl3P0nlW6wMIAlbTJ8PAyf2PEKs/zHutObFYoIP54oVoxsW6TOpY=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2652.eurprd08.prod.outlook.com (2603:10a6:7:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 17:43:39 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 17:43:38 +0000
Subject: Re: [PATCH v11 05/13] copy-on-read: limit COR operations to base in
 COR driver
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a938ce00-70ee-7f6e-f4f6-08630c49e843@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <dbc95282-cc06-b1c9-99ae-c206c2d00b2e@virtuozzo.com>
Date: Wed, 14 Oct 2020 20:43:35 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <a938ce00-70ee-7f6e-f4f6-08630c49e843@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR03CA0074.eurprd03.prod.outlook.com (2603:10a6:208:69::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 17:43:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1959f8f-1e6d-4fb4-5541-08d87068aeeb
X-MS-TrafficTypeDiagnostic: HE1PR08MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2652DAFF2DF85BE135D3BD29F4050@HE1PR08MB2652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRvDpOrVBQ//KzzJ3+JcBrfoC2zc9An5JnBNY+hK7F1Ijprec4iku8ahE0LqBEp81oU7S1UStqKIBS+YRAEiZDdcXU9iaOr1ydrnM8Gq17pGG0IlcOEtwbaoWj+MwkMYaoKgUlWl8BxVGJAwPrwclgCH30TLNfK373DU5B/EgK105Kea/ssHjtHlpABEareeScuS1NLzlktWZKIY2cm5eVlsoXnVaynCJjMaWyfAzzN91fa663QrNXUR6djQZlTebhWMOMRtte3+ugiHZVD7222S1og/so5JPbQQHTdQLI4TUc2bKqx8MPvUTx35jPkAlWMt+c5cgut90zV4SmC56YAx7GfyCSf8aaIK2GT0QECYJ3elWlDtaOVfNnB+l6rZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(346002)(376002)(366004)(396003)(136003)(26005)(956004)(2616005)(7416002)(52116002)(5660300002)(83380400001)(86362001)(31696002)(53546011)(107886003)(36756003)(2906002)(6512007)(6506007)(4326008)(6486002)(316002)(8676002)(44832011)(66556008)(66946007)(478600001)(8936002)(16526019)(31686004)(186003)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eYjjytn+btvFupriTTdu3Q7/EF8YHVQL2Aa4OWUWQ4ffZbMJfo6o4aV/0EtB05aIcmFpGDSPsxm0tUVIXSmIsGos2OJQEZKf3lx6bGcnBFUYdEiH55kbx6wHHV5zCTh857+QEg0lw/rKVxxNo3XwJDdKVdMK5a8sWyGldMG9xcfaxJP7vCKc0AN9BCupMcAVIoClHbeGXco+sE/y79oPVUG8eNsw7+I8hkvTn6Vm7MyHw1WCE4mDLTPWCdtZWvOK/YkJV1ouZkCdc7val4edC3XJGKHD2G9pyfBo4kjvlLMFMkSws0vpy8DFEMfB1FC7Mmszg4A6AIqu8uV4g6ChMpL0N5YLcEFbQ6v+sKYfiwB/w02Q3fHk4D/ikOvwWr+hx31G/okpnJjBaQXu3q1MwKAYRbyPhnKtOWR5Git2F3Wxv7WFOc45y7s/m61FyTW6TzaRWUy8K2LoXojYOlwgPoSW3yVf3l2udawUTnd7SI2XHzhSxq5Ahcsk9NKMDobtAyNbZ4lcSfxy9YlSOuYiOgyLZjJcNKcuQWhcZJEgfY7u72cmMjCUnA1+HfHuuYoE06acrER7Zu6juERF5wFKUWhipHVXH+9gkdxTVoA6A5a6x5gOPmPEli5k6tmS1oFqnH89g6ZJqlyjzicN0fJTsA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1959f8f-1e6d-4fb4-5541-08d87068aeeb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 17:43:38.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2EmqC3M2tOmOlYDxNVTSHAmxVZckugZIZvkPq/F6K08mFkOx3QQB6G2Ksd0YBXO36g2ZZ0Mt8YDiPPCayPwdRQp0ccXPMpMg1nHV5O8SoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2652
Received-SPF: pass client-ip=40.107.3.98;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 13:43:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 14.10.2020 14:59, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Limit COR operations by the base node in the backing chain when the
>> overlay base node name is given. It will be useful for a block stream
>> job when the COR-filter is applied. The overlay base node is passed as
>> the base itself may change due to concurrent commit jobs on the same
>> backing chain.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 39 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index c578b1b..dfbd6ad 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -122,8 +122,43 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>>                                              size_t qiov_offset,
>>                                              int flags)
>>   {
>> -    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
>> -                               flags | BDRV_REQ_COPY_ON_READ);
>> +    int64_t n = 0;
>> +    int64_t size = offset + bytes;
>> +    int local_flags;
>> +    int ret;
>> +    BDRVStateCOR *state = bs->opaque;
>> +
>> +    if (!state->base_overlay) {
>> +        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
>> +                                   flags | BDRV_REQ_COPY_ON_READ);
>> +    }
>> +
>> +    while (offset < size) {
>> +        local_flags = flags;
>> +
>> +        /* In case of failure, try to copy-on-read anyway */
>> +        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
>> +        if (!ret) {
> 
> In case of failure, a negative value is going to be returned, we won’t
> go into this conditional block, and local_flags isn’t going to contain
> BDRV_REQ_COPY_ON_READ.
> 
> So the idea of CORing in case of failure sounds sound to me, but it
> doesn’t look like that’s done.
> 

Yes, it's obvious. That was just my fault to miss setting the additional 
condition for "ret < 0". Thank you for noticing that.

Andrey

>> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
> 
> I think this should either be bdrv_backing_chain_next() or we must rule
> out the possibility of bs->file->bs being a filter somewhere.  I think
> I’d prefer the former.
> 
>> +                                          state->base_overlay, true, offset,
>> +                                          n, &n);
>> +            if (ret) {
> 
> “ret == 1 || ret < 0” would be more explicit (and in line with the “!ret
> || ret < 0” probably needed above), but correct either way.
> 
> Max
> 

