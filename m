Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BFBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5607E21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a1XP3aQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5607E21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpPl-00042J-B2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLpNZ-0002z8-Jf; Fri, 25 Sep 2020 11:11:21 -0400
Received: from mail-eopbgr00123.outbound.protection.outlook.com
 ([40.107.0.123]:18309 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLpNW-0004Al-MI; Fri, 25 Sep 2020 11:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSBkDhXaobwSub2UaBnnEV2QWGL/gRmrUzfnciZEXwOjbYl0SSJttOKXr6mBwsNlYDbGt0Zd0XldVAwMHRM44uvVGeuCWxAFA9wXGxIE8Q8Y2rlOEi63I3fIKcejStzV0vog1EKYXuAf+7GT4huB9qcfAHKwh3LhZa0EJvWIaAFLfEKcmUFvVYXvUfbypMl/7B3+S2xnLjgluyJJCqTWA4b4XwwWnlWMirmmCQ5qImVVTHhUezd20S6SrkYu5whNcnsDlNkW7gqjbogzm1YyISeN+SJ0uO3/W5RawqeJiP14kOIIZt2aQBFyzGgnnuGz4VpWRhFyBy0UOiqeqSXN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ki9rUFV7IOrWRBkR9nWpC7TdsV8BMSq1p7SBDvaVfY=;
 b=fhTUj7vepkh0t1+FxZFDBBmBTiv4cGOjefNKMhvy/iLpUwszDTdCkoJdCWuiaP00WBOpT6d9zaDN8AhWgLqRn7ugs8EVN8NaanEgpXzbynZFeI16Uxs6Id5/RKtawfOAP16l8+sWfM9EFXa2Hy7zMGYqT6NRgPG/eG07uy7qzQ0Ojf2jYY4DPwHyLqPLnIR20eEIcyXjnFcn+E9W6hFYTyRXhiSbK7XJFlFudAe8gGlrotF4/9eH8Tt7HYz+PIIV8PlL5D9Xl50fouAOC5VW4Ktm2Zs8BTVeKd1HrykLtTIYMnclwYwb4Xqix3iTLcby16srvSAN0C1Av0BrSzfnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ki9rUFV7IOrWRBkR9nWpC7TdsV8BMSq1p7SBDvaVfY=;
 b=a1XP3aQoCuDNRcW0VoUVjr1QmiiUqPswdjeDz4gC+rFx+lQNpKqK31JjkoU92YhUoHSC2GiQo72FAdTSIrY9Se/NMDN7zfNlzHLNjlXYL/YKBpcH+cEYMLBwNnHGwmFdlUV6/TiLwsApGNDY5tfqhTXuXTySzUolyCh2PhZzLKc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2529.eurprd08.prod.outlook.com (2603:10a6:203:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 25 Sep
 2020 15:11:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 15:11:15 +0000
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
 <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
 <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
 <d36a27c8-0f2c-ede5-6f97-e134093dcf6e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9d324820-cb15-84a6-574d-f92846e16928@virtuozzo.com>
Date: Fri, 25 Sep 2020 18:11:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <d36a27c8-0f2c-ede5-6f97-e134093dcf6e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Fri, 25 Sep 2020 15:11:14 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c34c0076-1ba6-4004-1348-08d861653f07
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2529:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB252932A890488CF65A18C75CC1360@AM5PR0802MB2529.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ragoGHYYgnm17mog9kRcxOiz75dMxwzcBGl179wUAErBhmuwDKb+Jwbx+1Tmq73y1+GP9PrZUoqEhViBvkssL1jX+Ij6KtHhTaOtUkPEptu8gPVoeuQQuzSEzdLcRJSU88fj5D2KH0JVy7qHjD6L6KCbRujlHRAZPUH1m/Nc7kNun5Ov4bKvKbc2xgY2jCYf/9Qe2AR5OIvnIikMg09kP673Cv2+ZqDMpkuhXvNX3JKCRLqqTcdEKBsRTrtIOVrcXI26I6xP0TfCYTjyVg2QnyErmBYl2/urvLtxNqUfqPR2szVYbQCD4K8+SoztGw0BVXAJG43LVF5cUiWgsR0wVZdfOsYPtCnVJdUoHj2JxXT3kVbeCI3eALHza9GHyUk8Ez58/CrkySXjEh/HW0Uuwf/Kdvqnysxjfhg5z23MtJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39840400004)(366004)(346002)(136003)(8936002)(2906002)(31696002)(86362001)(31686004)(16576012)(8676002)(316002)(36756003)(83380400001)(107886003)(4326008)(478600001)(2616005)(66476007)(66556008)(6486002)(5660300002)(186003)(53546011)(16526019)(26005)(52116002)(66946007)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0jpf5UXHTHKQ2851ESBBrueInEOqfNPBVXog4JZ7wGDPNzlX1khRy9LZpltA1hZPQUumRIp10eUECsj828Il+Bgr39OOJ/TmJXdvEBD663n5c8HnjKZm8GX5xIHvTjLXkhp0YA8+C5RJrenG1RXwQolZ8q/ntOKxumkwJC6EjPB0umIWRn4OfFU5+MM1uJFrKCNbzKIIgm6caxsPvnuwxqvbV7Uf2VN8ApG3dow7pcOzS8pm8xhoJWrBAOyx9OvRD6TiuDFUk1468hYHo/4Z3f3gC17FnlBFKz+r3xsFESkuyR02rXqPT9cAVk1bAVfKzetxL9WjbA2u8hdEqibPG2AKvbDQ5Ei59L0dMwc4eRG7PpKi+FgK1t7EDvGkxjcwPv/c8nX3sFgmPEEJsirXIHOeuMnrxiaVnAEE3jOLTxBr4L/i/GxO5/ACcGEk/VL5nvc+JvPTz5DlsLWI16hdS6NkHAoHNHms4Cm/v7igxfteTi7PjfIwhqzUA7G17J0ShwreK5daYQr3TZr/QZ1OQHHg/3lrWw4ZZ5nbjCbkVwKLVanjCsfYK/+2XyIFEsgWEkLfrqJSuCweu4xCGcH6zm3HiTm5+C25k1cXIYhVh1wGFc13wpvjoLBq/7Ag8qI2vrnivHUduo1ehrlx1UaJKg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34c0076-1ba6-4004-1348-08d861653f07
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 15:11:15.2344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7X/stCjAdqOjvDyoPw1hzOelngBJLLU2Q7zUsJr7NE6Sb8eX4gd/dXT9tiWZkvzSZfzIapXi05SwCrI/OaymaaEhzRMJgy9Pp77ONXi9ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2529
Received-SPF: pass client-ip=40.107.0.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 11:11:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_LOW=-0.7,
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

25.09.2020 12:11, Max Reitz wrote:
> On 25.09.20 10:49, Vladimir Sementsov-Ogievskiy wrote:
>> 25.09.2020 11:26, Max Reitz wrote:
>>> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    tests/qemu-iotests/298     | 186 +++++++++++++++++++++++++++++++++++++
>>>>    tests/qemu-iotests/298.out |   5 +
>>>>    tests/qemu-iotests/group   |   1 +
>>>>    3 files changed, 192 insertions(+)
>>>>    create mode 100644 tests/qemu-iotests/298
>>>>    create mode 100644 tests/qemu-iotests/298.out
> 
> [...]
> 
>>>> +class TestTruncate(iotests.QMPTestCase):
>>>
>>> The same decorator could be placed here, although this class doesn’t
>>> start a VM, and so is unaffected by the allowlist.  Still may be
>>> relevant in case of block modules, I don’t know.
>>
>> Or just global test skip at file top
> 
> Hm.  Like verify_quorum()?  Is there a generic function for that already?
> 
> [...]
> 
>>>> +        # Probably we'll want preallocate filter to keep align to
>>>> cluster when
>>>> +        # shrink preallocation, so, ignore small differece
>>>> +        self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
>>>> +
>>>> +        # Preallocate filter may leak some internal clusters (for
>>>> example, if
>>>> +        # guest write far over EOF, skipping some clusters - they
>>>> will remain
>>>> +        # fallocated, preallocate filter don't care about such
>>>> leaks, it drops
>>>> +        # only trailing preallocation.
>>>
>>> True, but that isn’t what’s happening here.  (We only write 10M at 0, so
>>> there are no gaps.)  Why do we need this 1M margin?
>>
>> We write 10M, but qcow2 also writes metadata as it wants
> 
> Ah, yes, sure.  Shouldn’t result in 1M, but why not.
> 
>>>> +        self.assertLess(abs(stat.st_blocks - refstat.st_blocks) * 512,
>>>> +                        1024 * 1024)
>>>
>>> [...]
>>>
>>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>>> index ff59cfd2d4..15d5f9619b 100644
>>>> --- a/tests/qemu-iotests/group
>>>> +++ b/tests/qemu-iotests/group
>>>> @@ -307,6 +307,7 @@
>>>>    295 rw
>>>>    296 rw
>>>>    297 meta
>>>> +298 auto quick
>>>
>>> I wouldn’t mark it as quick, there is at least one preallocate=full of
>>> 140M, and one of 40M, plus multiple 10M data writes and falloc
>>> preallocations.
>>>
>>> Also, since you mark it as “auto”, have you run this test on all
>>> CI-relevant hosts?  (Among other things I can’t predict) I wonder how
>>> preallocation behaves on macOS.  Just because that one was always a bit
>>> weird about not-really-data areas.
>>>
>>
>> Ofcourse, I didn't run on all hosts. I'm a bit out of sync about this..
> 
> Well, someone has to do it.  The background story is that tests are
> added to auto all the time (because “why not”), and then they fail on
> BSD or macOS.  We have BSD docker test build targets at least, so they
> can be easily tested.  (Well, it takes like half an hour, but you know.)
> 
> (We don’t have macOS builds, as far as I can tell, but I personally
> don’t even know why we run the iotests on macOS at all.  (Well, I also
> wonder about the BSDs, but given the test build targets, I shouldn’t
> complain, I suppose.))
> 
> (Though macOS isn’t part of the gating CI, is it?  I seem to remember
> macOS errors are generally only reported to me half a week after the
> pull request is merged, which is even worse.)
> 
> Anyway.  I just ran the test for OpenBSD
> (EXTRA_CONFIGURE_OPTS='--target-list=x86_64-softmmu' \
>     make vm-build-openbsd)

Oh, I didn't know that it's so simple. What another things you are running before sending a PULL?

> and got some failures:
> 
> --- /home/qemu/qemu-test.PGo2ls/src/tests/qemu-iotests/298.out  Fri Sep
> 25 07:10:31 2020
> +++ /home/qemu/qemu-test.PGo2ls/build/tests/qemu-iotests/298.out.bad
> Fri Sep 25 08:57:56 2020
> @@ -1,5 +1,67 @@
> -.............
> +qemu-io: Failed to resize underlying file: Unsupported preallocation
> mode: falloc
> +qemu-io: Failed to resize underlying file: Unsupported preallocation
> mode: falloc
> +FFFF.F...F...
> +======================================================================
> +FAIL: test_external_snapshot (__main__.TestPreallocateFilter)
>   ----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "298", line 81, in test_external_snapshot
> +    self.test_prealloc()
> +  File "298", line 78, in test_prealloc
> +    self.check_big()
> +  File "298", line 48, in check_big
> +    self.assertTrue(os.path.getsize(disk) > 100 * MiB)
> +AssertionError: False is not true
> +
> +======================================================================
> +FAIL: test_prealloc (__main__.TestPreallocateFilter)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "298", line 78, in test_prealloc
> +    self.check_big()
> +  File "298", line 48, in check_big
> +    self.assertTrue(os.path.getsize(disk) > 100 * MiB)
> +AssertionError: False is not true
> +
> +======================================================================
> +FAIL: test_reopen_opts (__main__.TestPreallocateFilter)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "298", line 119, in test_reopen_opts
> +    self.assertTrue(os.path.getsize(disk) == 25 * MiB)
> +AssertionError: False is not true
> +
> +======================================================================
> +FAIL: test_qemu_img (__main__.TestQemuImg)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "298", line 61, in test_qemu_img
> +    self.check_big()
> +  File "298", line 48, in check_big
> +    self.assertTrue(os.path.getsize(disk) > 100 * MiB)
> +AssertionError: False is not true
> +
> +======================================================================
> +FAIL: test_truncate_inside_preallocated_area__falloc
> (__main__.TestTruncate)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "298", line 161, in test_truncate_inside_preallocated_area__falloc
> +    self.do_test('falloc', '50M')
> +  File "298", line 135, in do_test
> +    self.assertEqual(ret, 0)
> +AssertionError: 1 != 0
> +
> +======================================================================
> +FAIL: test_truncate_over_preallocated_area__falloc (__main__.TestTruncate)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "298", line 173, in test_truncate_over_preallocated_area__falloc
> +    self.do_test('falloc', '150M')
> +  File "298", line 135, in do_test
> +    self.assertEqual(ret, 0)
> +AssertionError: 1 != 0
> +
> +----------------------------------------------------------------------
>   Ran 13 tests
> 
> -OK
> +FAILED (failures=6)
> 
>> If I don't put new test in "auto", is there any chance that test would
>> be automatically run somewhere?
> 
> I run all tests before pull requests at least.
> 
> Max
> 


-- 
Best regards,
Vladimir

