Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3024BC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 05:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5AB21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 05:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TtnIzczp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5AB21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ovY-00075w-3U
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 00:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6oup-0006Zl-6L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 00:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6ouk-00089u-Sz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 00:07:23 -0500
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com
 ([40.107.21.91]:42613 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6oue-0007tj-Oo; Wed, 26 Feb 2020 00:07:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZtvSIO8wm41vBbatDBqOo8JGW61qJSY27DqFtFUYif8QfvO3GjBO9Dt6WClJXt6Z+qKgq98ziXGBZiltlfUfcqYaXE1eVnSr+1quQthBeAzVj1+xLpu15AQprPO+k7Ijc4xCtIfgoAfX0CzzAfsTem1skmI/D+FZdW7uHth5fFfsMJg8j3vZL2saEKEUOR8OLKQzYyU4CfexMP60r9m+luw4t0oKn9HM1OBreY0hzNcpNO3YvJXK4Y20eQ4oLaT8LvzYpnH0UYIF59bQgFKwyEH8I8ETqvEVet3l5yJwraydvMoBJnfUmf7yh/k3HSdDrOLyWroDrVS1FdzhPc6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBwgHNRz/9zNSsPzpAFr2FL1Cmqr+j73GSQQ9sNgwMA=;
 b=SNc9QHOOe0//Qd0mYLbQUGo6R+/pp1xuT/5FamsMwqX7L2synTaK2GBQK0H+GMEWtRaxdCLb6bAcildL1KfRjyaCThdt1Mg/QDNTLzKcK8I7Jb8sUvMi8zF1rMpddtVRgJHPxpmC17K1H7wj1YKD90mmTx6hCFSy06xCppMSWGZXJYtfsGxjIhzSN6vCk8nZeBp6X3ldzfbI9dMRmuY7SbHE+A0Oww16+mLbR9SVAB3W/4Cuq/ILeUYU73RXgcGS3bGKsceqhKB7ESSBunrutTfCG73s8xIAGA8bRo3eeGvmgFeB0AhdnXT3IHGhCWZda8G344LJKngeT5Yn7TFVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBwgHNRz/9zNSsPzpAFr2FL1Cmqr+j73GSQQ9sNgwMA=;
 b=TtnIzczpHFFxlc8iucdoHZcTiPeKXtwoRE+A73/Xk1VM9KJPVBmKTnNhSIJfCvo51ZRsGsK8b7s8qGtIp7V85E/F6hu0QdRZsU7BCSZScUcrNhOHztXwtTelzzOSrTggikBzqlnTSFO2cF+MqDR7rEqz7rbogLD6G67Opkb0Uos=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4625.eurprd08.prod.outlook.com (10.255.98.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 05:07:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 05:07:09 +0000
Subject: Re: [PATCH 1/6] block: add bitmap-populate job
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-2-jsnow@redhat.com>
 <ede1d2b6-0af9-0002-dc33-b82aa870119f@virtuozzo.com>
 <5c03a2b5-7cba-b347-da80-f9d9acaccb6e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200226080706984
Message-ID: <d462c95f-a616-1ddb-f0fd-650be113c384@virtuozzo.com>
Date: Wed, 26 Feb 2020 08:07:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5c03a2b5-7cba-b347-da80-f9d9acaccb6e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:7:29::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR02CA0090.eurprd02.prod.outlook.com (2603:10a6:7:29::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Wed, 26 Feb 2020 05:07:08 +0000
X-Tagtoolbar-Keys: D20200226080706984
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7558af35-3fe7-4b7f-a4d5-08d7ba79bb54
X-MS-TrafficTypeDiagnostic: AM6PR08MB4625:
X-Microsoft-Antispam-PRVS: <AM6PR08MB46252A93A03A22D5DEF157B1C1EA0@AM6PR08MB4625.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39850400004)(189003)(199004)(52116002)(66556008)(54906003)(53546011)(7416002)(8676002)(66476007)(31696002)(81156014)(86362001)(16576012)(81166006)(66946007)(6486002)(8936002)(2906002)(316002)(956004)(5660300002)(26005)(36756003)(30864003)(186003)(16526019)(4326008)(478600001)(31686004)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4625;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAs09OGLE176Hz6CRIbMvTS0IqOtfvljE9AQrDL1wWWZedaV0tDKqaelcJuPVUWs3139rFL1r26uyTYcEvQn7njSWpVPYdEIRYSEJchhCdT7uJJiqMy1zVOK4BoGcEeiN2AX1wPkelLnJdci89p9WvqGNGvTHz2Q68ndxwJ+k+/m6uIT198eji9Z6zbVrUd2oBxH+RG4EVkqegI9XHhW/4Y0aMIPfyjahssbr7BRkEqkUPJ3mCcpm6XaTHlinKfGzPrLnn8V4ZfC/xhCXoUWfpB7J9rq5y6JdwSWyg3C9yb+9MsLVUKqaanW2TtyQni9tRl2Rc+c7GvoBAmydOQaNKzr1rByP24rrZ+paQwKX/GBWTkFHjmOzw0p5qhP8tt7N+sUSSiTGrmhsQr68rTPS4kRCv1zKSIirWIMbZDrRxODveAJiX4oveKmh92NBQQ8
X-MS-Exchange-AntiSpam-MessageData: SoIkk8s9+eh0wfv9h2g5UIz3lNJNtCRqbCjmJc1ju1E56IE7u93RbI1kLz7ikKImZF0ePeQP5Zfq5hH5inO9tcWtrLo1eONL7JrJNIbqXKm5ECwKKrZyUOjZf67em9x24u5pULH3blPPJ9qAYFEk0Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7558af35-3fe7-4b7f-a4d5-08d7ba79bb54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 05:07:09.5039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQdCnsiu9o7PiwcvKaDHAUD4cwk3sI9gbaKj8rhlPQ/S7Xtxy0EvdSMjefobsWkPTfLhO/qAkevz9GFAkNHfyu4xW3P1DtvuECXQIc56+O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4625
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.91
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 23:41, John Snow wrote:
>=20
>=20
> On 2/25/20 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 25.02.2020 3:56, John Snow wrote:
>>> This job copies the allocation map into a bitmap. It's a job because
>>> there's no guarantee that allocation interrogation will be quick (or
>>> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.
>>>
>>> It was designed with different possible population patterns in mind,
>>> but only top layer allocation was implemented for now.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 48 +=
++++++++
>>>  =C2=A0 qapi/job.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>  =C2=A0 include/block/block_int.h |=C2=A0 21 ++++
>>>  =C2=A0 block/bitmap-alloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 207 ++++++=
++++++++++++++++++++++++++++++++
>>>  =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>>  =C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>>>  =C2=A0 6 files changed, 280 insertions(+), 2 deletions(-)
>>>  =C2=A0 create mode 100644 block/bitmap-alloc.c
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 85e27bb61f..df1797681a 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -2245,6 +2245,54 @@
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 'command': 'block-dirty-b=
itmap-merge',
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'data': 'BlockD=
irtyBitmapMerge' }
>>>  =C2=A0 +##
>>> +# @BitmapPattern:
>>> +#
>>> +# An enumeration of possible patterns that can be written into a bitma=
p.
>>> +#
>>> +# @allocation-top: The allocation status of the top layer
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of the attached storage node.
>>> +#
>>> +# Since: 5.0
>>> +##
>>> +{ 'enum': 'BitmapPattern',
>>> +=C2=A0 'data': ['allocation-top'] }
>>> +
>>> +##
>>> +# @BlockDirtyBitmapPopulate:
>>> +#
>>> +# @job-id: identifier for the newly-created block job.
>>> +#
>>> +# @pattern: What pattern should be written into the bitmap?
>>> +#
>>> +# @on-error: the action to take if an error is encountered on a bitmap=
's
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at=
tached node, default 'report'.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 's=
top' and 'enospc' can only be used if the block device
>>> supports
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io=
-status (see BlockInfo).
>>> +#
>>> +# @auto-finalize: When false, this job will wait in a PENDING state
>>> after it has
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished its work, waiting for @block-job-final=
ize
>>> before
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 making any block graph changes.
>>
>> sounds a bit strange in context of bitmap-population job
>>
>=20
> Yeah, you're right. Copy-pasted for "consistency".
>=20
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 When true, this job will automatically
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 perform its abort or commit actions.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults to true.
>>> +#
>>> +# @auto-dismiss: When false, this job will wait in a CONCLUDED state
>>> after it
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 has completely ceased all work, and awaits
>>> @block-job-dismiss.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 When true, this job will automatically disappear
>>> from the query
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list without user intervention.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Defaults to true.
>>> +#
>>> +# Since: 5.0
>>> +##
>>> +{ 'struct': 'BlockDirtyBitmapPopulate',
>>> +=C2=A0 'base': 'BlockDirtyBitmap',
>>> +=C2=A0 'data': { 'job-id': 'str',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'pa=
ttern': 'BitmapPattern',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*o=
n-error': 'BlockdevOnError',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*a=
uto-finalize': 'bool',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*a=
uto-dismiss': 'bool' } }
>>> +
>>>  =C2=A0 ##
>>>  =C2=A0 # @BlockDirtyBitmapSha256:
>>>  =C2=A0 #
>>> diff --git a/qapi/job.json b/qapi/job.json
>>> index 5e658281f5..5f496d4630 100644
>>> --- a/qapi/job.json
>>> +++ b/qapi/job.json
>>> @@ -22,7 +22,7 @@
>>>  =C2=A0 # Since: 1.7
>>>  =C2=A0 ##
>>>  =C2=A0 { 'enum': 'JobType',
>>> -=C2=A0 'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
>>> +=C2=A0 'data': ['commit', 'stream', 'mirror', 'backup', 'create',
>>> 'bitmap-populate'] }
>>>  =C2=A0 =C2=A0 ##
>>>  =C2=A0 # @JobStatus:
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 6f9fd5e20e..a5884b597e 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -1215,6 +1215,27 @@ BlockJob *backup_job_create(const char *job_id,
>>> BlockDriverState *bs,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb, void *opaque,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobTxn *txn, Error **errp);
>>>  =C2=A0 +/*
>>> + * bitpop_job_create: Create a new bitmap population job.
>>> + *
>>> + * @job_id: The id of the newly-created job.
>>> + * @bs: Block device associated with the @target_bitmap.
>>> + * @target_bitmap: The bitmap to populate.
>>> + * @on_error: What to do if an error on @bs is encountered.
>>> + * @creation_flags: Flags that control the behavior of the Job lifetim=
e.
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See @BlockJobCreateFlags
>>> + * @cb: Completion function for the job.
>>> + * @opaque: Opaque pointer value passed to @cb.
>>> + * @txn: Transaction that this job is part of (may be NULL).
>>> + */
>>> +BlockJob *bitpop_job_create(const char *job_id, BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BitmapPattern pattern,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int creation_flags,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb, void *opaque,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 JobTxn *txn, Error **errp);
>>> +
>>>  =C2=A0 void hmp_drive_add_node(Monitor *mon, const char *optstr);
>>>  =C2=A0 =C2=A0 BdrvChild *bdrv_root_attach_child(BlockDriverState *chil=
d_bs,
>>> diff --git a/block/bitmap-alloc.c b/block/bitmap-alloc.c
>>> new file mode 100644
>>> index 0000000000..47d542dc12
>>> --- /dev/null
>>> +++ b/block/bitmap-alloc.c
>>> @@ -0,0 +1,207 @@
>>> +/*
>>> + * Async Dirty Bitmap Populator
>>> + *
>>> + * Copyright (C) 2020 Red Hat, Inc.
>>> + *
>>> + * Authors:
>>> + *=C2=A0 John Snow <jsnow@redhat.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>>> later.
>>> + * See the COPYING file in the top-level directory.
>>> + *
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +
>>> +#include "trace.h"
>>> +#include "block/block.h"
>>> +#include "block/block_int.h"
>>> +#include "block/blockjob_int.h"
>>> +#include "block/block_backup.h"
>>> +#include "block/block-copy.h"
>>
>> I hope, not all includes are needed :)
>=20
> Whoops, no, of course not. I copied the skeleton from backup, as you can
> tell ;)
>=20
>>
>>> +#include "qapi/error.h"
>>> +#include "qapi/qmp/qerror.h"
>>> +#include "qemu/ratelimit.h"
>>> +#include "qemu/cutils.h"
>>> +#include "sysemu/block-backend.h"
>>> +#include "qemu/bitmap.h"
>>> +#include "qemu/error-report.h"
>>> +
>>> +typedef struct BitpopBlockJob {
>>> +=C2=A0=C2=A0=C2=A0 BlockJob common;
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *new_bitmap;
>>> +=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t len;
>>> +} BitpopBlockJob;
>>> +
>>> +static const BlockJobDriver bitpop_job_driver;
>>> +
>>> +static void bitpop_commit(Job *job)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBlock=
Job, common.job);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_merge_internal(s->target_bitmap, =
s->new_bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NU=
LL, true);
>>
>> Hmm, so you populate new_bitmap, and then merge to target. Why can't we
>> work
>> directly with target bitmap? The most probable case is that libvirt will
>> create bitmap specifically to use as target in this operation, or not?
>>
>=20
> Most likely case, yes. Odds are very good it will be a brand new bitmap.
>=20
> However, we already have a creation command -- I didn't want to make a
> second job-version of the command and then maintain two interfaces, so I
> made it a "merge into existing" style command instead.
>=20
>> Hmm, just to make it possible to cancel the job and keep the target
>> bitmap in
>> original state? Is it really needed? I think on failure target bitmap
>> will be
>> removed anyway..
>>
>=20
> You caught me being *lazy*. I copy the bitmap so I can unconditionally
> enable it to catch in-flight writes without having to create block graph
> modifications.
>=20
> But, yes, to undo changes if we cancel.
>=20
> I didn't want to make a job that was not able to be canceled. The
> alternative is pursuing the design where we allow new bitmaps only --
> because then on cancel we can just delete them.

On backup job (and any other) we can't rollback target changes on cancel.
So, I think it would be OK to take same semantics for the new job, keeping =
in
mind that it would be most probable usage case and no sense in creating
additional bitmaps. And if caller needs to use existent non-empty bitmap as
target and wants correct cancel, it always can create additional bitmap by
itself and then merge it to actual target.

And why new? It's up to user, what to use as target. And user knows, that o=
n
failure or cancel target becomes invalid and will workaround this if needed=
.

>=20
>>> +}
>>> +
>>> +/* no abort needed; just clean without committing. */
>>> +
>>> +static void bitpop_clean(Job *job)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBlock=
Job, common.job);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(s->new_bitmap);
>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(s->target_bitmap, false)=
;
>>> +}
>>> +
>>> +static BlockErrorAction bitpop_error_action(BitpopBlockJob *job, int
>>> error)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return block_job_error_action(&job->common, job->on=
_error, true,
>>> error);
>>> +}
>>> +
>>> +static bool coroutine_fn yield_and_check(Job *job)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (job_is_cancelled(job)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 job_sleep_ns(job, 0);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (job_is_cancelled(job)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return false;
>>> +}
>>> +
>>> +static int coroutine_fn bitpop_run(Job *job, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBlock=
Job, common.job);
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int64_t offset;
>>> +=C2=A0=C2=A0=C2=A0 int64_t count;
>>> +=C2=A0=C2=A0=C2=A0 int64_t bytes;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (offset =3D 0; offset < s->len; ) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (yield_and_check(job)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -ECANCELED;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes =3D s->len - offset;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_is_allocated(s=
->bs, offset, bytes, &count);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(bitpop_error_action(s, -ret) =3D=3D
>>> BLOCK_ERROR_ACTION_REPORT) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!count) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D 0;
>>
>> Hmm, I think it's impossible case.. If so, better to make an assertion
>> or ignore..
>>
>=20
> OK, agreed.
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr=
v_set_dirty_bitmap(s->new_bitmap, offset, count);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_progress_update(job, co=
unt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset +=3D count;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +static const BlockJobDriver bitpop_job_driver =3D {
>>> +=C2=A0=C2=A0=C2=A0 .job_driver =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D sizeof(BitpopBlockJob),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .job_type=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D JOB_=
TYPE_BITMAP_POPULATE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .free=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D block_job_free,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .user_resume=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D block_job_user_resu=
me,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .run=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D bitpop_run,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D bitpop_commit,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clean=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D bitpop_clean,
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +};
>>> +
>>> +
>>> +BlockJob *bitpop_job_create(
>>> +=C2=A0=C2=A0=C2=A0 const char *job_id,
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap,
>>> +=C2=A0=C2=A0=C2=A0 BitmapPattern pattern,
>>> +=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error,
>>> +=C2=A0=C2=A0=C2=A0 int creation_flags,
>>> +=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb,
>>> +=C2=A0=C2=A0=C2=A0 void *opaque,
>>> +=C2=A0=C2=A0=C2=A0 JobTxn *txn,
>>> +=C2=A0=C2=A0=C2=A0 Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int64_t len;
>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *job =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 int64_t cluster_size;
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *new_bitmap =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 assert(bs);
>>> +=C2=A0=C2=A0=C2=A0 assert(target_bitmap);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!bdrv_is_inserted(bs)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Device is=
 not inserted: %s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_get_device_name(bs));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Why this?
>>
>=20
> I assumed there was nothing to read the allocation map *of* if there
> wasn't a media present.
>=20
> Am I mistaken?

is_inserted checks existing of bs->drv, but bitmap operations actually
doesn't need any drv.. Hmm. I'm not against this check anyway.

>=20
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOU=
RCE, errp)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> and this?
>>
>=20
> Copy-paste: I don't understand if I want a new op blocker, to re-use an
> op-blocker, or to have no op blocker.
>=20
> Genuinely I have no idea. I should left a review comment here, I forgot
> about this part, sorry.

I'm for no op blocker. As I understand, op-blockers are old and should be
replaced by permissions and frozen children. So, if we don't know, do we
need any blocking here, better go on without it. Also, op-blockers can't
block forbidden usage through filters anyway.

>=20
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BIT=
MAP_DEFAULT,
>>> errp)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (pattern !=3D BITMAP_PATTERN_ALLOCATION_TOP) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unrecogni=
zed bitmap pattern");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 len =3D bdrv_getlength(bs);
>>> +=C2=A0=C2=A0=C2=A0 if (len < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -len=
, "unable to get length for '%s'",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_get_device_name(bs));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* NB: new bitmap is anonymous and enabled */
>>> +=C2=A0=C2=A0=C2=A0 cluster_size =3D bdrv_dirty_bitmap_granularity(targ=
et_bitmap);
>>> +=C2=A0=C2=A0=C2=A0 new_bitmap =3D bdrv_create_dirty_bitmap(bs, cluster=
_size, NULL, errp);
>>> +=C2=A0=C2=A0=C2=A0 if (!new_bitmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Take ownership; we reserve the right to write in=
to this
>>> on-commit. */
>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(target_bitmap, true);
>>
>> Honestly, I still have bad understanding about how should we use dirty
>> bitmap mutex,
>> but note that bdrv_dirty_bitmap_set_busy locks the mutex. And it is (may
>> be) possible,
>> that busy status of the bitmap is changed after bdrv_dirty_bitmap_check
>> but before
>> bdrv_dirty_bitmap_set_busy.=C2=A0 So, more correct would be do both oper=
ation
>> under one
>> critical section. Still, I don't know is the situation possible.
>>
>=20
> Aren't we under the BQL here? Can we be pre-empted? :(

Seems we are. But, as it's said above dirty_bitmap_mutex declaration:

     /* Writing to the list requires the BQL _and_ the dirty_bitmap_mutex.
      * Reading from the list can be done with either the BQL or the
      * dirty_bitmap_mutex.  Modifying a bitmap only requires
      * dirty_bitmap_mutex.  */

It means, that another thread may modify bitmap (for example its 'busy' fie=
ld)
taking only dirty_bitmap_mutex, which will lead to the case I described.

>=20
>>> +
>>> +=C2=A0=C2=A0=C2=A0 job =3D block_job_create(job_id, &bitpop_job_driver=
, txn, bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BLK_PERM_CONSISTENT_READ,
>>
>> Do we need it? We are not going to read..
>>
>=20
> Copy-paste / leftover from an earlier draft where I was trying to
> achieve atomicity. It can be removed if we don't want the stricter
> atomicity.
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BLK_PERM_ALL & ~BLK_PERM_RESIZE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0, creation_flags,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 cb, opaque, errp);
>>> +=C2=A0=C2=A0=C2=A0 if (!job) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(=
target_bitmap, false);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(n=
ew_bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 job->bs =3D bs;
>>> +=C2=A0=C2=A0=C2=A0 job->on_error =3D on_error;
>>> +=C2=A0=C2=A0=C2=A0 job->target_bitmap =3D target_bitmap;
>>> +=C2=A0=C2=A0=C2=A0 job->new_bitmap =3D new_bitmap;
>>> +=C2=A0=C2=A0=C2=A0 job->len =3D len;
>>> +=C2=A0=C2=A0=C2=A0 job_progress_set_remaining(&job->common.job, job->l=
en);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return &job->common;
>>> +}
>>> diff --git a/blockjob.c b/blockjob.c
>>> index 5d63b1e89d..7e450372bd 100644
>>> --- a/blockjob.c
>>> +++ b/blockjob.c
>>> @@ -56,7 +56,8 @@ static bool is_block_job(Job *job)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return job_type(job) =3D=3D JOB_TYPE_BA=
CKUP ||
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 job_type(job) =3D=3D JOB_TYPE_COMMIT ||
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 job_type(job) =3D=3D JOB_TYPE_MIRROR ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type(=
job) =3D=3D JOB_TYPE_STREAM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type(=
job) =3D=3D JOB_TYPE_STREAM ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type(=
job) =3D=3D JOB_TYPE_BITMAP_POPULATE;
>>>  =C2=A0 }
>>>  =C2=A0 =C2=A0 BlockJob *block_job_next(BlockJob *bjob)
>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>> index 3bcb35c81d..f3cfc89d90 100644
>>> --- a/block/Makefile.objs
>>> +++ b/block/Makefile.objs
>>> @@ -36,6 +36,7 @@ block-obj-$(CONFIG_LIBSSH) +=3D ssh.o
>>>  =C2=A0 block-obj-y +=3D accounting.o dirty-bitmap.o
>>>  =C2=A0 block-obj-y +=3D write-threshold.o
>>>  =C2=A0 block-obj-y +=3D backup.o
>>> +block-obj-y +=3D bitmap-alloc.o
>>>  =C2=A0 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>>>  =C2=A0 block-obj-y +=3D throttle.o copy-on-read.o
>>>  =C2=A0 block-obj-y +=3D block-copy.o
>>>
>>
>>
>=20
> Thanks for the review. I'll start making changes, but won't send V2 just
> yet.
>=20
> --js
>=20


--=20
Best regards,
Vladimir

