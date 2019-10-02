Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF894C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B988321920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XgWodsgG";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="iknwAG2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B988321920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdku-0000zA-L6
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=71787d9211=jglauber@marvell.com>)
 id 1iFcSZ-0001Zp-H6
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=71787d9211=jglauber@marvell.com>)
 id 1iFcSY-00086U-4u
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:06:19 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=71787d9211=jglauber@marvell.com>)
 id 1iFcSX-00084J-OW; Wed, 02 Oct 2019 07:06:18 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x92B56hO016689; Wed, 2 Oct 2019 04:06:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EFDxkDF/0G/gyAHFdLEbXHCcL5I84rZ0elughXsauuY=;
 b=XgWodsgGm1W39e/LDV3T4rIh6k5MGrHU0xBNnRexvagpEfIPPJO9ay2c1wMk9iSuWavl
 We+ae5rlDG28zN3iL9V9zYU0xEEU0ROAO35t2ujkr4Fjn8/b1tMeZjFmGZeNECEyf/41
 K8wwXmvSpVEaLDM2Vs2HXZR5tQiVzOo6vW6hqU3lqc2z/yKJFLPLvukAafd5+K1y/0im
 3gEslFjhlfU1NHbUPYyk8dBdR+iZWQwumLtlu+y/Mvtp1VarZnvvFmq8WzRTaskdbk61
 +sZVzbVM2W/ZMCX9o1dFAJDA12thfslZLpiWNbuEYkvP8fJM7CIN0frTd3TVXqO8tUO3 Bw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 2va71mpse0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2019 04:06:02 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 2 Oct
 2019 04:06:00 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Oct 2019 04:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+3/VP5TgRYHm7WEO54gDuuS/usRQzQv2JNa6d/CS/K96UonPqN3p2NGbJmuxf83weIwLJ+zvBZ09cXECLqyIYyst24C/QSMr6QMqTM1qPXsOa19DEwypoMIxyDW/8QtPWuxmS2sZ9JcC00THJf+5nTKxqyIh17sT+gaNSAmgAOiZukl1KQl9J8YOo+fAV8TAGSzyn64dzsQYm2B0m9rYlXzHwkYjQ7Q6OtpCD68ScijXW2nSf8l3oP/c8NHO9OFXMP85o5XQ+Y74cL3TSD8hgMWz6PN21mMzI3Qc6HnXFWNOWhkWkLu0nRcZtCaN+UAKv9QDCBYsQZ6FszEseQUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFDxkDF/0G/gyAHFdLEbXHCcL5I84rZ0elughXsauuY=;
 b=PQMrkQcTfduoHD5JPPomNUQ7FYYh9Jfh1fFy+3yBSveiwWrl249HGFyArN2Tgaoz0fyLO7bQS38n0lTOt+GacAB22sKFUwHmwEpjLWJaZmpXh17wSb1F/xJo748rbKKqhvNge22szRoboGzhNHE7MGLdkNRcEcLWMB1T9Z3OxPsqBnxTBJ12mzwqzfvT5fDn8WIihIIOt7mCfmRlZdwtQs+835IDhkl19vyYGyVOxPjyrJ7ZjgIo0yihAhL29oOEToV+jxf5+H2CQOrTO6v+XIv1mGN/6ylBJW6tBWnNjXTLP4SPws5L3iMKGtQCxQZQCNaubBjZ1OyCscd+4Nr3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFDxkDF/0G/gyAHFdLEbXHCcL5I84rZ0elughXsauuY=;
 b=iknwAG2G3geAYmCJk0QRAsKrhFfWAhhsd8oGZtqot+Y5YKYMc9z47/bCt27yROpH4ZcEt3GTBfU/kf5CuF77lbB/RWBcbtIg+1ZVCd43nPTXkmmKIUqYO1hjHfKStDxcdfxlj9C/pgLGMq8gbb3eqIS2yTbpYkvovl4XdIPZU84=
