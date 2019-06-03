Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA5C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D516E2802A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cOxQi+3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D516E2802A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35117 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmkH-0004vj-KT
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 09:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hXmjO-0004bO-9S
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hXmjJ-0007b6-Ma
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:10:30 -0400
Received: from mail-eopbgr710115.outbound.protection.outlook.com
	([40.107.71.115]:44400
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hXmjI-0007Wy-SZ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=4QFy4e9FGbqvTAyf8y5yGQceIN5g1mBDnP+lYIl8HPg=;
	b=cOxQi+3XccqDVo7pfzvuF/HEV/L1V7L8OF+A6uMSDU+irBCDJBSdtiZxlG8CtRSkl4QDDwsXdBeWZG1+EPqL9Zi8KhzGnM/4CrN152v/+TP95lKiwIufGcMlS5a5GUwrGJtQe/PxmcPX13MLAkPrfVR284urh5QTWM/aV1K9iN4=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1076.namprd22.prod.outlook.com (10.174.85.156) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Mon, 3 Jun 2019 13:10:20 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::b0c5:c059:f809:fc07]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::b0c5:c059:f809:fc07%2]) with mapi id 15.20.1943.018;
	Mon, 3 Jun 2019 13:10:20 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mateja Marjanovic
	<mateja.marjanovic@rt-rk.com>
Thread-Topic: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for
	MSA binary operations
Thread-Index: AQHU0qqIl/K0DkPLJkmgHbdIuPoLNaaI5w0AgAGM2F0=
Date: Mon, 3 Jun 2019 13:10:20 +0000
Message-ID: <BN6PR2201MB12512BA7B7D00602F78C1331C6140@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>,
	<877ea4dsvt.fsf@zen.linaroharston>
