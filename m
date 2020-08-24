Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F8BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E9120578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SIrm+OXp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="HMvytey4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E9120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFk8-0004I9-Di
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kAFjW-0003r9-Ic
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:54:10 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64955)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kAFjS-0001zs-Cu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598288046; x=1629824046;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=omnIwrYtpykZC1On00BCL7+ll2tzad5gBjgGj61suCA=;
 b=SIrm+OXpYmmHnXa8UXd/4MZdV5L8mMmRvPjhbwjTiKPiuJO++I35M9Rh
 VzjKxlcbXPO6KlkagfxLGI/HVypvzge2vJf4JMUv85ABfv3HHoIYxL5zj
 jMM+749ievpmXIL6D5sgcwJo7svVuGOQp458cSWtqUzxY5N7GF5UX4pjt s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Aug 2020 09:54:04 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 24 Aug 2020 09:54:04 -0700
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 09:54:04 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 09:54:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 24 Aug 2020 09:54:03 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6579.namprd02.prod.outlook.com (2603:10b6:a03:20f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 16:54:01 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:54:01 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Known issue?  qemu is much slower when built with clang vs gcc
Thread-Topic: Known issue?  qemu is much slower when built with clang vs gcc
Thread-Index: AdZ6NopuzkxtYB5mRZ+QosZlo2lMxg==
Date: Mon, 24 Aug 2020 16:54:01 +0000
Message-ID: <BYAPR02MB4886C5F9260C1B52B91DD95EDE560@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d61246-a103-472c-9cd5-08d8484e4d8c
x-ms-traffictypediagnostic: BY5PR02MB6579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6579C28AC6F383AFE5D29773DE560@BY5PR02MB6579.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W46BW4arO4QlkAmD9EPolL83mv9MKPwUcFuoWF7cwcVkV6H+Qr6WeyDzX2SGZow6x4G4sh/eal7yfq5ozP27E9J9Dq6IHITd4krc7EGbXBdfDIb1p1YFGbD9TvB4iGNajZMMwNjFSl4K8PV6NUzVKAWkkteZvmOAQWBs7hKMeAd3CSN5F5Knna6prr/xakUBGJtE97sHViFwAx2LGnEsvg5xam+1C+eSUCFDx8YbPmKU+5eBMab0V6r4D41lAT0og960GieFnWJ94zyehNouMWC0Vwpaki3ZYZi9ok0ltIaDpioGBHayf6AXJqxPmebA8biRLCu+tcQ7/ZESCxVUHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(107886003)(76116006)(33656002)(9686003)(64756008)(478600001)(55016002)(4744005)(2906002)(186003)(66446008)(66556008)(26005)(66946007)(66476007)(316002)(6916009)(71200400001)(6506007)(8936002)(7696005)(5660300002)(8676002)(4326008)(52536014)(83380400001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: lcp8eHHEA8Zkuz9zGMdw5LSk0YpgqDEqa7v4ucVCud6NPCLTFU7jq05dobDbF4uRFYt8B/uJH+4tmNZd3/vbQ22Y340bzQEhjdrQqTDOOWyrzFblp1j7kUDKVC4YVBOuER7NwuE9YtYE1WzIbeTlAZL78XZ7JUw/wK5H94ZYi0B1xNiuLx5eKYRSDnG3bNJL+Tg0Yg8t7tM6VeUgN1CnCly1Qxdo7Fuxb9odpYJrhm4HB1I29ZLJR/mHdf7HbBixDqraau9zt6O+hpUDJcKQVeyzgqAhzcAhl1YF22I7/fGByGjktSkONrXE9cKg4b/3FJqH9dBDfdVFfkq6V1iEs/bqrg9TBt0TMnkCJaCDlKWX/71ef9big43AANlRjmlENZGMmZ58dcSqLP+dmpSedqZd7lIIBN5w4G89UX8a8IbszmJ4Zo6E7fSBOWMSJ1oJ/yICZ7eLv/b3Dya28h4lIMTEXut2H2FwLvCyec2MN6soqzzWppwGw0aq0tG2zGfC3276QU+qEKGpMM+/pYv75d3tHyBl7oogGHg5ijDMoTkcBDo78Rz+e4eT6XcZJxsSauN3bEEYZiOCT7EtdPstoeG+i7LzQPZOOcsxPy/n8gC7egs0vjuBNGbwfjosyIV8TOjiqBZxcalFG2hHACtTBA==
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzcGQ+kQc5iriX54MK3Uzfp4KVu9BO7oOuQdhbYVTQyHAI19XH69JEwEhdZgAq3YqMxkm9k6m5FVvmdvv01vMf+zi2qa9/CBwKz5HHegnw5Jb/PpUsczqOmFCGlYz5l5p8SLUBVYyMvJGMQIXpXzfTREUnmUDpP7aTjZ9YB9J16Jg76tQMrQQev5ULxS2xg0mt8KnuyOLC47ZsPiMK/v2+X067AWHbvN4m2gZeN8fuSDqbhvSuyJ8/DswELUiV/7dvYBKpbaWHgrVlAQtI7/zZYGFjg37Dt+OcAsZaJy0cbIQA7GQAU+PQVCYMibvqsJHSXnAKVcmFxHIp7pRJJpgg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNg25MBfRhXvR1HrE2VqjBGfwCCm1zlbLqHRdOcppUU=;
 b=djEiIaJPx9wIVbOx5jqZ2GTUTLvWOV2LX/6Re36/62Uz1NSwPazZDJK7siQDFXVLm5zMe5CeP4EvpUos2r2yz8W9suaY7pm9ZOLm0HLoyANvWu6PVjRkYjFhLIHmINtxnIqakSj4fIaO0+qGlgT7cAkz2hwcovQmyvmYeddw1V0dZ9Hcf6Ayb7vp0mUVunq9GV5X+YF4s6Jk8zZemIcZuiwOJo81c0uukW/aWn1wqQk9bF9VT9mnZ1xFpVGTQm3d/Gh5gtteGfzjjuOLTGAaxhMqu3HxKvCHV5RFYELNHdsj9w6YTTOJbx6Z97B3lyG+IWXn013YVvIygHCXW+tw1Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNg25MBfRhXvR1HrE2VqjBGfwCCm1zlbLqHRdOcppUU=;
 b=HMvytey4VPkq3GxlgZ6Gxwc40mGLFMu3ZTdJlzR2jQsLUlK8g/9zhLBwXRyu8fkU5L/vKEIGin+9LYPjRg2ezM6aDldfzMAQ1n892UBzvjJuvVsIAVnb6IMJiR9wi/vvt0jC57dxUuoKrOaeQJjjPbKJiK3UmbVX0AOsrqQMaDQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 78d61246-a103-472c-9cd5-08d8484e4d8c
x-ms-exchange-crosstenant-originalarrivaltime: 24 Aug 2020 16:54:01.7535 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: /4skneiXWX9AzBB9OjbeYDiIUk8avT0J2a/SjPksmgIHdm0PqS8ZpgAMfjOcZX+N1RPq6o/6CqXdLxJh4WMtFg==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6579
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB4886C5F9260C1B52B91DD95EDE560BYAPR02MB4886namp_"
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 12:54:05
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Brian Cain <bcain@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BYAPR02MB4886C5F9260C1B52B91DD95EDE560BYAPR02MB4886namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We're seeing significant slowdowns when we build qemu with clang instead of=
 gcc.  I'm hoping this is a known issue and there is a workaround or fix.  =
Please advise.

I have an example where qemu is 29X slower when built with clang.  My first=
 hunch was that there was something different happening in configure (e.g.,=
 passing -O0 to clang instead of -O2).  However, I have ruled this out.

Further investigation shows that we are calling the translator more often. =
 The same code is getting translated multiple times.  So, my current theory=
 is some different behavior in the translation block hashing causing the lo=
okup not to find existing translations.  I know clang can be overly aggress=
ive about optimizing undefined behavior.  So, I turned on clang's undefined=
 behavior sanitizer.  Interestingly, it did not report anything, *and* we d=
on't see the large performance difference.

Thanks,
Taylor


--_000_BYAPR02MB4886C5F9260C1B52B91DD95EDE560BYAPR02MB4886namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">We&#8217;re seeing significant slowdowns when we bui=
ld qemu with clang instead of gcc.&nbsp; I&#8217;m hoping this is a known i=
ssue and there is a workaround or fix.&nbsp; Please advise.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have an example where qemu is 29X slower when buil=
t with clang.&nbsp; My first hunch was that there was something different h=
appening in configure (e.g., passing -O0 to clang instead of -O2).&nbsp; Ho=
wever, I have ruled this out.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Further investigation shows that we are calling the =
translator more often.&nbsp; The same code is getting translated multiple t=
imes. &nbsp;So, my current theory is some different behavior in the transla=
tion block hashing causing the lookup not to
 find existing translations.&nbsp; I know clang can be overly aggressive ab=
out optimizing undefined behavior.&nbsp; So, I turned on clang&#8217;s unde=
fined behavior sanitizer.&nbsp; Interestingly, it did not report anything, =
*<b>and</b>* we don&#8217;t see the large performance difference.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Taylor<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BYAPR02MB4886C5F9260C1B52B91DD95EDE560BYAPR02MB4886namp_--