Received: from DM6PR18MB3001.namprd18.prod.outlook.com (20.179.104.143) by
 DM6PR18MB2362.namprd18.prod.outlook.com (20.179.71.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.18; Wed, 2 Oct 2019 11:05:59 +0000
Received: from DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba]) by DM6PR18MB3001.namprd18.prod.outlook.com
 ([fe80::11c2:98e0:b9d9:5dba%5]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 11:05:59 +0000
From: Jan Glauber <jglauber@marvell.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Thread-Topic: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
Thread-Index: AQHVeRFen3KZ7K8mD02pkgA8c1cuvA==
Date: Wed, 2 Oct 2019 11:05:59 +0000
Message-ID: <20191002110550.GA3482@hc>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <ed5c4522-9250-e403-c55d-d3dbcda82540@redhat.com>
In-Reply-To: <ed5c4522-9250-e403-c55d-d3dbcda82540@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::36) To DM6PR18MB3001.namprd18.prod.outlook.com
 (2603:10b6:5:182::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.42.2.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7d98316-6b95-4f2c-992c-08d74728814a
x-ms-traffictypediagnostic: DM6PR18MB2362:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR18MB2362690DAEE656B51202DB52D89C0@DM6PR18MB2362.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(6306002)(316002)(7736002)(81166006)(1076003)(52116002)(6436002)(66066001)(8936002)(99286004)(2906002)(33656002)(4326008)(9686003)(5660300002)(305945005)(8676002)(14444005)(26005)(81156014)(966005)(6486002)(3846002)(478600001)(76176011)(6116002)(256004)(6246003)(6916009)(229853002)(14454004)(53546011)(6506007)(6512007)(5024004)(102836004)(25786009)(386003)(86362001)(11346002)(476003)(486006)(64756008)(71200400001)(66556008)(66476007)(66946007)(33716001)(71190400001)(446003)(66446008)(186003)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB2362;
 H:DM6PR18MB3001.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/p9KFAwpMC/KNFOS3sW1jO+wWfr79FyHxaRIPKUbVt1su826VmXfXMBtyZ1PZlCpCEuuVU9hS4BXbzvQCFMie7EeLjivlGWPtrKhNXNwPdZf2lhzNv3V097hxW1d3k4ZLqX+53htrJzsA8fL8J2dcw3KIhS7ONOc3SqTO/aR01dEQEk8uExvc2EyhOhFcr7gOWekY0JaRc5bkYMu5GyC0/eqcOUbwdbVUZoBOV5p2A4mlD6rbGJoi5fjHFdY/6eTOc9htcqR58UuapdkrbcLUL3kEqa5u1FqWfLHMuBg1eGSPTKj3Oex7ZU7Adi9CPXzdiJhcDtGEnuBvO2fUa72nBqkIwk2gc+WE/NCxKb8yL3gd44CUDUg/XQ1dtQWw1HQNphFZBhbHCWF8uZsaFYs/chG6dRTLeNlGTsa6+4LlEw7Dn0f7gdf7lqxYRuUGDPds4O7iWsC/Tx4zo9q2ncrA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4E5701BF442ED4899E88E94649B8589@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d98316-6b95-4f2c-992c-08d74728814a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 11:05:59.2576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xK+wbFx59S6OXXyUO0Pz1HoEOiUrGg8SCeeVjz1l1q+0JdgYw78OrnL7fvczoe3DD/QhrocgCJczSakk0ij8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2362
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_06:2019-10-01,2019-10-02 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 67.231.156.173
X-Mailman-Approved-At: Wed, 02 Oct 2019 08:27:28 -0400
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

On Wed, Oct 02, 2019 at 11:45:19AM +0200, Paolo Bonzini wrote:
> On 02/10/19 11:23, Jan Glauber wrote:
> > I've tried to verify me theory with this patch and didn't run into the
> > issue for ~500 iterations (usually I would trigger the issue ~20 iterat=
ions).
>=20
> Awesome!  That would be a compiler bug though, as atomic_add and atomic_s=
ub
> are defined as sequentially consistent:
>=20
> #define atomic_add(ptr, n) ((void) __atomic_fetch_add(ptr, n, __ATOMIC_SE=
Q_CST))
> #define atomic_sub(ptr, n) ((void) __atomic_fetch_sub(ptr, n, __ATOMIC_SE=
Q_CST))

Compiler bug sounds kind of unlikely...

> What compiler are you using and what distro?  Can you compile util/aio-po=
six.c
> with "-fdump-rtl-all -fdump-tree-all", zip the boatload of debugging file=
s and
> send them my way?

This is on Ubuntu 18.04.3,
gcc version 7.4.0 (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)

I've uploaded the debug files to:
https://bugs.launchpad.net/qemu/+bug/1805256/+attachment/5293619/+files/aio=
-posix.tar.xz

Thanks,
Jan

> Thanks,
>=20
> Paolo

