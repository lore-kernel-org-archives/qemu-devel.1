Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94928C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE912076F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="WtmJvPOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE912076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlTf-0005RH-JY
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jGlSv-0004zt-1K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jGlSt-0008Uu-6E
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:27:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:44274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jGlSs-0008UR-Ha
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:27:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OFLSDb012018; Tue, 24 Mar 2020 08:27:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Zw4EOraz1zTWHbYJ/cR0Odw9AwQonq4Hn2mAC5Oy/+g=;
 b=WtmJvPOjrwUG3fQxjNyS9cZC84uT5Qg6s2bt1g3QtODmqoF3PMJGa/I9ryh01bSX3y6T
 iBmgJTJu2HCY6fXX5febZXd1sufSkF++7Z49G9Yc9ekR7WW9kRYUjoYz4SGbDYpg6NMQ
 BdCX6XLVDDjN49DTVj2PaR6d9/px3JcSQqfeSZzcKdRyxqC5sbqo81CXB31Zq9X7vKcq
 VqX1fM7hFpYIAdq3AyJwYl/6wC1WazP9Fm1Wvnl1PBhKrta8X/EiVnA4zW+76+5kWMhi
 TjdE0kMXi9a2Gt4NPXzIITcRdOcU64uhYsxE6VBGVqD7z8cSAt+6C8/PaWNPHnlBNh0e iQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ywh1gx43c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2020 08:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3SlFEs+X40Lvcd1gmsInY247zOtpoC7Yhvxt0C0tJEo0KbOmULenZVEDtSZ/JvJHbFvY6yJGiQWGdnAf/Hv+ZYlC/PZeVTipYtrcGtxQlq9WWeRnjz3cABP/TLqnP/JYcQMCeyR+5VECyVMD9L0Nn9k7j5sZv107FP3+NEHSvWrd61G1kv+3VQnLO/oKavW71mzaQiNMbGyM9XDLxyTqN9mvnJy10WMr+l1hSD1koMiJzxytaQXL4vA7UCHVN057uhYa9OUm/tGxvZOM1tYMrlMuSfxSStj0yInJ3mzW4lxxeLxkVMuKqjjCg3R3N9QqgP8MeyPx9k5rzp8/kRKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw4EOraz1zTWHbYJ/cR0Odw9AwQonq4Hn2mAC5Oy/+g=;
 b=eAYJUnYRL0/BDBd9ppnrL7ng3YCTKiFYcflMzU7udZ/UhCAxQJ8gdswjWH4Lc3Ze/3ZtXG+qiLlO8u+wV8yTnctBatQYMl7Xtmxe+whJKRsPEtZ/RhM6Q9iPuxZ5rR+J7DJTCxDM8XNGjjk6ryrUGhA/XpYFZ2xLv/Hcmrr5KZstIk3rIeNnS6dueUdZac6kL/rC474TKVGGpmZLLX3YaB6TyUC10JQphe2CsOiap/dYnsz037Ya6H+f5HbNyOcKJo92QWH93SE9RJWDAN/bgMV/RwbJXIavzTLuYzp/CnjGGJM4ugA2mMoSFM0J9aIvdxP3KbQfj5Sd6gCff4Ayxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6591.namprd02.prod.outlook.com (2603:10b6:208:15f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 15:27:36 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:27:36 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Hot unplug disabling on pci-pci bridge
Thread-Topic: Hot unplug disabling on pci-pci bridge
Thread-Index: AQHWAcPYtZw/rt1SL0WZPWjOTF64NqhXl/WAgAAk5wCAAA1iAIAAE7aA
Date: Tue, 24 Mar 2020 15:27:35 +0000
Message-ID: <371316CE-5225-45BE-9ECE-DE5041337BAF@nutanix.com>
References: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
 <20200324121703.472b034b@redhat.com>
 <90435944-E1E5-49AB-A039-ADBEC58EFB0B@nutanix.com>
 <20200324151702.4c2eb79e@redhat.com>
In-Reply-To: <20200324151702.4c2eb79e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4984eed-40cd-4352-a3ac-08d7d007e156
x-ms-traffictypediagnostic: MN2PR02MB6591:
x-microsoft-antispam-prvs: <MN2PR02MB6591644D7FFE78E9EF20FAB7F1F10@MN2PR02MB6591.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(86362001)(6916009)(6486002)(33656002)(26005)(54906003)(2616005)(44832011)(81156014)(81166006)(186003)(8936002)(36756003)(71200400001)(8676002)(91956017)(53546011)(4326008)(76116006)(478600001)(66476007)(5660300002)(66946007)(66446008)(64756008)(2906002)(6506007)(6512007)(66556008)(316002)(558084003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6591;
 H:MN2PR02MB5742.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEeY+wMz/LFT/Yg1dki+kJ0S3X+a/7PJzP5WJ8XnpIseaLT9fRWlc8APAgP/CTuVvDHZj0gqtH+pLO90WxdsGf59Si1OeVUSuV1ptbUVSAnHqZWfsDjuNV4P3BxGUarxpE6Tze90FqhU3ilzU2rRg/3pRkzPPa6T4hswe/4gcKCOASpoTj9CxHHvGPuwFxw9SREkOPrIew/gcu/x5SuK449LkjtxqDHhsxuh1I5H2OWkAGe1KGBxKldnMOGbwPaSJZSGXdC63ON6ANzYI+kS/nR2YTfF2pxk3MStfrB2EQnck/KAd6dTeFdbSrd9iNuCdZRvNQ8OJb16n+HVt75CABRvUwi/LoPfL9GQiL7ox/sESbPlVhryTwsxG1yyiXX7DvQ4JtTIDKMLFUY3aQSRw81WWZRMc7EDyunwmgO3B1HGtNrxGTgLByhm14GzFwte
x-ms-exchange-antispam-messagedata: 7SOxdbQHCTgU//K8+8uWXiqMU8YLEHpqRcgU/Ew3hibaows8a27y6ruoycnZBcrPuZJBUjvIlDZm5iBgLgaywJXTKKxKupx7utYjkQJ8M/hESGxe9UWhgSKcovAIiQgi9WLwmNlJhIbO1badn2fhwQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B96DFED14083EB4180AB6E8BB2D799CE@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4984eed-40cd-4352-a3ac-08d7d007e156
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:27:35.8735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42TSVo0CsWKoqq1/8JwIDF7UlQ+S2jpxndy8BUNaXXVaus4sjt9q+4x7Tw6TrnTuuWJIRY1eM0dM4vLO9nwXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6591
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Mar 24, 2020, at 7:47 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> if you are interested in hacking ACPI PCI hotplug more, look at how build=
_append_pci_bus_devices() works

Cool. Will keep digging while stuck at home :-)

A=

