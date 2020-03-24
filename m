Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CCC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD05020775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="cjhXjYON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD05020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGm6H-0006m8-RL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jGm5f-0006K3-Rm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jGm5e-0002J4-2b
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:07:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:37744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jGm5d-0002II-K5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:07:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OFi272012940; Tue, 24 Mar 2020 09:07:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Cek0b8wEmwLsWV5NgWaZfPr00vHzu3b4Rlbf2QQbXHA=;
 b=cjhXjYONQSQqcdRemdG+a/gehckQKuS7pTkyC4xnFD+vykPoNVFtCrtgtvbHzJjGCFiW
 tOegR2J4P16XLupNukORTx2UGs938aWJB/ZSxyYDP25Zk0bpJwIZS4qivk/AdnvHPsEy
 IJ2NMu1ck01C4LCL8Y8cy30Bc4wUnvdh2IsJS4rOMXKRd3qVCJytpM9fd8AeyfKBtnqV
 t64540Adgzp/1loojzTy2g77EhOkUy05DB0RGHPSy6OIjBxeyWkU72VmA+/1hbhr+D0Q
 zY3RaGWmSNxuIW3VuQCpjLg5NH5QbkrCxZrxLW6SK0x1cnFyGRhzdEZBeoGwFaTiv9BI Dg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ywj8fx3bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2020 09:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lryay1f6uIE/kwHy48WYQOW8aYYrNowBfgWsa1uukLfwcyuipJZL8HCdZxOlfJomy1zK7EzLt+yjoUxkTmWpdkcMXuKP5Vje68cb6CiwS3wLxWrRqZA7B25dn0nNKrtPoUiUCqsWGidDDukPKtrkWS0aX9NB7hdb3XFTponTVdsmj9va6FqPPi6NwfBu+Moe3v+xHgfUAWF2UJi5CZFEeOvwJsWSP1zs784eQFe0pxpeeu+AkABgCQPvGDyOGJLat2GRvVoOPEsVsy4mSeCqcqQe3nzr67ZkigB2qPx0yWNlUibOfz272/KDCCXBgoofUDb/KikwUH18e4coLsbkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cek0b8wEmwLsWV5NgWaZfPr00vHzu3b4Rlbf2QQbXHA=;
 b=OMQ+x5X1MtmPwMhMKo1PmPIJ3ElckjtFT16uPvj5oF7bMlhvzbPmFA1JT+JTHDc2Lm+LK2u2M04LMMlXDgrwi1Y0UGBhq2LosnpkyHV0A0P4IIv61EhYLfC0q77eAmBl83NiFai8/n2L6ipA6gnZrW2X6jbGPYHPORBSiha7IAVPI2knSa+nmWHeRRcfrluBd5GU3ngshbKwne07o5ZQAd+f6Mlefif3c+yJfgK+g2xi0mt9FQqsU53Ne21poxWDXi0Q3SLSQY4aCRbyoTBVsJxlAiQk5AQXtChod6v2iuAz2Hcn7bmQ3oXPigaCO2M9+K6gROv06jX3o9wl3gRtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6093.namprd02.prod.outlook.com (2603:10b6:208:1b6::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 16:07:35 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 16:07:35 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Hot unplug disabling on pci-pci bridge
Thread-Topic: Hot unplug disabling on pci-pci bridge
Thread-Index: AQHWAcPYtZw/rt1SL0WZPWjOTF64NqhXlY8AgAALkICAACcKgIAAIPaA
Date: Tue, 24 Mar 2020 16:07:35 +0000
Message-ID: <794EC45E-B3AC-4DBD-80A8-5FEC21302F51@nutanix.com>
References: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
 <20200324120828.2b50d41e@redhat.com>
 <95F47446-8E5E-4CF1-A076-24D714F7A827@nutanix.com>
 <20200324150935.4bfe8464@redhat.com>
In-Reply-To: <20200324150935.4bfe8464@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32451d77-1141-4d8a-cba0-08d7d00d7773
x-ms-traffictypediagnostic: MN2PR02MB6093:
x-microsoft-antispam-prvs: <MN2PR02MB6093C72EE1CFF5CE4E5E9F05F1F10@MN2PR02MB6093.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(44832011)(86362001)(6916009)(33656002)(81166006)(71200400001)(186003)(36756003)(54906003)(6486002)(26005)(8936002)(2616005)(8676002)(81156014)(64756008)(53546011)(4326008)(66556008)(76116006)(91956017)(66446008)(66946007)(558084003)(478600001)(5660300002)(2906002)(316002)(6506007)(6512007)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6093;
 H:MN2PR02MB5742.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aeCnGM3ZHSJAR+lSwRyorm4/qXMhbyi6v8Fk5FMc7wwXeP1L1y48mBcpNdRGICgePSYWTjuq4umb8qKnkwEQGU/+gpBkxJbO/X5LAqvDAxXW8iq58nIS/8Mw6A16+89oiHvplGPN67pkWz3EanRE4ZSbe/lc9yyvuUOuobP3+P4dUamN+bLyJOv9z9sUiOtcStm1BC63HcZjIu66AyCKMgP6ZkvIPwikmtkKnTj+AKOUDQSuFwf+12/DVwshAsPo27d8UKZ5Y7HfQaD7dpmpEEyhCLZ1K95Fr+NwRSVfN8vtPCVQdHaJ3f6N4BAd10Dzz0xJTtm8k4bes76nO7h60z6e0TwbU6ZA0b+VUhgyWGIBwQC02ssji1Q9tTxgQfDHBVm7i5RoA1QPQ6jzgOIaVdEeA48VLnpy8ZrOi5r8PgXuEy7XtIY9x5WULePd+utL
x-ms-exchange-antispam-messagedata: 7jgUbV2xJLG34JNUC1Yf3RmdmJYi+CJZ189kzpthlo0KilqMuLjWKpTfQOrsQMUcipszHbbiesfhXN8ZgKTkbSJv9dDSNGlm23CejTqUhxtQHtKnZon8k+FPJIXOqKig8CJ6oGeronZIGMG7LnraEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40B48E85ED2B7747AD45845657DDA922@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32451d77-1141-4d8a-cba0-08d7d00d7773
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:07:35.1915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrGjWW7frl+jshXHfRFmYg5v88CpjgpBmCPts15F57mr1pg7os1d8qUYS9/BkcTgzFppABAgQa2nPCzTfTRpAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6093
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_05:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Mar 24, 2020, at 7:39 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
>  disable acpi pci hotplug globally for VM

This sounds like a good idea for our needs.

A

