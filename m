Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA065C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B5C20679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LMwGLrdD";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="c6VATaQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B5C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqKj-0002Hi-Ig
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=71878e4925=jglauber@marvell.com>)
 id 1iIqJS-0001ZT-Qz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=71878e4925=jglauber@marvell.com>)
 id 1iIqJR-00066q-Lm
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:30:14 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50310
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=71878e4925=jglauber@marvell.com>)
 id 1iIqJR-000669-7y; Fri, 11 Oct 2019 04:30:13 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9B8TjeF025858; Fri, 11 Oct 2019 01:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=m3XYUSzhgopgd9Xgbyy4u+oJ/hfJs7vLDyu/QJZTF/k=;
 b=LMwGLrdDDMaLcw7DSGejHv/avUcFtVDTqd0hiFlPqpzuVT6rL+uEjr5ksdCBaj2ThwK+
 xHnX+ApybLh9yzaPhsKz//99AIJbpo+J+7wIFC9iEqFDKy95s1EkTd71ezo+TYorBm6c
 w9HlZP0t8UN95MM0zZhLej56yODoaCkVJZyyYm7U1+kXf1EQ8S6bV7fy3kpX94nSVuCG
 ET5wB/yP/jFcgl/vxMFOGI0op39pYIVzuvI6SbAFuZGGD7AUGiCszYPzcBN8rr25ptWa
 kNE3cj2IrkHz++lcDex0kOcHyltxKefkTgAX7rbHNGfvhAnsDjomgY41gufIiuyO2kyZ OQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 2vjj6v0tkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2019 01:30:05 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 01:30:04 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.56) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Oct 2019 01:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfypCrWjKskgySj6h/R731jqBmKJsDJmTmDUzbRP2NOKb5qrNsKaaKOssKcb5Qh4/cyKl4q2t5C6AmW2/F7ehlbuWHM1RItiDPTL+R6FxW3q8ftGVBSJz5vejEWiSfItlkaEOX7BUlkRRAR4I0BAKh9MnXnv8Yb1XKTfwL1brVbykfkHGduVfoKloP72ZmgqMBPVUB6kwvr5xj3Q3bQzWzC0PI4Cl5A84Lm92ecatDUQbXY70tlbvrfoYwUMHtB8Bjlczf1e1HAz/YS5psXm/ytDcuSUfmS/uWjt2ualFrJ2Ro/0e0EIsu836f8atweTEYEK/TSpPeE6uI1WiL+q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3XYUSzhgopgd9Xgbyy4u+oJ/hfJs7vLDyu/QJZTF/k=;
 b=EgX+ghkv7eR+5jTnnA5G3FPnXFrQ5KquZQcbKU1Yr0Hgi+Ac5Vbssb37dypRUt6PzjsEhtQrtweaMPYCuTI9SFs8NBVarXanwtSEQTBSmzntKRPerCA9+iatirfiSMeyEHX3qTMmdXhJRHlBlkSaglyOPeFOc22WpVYjm2EOM0br7hKmlebksQi24Uj+jSNlVoOxm524zbiNhbiK1IvMKwZpzsG8rd0w4BlnCgohSZ5w7MSHI/AVUCcBYpAgCuicAdrjgKAgpMxm7Q0pz1SEjcjGzSv5ZE4ip5W3itrcLeSn3sjIbSIaXmOe4b+ImnyilGJeGZv7DPiZnl9u4DSmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3XYUSzhgopgd9Xgbyy4u+oJ/hfJs7vLDyu/QJZTF/k=;
 b=c6VATaQXAs0qHZfXEqg4or1jFhBYNbKqfhwq7xSHEO/kZB1mIQJRkD518kNXnNosAZER1gkSC4gHLOL9iGWOQtr0tqemY4uLSyfLMMqN0vVQWNs01nQVuLpabA9gsfHCFP6JANx5odh7rCh08tVaQGBC30GhBjHPM9HHODxfoZE=
