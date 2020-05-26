Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9A0207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QK98cNLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9A0207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSDb-000074-4e
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 01:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jdSD0-00087W-Vu
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:33:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:21862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jdSCz-0002Zk-83
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:33:01 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04Q5R4vM011243; Mon, 25 May 2020 22:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ikmNtDFoU196Zurg7gTAZBewCfEB0rCdMPgwzOEvWHo=;
 b=QK98cNLYfCU1fBH6eNIgFmGwcuMAIyc+SGdKp4AnCZF0Wgtng/Qsv9Cbba/vHDItZIsh
 mGHyWMgGiG2D6H2ySiZ8OEr+Tt0noFBGpCbLFvLG4Z1rDGD2amHH9czpU/5MARMszkW8
 5DCPGmFvwuD5XclruUe0kBxWGYFoLaiMg1Zmff601zHbauvvH0oY7hyMLENJOddftidA
 n2Lw2mAg0phgsgjzZNCmRTuGoulINJPkxwXYUyK6AYWA9njERosBI+1E23jWKuZNgvDH
 jiwMzCOJUVka+mnJDprnF5X3VaKzROOsynxr9VEkIx1bX9R1RT3jO5cVDgO9Q0jPOwKs xg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-002c1b01.pphosted.com with ESMTP id 318gheh3kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 22:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/NeLq49mV0A1BCpwt82yO4+eLwvJ9rrVfuwSqm3jO0g6omC5ogDyGlxTbiG7g4oyFMWY7XknO/NBtw/7qemErf1qsCjpxeTIUwA6WB2wwULaf+EQcAk+rN7nTq+lTDUun3w0MgQEYHOvXrEs++w40+V2s7G3btIw54XOTfXdztSQY7ttkrimQEuYROVQ4zQb3/muAxTJAy1+Tt3OWl5xjIGHrBFlowBwPN7vw45zvDp+ofZ25hVMDjyTZqGHxb75mQK53MqoDVJFGXQ9DJK8dVeWnMc79JrEZB3ofsLZW1Eu3BMEwHa1pAZTs00LuYZ0h63hzOcvaKAURSilqbD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikmNtDFoU196Zurg7gTAZBewCfEB0rCdMPgwzOEvWHo=;
 b=RBmzEolcewZC2V5ex30+o+RsWHdPZsfhY5QjhU2D3CQCiiz0/kcfA3yYLn9/zx+zdUZj3CK80UaZhKJ28fvQQfEvhsH2u6Kw2WKWgvkvzZlTZ43nA8zyPrlfbMZK21awwla5u/I7kF7sY40KNhoAfuCajLcN29qfr0qbXtx6mNFtAGGsjZHwFwoDJFxouGJlN7KqoUsJAvOjd5Tt0Z+Q5nV4v+uqu+xC0wn93mVTMepLU+X3R3REAVOZhj4phgv/zmm3ToV/zJB0CY7Noiv4eHlTXyz15W1AWqzax4aTOQ35hQuVl+9DsLiI7K7yGS7HTbaKKp8FbGw9VJwfK37jGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6239.namprd02.prod.outlook.com (2603:10b6:208:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 05:32:40 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 05:32:40 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Laine Stump <laine@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6ijUHoAgACw0gCAAoGgAIACpx8AgAexwgCAAAEdgIAAAmMAgAAI/oCAAApigIAABOmAgAAP4gCAAEE1gIABAK6AgAArWICAADbJAIAAJlEAgAcwvIA=
Date: Tue, 26 May 2020 05:32:39 +0000
Message-ID: <3CDF772E-9CEA-46F4-806A-D22CE1C4F710@nutanix.com>
References: <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
 <20200520054714-mutt-send-email-mst@kernel.org>
 <20200520115626.6a2a2355@nas.mammed.net>
 <20200520060645-mutt-send-email-mst@kernel.org>
 <20200520130547.7ac568b8@nas.mammed.net>
 <20200520072055-mutt-send-email-mst@kernel.org>
 <20200520142012.5394b2f6@nas.mammed.net>
 <20200520121043-mutt-send-email-mst@kernel.org>
 <20200521093217.4f440fbc@nas.mammed.net>
 <20200521060511-mutt-send-email-mst@kernel.org>
 <20200521152330.5958bae1@redhat.com>
 <9fd75e93-4bd7-6a34-607d-a30ae273ccfd@redhat.com>
In-Reply-To: <9fd75e93-4bd7-6a34-607d-a30ae273ccfd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [2401:4900:104a:f504:bcc2:b07a:cc1c:f50d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9cadd49-b8fc-468f-59ec-08d8013634f8
x-ms-traffictypediagnostic: MN2PR02MB6239:
x-microsoft-antispam-prvs: <MN2PR02MB62391F93C80CE1B6DD022F4BF1B00@MN2PR02MB6239.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DmD9mmCV4HvLCtNiyJsaWxv02XB/mjNwW8uvxo14KFKe7AUtDAbIbhiyAm/5Od3tYCzgM+44+h+fssnlHLhS1kE3XFwPals/OZLkEnLrBdAseZ1obHa19xqNl7NF/mqDoL+9lYOOxATpHe6cQA3WFD8WyBhEfkYv4YEF5D9GLK9zE03f5kQJHotleNQ5yL0frC8iN9MdPT/ReR0FtE7Rc9rxDH9DU4TeqojmuQXTS8nOgb1DwYCb+ejYzTmbzGUQOqUbflsA55QSUMd5zXJlzlk6EbjR7aGM9jVNxVWj9bwmoHHS7RK7EKPEzM+WYndp/EDKy0mkQBEuPPjZFu96UNqXp/mSJGSCfCtLejA+sgZ3oCR0VBspOKMIG0/uTQnGLnKGEUJS+RU7lkTos6MV8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(71200400001)(6512007)(6486002)(4326008)(5660300002)(2616005)(6916009)(36756003)(6506007)(66556008)(64756008)(478600001)(91956017)(86362001)(66946007)(53546011)(66476007)(966005)(33656002)(186003)(2906002)(8936002)(7416002)(316002)(76116006)(54906003)(8676002)(44832011)(66446008)(558084003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AL8Fqc0Jr4ER1DrYKMlTWn1GDpLF5unR+7mvnz7MUXfFJHX3KpaLreLS6eOPyGuY3V6pkP1xUQ/GvUfkkYNmSPrq0UfoB+s8u/BgUHYHVbOhaFiZ7/RiognKzF41CkMVJ85C1iFYf2R1xKzFCCXYfCEfoXJlah9NTNt3JLSqVL+EhBy96EBB+LuPAy0CurwIb2XVYmpnVPwOn70WXQT85xT1PkBMzSPnotHrkFO2yX3T4fu9Z9yrSwdrGjTr9HnwesfWaZckX4OhiqekgI7ya/5ivM53ls/UlkWxvGXkRWJ9bIdd8JdMGeZvy4jmpFOt9FD8nBOmOBkslrLBIBvqg0xCI8D4awXTedRCPm/rpLmvN1me3+jOB4pNspimESo1QQXvd0nPnIIPT/LUGCA/z4dpqW9dWZVYY1k/SQwoAUwKtly7USNBKZ7pqSsshhfVvP5UYzvsenugAQFYKe1tYTihRo9NyP6wq5Dk7HAUM5H0NaIUIsegF6KoCwBgM/5sHrhxx0cHak1AR1h94QQ4pM6fD8oZJvBGaQKRMUo8pq4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7F1519127511B04B91B511A4FFF1B364@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cadd49-b8fc-468f-59ec-08d8013634f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 05:32:39.9619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPgWXuc2vSojD9VL2745ACPFB7A8E1AtzVY5FiZL92lLNIMcqGrEFG0K3SLJUVyAlMZkuVhNuRgBb3isAu0W4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-25_10:2020-05-25,
 2020-05-25 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:32:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 21, 2020, at 9:10 PM, Laine Stump <laine@redhat.com> wrote:
>=20
> I recall at one time someone (Marcel maybe?) proposed changing the defaul=
t of that setting, but don't remember why.

https://patchwork.kernel.org/patch/9409349/