In-Reply-To: <877ea4dsvt.fsf@zen.linaroharston>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 289e4b74-ec2c-4e17-42f9-08d6e824d4eb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1076; 
x-ms-traffictypediagnostic: BN6PR2201MB1076:
x-microsoft-antispam-prvs: <BN6PR2201MB1076DB0CE434FC9CEFDB17D1C6140@BN6PR2201MB1076.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(55016002)(53936002)(53946003)(9686003)(86362001)(4326008)(33656002)(25786009)(55236004)(186003)(6246003)(6506007)(7696005)(8936002)(81166006)(81156014)(102836004)(6436002)(66066001)(5660300002)(2501003)(229853002)(76176011)(53546011)(68736007)(26005)(8676002)(99286004)(110136005)(54906003)(74316002)(71200400001)(30864003)(478600001)(14454004)(52536014)(66574012)(7736002)(305945005)(71190400001)(316002)(446003)(2906002)(11346002)(73956011)(91956017)(76116006)(3846002)(6116002)(66446008)(486006)(66476007)(256004)(476003)(66556008)(66946007)(64756008)(579004)(559001)(569006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1076;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMV4V3FTOYOZ4IW4LEut/EH9UMcnotJMWCXnEo9qd8diqlbwvvTEr3z34xC5cGoiZFmJlXdE0oLIryYAxOg192TVRB+LdnRSMh3DktJnxtPiy0IaNEvgJJJtPpkOmO3kdRHQUQ9EabHjT60RAggb3yEiZxlEcxWK/cfYl4bG/EMJC9HrJglagOSfFp090kZn6JIWsdMaV4iMqJ08bLvwnTqmS7hpPuo7A36O9BTBAP3T01O9ey7HZqR37zGwW8WHWFSjRwIMrnX3r3o8YPsrscV+Q2fpzcWGu4ZptJidSGyiQuOCW8EkE54NIcgmkgPxroHHHL+2mDeDaQrz+YE+c1vlvBb9vd+j1KPFbjwify7Y6diGhu7zNoxrYOIcPLyQMYYtuquDFnx3oEJv+42fUBzSq6/IxY3FApFzqd3fASc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289e4b74-ec2c-4e17-42f9-08d6e824d4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 13:10:20.6356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1076
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.115
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for
 MSA binary operations
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Benn=E9e <alex.bennee@linaro.org>
> Sent: Sunday, June 2, 2019 3:22 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Rikalo; Aleksandar Markovic; aurelien@aurel32.net
> Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance fo=
r MSA binary operations


> Mateja Marjanovic <mateja.marjanovic@rt-rk.com> writes:

> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >
> > Eliminate loops for better performance.

> Have you done any measurements of the bellow loop unrolling? Because
> this is something that maybe we can achieve and let the compiler make
> the choice.

I know that Mateja did extensive performance measurements, and I am
asking him to give us some samples.

As for code generation, here are disassemblies of function
helper_msa_add_a_df() before and after this patch:

(it is visible the compiler did not perform unrolling loops by itself)

BEFORE:

Dump of assembler code for function helper_msa_add_a_df:
   0x00000000001500b0 <+0>:	cmp    $0x1,%esi
   0x00000000001500b3 <+3>:	je     0x150258 <helper_msa_add_a_df+424>
   0x00000000001500b9 <+9>:	jb     0x1501e8 <helper_msa_add_a_df+312>
   0x00000000001500bf <+15>:	cmp    $0x2,%esi
   0x00000000001500c2 <+18>:	je     0x150180 <helper_msa_add_a_df+208>
   0x00000000001500c8 <+24>:	cmp    $0x3,%esi
   0x00000000001500cb <+27>:	jne    0x1502c2 <helper_msa_add_a_df+530>
   0x00000000001500d1 <+33>:	mov    %ecx,%ecx
   0x00000000001500d3 <+35>:	mov    %edx,%edx
   0x00000000001500d5 <+37>:	lea    0x22(%rcx),%rax
   0x00000000001500d9 <+41>:	lea    0x22(%rdx),%r10
   0x00000000001500dd <+45>:	shl    $0x4,%rcx
   0x00000000001500e1 <+49>:	add    %rdi,%rcx
   0x00000000001500e4 <+52>:	shl    $0x4,%rdx
   0x00000000001500e8 <+56>:	shl    $0x4,%rax
   0x00000000001500ec <+60>:	shl    $0x4,%r10
   0x00000000001500f0 <+64>:	add    %rdi,%rax
   0x00000000001500f3 <+67>:	mov    0x8(%rax),%r9
   0x00000000001500f7 <+71>:	mov    0x8(%rax),%rsi
   0x00000000001500fb <+75>:	mov    %r8d,%eax
   0x00000000001500fe <+78>:	sar    $0x3f,%r9
   0x0000000000150102 <+82>:	xor    %r9,%rsi
   0x0000000000150105 <+85>:	sub    %r9,%rsi
   0x0000000000150108 <+88>:	mov    %rsi,%r9
   0x000000000015010b <+91>:	lea    0x22(%rax),%rsi
   0x000000000015010f <+95>:	shl    $0x4,%rax
   0x0000000000150113 <+99>:	lea    (%rdi,%rax,1),%rax
   0x0000000000150117 <+103>:	shl    $0x4,%rsi
   0x000000000015011b <+107>:	add    %rdi,%rsi
   0x000000000015011e <+110>:	mov    0x8(%rsi),%r8
   0x0000000000150122 <+114>:	mov    0x8(%rsi),%r11
   0x0000000000150126 <+118>:	sar    $0x3f,%r8
   0x000000000015012a <+122>:	xor    %r8,%r11
   0x000000000015012d <+125>:	mov    %r11,%rsi
   0x0000000000150130 <+128>:	sub    %r8,%rsi
   0x0000000000150133 <+131>:	add    %r9,%rsi
   0x0000000000150136 <+134>:	mov    %rsi,0x8(%rdi,%r10,1)
   0x000000000015013b <+139>:	mov    0x230(%rcx),%rsi
   0x0000000000150142 <+146>:	mov    0x230(%rcx),%r8
   0x0000000000150149 <+153>:	sar    $0x3f,%rsi
   0x000000000015014d <+157>:	xor    %rsi,%r8
   0x0000000000150150 <+160>:	mov    %r8,%rcx
   0x0000000000150153 <+163>:	mov    0x230(%rax),%r8
   0x000000000015015a <+170>:	sub    %rsi,%rcx
   0x000000000015015d <+173>:	mov    0x230(%rax),%rsi
   0x0000000000150164 <+180>:	sar    $0x3f,%rsi
   0x0000000000150168 <+184>:	xor    %rsi,%r8
   0x000000000015016b <+187>:	mov    %r8,%rax
   0x000000000015016e <+190>:	sub    %rsi,%rax
   0x0000000000150171 <+193>:	add    %rcx,%rax
   0x0000000000150174 <+196>:	mov    %rax,0x230(%rdi,%rdx,1)
   0x000000000015017c <+204>:	retq  =20
   0x000000000015017d <+205>:	nopl   (%rax)
   0x0000000000150180 <+208>:	mov    %r8d,%r8d
   0x0000000000150183 <+211>:	mov    %ecx,%ecx
   0x0000000000150185 <+213>:	mov    %edx,%edx
   0x0000000000150187 <+215>:	mov    %r8,%rax
   0x000000000015018a <+218>:	neg    %r8
   0x000000000015018d <+221>:	shl    $0x4,%rcx
   0x0000000000150191 <+225>:	shl    $0x4,%rax
   0x0000000000150195 <+229>:	shl    $0x4,%r8
   0x0000000000150199 <+233>:	shl    $0x4,%rdx
   0x000000000015019d <+237>:	lea    0x228(%rdi,%rax,1),%r9
   0x00000000001501a5 <+245>:	lea    0x238(%rdi,%rax,1),%rdi
   0x00000000001501ad <+253>:	lea    (%r9,%r8,1),%r10
   0x00000000001501b1 <+257>:	add    $0x4,%r9
   0x00000000001501b5 <+261>:	movslq (%r10,%rcx,1),%rax
   0x00000000001501b9 <+265>:	mov    %rax,%rsi
   0x00000000001501bc <+268>:	sar    $0x3f,%rsi
   0x00000000001501c0 <+272>:	xor    %rsi,%rax
   0x00000000001501c3 <+275>:	sub    %rsi,%rax
   0x00000000001501c6 <+278>:	movslq -0x4(%r9),%rsi
   0x00000000001501ca <+282>:	mov    %rsi,%r11
   0x00000000001501cd <+285>:	sar    $0x3f,%r11
   0x00000000001501d1 <+289>:	xor    %r11,%rsi
   0x00000000001501d4 <+292>:	sub    %r11,%rsi
   0x00000000001501d7 <+295>:	add    %rsi,%rax
   0x00000000001501da <+298>:	cmp    %rdi,%r9
   0x00000000001501dd <+301>:	mov    %eax,(%r10,%rdx,1)
   0x00000000001501e1 <+305>:	jne    0x1501ad <helper_msa_add_a_df+253>
   0x00000000001501e3 <+307>:	repz retq=20
   0x00000000001501e5 <+309>:	nopl   (%rax)
   0x00000000001501e8 <+312>:	mov    %r8d,%r8d
   0x00000000001501eb <+315>:	mov    %ecx,%ecx
   0x00000000001501ed <+317>:	mov    %edx,%edx
   0x00000000001501ef <+319>:	mov    %r8,%rax
   0x00000000001501f2 <+322>:	neg    %r8
   0x00000000001501f5 <+325>:	shl    $0x4,%rcx
   0x00000000001501f9 <+329>:	shl    $0x4,%rax
   0x00000000001501fd <+333>:	shl    $0x4,%r8
   0x0000000000150201 <+337>:	shl    $0x4,%rdx
   0x0000000000150205 <+341>:	lea    0x228(%rdi,%rax,1),%r9
   0x000000000015020d <+349>:	lea    0x238(%rdi,%rax,1),%r11
   0x0000000000150215 <+357>:	nopl   (%rax)
   0x0000000000150218 <+360>:	lea    (%r8,%r9,1),%rdi
   0x000000000015021c <+364>:	add    $0x1,%r9
   0x0000000000150220 <+368>:	movsbq (%rdi,%rcx,1),%rax
   0x0000000000150225 <+373>:	mov    %rax,%rsi
   0x0000000000150228 <+376>:	sar    $0x3f,%rsi
   0x000000000015022c <+380>:	xor    %rsi,%rax
   0x000000000015022f <+383>:	sub    %rsi,%rax
   0x0000000000150232 <+386>:	movsbq -0x1(%r9),%rsi
   0x0000000000150237 <+391>:	mov    %rsi,%r10
   0x000000000015023a <+394>:	sar    $0x3f,%r10
   0x000000000015023e <+398>:	xor    %r10,%rsi
   0x0000000000150241 <+401>:	sub    %r10,%rsi
   0x0000000000150244 <+404>:	add    %rsi,%rax
   0x0000000000150247 <+407>:	cmp    %r9,%r11
   0x000000000015024a <+410>:	mov    %al,(%rdi,%rdx,1)
   0x000000000015024d <+413>:	jne    0x150218 <helper_msa_add_a_df+360>
   0x000000000015024f <+415>:	repz retq=20
   0x0000000000150251 <+417>:	nopl   0x0(%rax)
   0x0000000000150258 <+424>:	mov    %r8d,%r8d
   0x000000000015025b <+427>:	mov    %ecx,%ecx
   0x000000000015025d <+429>:	mov    %edx,%edx
   0x000000000015025f <+431>:	mov    %r8,%rax
   0x0000000000150262 <+434>:	neg    %r8
   0x0000000000150265 <+437>:	shl    $0x4,%rcx
   0x0000000000150269 <+441>:	shl    $0x4,%rax
   0x000000000015026d <+445>:	shl    $0x4,%r8
   0x0000000000150271 <+449>:	shl    $0x4,%rdx
   0x0000000000150275 <+453>:	lea    0x228(%rdi,%rax,1),%r9
   0x000000000015027d <+461>:	lea    0x238(%rdi,%rax,1),%r10
   0x0000000000150285 <+469>:	nopl   (%rax)
   0x0000000000150288 <+472>:	lea    (%r8,%r9,1),%rdi
   0x000000000015028c <+476>:	add    $0x2,%r9
   0x0000000000150290 <+480>:	movswq (%rdi,%rcx,1),%rax
   0x0000000000150295 <+485>:	mov    %rax,%rsi
   0x0000000000150298 <+488>:	sar    $0x3f,%rsi
   0x000000000015029c <+492>:	xor    %rsi,%rax
   0x000000000015029f <+495>:	sub    %rsi,%rax
   0x00000000001502a2 <+498>:	movswq -0x2(%r9),%rsi
   0x00000000001502a7 <+503>:	mov    %rsi,%r11
   0x00000000001502aa <+506>:	sar    $0x3f,%r11
   0x00000000001502ae <+510>:	xor    %r11,%rsi
   0x00000000001502b1 <+513>:	sub    %r11,%rsi
   0x00000000001502b4 <+516>:	add    %rsi,%rax
   0x00000000001502b7 <+519>:	cmp    %r10,%r9
   0x00000000001502ba <+522>:	mov    %ax,(%rdi,%rdx,1)
   0x00000000001502be <+526>:	jne    0x150288 <helper_msa_add_a_df+472>
   0x00000000001502c0 <+528>:	repz retq=20
   0x00000000001502c2 <+530>:	lea    0x13c3b7(%rip),%rcx        # 0x28c680 =
<__PRETTY_FUNCTION__.26062>
   0x00000000001502c9 <+537>:	lea    0x13b830(%rip),%rsi        # 0x28bb00
   0x00000000001502d0 <+544>:	lea    0x1c7204(%rip),%rdi        # 0x3174db
   0x00000000001502d7 <+551>:	sub    $0x8,%rsp
   0x00000000001502db <+555>:	mov    $0x357,%edx
   0x00000000001502e0 <+560>:	callq  0x8eeb8
End of assembler dump.


AFTER:

   0x00000000001548d0 <+0>:	cmp    $0x1,%esi
   0x00000000001548d3 <+3>:	je     0x154e00 <helper_msa_add_a_df+1328>
   0x00000000001548d9 <+9>:	jb     0x154a98 <helper_msa_add_a_df+456>
   0x00000000001548df <+15>:	cmp    $0x2,%esi
   0x00000000001548e2 <+18>:	je     0x1549a0 <helper_msa_add_a_df+208>
   0x00000000001548e8 <+24>:	cmp    $0x3,%esi
   0x00000000001548eb <+27>:	jne    0x154fd1 <helper_msa_add_a_df+1793>
   0x00000000001548f1 <+33>:	mov    %ecx,%eax
   0x00000000001548f3 <+35>:	mov    %r8d,%r8d
   0x00000000001548f6 <+38>:	mov    %edx,%edx
   0x00000000001548f8 <+40>:	lea    0x22(%rax),%rcx
   0x00000000001548fc <+44>:	lea    0x22(%rdx),%r9
   0x0000000000154900 <+48>:	shl    $0x4,%rax
   0x0000000000154904 <+52>:	add    %rdi,%rax
   0x0000000000154907 <+55>:	shl    $0x4,%rdx
   0x000000000015490b <+59>:	shl    $0x4,%rcx
   0x000000000015490f <+63>:	shl    $0x4,%r9
   0x0000000000154913 <+67>:	add    %rdi,%rcx
   0x0000000000154916 <+70>:	mov    0x8(%rcx),%rsi
   0x000000000015491a <+74>:	mov    0x8(%rcx),%r11
   0x000000000015491e <+78>:	sar    $0x3f,%rsi
   0x0000000000154922 <+82>:	xor    %rsi,%r11
   0x0000000000154925 <+85>:	mov    %r11,%rcx
   0x0000000000154928 <+88>:	sub    %rsi,%rcx
   0x000000000015492b <+91>:	mov    %rcx,%rsi
   0x000000000015492e <+94>:	lea    0x22(%r8),%rcx
   0x0000000000154932 <+98>:	shl    $0x4,%r8
   0x0000000000154936 <+102>:	add    %rdi,%r8
   0x0000000000154939 <+105>:	shl    $0x4,%rcx
   0x000000000015493d <+109>:	add    %rdi,%rcx
   0x0000000000154940 <+112>:	mov    0x8(%rcx),%r10
   0x0000000000154944 <+116>:	mov    0x8(%rcx),%r11
   0x0000000000154948 <+120>:	sar    $0x3f,%r10
   0x000000000015494c <+124>:	xor    %r10,%r11
   0x000000000015494f <+127>:	mov    %r11,%rcx
   0x0000000000154952 <+130>:	sub    %r10,%rcx
   0x0000000000154955 <+133>:	add    %rsi,%rcx
   0x0000000000154958 <+136>:	mov    %rcx,0x8(%rdi,%r9,1)
   0x000000000015495d <+141>:	mov    0x230(%rax),%rcx
   0x0000000000154964 <+148>:	mov    0x230(%rax),%rsi
   0x000000000015496b <+155>:	sar    $0x3f,%rcx
   0x000000000015496f <+159>:	xor    %rcx,%rsi
   0x0000000000154972 <+162>:	mov    %rsi,%rax
   0x0000000000154975 <+165>:	mov    0x230(%r8),%rsi
   0x000000000015497c <+172>:	sub    %rcx,%rax
   0x000000000015497f <+175>:	mov    %rax,%rcx
   0x0000000000154982 <+178>:	mov    0x230(%r8),%rax
   0x0000000000154989 <+185>:	sar    $0x3f,%rsi
   0x000000000015498d <+189>:	xor    %rsi,%rax
   0x0000000000154990 <+192>:	sub    %rsi,%rax
   0x0000000000154993 <+195>:	add    %rcx,%rax
   0x0000000000154996 <+198>:	mov    %rax,0x230(%rdi,%rdx,1)
   0x000000000015499e <+206>:	retq  =20
   0x000000000015499f <+207>:	nop
   0x00000000001549a0 <+208>:	mov    %ecx,%ecx
   0x00000000001549a2 <+210>:	mov    %r8d,%r8d
   0x00000000001549a5 <+213>:	mov    %edx,%edx
   0x00000000001549a7 <+215>:	lea    0x22(%rcx),%rax
   0x00000000001549ab <+219>:	lea    0x22(%rdx),%r9
   0x00000000001549af <+223>:	shl    $0x4,%rcx
   0x00000000001549b3 <+227>:	add    %rdi,%rcx
   0x00000000001549b6 <+230>:	shl    $0x4,%rdx
   0x00000000001549ba <+234>:	shl    $0x4,%rax
   0x00000000001549be <+238>:	shl    $0x4,%r9
   0x00000000001549c2 <+242>:	add    %rdi,%rdx
   0x00000000001549c5 <+245>:	movslq 0x8(%rdi,%rax,1),%rax
   0x00000000001549ca <+250>:	mov    %rax,%rsi
   0x00000000001549cd <+253>:	sar    $0x3f,%rsi
   0x00000000001549d1 <+257>:	xor    %rsi,%rax
   0x00000000001549d4 <+260>:	sub    %rsi,%rax
   0x00000000001549d7 <+263>:	lea    0x22(%r8),%rsi
   0x00000000001549db <+267>:	shl    $0x4,%r8
   0x00000000001549df <+271>:	shl    $0x4,%rsi
   0x00000000001549e3 <+275>:	movslq 0x8(%rdi,%rsi,1),%rsi
   0x00000000001549e8 <+280>:	mov    %rsi,%r10
   0x00000000001549eb <+283>:	sar    $0x3f,%r10
   0x00000000001549ef <+287>:	xor    %r10,%rsi
   0x00000000001549f2 <+290>:	sub    %r10,%rsi
   0x00000000001549f5 <+293>:	add    %rsi,%rax
   0x00000000001549f8 <+296>:	mov    %eax,0x8(%rdi,%r9,1)
   0x00000000001549fd <+301>:	movslq 0x22c(%rcx),%rax
   0x0000000000154a04 <+308>:	add    %r8,%rdi
   0x0000000000154a07 <+311>:	mov    %rax,%rsi
   0x0000000000154a0a <+314>:	sar    $0x3f,%rsi
   0x0000000000154a0e <+318>:	xor    %rsi,%rax
   0x0000000000154a11 <+321>:	sub    %rsi,%rax
   0x0000000000154a14 <+324>:	movslq 0x22c(%rdi),%rsi
   0x0000000000154a1b <+331>:	mov    %rsi,%r8
   0x0000000000154a1e <+334>:	sar    $0x3f,%r8
   0x0000000000154a22 <+338>:	xor    %r8,%rsi
   0x0000000000154a25 <+341>:	sub    %r8,%rsi
   0x0000000000154a28 <+344>:	add    %rsi,%rax
   0x0000000000154a2b <+347>:	mov    %eax,0x22c(%rdx)
   0x0000000000154a31 <+353>:	movslq 0x230(%rcx),%rax
   0x0000000000154a38 <+360>:	mov    %rax,%rsi
   0x0000000000154a3b <+363>:	sar    $0x3f,%rsi
   0x0000000000154a3f <+367>:	xor    %rsi,%rax
   0x0000000000154a42 <+370>:	sub    %rsi,%rax
   0x0000000000154a45 <+373>:	movslq 0x230(%rdi),%rsi
   0x0000000000154a4c <+380>:	mov    %rsi,%r8
   0x0000000000154a4f <+383>:	sar    $0x3f,%r8
   0x0000000000154a53 <+387>:	xor    %r8,%rsi
   0x0000000000154a56 <+390>:	sub    %r8,%rsi
   0x0000000000154a59 <+393>:	add    %rsi,%rax
   0x0000000000154a5c <+396>:	mov    %eax,0x230(%rdx)
   0x0000000000154a62 <+402>:	movslq 0x234(%rcx),%rax
   0x0000000000154a69 <+409>:	mov    %rax,%rcx
   0x0000000000154a6c <+412>:	sar    $0x3f,%rcx
   0x0000000000154a70 <+416>:	xor    %rcx,%rax
   0x0000000000154a73 <+419>:	sub    %rcx,%rax
   0x0000000000154a76 <+422>:	movslq 0x234(%rdi),%rcx
   0x0000000000154a7d <+429>:	mov    %rcx,%rsi
   0x0000000000154a80 <+432>:	sar    $0x3f,%rsi
   0x0000000000154a84 <+436>:	xor    %rsi,%rcx
   0x0000000000154a87 <+439>:	sub    %rsi,%rcx
   0x0000000000154a8a <+442>:	add    %rcx,%rax
   0x0000000000154a8d <+445>:	mov    %eax,0x234(%rdx)
   0x0000000000154a93 <+451>:	retq  =20
   0x0000000000154a94 <+452>:	nopl   0x0(%rax)
   0x0000000000154a98 <+456>:	mov    %ecx,%eax
   0x0000000000154a9a <+458>:	mov    %r8d,%r8d
   0x0000000000154a9d <+461>:	mov    %edx,%edx
   0x0000000000154a9f <+463>:	lea    0x22(%rax),%rcx
   0x0000000000154aa3 <+467>:	lea    0x22(%rdx),%r9
   0x0000000000154aa7 <+471>:	shl    $0x4,%rax
   0x0000000000154aab <+475>:	lea    (%rdi,%rax,1),%rax
   0x0000000000154aaf <+479>:	shl    $0x4,%rdx
   0x0000000000154ab3 <+483>:	shl    $0x4,%rcx
   0x0000000000154ab7 <+487>:	shl    $0x4,%r9
   0x0000000000154abb <+491>:	add    %rdi,%rdx
   0x0000000000154abe <+494>:	movsbq 0x8(%rdi,%rcx,1),%rsi
   0x0000000000154ac4 <+500>:	mov    %rsi,%rcx
   0x0000000000154ac7 <+503>:	sar    $0x3f,%rcx
   0x0000000000154acb <+507>:	xor    %rcx,%rsi
   0x0000000000154ace <+510>:	sub    %rcx,%rsi
   0x0000000000154ad1 <+513>:	lea    0x22(%r8),%rcx
   0x0000000000154ad5 <+517>:	shl    $0x4,%r8
   0x0000000000154ad9 <+521>:	shl    $0x4,%rcx
   0x0000000000154add <+525>:	movsbq 0x8(%rdi,%rcx,1),%rcx
   0x0000000000154ae3 <+531>:	mov    %rcx,%r10
   0x0000000000154ae6 <+534>:	sar    $0x3f,%r10
   0x0000000000154aea <+538>:	xor    %r10,%rcx
   0x0000000000154aed <+541>:	sub    %r10,%rcx
   0x0000000000154af0 <+544>:	add    %rcx,%rsi
   0x0000000000154af3 <+547>:	mov    %sil,0x8(%rdi,%r9,1)
   0x0000000000154af8 <+552>:	movsbq 0x229(%rax),%rcx
   0x0000000000154b00 <+560>:	add    %r8,%rdi
   0x0000000000154b03 <+563>:	mov    %rcx,%rsi
   0x0000000000154b06 <+566>:	sar    $0x3f,%rsi
   0x0000000000154b0a <+570>:	xor    %rsi,%rcx
   0x0000000000154b0d <+573>:	sub    %rsi,%rcx
   0x0000000000154b10 <+576>:	movsbq 0x229(%rdi),%rsi
   0x0000000000154b18 <+584>:	mov    %rsi,%r8
   0x0000000000154b1b <+587>:	sar    $0x3f,%r8
   0x0000000000154b1f <+591>:	xor    %r8,%rsi
   0x0000000000154b22 <+594>:	sub    %r8,%rsi
   0x0000000000154b25 <+597>:	add    %rsi,%rcx
   0x0000000000154b28 <+600>:	mov    %cl,0x229(%rdx)
   0x0000000000154b2e <+606>:	movsbq 0x22a(%rax),%rcx
   0x0000000000154b36 <+614>:	mov    %rcx,%rsi
   0x0000000000154b39 <+617>:	sar    $0x3f,%rsi
   0x0000000000154b3d <+621>:	xor    %rsi,%rcx
   0x0000000000154b40 <+624>:	sub    %rsi,%rcx
   0x0000000000154b43 <+627>:	movsbq 0x22a(%rdi),%rsi
   0x0000000000154b4b <+635>:	mov    %rsi,%r8
   0x0000000000154b4e <+638>:	sar    $0x3f,%r8
   0x0000000000154b52 <+642>:	xor    %r8,%rsi
   0x0000000000154b55 <+645>:	sub    %r8,%rsi
   0x0000000000154b58 <+648>:	add    %rsi,%rcx
   0x0000000000154b5b <+651>:	mov    %cl,0x22a(%rdx)
   0x0000000000154b61 <+657>:	movsbq 0x22b(%rax),%rcx
   0x0000000000154b69 <+665>:	mov    %rcx,%rsi
   0x0000000000154b6c <+668>:	sar    $0x3f,%rsi
   0x0000000000154b70 <+672>:	xor    %rsi,%rcx
   0x0000000000154b73 <+675>:	sub    %rsi,%rcx
   0x0000000000154b76 <+678>:	movsbq 0x22b(%rdi),%rsi
   0x0000000000154b7e <+686>:	mov    %rsi,%r8
   0x0000000000154b81 <+689>:	sar    $0x3f,%r8
   0x0000000000154b85 <+693>:	xor    %r8,%rsi
   0x0000000000154b88 <+696>:	sub    %r8,%rsi
   0x0000000000154b8b <+699>:	add    %rsi,%rcx
   0x0000000000154b8e <+702>:	mov    %cl,0x22b(%rdx)
   0x0000000000154b94 <+708>:	movsbq 0x22c(%rax),%rcx
   0x0000000000154b9c <+716>:	mov    %rcx,%rsi
   0x0000000000154b9f <+719>:	sar    $0x3f,%rsi
   0x0000000000154ba3 <+723>:	xor    %rsi,%rcx
   0x0000000000154ba6 <+726>:	sub    %rsi,%rcx
   0x0000000000154ba9 <+729>:	movsbq 0x22c(%rdi),%rsi
   0x0000000000154bb1 <+737>:	mov    %rsi,%r8
   0x0000000000154bb4 <+740>:	sar    $0x3f,%r8
   0x0000000000154bb8 <+744>:	xor    %r8,%rsi
   0x0000000000154bbb <+747>:	sub    %r8,%rsi
   0x0000000000154bbe <+750>:	add    %rsi,%rcx
   0x0000000000154bc1 <+753>:	mov    %cl,0x22c(%rdx)
   0x0000000000154bc7 <+759>:	movsbq 0x22d(%rax),%rcx
   0x0000000000154bcf <+767>:	mov    %rcx,%rsi
   0x0000000000154bd2 <+770>:	sar    $0x3f,%rsi
   0x0000000000154bd6 <+774>:	xor    %rsi,%rcx
   0x0000000000154bd9 <+777>:	sub    %rsi,%rcx
   0x0000000000154bdc <+780>:	movsbq 0x22d(%rdi),%rsi
   0x0000000000154be4 <+788>:	mov    %rsi,%r8
   0x0000000000154be7 <+791>:	sar    $0x3f,%r8
   0x0000000000154beb <+795>:	xor    %r8,%rsi
   0x0000000000154bee <+798>:	sub    %r8,%rsi
   0x0000000000154bf1 <+801>:	add    %rsi,%rcx
   0x0000000000154bf4 <+804>:	mov    %cl,0x22d(%rdx)
   0x0000000000154bfa <+810>:	movsbq 0x22e(%rax),%rcx
   0x0000000000154c02 <+818>:	mov    %rcx,%rsi
   0x0000000000154c05 <+821>:	sar    $0x3f,%rsi
   0x0000000000154c09 <+825>:	xor    %rsi,%rcx
   0x0000000000154c0c <+828>:	sub    %rsi,%rcx
   0x0000000000154c0f <+831>:	movsbq 0x22e(%rdi),%rsi
   0x0000000000154c17 <+839>:	mov    %rsi,%r8
   0x0000000000154c1a <+842>:	sar    $0x3f,%r8
   0x0000000000154c1e <+846>:	xor    %r8,%rsi
   0x0000000000154c21 <+849>:	sub    %r8,%rsi
   0x0000000000154c24 <+852>:	add    %rsi,%rcx
   0x0000000000154c27 <+855>:	mov    %cl,0x22e(%rdx)
   0x0000000000154c2d <+861>:	movsbq 0x22f(%rax),%rcx
   0x0000000000154c35 <+869>:	mov    %rcx,%rsi
   0x0000000000154c38 <+872>:	sar    $0x3f,%rsi
   0x0000000000154c3c <+876>:	xor    %rsi,%rcx
   0x0000000000154c3f <+879>:	sub    %rsi,%rcx
   0x0000000000154c42 <+882>:	movsbq 0x22f(%rdi),%rsi
   0x0000000000154c4a <+890>:	mov    %rsi,%r8
   0x0000000000154c4d <+893>:	sar    $0x3f,%r8
   0x0000000000154c51 <+897>:	xor    %r8,%rsi
   0x0000000000154c54 <+900>:	sub    %r8,%rsi
   0x0000000000154c57 <+903>:	add    %rsi,%rcx
   0x0000000000154c5a <+906>:	mov    %cl,0x22f(%rdx)
   0x0000000000154c60 <+912>:	movsbq 0x230(%rax),%rcx
   0x0000000000154c68 <+920>:	mov    %rcx,%rsi
   0x0000000000154c6b <+923>:	sar    $0x3f,%rsi
   0x0000000000154c6f <+927>:	xor    %rsi,%rcx
   0x0000000000154c72 <+930>:	sub    %rsi,%rcx
   0x0000000000154c75 <+933>:	movsbq 0x230(%rdi),%rsi
   0x0000000000154c7d <+941>:	mov    %rsi,%r8
   0x0000000000154c80 <+944>:	sar    $0x3f,%r8
   0x0000000000154c84 <+948>:	xor    %r8,%rsi
   0x0000000000154c87 <+951>:	sub    %r8,%rsi
   0x0000000000154c8a <+954>:	add    %rsi,%rcx
   0x0000000000154c8d <+957>:	mov    %cl,0x230(%rdx)
   0x0000000000154c93 <+963>:	movsbq 0x231(%rax),%rcx
   0x0000000000154c9b <+971>:	mov    %rcx,%rsi
   0x0000000000154c9e <+974>:	sar    $0x3f,%rsi
   0x0000000000154ca2 <+978>:	xor    %rsi,%rcx
   0x0000000000154ca5 <+981>:	sub    %rsi,%rcx
   0x0000000000154ca8 <+984>:	movsbq 0x231(%rdi),%rsi
   0x0000000000154cb0 <+992>:	mov    %rsi,%r8
   0x0000000000154cb3 <+995>:	sar    $0x3f,%r8
   0x0000000000154cb7 <+999>:	xor    %r8,%rsi
   0x0000000000154cba <+1002>:	sub    %r8,%rsi
   0x0000000000154cbd <+1005>:	add    %rsi,%rcx
   0x0000000000154cc0 <+1008>:	mov    %cl,0x231(%rdx)
   0x0000000000154cc6 <+1014>:	movsbq 0x232(%rax),%rcx
   0x0000000000154cce <+1022>:	mov    %rcx,%rsi
   0x0000000000154cd1 <+1025>:	sar    $0x3f,%rsi
   0x0000000000154cd5 <+1029>:	xor    %rsi,%rcx
   0x0000000000154cd8 <+1032>:	sub    %rsi,%rcx
   0x0000000000154cdb <+1035>:	movsbq 0x232(%rdi),%rsi
   0x0000000000154ce3 <+1043>:	mov    %rsi,%r8
   0x0000000000154ce6 <+1046>:	sar    $0x3f,%r8
   0x0000000000154cea <+1050>:	xor    %r8,%rsi
   0x0000000000154ced <+1053>:	sub    %r8,%rsi
   0x0000000000154cf0 <+1056>:	add    %rsi,%rcx
   0x0000000000154cf3 <+1059>:	mov    %cl,0x232(%rdx)
   0x0000000000154cf9 <+1065>:	movsbq 0x233(%rdi),%rcx
   0x0000000000154d01 <+1073>:	mov    %rcx,%rsi
   0x0000000000154d04 <+1076>:	sar    $0x3f,%rsi
   0x0000000000154d08 <+1080>:	xor    %rsi,%rcx
   0x0000000000154d0b <+1083>:	sub    %rsi,%rcx
   0x0000000000154d0e <+1086>:	movsbq 0x233(%rax),%rsi
   0x0000000000154d16 <+1094>:	mov    %rsi,%r8
   0x0000000000154d19 <+1097>:	sar    $0x3f,%r8
   0x0000000000154d1d <+1101>:	xor    %r8,%rsi
   0x0000000000154d20 <+1104>:	sub    %r8,%rsi
   0x0000000000154d23 <+1107>:	add    %rsi,%rcx
   0x0000000000154d26 <+1110>:	mov    %cl,0x233(%rdx)
   0x0000000000154d2c <+1116>:	movsbq 0x234(%rdi),%rcx
   0x0000000000154d34 <+1124>:	mov    %rcx,%rsi
   0x0000000000154d37 <+1127>:	sar    $0x3f,%rsi
   0x0000000000154d3b <+1131>:	xor    %rsi,%rcx
   0x0000000000154d3e <+1134>:	sub    %rsi,%rcx
   0x0000000000154d41 <+1137>:	movsbq 0x234(%rax),%rsi
   0x0000000000154d49 <+1145>:	mov    %rsi,%r8
   0x0000000000154d4c <+1148>:	sar    $0x3f,%r8
   0x0000000000154d50 <+1152>:	xor    %r8,%rsi
   0x0000000000154d53 <+1155>:	sub    %r8,%rsi
   0x0000000000154d56 <+1158>:	add    %rsi,%rcx
   0x0000000000154d59 <+1161>:	mov    %cl,0x234(%rdx)
   0x0000000000154d5f <+1167>:	movsbq 0x235(%rax),%rcx
   0x0000000000154d67 <+1175>:	mov    %rcx,%rsi
   0x0000000000154d6a <+1178>:	sar    $0x3f,%rsi
   0x0000000000154d6e <+1182>:	xor    %rsi,%rcx
   0x0000000000154d71 <+1185>:	sub    %rsi,%rcx
   0x0000000000154d74 <+1188>:	movsbq 0x235(%rdi),%rsi
   0x0000000000154d7c <+1196>:	mov    %rsi,%r8
   0x0000000000154d7f <+1199>:	sar    $0x3f,%r8
   0x0000000000154d83 <+1203>:	xor    %r8,%rsi
   0x0000000000154d86 <+1206>:	sub    %r8,%rsi
   0x0000000000154d89 <+1209>:	add    %rsi,%rcx
   0x0000000000154d8c <+1212>:	mov    %cl,0x235(%rdx)
   0x0000000000154d92 <+1218>:	movsbq 0x236(%rdi),%rcx
   0x0000000000154d9a <+1226>:	mov    %rcx,%rsi
   0x0000000000154d9d <+1229>:	sar    $0x3f,%rsi
   0x0000000000154da1 <+1233>:	xor    %rsi,%rcx
   0x0000000000154da4 <+1236>:	sub    %rsi,%rcx
   0x0000000000154da7 <+1239>:	movsbq 0x236(%rax),%rsi
   0x0000000000154daf <+1247>:	mov    %rsi,%r8
   0x0000000000154db2 <+1250>:	sar    $0x3f,%r8
   0x0000000000154db6 <+1254>:	xor    %r8,%rsi
   0x0000000000154db9 <+1257>:	sub    %r8,%rsi
   0x0000000000154dbc <+1260>:	add    %rsi,%rcx
   0x0000000000154dbf <+1263>:	mov    %cl,0x236(%rdx)
   0x0000000000154dc5 <+1269>:	movsbq 0x237(%rax),%rax
   0x0000000000154dcd <+1277>:	mov    %rax,%rcx
   0x0000000000154dd0 <+1280>:	sar    $0x3f,%rcx
   0x0000000000154dd4 <+1284>:	xor    %rcx,%rax
   0x0000000000154dd7 <+1287>:	sub    %rcx,%rax
   0x0000000000154dda <+1290>:	movsbq 0x237(%rdi),%rcx
   0x0000000000154de2 <+1298>:	mov    %rcx,%rsi
   0x0000000000154de5 <+1301>:	sar    $0x3f,%rsi
   0x0000000000154de9 <+1305>:	xor    %rsi,%rcx
   0x0000000000154dec <+1308>:	sub    %rsi,%rcx
   0x0000000000154def <+1311>:	add    %rcx,%rax
   0x0000000000154df2 <+1314>:	mov    %al,0x237(%rdx)
   0x0000000000154df8 <+1320>:	retq  =20
   0x0000000000154df9 <+1321>:	nopl   0x0(%rax)
   0x0000000000154e00 <+1328>:	mov    %ecx,%eax
   0x0000000000154e02 <+1330>:	mov    %r8d,%r8d
   0x0000000000154e05 <+1333>:	mov    %edx,%edx
   0x0000000000154e07 <+1335>:	lea    0x22(%rax),%rcx
   0x0000000000154e0b <+1339>:	lea    0x22(%rdx),%r9
   0x0000000000154e0f <+1343>:	shl    $0x4,%rax
   0x0000000000154e13 <+1347>:	lea    (%rdi,%rax,1),%rax
   0x0000000000154e17 <+1351>:	shl    $0x4,%rdx
   0x0000000000154e1b <+1355>:	shl    $0x4,%rcx
   0x0000000000154e1f <+1359>:	shl    $0x4,%r9
   0x0000000000154e23 <+1363>:	add    %rdi,%rdx
   0x0000000000154e26 <+1366>:	movswq 0x8(%rdi,%rcx,1),%rsi
   0x0000000000154e2c <+1372>:	mov    %rsi,%rcx
   0x0000000000154e2f <+1375>:	sar    $0x3f,%rcx
   0x0000000000154e33 <+1379>:	xor    %rcx,%rsi
   0x0000000000154e36 <+1382>:	sub    %rcx,%rsi
   0x0000000000154e39 <+1385>:	lea    0x22(%r8),%rcx
   0x0000000000154e3d <+1389>:	shl    $0x4,%r8
   0x0000000000154e41 <+1393>:	shl    $0x4,%rcx
   0x0000000000154e45 <+1397>:	movswq 0x8(%rdi,%rcx,1),%rcx
   0x0000000000154e4b <+1403>:	mov    %rcx,%r10
   0x0000000000154e4e <+1406>:	sar    $0x3f,%r10
   0x0000000000154e52 <+1410>:	xor    %r10,%rcx
   0x0000000000154e55 <+1413>:	sub    %r10,%rcx
   0x0000000000154e58 <+1416>:	add    %rcx,%rsi
   0x0000000000154e5b <+1419>:	mov    %si,0x8(%rdi,%r9,1)
   0x0000000000154e61 <+1425>:	movswq 0x22a(%rax),%rcx
   0x0000000000154e69 <+1433>:	add    %r8,%rdi
   0x0000000000154e6c <+1436>:	mov    %rcx,%rsi
   0x0000000000154e6f <+1439>:	sar    $0x3f,%rsi
   0x0000000000154e73 <+1443>:	xor    %rsi,%rcx
   0x0000000000154e76 <+1446>:	sub    %rsi,%rcx
   0x0000000000154e79 <+1449>:	movswq 0x22a(%rdi),%rsi
   0x0000000000154e81 <+1457>:	mov    %rsi,%r8
   0x0000000000154e84 <+1460>:	sar    $0x3f,%r8
   0x0000000000154e88 <+1464>:	xor    %r8,%rsi
   0x0000000000154e8b <+1467>:	sub    %r8,%rsi
   0x0000000000154e8e <+1470>:	add    %rsi,%rcx
   0x0000000000154e91 <+1473>:	mov    %cx,0x22a(%rdx)
   0x0000000000154e98 <+1480>:	movswq 0x22c(%rax),%rcx
   0x0000000000154ea0 <+1488>:	mov    %rcx,%rsi
   0x0000000000154ea3 <+1491>:	sar    $0x3f,%rsi
   0x0000000000154ea7 <+1495>:	xor    %rsi,%rcx
   0x0000000000154eaa <+1498>:	sub    %rsi,%rcx
   0x0000000000154ead <+1501>:	movswq 0x22c(%rdi),%rsi
   0x0000000000154eb5 <+1509>:	mov    %rsi,%r8
   0x0000000000154eb8 <+1512>:	sar    $0x3f,%r8
   0x0000000000154ebc <+1516>:	xor    %r8,%rsi
   0x0000000000154ebf <+1519>:	sub    %r8,%rsi
   0x0000000000154ec2 <+1522>:	add    %rsi,%rcx
   0x0000000000154ec5 <+1525>:	mov    %cx,0x22c(%rdx)
   0x0000000000154ecc <+1532>:	movswq 0x22e(%rax),%rcx
   0x0000000000154ed4 <+1540>:	mov    %rcx,%rsi
   0x0000000000154ed7 <+1543>:	sar    $0x3f,%rsi
   0x0000000000154edb <+1547>:	xor    %rsi,%rcx
   0x0000000000154ede <+1550>:	sub    %rsi,%rcx
   0x0000000000154ee1 <+1553>:	movswq 0x22e(%rdi),%rsi
   0x0000000000154ee9 <+1561>:	mov    %rsi,%r8
   0x0000000000154eec <+1564>:	sar    $0x3f,%r8
   0x0000000000154ef0 <+1568>:	xor    %r8,%rsi
   0x0000000000154ef3 <+1571>:	sub    %r8,%rsi
   0x0000000000154ef6 <+1574>:	add    %rsi,%rcx
   0x0000000000154ef9 <+1577>:	mov    %cx,0x22e(%rdx)
   0x0000000000154f00 <+1584>:	movswq 0x230(%rax),%rcx
   0x0000000000154f08 <+1592>:	mov    %rcx,%rsi
   0x0000000000154f0b <+1595>:	sar    $0x3f,%rsi
   0x0000000000154f0f <+1599>:	xor    %rsi,%rcx
   0x0000000000154f12 <+1602>:	sub    %rsi,%rcx
   0x0000000000154f15 <+1605>:	movswq 0x230(%rdi),%rsi
   0x0000000000154f1d <+1613>:	mov    %rsi,%r8
   0x0000000000154f20 <+1616>:	sar    $0x3f,%r8
   0x0000000000154f24 <+1620>:	xor    %r8,%rsi
   0x0000000000154f27 <+1623>:	sub    %r8,%rsi
   0x0000000000154f2a <+1626>:	add    %rsi,%rcx
   0x0000000000154f2d <+1629>:	mov    %cx,0x230(%rdx)
   0x0000000000154f34 <+1636>:	movswq 0x232(%rax),%rcx
   0x0000000000154f3c <+1644>:	mov    %rcx,%rsi
   0x0000000000154f3f <+1647>:	sar    $0x3f,%rsi
   0x0000000000154f43 <+1651>:	xor    %rsi,%rcx
   0x0000000000154f46 <+1654>:	sub    %rsi,%rcx
   0x0000000000154f49 <+1657>:	movswq 0x232(%rdi),%rsi
   0x0000000000154f51 <+1665>:	mov    %rsi,%r8
   0x0000000000154f54 <+1668>:	sar    $0x3f,%r8
   0x0000000000154f58 <+1672>:	xor    %r8,%rsi
   0x0000000000154f5b <+1675>:	sub    %r8,%rsi
   0x0000000000154f5e <+1678>:	add    %rsi,%rcx
   0x0000000000154f61 <+1681>:	mov    %cx,0x232(%rdx)
   0x0000000000154f68 <+1688>:	movswq 0x234(%rax),%rcx
   0x0000000000154f70 <+1696>:	mov    %rcx,%rsi
   0x0000000000154f73 <+1699>:	sar    $0x3f,%rsi
   0x0000000000154f77 <+1703>:	xor    %rsi,%rcx
   0x0000000000154f7a <+1706>:	sub    %rsi,%rcx
   0x0000000000154f7d <+1709>:	movswq 0x234(%rdi),%rsi
   0x0000000000154f85 <+1717>:	mov    %rsi,%r8
   0x0000000000154f88 <+1720>:	sar    $0x3f,%r8
   0x0000000000154f8c <+1724>:	xor    %r8,%rsi
   0x0000000000154f8f <+1727>:	sub    %r8,%rsi
   0x0000000000154f92 <+1730>:	add    %rsi,%rcx
   0x0000000000154f95 <+1733>:	mov    %cx,0x234(%rdx)
   0x0000000000154f9c <+1740>:	movswq 0x236(%rax),%rax
   0x0000000000154fa4 <+1748>:	mov    %rax,%rcx
   0x0000000000154fa7 <+1751>:	sar    $0x3f,%rcx
   0x0000000000154fab <+1755>:	xor    %rcx,%rax
   0x0000000000154fae <+1758>:	sub    %rcx,%rax
   0x0000000000154fb1 <+1761>:	movswq 0x236(%rdi),%rcx
   0x0000000000154fb9 <+1769>:	mov    %rcx,%rsi
   0x0000000000154fbc <+1772>:	sar    $0x3f,%rsi
   0x0000000000154fc0 <+1776>:	xor    %rsi,%rcx
   0x0000000000154fc3 <+1779>:	sub    %rsi,%rcx
   0x0000000000154fc6 <+1782>:	add    %rcx,%rax
   0x0000000000154fc9 <+1785>:	mov    %ax,0x236(%rdx)
   0x0000000000154fd0 <+1792>:	retq  =20
   0x0000000000154fd1 <+1793>:	lea    0x14faa8(%rip),%rcx        # 0x2a4a80=
 <__PRETTY_FUNCTION__.25843>
   0x0000000000154fd8 <+1800>:	lea    0x14ef81(%rip),%rsi        # 0x2a3f60
   0x0000000000154fdf <+1807>:	lea    0x1da975(%rip),%rdi        # 0x32f95b
   0x0000000000154fe6 <+1814>:	sub    $0x8,%rsp
   0x0000000000154fea <+1818>:	mov    $0x368,%edx
   0x0000000000154fef <+1823>:	callq  0x8f170


> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > ---
> >  target/mips/msa_helper.c | 43 ++++++++++++++++++++++++++++++----------=
---
> >  1 file changed, 30 insertions(+), 13 deletions(-)
> >
> > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> > index 4c7ec05..1152fda 100644
> > --- a/target/mips/msa_helper.c
> > +++ b/target/mips/msa_helper.c
> > @@ -804,28 +804,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env=
, uint32_t df,         \
> >      wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);                      =
    \
