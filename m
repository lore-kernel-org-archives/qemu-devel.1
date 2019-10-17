Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001F7ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C053720872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pmPRWocC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C053720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9RY-0005bW-U3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iL8ob-0008Qd-KA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iL8oZ-0003S6-Cz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:39:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:3090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iL8oZ-0003RX-6W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:39:51 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9HGU1ha025066; Thu, 17 Oct 2019 09:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=bp5DMnv0anlavCrigTezZ4G/B950mX6P/T8viMbFf1A=;
 b=pmPRWocCtpBDaMz+duYhStMfxKgxlOlxIX/geuEnNJGUkZY7iW9zTLJfiu4d/06jcY0X
 MxMr6iCBxkeYJa1AoqXMMzk+dFm/s92fzv2HXUJ3Q24bt1LZJ+Re6FsJmmd8uxDlztDX
 m7YnBazeGRQ3KH3+5Z1SwPr4tDibRWt7S85wDxF1/rJQoH7hYctFP2ge6sBsTCspyii+
 RvL4J5VLSHerVj4esNEWRkwEFiG6jF7elMYxijQ8PF8KGp7OU1YFdQn7XQDhtdogfgJx
 taYI6b3rnqTXV5uzClkOp+vu8W4fe2qPtMRt2U6jhtevUZEcNC1M1ePcB+RfQSaGQZSi CQ== 
Received: from nam01-by2-obe.outbound.protection.outlook.com
 (mail-by2nam01lp2052.outbound.protection.outlook.com [104.47.34.52])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2vke5ekh88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 09:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQJZMIIvdcHUKE9M5fB1PCHBuCURw+eoJ9fzWIencpmsGrLdOM4jJNyXPjp4D9KeU0KBgEcC0CLLnJMY4b21HUsg4jeiMMNi2YjpmAOjfV/Ve/ZsnIeWaFY175ta+s02RpRkVQ/uBwDTnuswoCSBUdZmSVT/AX1tRMzN6XAMoquXJH7aglZ4m8WyVsnrpW3xhxNaGeoFSmxbqCNApVIXnc/7WBXS1ij20MtTinQZ3wc+pWPjTpbB7Ks/XhuL6OznwLLqgNELKYCw+WUSqJHoZO4AT+COPR7j2ruIdmSeqVraZhzuUdCUE9txGGVxVPiVhFaaIRjy8RGqaB8QMgGqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp5DMnv0anlavCrigTezZ4G/B950mX6P/T8viMbFf1A=;
 b=RdePpKPLK/ZwqesK3S7HcodfpXT91IJ/TxBbSZ0c1miWpAS0Yy/FIDnEPBa3DpHnwHxHhe/NNAeo7tq7R9MZmoHnKpuoU3olIgHjw6sGaMPe4InK/ufInm3JKnGgOXwrHBkvIVRpPKPxeUEfd7O5sxXgm+8qMN9opB0lZ7wYdmiOkcCOFqoUY/2SPv4S0xzgzECYKQwnyvXuzUxguH9bXd2L5gjAdTAnax8sNcqz2TO5o7j278rpblrzudUYSFVhAV5uFlG6YUaKtvEdvCKEIO8iGJq5zc61LVdj8WsnWtsTnf0t7obMGB65c1Y7eglbvPLByMbVNx2cdwPJBd5ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2797.namprd02.prod.outlook.com (10.175.49.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 16:39:44 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::7ca0:95fd:4b35:3435]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::7ca0:95fd:4b35:3435%6]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 16:39:44 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH] vhost-user-scsi: implement handle_output
