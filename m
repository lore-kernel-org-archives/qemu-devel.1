Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E31C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2B3227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="z57kcDvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2B3227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0CN-0000dl-35
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ii08E-00042N-S4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ii08C-0002NM-Ij
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:18224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ii08C-0002IM-74
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:36 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJHx8QK020335; Thu, 19 Dec 2019 10:02:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=uJ0QaDZGqgCnR/RxrQdjYjk2mH9M4h92LqEhItEj/f0=;
 b=z57kcDvKD0OlyEJRXaKCFDufyPy/4LIJ3OJPtylGvunz10moeWfsG9QTuuJQTbZmAPt+
 yvK2Ldi58WFWxiKSzbfStw0hft7OKW6Kdt1pD56jRZJ/VKt+drsQADrHpKtzmI+96BT/
 oH48O5rkyIc75d70fk4G0Xqdika0pTVkMUkqF7K37/0TsUIqLSW5oZkaolmsFgZZ9Iny
 LlkxyiYh1vhtaDMpQPqyi9fktOo6lrrKB0LHnd3m6FUeKrqmJ/pHiwQZQ2mt/ierzGS7
 7KR+nGn8EX2TQuBc+aPDPqnDL1UQrHND+74KWNL+QTrpOBtKX/NNKgOqj+9SAjRV4Vku 7w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2ww0643bw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 10:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHT5pNkftctn27Y+1Snia4dCLO0azctToLBurQDOPYJtJES/IU2oAhAY4Pi5fCiNZYFjSP4o/I0TaJG5CcSKVMuWt37QZ8I5a+Q6z2t5WFhWVxKtQ1+hxDmWt3qt3YHoBVrBxDLtLhufrewRI4siRvuiK2ITGUCyU5iMoJm5UWO53tsu/TvoZQguQ7ajRZtDQOnWfltDWE4TA5efGFtAI+22j5n5jqZlk0s+nE47rR60WBZ/jt6j1pj69YvsEOAODCyDhsl50dSWOl7SxyHkc+HnUUMrUTaOGXNKrmr3geJJIU3fbmjSTjPyymymbiXAcCA1Vq20LJnEcLp1hj3dYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ0QaDZGqgCnR/RxrQdjYjk2mH9M4h92LqEhItEj/f0=;
 b=INdrBOuXZXBBndnQsoy834b7pDn2M6I2GA2nVTQb07Ux2qXsLzC7Xpg3upR9FRSQmuhZDSJWotTOxsTueLypNG2rVxV6SE62yE7aWnAJ2ZuU1YDPGSFDzAKzXYa0rAgKRq7pDwanAhbFl3leBwZCMYXHPfCwHsdLFsRbA+GK1WCzaUmTiEV1Lm4B8Ve/Z2dnF/417z3k6zZ9gqhiyByR6ilRklxj0TmZtpVac2xMukXOwdu5MsRVa07M1Pn+ChvQLmtgUHO1dWfXpPfkgz6DR5Z1QUhMisxVrSzrgsJD68Ovl9wqcrsURHK4XpyxVNJxOy24i61pw3H/NZiuke2zNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3166.namprd02.prod.outlook.com (10.164.204.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 18:02:28 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 18:02:28 +0000
Received: from nutanix.com (82.9.225.166) by
 AM4PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:205:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.4 via Frontend Transport; Thu, 19 Dec 2019 18:02:26 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Phillipe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVtpZ6lIuRGF0HJ0OIoqz7XKz+ug==
Date: Thu, 19 Dec 2019 18:02:28 +0000
Message-ID: <20191219180205.25191-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:205:1::17) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 818d5a0b-a8c7-4b6e-453c-08d784ad9c5d
x-ms-traffictypediagnostic: MWHPR02MB3166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3166174FA5947F46A1DF7065D7520@MWHPR02MB3166.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(54534003)(199004)(189003)(956004)(2616005)(86362001)(5660300002)(52116002)(26005)(64756008)(66446008)(7696005)(36756003)(4326008)(107886003)(8886007)(478600001)(55016002)(316002)(186003)(16526019)(8936002)(1076003)(66476007)(66946007)(81156014)(66556008)(54906003)(81166006)(8676002)(71200400001)(2906002)(110136005)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3166;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ZPmNnEQNawpAJtFeRRresHsHom1x51cTsh9g23LvKdReTJogCBY/quFDhdOfke5EJ03fXX3PzqfETkug23fcQ/yqinrgU+5zTAsUTybpWh6PIMxuWBbQedj+/wDwOG//0srkZVqEd8WHSZKMSUG5bykLKXmWTT/4uOG4kvEoFJan/ApThpoMxXULCfx1Ek282ZLGjyEi2X6v4UfVYp02hqgxJECxId3Vi1uzFBQdcqaSY+QC990NAgRy1YOyThdHDxn/i6mQG8dXbYpmNeWkQHiWWofmxNvOad87RZB/w2n0B9tD8M++1m5JyPQCxZMAUzWaPpaxzyP1hLYdPe7LJ5Gq54/QGExwYaM82/GdzIfzuBlROqpRF7sxKahZ56oFiDJqWZAA+WDQX/ZBijYY2BktrM46tH0hAGpiQjyEbiieqLXX7CXZ8VsNl/CZovopC065LR9GfzNnM49a7FhZAEQGESGXcFZI5T3BhsNCa4VE12IN4OZ3aGqqCuIbDPkpi3TsTSIjCyeGxB2TiVq7g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818d5a0b-a8c7-4b6e-453c-08d784ad9c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 18:02:28.7519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rq44hgpYST+lkrt/Tz8bhX7nbAn+sKELEpIx0r9qZ7ALbRjVUVIYwfhSxoo5+9G7zw+U34CBJPZTgjW5LV4/u23uTsBnaVik4Y+vyo55nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3166
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_06:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBpbXByb3ZlcyB0aGUgZmFtaWx5IG9mIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWludFhYX3B0
ciBoZWxwZXJzIGJ5IGVuYWJsaW5nDQphIGRlZmF1bHQgZ2V0dGVyL3NldHRlciBvbmx5IHdoZW4g
ZGVzaXJlZC4gVG8gcHJldmVudCBhbiBBUEkgYmVoYXZpb3VyYWwgY2hhbmdlDQooZnJvbSBjbGll
bnRzIHRoYXQgYWxyZWFkeSB1c2VkIHRoZXNlIGhlbHBlcnMgYW5kIGRpZCBub3Qgd2FudCBhIHNl
dHRlciksIHdlDQphZGQgYSBPQkpfUFJPUF9GTEFHX1JFQUQgZmxhZyB0aGF0IGFsbG93IGNsaWVu
dHMgdG8gb25seSBoYXZlIGEgZ2V0dGVyLiBQYXRjaCAxDQplbmhhbmNlcyB0aGUgQVBJIGFuZCBt
b2RpZnkgY3VycmVudCB1c2Vycy4NCg0KV2hpbGUgbW9kaWZ5aW5nIHRoZSBjbGllbnRzIG9mIHRo
ZSBBUEksIGEgY291cGxlIG9mIGltcHJvdmVtZW50IG9wcG9ydHVuaXRpZXMNCndlcmUgb2JzZXJ2
ZWQgaW4gaWNoOS4gVGhlc2Ugd2VyZSBhZGRlZCBpbiBzZXBhcmF0ZSBwYXRjaGVzICgyIGFuZCAz
KS4NCg0KUGF0Y2ggMyBjbGVhbnMgdXAgYSBsb3Qgb2YgZXhpc3RpbmcgY29kZSBieSBtb3Zpbmcg
dmFyaW91cyBvYmplY3RzIHRvIHRoZQ0KZW5oYW5jZWQgQVBJLiBQcmV2aW91c2x5LCB0aG9zZSBv
YmplY3RzIGhhZCB0aGVpciBvd24gZ2V0dGVycy9zZXR0ZXJzIHRoYXQgb25seQ0KdXBkYXRlZCB0
aGUgdmFsdWVzIHdpdGhvdXQgZnVydGhlciBjaGVja3MuIFNvbWUgb2YgdGhlbSBhY3R1YWxseSBs
YWNrZWQgYSBjaGVjaw0KZm9yIHNldHRpbmcgb3ZlcmZsb3dzLCB3aGljaCBjb3VsZCBoYXZlIHJl
c3VsdGVkIGluIHVuZGVzaXJlZCB2YWx1ZXMgYmVpbmcgc2V0Lg0KVGhlIG5ldyBkZWZhdWx0IHNl
dHRlcnMgaW5jbHVkZSBhIGNoZWNrIGZvciB0aGF0LCBub3QgdXBkYXRpbmcgdGhlIHZhbHVlcyBp
bg0KY2FzZSBvZiBlcnJvcnMgKGFuZCBwcm9wYWdhdGluZyB0aGVtKS4gSWYgdGhleSBkaWQgbm90
IHByb3ZpZGUgYW4gZXJyb3INCnBvaW50ZXIsIHRoZW4gdGhhdCBiZWhhdmlvdXIgd2FzIG1haW50
YWluZWQuDQoNCkZlbGlwZSBGcmFuY2lvc2kgKDQpOg0KICBxb20vb2JqZWN0OiBlbmFibGUgc2V0
dGVyIGZvciB1aW50IHR5cGVzDQogIGljaDk6IGZpeCBnZXR0ZXIgdHlwZSBmb3Igc2NpX2ludCBw
cm9wZXJ0eQ0KICBpY2g5OiBTaW1wbGlmeSBpY2g5X2xwY19pbml0Zm4NCiAgcW9tL29iamVjdDog
VXNlIGNvbW1vbiBnZXQvc2V0IHVpbnQgaGVscGVycw0KDQogaHcvYWNwaS9pY2g5LmMgICAgICAg
fCAgOTkgKystLS0tLS0tLS0tLS0tLS0tLS0NCiBody9hY3BpL3BjaWhwLmMgICAgICB8ICAgNyAr
LQ0KIGh3L2FjcGkvcGlpeDQuYyAgICAgIHwgIDEyICstLQ0KIGh3L2lzYS9scGNfaWNoOS5jICAg
IHwgIDI3ICsrLS0tLQ0KIGh3L21pc2MvZWR1LmMgICAgICAgIHwgIDEzICstLQ0KIGh3L3BjaS1o
b3N0L3EzNS5jICAgIHwgIDE0ICstLQ0KIGh3L3BwYy9zcGFwci5jICAgICAgIHwgIDE4ICstLS0N
CiBody9wcGMvc3BhcHJfZHJjLmMgICB8ICAgMyArLQ0KIGluY2x1ZGUvcW9tL29iamVjdC5oIHwg
IDQ0ICsrKysrKystLQ0KIG1lbW9yeS5jICAgICAgICAgICAgIHwgIDE1ICstLQ0KIHFvbS9vYmpl
Y3QuYyAgICAgICAgIHwgMjE2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0NCiB0YXJnZXQvYXJtL2NwdS5jICAgICB8ICAyMiArLS0tLQ0KIHRhcmdldC9pMzg2L3Nl
di5jICAgIHwgMTA2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIHVpL2NvbnNvbGUuYyAgICAgICAg
IHwgICA0ICstDQogMTQgZmlsZXMgY2hhbmdlZCwgMjgyIGluc2VydGlvbnMoKyksIDMxOCBkZWxl
dGlvbnMoLSkNCg0KLS0gDQoyLjIwLjENCg0KQ2hhbmdlbG9nOg0KdjEtPnYyOg0KLSBVcGRhdGUg
c2NpX2ludCBkaXJlY3RseSBpbnN0ZWFkIG9mIHVzaW5nIHN0YWNrIHZhcmlhYmxlDQotIERlZmlu
aW5nIGFuIGVuaGFuY2VkIE9iamVjdFByb3BlcnR5RmxhZ3MgaW5zdGVhZCBvZiBqdXN0ICdyZWFk
b25seScNCi0gRXJyb3Jpbmcgb3V0IGRpcmVjdGx5IChpbnN0ZWFkIG9mIHVzaW5nIGdvdG9zKSBv
biBkZWZhdWx0IHNldHRlcnMNCi0gUmV0YWluaW5nIGxhY2sgb2YgZXJycCBwYXNzaW5nIHdoZW4g
aXQgd2Fzbid0IHRoZXJlDQp2Mi0+djM6DQotIFJlbmFtZSBmbGFncyBfUkQgdG8gX1JFQUQgYW5k
IF9XUiB0byBfV1JJVEUNCi0gQWRkIGEgY29udmVuaWVuY2UgX1JFQURXUklURSBmbGFnDQotIERy
b3AgdGhlIHVzYWdlIG9mIFVMIGluIHRoZSBiaXQgZmxhZyBkZWZpbml0aW9ucw0KdjMtPnY0Og0K
LSBEcm9wIGNoYW5nZXMgdG8gaHcvdmZpby9wY2ktcXVpcmtzLmMNCg==

