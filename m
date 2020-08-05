Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50D02311F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZEiavMEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50D02311F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3LlJ-0004zL-3O
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 11:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swapnil.ingle@nutanix.com>)
 id 1k3LkT-0004RR-M2; Wed, 05 Aug 2020 11:54:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:58210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swapnil.ingle@nutanix.com>)
 id 1k3LkR-0005YG-6R; Wed, 05 Aug 2020 11:54:37 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 075FnE81024871; Wed, 5 Aug 2020 08:54:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=aQVxuxUvZL6u5ndCWwjgCdpMRMoqBE12klCLpXQ6vHY=;
 b=ZEiavMEF7xspU/ukqPmCfM38Wn3UmfArTaE4idEZezwfldRuQQWJ4gUxVR1Xo8EXP882
 Fl1OliWo6HqokkWJkmX71Ycje6M52o8HT+jQKQhM0dzPvQlSWKV7HpGzGsis/Ckqz2Hd
 l8mLgLEiySsx4skSA0mWNAg4ClmPAXs7dZFcSTcVhiCz7CL8A/nJCI5++5fD89XRThrx
 AdX0p3kwaqbbdiGqhY2d8uWy1y0hdd8172keB0ZokPK76HWHFS/aPmR8d83qXxaggybL
 8vKNJyF1egxNUjZyDH1trZkZUnfg1UW4H/BCAb4H38fwFmGrE5twuUOd9GMgdEuexOSp zg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0b-002c1b01.pphosted.com with ESMTP id 32nhf6r1m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2020 08:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLXy3Y7W5ZMFlgx1cln2xZ/Zuu2yuObHeaMEU6PIE5BM+q1hiJtzhzFlv8rW4AWCREqiQEDvvsk1q7lhujCIFsAjDMHOSuId2LbCvtqNuat9Qh7ZPI5g0BI0c+ysZsgSG+WA0srhLiMGrNWXsQU92KpQ2w/g0pGXB0NJpy7lm/tdgDxRdmxOr99UoEOMkJB6u1Q/7Nx307pkI62SL+8c9NBQxo5qXF51aLxS1+LWnJ1PJMRAUceZr+V1qkl6vIoLE7GBQyGqjvKNMk5VfmWcZYy7wIODiY7QycN7u5St9TbAuPg2CIBOzeOwKp8IU+qCt5f7efU5/EFU9lSNMo6dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQVxuxUvZL6u5ndCWwjgCdpMRMoqBE12klCLpXQ6vHY=;
 b=WI4qRFoIYptt7QWAVW4KZlaS+cSnE82R9/upU23aqadY0k5gxPkEkGa8DPrOC6lG9Mjpy/1Nw0Qlk35elfuiu37YGLVD/00AGhpIX+glTCeBdt3SOA2rIGdWNFtsX8lxnqXpbwsw1iWLwXQSFjLyqakZyvRy+CObY+MPzR67NRE9n3itKLkXvJjsfsd1QpwJccVP86e8/YfT+tuERhlJna17KH71E8FeejJUuom0yTfKMJypcHKYcw6pzS9PenEM/iV9bwjHLLwXt6pzkbHNuc/Vj1EsIXJOfQigexM51sVD1ieqffHaaZp5xXrRZN8/E1eIOg5kIKQM4cZwdI0n5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB3958.namprd02.prod.outlook.com (2603:10b6:a02:fc::21)
 by BYAPR02MB4501.namprd02.prod.outlook.com (2603:10b6:a03:5c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Wed, 5 Aug
 2020 15:54:27 +0000
Received: from BYAPR02MB3958.namprd02.prod.outlook.com
 ([fe80::75df:d252:4814:2f8b]) by BYAPR02MB3958.namprd02.prod.outlook.com
 ([fe80::75df:d252:4814:2f8b%5]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 15:54:27 +0000
From: Swapnil Ingle <swapnil.ingle@nutanix.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: qemu-img convert asserts while converting from vhdx to raw
Thread-Topic: qemu-img convert asserts while converting from vhdx to raw
Thread-Index: AQHWZP+rImKr+07DY0WwP1ytUb9RxakeY8yAgAt1GgA=
Date: Wed, 5 Aug 2020 15:54:27 +0000
Message-ID: <EF5F4DAB-6FA4-43DC-A9F2-AFEB0B9837CA@nutanix.com>
References: <8906F385-C6C0-4F60-A15C-07B2AE7F0B7A@nutanix.com>
 <fa95eeba-5f3d-912d-01ba-14dbcc4c24dd@redhat.com>
In-Reply-To: <fa95eeba-5f3d-912d-01ba-14dbcc4c24dd@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [37.235.116.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 279bb9e4-dde0-4cb9-42ee-08d83957d54d
x-ms-traffictypediagnostic: BYAPR02MB4501:
x-microsoft-antispam-prvs: <BYAPR02MB4501AA6F747C7229DDE69BAFFD4B0@BYAPR02MB4501.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8u0VbMRCGthhGNwQBGJxAxWWM3D5ULCKoCgWjqVk7ZjfxNdEUYCYtSVqyCBq39mbxKStfNHXWDx+uCJvYtCMHto3u3tdAUkiVrgND+N2dk+spu6ZFS0RsKD1Yqw2LQZ7H+QI2Oe2A3sCPwkpuAc1lqrLsETsKZ0WXKRVLySt14rR5qnNvPUFmD8ysWt7lofxF6ObmMhcSnOJaUs1ZVNh3uhPUBBLaHMc8ca6s9wIjEVl1hmjO9tbSqHcx6KcQAH1nRJumOMVPD1pO9UoKuM/sytBe0jJbOfWBeSqrgDn/I+MOe82lP7d2zlfzMByZPO9kNKkakfknF1GSU/iG2Jang==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB3958.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(66556008)(33656002)(8936002)(36756003)(66946007)(91956017)(6916009)(8676002)(6512007)(64756008)(76116006)(4326008)(71200400001)(2906002)(66446008)(66476007)(6506007)(44832011)(5660300002)(54906003)(86362001)(478600001)(83380400001)(316002)(186003)(6486002)(53546011)(2616005)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 28ut4RRDYPZveAF/Nhqxex/O8Gk2p/tyokq7zMWKHuSIXL+muGQrKvG3mZyXdvaNMwUEoxH7gwYz+L/OCDLw/iS+aIQcdExszBQuJMVVU3M7cckd15Ynz6i2vpG1OGzLdTCuNqQnZNeFr+caz4I/TNmql8AtZfwlxKWpL4QwrGA6Q9SBl5pu8nRssiPQE8S2/xcfVeV74z1GM5NhKQ9wkptDm2hgNTs0yVj+9LNH295UauWCMwr0QHQyJi07DMbB0hSlWjCB/B1UmB8HwEXQ89d1Qq9vrKMN/O6reNjW2Om+UClNtMh5kAW6Pg5f/gP5CxXG+TtAiZkQIKXYrW3LCWPCfZXJ5yJmuccCrDWMa2JrSwm3olJO+nBFRs2m0vXCLGZwKe7qe2Z/31psf663mfOdoVf3w0lGt+Xq5VM0eCJB9ETBzQoYmrDLS2jFQsNTM6QMj42vdMDppOYxl5uLyZBEAkSYRYMYAINpvOcDrGMZTnYqSL6ioAuUnLGboueX2Ykm+jUCuKoRqRSVj51As0KmIhYs8yUp4r0qgJefvIyg7s5PQMBI06Q8DMK+Y+MOnbc4slzn6yqo6ZdBFwkeDL+DSWL6dHvlW6z3gvvQCGzooYNciKdWm177l/4cAMzzu/wkXvTy7u6pkp9ltI0sEA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <93C6BC51DA44C548B5160C48E63F3A3B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279bb9e4-dde0-4cb9-42ee-08d83957d54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 15:54:27.3039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2gJQnRuYfpCw6fb91+1lz4vVAFkwlIqFi34KEOu7ZVuivHeOBHCnlXsOUzgRYMesEEEe5Iu7joZika9ButDomAwwPJ5hOW4njxeA+3lLpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-05_13:2020-08-03,
 2020-08-05 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=swapnil.ingle@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 11:54:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Jeff Cody <codyprime@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgTWF4LA0KDQpUaGFua3MgZm9yIHRoZSByZXNwb25zZS4NCg0KSSBjaGVja2VkIGludGVybmFs
bHkgYW5kIGxvb2tzIGxpa2UgaXQgYWx3YXlzIGZhaWxzLg0KQWxzbyBpbiB0aGUgY29kZSBJIHNl
ZSBjb21tZW50IHNheWluZyAiV2Ugb25seSBzdXBwb3J0IDUxMiBjdXJyZW50bHkiDQphdCBibG9j
ay92aGR4LmM6IHZoZHhfcGFyc2VfbWV0YWRhdGEoKQ0KDQpBcyB5b3Ugc3VnZ2VzdGVkIHdlIGNh
biBqdXN0IHJlZnVzZSB0byBvcGVuIGltYWdlcyB3aXRoIDRLIGxvZ2ljYWwgc2VjdG9yIHNpemUs
IA0KSSB3aWxsIHNlbmQgYW4gcGF0Y2ggZml4aW5nIHRoaXMuDQoNClRoYW5rcyBhbmQgUmVnYXJk
cywNCi1Td2FwbmlsDQoNCu+7v09uIDI5LjA3LjIwLCAxMjo1NiwgIk1heCBSZWl0eiIgPG1yZWl0
ekByZWRoYXQuY29tPiB3cm90ZToNCg0KICAgIE9uIDI4LjA3LjIwIDE4OjUzLCBTd2FwbmlsIElu
Z2xlIHdyb3RlOg0KICAgID4gSGV5IEd1eXMsDQogICAgPiANCiAgICA+ICANCiAgICA+IA0KICAg
ID4gV2UgYXJlIHNlZWluZyBmb2xsb3dpbmcgYXNzZXJ0IHdoZW4gdHJ5aW5nIHRvIGNvbnZlcnQg
ZGlzayBpbWFnZSBmcm9tDQogICAgPiB2aGR4IHRvIHJhdy4gDQogICAgPiANCiAgICA+IFRoaXMg
aXNzdWUgaXMgc2VlbiBvbmx5IGZvciBkaXNrIHdpdGggNGsgbG9naWNhbCBzZWN0b3Igc2l6ZS4N
Cg0KICAgIEhvbmVzdGx5LCBsb29raW5nIGF0IHRoZSB2aGR4IGNvZGUsIGl0IGp1c3QgY2Fu4oCZ
dCB3b3JrIGZvciA0ayBsb2dpY2FsDQogICAgc2VjdG9ycyB3aXRob3V0IGEgbWFqb3IgcmV3b3Jr
LiAgQXMgZmFyIGFzIEkgY2FuIHNlZSwgZm9yIHNvbWUgcmVhc29uIGl0DQogICAgbGlrZXMgdG8g
YXNzdW1lIHRoYXQgcWVtdSBibG9jayBsYXllciBzZWN0b3JzICh3aGljaCBhcmUgYWx3YXlzIDUx
Mg0KICAgIGJ5dGVzKSBhcmUgYWx3YXlzIHRoZSBzYW1lIGFzIHZoZHggc2VjdG9ycyAod2hpY2gg
YXJlbuKAmXQpLg0KDQogICAgRGlkIHlvdSBldmVyIGdldCBhbnkgdmhkeCBpbWFnZSB3aXRoIDRr
IGxvZ2ljYWwgc2VjdG9ycyB0byB3b3JrPw0KDQogICAgVGhlIHByb2JsZW0gSSBzZWUgaXMgdGhh
dCB3ZSBkb27igJl0IGhhdmUgYW4gYWN0aXZlIG1haW50YWluZXIgZm9yIHZoZHgsDQogICAgc28g
YXMgdW5mb3J0dW5hdGUgYXMgaXQgaXMsIGlmIGl04oCZcyByZWFsbHkgbmV2ZXIgd29ya2VkLCB0
aGUgb25seQ0KICAgIHJlYWxpc3RpYyBzb2x1dGlvbiBJIHNlZSB3b3VsZCBiZSB0byBvdXRyaWdo
dCByZWZ1c2UgdG8gb3BlbiBpbWFnZXMgd2l0aA0KICAgIDRrIHNlY3RvcnMuLi4NCg0KICAgIE1h
eA0KDQogICAgPiAkIHFlbXUtaW1nIGNvbnZlcnQgLWYgdmhkeCAtTyByYXcgNEtUZXN0MS52aGR4
IHRlc3QucmF3DQogICAgPiANCiAgICA+IHFlbXUtaW1nOiB1dGlsL2lvdi5jOjM4ODogcWlvdl9z
bGljZTogQXNzZXJ0aW9uIGBvZmZzZXQgKyBsZW4gPD0NCiAgICA+IHFpb3YtPnNpemUnIGZhaWxl
ZC4NCiAgICA+IA0KICAgID4gQWJvcnRlZA0KICAgID4gDQogICAgPiAgDQogICAgPiANCiAgICA+
ICQgcWVtdS1pbWcgLS12ZXJzaW9uDQogICAgPiANCiAgICA+IHFlbXUtaW1nIHZlcnNpb24gNS4w
LjkxICh2NS4xLjAtcmMxLTItZzNjYmM4OTctZGlydHkpDQogICAgPiANCiAgICA+IENvcHlyaWdo
dCAoYykgMjAwMy0yMDIwIEZhYnJpY2UgQmVsbGFyZCBhbmQgdGhlIFFFTVUgUHJvamVjdCBkZXZl
bG9wZXJzDQogICAgPiANCiAgICA+ICANCiAgICA+IA0KICAgID4gICQgcWVtdS1pbWcgY2hlY2sg
LXIgYWxsIDRLVGVzdDEudmhkeA0KICAgID4gDQogICAgPiBObyBlcnJvcnMgd2VyZSBmb3VuZCBv
biB0aGUgaW1hZ2UuDQogICAgPiANCiAgICA+ICANCiAgICA+IA0KICAgID4gJCBxZW11LWltZyBp
bmZvIDRLVGVzdDEudmhkeA0KICAgID4gDQogICAgPiBpbWFnZTogNEtUZXN0MS52aGR4DQogICAg
PiANCiAgICA+IGZpbGUgZm9ybWF0OiB2aGR4DQogICAgPiANCiAgICA+IHZpcnR1YWwgc2l6ZTog
MTAgR2lCICgxMDczNzQxODI0MCBieXRlcykNCiAgICA+IA0KICAgID4gZGlzayBzaXplOiAzNS43
IEdpQg0KICAgID4gDQogICAgPiBjbHVzdGVyX3NpemU6IDMzNTU0NDMyDQogICAgPiANCiAgICA+
ICANCiAgICA+IA0KICAgID4gVGhlIHZoZHggZGlzayBtZXRhZGF0YSBpcyBmb2xsb3dpbmcsIA0K
ICAgID4gDQogICAgPiAgDQogICAgPiANCiAgICA+IFZoZEZvcm1hdCA6IFZIRFgNCiAgICA+IA0K
ICAgID4gVmhkVHlwZSA6IER5bmFtaWMNCiAgICA+IA0KICAgID4gTG9naWNhbFNlY3RvclNpemUg
OiA0MDk2IA0KICAgID4gDQogICAgPiBQaHlzaWNhbFNlY3RvclNpemUgOiA0MDk2DQogICAgPiAN
CiAgICA+IEJsb2NrU2l6ZSA6IDMzNTU0NDMyDQogICAgPiANCiAgICA+ICANCiAgICA+IA0KICAg
ID4gRm9sbG93aW5nIGlzIHRoZSBiYWNrdHJhY2Ugb2YgdGhlIGFzc2VydCwgDQogICAgPiANCiAg
ICA+ICANCiAgICA+IA0KICAgID4gIzAgIDB4MDAwMDdmZmZmNjRjZjM4NyBpbiByYWlzZSAoKSBm
cm9tIC9saWI2NC9saWJjLnNvLjYNCiAgICA+IA0KICAgID4gIzEgIDB4MDAwMDdmZmZmNjRkMGE3
OCBpbiBhYm9ydCAoKSBmcm9tIC9saWI2NC9saWJjLnNvLjYNCiAgICA+IA0KICAgID4gIzIgIDB4
MDAwMDdmZmZmNjRjODFhNiBpbiBfX2Fzc2VydF9mYWlsX2Jhc2UgKCkgZnJvbSAvbGliNjQvbGli
Yy5zby42DQogICAgPiANCiAgICA+ICMzICAweDAwMDA3ZmZmZjY0YzgyNTIgaW4gX19hc3NlcnRf
ZmFpbCAoKSBmcm9tIC9saWI2NC9saWJjLnNvLjYNCiAgICA+IA0KICAgID4gIzQgIDB4MDAwMDU1
NTU1NTZhYmY1YSBpbiBxaW92X3NsaWNlIChxaW92PTB4N2ZmZmY0MTIyYTIwLCBvZmZzZXQ9MCwN
CiAgICA+IGxlbj0yMDk2NjQwLCBoZWFkPTB4N2ZmZmY0MTIyNjQ4LCB0YWlsPTB4N2ZmZmY0MTIy
NjUwLA0KICAgID4gDQogICAgPiAgICAgbmlvdj0weDdmZmZmNDEyMjY0MCkgYXQgdXRpbC9pb3Yu
YzozODgNCiAgICA+IA0KICAgID4gIzUgIDB4MDAwMDU1NTU1NTZhYzBmNiBpbiBxZW11X2lvdmVj
X2luaXRfZXh0ZW5kZWQgKHFpb3Y9MHg3ZmZmZjQxMjI3MzAsDQogICAgPiBoZWFkX2J1Zj0weDAs
IGhlYWRfbGVuPTAsIG1pZF9xaW92PTB4N2ZmZmY0MTIyYTIwLCBtaWRfb2Zmc2V0PTAsDQogICAg
PiANCiAgICA+ICAgICBtaWRfbGVuPTIwOTY2NDAsIHRhaWxfYnVmPTB4MCwgdGFpbF9sZW49MCkg
YXQgdXRpbC9pb3YuYzo0MjkNCiAgICA+IA0KICAgID4gIzYgIDB4MDAwMDU1NTU1NTZhYzQzOCBp
biBxZW11X2lvdmVjX2luaXRfc2xpY2UgKHFpb3Y9MHg3ZmZmZjQxMjI3MzAsDQogICAgPiBzb3Vy
Y2U9MHg3ZmZmZjQxMjJhMjAsIG9mZnNldD0wLCBsZW49MjA5NjY0MCkgYXQgdXRpbC9pb3YuYzo0
OTUNCiAgICA+IA0KICAgID4gIzcgIDB4MDAwMDU1NTU1NTYwOWJkNiBpbiBiZHJ2X2RyaXZlcl9w
cmVhZHYgKGJzPTB4NTU1NTU1OTgyYTgwLA0KICAgID4gb2Zmc2V0PTE1ODQxODg2MjA4LCBieXRl
cz0yMDk2NjQwLCBxaW92PTB4N2ZmZmY0MTIyYTIwLCBxaW92X29mZnNldD0wLA0KICAgID4gDQog
ICAgPiAgICAgZmxhZ3M9MCkgYXQgYmxvY2svaW8uYzoxMTM0DQogICAgPiANCiAgICA+ICM4ICAw
eDAwMDA1NTU1NTU2MGFkNTUgaW4gYmRydl9hbGlnbmVkX3ByZWFkdiAoY2hpbGQ9MHg1NTU1NTU5
ODkxZjAsDQogICAgPiByZXE9MHg3ZmZmZjQxMjI5MDAsIG9mZnNldD0xNTg0MTg4NjIwOCwgYnl0
ZXM9MjA5NjY0MCwgYWxpZ249MSwNCiAgICA+IA0KICAgID4gICAgIHFpb3Y9MHg3ZmZmZjQxMjJh
MjAsIHFpb3Zfb2Zmc2V0PTAsIGZsYWdzPTApIGF0IGJsb2NrL2lvLmM6MTUxNQ0KICAgID4gDQog
ICAgPiAjOSAgMHgwMDAwNTU1NTU1NjBiNjdiIGluIGJkcnZfY29fcHJlYWR2X3BhcnQgKGNoaWxk
PTB4NTU1NTU1OTg5MWYwLA0KICAgID4gb2Zmc2V0PTE1ODQxODg2MjA4LCBieXRlcz0yMDk2NjQw
LCBxaW92PTB4N2ZmZmY0MTIyYTIwLCBxaW92X29mZnNldD0wLA0KICAgID4gDQogICAgPiAgICAg
ZmxhZ3M9MCkgYXQgYmxvY2svaW8uYzoxNzU2DQogICAgPiANCiAgICA+ICMxMCAweDAwMDA1NTU1
NTU2MGI0YjQgaW4gYmRydl9jb19wcmVhZHYgKGNoaWxkPTB4NTU1NTU1OTg5MWYwLA0KICAgID4g
b2Zmc2V0PTE1ODQxODg2MjA4LCBieXRlcz0yMDk2NjQwLCBxaW92PTB4N2ZmZmY0MTIyYTIwLCBm
bGFncz0wKQ0KICAgID4gDQogICAgPiAgICAgYXQgYmxvY2svaW8uYzoxNzE0DQogICAgPiANCiAg
ICA+ICMxMSAweDAwMDA1NTU1NTU1ZTMyNjYgaW4gdmhkeF9jb19yZWFkdiAoYnM9MHg1NTU1NTU5
N2IzNzAsDQogICAgPiBzZWN0b3JfbnVtPTQxOTQzMDQsIG5iX3NlY3RvcnM9NDA5NSwgcWlvdj0w
eDdmZmZmNDEyMmUxMCkgYXQNCiAgICA+IGJsb2NrL3ZoZHguYzoxMjA4DQogICAgPiANCiAgICA+
ICMxMiAweDAwMDA1NTU1NTU2MDlkYTEgaW4gYmRydl9kcml2ZXJfcHJlYWR2IChicz0weDU1NTU1
NTk3YjM3MCwNCiAgICA+IG9mZnNldD0yMTQ3NDgzMTM2LCBieXRlcz0yMDk3MTUyLCBxaW92PTB4
N2ZmZmY0MTIyZTEwLCBxaW92X29mZnNldD0wLA0KICAgID4gDQogICAgPiAgICAgZmxhZ3M9MCkg
YXQgYmxvY2svaW8uYzoxMTY5DQogICAgPiANCiAgICA+ICMxMyAweDAwMDA1NTU1NTU2MGFkNTUg
aW4gYmRydl9hbGlnbmVkX3ByZWFkdiAoY2hpbGQ9MHg1NTU1NTU5ODkxNTAsDQogICAgPiByZXE9
MHg3ZmZmZjQxMjJjYjAsIG9mZnNldD0yMTQ3NDgzMTM2LCBieXRlcz0yMDk3MTUyLCBhbGlnbj01
MTIsDQogICAgPiANCiAgICA+ICAgICBxaW92PTB4N2ZmZmY0MTIyZTEwLCBxaW92X29mZnNldD0w
LCBmbGFncz0wKSBhdCBibG9jay9pby5jOjE1MTUNCiAgICA+IA0KICAgID4gIzE0IDB4MDAwMDU1
NTU1NTYwYjY3YiBpbiBiZHJ2X2NvX3ByZWFkdl9wYXJ0IChjaGlsZD0weDU1NTU1NTk4OTE1MCwN
CiAgICA+IG9mZnNldD0yMTQ3NDgzMTM2LCBieXRlcz0yMDk3MTUyLCBxaW92PTB4N2ZmZmY0MTIy
ZTEwLCBxaW92X29mZnNldD0wLA0KICAgID4gDQogICAgPiAgICAgZmxhZ3M9MCkgYXQgYmxvY2sv
aW8uYzoxNzU2DQogICAgPiANCiAgICA+ICMxNSAweDAwMDA1NTU1NTU2MGI0YjQgaW4gYmRydl9j
b19wcmVhZHYgKGNoaWxkPTB4NTU1NTU1OTg5MTUwLA0KICAgID4gb2Zmc2V0PTIxNDc0ODMxMzYs
IGJ5dGVzPTIwOTcxNTIsIHFpb3Y9MHg3ZmZmZjQxMjJlMTAsIGZsYWdzPTApDQogICAgPiANCiAg
ICA+ICAgICBhdCBibG9jay9pby5jOjE3MTQNCiAgICA+IA0KICAgID4gIzE2IDB4MDAwMDU1NTU1
NTVmMzRjMyBpbiBibGtfZG9fcHJlYWR2IChibGs9MHg1NTU1NTU5N2IwMTAsDQogICAgPiBvZmZz
ZXQ9MjE0NzQ4MzEzNiwgYnl0ZXM9MjA5NzE1MiwgcWlvdj0weDdmZmZmNDEyMmUxMCwgZmxhZ3M9
MCkNCiAgICA+IA0KICAgID4gICAgIGF0IGJsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxMjExDQogICAg
PiANCiAgICA+ICMxNyAweDAwMDA1NTU1NTU1ZjM1MWIgaW4gYmxrX2NvX3ByZWFkdiAoYmxrPTB4
NTU1NTU1OTdiMDEwLA0KICAgID4gb2Zmc2V0PTIxNDc0ODMxMzYsIGJ5dGVzPTIwOTcxNTIsIHFp
b3Y9MHg3ZmZmZjQxMjJlMTAsIGZsYWdzPTApDQogICAgPiANCiAgICA+ICAgICBhdCBibG9jay9i
bG9jay1iYWNrZW5kLmM6MTIyMw0KICAgID4gDQogICAgPiAjMTggMHgwMDAwNTU1NTU1NTczNDdi
IGluIGJsa19jb19wcmVhZCAoYmxrPTB4NTU1NTU1OTdiMDEwLA0KICAgID4gb2Zmc2V0PTIxNDc0
ODMxMzYsIGJ5dGVzPTIwOTcxNTIsIGJ1Zj0weDdmZmZlZmRmZjAwMCwgZmxhZ3M9MCkNCiAgICA+
IA0KICAgID4gICAgIGF0IC9ob21lL3N3YXBuaWwvZGV2L2dpdGh1Yi9xZW11L2luY2x1ZGUvc3lz
ZW11L2Jsb2NrLWJhY2tlbmQuaDoxNDANCiAgICA+IA0KICAgID4gIzE5IDB4MDAwMDU1NTU1NTU3
NzFhYSBpbiBjb252ZXJ0X2NvX3JlYWQgKHM9MHg3ZmZmZmZmZmRjMzAsDQogICAgPiBzZWN0b3Jf
bnVtPTQxOTQzMDMsIG5iX3NlY3RvcnM9NDA5NiwgYnVmPTB4N2ZmZmVmZGZmMDAwICIiKSBhdA0K
ICAgID4gcWVtdS1pbWcuYzoxODMwDQogICAgPiANCiAgICA+ICMyMCAweDAwMDA1NTU1NTU1Nzc4
NWMgaW4gY29udmVydF9jb19kb19jb3B5IChvcGFxdWU9MHg3ZmZmZmZmZmRjMzApIGF0DQogICAg
PiBxZW11LWltZy5jOjIwMDcNCiAgICA+IA0KICAgID4gIzIxIDB4MDAwMDU1NTU1NTZhOWU0ZSBp
biBjb3JvdXRpbmVfdHJhbXBvbGluZSAoaTA9MTQzNjEzMzU2OCwgaTE9MjE4NDUpDQogICAgPiBh
dCB1dGlsL2Nvcm91dGluZS11Y29udGV4dC5jOjE3Mw0KICAgID4gDQogICAgPiAjMjIgMHgwMDAw
N2ZmZmY2NGUxMTkwIGluID8/ICgpIGZyb20gL2xpYjY0L2xpYmMuc28uNg0KICAgID4gDQogICAg
PiAjMjMgMHgwMDAwN2ZmZmZmZmZkMmUwIGluID8/ICgpDQogICAgPiANCiAgICA+ICMyNCAweDAw
MDAwMDAwMDAwMDAwMDAgaW4gPz8gKCkNCiAgICA+IA0KICAgID4gIA0KICAgID4gDQogICAgPiBU
aGFua3MgYW5kIFJlZ2FyZHMsDQogICAgPiANCiAgICA+IC1Td2FwbmlsDQogICAgPiANCiAgICA+
ICANCiAgICA+IA0KDQoNCg0K

