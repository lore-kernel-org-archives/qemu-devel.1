Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B280C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FF720870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IRmEa61O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FF720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9TfX-0000KG-5E
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j9TeO-0007po-42
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j9TeM-0006CU-V1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:01:24 -0500
Received: from mail-eopbgr70112.outbound.protection.outlook.com
 ([40.107.7.112]:5829 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j9TeD-0005ni-7O; Wed, 04 Mar 2020 08:01:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATbzKEeeATHvLuYaJm7tQj1MtkUC7pBYZpjOixIKf1USVeOOc1+d3tgTtUGxmkmiYC6eunQd2zsZFWHxKjA+bOWXXsJbjmku2jEBF6vTZViZ0oSxin8u0MSaRAe9hfnG5Knc4lg/iziF3Az7aE2EQpE9Tfe/Ew9gqinT3zF3aM2XNm7r7UwbwDpcWx5woAlaOo2XrZ4BUjUO+FlzGZW3yxH7SSqz9hMEIUhUVtGaSzYe149Tz/xDyZQggHYn0NnosSCbTn2cKIOmis7AIigKgzRgXoONvgKYE9jfmf4vWmcfirKhY6C7alQZiEqJaIsZOobEDT4YPYGCWml5nJqeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zMFGSATGBKfWZWvk8/nCW/CafXnUiqoY5t9FoqGCPg=;
 b=Z9b3M7iuvwkOuGUeS87F6is42GSKlqxeXnFmk+/r4rgMY9CYg/bf191es8Qd669n0HLJxvnqWi4rgu0S30Ti6GfIkmcP9152x08mH6ry78Jd6S2XnRpVcIYEmFgFtM4KuxXY52itSIBPa+gMUkbBqSrB6r9d2KXS4YCcGDAvo8SKxfvBm/GCXbYyP6teTe2trzeeRxPMQZ68v/HLwtYPkZX+UQY4oWWG8vFsH+IXnzY6U4SXL5O6w1BeGyzpGtiVzfKw2u9g9oSqk6ewpr+B3Z+XhkcUt32K2qmGsqYuTH1hlggevE+aU3blVS8Y6mHZcLcK1SMaZ513KxtGTBcQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zMFGSATGBKfWZWvk8/nCW/CafXnUiqoY5t9FoqGCPg=;
 b=IRmEa61OIqb4iE95JuMitEO1S0Su0cFsIfPt3Cv8QsvyeZEjRxscuqMBdf5VAearGAPGIAGWFJONlPKWgkjzWwQG6Yt0fW8SiiaYgacP9XbV6HRjS27Jaho4V5k/DEx4gj84O0/y1YZq0Cx8ryz3MaG8Ck6JnrUJ2wRUN2kAkVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5524.eurprd08.prod.outlook.com (52.132.213.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 13:01:10 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 13:01:10 +0000
Subject: Re: [PATCH v4 5/5] iotests: 287: add qcow2 compression type test
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-6-dplotnikov@virtuozzo.com>
 <3d79452c-a2e9-06f5-ebf1-5edb3ac24108@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <50f794d4-ea00-33a4-ed08-854179b93f79@virtuozzo.com>
Date: Wed, 4 Mar 2020 16:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <3d79452c-a2e9-06f5-ebf1-5edb3ac24108@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0102CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::34) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.241.117) by
 HE1PR0102CA0057.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Wed, 4 Mar 2020 13:01:09 +0000
X-Originating-IP: [94.233.241.117]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c01c08e-d98f-424d-5040-08d7c03c1c61
X-MS-TrafficTypeDiagnostic: AM0PR08MB5524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB55248EE04A1E1487E0520933CFE50@AM0PR08MB5524.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(346002)(39850400004)(396003)(199004)(189003)(956004)(8936002)(16576012)(86362001)(31686004)(186003)(8676002)(26005)(4326008)(316002)(53546011)(36756003)(81166006)(16526019)(31696002)(5660300002)(52116002)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(81156014)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5524;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eT1I6NfpCy3vzlbBA+J1oO5Cj0rHJv3LQ9Qb6geloziQYwKgIPY93vqwF2vi4SJetMuCSuegQbQOmI3oLlvjykCgxWP9GD0CA0GhK4anFuC71CN0P8YPU+vq/cv96E23Lw4H4A8szgbIQUnZCEoNEt1OINeprrElHZlYM/1PMlO9S1PI8+g5CgnMeb1i7pyTHPcESXdqBcHzSOFrEJdp2vVrV3CKAkeT2a7OTlrmeZ6XEDiApoEehaAExmO7+gWl3gV8LBc+u2DEEbW5pRU3tmiWb7hjOEihGs9cYBxZUbbDNHotztjxVp0fFheHaNTEaAbWB6fegEyNRqb4V8FpC3xZHP8zk4L25XFZPoJXGERrhA9A/VttR5n+IOGyb3WVQnG6EXkHjEfyQbdi8qvi/hAMWTuqSEBWO2fxsnPGRHdLT+ngUULrQsl6OWhGu6Gr
X-MS-Exchange-AntiSpam-MessageData: rB7wv4sOH5vZNBBpJkSpf0z9etunFehthtvuKzIuqki3/Alk4uCdWSLyScT584I09tNRk0JMwZ8OuxOl6iKUtKrA9LBdehStPnIuVtWT/NGFmAG1Mhn5rwyN5Z92SR3/j5GE0ch27Mdmf++/6RZNMA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c01c08e-d98f-424d-5040-08d7c03c1c61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 13:01:10.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poAHKxCB7GlGLcInPEBFqJlVglUciILHP8vjoHUIAj+3/LLZUrgmfGOoOIsd2UKTl0tD1Y6ash8+2uzJO6Z3cUA5DVkSqG0ScZyry6pwadU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5524
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.112
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 04.03.2020 14:27, Vladimir Sementsov-Ogievskiy wrote:
> 03.03.2020 16:34, Denis Plotnikov wrote:
>> The test checks fulfilling qcow2 requiriements for the compression
>> type feature and zstd compression type operability.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/287=C2=A0=C2=A0=C2=A0=C2=A0 | 127 ++++++++++++=
+++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/287.out |=C2=A0 43 +++++++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 171 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/287
>> =C2=A0 create mode 100644 tests/qemu-iotests/287.out
>>
>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>> new file mode 100755
>> index 0000000000..39cb665c85
>> --- /dev/null
>> +++ b/tests/qemu-iotests/287
>
> [..]
>
>> +# Test: using zstd compression, write to and read from an image
>> +echo
>> +echo "=3D=3D=3D Testing reading and writing with zstd =3D=3D=3D"
>> +echo
>> +
>> +CLUSTER_SIZE=3D65536
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>
> As I understand, you should define env variable assignments on the=20
> same line
> with _make_test_img so that they be passed to it, like
> CLUSTER_SIZE=3D65536 IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 6=
4M
It works like a regular env variable and can be defined on another line=20
above.
Anyway, I'll move "CLUSTER_SIZE=3D65536" to the beginning of the test to=20
avoid any confusions.
>
> with this:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Thanks for reviewing the series! l'll send v5 with all modifications=20
shortly.

Denis
>
>> +$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
>
> you may s/65536/64k/
>
>> +$QEMU_IO -c "read -P 0xAC 65536 65536 " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
>> +
>
>
> [..]
>
>