> >      wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);                      =
    \
> >      wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
> > \

> If we can ensure alignment for the various vector registers then the
> compiler always has the option of using host vectors (certainly for int
> and logic operations).

> > -    uint32_t i;                                                       =
  \
> >                                                                        =
  \

> >      switch (df) {                                                     =
  \
> >      case DF_BYTE:                                                     =
  \
> > -        for (i =3D 0; i < DF_ELEMENTS(DF_BYTE); i++) {                =
    \
> > -            pwd->b[i] =3D msa_ ## func ## _df(df, pws->b[i], pwt->b[i]=
);  \
> > -        }                                                             =
  \
> > +        pwd->b[0]  =3D msa_ ## func ## _df(df, pws->b[0], pwt->b[0]); =
    \
> > +        pwd->b[1]  =3D msa_ ## func ## _df(df, pws->b[1], pwt->b[1]); =
    \
> > +        pwd->b[2]  =3D msa_ ## func ## _df(df, pws->b[2], pwt->b[2]); =
    \
> > +        pwd->b[3]  =3D msa_ ## func ## _df(df, pws->b[3], pwt->b[3]); =
    \
> > +        pwd->b[4]  =3D msa_ ## func ## _df(df, pws->b[4], pwt->b[4]); =
    \
> > +        pwd->b[5]  =3D msa_ ## func ## _df(df, pws->b[5], pwt->b[5]); =
    \
