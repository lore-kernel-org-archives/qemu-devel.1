Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DBFC35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1621A206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eeUpKWdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1621A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CIM-0001g8-9L
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j5C9p-0007a5-HP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j5C9n-0008FL-G3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:32:08 -0500
Received: from mail-ve1eur03on071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::71d]:32258
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j5C9m-0008Dd-7A; Fri, 21 Feb 2020 12:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWn9EDGhtjZfaZabiyzjSD00sTnC43qY/ozbpwvrLzVXUDyD51zZrEgykN2DRabwm8Jufuu288GG4B6QtzeFTcuAeBoJ8aItay184M4MDMR4SHw/cJYak17mXDRI3lANizgpEmeB5jLxKCq76TrjegvD2E76ZIlTHWe6xolToUkIwhSTnDwhs6Mh1jzMKtAQ5Myc2SAFm3UdN2rTdwG9N/2ecjS+ukkrLjRHHvwikjYXPEc/ELzKi5/TF+EoLAx/qTj0hw4X4LNx75hST0wBE+3eJVqC31F/hNu6dnbavNrQCGmf45LsX7alewK+qHin2VL2Zo6EZV1vem6cMDDSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De9oi+D5qtGD6H/lO4/hVswXUoHltfm4VlfdPII3PmM=;
 b=Bn1rW6ckhoGjjB62EIdjO+iMT3uU3LKCclNe31XxKmZiNBkKsNVzW0U0u8TbKk8IQmhrtJ5aUDoBWgRmGYqQsI1frCMLGE8zduqXwwCru9Oev2Y49e7yM/YaItUxMRhf/YHHeNfC+3bXx9dC3g4bb4XmQ9E7C8miq9H1nx8xdBSKiQdGbpd4AywAePL2L6xMEwcfnDImEkUgwijsjuvE4aKD5PS+UFCXayP+KS99Rw/UVFGPBjLQPhaqNJ6l4ee+64omZkEvQDOXW7+Jhv/YcyHVTBuPUSYdgwZC5sKAmTssoPBbch9nRQqf7n6kxSDJFZUBeo8bynvwbBMDseqZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De9oi+D5qtGD6H/lO4/hVswXUoHltfm4VlfdPII3PmM=;
 b=eeUpKWdrHwydCvzMsv602+fYfQvHfOAREIaFmaS7W8f9hnPB54XMyvl1Stm+kBjlUqMMGvGuymD0eyNbwS/JyrEuT2Z9K9yX9Q2Tm7j8bVOTx2JVa7KpNKW8gmDv4aLCs0UmbqacOrjSSXeJWIlOoqJvFK2LrYfo4z3azFSoDMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6SPR01MB0057.eurprd08.prod.outlook.com (10.255.22.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Fri, 21 Feb 2020 17:32:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 17:32:02 +0000
Subject: Re: [PATCH v7 01/11] qapi/error: add (Error **errp) cleaning APIs
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-2-vsementsov@virtuozzo.com>
 <87d0a88k6d.fsf@dusky.pond.sub.org>
 <7856fcbb-8c01-aba3-a11b-63058c117362@virtuozzo.com>
 <875zfz6gsh.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200221203155959
Message-ID: <064ca8e9-458e-c780-92a0-05f40cf0975b@virtuozzo.com>
Date: Fri, 21 Feb 2020 20:31:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <875zfz6gsh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::16)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 17:32:01 +0000
X-Tagtoolbar-Keys: D20200221203155959
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfdb1672-398b-4a30-d62d-08d7b6f3f64b
X-MS-TrafficTypeDiagnostic: AM6SPR01MB0057:
X-Microsoft-Antispam-PRVS: <AM6SPR01MB0057F4D71D0E109A0B69A2A4C1120@AM6SPR01MB0057.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(16576012)(316002)(54906003)(31686004)(66946007)(478600001)(66476007)(66556008)(31696002)(6486002)(81166006)(8936002)(86362001)(26005)(81156014)(8676002)(6916009)(16526019)(186003)(5660300002)(956004)(7416002)(36756003)(6666004)(2906002)(2616005)(4326008)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6SPR01MB0057;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uAEmzSrMrgBj0++TKfDbH73YxO9znBlHHy/Rjv+e49nyBnt0Q1wTTtCH0ax0S6+aIGdCTFxVGA8d/moK6USmj+EExfGrcbBWHUznRDGh3SESjWxoryvz6eivPvCjMEkib3bKbgknytSA9WGUq97bvN3nJ+YVn7W16MeoDcANSeLmYvUjoTp7W9xlYrF2huWItsc+tCfEAtIaNGr+Ip2dCdWi7N2IcXr/2hAB1Ai8xjO/GnYuz+HB97ZG9wAlNfkMv3OJ2rSRSL4d2DlscpSF3dsV4wYtlICHTGzH/gxPsI2JgJ7zajkyTD0yPzpwH8LyYnawWskBw6Aqh8B9GIbsDuKvgc15hyIWoyEAZhFJ6Ejb/Q9DRQE1OSJWJM8DsZ4/xXm+zOfP4cyixgpyndl8LvF27RZ2q1u9l4vtVnCy/GGoVvdNt72j4ypFffcqH61
X-MS-Exchange-AntiSpam-MessageData: gOrvb366LFT7xO/91E23E7ur+NIotbpJ+rDi1DM/aMPCoOi9WlF/woP1DljompZ8Q4vbcAXH0GPJcYQdDdlVMCvGv7xsJ7UhYB5Bfo3xzZUxmFqUerYtEkE8refpB5xYMjkrcQHuyxZZrfrCHJqHnA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb1672-398b-4a30-d62d-08d7b6f3f64b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 17:32:02.3366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGY3/4FmZOIBSozIYJzmgfMjbt1Lg21uzddxMDWvhqoP8cPV1yCuERcEywmZgH+gNiKbnwyeLktLlkS6HctXADjOQXTiBk87YPw4P55Ro6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0057
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::71d
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.02.2020 19:34, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 21.02.2020 10:38, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> Add functions to clean Error **errp: call corresponding Error *err
>>>> cleaning function an set pointer to NULL.
>>>>
>>>> New functions:
>>>>     error_free_errp
>>>>     error_report_errp
>>>>     warn_report_errp
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> ---
>>>>
>>>> CC: Eric Blake <eblake@redhat.com>
>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>> CC: Max Reitz <mreitz@redhat.com>
>>>> CC: Greg Kurz <groug@kaod.org>
>>>> CC: Stefano Stabellini <sstabellini@kernel.org>
>>>> CC: Anthony Perard <anthony.perard@citrix.com>
>>>> CC: Paul Durrant <paul@xen.org>
>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>> CC: Laszlo Ersek <lersek@redhat.com>
>>>> CC: Gerd Hoffmann <kraxel@redhat.com>
>>>> CC: Stefan Berger <stefanb@linux.ibm.com>
>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> CC: qemu-block@nongnu.org
>>>> CC: xen-devel@lists.xenproject.org
>>>>
>>>>    include/qapi/error.h | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>> index ad5b6e896d..d34987148d 100644
>>>> --- a/include/qapi/error.h
>>>> +++ b/include/qapi/error.h
>>>> @@ -309,6 +309,32 @@ void warn_reportf_err(Error *err, const char *fmt=
, ...)
>>>>    void error_reportf_err(Error *err, const char *fmt, ...)
>>>>        GCC_FMT_ATTR(2, 3);
>>>>    +/*
>>>> + * Functions to clean Error **errp: call corresponding Error *err cle=
aning
>>>> + * function, then set pointer to NULL.
>>>> + */
>>>> +static inline void error_free_errp(Error **errp)
>>>> +{
>>>> +    assert(errp && *errp);
>>>> +    error_free(*errp);
>>>> +    *errp =3D NULL;
>>>> +}
>>>> +
>>>> +static inline void error_report_errp(Error **errp)
>>>> +{
>>>> +    assert(errp && *errp);
>>>> +    error_report_err(*errp);
>>>> +    *errp =3D NULL;
>>>> +}
>>>> +
>>>> +static inline void warn_report_errp(Error **errp)
>>>> +{
>>>> +    assert(errp && *errp);
>>>> +    warn_report_err(*errp);
>>>> +    *errp =3D NULL;
>>>> +}
>>>> +
>>>> +
>>>>    /*
>>>>     * Just like error_setg(), except you get to specify the error clas=
s.
>>>>     * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR =
is
>>>
>>> These appear to be unused apart from the Coccinelle script in PATCH 03.
>>>
>>> They are used in the full "[RFC v5 000/126] error: auto propagated
>>> local_err" series.  Options:
>>>
>>> 1. Pick a few more patches into this part I series, so these guys come
>>>      with users.
>>
>> It needs some additional effort for this series.. But it's possible. Sti=
ll,
>> I think that we at least should not pull out patches which should be in
>> future series (for example from ppc or block/)..
>=20
> Yes, we want to keep related stuff together.
>=20
>> Grepping through v5:
>>   for x in {warn_report_errp,error_report_errp,error_free_errp}; do echo=
 =3D=3D $x =3D=3D; git grep -l $x | grep -v coccinelle | grep -v 'error\.h'=
; echo; done
>> =3D=3D warn_report_errp =3D=3D
>> block/file-posix.c
>> hw/ppc/spapr.c
>> hw/ppc/spapr_caps.c
>> hw/ppc/spapr_irq.c
>> hw/vfio/pci.c
>> net/tap.c
>> qom/object.c
>>
>> =3D=3D error_report_errp =3D=3D
>> hw/block/vhost-user-blk.c
>> util/oslib-posix.c
>>
>> =3D=3D error_free_errp =3D=3D
>> block.c
>> block/qapi.c
>> block/sheepdog.c
>> block/snapshot.c
>> blockdev.c
>> chardev/char-socket.c
>> hw/audio/intel-hda.c
>> hw/core/qdev-properties.c
>> hw/pci-bridge/pci_bridge_dev.c
>> hw/pci-bridge/pcie_pci_bridge.c
>> hw/scsi/megasas.c
>> hw/scsi/mptsas.c
>> hw/usb/hcd-xhci.c
>> io/net-listener.c
>> migration/colo.c
>> qga/commands-posix.c
>> qga/commands-win32.c
>> util/qemu-sockets.c
>>
>> What do you want to add?
>=20
> PATCH v5 032 uses both error_report_errp() and error_free_errp().
> Adding warn_report_errp() without a user is okay with me.  What do you
> think?
>=20
> If there are patches you consider related to 032, feel free to throw
> them in.

032 is qga/commands-win32.c and util/oslib-posix.c

Seems that they are wrongly grouped into one patch.

qga/commands-win32.c matches qga/ (Michael Roth)
and  util/oslib-posix.c matches POSIX (Paolo Bonzini)

So, it should be two separate patches anyway.

For [1.] I only afraid that we'll have to wait for maintainers, who were
not interested in previous iterations, to review these new patches..

>=20
>>>
>>> 2. Punt this patch to the first part that has users, along with the
>>>      part of the Coccinelle script that deals with them.
>>
>> But coccinelle script would be wrong, if we drop this part from it. I th=
ink,
>> that after commit which adds coccinelle script, it should work with any =
file,
>> not only subset of these series.
>>
>> So, it's probably OK for now to drop these functions, forcing their addi=
tion if
>> coccinelle script will be applied where these functions are needed. We c=
an, for
>> example comment these three functions.
>>
>> Splitting coccinelle script into two parts, which will be in different s=
eries will
>> not help any patch-porting processes.
>>
>> Moreover, this will create dependencies between future series updating o=
ther files.
>>
>> So, I don't like [2.]..
>=20
> And it's likely more work than 1.
>=20
>>> 3. Do nothing: accept the functions without users.
>>
>> OK for me)
>>
>>>
>>> I habitually dislike 3., but reviewing the rest of this series might
>>> make me override that dislike.
> [...]
>=20


--=20
Best regards,
Vladimir