Received: from DM6PR18MB3001.namprd18.prod.outlook.com (20.179.104.143) by
 DM6PR18MB2954.namprd18.prod.outlook.com (20.179.50.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Fri, 11 Oct 2019 08:30:02 +0000
Received: from DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba]) by DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:30:02 +0000
From: Jan Glauber <jglauber@marvell.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Thread-Topic: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
Thread-Index: AQHVgA4T6nIqkEBuW02+19lJnMn2Pw==
Date: Fri, 11 Oct 2019 08:30:02 +0000
Message-ID: <20191011082954.GA10493@hc>
References: <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
 <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com> <20191009080220.GA2905@hc>
 <d5367b2a-84ee-1211-a2dc-7d631c94fe3f@redhat.com> <20191011060518.GA6920@hc>
 <966c119d-aa76-2149-108f-867aebd772f7@redhat.com>
In-Reply-To: <966c119d-aa76-2149-108f-867aebd772f7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::33) To DM6PR18MB3001.namprd18.prod.outlook.com
 (2603:10b6:5:182::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [46.5.207.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b2a556-686f-4ca6-9767-08d74e2535de
x-ms-traffictypediagnostic: DM6PR18MB2954:
x-microsoft-antispam-prvs: <DM6PR18MB2954A7654FBB1D961F31FC85D8970@DM6PR18MB2954.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(66446008)(305945005)(71200400001)(2906002)(14444005)(6916009)(229853002)(3846002)(316002)(4326008)(256004)(6246003)(33716001)(7736002)(6436002)(33656002)(54906003)(6486002)(6116002)(71190400001)(6512007)(99286004)(386003)(76176011)(486006)(6506007)(52116002)(9686003)(102836004)(8676002)(478600001)(66556008)(5660300002)(53546011)(81156014)(1076003)(4744005)(476003)(14454004)(86362001)(64756008)(66946007)(446003)(25786009)(8936002)(11346002)(26005)(66066001)(186003)(66476007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB2954;
 H:DM6PR18MB3001.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ic9s9TPBHW9V9oJWdmXE/ZW5+Tzk5uy+yM8bT38TiM/2UHKqukbfkgAvon+v/r80Gw89xwwurkXHHRwkWwhUrdpJq3SCvEhA1dcGLMxpJje3P1M6RMv517rj9EGjJoD0cmKUygfUXKiDOrJx52FCPjGd8ASpg/+5k9989vI9RFRqzv2C1gbUE5BpX1lcXFQGVoxnu4h0QVfaQRCwEVgJVYmzd2ABe2e8+TtDEgdCgRMFfNl7LRH+iaBTD1879sUNba2WsstLZOwr1o++WjhdollB5Qg7+wKz8ZF9D5wAcsnNJjYg096JUjqzY6QDWpOn1caLaKdB8FxxwIDiQqxWuXFVWUgPk37TvuIh/i9LDdZU017194CelI8N7h0/tEoaDSxEjQ3pUpnGjY/hLMMTe3ZXtsc9gDPagXPcrBf/cZ4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAEFC849932D5A468E26BC3890A41EE8@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2a556-686f-4ca6-9767-08d74e2535de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 08:30:02.3439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r66uR2IFxhtphSWIzWoIcMSDY1/SwfWq1pkkF/eNV6IFMekDDHd9YsDDUc0ysEH1DsVEXnV4egMiCefULGWYfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2954
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_05:2019-10-10,2019-10-11 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 67.231.148.174
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, dann frazier <dann.frazier@canonical.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>, QEMU
 Developers - ARM <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 10:18:18AM +0200, Paolo Bonzini wrote:
> On 11/10/19 08:05, Jan Glauber wrote:
> > On Wed, Oct 09, 2019 at 11:15:04AM +0200, Paolo Bonzini wrote:
> >>> ...but if I bump notify_me size to uint64_t the issue goes away.
> >>
> >> Ouch. :)  Is this with or without my patch(es)?
>=20
> You didn't answer this question.

Oh, sorry... I did but the mail probably didn't make it out.
I have both of your changes applied (as I think they make sense).

> >> Also, what if you just add a dummy uint32_t after notify_me?
> >=20
> > With the dummy the testcase also runs fine for 500 iterations.
>=20
> You might be lucky and causing list_lock to be in another cache line.
> What if you add __attribute__((aligned(16)) to notify_me (and keep the
> dummy)?

Good point. I'll try to force both into the same cacheline.

--Jan

> Paolo
>=20
> > Dann, can you try if this works on the Hi1620 too?

