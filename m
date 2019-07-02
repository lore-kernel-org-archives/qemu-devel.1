Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB8C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572A1218DA
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gIXRC44Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572A1218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQyy-0003u9-HG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 18:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1hiQxf-0003SN-52
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1hiQxd-0006ho-Hp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:09:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:9572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1hiQxd-0006Uw-0b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:09:13 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x62M6TfX028911; Tue, 2 Jul 2019 15:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=VmdmaaGNZAmhSXk/W0Lr/dCjOqFj5WUm8oKiVHu02vQ=;
 b=gIXRC44QqkJoo4MdKh2ezhpW7lYK3X4NKigTvhYystTb7kysMo24BOKaj56zTgghWtTb
 e2w39imyp5KolxOAYLkHeyiXzB3a1o92XMryynWKghUkShuvw6R6LBtHjQqdZXSJevB0
 s4xlxLE2QkaqWt/YXflLJFxchXy4+xqXx4gk7sr5tt1UI/nEKNAuNIFp0vg6/xIK0ldJ
 KY2wRIihBR8iZzZEhNZ/OUuMRP/TdEnBBuIaapjwcTowjU65L/30cv/1qT0NzpBEzNjY
 mBr5whfaFEDQSk0CncAWHWTk8aVRk/VGtcJMPJx1xo6FyNtxR7tFl3Ni40aOdBAvMKlz fA== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp2055.outbound.protection.outlook.com [104.47.32.55])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2tg8728wqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 02 Jul 2019 15:08:57 -0700
