Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC9C433F2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00214207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bM2AGvYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00214207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw536-0001Xj-3i
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw52L-00017w-Gj; Thu, 16 Jul 2020 10:39:01 -0400
Received: from mail-eopbgr70105.outbound.protection.outlook.com
 ([40.107.7.105]:39422 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw52H-0007av-5G; Thu, 16 Jul 2020 10:39:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL7Sjs858ZtJJ6/INs8OgfyZmLbtyOWzbeACDHEYaRjgKA6pvcfiRftxN8KqX2h/FT6T5pQ22XUAIwz3aD+hLxAUSVQhqbrQKCVyIufUF0xlwMmzIKMIUy5ePSFgeZRN7ydhkuBUpMgtXpvWOQnyjzhM2MDkeoCQPf+6kCHhJeBEdhSLspxw//6dGaplpbn3IQcKAhm1ED97YPaCR9cGxC2pA5qDKzJfPF5qvcNjYDbiLkN2bPkEy9iMZVW++tAE/r5oqWhxLiUaJCCIVCCvNBz1Mu4v4JBN4T/VyC5rty1VDJ7b22K0Rp1Yf1594RaEZhqeRoVMnRcq0+bVJmttBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CarKAc2Rv2Qa5arFPdMa/n+Kw8btyE2mMyFshPOL/1U=;
 b=gOZiL2Ug5Dkv0BPDDoaZ3vh7w8DYewUjvilbLvROCUPTPbRGSQZXTE7yvJhyt7dSJST1O0cETFCPs5MYH/iD8XK2fxc+bw2uWEFsnq49Z6IfoP+++f5aYWRaMV7yEn2K2xZhqmyOwANcCoeyjvCRbe6YqMxcC55Y2lzCzUOAoXuEWokb1J3z1xgLZ6zBZT1m8HDJX3xmDipGSmKf/wvjww+g0tKSD6VrPLf0oq4jQ1HyUzXg2NAlr/JUCcKqOKu7hClpuVZq3o7KOhl1qZXZHprYMuoh71M/Zt5VP5ver3TlJnW7J2ruMyJtNUmn1V7X2Qi5QrP7rCkDJz985OXG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CarKAc2Rv2Qa5arFPdMa/n+Kw8btyE2mMyFshPOL/1U=;
 b=bM2AGvYQcF+5+yAlLZpNQfBdZkggxKTXQVlDy//xW9AcRl1QFXpLuUMHj9IDT4Ixqp9t8I6BJq2YfKBoHhs8DQ1vAC8bcxIZ/5c1HXTrbfh4cNMQ0dpkhtZ0n7rvtSDabmOYIuJqLzHd8Wz7QPd//Z/DIuSqSQWNFqd0WlgVZzw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4021.eurprd08.prod.outlook.com (2603:10a6:20b:aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 14:38:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 14:38:53 +0000
Subject: Re: [PATCH v10 08/10] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-9-git-send-email-andrey.shinkevich@virtuozzo.com>
 <761829e6-ba9c-c8c0-8f37-976e37fcb6d0@virtuozzo.com>
 <9377dc3f-002f-6761-bb81-17a17cfafb08@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c538f45c-8c00-7f60-c92e-7cc60c128376@virtuozzo.com>
Date: Thu, 16 Jul 2020 17:38:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9377dc3f-002f-6761-bb81-17a17cfafb08@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 14:38:52 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfbbf954-16c0-4ef2-7ce6-08d82995f648
X-MS-TrafficTypeDiagnostic: AM6PR08MB4021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4021922F1032311E10550869C17F0@AM6PR08MB4021.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twa7aoLYQfgfkwq/24QsEvmwm/CCH/RLoQbTaOCU0+3LD4bub/k6DRwdM3bb/XhzkhwZOWGNVbGT+jAT6s9rPKb5R4nVrjqtBokii8KnmpIzqPqYCFfjr8c+PsJ0IxrEU7YLhQkmIAlYZAst6SFMsN5WCLl61o1FTfeWcdU4GMqM35xDB5hL5P0i8yBGdk+n9o8HOioaCwk4v7msUPl4vT2+7r2Ma8VSPh8EpZkE6mKgx1aMR+aSG3PcpoH1KPW5Ycb5f+kwM1PSpOuiWXupEVeCE0KzUj8j4LnITTGDncCLLa5Mgw32SR/SDlPdijQE0O8sepzieM39xTI8YJEq89jUbvhOayTJ29wisZ+nEgcHfibz/a5aDIoJORqVskiL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(396003)(376002)(346002)(366004)(107886003)(16576012)(66476007)(2906002)(5660300002)(8936002)(16526019)(83380400001)(66946007)(956004)(31696002)(2616005)(8676002)(4326008)(186003)(66556008)(31686004)(86362001)(6486002)(26005)(478600001)(316002)(52116002)(53546011)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iklo7z98wCDlbwHfpiZ1DnZEPE85L8sJaRLqImOLaeSshBmSvyqlgaZxptruK2VzkTWbD+gBqTj7T6INUUJIrpg9aVy+ENqo+YxMihhvWUbDb3HpPWNjFbhXc+rVwSqpy6hVRpyPt1eLui4f98JRvxaNV8l64hvec7IYnzYiUWxRjJa57E6TzshUZkdgq5e+x7orhP+uSnvqezAw2LHQpLbg9aIBd06wTbYwrT5Z76WS8+kqf76UQIRlq7JqEvhTWhPdakYlL89qYHQiu0DGaXnlq7ew6QUH0OsWsG1Iihy0AnYh4ndUrc36xs6KHYt0x0Tdwl1LhdDNTauG7INJFTtsBq7n88W/fYCDmf7eK3J5D5OuiZTdNlhlhfAAn/sXdH7dG6bn27JivfnNRUNhJ12T5cadEWzWW95s8RBss2x5favpQJ+wn45aGOuADx99UAjus2mbSGJ4z7vrGW3yeZlKV8VHafDK8Z/sUVCrpIrglFBEqBB+3/P0e81pSMlw
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbbf954-16c0-4ef2-7ce6-08d82995f648
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 14:38:53.2971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0tVQp1zv+uaEU2ohDjIwALKKla+eOnzeOC1fmSSctSri08bLGELKoFH8hBJ1IO8QvqKUh1viFwfO2YMfn8JvFwAFcc9txOFKsI9cMgg5I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
Received-SPF: pass client-ip=40.107.7.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:38:54
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

16.07.2020 17:36, Andrey Shinkevich wrote:
> On 16.07.2020 13:20, Vladimir Sementsov-Ogievskiy wrote:
>> 14.07.2020 00:36, Andrey Shinkevich wrote:
>>> Add the command key to the qcow2.py arguments list to dump QCOW2
>>> metadata in JSON format. Here is the suggested way to do that. The
>>> implementation of the dump in JSON format is in the patch that follows.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/qcow2.py        | 19 +++++++++++++++----
>>>   tests/qemu-iotests/qcow2_format.py | 16 ++++++++--------
>>>   2 files changed, 23 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
>>> index 0910e6a..7402279 100755
> ...
>>> @@ -134,6 +137,11 @@ cmds = [
>>>       def main(filename, cmd, args):
>>> +    global dump_json
>>> +    dump_json = '-j' in sys.argv
>>> +    if dump_json:
>>> +        sys.argv.remove('-j')
>>> +        args.remove('-j')
>>
>> I'd prefer to access sys.argv in one place (in "if __name__ ...").
>>
> 
> In case we move the block
> 
>      global dump_json
>      dump_json = '-j' in sys.argv
> 
>          if dump_json:
>              sys.argv.remove('-j')
> 
> from main() to the body of "if __name__ == '__main__'"
> 
> we get the following error -
> 
> "SyntaxError: name 'dump_json' is assigned to before global declaration"

you don't need "global" declaration outside of a function


-- 
Best regards,
Vladimir