> > +        pwd->b[6]  =3D msa_ ## func ## _df(df, pws->b[6], pwt->b[6]); =
    \
> > +        pwd->b[7]  =3D msa_ ## func ## _df(df, pws->b[7], pwt->b[7]); =
    \
> > +        pwd->b[8]  =3D msa_ ## func ## _df(df, pws->b[8], pwt->b[8]); =
    \
> > +        pwd->b[9]  =3D msa_ ## func ## _df(df, pws->b[9], pwt->b[9]); =
    \
> > +        pwd->b[10] =3D msa_ ## func ## _df(df, pws->b[10], pwt->b[10])=
;   \
> > +        pwd->b[11] =3D msa_ ## func ## _df(df, pws->b[11], pwt->b[11])=
;   \
> > +        pwd->b[12] =3D msa_ ## func ## _df(df, pws->b[12], pwt->b[12])=
;   \
> > +        pwd->b[13] =3D msa_ ## func ## _df(df, pws->b[13], pwt->b[13])=
;   \
> > +        pwd->b[14] =3D msa_ ## func ## _df(df, pws->b[14], pwt->b[14])=
;   \
> > +        pwd->b[15] =3D msa_ ## func ## _df(df, pws->b[15], pwt->b[15])=
;   \
> >          break;                                                        =
  \
