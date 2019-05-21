Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37190C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D509721743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="ZTLpZkt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D509721743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT10j-0000HD-0h
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:24:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <torbjorn.svensson@st.com>) id 1hT0yh-0007gH-D0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <torbjorn.svensson@st.com>) id 1hT0yg-0008VT-6B
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:22:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14510
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <torbjorn.svensson@st.com>)
	id 1hT0yf-0008SV-HX; Tue, 21 May 2019 05:22:34 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4L97hIw017771; Tue, 21 May 2019 11:22:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
	h=from : to : cc : subject
	: date : message-id : references : in-reply-to : content-type :
	content-transfer-encoding : mime-version; s=STMicroelectronics;
	bh=YlblJNkMn5MjaXo/R2ltSJBXT1bMXlFgqBD3cZkU6Gw=;
	b=ZTLpZkt9n+fyjouJQJmeyMAHQqufnwAZgbXmdxBRIkezCECAFucas6AQHDJTwdd3OAtu
	ZIxVhC95M7LveV7Go4QiakgAk7RhMjAoz3Ih6f5c91M8A9Spuxgcz3G969ZH1AOkPd5r
	AWhiAAITx/wu0stJMrhrnlHBptkLdZLmmD9zE073M/DRhv4tgxFD7EcUFDTS4fOyFFkx
	VfW99+exwvTTIWihsMqYwFAwCibeD4sCoe64FrpPHzN05RSdmu7DBl5931y2QIYeJy09
	j9wrjWmGR5jm+O5X+GuxPPztMn6XvwT9q8du8k+SRcT9mhlLf+ZyISvZanXVw3QFPq0W
	3A== 
Received: from eur01-db5-obe.outbound.protection.outlook.com
	(mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55])
	by mx08-00178001.pphosted.com with ESMTP id 2sj7740shm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2019 11:22:06 +0200
