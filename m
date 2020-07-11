Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF1C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DE920725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wtc2kAJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKuy-0003cl-Pf
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 15:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juKu9-00038o-5M; Sat, 11 Jul 2020 15:11:21 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:6981 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juKu6-0003i3-2K; Sat, 11 Jul 2020 15:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIxF+c+g4VJFlr7vFWDtsvwL6CzqcBClR7UEqMd5hmLLcttBaly54WlGeXzBzL2TnaFGCz021g09E093TId/q0vnpc/izJap9iA6dcOFCoUQ3llABR7vRGnsIaI30vud2fECrpWAvHbp54NOXb9BjFQJihsYF+SxtI2kVkPJ6fq3ZPkrebRlzFTBNHuLx5NIv5zAVoZwWVLlnb1gWrDO3JUD4HJlU/yGNTNZp3gAV+w51SlRHB8By3ZfIt3DZXZtFg60ZmTUX42wX1VbhOBgniU2k0WZYoqkrZQkJIObNjKDmoPc2KMXRluobjCxL3nnHFX9zCER1xrV3Ri9Z+n/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cf8oqxULhIt9lVamA4ZCEzmYpuQcdgu8su+uWaKu5Q=;
 b=d28KTotyLjIItBP1dqw0/S+tGE8wru8NobIlhxJGpKeD1W/F5dIM8McvsHxRRAhGtbSutLbz/4gXsXPhOnn8JlAGolImw8xU1j71mOa34XsvKs3cVv/LaQOJl/MLahnT5PmpAy4Z3CjeFEGKY5bS9FyqdHRRXO980hZjQSVG112oAHU/SQYZKSCKs2kc9uFLxXop+wffAszSj2ZSnhoLTUNeJRjYI7g7fxyvQkyswgm7SX2iBuSmd7OIYp3Ov6l0NBv4fHXtxe9PL+dCL5+Ah7NaSzzCwvclSbHdYfc7rlxidy8xfQmi8bGksmkz1o5+9YPszq5FLpS5t5MCqzrSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cf8oqxULhIt9lVamA4ZCEzmYpuQcdgu8su+uWaKu5Q=;
 b=wtc2kAJ1yrnq/KOt1+hXiiLLCT9q4PbVq4IzxOZpBoFRJvly3jw6MycWxzkbmimOAHV6UXuJ9j1S2o0ltosBlOZPb/7DCXebGa9ZgwkA9oJwL0uhr00Q29ZHyCme2JHpUJ0cH6ijF9ZCI3Kwgv8TLkxzYBdfKpUWRI3BOCvDbQY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1777.eurprd08.prod.outlook.com (2603:10a6:203:3a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Sat, 11 Jul
 2020 19:11:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 19:11:14 +0000
Subject: Re: [PATCH v8 05/10] qcow2_format.py: Dump bitmap directory
 information
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e3b87637-92cd-fc56-9344-c8c9d7329dd3@virtuozzo.com>
Date: Sat, 11 Jul 2020 22:11:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1593782030-521984-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:208:be::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR04CA0094.eurprd04.prod.outlook.com (2603:10a6:208:be::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Sat, 11 Jul 2020 19:11:13 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f772dfb1-94eb-4e1a-3bb7-08d825ce2e3e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB17772D4E16A87D7B6CE84918C1620@AM5PR0801MB1777.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7V5arMX61S/ydUyH2yJSrj4gPN9zVpsp31z+CFEXa/EN2rT7IdgI+FM/+8UnGos7QsW24lWDORqwMMCly+IbjQEfVrovtjMsjQ9hDVhC2ESE8lHWGjRIoKsXkTYM//vDkaUoefSl05B6/4WfCDgTrGrM6l+l5GXKvZmXVcLthXhyw6/g+YV0tYVOUMSA3w+sMUsIMvf3LYeUV2amyVyzL0PuqIlJbhvQLWz2esbvQs/3WkG/CPGoM4YROIa6OlJAVbFUWiD3T8pmYLVg3PqHKEqgwXfScbFqr20nfgtp0jQkgihsEEVU3KE302wkOsyKdeFT/QDmTfqwJJLKtLy7zZ0FwW526fOn4p9oaeevDPQz2SJINeOUss38v/O4TAd0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(31696002)(83380400001)(316002)(36756003)(16576012)(5660300002)(6486002)(107886003)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(8936002)(16526019)(478600001)(186003)(86362001)(2616005)(52116002)(26005)(956004)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4zyvAUEsjXm+te86T+uy4HOh3HtD1LC+pWfqyk9vive4YQ/OdueHVPXbcLz3e7L+hqNmbuI6WP3nq/5yRh+74QOaunAT1ZNemC9fzJX0+SDNOo757EDC+8IR/0MxnX9rRWQ1WLQydEB34BTvxmSbWW6tY8JYXduP2IGyvjpypNyGDG0PyUaGxb1vZDWethj7JNueZ2Ex40QNsQGf4tbSDtXNc1xhRlQbVxig+nV8aH7ZvV8S70QwOam9NU0KpbmhTvBUUvGgXRcsXLJ1bDYoaQuAQZ9gkji33chROYWP7ur1nDl5eRamFO5JZYtTRUgbi5LZ/4RBvpIxAebpTHoHg7Er98MkW7nVyG9XGfHcZmuvmIdx1fUMKIeVWsCnY6O1KabwO0XbfiXppm1yNFjPGt2pfnZf20wXb8ZAgD+Ne963bbibro9NjjLL1fksQxEXHFtCu+D7sFsv/dRqnE5PMUS2coJ0mMgEpaAKr4ivg2VLXWsYcMib9dHV9rpVqXCD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f772dfb1-94eb-4e1a-3bb7-08d825ce2e3e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 19:11:14.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivOBO4ciENycYQOXepc1Px8J3xQb0g2nOFF+4sgvuh0M0ZODtJz8s9WyaFsoMrH0Yf+NbVwYsxfd40iA7ZNV7OebRt4uGAm1e3bVW4LT5HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1777
Received-SPF: pass client-ip=40.107.7.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 15:11:15
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

03.07.2020 16:13, Andrey Shinkevich wrote:
> Read and dump entries from the bitmap directory of QCOW2 image.
> It extends the output in the test case #291.
> 
> Header extension:
> magic                     0x23852875 (Bitmaps)
> ...
> 
> Bitmap name               bitmap-1
> bitmap_table_offset       0xf0000
> bitmap_table_size         1
> flags                     0x2 (['auto'])
> type                      1
> granularity_bits          16
> name_size                 8
> extra_data_size           0
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/291.out         | 45 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/qcow2_format.py | 44 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
> 
> diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
> index 08bfaaa..53a8eeb 100644
> --- a/tests/qemu-iotests/291.out
> +++ b/tests/qemu-iotests/291.out
> @@ -33,6 +33,24 @@ reserved32                0
>   bitmap_directory_size     0x40
>   bitmap_directory_offset   0x510000
>   
> +Bitmap name               b1
> +bitmap_table_offset       0x4e0000
> +bitmap_table_size         1
> +flags                     0x0 ([])
> +type                      1
> +granularity_bits          19
> +name_size                 2
> +extra_data_size           0
> +
> +Bitmap name               b2
> +bitmap_table_offset       0x500000
> +bitmap_table_size         1
> +flags                     0x2 (['auto'])
> +type                      1
> +granularity_bits          16
> +name_size                 2
> +extra_data_size           0
> +
>   
>   === Bitmap preservation not possible to non-qcow2 ===
>   
> @@ -98,6 +116,33 @@ reserved32                0
>   bitmap_directory_size     0x60
>   bitmap_directory_offset   0x520000
>   
> +Bitmap name               b1
> +bitmap_table_offset       0x470000
> +bitmap_table_size         1
> +flags                     0x0 ([])
> +type                      1
> +granularity_bits          19
> +name_size                 2
> +extra_data_size           0
> +
> +Bitmap name               b2
> +bitmap_table_offset       0x490000
> +bitmap_table_size         1
> +flags                     0x2 (['auto'])
> +type                      1
> +granularity_bits          16
> +name_size                 2
> +extra_data_size           0
> +
> +Bitmap name               b0
> +bitmap_table_offset       0x510000
> +bitmap_table_size         1
> +flags                     0x0 ([])
> +type                      1
> +granularity_bits          16
> +name_size                 2
> +extra_data_size           0
> +
>   
>   === Check bitmap contents ===
>   
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index d8c058d..7c0dc9a 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -132,6 +132,50 @@ class Qcow2BitmapExt(Qcow2Struct):
>   
>       def __init__(self, fd):
>           super().__init__(fd=fd)
> +        self.read_bitmap_directory(fd)
> +
> +    def read_bitmap_directory(self, fd):
> +        fd.seek(self.bitmap_directory_offset)
> +        self.bitmap_directory = \
> +            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]

sounds good. I think, we should restore fd position after reading bitmap_directory, to point at the end of extension, to not break further extensions loading

> +
> +    def dump(self):
> +        super().dump()
> +        for entry in self.bitmap_directory:
> +            print()
> +            entry.dump()
> +
> +
> +class Qcow2BitmapDirEntry(Qcow2Struct):
> +
> +    fields = (
> +        ('u64', '{:#x}', 'bitmap_table_offset'),
> +        ('u32', '{}', 'bitmap_table_size'),
> +        ('u32', BitmapFlags, 'flags'),
> +        ('u8',  '{}', 'type'),
> +        ('u8',  '{}', 'granularity_bits'),
> +        ('u16', '{}', 'name_size'),
> +        ('u32', '{}', 'extra_data_size')
> +    )
> +
> +    def __init__(self, fd):
> +        super().__init__(fd=fd)
> +        # Seek relative to the current position in the file
> +        fd.seek(self.extra_data_size, 1)
> +        bitmap_name = fd.read(self.name_size)
> +        self.name = bitmap_name.decode('ascii')
> +        # Move position to the end of the entry in the directory
> +        entry_raw_size = self.bitmap_dir_entry_raw_size()
> +        padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
> +        fd.seek(padding, 1)
> +
> +    def bitmap_dir_entry_raw_size(self):
> +        return struct.calcsize(self.fmt) + self.name_size + \
> +            self.extra_data_size
> +
> +    def dump(self):
> +        print(f'{"Bitmap name":<25} {self.name}')
> +        super(Qcow2BitmapDirEntry, self).dump()
>   
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
> 


-- 
Best regards,
Vladimir

