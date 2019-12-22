Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D22C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 07:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A16206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 07:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hbHFjEim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A16206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iivyO-0001k9-Ed
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 02:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1iivxk-0001IK-Jd
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 02:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1iivxi-0008OW-J8
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 02:47:39 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:50678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1iivxi-0008He-AO
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 02:47:38 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBM7j5ij020290; Sat, 21 Dec 2019 23:47:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=UlG09nH3aEQM+VdUmTjeNC+aH1Bmw6AHply2Pj2HicE=;
 b=hbHFjEimsLBH9x1mbuVb6DOkm9XpBNJ8cd7b+U1gz1qWWn9SHKhDCva92ymvQFCQ12hl
 ovOpJbnSDDbttMSEgyihYpHzNlydhpFp10SmfhyCTg599l3T7eNuULl7OxtMju9GXk2o
 Z3isJ+kdCpjocVnUPjQBAZcIjm3X5ql17Sexv4Gl+M9a8HlVaB+DPbJyjgU5w2wuPTz9
 SpHlN0QdSXrvFQeUToxLSsL4nnb1cX6hJnrAuFGwKri1+j85SwukATm+Gi3Rb//wbvne
 49oGL8ZFiUQCPyEHnZJ6zV2jU5VY5fr8mkoPrNDFqvyslR9r45X6tU1tV05r9vfx36kB pg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2x1htf97u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Dec 2019 23:47:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKQMUyx0m0AEarbEoH+6yr0psFyDsnCcWNH7URATdY+VByIeqVuPG2nuwHjZ9rBidsxCWIsfDEf4Y9OZEG5BAvCEMQdgPpG3MrpMD5ojO3Nhd8ixatNqRHhhrh7n7Ldgb4Amsju5rX/Mhbh1YfrRd6E3n6bDu+6rjCy7uHybbxaNPIwwJY+QQs2XTaUgMmJey04hUwZprv5it8thQnLkrn4Zf7RLyLgE7Z44wi/sRRpMvOrfNkujniRwUXVm06/KsTJBb2VPqDVeEBvxi63dEtZsRYdVIk4gtkix36V6RhoVvR5i0Fz9RDjfYZmaKruUgg3IbYZjC3X9xgdUEPThfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlG09nH3aEQM+VdUmTjeNC+aH1Bmw6AHply2Pj2HicE=;
 b=gUCYAOLlEqaie61e99CuBAE6aNcouxx5WfSAD+hdfmpfbuBp0hPRdAq1hx+4ntiIMuIzTSF1rMluS4ef8XxoMVbmPdWrpveKUIRki7eGVjAvcJnzYWhH8+8cS6MKZ1bqqoNCEwra7fdXeqSWx2mhWTA6D0zTyxb9vRZif4watPqAoCQLY9MXHnaLKDbn96r7eBK/6YuLk42zSEjNAkqMfcO55s/KATbBHz72/lZyMAgJYj/lBWbQhbgGf6mZCPElZJIPsG9qPMSm8bblxPQoH1GSnLXGmktnpBAxAZ1PiqIGjL5N1j6UNSbcDBYqrrCz/CQN3FnJNEzkNrIrgEa+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.175.28) by
 MN2PR02MB5949.namprd02.prod.outlook.com (20.179.98.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Sun, 22 Dec 2019 07:32:38 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c%3]) with mapi id 15.20.2559.017; Sun, 22 Dec 2019
 07:32:38 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVtYKm5uylcpuSJ0uEmLmhvuRW56e/yJSAgAYAW4A=
