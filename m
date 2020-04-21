Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69080C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D5A20679
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ps3u7P+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQuAX-0002Uo-2l
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 10:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQu9B-0001Rm-5Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQu99-0007RY-Es
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:45:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:5160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jQu98-0007Pt-A7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:45:11 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03LEgYau017646; Tue, 21 Apr 2020 07:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=WtCLQJm3mWSmRwl+gzDArmbL13MilwMoWvyt7V97hQk=;
 b=Ps3u7P+7XvVkm1z7ggkJswzsQFANZRoTg9SXOk3sPA0D1wJa3nC38b90VUX8tS/nTbuK
 noAxyoNsyieajgiHwx4jxVBM+dALvAU5XfUJFDNk2YUpH0+vEwN4rt0eij8Cfe5W8i+e
 diAGH35bA2PDIV0rRVjL5KiPV+Oz2zPm29Fn/XMQPowQ4ZVeKAs2pJbpf383Y1QkVWQn
 ik7hjFq3K/u7/tqP5xH5QJdo2hMAqsEJkg42T1gDipsBlFW2E9BLdL3kykA1ELc6WNVF
 Zrcn69R3CVpl/H7g01ZQc3vp2j3zSCW2parh/7zz59A7WbCuMOs7w644tf2PSeph3JEz YQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30fwf8xfkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2020 07:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/mwiNN3LMI4GzQhnR8LH+zks/PC8u5OOryZUaVx1qPp51QPzViLFkbQaUOsSpCeY9T0y1slL6to8ZU9gKh2uSSDH/7nzV1RzKtBkd5hDSm4aqVXOCKlVqXbsTLvjpskfmlwIRu+pvR4Q3m5AbAgXN5C8Ycf1rMyOHpxYIrWCfckcxT7mWFGyOsN0hukm2vlinIA+IvDjeGJFgTlLwsuig9rm/ukSX2aO+7BfEJWfEfo46Mx0KzsPvrMAEJjfVDoAOXksDEWlMRAnXljtz5a12jxPI1vmLJzwm1PLkfq+ceMgNth2fi6zoRMYEFZqhiDoTGaka5llzZzskcW8Ze9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtCLQJm3mWSmRwl+gzDArmbL13MilwMoWvyt7V97hQk=;
 b=SwLvH3f5qmx2dzyBtinaMJiRPH2HfDcFnfMxO+10b2p6+Lcl3ebszxjHf7bWKVm1XIyibE0MxId/H8CC+Vo8WfIuVM8rGaVMOJzXlC3e7XCPBkk+V/ezidfa8F+5AyTwIIdOCRliKu01qbpL3IyB8y1MtNcBUXgR0wvOpDvoRnkabn0j6Qjy4wdYQJ2ORzy9MXqIP8kSRUovjvwYwouUJLhEXxF7NZrxx2c73d9C6fcYesoXyV9zlTs+t+m02d5XSCbzUuVSmjYYVh0jQVz7dJ6J+tNjkZbYxB7RWqkhEReKmvlNyKyorYM4eM8U8INmjuyMGIWWMqDWxyBgelrNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6640.namprd02.prod.outlook.com (2603:10b6:208:1d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 14:45:04 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 14:45:04 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAERh2AgABeQwCAAY19AA==
Date: Tue, 21 Apr 2020 14:45:04 +0000
Message-ID: <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200420105936-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3baadbf-9bb3-4914-9cb8-08d7e60293f2
x-ms-traffictypediagnostic: MN2PR02MB6640:
x-microsoft-antispam-prvs: <MN2PR02MB664077C17C580949120B8645F1D50@MN2PR02MB6640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(39860400002)(396003)(376002)(346002)(366004)(6916009)(66946007)(2616005)(81156014)(8676002)(478600001)(4326008)(2906002)(53546011)(26005)(71200400001)(8936002)(44832011)(54906003)(6506007)(186003)(86362001)(316002)(6512007)(33656002)(76116006)(66476007)(64756008)(66446008)(6486002)(66556008)(91956017)(5660300002)(36756003)(558084003);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 591lkB/h85eLEOLY8I84+rEBf//drNdgNw3lQaxlxm2pNQMcW0cx0f3AMY+ig23GDW2rA2Y8M9DOI5QF2uiir/Gq8FXUZMOO8WU4VOvRzAA7w9OjPV3qBU5Z4fhrW+ggclStwOM4Gk3agFyioA7aAB4fWUE7gLGWli2xcEOpnajV3mqB/Btx0VAONdBNPk6fcxRsHA5bZzgcPpykOUgUtrrbUytXpEy/mocfwIb3C4nWQdHWlU3lGzBhkHlcbim6vP9cxFtj4A6yGMIwjTouoNu7ZBdf7JqnQdXNndlisUnIzXDHPa6k++BlGDDbKlZg73QGPpwpMj1QM3XzWiAwObG6dECFciBfMjeS2g5kDhpYpC+WF9iUp1QjBrBJCMdLsgtV0SYqq/XzE3+xxfGM8BwE0D+m6GwwpW2/b6EcFMsV/W/poEYZDS0sTwb2+/CO
x-ms-exchange-antispam-messagedata: XZPyPtVZR3yJscyRFvX3lvRfc/YM3PkFHSygSrR6+aiMpgBQ+CicM0GNFA1fuRYpss/RfBZA70aX9RYWKXn6QLlHzKD3wP2N5jnzt7c6AqrXIZpidUZ6NEPOsBnauyagrbLHAw/tLtAJAqwAWH0oPA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <66ED181E7F638A49922349EE1707E1E6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3baadbf-9bb3-4914-9cb8-08d7e60293f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 14:45:04.1958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jEw8tHga6pZ24hRsS7jTLI/K0mseCTO9GOIdIRHoXm62CmBbWTmhy81QJ3Hpfl9HtmJuQChRD7na/3HxIwkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-21_05:2020-04-20,
 2020-04-21 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 10:45:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.151.68
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
Cc: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 20, 2020, at 8:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> But I for one would like to focus on keeping PIIX stable
> and focus development on q35.  Not bloating PIIX with lots of new
> features is IMHO a good way to do that.

Does this mean this patch is a no-go then? :(