Received: from BYAPR02MB4566.namprd02.prod.outlook.com (52.135.239.205) by
 BYAPR02MB4181.namprd02.prod.outlook.com (20.176.249.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Tue, 2 Jul 2019 22:08:55 +0000
Received: from BYAPR02MB4566.namprd02.prod.outlook.com
 ([fe80::38e0:8f7:9fd4:eb1c]) by BYAPR02MB4566.namprd02.prod.outlook.com
 ([fe80::38e0:8f7:9fd4:eb1c%6]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 22:08:55 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: Should memory hotplug work with vhost-user backends?
Thread-Index: AQHVMSK9HbtiS4IGUUSSY9wOBJ3M0A==
Date: Tue, 2 Jul 2019 22:08:54 +0000
Message-ID: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f5867c2-b00a-4514-f482-08d6ff39dfba
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BYAPR02MB4181; 
x-ms-traffictypediagnostic: BYAPR02MB4181:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <BYAPR02MB41813F0D961F51147DE224F6EAF80@BYAPR02MB4181.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(478600001)(2501003)(2351001)(86362001)(5640700003)(54896002)(8676002)(6916009)(8936002)(25786009)(6306002)(81166006)(14444005)(71190400001)(81156014)(6512007)(6436002)(256004)(6486002)(71200400001)(53936002)(68736007)(6506007)(102836004)(14454004)(2616005)(316002)(476003)(107886003)(33656002)(26005)(186003)(99286004)(486006)(44832011)(966005)(36756003)(5660300002)(54906003)(73956011)(91956017)(66066001)(76116006)(66476007)(66446008)(64756008)(66946007)(2906002)(4326008)(3846002)(6116002)(7736002)(66556008)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4181;
 H:BYAPR02MB4566.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6thdeBlVKGbKwOiEHtj6kTGv8rxjlja8KqKZ6WJkk0QN8UdAnrXXe4+/aYxteUNDwh0xmu9xSGF05Q0oZhLvzGJdT0CXXQrLhBQ0ILiGZC1eeJdvr0onPJyivW+l47inKlbBzJooeLIc7rxoSJ5V3Y0ws8iSuyQBYITCFkBPeHMx5A1M/sZllAWIegs68XTxpDJIMmnTehioSdCW97OkvqAkUFjo0LFkSLTlyJVXqoiP5z84s1DP8TqF4RPxsjJp5JAXoG8LifjrecZDLzF9GAOpufC20Ll5uVoLPVGE68rbrAsaaE8XCl0+Pz6j+dbBfAFTlYUcJ6EreOtZuefN2QUIciZoj4vQQSn+ZWZ94WdLqRIBKW9CeQbQS05xzTe+b6u5gwafeaaqTZ/l1DhceR08k0u7/j6VqbBUss2KTA=
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5867c2-b00a-4514-f482-08d6ff39dfba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 22:08:54.9295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raphael.norwitz@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4181
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-02_11:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Should memory hotplug work with vhost-user backends?
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
Cc: Mike Cui <cui@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Malcolm Crossley <malcolm@nutanix.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "changchun.ouyang@intel.com" <changchun.ouyang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rm9yIGJhY2tncm91bmQgSSBhbSB0cnlpbmcgdG8gd29yayBhcm91bmQgYSByYW0gc2xvdCBsaW1p
dCBpbXBvc2VkIGJ5IHRoZSB2aG9zdC11c2VyIHByb3RvY29sLiBXZSBhcmUgaGF2aW5nIHRyb3Vi
bGUgcmVjb25jaWxpbmcgdGhlIGNvbW1lbnQgaGVyZTogaHR0cHM6Ly9naXRodWIuY29tL3FlbXUv
cWVtdS9ibG9iL21hc3Rlci9ody92aXJ0aW8vdmhvc3QtdXNlci5jI0wzMzMgIHRoYXQg4oCcRm9y
IG5vbi12cmluZyBzcGVjaWZpYyByZXF1ZXN0cywgbGlrZSBWSE9TVF9VU0VSX1NFVF9NRU1fVEFC
TEUuLCB3ZSBqdXN0IG5lZWQgdG8gc2VuZCBpdCBvbmNlIHRoZSBmaXJzdCB0aW1l4oCdIGFuZCB0
aGUgaGlnaCBsZXZlbCBpbXBsZW1lbnRhdGlvbiBvZiBtZW1vcnkgaG90LWFkZCwgd2hpY2ggY2Fs
bHMgc2V0X21lbV90YWJsZSBldmVyeSB0aW1lIGEgVk0gaG90IGFkZHMgbWVtb3J5Lg0KDQpBIGZl
dyBxdWVzdGlvbnM6DQoxLg0KV2hhdCBleGFjdGx5IGlzIHRoZSBjaGVjayBgaWYgKHZob3N0X3Vz
ZXJfb25lX3RpbWVfcmVxdWVzdChtc2ctPmhkci5yZXF1ZXN0KSAmJiBkZXYtPnZxX2luZGV4ICE9
IDApYCBmb3I/IEluIHRoZSBtZXNzYWdlIGZvciBjb21taXQgYjkzMWJmYmYwNDI5ODNmMzExYjNi
MDk4OTRkODAzMGIyNzU1YTYzOCwgd2hpY2ggaW50cm9kdWNlZCB0aGUgY2hlY2ssIEkgc2VlIGl0
IHNheXMg4oCcbm9uLXZyaW5nIHNwZWNpZmljIG1lc3NhZ2VzWywgd2hpY2ggc2hvdWxkXSBiZSBz
ZW50IG9ubHkgb25jZeKAnSBhbmQgZ2l2ZXMgVkhPU1RfVVNFUl9TRVRfTUVNX1RBQkxFIGFzIGFu
IGV4YW1wbGUgb25lIHN1Y2ggbWVzc2FnZS4gVGhlIGB2aG9zdF91c2VyX29uZV90aW1lX3JlcXVl
c3QoKWAgY2FsbCBjbGVhcmx5IGNoZWNrcyB3aGV0aGVyIHRoaXMgdHlwZSBvZiBtZXNzYWdlIGlz
IHRoZSBraW5kIG9mIG1lc3NhZ2UgaXMgc3VwcG9zZWQgdG8gYmUgc2VudCBvbmNlIG9mIHdoaWNo
IFZIT1NUX1VTRVJfU0VUX01FTV9UQUJMRSBpcyBvbmUuIFdoeSwgdGhlbiwgZG9lcyB0aGlzIGNv
bW1pdCBhZGQgdGhlIGNoZWNrIGlmIGBkZXYtPnZxX2luZGV4ICE9IDBgPyBJdCBzZWVtcyBsaWtl
IHRoZXJlIGlzIGEgbGF0ZW50IGFzc3VtcHRpb24gdGhhdCBhZnRlciB0aGUgZmlyc3QgY2FsbCBk
ZXYtPnZxX2luZGV4IHNob3VsZCBiZSBzZXQgdG8gc29tZSB2YWx1ZSBncmVhdGVyIHRoYW4gb25l
LCBob3dldmVyIGZvciBtYW55IGNhc2VzIHN1Y2ggYXMgdmhvc3QtdXNlci1zY3NpIGRldmljZXMg
d2UgY2FuIHNlZSB0aGlzIGlzIGNsZWFybHkgbm90IHRoZSBjYXNlIGh0dHBzOi8vZ2l0aHViLmNv
bS9xZW11L3FlbXUvYmxvYi9tYXN0ZXIvaHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYyNMOTUuIElz
IHRoaXMgY2hlY2sgdGhlbiDigJhicm9rZW7igJkgZm9yIHN1Y2ggZGV2aWNlcz8NCg0KMi4NCklm
IHRoaXMgY2hlY2sgaXMgaW5kZWVkIGJyb2tlbiBmb3Igc3VjaCBkZXZpY2VzLCBhbmQgc2V0X21l
bV90YWJsZSBjYWxsIGlzIG9ubHkgc3VwcG9zZWQgdG8gYmUgcnVuIG9uY2UgZm9yIHN1Y2ggZGV2
aWNlcywgaXMgdGhlIGFiaWxpdHkgdG8gY2FsbCBpdCBtdWx0aXBsZSB0aW1lcyB0ZWNobmljYWxs
eSBhIGJ1ZyBmb3IgZGV2aWNlcyBzdWNoIGFzIHZob3N0LXVzZXItc2NzY2kgZGV2aWNlcz8gSWYg
c28sIHRoaXMgd291bGQgaW1wbHkgdGhhdCB0aGUgZXhpc3RpbmcgYWJpbGl0eSB0byBob3QgYWRk
IG1lbW9yeSB0byB2aG9zdC11c2VyLXNjc2kgZGV2aWNlcyBpcyBieSBleHRlbnNpb24gdGVjaG5p
Y2FsbHkgYSBidWcvdW5pbnRlbmRlZCBiZWhhdmlvci4gSXMgdGhpcyB0aGUgY2FzZT8NCg0KVGhh
bmtzLA0KUmFwaGFlbA0K
