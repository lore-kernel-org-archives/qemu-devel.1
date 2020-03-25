Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4DDC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 04:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332DB20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 04:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J/O/owRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332DB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGxf3-0005OV-Cn
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 00:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGxeI-0004vf-QS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 00:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGxeH-0008PH-1M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 00:28:14 -0400
Received: from mail-eopbgr30136.outbound.protection.outlook.com
 ([40.107.3.136]:23022 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGxeC-0008GF-3z; Wed, 25 Mar 2020 00:28:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y807gv04RIHP7gXqiH1/vReKygLygWigcVovBfBanZXQ0h2UPNWAuT5Mp11369/E+nBL5hdHCmwZkaHRG/gf0zBL1V3JTiy6JEOAFiqytX6rfKbSpGBXfEk9IUZrJ1++D7pGfDBr++4VG3og6vjj9FSArEuXvYXhgSpwY94Ut0QRp843vy+6c3FNIw/vQuZbFnRgqiFHIvmtQJ/39i1Rt4GhH+O6y6xL+H7C0+DLRDAl0OynP24ggXGbqogtCMRIeaV6C0xTCKanQvzk6XL5i7o++PgpwWx2BVaWEBWYxt7SnaWLr30VU8EDRdD5dqQjAwFGHhSfHHCk/LoKFz7WcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROPEmkjIhipmk+j+N9aLF+1nya0CI9ZMv6vNiEimcKQ=;
 b=WmLNm9LXtFlgUmI8u34Md+uFJ5eTPR/fIi4mZfPaGuD7I3oDKdcWm+zwz4QW/+/CwDRtyKt92a6YaiEgVxjQ0cHcY7QYNcp5ryYyKYRxFpwHrG9phB2P57o1H2u7UdBlDK7a9H/Unzg9owSDbWmmmmOApvbFEYTweLtaW7Q1JCA7xhLJlIvcnENdE0yvvsxf2DQWNmRjOf0APWR9DrjFBmyEEP7yH4eZcm3lL4RtvUD8nsFTFk3hJ9M7nHD+wgY8hhwA6cZ1F+BEnq3wRiPnXk9ooJ3PDJfpu4vCVIGFozE5nLDYSGU2ceFT9pz0T+uVx5B99mjxGZujVFfhHQI8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROPEmkjIhipmk+j+N9aLF+1nya0CI9ZMv6vNiEimcKQ=;
 b=J/O/owRgTRY7QDGSZq4y8on04QyPWxkrEu1ib0pwhlXyQhFYNMMdKFdmTOY5VOwMKz6Fnm5Yb0Qw/EdTrK3qYNhShd+uRf9u0cp7y0oRX7sBT61jPuJUjMeSCtchBeSshcmnmbziVxBCQ/WnLXaSISbxvmIqTLp1HsdF2UGYcgo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5319.eurprd08.prod.outlook.com (10.141.175.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 04:28:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 04:28:05 +0000
Subject: Re: [PATCH 6/6] qga/commands-posix: fix use after free of local_err
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-7-vsementsov@virtuozzo.com>
 <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200325072802438
Message-ID: <3e28eab6-a7c8-a9b3-84bf-b98e241139cc@virtuozzo.com>
Date: Wed, 25 Mar 2020 07:28:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0142.eurprd05.prod.outlook.com
 (2603:10a6:7:28::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR05CA0142.eurprd05.prod.outlook.com (2603:10a6:7:28::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 04:28:04 +0000
X-Tagtoolbar-Keys: D20200325072802438
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c3b8a8-82db-4c3a-91af-08d7d074e9f8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5319FFEA10D1BE4FD906DB74C1CE0@AM7PR08MB5319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(186003)(16526019)(16576012)(6486002)(478600001)(26005)(31686004)(53546011)(7416002)(86362001)(5660300002)(4326008)(2616005)(2906002)(956004)(8936002)(66946007)(81166006)(81156014)(66556008)(66476007)(36756003)(31696002)(52116002)(8676002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5319;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wrd+gjoSCQjipyam7IWj25VcKUNhFwyLm1F2vxZlAv+m2mFcrSdJeDSXNA+5ewADVhC941Sjbz/shwLJk/D846IgU0DuQ6oTpZob8STGIODXD5osGvnGiU0zdDiPh2yE4W/f8D1zE7fqPiTxLzz7EmD0CP/SipKtA/v2O55iAATC+1dRSDJvqW1e/0PiykjwEfE+aD7DvmGwjKQy5htEJWLu4TWqmLrfLjXjN7SCIUgMcvtIsBjc4vbEmOcFw0AU41vdH2c3FmSPBqNRgufLjqeH5iO4cqwCvke4wbnbiHka2LGhuKV9rXX/Rg8P44LOY7x11ZCtMsWLtz6QveUo0SK4BvvuL668oblrTQ/FPLkG5rPpsKJyWroIsPhB83876qDa8Uca+zEbybEmIOnWA8HoME2TxkJI2f9hVfSmV7XEi1wAx4Rhh7IsD/SjS8O9
X-MS-Exchange-AntiSpam-MessageData: GI/8YQBDlyWPF9MM2VSV0R8SMewynNwf6KT3QCWcjXM6HiXxZtr0oXaTxito3Yojs31e5Kv287XKLxNL/T7f0/tbrv2NlTR8Gdu8vL/hq9EwRTWuAOSt1GJs3rFye2bUmgqVZSdsgGMmXLHPkIBe6A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c3b8a8-82db-4c3a-91af-08d7d074e9f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 04:28:05.8132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXHsYQ4qXKNCA2X6cUm1P/bc+ZPUx+rbNQGxAaHtoAE/rR9s8XfbpWxVwjTKx7TGm3w/I/4WJvBDjsjGHyUP3mnN2+7GrjyYxJMZC+W8bX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.136
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 marcandre.lureau@redhat.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.03.2020 23:03, Eric Blake wrote:
> On 3/24/20 10:36 AM, Vladimir Sementsov-Ogievskiy wrote:
>> local_err is used several times in guest_suspend(). Setting non-NULL
>> local_err will crash, so let's zero it after freeing. Also fix possible
>> leak of local_err in final if().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 qga/commands-posix.c | 3 +++
>> =A0 1 file changed, 3 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 93474ff770..cc69b82704 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1773,6 +1773,7 @@ static void guest_suspend(SuspendMode mode, Error =
**errp)
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 error_free(local_err);
>> +=A0=A0=A0 local_err =3D NULL;
>=20
> Let's show this with more context.
>=20
>> static void guest_suspend(SuspendMode mode, Error **errp)
>> {
>> =A0=A0=A0 Error *local_err =3D NULL;
>> =A0=A0=A0 bool mode_supported =3D false;
>>
>> =A0=A0=A0 if (systemd_supports_mode(mode, &local_err)) {
>=20
> Hmm - we have an even earlier bug that needs fixing.=A0 Note that systemd=
_supports_mode() returns a bool AND conditionally sets errp.=A0 But it is i=
nconsistent: it has the following table of actions based on the results of =
run_process_child() on "systemctl status" coupled with the man page on "sys=
temctl status" return values:
> -1 (unable to run systemctl) -> errp set, return false
> 0 (unit is active) -> errp left unchanged, return false
> 1 (unit not failed) -> errp left unchanged, return true
> 2 (unused) -> errp left unchanged, return true
> 3 (unit not active) -> errp left unchanged, return true
> 4 (no such unit) -> errp left unchanged, return false
> 5+ (unexpected from systemctl) -> errp left unchanged, return false
>=20
> But the comments in systemd_supports_mode() claim that ANY status < 4 (ot=
her than -1, which means we did not run systemctl) should count as the serv=
ice existing, even though the most common status is 3.=A0 If our comment is=
 to be believed, then we should return true, not false, for status 0.
>=20
> Now, back to _this_ function:
>=20
>> =A0=A0=A0=A0=A0=A0=A0 mode_supported =3D true;
>> =A0=A0=A0=A0=A0=A0=A0 systemd_suspend(mode, &local_err);
>=20
> Okay - if we get here (whether from status 1-3, or with systemd_supports_=
mode fixed to support status 0-3), local_err is still unset prior to callin=
g systemd_suspend(), and we are guaranteed that after the call, either we s=
uspended successfully or local_err is now set.
>=20
>> =A0=A0=A0 }
>>
>> =A0=A0=A0 if (!local_err) {
>> =A0=A0=A0=A0=A0=A0=A0 return;
>> =A0=A0=A0 }
>=20
> So if returned, we succeeded at systemd_suspend, and there is nothing fur=
ther to do; but if we get past that point, we don't know if it was systemd_=
supports_mode that failed or systemd_suspend that failed, and we don't know=
 if local_err is set.

No, we know that is set, as we check exactly this and return if not set.

>=20
>>
>> =A0=A0=A0 error_free(local_err);
>> +=A0=A0=A0 local_err =3D NULL;
>=20
> Yet, we blindly throw away local_err, without trying to report it.=A0 If =
that's the case, then WHY are we passing in local_err?=A0 Wouldn't it be be=
tter to pass in NULL (we really don't care about the error message), and/or=
 fix systemd_suspend() to return a bool just like systemd_supports_mode, an=
d/or fix systemd_supports_mode to guarantee that it sets errp when returnin=
g false?
>=20

I agree that this is a strange function and its logic is weird. But I don't=
 know what the logic should be. My patch is still valid to just fix obvious=
 use-after-free and possible leak. It doesn't fix the logic.


--=20
Best regards,
Vladimir