Received: from AM6PR10MB2504.EURPRD10.PROD.OUTLOOK.COM (20.177.116.145) by
	AM6SPR01MB0039.EURPRD10.PROD.OUTLOOK.COM (20.178.86.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.18; Tue, 21 May 2019 09:21:47 +0000
Received: from AM6PR10MB2504.EURPRD10.PROD.OUTLOOK.COM
	([fe80::9435:11d7:741e:719a]) by
	AM6PR10MB2504.EURPRD10.PROD.OUTLOOK.COM
	([fe80::9435:11d7:741e:719a%6]) with mapi id 15.20.1900.020;
	Tue, 21 May 2019 09:21:46 +0000
From: Torbjorn SVENSSON <torbjorn.svensson@st.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [Qemu-arm] [PATCH] target/arm: Fix broken VQADD and VQSUB
	causing abort
Thread-Index: AdUMxY0RShgfpEqqTEGIfg5CjmaqVAAB2h+AALpcmHA=
Date: Tue, 21 May 2019 09:21:46 +0000
Message-ID: <AM6PR10MB2504E67988D276CB7C070F7781070@AM6PR10MB2504.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB204723BF7D62501F0339242A810B0@VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM>
	<CAFEAcA9_oe2NTnyb9ce_hH5jaaTt=V4-iOzC3a5Un8k1TUWHzw@mail.gmail.com>
In-Reply-To: <CAFEAcA9_oe2NTnyb9ce_hH5jaaTt=V4-iOzC3a5Un8k1TUWHzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.76.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bed480a-fcd5-4e15-f061-08d6ddcdbf77
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6SPR01MB0039; 
x-ms-traffictypediagnostic: AM6SPR01MB0039:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6SPR01MB00393DCF043C24B8BCAD8C6481070@AM6SPR01MB0039.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(51914003)(13464003)(199004)(6916009)(76176011)(55016002)(9686003)(316002)(86362001)(74316002)(7696005)(102836004)(55236004)(99286004)(68736007)(54906003)(6306002)(6506007)(53546011)(4326008)(53936002)(6246003)(25786009)(966005)(478600001)(2906002)(14454004)(3846002)(6116002)(71200400001)(71190400001)(446003)(11346002)(256004)(73956011)(66476007)(66556008)(66446008)(66946007)(64756008)(33656002)(76116006)(476003)(5660300002)(186003)(66066001)(52536014)(26005)(8936002)(6436002)(229853002)(81166006)(81156014)(486006)(7736002)(305945005)(8676002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6SPR01MB0039;
	H:AM6PR10MB2504.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: st.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OCZyl+p6lCM7rsGqfxUABtQkNMCNmT0zCtG44+LxG++6hdst8oSXSEx52kc1f8Awtd9G/AN/G4rqxgX8xuM0ZOIE2KgHoGH+CGJz1yOV9RQ7OnNUkx3Q09lSlWSC2oFv4DRs7IyRM2PXlvd6zyso4ynkftfkZleBYUTdLTEWyahUGmcs4cC/ljh9WkOH9HfoZp3sFgpoqJnfi7wn7vig/+q3symOdP5Mc0AR7xs1nERPa5OKxTC8I8OG2bcuDYf05B87FnfQNOcb4IA2l5lBnWF0TwNTWieNA2HaoIOLKhad1Wn8tagCyULnSDk/KqOcH4fe+O90Vaek1KZhONGiuIozTmMSVTOSeS0nwUuHrS982ubWRMP8b7HYXYl98DaLYBq1Um35zeZx/kL35T+c6O2l+icr9Qn4jfYtYA9zdRo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bed480a-fcd5-4e15-f061-08d6ddcdbf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 09:21:46.8737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0039
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-21_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905210059
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 91.207.212.93
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Fix broken VQADD
 and VQSUB causing abort
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel HULTGREN <samuel.hultgren@st.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNClRoYW5rcyBmb3IgdGhlIGZhc3QgcmVzcG9uc2UhDQpHcmVhdCB0byBoZWFy
IHRoYXQgYSBwYXRjaCBmb3IgdGhlIGlzc3VlIGlzIG9uIGl0cyB3YXkgaW50byBtYXN0ZXIuIA0K
DQpLaW5kIHJlZ2FyZHMsDQpUb3JiasO2cm4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gDQpTZW50OiBk
ZW4gMTcgbWFqIDIwMTkgMTg6MjQNClRvOiBUb3Jiam9ybiBTVkVOU1NPTiA8dG9yYmpvcm4uc3Zl
bnNzb25Ac3QuY29tPg0KQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IFNhbXVlbCBIVUxUR1JFTiA8
c2FtdWVsLmh1bHRncmVuQHN0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDog
UmU6IFtRZW11LWFybV0gW1BBVENIXSB0YXJnZXQvYXJtOiBGaXggYnJva2VuIFZRQUREIGFuZCBW
UVNVQiBjYXVzaW5nIGFib3J0DQoNCk9uIEZyaSwgMTcgTWF5IDIwMTkgYXQgMTc6MDQsIFRvcmJq
b3JuIFNWRU5TU09OIDx0b3Jiam9ybi5zdmVuc3NvbkBzdC5jb20+IHdyb3RlOg0KPg0KPiBJbiBj
b21taXQgODllNjhiNTc1ZTEzOGQwYWYxNDM1ZjExYThmZmNkODc3OWMyMzdiZCwgdGhlIGhhbmRs
aW5nIG9mIA0KPiBWUUFERCBhbmQgVlFTVUIgd2FzIGNoYW5nZWQgZm9yIENvcnRleC1BIGFuZCB0
aGUgbmV3IGhhbmRsaW5nIGRvZXMgbm90IA0KPiByZXR1cm4gcHJvcGVybHkgYWZ0ZXIgY2FsbGlu
ZyB0Y2dfZ2VuX2d2ZWNfNCgpLCB0aHVzIHRoZSBjb2RlIGFmdGVyIGlzIA0KPiBleGVjdXRlZCBh
bmQgdGhhdCBkb2VzIG5vdCBrbm93IGFib3V0IHRoZSBWUUFERCBvciBWUVNVQiBpbnN0cnVjdGlv
bnMgDQo+IGFuZCBjYWxscyBhYm9ydC4NCj4NCj4gRGV0ZWN0ZWQgcnVubmluZyBHQ0MgdGVzdHN1
aXRlIGZvciBDb3J0ZXgtQTcgYW5kIGV4ZWN1dGluZyB0aGUgdGVzdHMgDQo+IGluIFFFTVUgdXNp
bmcgQ29ydGV4LUExNSBzaW5jZSBDb3J0ZXgtQTcgYW5kIENvcnRleC1BMTUgaGF2ZSBzaW1pbGFy
IA0KPiBpbnN0cnVjdGlvbiBzZXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRvcmJqw7ZybiBTVkVO
U1NPTiA8dG9yYmpvcm4uc3ZlbnNzb25Ac3QuY29tPg0KDQpIaSBUb3Jiam9ybjsgdGhhbmtzIGZv
ciB0aGlzIHBhdGNoLiBBcyBpdCBoYXBwZW5zIHRoZXJlJ3MgYWxyZWFkeSBhIGZpeCBmb3IgdGhp
cyBvbiBsaXN0Og0KIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTEwMDY0NS8N
CnNvIGl0IHNob3VsZCBnZXQgaW50byBnaXQgbWFzdGVyIHNvbWUgdGltZSBuZXh0IHdlZWsuDQoN
CnRoYW5rcw0KLS0gUE1NDQo=

