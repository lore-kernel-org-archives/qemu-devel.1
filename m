Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A31C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1711207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 03:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sw/XideM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="mRXcuYon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1711207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAPz1-0002lK-66
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 23:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1kAPyF-0002MI-Mi
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 23:50:03 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9924)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1kAPyC-0001Xm-Te
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 23:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598327400; x=1629863400;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=mpY1svTSu7RANGQcWp4XbIS1noQ4OtTX6450UCKpEFU=;
 b=Sw/XideM7VxS1Dqi5si4GUrncF4922xzcaAg7qm5aWyaE1nb1Fp3AoXz
 by4PxuFVcVsaing2h7psvlXu7F93EFzEFFFZZ2IYxY0aNpy7FmpQtS+Go
 +cuV6gb2saCIbcO6Yn+z0hsL1SdQMS9iS+lCk/+wepjlEjejT061V96Hp g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Aug 2020 20:49:56 -0700
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 24 Aug 2020 20:49:56 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 20:49:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 24 Aug 2020 20:49:56 -0700
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by SN1PR02MB3808.namprd02.prod.outlook.com (2603:10b6:802:31::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 03:49:53 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::64de:d6ae:baa0:f486]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::64de:d6ae:baa0:f486%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 03:49:53 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <tsimpson@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: Known issue?  qemu is much slower when built with clang vs gcc
Thread-Topic: Known issue?  qemu is much slower when built with clang vs gcc
Thread-Index: AdZ6NopuzkxtYB5mRZ+QosZlo2lMxgAXAhag
Date: Tue, 25 Aug 2020 03:49:53 +0000
Message-ID: <SN6PR02MB4205A45405802A2BFB163EEAB8570@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <BYAPR02MB4886C5F9260C1B52B91DD95EDE560@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4886C5F9260C1B52B91DD95EDE560@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: quicinc.com; dkim=none (message not signed)
 header.d=none;quicinc.com; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [104.54.226.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4deece0b-ed29-4998-a78e-08d848a9ed12
x-ms-traffictypediagnostic: SN1PR02MB3808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR02MB3808A73B13C504486AD6167EB8570@SN1PR02MB3808.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFxe8dEnWJJVUPM+V00OzTkzpERmTbq3/O8nZGw+jCWaLQ0P/V1hnOrKjnyUGjJL6ZJACN/BqTVtTPhdudzBmwnNhTFX1mspFAb7mi2383hvNk4UWw+cn3jg1c7ITkTMQMt8xHPU7SfmCHRSf+W5hZBbNyRyuojcZ42xfiYWNfMurHBscSBgq53fgZS6zmPgPiK01hxlfbV2+NBFpbUsjkCOaUMCmml18BUMee3rIQx8QQYYgpWGhxnMNgth6RGbYBDsdEiYXE3x1/duB7p46kMQ/m3E7gPCB6KLy0aH7PddwRiM09Dxv4lOqz2HflpQ3trGkrqxR3fIHPPMkaAtOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(5660300002)(71200400001)(33656002)(6506007)(26005)(52536014)(53546011)(8936002)(186003)(8676002)(66556008)(66476007)(86362001)(7696005)(2906002)(478600001)(55016002)(64756008)(66446008)(316002)(83380400001)(110136005)(66946007)(9686003)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0tOXQbkBSQtXlhykLBHtkK15JrHLfkREJ6kp5nDoz674ppg8OfV4dQulxOdVSDU8G9YJJbMAeq2XIZn7FkWUymS4PlQL0HzXYEa1/T4kLFmzBW9FIq9t/LEsPqMtkldVNxz0Whnl8YjtrX1LZmBLkfAlCzRMGu6wYnE7O9En+nbQhLa9AfrX7EE/+GL7ugxteD+nR9nIpWb50AxE5ujq0S4I5QqBH5fbm8kWc/eJ02Wh4UxzMZOGcFhV4CzNTBzbA+Zyqpdcbh0GRjJGzKfmZq0Ty+5+13IGc4aIznNYyZGr4rQOiwpz4DR8vbtBtVNtoCA7nRMgydfIwFde+ui2hD9wUQubcUFru30C7LtnhqZCY/3JOAqTlttQhbGTBJZNx7ntoQU5jy3GhKcEpMIrmMMFw9BFNLfuBg7a1kFt/k8wLsFpg75f8EevCEeC3ipDj9fASQwqEKAaUTOxLHHAfI4O151r8H7U1LxzWCY7t7k0YK+96iYvGIz7ZYZ8pCjMr5Pk3qljbNstN1q8R0CczffKzKhHV98K7s2/JFS9Q/uoEYZdqMK/EED2iVdL7/75eaTFkxEaLFrOmgfuNLKOJS2ZwZeHTj3W7vF6gq27YJzr0ILl6hd6CuPElvHps5AMzkQNGoOo0bs07qbviPyiiw==
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDqhoYaXrk7ypElLcjV3bVjW/ypHArJNzuTf397Vu94sgrRpXKOyOevQA46b0Rww1hziJTd4BxxsnKiGYMu3Dk/fwrKoae6ItH6pwEp4w/gYR6u3i7qWrYckb9kDIK/aAbxumr1MkjNGOt/ekpPZHlN9pxFKoGPkhKMzzAM78m7ni22otXCe5W9lWd+4WI1UeGwrULdJj52FhY9V/F9nEikbMAt0RqEAZtWmggq0aPwf0/k4dfxT0xkqaUd9JgXYko9P6G9slKNsK1BQiMRp4Svc/wAHVdjhmYGpX1PyG9i3B0dwOwDhbWHEbwMd60cM+NX4pz8HXwyEecmOE9qFsw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktzmOry0UDvpFzzXKXl4KEzgpzBe6G7rWaP2ex2Jxgg=;
 b=K81oOMqEU+7pL3lP84bZX3TlNeLlWhGThwvJ1t8+nJFflpGJfpERtKB/3DOlzHc+YIH7Oy5hKnyyzyBZKwbkjfGwWJiyTRvtKIDLrGDNhIKAk22YjBJtIww/IRCg6PLQf0AO0wmgRYUa9IWriCizd+XUVQTKyXqBR5hzTEAL3viOvqHmGL3gqBa17RNWPgzshv3y7IkqLXDmUPvg7yOzbcgG0SQEXs5xrDrmObdzEi2/LFaEk456rIZAAsf8LSJKSZiPs0ev8J9sdu5d5mFbahY2CdRwfxTGiZUP05OGtuYUftYm1xiqRac4czc+1z/T4C94PsHoZVQcrDAxAXTeEg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktzmOry0UDvpFzzXKXl4KEzgpzBe6G7rWaP2ex2Jxgg=;
 b=mRXcuYonlD3S7gOMkzuQqHBj014l1WliD7/YB5HIVxQmdeCnJCfZ6TN99MwaEj/3K7i/SGC2YjARFVzB0jDTCJfWxL/mt1Vg/5M4qh2GRDuPtMrWqSr+4pNdv2qpfgXik9mRsSK8eMtjMSFjSFgyWgoLvXjPxK+VUS0GqNrVx5U=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SN6PR02MB4205.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4deece0b-ed29-4998-a78e-08d848a9ed12
x-ms-exchange-crosstenant-originalarrivaltime: 25 Aug 2020 03:49:53.5281 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: v8erzKyveKpZbcLzLx7pnaGccVOnOEWLBJ02pHBrn4mzJt0IWQq2vsW9L14i2H5BAjT3SNQtxkbjf/4d2aS6Ow==
x-ms-exchange-transport-crosstenantheadersstamped: SN1PR02MB3808
x-originatororg: quicinc.com
Content-Type: multipart/alternative;
 boundary="_000_SN6PR02MB4205A45405802A2BFB163EEAB8570SN6PR02MB4205namp_"
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=bcain@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 23:49:57
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

--_000_SN6PR02MB4205A45405802A2BFB163EEAB8570SN6PR02MB4205namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Taylor,

I can report that the performance looks to be in the ballpark of parity wit=
h gcc when we move from clang 8.0 to 11.0 rc2.   Perhaps we can attribute t=
his to a since-fixed defect in clang?

-Brian

From: Taylor Simpson <tsimpson@quicinc.com>
Sent: Monday, August 24, 2020 11:54 AM
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>
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


--_000_SN6PR02MB4205A45405802A2BFB163EEAB8570SN6PR02MB4205namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
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
<p class=3D"MsoNormal"><b>From:</b> Taylor Simpson &lt;tsimpson@quicinc.com=
&gt; <br>
<b>Sent:</b> Monday, August 24, 2020 11:54 AM<br>
<b>To:</b> qemu-devel@nongnu.org<br>
<b>Cc:</b> Brian Cain &lt;bcain@quicinc.com&gt;<br>
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
</body>
</html>

--_000_SN6PR02MB4205A45405802A2BFB163EEAB8570SN6PR02MB4205namp_--

