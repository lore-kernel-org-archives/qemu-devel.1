Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C544EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941EE207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ye/x4atV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941EE207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGRV-00063x-4o
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iZGPp-0004PO-LY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iZGPn-0007ot-SJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:11474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iZGPn-0007ma-Le
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:39 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAPFVZQm009323; Mon, 25 Nov 2019 07:36:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=zCyD9kV+lvGUqlwQnxGo6W7BjOD17bvbwHPFHFIU9fs=;
 b=Ye/x4atVTA/cxBv53Gif6xX2Nf7TaMmA/jhFSicrr6RuUAuBHCB62govky0m4uLo6Z+6
 Xv6AekXjyHCA7AtgL+JH0G9CCXvxzYAFkp2KExq1hXRAfzUl6bgThwKV+ZX4EhnSBENl
 o5AjIP3dnZ/Ai7e0rGrV/OnWJuqPL26GxlCBK6ZchXdA0NP4Nd79+DAlxjwhfM/Yf1z8
 MCJEJ0hYIfYCWQpvrcKDqGIyr9RVn/rK4qBEHYEjuOesnFaVPwDB04JAvUiF8ex8Wmv/
 aT9lv0CWCqOFMUL7GjRXwTSdq/EdVRA4HPE+WQmbC938Lc3eWhwLfL5doQ2hj+rLzMUP bA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wf4yn3unm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2019 07:36:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIh6/pAN7e/MN96miOyx/GLyIiig6YG1On6Sv+4uATZLJERXAkP55FiVT8UMaWN+sU1cANdacXMdgyGTrKlmrCsmpPid+dpi1ZoEYGheVZzCIJrMp0QxRasWVIpwpGvhz1L3rZTfwwLnv0ckHfMXI183u7HSExHrYgqeGjPa8Av0gz+5i3gdKfKHQ7xVZUZmwJg0ozS5oqwc0BOVrmCkemH/CEMzUNW+GuYqnnVPaWvh/iobUl0y3NbOQMTlEsAY4Fv1q0m7KozJRXN0J6/s/LknnQ4J5vMrgTtdwC3LAbUXiuI2wtNu/gWiNVLyZ0fYN6MqIiXLP9r1fpfn2Mx6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCyD9kV+lvGUqlwQnxGo6W7BjOD17bvbwHPFHFIU9fs=;
 b=KCoxmm1OwG5XIT/b4MjxZ77Phg5Ls2+Av4DdLgahqtZUClCst6hzXHNJG7lFaL/Pb/PhfuEpXTbinhtsYzuFavKKH6p6p50MjvcynknpY6cr24UoPtusVHbTsIcGrSebgQoDQYZ4ANhX7866j2v4oEHZN66FwcP80BzkIQYFCtzoeENhTJ7joqzfpW9cIEQ3+qEZh9XXjxgtmdorgWtBRyCwnE0hoTbKZJGJuYEWgPEyqRxmA65VulHbYyCUTkhvUQe4TCKGzZCqxgOicXVyajizqiTAOYbb8Z4Nf4xOvLWrKM1W5/n6b+j1xz2kh90plpk1hN8bVBUh28qvG7PsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3183.namprd02.prod.outlook.com (10.164.133.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 15:36:34 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:36:34 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVo6YefpPRqMssQki98wdtNKpYLw==
Date: Mon, 25 Nov 2019 15:36:34 +0000
Message-ID: <20191125153619.39893-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b68fa64-8574-403d-b723-08d771bd40a3
x-ms-traffictypediagnostic: MWHPR02MB3183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB31837177705BC80498FFECF1D74A0@MWHPR02MB3183.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(4326008)(6512007)(86362001)(1076003)(3846002)(6116002)(386003)(6506007)(7736002)(305945005)(6436002)(6486002)(478600001)(54906003)(26005)(102836004)(110136005)(2906002)(36756003)(25786009)(14454004)(316002)(99286004)(256004)(107886003)(66066001)(66446008)(64756008)(66556008)(66476007)(2616005)(5660300002)(66946007)(186003)(52116002)(50226002)(81166006)(81156014)(8676002)(71200400001)(8936002)(71190400001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3183;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9hrMfeqKwqBLZwC8juc0Dc25zdZvx0X1Zl4tCL5ByqJsb4qPCpfH3Yo/CYATAZUfurw+U733f30MmCm5YugvF/GdXoAukkuLp3ueqpxB8md2RUTKf7jHwAKrC/QUxa76iCTEEVcBiLRhwcZrwUv0kpdkQUUOdd7dvLNasrUL6Dn6xIqW4uCxn0XgNKtxnAy3COw5fUH5qOLVoc3Kw9NeChkh//71T7gf8i69fuzKPXTLqmL4jylTagbuhHllDIuqKXLShGo3p4FM8NqR/4+OGDpkUAGMZAKORBQ292WRNHTY3DiYvHdBv/5aaUmE+TlIqTjmjWB6g0dEFLsz2y7jR6c+v/KGDGVcI0vqXkC5D17UTybUQIMs7gB+LvaeDerwaJTNdUI6Gb70E21dmvHdanVbwFAydpIEnn0sFH06mZ/zQEn8kuiwlwtLROIqb6VS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b68fa64-8574-403d-b723-08d771bd40a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:36:34.4732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryeytVi3l1Ug8x+vj8kNeVds4RQceS+YohFpAvlhZye3CP699N2QueUloIHp7HUS+zNegJHuuzSO4uORV6V32GyWXVgEbgV6uZEk6QwdZws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_03:2019-11-21,2019-11-25 signatures=0
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
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBpbXByb3ZlcyB0aGUgZmFtaWx5IG9mIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWludFhYX3B0
ciBoZWxwZXJzIGJ5IGVuYWJsaW5nDQphIGRlZmF1bHQgc2V0dGVyIHdoZW4gZGVzaXJlZC4gVG8g
cHJldmVudCBhbiBBUEkgYmVoYXZpb3VyYWwgY2hhbmdlIChmcm9tDQpjbGllbnRzIHRoYXQgYWxy
ZWFkeSB1c2VkIHRoZXNlIGhlbHBlcnMgYW5kIGRpZCBub3Qgd2FudCBhIHNldHRlciksIHdlIGFk
ZCBhDQoicmVhZG9ubHkiIHBhcmFtZXRlciB0aGF0IGFsbG93IGNsaWVudHMgdG8gb25seSBoYXZl
IGEgZ2V0dGVyLiBQYXRjaCAxIGVuaGFuY2VzDQp0aGUgQVBJIGFuZCBtb2RpZnkgY3VycmVudCB1
c2Vycy4NCg0KV2hpbGUgbW9kaWZ5aW5nIHRoZSBjbGllbnRzIG9mIHRoZSBBUEksIGEgY291cGxl
IG9mIGltcHJvdmVtZW50IG9wcG9ydHVuaXRpZXMNCndlcmUgb2JzZXJ2ZWQgaW4gaWNoOS4gVGhl
c2Ugd2VyZSBhZGRlZCBpbiBzZXBhcmF0ZSBwYXRjaGVzICgyIGFuZCAzKS4NCg0KUGF0Y2ggMyBj
bGVhbnMgdXAgYSBsb3Qgb2YgZXhpc3RpbmcgY29kZSBieSBtb3ZpbmcgdmFyaW91cyBvYmplY3Rz
IHRvIHRoZQ0KZW5oYW5jZWQgQVBJLiBQcmV2aW91c2x5LCB0aG9zZSBvYmplY3RzIGhhZCB0aGVp
ciBvd24gZ2V0dGVycy9zZXR0ZXJzIHRoYXQgb25seQ0KdXBkYXRlZCB0aGUgdmFsdWVzIHdpdGhv
dXQgZnVydGhlciBjaGVja3MuIFNvbWUgb2YgdGhlbSBhY3R1YWxseSBsYWNrZWQgYSBjaGVjaw0K
Zm9yIHNldHRpbmcgb3ZlcmZsb3dzLCB3aGljaCBjb3VsZCBoYXZlIHJlc3VsdGVkIGluIHVuZGVz
aXJlZCB2YWx1ZXMgYmVpbmcgc2V0Lg0KVGhlIG5ldyBkZWZhdWx0IHNldHRlcnMgaW5jbHVkZSBh
IGNoZWNrIGZvciB0aGF0LCBub3QgdXBkYXRpbmcgdGhlIHZhbHVlcyBpbg0KY2FzZSBvZiBlcnJv
cnMgKGFuZCBwcm9wYWdhdGluZyB0aGVtKS4NCg0KRmVsaXBlIEZyYW5jaW9zaSAoNCk6DQogIHFv
bS9vYmplY3Q6IGVuYWJsZSBzZXR0ZXIgZm9yIHVpbnQgdHlwZXMNCiAgaWNoOTogZml4IGdldHRl
ciB0eXBlIGZvciBzY2lfaW50IHByb3BlcnR5DQogIGljaDk6IFNpbXBsaWZ5IGljaDlfbHBjX2lu
aXRmbg0KICBxb20vb2JqZWN0OiBVc2UgY29tbW9uIGdldC9zZXQgdWludCBoZWxwZXJzDQoNCiBo
dy9hY3BpL2ljaDkuYyAgICAgICB8ICA5NyArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBo
dy9hY3BpL3BjaWhwLmMgICAgICB8ICAgNiArLQ0KIGh3L2FjcGkvcGlpeDQuYyAgICAgIHwgIDEy
ICsrLS0NCiBody9pc2EvbHBjX2ljaDkuYyAgICB8ICAzMSArKystLS0tLS0NCiBody9taXNjL2Vk
dS5jICAgICAgICB8ICAxMiArLS0tDQogaHcvcGNpLWhvc3QvcTM1LmMgICAgfCAgMTQgKy0tLQ0K
IGh3L3BwYy9zcGFwci5jICAgICAgIHwgIDE3ICstLS0tDQogaHcvcHBjL3NwYXByX2RyYy5jICAg
fCAgIDIgKy0NCiBody92ZmlvL3BjaS1xdWlya3MuYyB8ICAxOCArKy0tLQ0KIGluY2x1ZGUvcW9t
L29iamVjdC5oIHwgIDI4ICsrKysrLS0tDQogbWVtb3J5LmMgICAgICAgICAgICAgfCAgMTUgKy0t
LS0NCiBxb20vb2JqZWN0LmMgICAgICAgICB8IDE1MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tDQogdGFyZ2V0L2FybS9jcHUuYyAgICAgfCAgMjEgKy0tLS0tDQog
dGFyZ2V0L2kzODYvc2V2LmMgICAgfCAxMDIgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CiB1aS9jb25zb2xlLmMgICAgICAgICB8ICAgMyArLQ0KIDE1IGZpbGVzIGNoYW5nZWQsIDE5NiBp
bnNlcnRpb25zKCspLCAzMzQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMC4xDQoNCg==

