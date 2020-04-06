Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09174C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7766249E8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="d9RnZ5aP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f18eG4Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7766249E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVR1-0006gc-0K
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=13650a4581=coreyw7@fb.com>) id 1jLVQH-000696-9A
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=13650a4581=coreyw7@fb.com>) id 1jLVQF-0002o1-Uj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:20:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=13650a4581=coreyw7@fb.com>)
 id 1jLVQC-0002jb-HY; Mon, 06 Apr 2020 13:20:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 036HK7PW027299; Mon, 6 Apr 2020 10:20:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 mime-version; s=facebook; bh=gnJQ7dNKCnMezcwtptQXNHwUn1fFSw/eW8MDrY/DnKY=;
 b=d9RnZ5aP+dfBXXFH0JK6yds3E+0YLAte7KpIHJZPYEQp/ScpnKMAQN0u4GEimBTOjJ5G
 Edpozjl7YWT9KHCmtz8ifpiby3wxARWEyH3ZmE6S3YCZWQHIzlt3Dccmg8lE513G9TWc
 SJ2VYS0aFb1wYDkgz2vZ60YGEACVTSYzVLQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 307ff7tt3w-17
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 06 Apr 2020 10:20:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 10:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHVhxd8a+iLS0D97Zo7rZQRRQk43lxGwM5BMAJqsmr7Gwh3R0eXvkncgfPtKR1KtFxO+y3E9hzq5CVvl3UHeDx4OMr7n/tETLUllCYpZnSHi7WVsTZGnRal9Q+KNw58QGiwJvKaIMjtsShO+HwceyWAjZib6juSDIsKUW+WBLVSd6gkJuEbh9VUmVsyF4l2hhCVQ0zSJvG/FsZNF2z4D0YqJE6OpsPDdLIi1FwYdSChb08k1fBqhUE1mxO4mXylBC/vUB5dqM0l8GsxEAM9x+a/dC94Wk1YpDiqQJ1DcYYA5Z2aehfowAztKTmsP1qW26IHSOuIX+/GXoMbBflhDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnJQ7dNKCnMezcwtptQXNHwUn1fFSw/eW8MDrY/DnKY=;
 b=Ttpcc1PdjEX7jiR6RKTD1MH5v+pR6iaz71lxh2C+Hv71IR8F7atq40T5FTa299uS/hHzj1FBJLT6CYdItkMANSgmGbWCEXab2JlNLMfbUp/WTjJYIz9+iUksG80yPVBavQEDZF4eD87gXhv+SPKW5BqvXsXwoK9XFoFC0jS8mZLZJQc7o2J+KvoT3tHRxN+Y9srbVwl4UtSO3a/oaweJqHycNlKHaErb/+9LTxTS746p5Hdg4tyx6Sp4eLp/YCg0vIcC0GiTCLFblICYv2RDSFxsl3julxrHUwSc+Y+o0F83FSTh7UpcykzhACM5syD3BxhqWafgQbfft/sqYJ3Jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnJQ7dNKCnMezcwtptQXNHwUn1fFSw/eW8MDrY/DnKY=;
 b=f18eG4IyHxy77Tw5luhvTHjYZ5LaRAc2yJ9SK+FVQeHQdDJ1DDl4w1XEnFstQR/ST7sExb1Q+1Sf/5oDF1xgxZ3VR6lMf/0r0Vjf0EbjtMQFdcdn0KBe/gLyRvMrPuQXq0QjGCtvxrks6woirvrf01e3ny9WA2I7PIvd7szgUvE=
Received: from MW3PR15MB4041.namprd15.prod.outlook.com (2603:10b6:303:47::20)
 by MW3PR15MB3817.namprd15.prod.outlook.com (2603:10b6:303:4d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 17:20:15 +0000
Received: from MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31]) by MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31%5]) with mapi id 15.20.2878.021; Mon, 6 Apr 2020
 17:20:15 +0000
From: Corey Wharton <coreyw7@fb.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 0/2] Support different CPU types for the sifive_e
 machine
Thread-Topic: [PATCH v2 0/2] Support different CPU types for the sifive_e
 machine
