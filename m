Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3719C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFFD21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="tAmjBbjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFFD21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iue50-0000Ug-IS
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iubrL-00015g-1s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iubrJ-0000UN-U8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:45:18 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:45152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1iubrE-0000HP-5X; Thu, 23 Jan 2020 07:45:12 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00NCcAtY003898; Thu, 23 Jan 2020 04:45:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=X5AOSgpjJdxzXZAwFtpWGcUS1/ekd/WoU38JeRcWDlo=;
 b=tAmjBbjAkbYw7SMiJjBryzq0ytkhgHQwbMvg0Vb/ESH2IJc3wvP+/KudMJk2Welb/N7B
 3dafNVykUq021Wpul7gzitwohtN4+tjFm/P+10gk0kwuTt8DmQNdPkd3rUObNCN7qrSE
 ljT/4lin4nQ7QwUKRC3OgrXXwZ+BYTHODmIoWQMWtfrTFcW70fxvkljrWM4y1wEzdhxz
 2iRdhdnHsP9iEr/fEepaX4x3B/zJwRJnGUPVvReUV91WVdhixQsZA/v3bTnSGyMdzLRD
 8trbgqMDl2AEJpaJE6IkZg9cb1OAmBn/TyqHtGJ4vgAVyd3LQ5VA670BDii4bHzdPmrD hQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xky80ju1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2020 04:45:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyfHH2wOsuW0o7Vpyw0o5QFmBvHyrbWbUJ0VPFlw+8i5fmFaESAL31W+V5krICor4/f8v9QaEKTY9r7Zuhg3spryaKtVdXoMDWytEcpmbNHlGobljiNqvfxjn0NPOESRVg+lvyH57mgtCQKDVYFzpint6JiTh27Sdv0ZresLs2XIMQr5ptQJz2creSP3ucgujAusBZhdxgpSFdRHnVdwq3yNKqmHX1oF46svpOe75HB8Pk/jggwxe4if2+BZWAD5auBEq1sRUk83zW7hgH1yIW1GquVQH9gKeRo98Vpmt+uLLxpLlm/MiLoE76o+StL+zmpn3MKeR5xE9UBtAdIWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5AOSgpjJdxzXZAwFtpWGcUS1/ekd/WoU38JeRcWDlo=;
 b=h6Z30UDSA99WrkqFLAhFTrNbjCE7CbG2KCOKDcXE0h3V6zOZN5D+G0LRBAt4I5imSKOftaty4957f5syZmZcUbiNx+iq6GBDhxJNU22n9wIOj/72UT/OEVVxqO9e/5uu4BNm6frXECy5YnY/yBqJioQyD8MJSaAf5hLKqvyMWJ0TgufiV+3Ic2WvQLPPJTz+Li87ZgznbkptWLFPJ0oLOpLJ9dCokIoNl9PSCUF51qNhp5e1WYrdcBVPEVnndE2RLuf6+F5iMv2+rxLP97UY17gmuvscPYeJWX74Un2S7B/955sg0OolAsxZ+PB60oS6K+JgPtUo7DUOEOiPmU+4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3246.namprd02.prod.outlook.com (10.164.204.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Thu, 23 Jan 2020 12:44:59 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2644.028; Thu, 23 Jan
 2020 12:44:59 +0000
Received: from nutanix.com (62.254.189.133) by
 BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 12:44:56 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Thread-Topic: [PATCH] iscsi: Cap block count from GET LBA STATUS
 (CVE-2020-1711)
Thread-Index: AQHV0ersGiQprkLuikaxEpLUh3OweQ==
Date: Thu, 23 Jan 2020 12:44:59 +0000
Message-ID: <20200123124357.124019-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97ef5eb9-ec24-4293-795f-08d7a0020ea8
x-ms-traffictypediagnostic: MWHPR02MB3246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB324600AD1CC6F70F47B51CB5D70F0@MWHPR02MB3246.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(81156014)(8936002)(8676002)(81166006)(5660300002)(110136005)(316002)(16526019)(1076003)(54906003)(4326008)(186003)(7696005)(52116002)(86362001)(64756008)(71200400001)(2906002)(66946007)(26005)(478600001)(66476007)(66556008)(66446008)(956004)(2616005)(8886007)(7416002)(36756003)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3246;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiCZPM0oFZ48Uw1KVOKUJKbttI9B33Kkr0J4m8cXub64MIX5UYpMwoqKA1T18MiXIQa3+hRFwYWs8+qBtOFnuq/sqXi2r5mZ7WPJoImg4b6wEsil5guKJP8tCqXiHRrCFmzYJvC9Ys4baEi6dQF7r3eZXdLkkNRVbPwbHtoFb2G/WPVsGd/PS1yaHRkjQcjBzm4qDQc+sVbNKdRlrvicBYMLsRhJ+UqZSO8sEaesTn583Nan5oTA+XuMn8HhgwtnrI7mFPP+2X/Yww2a9EtZnS46t1bqsqcw9+n43CEAcjnoub2SB0b8O4tcYASHesBkrOQZLFBxsXTOi2eueYcGyh/p+YglCujr9WKeE/qmn7rKqhcxRYK/db/SX8MNaXmXXYENaH5YIoruHYQTvN0LFoAueTPJsg5JdepfLl5QeF+BPaZQvGvRIN3GSMd2MAIY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ef5eb9-ec24-4293-795f-08d7a0020ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 12:44:59.8002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9D3Fcy8vYmD9sHUG9v9jU+w+IhYFXdNNzZ4fyxaPwVxRofRIUnJxIJFTXnbnUHb6tfJCBczS+xymH0V4LXe5w/pBm54BPXl0mFJGNwbE6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3246
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-23_08:2020-01-23,
 2020-01-23 signatures=0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2hlbiBxdWVyeWluZyBhbiBpU0NTSSBzZXJ2ZXIgZm9yIHRoZSBwcm92aXNpb25pbmcgc3RhdHVz
IG9mIGJsb2NrcyAodmlhDQpHRVQgTEJBIFNUQVRVUyksIFFlbXUgb25seSB2YWxpZGF0ZXMgdGhh
dCB0aGUgcmVzcG9uc2UgZGVzY3JpcHRvciB6ZXJvJ3MNCkxCQSBtYXRjaGVzIHRoZSBvbmUgcmVx
dWVzdGVkLiBHaXZlbiB0aGUgU0NTSSBzcGVjIGFsbG93cyBzZXJ2ZXJzIHRvDQpyZXNwb25kIHdp
dGggdGhlIHN0YXR1cyBvZiBibG9ja3MgYmV5b25kIHRoZSBlbmQgb2YgdGhlIExVTiwgUWVtdSBt
YXkNCmhhdmUgaXRzIGhlYXAgY29ycnVwdGVkIGJ5IGNsZWFyaW5nL3NldHRpbmcgdG9vIG1hbnkg
Yml0cyBhdCB0aGUgZW5kIG9mDQppdHMgYWxsb2NtYXAgZm9yIHRoZSBMVU4uDQoNCkEgbWFsaWNp
b3VzIGd1ZXN0IGluIGNvbnRyb2wgb2YgdGhlIGlTQ1NJIHNlcnZlciBjb3VsZCBjYXJlZnVsbHkg
cHJvZ3JhbQ0KUWVtdSdzIGhlYXAgKGJ5IHNlbGVjdGl2ZWx5IHNldHRpbmcgdGhlIGJpdG1hcCkg
YW5kIHRoZW4gc21hc2ggaXQuDQoNClRoaXMgbGltaXRzIHRoZSBudW1iZXIgb2YgYml0cyB0aGF0
IGlzY3NpX2NvX2Jsb2NrX3N0YXR1cygpIHdpbGwgdHJ5IHRvDQp1cGRhdGUgaW4gdGhlIGFsbG9j
bWFwIHNvIGl0IGNhbid0IG92ZXJmbG93IHRoZSBiaXRtYXAuDQoNClNpZ25lZC1vZmYtYnk6IEZl
bGlwZSBGcmFuY2lvc2kgPGZlbGlwZUBudXRhbml4LmNvbT4NClNpZ25lZC1vZmYtYnk6IFBldGVy
IFR1cnNjaG1pZCA8cGV0ZXIudHVyc2NobUBudXRhbml4LmNvbT4NClNpZ25lZC1vZmYtYnk6IFJh
cGhhZWwgTm9yd2l0eiA8cmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tPg0KLS0tDQogYmxvY2sv
aXNjc2kuYyB8IDUgKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYmxvY2svaXNjc2kuYyBiL2Jsb2NrL2lzY3NpLmMN
CmluZGV4IDJhZWE3ZTNmMTMuLmNiZDU3Mjk0YWIgMTAwNjQ0DQotLS0gYS9ibG9jay9pc2NzaS5j
DQorKysgYi9ibG9jay9pc2NzaS5jDQpAQCAtNzAxLDcgKzcwMSw3IEBAIHN0YXRpYyBpbnQgY29y
b3V0aW5lX2ZuIGlzY3NpX2NvX2Jsb2NrX3N0YXR1cyhCbG9ja0RyaXZlclN0YXRlICpicywNCiAg
ICAgc3RydWN0IHNjc2lfZ2V0X2xiYV9zdGF0dXMgKmxiYXMgPSBOVUxMOw0KICAgICBzdHJ1Y3Qg
c2NzaV9sYmFfc3RhdHVzX2Rlc2NyaXB0b3IgKmxiYXNkID0gTlVMTDsNCiAgICAgc3RydWN0IElz
Y3NpVGFzayBpVGFzazsNCi0gICAgdWludDY0X3QgbGJhOw0KKyAgICB1aW50NjRfdCBsYmEsIG1h
eF9ieXRlczsNCiAgICAgaW50IHJldDsNCiANCiAgICAgaXNjc2lfY29faW5pdF9pc2NzaXRhc2so
aXNjc2lsdW4sICZpVGFzayk7DQpAQCAtNzIxLDYgKzcyMSw3IEBAIHN0YXRpYyBpbnQgY29yb3V0
aW5lX2ZuIGlzY3NpX2NvX2Jsb2NrX3N0YXR1cyhCbG9ja0RyaXZlclN0YXRlICpicywNCiAgICAg
fQ0KIA0KICAgICBsYmEgPSBvZmZzZXQgLyBpc2NzaWx1bi0+YmxvY2tfc2l6ZTsNCisgICAgbWF4
X2J5dGVzID0gKGlzY3NpbHVuLT5udW1fYmxvY2tzIC0gbGJhKSAqIGlzY3NpbHVuLT5ibG9ja19z
aXplOw0KIA0KICAgICBxZW11X211dGV4X2xvY2soJmlzY3NpbHVuLT5tdXRleCk7DQogcmV0cnk6
DQpAQCAtNzY0LDcgKzc2NSw3IEBAIHJldHJ5Og0KICAgICAgICAgZ290byBvdXRfdW5sb2NrOw0K
ICAgICB9DQogDQotICAgICpwbnVtID0gKGludDY0X3QpIGxiYXNkLT5udW1fYmxvY2tzICogaXNj
c2lsdW4tPmJsb2NrX3NpemU7DQorICAgICpwbnVtID0gTUlOKChpbnQ2NF90KSBsYmFzZC0+bnVt
X2Jsb2NrcyAqIGlzY3NpbHVuLT5ibG9ja19zaXplLCBtYXhfYnl0ZXMpOw0KIA0KICAgICBpZiAo
bGJhc2QtPnByb3Zpc2lvbmluZyA9PSBTQ1NJX1BST1ZJU0lPTklOR19UWVBFX0RFQUxMT0NBVEVE
IHx8DQogICAgICAgICBsYmFzZC0+cHJvdmlzaW9uaW5nID09IFNDU0lfUFJPVklTSU9OSU5HX1RZ
UEVfQU5DSE9SRUQpIHsNCi0tIA0KMi4yMC4xDQoNCg==