Thread-Topic: [PATCH] vhost-user-scsi: implement handle_output
Thread-Index: AQHVhQl71p+KRszYckq7k3pyTpDK5Q==
Date: Thu, 17 Oct 2019 16:39:44 +0000
Message-ID: <20191017163859.23184-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc49d3d8-cc3b-4c0c-143b-08d753209d60
x-ms-traffictypediagnostic: MWHPR02MB2797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2797F469091A67A5CC1E6D61D76D0@MWHPR02MB2797.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(376002)(366004)(346002)(136003)(199004)(189003)(2906002)(8936002)(25786009)(305945005)(110136005)(7736002)(478600001)(99286004)(6486002)(6436002)(6116002)(3846002)(81156014)(81166006)(316002)(6512007)(66556008)(8676002)(66446008)(64756008)(66476007)(66946007)(50226002)(14454004)(14444005)(486006)(256004)(86362001)(2616005)(476003)(1076003)(4326008)(66066001)(6506007)(386003)(5660300002)(52116002)(71200400001)(71190400001)(7049001)(36756003)(186003)(26005)(102836004)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2797;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFLljhRSvh8cebUr/dB+LgFspCk/HD2LVHsicasUnWveol2SZRvNvecfKz8Gir1fNy3ixNM2LgX0f7GqgootQxKVpWDiFRv0aBQP00sjUgPWG4wAKQzH/qU/BfDyCzjDLmcBJpm1AxY0jxSAaE3ysAw9hPQTUZV5t7/feYTHME/rUnjJjpLJz2hXgyeVfpRx0vNfIJQcqnrhUwmdQNeWfOcO3EIPwMy6rm8qleECCqvRPuW06ec8o1RiCFw6EBcyWJ95R+VQH6eYHgqe4qkhQyumLehOaIYnHsm/YPRKS1dx7TwH5Ed2KS7cg8uWzdDcgEEwlT6QKWJUrfSs1YEjoyO1GPRodQo41OkZVVQVRrJSbgLDJkUCqTLGWcoZLF38YJ81DzwOYuWeot7M9mVhVEun+rnOeEOkKCfDZOZDa3I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc49d3d8-cc3b-4c0c-143b-08d753209d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 16:39:44.3871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZjZg3Hjj53PgOsslrLy3JEepsGvXi2RYG9ssRrJBORKNPEUJ8/BFRXW1AWgwcmV9s21elhTf9cV/agcMmVwGel+hWubO0eiiJLQ87ZY/Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2797
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T3JpZ2luYWxseSwgdmhvc3QtdXNlci1zY3NpIGRpZCBub3QgaW1wbGVtZW50IGEgaGFuZGxlX291
dHB1dCBjYWxsYmFjaw0KYXMgdGhhdCBkaWRuJ3Qgc2VlbSBuZWNlc3NhcnkuIFR1cm5zIG91dCBp
dCBpcy4NCg0KRGVwZW5kaW5nIG9uIHdoaWNoIG90aGVyIGRldmljZXMgYXJlIHByZXNlbnRlZCB0
byBhIFZNLCBTZWFCSU9TIG1heQ0KZGVjaWRlIHRvIG1hcCB2aG9zdC11c2VyLXNjc2kgZGV2aWNl
cyBvbiB0aGUgNjQtYml0IHJhbmdlIG9mIHRoZSBhZGRyZXNzDQpzcGFjZS4gQXMgYSByZXN1bHQs
IFNlYUJJT1Mgd2lsbCBraWNrIFZRcyB2aWEgdGhlIGNvbmZpZyBzcGFjZS4gVGhvc2UNCmxhbmQg
b24gUWVtdSAobm90IHRoZSB2aG9zdCBiYWNrZW5kKSBhbmQgYXJlIG1pc3NlZCwgY2F1c2luZyB0
aGUgVk0gbm90DQp0byBib290LiBUaGlzIGZpeGVzIHRoZSBpc3N1ZSBieSBnZXR0aW5nIFFlbXUg
dG8gcG9zdCB0aGUgbm90aWZpY2F0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgRnJhbmNp
b3NpIDxmZWxpcGVAbnV0YW5peC5jb20+DQotLS0NCiBody9zY3NpL3Zob3N0LXVzZXItc2NzaS5j
IHwgOSArKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYyBiL2h3L3Nj
c2kvdmhvc3QtdXNlci1zY3NpLmMNCmluZGV4IDZhNmMxNWRkMzIuLjEzMjc4ZWQxNTEgMTAwNjQ0
DQotLS0gYS9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jDQorKysgYi9ody9zY3NpL3Zob3N0LXVz
ZXItc2NzaS5jDQpAQCAtNjIsOCArNjIsOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX3Njc2lf
c2V0X3N0YXR1cyhWaXJ0SU9EZXZpY2UgKnZkZXYsIHVpbnQ4X3Qgc3RhdHVzKQ0KICAgICB9DQog
fQ0KIA0KLXN0YXRpYyB2b2lkIHZob3N0X2R1bW15X2hhbmRsZV9vdXRwdXQoVmlydElPRGV2aWNl
ICp2ZGV2LCBWaXJ0UXVldWUgKnZxKQ0KK3N0YXRpYyB2b2lkIHZob3N0X2hhbmRsZV9vdXRwdXQo
VmlydElPRGV2aWNlICp2ZGV2LCBWaXJ0UXVldWUgKnZxKQ0KIHsNCisgICAgZXZlbnRfbm90aWZp
ZXJfc2V0KHZpcnRpb19xdWV1ZV9nZXRfaG9zdF9ub3RpZmllcih2cSkpOw0KIH0NCiANCiBzdGF0
aWMgdm9pZCB2aG9zdF91c2VyX3Njc2lfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAq
KmVycnApDQpAQCAtODAsOSArODEsOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX3Njc2lfcmVh
bGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogICAgICAgICByZXR1cm47DQog
ICAgIH0NCiANCi0gICAgdmlydGlvX3Njc2lfY29tbW9uX3JlYWxpemUoZGV2LCB2aG9zdF9kdW1t
eV9oYW5kbGVfb3V0cHV0LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF9k
dW1teV9oYW5kbGVfb3V0cHV0LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aG9z
dF9kdW1teV9oYW5kbGVfb3V0cHV0LCAmZXJyKTsNCisgICAgdmlydGlvX3Njc2lfY29tbW9uX3Jl
YWxpemUoZGV2LCB2aG9zdF9oYW5kbGVfb3V0cHV0LA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2aG9zdF9oYW5kbGVfb3V0cHV0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2aG9zdF9oYW5kbGVfb3V0cHV0LCAmZXJyKTsNCiAgICAgaWYgKGVyciAhPSBOVUxMKSB7
DQogICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsNCiAgICAgICAgIHJldHVybjsN
Ci0tIA0KMi4yMC4xDQoNCg==

