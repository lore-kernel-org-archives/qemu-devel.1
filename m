Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A0EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF0420578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="WffgzZvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF0420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmNJ-00085G-36
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jHmMX-0007Zy-7w
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jHmMV-0003E9-DT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:37:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:14538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jHmMU-00039T-V4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:37:15 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02RAZ251003773; Fri, 27 Mar 2020 03:37:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=KXOKN5uNUwzr9xyRwFiusm3eEaY7AnJDLZB81G/YMf8=;
 b=WffgzZvgV0SJdZqSZ84+BlLvqgMHL0hVBbrUcBQL73gbRFQAYiPLxStUX7xxQNZVi2MF
 BaSgIEqXW/BeHvK9yEtSKMwr8vl5dzQCk1eAP3c64+ZEWyNod5rOUH6DcfekaN5Rgyqa
 3cl8HbJeu/GwxL0gpLO91x0tZMAd1IHe5wcEZl9TCFHkhDzgXifHEhB/GkhJ8Ff3r0OI
 0gNY+0u7nviCMCx0vNcLNQxYAeAI4B9iVYAm/dtwgACRdQAM+Ceg09AUgzU/EuTE03cj
 4Tvcd3mnHNHq5hI5zk7YLTOvy/fdu1x559KvhES7ZFcqL3/TXeWTmZOJ4KkEPQCBiybe rQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ywgfan1gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2020 03:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QryD3E8ZVN0RzzrDBKwfpednA0c/+Ass95P30d3KrcBa5hqwDeMIKv7nZ7x5wmsQFXm3kuB3Wuxdo9OZKOdKOnD5JG0f9NrnORWPnt6IOdViBI6t968IQWNa/jkiinZag0tDdoKLvGpIlG0NKClMO6+u2OzxCrQpolrwUL5vciQmjV9ShLcOBddWra5O8VqVUnr1jvKOS+gvh42L1zYDktxG2NZNR4m4vbpS/mQ6icMrLYwm3KnHVnYg6YFbLtXesi3j7HuL7tLqQr7iIS+Qb+dukvPHsgLy8uO0lt18aNoXQRO3GU9Ta+Mp/ln1xtjlU8ST1/iRxWKPWnSCziWJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOKN5uNUwzr9xyRwFiusm3eEaY7AnJDLZB81G/YMf8=;
 b=b6KOW61wKQAPpvagH09MuppXDhNCrb4tYFLC1VTcuaYm14BlfU9fyf/SAP2O0qkpe3DihlZ6+hJ0TVOOHKh5YIV3mB7Id1qTgHo04Hjp9F26uxl9IEnAG7Y4ENKlQIjP2XTe43ewiV9vrPAC9ZBwHQYssoc5ssju8JdjBc3RH7sb6KVUus8irZyCWmmdiku1fXVsgZ75GgEgQueEtc8YM2HwVaXS8pkxSegH5/W5qyEsLp0HvNAfZ/TBxLxZ6fMoWQ+bnREew29XIOVEgLMKEDFZohn27QaD4AQbAfMWzzAfKi+0vsMZIbCrcPM0n3xc5/BIk3OcdP/fgANjxwECww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (2603:10b6:208:1bf::17)
 by MN2PR02MB5951.namprd02.prod.outlook.com (2603:10b6:208:10e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 10:37:08 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 10:37:07 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QAzutvw
Date: Fri, 27 Mar 2020 10:37:07 +0000
Message-ID: <MN2PR02MB6205CD604052BD7DCBF10A308BCC0@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f021023-a529-4506-e2e0-08d7d23acc91
x-ms-traffictypediagnostic: MN2PR02MB5951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB5951537E39F02D65ECD2BA108BCC0@MN2PR02MB5951.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(39860400002)(136003)(396003)(346002)(376002)(9686003)(52536014)(5660300002)(81166006)(55016002)(66946007)(76116006)(33656002)(6506007)(66446008)(110136005)(478600001)(66556008)(8936002)(54906003)(66476007)(64756008)(316002)(7696005)(86362001)(71200400001)(26005)(4326008)(2906002)(81156014)(7416002)(44832011)(186003)(4744005)(8676002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRlC4X+/XslDzZgymXEoSrlQ05mW7lSCF1LnufO+CBa6vflw5w61iXmE+KRBbqKMJy241mwTWqf0g8f1x0TXRNRTjs6u+67+/Aqi+xA11dfAAKt++P7CL2Ipeo3DVs2wGmlCSSnLu1y3WFtZDZCn9vG5KkoJq3ApGDUsdgdj/HNXgRh4wC2s7G1KullYOO89XVvntluQqIta7b+urXqQz/ITbruYZYyzSztJqeeaNOQkU76XFJ2mV+iPeOlSICWC6kYWWFyQrdcVCmwOCByfSLSzmpKd1CQBlNOHj72ErFWDCKlUWHyZNTLbBElv/9ekbt6Yfhlu/+YxXqIRGMbLzg9+19GnIphcLsy+mPxjQ+Co8bDtef7ofwJKpi6yEEkxUQXZEDqyndJ1bxv5frxX0fDk8FuwaTOYXk5UKaB9qGgFuDJmKXU9ZFK9dVQ5ITue
x-ms-exchange-antispam-messagedata: 8OQjRBX2koAKi5WaRcFm+zpTGSIL3BtTG9b65zeomI/sx812R1and5XmHBGKp0PTmxvR7q4ZCuordiaTnY1PimRLxkNS9+4yrbXVn2+jq3jOiFckmfXy+TBCC9BkkBoIYVi6LpI+4AaiiQ9b+C82mA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f021023-a529-4506-e2e0-08d7d23acc91
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 10:37:07.7623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hHaYqIo07xAwwUJEhW/HB7uG2EixDPAQ7qDhdb/UuyN5HXskaViuZEsYCXaSsQbXct0zFVEMuvoQeLph6wgyDeOh7ps9fx9wWrTWOOXqK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-27_03:2020-03-27,
 2020-03-27 signatures=0
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, 
 James R" <james.r.harris@intel.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "Zhang, Tina" <tina.zhang@intel.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> =20
> Next I explain how to test the PoC.
>=20
> Build MUSER with vfio-over-socket:
>=20
>         git clone --single-branch --branch vfio-over-socket
> git@github.com:tmakatos/muser.git
>         cd muser/
>         git submodule update --init
>         make

Yesterday's version had a bug where it didn't build if you didn't have an e=
xisting libmuser installation, I pushed a patch to fix that.