Date: Sun, 22 Dec 2019 07:32:38 +0000
Message-ID: <7452FAE9-ACDF-495E-AE5A-8A8ED9488B03@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
In-Reply-To: <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.96.119.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b7f2741-d923-495e-0081-08d786b11efa
x-ms-traffictypediagnostic: MN2PR02MB5949:
x-microsoft-antispam-prvs: <MN2PR02MB59494A16BA542E53E9019FD8F12F0@MN2PR02MB5949.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(66446008)(2616005)(91956017)(44832011)(36756003)(71200400001)(76116006)(6486002)(64756008)(54906003)(66946007)(66476007)(66556008)(6512007)(316002)(4326008)(5660300002)(2906002)(81166006)(53546011)(81156014)(8676002)(6506007)(86362001)(6916009)(8936002)(26005)(186003)(33656002)(478600001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB5949;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LTnWSejA86Pdfp326LZq7jv8CVuZR7EEX+yimYAFva21DmnN02bNyHboG1esF1L+NE9UyIM6sfu4mmf00l8vI4DA5g1STDkYm8q5MEEMHWuO1mxaMCVArs5k2pwbUW3UuApGZpqbnZtzQoc/EHyMnnwbMxxFsmBBDzOGpDFWtFIllgwsAo586x19We6mPAs4lSGE6lB5lWDuxFNU8hCNG9gZeP+21qcHJYkm/XcEVgVU4wxvyOxmtGs/RCLy3uaNvJYBdT1x6RI1IaywBs+5VqIYrOgxACSUcgjfCwoMDhqZP/lh2vPtEtIpzRwz4KVUznXf4+P0W/xuU3yZzZkwNyJ0q1MpBwIDxUiabozr43pQgMGEz4cEZyBjqGv3EL1/szN3dlccFkFjP7D1C7IjGo0axIqcDzW1rt3oG1Q7TNGw8myI40Ddk0r6krGkxs5A3x96smd3R7pXR8acTkIIROOJD0StwUCb6ONDvszGVr0+R/+IEig/YW0vgLJbABp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <88734E35E959424A9CB6DE73D7FE5121@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f2741-d923-495e-0081-08d786b11efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2019 07:32:38.1209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsdAmyzhqaiUo6pa5R8Y+ECaGXZ42wt6FnINT/VbDr3dRtZSaCiVgbZNN8K8hYZGxyfagunEaumrEwntdIDt6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5949
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-22_01:2019-12-17,2019-12-21 signatures=0
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpQaW5nIOKApg0KDQo+IE9uIERlYyAxOCwgMjAxOSwgYXQgNToyMyBQTSwgUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxOC8xMi8xOSAxMDowNSwg
QW5pIFNpbmhhIHdyb3RlOg0KPj4gQ0xaRVJPIENQVUlEIHNob3VsZCBiZSBwYXNzZWQgb24gdG8g
dGhlIGd1ZXN0cyB0aGF0IHVzZSBFUFlDIG9yIEVQWUMtSUJQQiBDUFUNCj4+IG1vZGVsIHdoZW4g
dGhlIEFNRCBaRU4gYmFzZWQgaG9zdCBzdXBwb3J0cyBpdC4gVGhpcyBjaGFuZ2UgbWFrZXMgaXQg
cmVjb2duaXplDQo+PiB0aGlzIENQVUlEIGZvciBndWVzdHMgd2hpY2ggdXNlIEVQWUMgb3IgRVBZ
Qy1JQlBCIENQVSBtb2RlbC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQW5pIFNpbmhhIDxhbmku
c2luaGFAbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+IHRhcmdldC9pMzg2L2NwdS5jIHwgMiArKw0K
Pj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2kzODYvY3B1LmMgYi90YXJnZXQvaTM4Ni9jcHUuYw0KPj4gaW5kZXggNjlmNTE4YS4u
NTVmMDY5MSAxMDA2NDQNCj4+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQo+PiArKysgYi90YXJn
ZXQvaTM4Ni9jcHUuYw0KPj4gQEAgLTM4MTMsNiArMzgxMyw4IEBAIHN0YXRpYyBYODZDUFVEZWZp
bml0aW9uIGJ1aWx0aW5feDg2X2RlZnNbXSA9IHsNCj4+ICAgICAgICAgICAgIENQVUlEX0VYVDNf
TUlTQUxJR05TU0UgfCBDUFVJRF9FWFQzX1NTRTRBIHwgQ1BVSURfRVhUM19BQk0gfA0KPj4gICAg
ICAgICAgICAgQ1BVSURfRVhUM19DUjhMRUcgfCBDUFVJRF9FWFQzX1NWTSB8IENQVUlEX0VYVDNf
TEFIRl9MTSB8DQo+PiAgICAgICAgICAgICBDUFVJRF9FWFQzX1RPUE9FWFQsDQo+PiArICAgICAg
ICAuZmVhdHVyZXNbRkVBVF84MDAwXzAwMDhfRUJYXSA9DQo+PiArICAgICAgICAgICAgQ1BVSURf
ODAwMF8wMDA4X0VCWF9DTFpFUk8sDQo+PiAgICAgICAgIC5mZWF0dXJlc1tGRUFUXzdfMF9FQlhd
ID0NCj4+ICAgICAgICAgICAgIENQVUlEXzdfMF9FQlhfRlNHU0JBU0UgfCBDUFVJRF83XzBfRUJY
X0JNSTEgfCBDUFVJRF83XzBfRUJYX0FWWDIgfA0KPj4gICAgICAgICAgICAgQ1BVSURfN18wX0VC
WF9TTUVQIHwgQ1BVSURfN18wX0VCWF9CTUkyIHwgQ1BVSURfN18wX0VCWF9SRFNFRUQgfA0KPj4g
DQo+IA0KPiBUaGlzIG5lZWRzIHRvIGJlIGRvbmUgb25seSBmb3IgbmV3ZXIgbWFjaGluZSB0eXBl
IChvciBpcyBpdCBDUFUgbW9kZWwNCj4gdmVyc2lvbnMgbm93PyBuZWVkIEVkdWFyZG8gdG8gcmVz
cG9uZCkuDQo+IA0KPiBQYW9sbw0KDQo=

