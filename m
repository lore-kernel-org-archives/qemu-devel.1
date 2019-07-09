Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A178CC73C5C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 21:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C2420844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 21:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="nPw2Ld9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hky6k-0002PF-Lz
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 17:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1hky44-0000dQ-93
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1hky42-0007mJ-9N
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:54:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:43424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1hky41-0007dp-Kz
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:54:18 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x69LmAas011945; Tue, 9 Jul 2019 14:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=proofpoint20171006;
 bh=ZxnlTuqsXg0zAzovhTI7cQGkNc7txcYuczZjoyUS7YE=;
 b=nPw2Ld9BBGJHIl9FZvU9Zq/nPmYsm7S32mk1SODokxLy46f7qjDO31CA1drBzPr6V/Ng
 FMxezP1KBNQDcn5nZDsDIxROQonEHCtAtzRp1reH+/buzw0tm1C1wGLNyD1Ne16ANDtv
 bFAnZATmY0Qv22EYav75H3Ck/SsQGuPsd76o6KMACcJzxHV9cQbtz06ezwjV24jpF1DR
 71OayCJPZQKRkFvBGKJ1Q7gdGHGdJUbfXFvEnkhnt5lis2E/pGxe2u2hjLkpohXevzz0
 jjeyfXj9LVllVX6WFTSualHQEqrCJV/UCfcYibeiJ3bPR2nFYcCmBErKTZc0nyFTZ1Ym Hw== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2tju6we3h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2019 14:54:10 -0700
