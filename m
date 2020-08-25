Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C8DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2062075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CmoLwF70";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="iO207J4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2062075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaMO-0008Ac-0J
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kAaJr-0004dn-6s
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:53:03 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:12127)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kAaJo-0000jl-9N
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598367180; x=1629903180;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=uxIj9x1eTuzOxCjPp7mBxZp4RXblmIp//HjMIWS3Tsg=;
 b=CmoLwF70X52ijMagKUwqzh88jyMrOo7A/AI5ipAt6SZuxrmN/X2adLB4
 YqoPKc4SHyXIsbcsQivIU56mh028MMKvZXyhwDGPHCojCdMt/GHm3i3ry
 CptcOnFKy9usO1f70jdVWMMFEYl91FoKG6DogGN/VOTZhOPQMU1sSFOaT I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Aug 2020 07:52:57 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 25 Aug 2020 07:52:57 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 07:52:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 25 Aug 2020 07:52:56 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5048.namprd02.prod.outlook.com (2603:10b6:a03:71::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 25 Aug
 2020 14:52:54 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 14:52:54 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Brian Cain <bcain@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: Known issue?  qemu is much slower when built with clang vs gcc
Thread-Topic: Known issue?  qemu is much slower when built with clang vs gcc
Thread-Index: AdZ6NopuzkxtYB5mRZ+QosZlo2lMxgAXAhagABczX1A=
Date: Tue, 25 Aug 2020 14:52:53 +0000
Message-ID: <BYAPR02MB488622E6EE5A24E7B6DEFC6DDE570@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <BYAPR02MB4886C5F9260C1B52B91DD95EDE560@BYAPR02MB4886.namprd02.prod.outlook.com>
 <SN6PR02MB4205A45405802A2BFB163EEAB8570@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4205A45405802A2BFB163EEAB8570@SN6PR02MB4205.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: quicinc.com; dkim=none (message not signed)
 header.d=none;quicinc.com; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f779119d-5afa-43e9-e817-08d849068c05
x-ms-traffictypediagnostic: BYAPR02MB5048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB50489063CC4A0B5B9DFFEA31DE570@BYAPR02MB5048.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: haQxx65eDEFd/tGI+aqdF6mJUqnKGUk6SMVPKIvgA9hAVYFIhD2J8WtYw9UqGIQULZ8w0895QTQ+TOVXheylHGDAZ4w2rbtM/fPIRD0fH2DOBSqnmLBMQEJ9rYb5RQ7pWjYHv8SZ3UizOyRoe9VSzHJ6OMKI/A1UUn0yW5IMnsDcBNYp6wUBjWbpsjDarYRJVFKbonIaX0YBWcOXLdsF3uI7HYAUBB2vK26rGTyICrbQF8RxCqGejO83nJkq6WPt1t72g97H/+C29z40rsBkSwlQCbonIJ4YUdcRLsPSLjQDSKRxU8xa1LpXst/bv270pu2J48wm8Zlw++86JVTvXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(110136005)(64756008)(71200400001)(86362001)(83380400001)(55016002)(316002)(5660300002)(52536014)(9686003)(478600001)(26005)(186003)(76116006)(66446008)(66946007)(66556008)(2906002)(66476007)(53546011)(33656002)(6506007)(7696005)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Z7U8H/jNyEaY/BuCGqYC17HRTgb4vzD3NMSRDIg+l6sMINQqvPGr03FMNSN8pWstWT0I44dfHH+S/0fR+bRg15ikEBOuFec0wNjk8c8XZbEWp3nXcZF2FzAbfat0rqIv/tWwe0tL/xUrfbitNoIcl31zNTr6oJBUOz9o0SFwnyFFHzhuqv4xxqA6FZJUSLnefxlauos0KkL8PEe6N2aPVKzxn73oNe9EvcxcIf/xQ7MyQm6vcvc0GkiJ27EnH50PiPQUMjjo+28fpCq+6dk0ezD+d9KKjWL+OK5FlAgYhsyIaDNNzelJ/D9bInliPOfOBz0TlSacJlFaEZ3OvCrbcdj7Wg/cXzd1cDiJ9by5ubP2gtIcYQQ+0X1j+bnNAtuBWQ2KVJl1aE4B4pDfTrgEYnrOhk7ehT59Eey1lri3wgL/1zx/2vX+iIoN2MAkodeuzYjJzNkwfFA/rfY3fgy+Iul/NjryMphhl1zDkhmApTbFfVr2uKPZRp75Dm+whuDZ3IMUPeME+xgzg0faeuGi7QrBGB0511uBoFfTjk6y5k1mjql4fjBRusO8w2XYN6iSj90Qz51f5uUGADmk5RdywbUnPjJR8DdE+TmLQpHvXQCh23PwnhOrTEnbhIoVzrFJHRK78Cx57wDyFS4JoC0cMg==
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyZmC2o91pYdauO0sB5C4mpnYlwT9PdZIm2qiwzxvXrufM+S09x6eXK38dfla3NADqXUHwMfdlaCS1Mf+a4CdRcuKz1c1xPcsBpWqO2+z5lqPBdADCHBR2v7lZNTXHbKRG6Wk48V8zYMttBhY8ovvoG2ihglmSsiStyQUOLCA9imYYsnofGx6+eL+flvEFfMfoJDFHQS1tPx/QQj6jEdmcWx1Z+qhBzmeKnMy5GyX6S5A18wTgmyc6GRgYhL+yahKhZGI5Keh4V468gzWGKdTYaAfN/VwRacVeXNxHC7FHBFMRsRTuHSNoc+Jv2J1nO7ICaD/KmuIJle93U74Rx8fQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+ZjwcfBq+vnXLMcbN4Vk1+tIQA/4SThg0o1J+w1xlI=;
 b=KuHlEItlwcA3D3RcPo8rlt52ujC9UgPlfa3Wxl1kbehu63vLMeoC/YqfZf+t0NV8+n1XObDvyqo9ZCHhSIWCmzs9NrC8w4XvADE1wxNqmTkllT52u6uFUbudG1dMZNaKWevfWVh/XQOwxRhUrotCvP0RP9bbQm+SiroolvI7hDV42azYmMSsp/Lbq9LsRn3QlkYdrVFU4ILTEURyD7SC7Ammf1LKlGGBxF0ubjTxfLhj0EbJsDZzsEz1qtV2B++/EKWEcclgkK0Wvz+z+fQMB5T13Ucjsdonv9l/ZJwAxCeqK2KJAEGNax6WtOzPZ8B/OQFqjvX2jNBruXh7tdQXSw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+ZjwcfBq+vnXLMcbN4Vk1+tIQA/4SThg0o1J+w1xlI=;
 b=iO207J4ocEkJAye9to5LA6s2KhdVaZc+yZrxY8XQPJmvjqJvXUYca6GMRA0YlI6ThKmS7r0V9RcC8p3DNL0LdBrxLVKLRgXSN9A6HvIoBGI7rKJ6PdVFm8fbWzdlqQlKBQ7Khtq9kaHs5c0PQtVC47SJrRfBe1RxD2MJGx8sKqw=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f779119d-5afa-43e9-e817-08d849068c05
x-ms-exchange-crosstenant-originalarrivaltime: 25 Aug 2020 14:52:53.9394 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: z6rlac5AK1KuK4Sx8fYgWVFBhPdGudOtcC4meXA7MUEb1boCsl7q2qqZtt5apwmOY0gxyOKzC1ltmmCgx3+Dfw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5048
x-originatororg: quicinc.com
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB488622E6EE5A24E7B6DEFC6DDE570BYAPR02MB4886namp_"
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:52:57
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BYAPR02MB488622E6EE5A24E7B6DEFC6DDE570BYAPR02MB4886namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

OK, thanks Brian!


From: Brian Cain <bcain@quicinc.com>
Sent: Monday, August 24, 2020 9:50 PM
To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
Subject: RE: Known issue? qemu is much slower when built with clang vs gcc

Taylor,

I can report that the performance looks to be in the ballpark of parity wit=
h gcc when we move from clang 8.0 to 11.0 rc2.   Perhaps we can attribute t=
his to a since-fixed defect in clang?

-Brian

From: Taylor Simpson <tsimpson@quicinc.com<mailto:tsimpson@quicinc.com>>
Sent: Monday, August 24, 2020 11:54 AM
To: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>
Cc: Brian Cain <bcain@quicinc.com<mailto:bcain@quicinc.com>>
Subject: Known issue? qemu is much slower when built with clang vs gcc

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


--_000_BYAPR02MB488622E6EE5A24E7B6DEFC6DDE570BYAPR02MB4886namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">OK, thanks Brian!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Brian Cain &lt;bcain@quicinc.com&gt; <b=
r>
<b>Sent:</b> Monday, August 24, 2020 9:50 PM<br>
<b>To:</b> Taylor Simpson &lt;tsimpson@quicinc.com&gt;; qemu-devel@nongnu.o=
rg<br>
<b>Subject:</b> RE: Known issue? qemu is much slower when built with clang =
vs gcc<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Taylor,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I can report that the performance looks to be in the=
 ballpark of parity with gcc when we move from clang 8.0 to 11.0 rc2.&nbsp;=
 &nbsp;Perhaps we can attribute this to a since-fixed defect in clang?<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Taylor Simpson &lt;<a href=3D"mailto:ts=
impson@quicinc.com">tsimpson@quicinc.com</a>&gt;
<br>
<b>Sent:</b> Monday, August 24, 2020 11:54 AM<br>
<b>To:</b> <a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</=
a><br>
<b>Cc:</b> Brian Cain &lt;<a href=3D"mailto:bcain@quicinc.com">bcain@quicin=
c.com</a>&gt;<br>
<b>Subject:</b> Known issue? qemu is much slower when built with clang vs g=
cc<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
</div>
</div>
</body>
</html>

--_000_BYAPR02MB488622E6EE5A24E7B6DEFC6DDE570BYAPR02MB4886namp_--