> >      case DF_HALF:                                                     =
  \
> > -        for (i =3D 0; i < DF_ELEMENTS(DF_HALF); i++) {                =
    \
> > -            pwd->h[i] =3D msa_ ## func ## _df(df, pws->h[i], pwt->h[i]=
);  \
> > -        }                                                             =
  \
> > +        pwd->h[0] =3D msa_ ## func ## _df(df, pws->h[0], pwt->h[0]);  =
    \
> > +        pwd->h[1] =3D msa_ ## func ## _df(df, pws->h[1], pwt->h[1]);  =
    \
> > +        pwd->h[2] =3D msa_ ## func ## _df(df, pws->h[2], pwt->h[2]);  =
    \
> > +        pwd->h[3] =3D msa_ ## func ## _df(df, pws->h[3], pwt->h[3]);  =
    \
> > +        pwd->h[4] =3D msa_ ## func ## _df(df, pws->h[4], pwt->h[4]);  =
    \
> > +        pwd->h[5] =3D msa_ ## func ## _df(df, pws->h[5], pwt->h[5]);  =
    \
> > +        pwd->h[6] =3D msa_ ## func ## _df(df, pws->h[6], pwt->h[6]);  =
    \
> > +        pwd->h[7] =3D msa_ ## func ## _df(df, pws->h[7], pwt->h[7]);  =
    \
