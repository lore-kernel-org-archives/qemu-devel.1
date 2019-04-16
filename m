Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B6C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 21:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3062075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 21:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="kQca03dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3062075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGVWo-0003HS-I5
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 17:22:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGVVX-0002eN-Sq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGVVW-0003b5-K4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:47 -0400
Received: from mail-eopbgr800109.outbound.protection.outlook.com
	([40.107.80.109]:42400
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGVVW-0003Yq-6X
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BkLOkmfMvEh7D93lZ8koINBedXII0msF2f+Cua140FU=;
	b=kQca03dqPXM4/G7paR/pKnXKxqU/xGaIMYiSSU4lBbjjdq4nccbqnPtEVyuhQcIyKKf1PCFdjBWXn29IeMCTo0nL8efgGY2QS9pHMOjWLlxzahBQcoTz46vQ+YcMhXmlLJ/3oYnM1dkN1zHXHVKZqADuXvk886uSWT3wBWYYHL8=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1106.namprd22.prod.outlook.com (10.174.88.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.15; Tue, 16 Apr 2019 21:20:42 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1813.011;
	Tue, 16 Apr 2019 21:20:42 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>, Aleksandar Markovic
	<aleksandar.m.mail@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH v6 4/4] target/mips: Optimize ILVR.<B|H|W|D>
	MSA instructions
Thread-Index: AQHU6uhqTf+UfVuf8UKb+Agp55g0waY6T5OAgALWGQCAAjSa6Q==
Date: Tue, 16 Apr 2019 21:20:42 +0000
Message-ID:
 <BN6PR2201MB1251458C6A26DEE093C282EEC6240@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-5-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=i3H+aMaOCqMBkK4r9E4Ezqtyqw=VbwNmJZ6Wnc3in5PA@mail.gmail.com>,
	<bcc405c5-2e96-19a9-123e-bc607c243209@rt-rk.com>
In-Reply-To: <bcc405c5-2e96-19a9-123e-bc607c243209@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 228ab1eb-59a0-4174-e5cc-08d6c2b161a7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1106; 
x-ms-traffictypediagnostic: BN6PR2201MB1106:
x-microsoft-antispam-prvs: <BN6PR2201MB1106CF78BAE5E6AC5EC073A5C6240@BN6PR2201MB1106.namprd22.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(39840400004)(346002)(136003)(396003)(199004)(189003)(486006)(5660300002)(68736007)(8676002)(55016002)(93886005)(74316002)(14444005)(256004)(478600001)(2906002)(9686003)(8936002)(6246003)(86362001)(81156014)(81166006)(446003)(6436002)(11346002)(14454004)(97736004)(476003)(229853002)(7696005)(76176011)(186003)(6506007)(25786009)(3846002)(66066001)(110136005)(105586002)(54906003)(106356001)(4326008)(53936002)(7736002)(6116002)(305945005)(71190400001)(52536014)(316002)(99286004)(71200400001)(26005)(55236004)(33656002)(102836004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1106;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w9Eoh+jBTc2BjCxDFQRSMEoDcafXg/DYYBvQJdlErXS5GOXJLwpfSlK1Tug+nQcfOIBZwbha0rTwplyiLyA1lLY9Cv32n+YjA7t7loIvals7bg+/7kK3+ncKir4JTgsCqe+WGUzNgFrpW5ukpXws/3P5GJ/2xPHTrEgCQuJVZd7kTOpukVz5lgrteot29znkY/M/ndWV9gX6J2gN/xnnuwDaCgINEFqE2BEgmuH8YPtzzpUB6ABRwbqUYPrWejcUsGPFgTWA2FSeO+rklYQoVsghab4gmAbS3Q4fwOb816k/tuRvND1gReHAE3Z/Y8IkXgpQfNvrfKEjZdqS2sU5rN6Jv+eUrnvDX8YBkCmWdfg/ltaqWV7O60H4tw9tHZq1s+S0rovqS60x6a9c0dYVv4roHDka9UNku3XctNBTdgw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228ab1eb-59a0-4174-e5cc-08d6c2b161a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 21:20:42.0495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1106
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.109
Subject: Re: [Qemu-devel] [PATCH v6 4/4] target/mips: Optimize
 ILVR.<B|H|W|D> MSA instructions
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
	=?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416212042.hnfyTRIaIwbLcmghrtY24EwhR88hbZBl1CcpDn_dtlE@z>

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >>
> >> +void helper_msa_ilvr_b(CPUMIPSState *env, uint32_t wd,
> >> +                       uint32_t ws, uint32_t wt)
> >> +{
> >> +    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> >> +    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
> >> +    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
> >> +
> > Why do we use here env->active_fpu.fpr[wd].wr, while for other instruct=
ions in
> > this patch, we access msa_wr_d<b|h|w|d[] directly?
> With a pointer to wr_t we have an array of bytes, halfwords, words or
> doublewords
> and can read from them and change them like an ordinary array. In other
> cases
> we use a variable that is TCGv_i64 and would have to use tcg_gen
> functions to
> modify the value of the register. Before my changes in ilvr instruction
> helpers
> env->active_fpu.fpr[wd].wr was used, so I just copy-pasted that.
>

Your answer touches just surface, and doesn't fully answer my question.
I would like you to show deeper understanding of the code you are working
with. You can't just copy/paste without thinking.

Why do majority of MSA helpers use env->active_fpu.fpr[<index>].wr, while
your code mostly reference the MSA register directly? Is this the same
thing? If yes, why all MSA code doesn't use registers directly, which
would certainly be simpler than referencing active_fpu? What is the role
of "active_fpu"? Can it be changed? Can you analyze the underlying
reasons for referencing "active_fpu", and can you claim that it is safe
to circumvent it and reference the MSA registers directly?

Thanks,
Aleksandar