Thread-Index: AQHV+W6F19oCiS7Pd0iMGSOlB5BcCKhsfFrN
Date: Mon, 6 Apr 2020 17:20:15 +0000
Message-ID: <MW3PR15MB40416B8789C2C1C63997DF8793C20@MW3PR15MB4041.namprd15.prod.outlook.com>
References: <20200313193429.8035-1-coreyw7@fb.com>
In-Reply-To: <20200313193429.8035-1-coreyw7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:601:c980:28be:c89b:8bd6:c93b:5b92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c2a6214-8e7b-4f01-d034-08d7da4ec59c
x-ms-traffictypediagnostic: MW3PR15MB3817:
x-microsoft-antispam-prvs: <MW3PR15MB3817CF52884FF555F138B01793C20@MW3PR15MB3817.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR15MB4041.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(52536014)(55016002)(9686003)(33656002)(8676002)(5660300002)(86362001)(7696005)(71200400001)(64756008)(966005)(2906002)(66476007)(66556008)(110136005)(186003)(19627405001)(53546011)(66946007)(76116006)(66446008)(8936002)(498600001)(4326008)(81166006)(54906003)(6506007)(81156014);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EXj3P8D9R4de2b9CUK6znqXqjBrKeuQUztu4w8C2TR9SMOUNKIEpkWE+j3OjhcmKjE8aq0bwxxYbZVrHoQndEPduq3miat7SsGCOlwdyHA5LgOsJdrTqAbC6EwVuEDZI2PSMa7O60p+IVTRC8VGp2jhHW3jl1SCY62cOvkg6F+aCAWRMt9WMhP/4wyv5PiuQBQ2xq09DMR8VhvP0doDq/oc5Q9xfYIhnzl00V8HCy0B/ptaY8VO9dBBsiFx5iv/mrlrNp0Ail43o7FC7198sQwlSKqeWtW9gr2ZbNpkLA5Io+vcmpEXkgA0DnTU36R62n8nJVRncijQWFnjnTPPToM3EB+yXfvZiEIJaTJNiAib/7YfKm6NR1ipQnJV8ZkNfi7O2BGzWIgwmBAHRKS05BP4h4w+ooxqqSQqFfD/nAqgPgb2XuTUAcAMbW2a2SSVxP/7C9W+keJ/R22A/zMG/hMzJRiF5L7Kf7T/gB3CFFt+WfbAcdFPtNlJsPQsan2SYZNAV4YX/wmwXCGQdxTM9Wg==
x-ms-exchange-antispam-messagedata: /D8ESInWC8tqQcGhm6qzMK6HSX0adQTfa8mw+SqmfDBshkYRck4QZk7K1Cs3mtnxaL6pzzbtUqjiIDdjl0YkhqQa1IjI26i+71mVIRVJwT6OOcSQgHeU4eIVSqAIS4X3zVGnzu4jRSBTLY8KMtWaq0mBa1SYskqaF34Dvrlke6pDRI3xbkvnbPcq5ior+pSmTwsJC4zIsHoLMIhtea6lFA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_MW3PR15MB40416B8789C2C1C63997DF8793C20MW3PR15MB4041namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a6214-8e7b-4f01-d034-08d7da4ec59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 17:20:15.2145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xukFE1UhP7b+s5agn9qZ79FdkWAJKJZgmGum/zOF47fiH6gsD86SiW1i1qEyLP0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_08:2020-04-06,
 2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 lowpriorityscore=0
 mlxscore=0 clxscore=1011 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=604 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060137
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.153.30
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_MW3PR15MB40416B8789C2C1C63997DF8793C20MW3PR15MB4041namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ping

https://patchwork.kernel.org/patch/11437661/
https://patchwork.kernel.org/patch/11437665/

________________________________
From: Corey Wharton <coreyw7@fb.com>
Sent: Friday, March 13, 2020 12:35 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; qemu-riscv@nongnu.org <q=
emu-riscv@nongnu.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>; Alistair Francis <Alistair.Francis=
@wdc.com>; Sagar Karandikar <sagark@eecs.berkeley.edu>; Bastian Koppelmann =
<kbastian@mail.uni-paderborn.de>; Bin Meng <bmeng.cn@gmail.com>; Corey Whar=
ton <coreyw7@fb.com>
Subject: [PATCH v2 0/2] Support different CPU types for the sifive_e machin=
e

The purpose of this patch set is to allow the sifive_e machine to run
with different CPU targets to enable different ISA entensions. To that
end it also introduces a new sifive-e34 CPU type which provides the
same ISA as sifive-e31, with the addition of the single precision
floating-point extension (f). The default CPU for the sifive_e machine
is unchanged.

v2: Added missing RVU flag

Corey Wharton (2):
  riscv: sifive_e: Support changing CPU type
  target/riscv: Add a sifive-e34 cpu type

 hw/riscv/sifive_e.c |  3 ++-
 target/riscv/cpu.c  | 10 ++++++++++
 target/riscv/cpu.h  |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

--
2.21.1


--_000_MW3PR15MB40416B8789C2C1C63997DF8793C20MW3PR15MB4041namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>ping<br>
</span>
<div><br>
</div>
<div>https://patchwork.kernel.org/patch/11437661/<br>
</div>
<span><a href=3D"https://patchwork.kernel.org/patch/11437665/" id=3D"LPlnk8=
66816">https://patchwork.kernel.org/patch/11437665/</a></span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Corey Wharton &lt;cor=
eyw7@fb.com&gt;<br>
<b>Sent:</b> Friday, March 13, 2020 12:35 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; qemu-riscv@=
nongnu.org &lt;qemu-riscv@nongnu.org&gt;<br>
<b>Cc:</b> Palmer Dabbelt &lt;palmer@dabbelt.com&gt;; Alistair Francis &lt;=
Alistair.Francis@wdc.com&gt;; Sagar Karandikar &lt;sagark@eecs.berkeley.edu=
&gt;; Bastian Koppelmann &lt;kbastian@mail.uni-paderborn.de&gt;; Bin Meng &=
lt;bmeng.cn@gmail.com&gt;; Corey Wharton &lt;coreyw7@fb.com&gt;<br>
<b>Subject:</b> [PATCH v2 0/2] Support different CPU types for the sifive_e=
 machine</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The purpose of this patch set is to allow the sifi=
ve_e machine to run<br>
with different CPU targets to enable different ISA entensions. To that<br>
end it also introduces a new sifive-e34 CPU type which provides the<br>
same ISA as sifive-e31, with the addition of the single precision<br>
floating-point extension (f). The default CPU for the sifive_e machine<br>
is unchanged.<br>
<br>
v2: Added missing RVU flag<br>
<br>
Corey Wharton (2):<br>
&nbsp; riscv: sifive_e: Support changing CPU type<br>
&nbsp; target/riscv: Add a sifive-e34 cpu type<br>
<br>
&nbsp;hw/riscv/sifive_e.c |&nbsp; 3 &#43;&#43;-<br>
&nbsp;target/riscv/cpu.c&nbsp; | 10 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;<br>
&nbsp;target/riscv/cpu.h&nbsp; |&nbsp; 1 &#43;<br>
&nbsp;3 files changed, 13 insertions(&#43;), 1 deletion(-)<br>
<br>
-- <br>
2.21.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MW3PR15MB40416B8789C2C1C63997DF8793C20MW3PR15MB4041namp_--

