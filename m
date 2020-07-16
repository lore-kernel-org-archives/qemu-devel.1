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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B31C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF0F2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PSq+GHi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF0F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw60Z-0000zK-KX
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw5zf-0000N1-5X; Thu, 16 Jul 2020 11:40:19 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:12676 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw5za-00078q-Ll; Thu, 16 Jul 2020 11:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJQG0LY1z+ohM0AE7IYt1US5KbLHOKkIxlerMgkDu42Lyl6JMbz+wN3LaJA9cAJqBY1bpt4YloAwpDtlDt7rCwjxEbwdwDd3X9poQQz3FxNQ95hE7OPI3iajLF/vE37h9qONG/B7jzCFkBKZp75ID3ZvmdevnP7yoI5bl2b/wWU8YezsQWquPrTBu0TjrHemWbZ5mLJ41QKZqQZSL4fvXrHn+1ucUjVtKWgEr8VKMiMB7B35z9ZBakMn/0ZLsnCZeyO81vCSPxFR4QOYDHPPUht0DWq1kkEs7pXp9UHKoi07or+hGTc0NeP61mrnORewbZc9/gfbGGZo5guiGddgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WjnbGhJZ5uPETXvKeNe5K05vaBM++hQcA22CVV1TK0=;
 b=b4UW+nA5vxGxzHOdoebPfH7d81kTrKUyrYWmuakIXKHWWu6TMiYDA34NO6W+JTv3u5VpdSxWC4QzfGwSsJt7EuGhT8iOB7dxIbQfVnnYXRs1nBi0bmHMi/Iq1vQxiR5ldRe0yt//a3oF269MAwXz/8DD7T1K403rDAk1NM/K48JJQ8jO4TrTAptUykDPGgyE+uMmkMa0ryu4PzFu2xW8I+9sgtALoyN85B816e/KMItvWbIvsxhJyq/J/8XXWUh4uF06CregHM7QPk7SA682UUg7f00C4zTAspaAcNNVryp7PWhwsu6n1RmUGI7J0tDUIpIwHoxXpVTsrkrrfJADOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WjnbGhJZ5uPETXvKeNe5K05vaBM++hQcA22CVV1TK0=;
 b=PSq+GHi7KNBTE8hs/859IZTvRsLrcBKptNpGLWG+Q2TPeUjHACM5RLLDDLT7frtVn6X6kRFx7YtVp7dER19fFORx91i0gg+zfjBYSQAb8mKjpsOVh3kIYJaATLCgwbdXnq1vpTHXfBxH9qETPmd378urcpnKJwBt5wweeny8pAg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3223.eurprd08.prod.outlook.com (2603:10a6:209:4d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 15:40:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 15:40:11 +0000
Subject: Re: [PATCH v10 09/10] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7397fb42-13a3-b86b-83fd-3df62114f4f6@virtuozzo.com>
 <3e22fb08-2fd1-c0bc-8b83-2ded1a090720@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <77d809ff-d42d-55ee-b65d-c5fa69dcc394@virtuozzo.com>
Date: Thu, 16 Jul 2020 18:40:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3e22fb08-2fd1-c0bc-8b83-2ded1a090720@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0080.eurprd07.prod.outlook.com
 (2603:10a6:207:6::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR07CA0080.eurprd07.prod.outlook.com (2603:10a6:207:6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.16 via Frontend Transport; Thu, 16 Jul 2020 15:40:10 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca368252-94a1-4b98-59e8-08d8299e8678
X-MS-TrafficTypeDiagnostic: AM6PR08MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3223F5BC95D7FEB4D2D4BC6AC17F0@AM6PR08MB3223.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAZmJDVn/Q2tG3Ns6oFBjAZ0UBfmFKY0Ke6GkdOMZ6z+4aI54UbFd6I+jQB2+0LilpBLTcZ7gsfEy1px09UG8SpDy+X4ajj/VVzX4Q9VxL/TuJJhzvpp5uqrLSgw8328EQqjEj+xpwJySx0nfVo0bP9It7BX0s4gsllJQ5r9xyOkzLN8N6MMK+FseUGySWi1dMdO/9N1YbRLglskQ0/wI06/d2sU5SMISoGL4LdSFDAWNmL5OVpTrlvhEfjXZUfzY/A37Jyq08lmiSrUyKK2iTalzLKcDpYwj1ONflpffFrHPKWW/cxAier6adlc4arvMIIkECEZLMEw7eJWHh47s+2deUbYPDuIP9N9XhB7sBOVluUde9ufct+alOboxgCq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(107886003)(4326008)(26005)(5660300002)(8936002)(478600001)(36756003)(2616005)(956004)(2906002)(66556008)(316002)(8676002)(66476007)(86362001)(83380400001)(186003)(31686004)(6486002)(16526019)(53546011)(31696002)(16576012)(52116002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 34dl3TBFiqHd66ODSSu7EFn0hAm4iga0TwSfj3FvvZQLP7hRRhIdFh3obsEh+G+R3WlE6aOGvmdbxPJlhs68ABRy3FuHbPh4f+ORgFRVY+CUOFl6kO/oaYujsqOS3sVVf1c7xjD4sRbjqQopd6nvF/Pz5toiIlHd0rDVklliVbrVo2qiCb9mIYkeLJ+qSxTWIjRwJT+HDsccQfran4L4LHUHsVWP25KWI8jIyms2ncBgSvu3gkALh/RQWrXUDodRmr9t8t3bbPaK1GDM/wcV/Do4liHDK2J7tfrG28yxyEXiQNN6ZHRol0C3ohm9MxJqwztoIe80Y5uf1E6L1iKQ2jsxRPxH1yY9WmipsvwJz2Rr/3Xor3SP+cQD2VhithEPP6wMhon9QnVdPkd2+J0d/Dlws6EC/sVNbEiplPYyPqPvJ/Q940XYao6EB1Qa0tdUiaPO4BydF4S2dNQMceQTqP4wPWAT3rfVR0DxJ4aTdKRGi1sLHnySIzlmoyf0gyWV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca368252-94a1-4b98-59e8-08d8299e8678
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:40:11.2094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4pKEBjFTLEV78SpACI6Nd4DBgXMjjgUzztHfHoSe73HpzH2B/jdKnq7uTVUg9+lxkqiavUN3SK9f4f8Yz8b765xr+64mE0MxtHiHJMyXn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3223
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 11:40:12
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

16.07.2020 18:34, Andrey Shinkevich wrote:
> On 16.07.2020 13:24, Vladimir Sementsov-Ogievskiy wrote:
>> 14.07.2020 00:36, Andrey Shinkevich wrote:
>>> As __dict__ is being extended with class members we do not want to
>>> print, make a light copy of the initial __dict__ and extend the copy
>>> by adding lists we have to print in the JSON output.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/qcow2_format.py | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>> index e0e14b5..83c3482 100644
>>> --- a/tests/qemu-iotests/qcow2_format.py
>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>> @@ -109,6 +109,8 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>>           self.__dict__ = dict((field[2], values[i])
>>>                                for i, field in enumerate(self.fields))
>>>   +        self.fields_dict = self.__dict__.copy()
>>
>> No, I don't like that. Keeping two copies of all the data is bad idea. If you want to select some fields, add a method (dump_json() ?) Which will collect the fields you want in a dict and return that new dict. But don't store object attributes twice.
>>
> 
> Not really. It makes a light copy that stores only references to the desired fields.
> 

I'm not about memory consumption, I'm about the design. Keeping two representations of same thing is always painful to maintain.

> 
>>> +
>>>       def dump(self, dump_json=None):
>>>           for f in self.fields:
>>>               value = self.__dict__[f[2]]
>>> @@ -144,6 +146,7 @@ class Qcow2BitmapExt(Qcow2Struct):
>>>           self.bitmap_directory = \
>>>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>>>                for _ in range(self.nb_bitmaps)]
>>> + self.fields_dict.update(bitmap_directory=self.bitmap_directory)
>>>         def dump(self, dump_json=None):
>>>           super().dump(dump_json)
>>> @@ -189,6 +192,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>>           table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
>>>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>>> cluster_size=self.cluster_size)
>>> +        self.fields_dict.update(bitmap_table=self.bitmap_table)
>>>         def dump(self, dump_json=None):
>>>           print(f'{"Bitmap name":<25} {self.name}')
>>>
>>
>>


-- 
Best regards,
Vladimir

