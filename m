Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89824C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1C3206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bs8jbPec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1C3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXzF-0001DA-E5
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55032 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQXyI-0000Fi-Aq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:04:32 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQXyG-0006T2-1w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:04:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:8416)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jQXyD-0006Rl-WA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:04:27 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03KF0O3U004050; Mon, 20 Apr 2020 08:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=X8Q/e6U7heH0+QHb3W5R+QbuqWepOleiV2MS7Lv3ySk=;
 b=bs8jbPecfOdUxKv8MFULcAWzCcoH6xdwAcpL2yQISUIoDRtos4W3gSInTJMu+JLcHUM1
 /C1+m5Exv3f9GN0Nsu6+9srKy9Hms41S3Lyei7C8n2Xaaf9tQVIlRCs88uwS3HvD0Wc4
 u0f6QQ7abYbHS/RRwqGG8mKjr9POGawsHoaVAdxdEmZctDXw73INjGa01zKqQKnWtlBb
 U0FWwayiVWZlRMbDJ+tP6XT+8TgdlHoRni81HniybLRzX5z1k6nXSG/goGJL2C2fbApH
 o0B9OozCn09FN9pyuyb2vvXKMl61TPcf0aQ5nDrxpa0d8d2ZPoK7xWFGbUDBV1cCOpfV Qg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30fy39uruc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 08:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeKWOcWv8j8rPlUh1WoaePgSFDzOlVpG787wI5U4uku7269ws9LxTClS3nETlBsFaXt0uoWgM0MYiLn8P+Q/aYwya5D0EVrupPi9QhABCXP5VWm55hBMs34LL84Opf0iBOSVEJR7T6MzCadPharzuObCIleukKoGg2VxkgiERRFP5YBx0G9kUztzL0DGwx9z1vZEk3cFFGYAqy+mi9zhxvut80gNAsCba1mnXIj7+t+rni5YRYc1UvwDlHmmrqBbI1Wb06vjhEKJXw0d7r0EsFaHBA/FN7AQtMh1tPJpxz2qJMvWYU3KibMr+dIW3uptkvUd++HUDAO6knGHTJdyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8Q/e6U7heH0+QHb3W5R+QbuqWepOleiV2MS7Lv3ySk=;
 b=MlD7+tEIaZhv6jZ8mrjib59CNfwq+2TqH4JudLAzOe5gD0RkuqoU+mo73oDTccsYuERL2w3UoKDHfTxng29AGwmC+mqUvYECU/Typ9jHMMQTTubNkE8LYvRIZQdAtV27Oia28RQIBifdkATWFJes8KW10YAprX8vdrq/Hx+/GqZOBg+py24BwbsOjcBKELIE2FxKMl4/0CGVv6zowomd4km/5MAwFpv9JUjyMm7y0iduSCBxWVIl0EZNngoaLzFcYOPvhZoURTcTKs4skLJgz2xURXRwLXx608HWz8VKdtwejKYoCk8nAgUkaafVJ2vtCF4rrSGfeOXvGLqj9dzT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5904.namprd02.prod.outlook.com (2603:10b6:208:113::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:04:20 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:04:19 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAAB0KAgABZuwCAAFwZAIAAnSIAgANKsgA=
Date: Mon, 20 Apr 2020 15:04:19 +0000
Message-ID: <24B1F6CD-14DD-4F28-9406-453D19CCAFCF@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
 <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
 <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
 <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
In-Reply-To: <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cfef58c-0902-4a21-f33a-08d7e53c1a4d
x-ms-traffictypediagnostic: MN2PR02MB5904:
x-microsoft-antispam-prvs: <MN2PR02MB59043B436305F1D573F1C583F1D40@MN2PR02MB5904.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(71200400001)(558084003)(2906002)(81156014)(8676002)(8936002)(44832011)(66946007)(33656002)(76116006)(26005)(53546011)(6506007)(66476007)(66556008)(64756008)(5660300002)(66446008)(2616005)(4326008)(6486002)(91956017)(6916009)(36756003)(6512007)(86362001)(7416002)(54906003)(186003)(316002)(478600001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BlIJHaHQVmY81R2vyKftFMRTyzRUphc0jZTN2+sM8GZdVK/X4YTuceNzQHJNucYx6prIF/bteNUakfFPYsiPknJ4zMW+RUiiT0X0YHVjLzXvWqzO9obhEhcaXT0xmBmxnnOLMS3v8T/lTE44SC2dNGBH2nxC1/YrZHPZ//zjOd5qGvrOPgNA2WkuFjL8HlYEUnl5gaHqjTnj+/N361X2DNurbqwbJIxOW2uLb7RxzzLL1KH8NH0+bgPQEVUlbtFar2s1R1uWJ/t2ImCd3qmyngRyGzOOO3z5XCdGtlgv/6RnJ+7U/IvBuZ+41w9EcO3XnjHmT9JP3CqNnNb391P2isPLNBfJR3d8OgEHbTTv+/79JMkM0r3RWhoLPWYd20TZhQ+nZRtpYYq7g+KqLAA+OykfyscKb6Y1iyAVDmSn7L1CPdUVbAZd6aiNR20+nOS
x-ms-exchange-antispam-messagedata: LF4/FL0yLFsHVi3xzRQ7Od6+cRwStpAaXqSERMFU5bmdU8pAZ6AIqLbzfiIYlgNU0JmDWENXEFOW7kSD54njd3WyMEiYPAlLnHGmJ8k8cnYOgJ0+9iNzXMcQnGyZ7HJV9sPfbHTIVbOlAME+RfJoOg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E799C1FF95FCEA43AB99F1A4DEDFC172@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfef58c-0902-4a21-f33a-08d7e53c1a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 15:04:19.4841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ocyZWeZ4eQes9FnAI9LP1L5vneZau8iGumq8Dlc17HH+2oJqQdduvhUzWk2otG4qPL/3Sv9xobluszopozIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5904
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_05:2020-04-20,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:04:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 18, 2020, at 6:18 PM, Marcel Apfelbaum <marcel.apfelbaum@gmail.com=
> wrote:
>=20
> A PCIe Root Port or a PCI slot can or cannot support hot-plugging. Anythi=
ng in the middle can't be done at PCIe/PCI level (as far as I know).

Is it possible to dynamically set PCI_EXP_SLTCAP_HPC for a slot at runtime?=