Received: from BYAPR02MB4566.namprd02.prod.outlook.com (52.135.239.205) by
 BYAPR02MB5382.namprd02.prod.outlook.com (20.177.228.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:54:08 +0000
Received: from BYAPR02MB4566.namprd02.prod.outlook.com
 ([fe80::38e0:8f7:9fd4:eb1c]) by BYAPR02MB4566.namprd02.prod.outlook.com
 ([fe80::38e0:8f7:9fd4:eb1c%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:54:08 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: Should memory hotplug work with vhost-user backends?
Thread-Index: AQHVMSK9HbtiS4IGUUSSY9wOBJ3M0Ka5QCmAgAmfOQA=
Date: Tue, 9 Jul 2019 21:54:08 +0000
Message-ID: <84A004CE-A584-46FA-8802-A8A216B7368C@nutanix.com>
References: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
 <20190703031041-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190703031041-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.14.253.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 493df62f-d89e-42c9-3155-08d704b7f828
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BYAPR02MB5382; 
x-ms-traffictypediagnostic: BYAPR02MB5382:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR02MB5382600A695C73B319C1066AEAF10@BYAPR02MB5382.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(39860400002)(366004)(346002)(189003)(199004)(51914003)(54906003)(81156014)(81166006)(8936002)(76116006)(66476007)(316002)(25786009)(476003)(91956017)(66556008)(64756008)(966005)(66446008)(606006)(26005)(66946007)(8676002)(486006)(71190400001)(478600001)(14454004)(33656002)(54896002)(5660300002)(71200400001)(229853002)(53936002)(86362001)(6916009)(6116002)(102836004)(186003)(36756003)(446003)(6306002)(6512007)(2616005)(11346002)(53546011)(6486002)(53376002)(236005)(107886003)(6436002)(4326008)(68736007)(3846002)(6246003)(7736002)(76176011)(66066001)(2906002)(6506007)(256004)(14444005)(44832011)(99286004)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5382;
 H:BYAPR02MB4566.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U6qbzIpShVEjAz/tGnJoKqDqRvdQixa8wf76sbvuDToqux5FpBaqh6q1VQYuBjzY71KYJsoxHCFTvPtWTKaEg3c+mMyYS3yVsOY4KX6YApjhJiNyktGEviHZuD+MVtrI/r6MoQWKMNscoKogy7VKEtSMsUH57iBJtjrIWk0JmDDfa4cCN9q7sSy1xlZAu8vZL4AUMmvC2qDxsUVzDeiFaugPibE1gj4/6Tqbh42AqaUc7xZeMgEnSevl/Whvk1VBJVVW1st2vwWZOOA3SIMGJ54neYsE5cwuWFPAnQ8jG3HA/XQGcdfp/ogU+GngpQ+N0xtUZkQT0xqSRFz0hAIfcUwtBTKfPvAkyEhdCeLQWnJTYPhx+ZVqp0feLpuUW+/144TEcWDauuL54HkKybJJ0N8VGHP8a42E3L/xVE79o6w=
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493df62f-d89e-42c9-3155-08d704b7f828
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:54:08.3545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raphael.norwitz@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5382
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-09_09:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user
 backends?
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
Cc: Mike Cui <cui@nutanix.com>, Malcolm Crossley <malcolm@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "changchun.ouyang@intel.com" <changchun.ouyang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIEp1bCAzLCAyMDE5LCBhdCAxMTo1NyBBTSwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbTxtYWlsdG86bXN0QHJlZGhhdC5jb20+PiB3cm90ZToNCg0KT24gVHVlLCBKdWwg
MDIsIDIwMTkgYXQgMTA6MDg6NTRQTSArMDAwMCwgUmFwaGFlbCBOb3J3aXR6IHdyb3RlOg0KRm9y
IGJhY2tncm91bmQgSSBhbSB0cnlpbmcgdG8gd29yayBhcm91bmQgYSByYW0gc2xvdCBsaW1pdCBp
bXBvc2VkIGJ5IHRoZQ0Kdmhvc3QtdXNlciBwcm90b2NvbC4gV2UgYXJlIGhhdmluZyB0cm91Ymxl
IHJlY29uY2lsaW5nIHRoZSBjb21tZW50IGhlcmU6IGh0dHBzOg0KLy9naXRodWIuY29tL3FlbXUv
cWVtdS9ibG9iL21hc3Rlci9ody92aXJ0aW8vdmhvc3QtdXNlci5jI0wzMzM8aHR0cDovL2dpdGh1
Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2h3L3ZpcnRpby92aG9zdC11c2VyLmMjTDMzMz4g
IHRoYXQg4oCcRm9yDQpub24tdnJpbmcgc3BlY2lmaWMgcmVxdWVzdHMsIGxpa2UgVkhPU1RfVVNF
Ul9TRVRfTUVNX1RBQkxFLiwgd2UganVzdCBuZWVkIHRvDQpzZW5kIGl0IG9uY2UgdGhlIGZpcnN0
IHRpbWXigJ0gYW5kIHRoZSBoaWdoIGxldmVsIGltcGxlbWVudGF0aW9uIG9mIG1lbW9yeQ0KaG90
LWFkZCwgd2hpY2ggY2FsbHMgc2V0X21lbV90YWJsZSBldmVyeSB0aW1lIGEgVk0gaG90IGFkZHMg
bWVtb3J5Lg0KDQpJSVVDIHRoZSBjb21tZW50IHJlZmVycyB0byBtdWx0aXBsZSB2aXJ0cXVldWUu
IEl0IGlzIHRyeWluZyB0byBzYXkgdGhhdA0Kd2UgZG8gbm90IG5lZWQgdG8gc2VuZCBWSE9TVF9V
U0VSX1NFVF9NRU1fVEFCTEUgZm9yIGVhY2gNCnZpcnRxdWV1ZS4NCg0KDQoNCg0KDQpBIGZldyBx
dWVzdGlvbnM6DQoNCjEuDQoNCldoYXQgZXhhY3RseSBpcyB0aGUgY2hlY2sgYGlmICh2aG9zdF91
c2VyX29uZV90aW1lX3JlcXVlc3QobXNnLT5oZHIucmVxdWVzdCkgJiYNCmRldi0+dnFfaW5kZXgg
IT0gMClgIGZvcj8NCg0KU29tZSBiYWNrZW5kcyByZWdpc3RlciBtdWx0aXBsZSBkZXYgaW5zdGFu
Y2VzIHBlciBiYWNrZW5kOiBvbmUgZm9yIGVhY2gNCnZpcnRxdWV1ZS4gIFRoaXMgY2hlY2sgYXZv
aWRzIHNlbmRpbmcgVkhPU1RfVVNFUl9TRVRfTUVNX1RBQkxFIG1vcmUgdGhhbg0Kb25jZSBpbiB0
aGlzIGNhc2UuDQoNCg0KSW4gdGhlIG1lc3NhZ2UgZm9yIGNvbW1pdA0KYjkzMWJmYmYwNDI5ODNm
MzExYjNiMDk4OTRkODAzMGIyNzU1YTYzOCwgd2hpY2ggaW50cm9kdWNlZCB0aGUgY2hlY2ssIEkg
c2VlIGl0DQpzYXlzIOKAnG5vbi12cmluZyBzcGVjaWZpYyBtZXNzYWdlc1ssIHdoaWNoIHNob3Vs
ZF0gYmUgc2VudCBvbmx5IG9uY2XigJ0gYW5kIGdpdmVzDQpWSE9TVF9VU0VSX1NFVF9NRU1fVEFC
TEUgYXMgYW4gZXhhbXBsZSBvbmUgc3VjaCBtZXNzYWdlLiBUaGUNCmB2aG9zdF91c2VyX29uZV90
aW1lX3JlcXVlc3QoKWAgY2FsbCBjbGVhcmx5IGNoZWNrcyB3aGV0aGVyIHRoaXMgdHlwZSBvZg0K
bWVzc2FnZSBpcyB0aGUga2luZCBvZiBtZXNzYWdlIGlzIHN1cHBvc2VkIHRvIGJlIHNlbnQgb25j
ZSBvZiB3aGljaA0KVkhPU1RfVVNFUl9TRVRfTUVNX1RBQkxFIGlzIG9uZS4gV2h5LCB0aGVuLCBk
b2VzIHRoaXMgY29tbWl0IGFkZCB0aGUgY2hlY2sgaWYNCmBkZXYtPnZxX2luZGV4ICE9IDBgPyBJ
dCBzZWVtcyBsaWtlIHRoZXJlIGlzIGEgbGF0ZW50IGFzc3VtcHRpb24gdGhhdCBhZnRlciB0aGUN
CmZpcnN0IGNhbGwgZGV2LT52cV9pbmRleCBzaG91bGQgYmUgc2V0IHRvIHNvbWUgdmFsdWUgZ3Jl
YXRlciB0aGFuIG9uZSwgaG93ZXZlcg0KZm9yIG1hbnkgY2FzZXMgc3VjaCBhcyB2aG9zdC11c2Vy
LXNjc2kgZGV2aWNlcyB3ZSBjYW4gc2VlIHRoaXMgaXMgY2xlYXJseSBub3QNCnRoZSBjYXNlIGh0
dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHVi
LmNvbV9xZW11X3FlbXVfYmxvYl9tYXN0ZXJfaHdfc2NzaV92aG9zdC0yRHVzZXItMkRzY3NpLmMt
MjMmZD1Ed0lEYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9SW40Z21SMXBHektCOEc1cDZM
VXJXcWtTTWVjMkw1RXRYWm93X0ZaTkpaayZtPUpRMmhuLVJoVGZ5aFowRnhxNW16RVJhb1Z6Yjdj
VDh2Y0k3WHYyMEozeWsmcz1hSWVNUDVpZkt4RjNubzI2Y19NNXgxcm5WSDBmaG9GVTJpUkc5QlBS
TkJrJmU9DQpMOTUuIElzIHRoaXMgY2hlY2sgdGhlbiDigJhicm9rZW7igJkgZm9yIHN1Y2ggZGV2
aWNlcz8NCg0KSSB0aGluayB2aG9zdC1zY3NpIGhhcyBhIHNpbmdsZSBpbnN0YW5jZSBwZXIgYmFj
a2VuZCwgdGhhdCBpcw0Kd2h5IHZxX2luZGV4IGlzIDAuDQoNCg0KDQoyLg0KDQpJZiB0aGlzIGNo
ZWNrIGlzIGluZGVlZCBicm9rZW4gZm9yIHN1Y2ggZGV2aWNlcywgYW5kIHNldF9tZW1fdGFibGUg
Y2FsbCBpcyBvbmx5DQpzdXBwb3NlZCB0byBiZSBydW4gb25jZSBmb3Igc3VjaCBkZXZpY2VzLCBp
cyB0aGUgYWJpbGl0eSB0byBjYWxsIGl0IG11bHRpcGxlDQp0aW1lcyB0ZWNobmljYWxseSBhIGJ1
ZyBmb3IgZGV2aWNlcyBzdWNoIGFzIHZob3N0LXVzZXItc2NzY2kgZGV2aWNlcz8gSWYgc28sDQp0
aGlzIHdvdWxkIGltcGx5IHRoYXQgdGhlIGV4aXN0aW5nIGFiaWxpdHkgdG8gaG90IGFkZCBtZW1v
cnkgdG8gdmhvc3QtdXNlci1zY3NpDQpkZXZpY2VzIGlzIGJ5IGV4dGVuc2lvbiB0ZWNobmljYWxs
eSBhIGJ1Zy91bmludGVuZGVkIGJlaGF2aW9yLiBJcyB0aGlzIHRoZQ0KY2FzZT8NCg0KDQoNClRo
YW5rcywNCg0KUmFwaGFlbA0KDQpJIGRvbid0IHRoaW5rIHRoYXQgaXMgdGhlIGNhc2UuIEl0J3Mg
cG9zc2libGUgdGhhdCBtZW1vcnkgaG90cGx1ZyBoYXMNCmJ1Z3Mgd2l0aCB2aG9zdC11c2VyLCBi
dXQgSSBkb24ndCB0aGluayBpdCdzIGFueXRoaW5nIGZ1bmRhbWVudGFsLg0KDQotLQ0KTVNUDQoN
ClRoYW5rcyBmb3IgdGhlIHJlc3BvbnNlcyBTdGVmYW4gYW5kIE1TVCwgSeKAmWxsIGJlIGxvb2tp
bmcgaW50byBpdCBhbmQgcG9zdGluZyBhbiBSRkMgd2hlbiBJJ20gcmVhZHkuDQoNCg==