> >          break;                                                        =
  \
> >      case DF_WORD:                                                     =
  \
> > -        for (i =3D 0; i < DF_ELEMENTS(DF_WORD); i++) {                =
    \
> > -            pwd->w[i] =3D msa_ ## func ## _df(df, pws->w[i], pwt->w[i]=
);  \
> > -        }                                                             =
  \
> > +        pwd->w[0] =3D msa_ ## func ## _df(df, pws->w[0], pwt->w[0]);  =
    \
> > +        pwd->w[1] =3D msa_ ## func ## _df(df, pws->w[1], pwt->w[1]);  =
    \
> > +        pwd->w[2] =3D msa_ ## func ## _df(df, pws->w[2], pwt->w[2]);  =
    \
> > +        pwd->w[3] =3D msa_ ## func ## _df(df, pws->w[3], pwt->w[3]);  =
    \
> >          break;                                                        =
  \
> >      case DF_DOUBLE:                                                   =
  \
> > -        for (i =3D 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {              =
    \
> > -            pwd->d[i] =3D msa_ ## func ## _df(df, pws->d[i], pwt->d[i]=
);  \
> > -        }                                                             =
  \
> > +        pwd->d[0] =3D msa_ ## func ## _df(df, pws->d[0], pwt->d[0]);  =
    \
> > +        pwd->d[1] =3D msa_ ## func ## _df(df, pws->d[1], pwt->d[1]);  =
    \
> >          break;                                                        =
  \
> >      default:                                                          =
  \
> >          assert(0);                                                    =
  \


--
Alex Benn=E9e

