Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B9C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7608320870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LUEIlv24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7608320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGi5F-00059L-M1
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jGi4I-00041Q-8q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jGi4D-0004IR-9O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:50:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:50100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jGi4C-0004ID-ND
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:49:57 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OBlrfl002224; Tue, 24 Mar 2020 04:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Cmv8rmaA20AaWfBIc2vPNvz68g+Yrqwg5wT4TOsVPNg=;
 b=LUEIlv24Pk2+aiLKoUbytFzTZwfCubGqCf5YhnglmPiVdmGTvwDR1gNqjxPXpK96ENhM
 scqnCgyuHN1GJdnjtmE7GR0Vjl18LbI7PLf59YloszMa8ZI+hkoTTAmKih93894fAQ8M
 SI7DY1K673J6U4MyS8UwM48sFpLDc/oIoHems1Vf8YOyYjv2GIQvw9XIFGi9YB1skO3b
 lqln7bgPf8b2OA/2aQi2mFrw35czjfD200BzKXYjuFQ4ikNCXbIz2CNonNGT3Yv6LSUQ
 HZPwQQNc4pDd8RLYRR+pUFLO4nwZJ0Bmiqi3uXrDVlB41e+lI/1oz15vs0NhqHL6ToRC eg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2ywjg0njmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2020 04:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBHr1ClaGkFwSbWl/Oo/HpsjuxCyOveGXgM0lO1LVvCrnTEZVXl6BPhhfr4n/k4k2H1fiyFOkHNP7mbulYqxun4xRmUZ6amD+t0YJZMRcWAR5AHgfwBiDK57rgmNJUcOBZitOGNTZn38xqXUh2GOsqe1SkmZnjrfU8hWbv5CKya2Ck0gocOrqkJhgSQYy5Y0Qg6sX2suT8eYPwkybTsjEoChhGFoQfAzPdppxfdUb4vNNzaZ/YmESYZhyDj8Ly4+SmphmDeDq9zg1rztcAQWfr2MHeQLQUL8ao7nW25OOTnaiRYOTHAgBjr05aQasx84zhxyGFSIifL5n4uxGJxmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmv8rmaA20AaWfBIc2vPNvz68g+Yrqwg5wT4TOsVPNg=;
 b=M7aaljfaATMUXcRBvrRQ7L6kmY31mDOfbZdDm5Lt0NmkmaYgCv3yhY09K4T/wJSQnP7/yXSX/6okUD3O/v7vg5g0wgwR5NIFBp7wHpRr0733Ed0zv5XLXJJsfsUe2WOEMZdiI75/siAsVAsdicuVLssK9RUbBPGvfIO5PNF+xMDVXC2jYaRCsMNY6V6XibFHqo66dwR5+tFuGk8o3JLHUKmVotJVZGgaScwICew6qROBzl5Zf/sFHZUrwQIrFp3M4U78GgIF9C2iepdN874GicCSyaE4jfQ4B+zciSOkJUZUmIvQhqGFzMH9sWT8nr7lgyyYpi4G3HunCqTdN/3CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5805.namprd02.prod.outlook.com (2603:10b6:208:117::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 11:49:53 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 11:49:53 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Hot unplug disabling on pci-pci bridge
Thread-Topic: Hot unplug disabling on pci-pci bridge
Thread-Index: AQHWAcPYtZw/rt1SL0WZPWjOTF64NqhXlY8AgAALkIA=
Date: Tue, 24 Mar 2020 11:49:53 +0000
Message-ID: <95F47446-8E5E-4CF1-A076-24D714F7A827@nutanix.com>
References: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
 <20200324120828.2b50d41e@redhat.com>
In-Reply-To: <20200324120828.2b50d41e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cdb26e5-694c-4a4c-a5ad-08d7cfe9774f
x-ms-traffictypediagnostic: MN2PR02MB5805:
x-microsoft-antispam-prvs: <MN2PR02MB580585BFE20E7482B6C72A6FF1F10@MN2PR02MB5805.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(396003)(366004)(376002)(136003)(6486002)(54906003)(66446008)(6506007)(53546011)(6512007)(558084003)(316002)(5660300002)(66476007)(6916009)(478600001)(4326008)(66946007)(76116006)(66556008)(8936002)(86362001)(44832011)(81166006)(2616005)(64756008)(81156014)(8676002)(71200400001)(36756003)(33656002)(186003)(26005)(2906002)(91956017);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB5805;
 H:MN2PR02MB5742.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MfVaTSmmpQDhA3w7tSyQnw9z2MjUVVDAdI4YazDY6mDpWSXyxKuG5P/mugKDQJR8UUHPV/US2N7gTcpB/NVxIV9mIo2sU1dHuPgfUSOXInUKJ7mX/rG1ZmnEDq5AGmO2TBiV3CPSoi8pcMYB8PJomeOGgUk8m8BxO3R2QX1FVG4MmFlvZ2hrEvMD6jzO2uYgsNM+yoIE0yCCQDCmtKzugz+Wd0b92mQeQWEKt4S1vePuxxD0elfgpjruAeJM+TJGKUD8wJ3xxWbOkzi2ICKmSHVQ/TQ27XICUkgaMm57rGEs1hxBjhD88igrI1b3UBwsIvukFAjVSPLlzLLVgHY+daAwDsjrKn8tfAvNzHbqD8maXp+kw+Vch+GD6yXnXHrreqoqPW76cBVA0gaWxwVuooUBnzCRO6loQ4e4r368LQQxusQGVn90x0xDcbfZwq+s
x-ms-exchange-antispam-messagedata: UEAdb2BFB7H/RdRSebdL/AyaCzGzkAbs6TLxOoli7Q263hfateZ7TGrcp8WqTXTXJxw+2sOEOnzbP2ouVuP9x3hpd39YPCZh/OJVQu6wo6+OTsiHbDONcKvASkWY07DG+TLwRxTT3BZ+wgtLOSTasQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0758D0C485E6934596B9D8D97EDE9F5B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdb26e5-694c-4a4c-a5ad-08d7cfe9774f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 11:49:53.0603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y70+aIE/35MQ83r56fmTrlDPRUrrxMWJ1mnq8bIMYcCxxMEQacmxPs9CuT/SFKF4QwwxTMIep++05PCdf/5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5805
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_05:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Mar 24, 2020, at 4:38 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> question is do you need to disable only unplug side both
> (plug+unplug) operations (like we did with PCIE)?

I need to disable the unplug side only.

Ani


