Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC13C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 17:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8331E2158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 17:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Shfyj6xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8331E2158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iakTn-0006QH-PV
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 12:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iakM7-0001sB-8V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iakM3-00006l-HN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:46:56 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:52214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iakM3-0008QL-5R
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:46:55 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATHfgPo014251; Fri, 29 Nov 2019 09:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=9pCAEP83Kq5qR/IQmBdSypK1yhBUiE3yE+vc2+m3QQ0=;
 b=Shfyj6xmksu88M5CAVqIqI6b4+01MZnd5yVrtZlraxbddPWNxYkvZm7cxpqUgFW4IqEa
 2PuKwYSDFswbnb7W4rxKMfzF/lzk9hzbtmafQmi98A2UldhW0OCHt2rGPmb+FK+lqbyC
 6LBF/2hFs7Ynd6YDduf8Q7hmMNMVJtpVHlMt1yeAX169Tkjqlk/cO0GzIk5FASVSC1GA
 2Gyj/JBz6di2ui4P9arnauUdMFWJfMlkAtXHHa/Jta3SNCzBOE7glX0KRKqEnGcs/6m0
 f1HnbLOzPpp0CSkeV8zyZv4FhmG0lZ0Jha2b7+g8TY+RZ/3OzHTfn4hU6ISfKDtVTG5O mg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2whjspd8t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Nov 2019 09:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JomzIyaYS5jnT/gnrRXZlsDdSRNQzBxJr8cyCaK9gV4H1/M4J4IYC5DAhc2vy+UFhwDeHyzdg581g7/MgtFDNR32213+DtJUPqsDaB4VaxXthC9u2ppt+bkbWis4fv9OYy5NVfWe9hWybo3hqAv2XAwR2IDTYGUao942pljYb07P66JAz8XQbH7ohqGqgoemOnHW62GnQxqSA5McCzdDanjBt0goQalqTBQ0I09RobQAheUVQtR2JQ2lMYhgtoCNoWSJWtsXtzLrGijSaKiWfC/C7Ea8oYIpgdQrHKrtvg5U2tR8NGXa5ajbw2L9veiqAo3l6JHpC07VZ+t7XT0u6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pCAEP83Kq5qR/IQmBdSypK1yhBUiE3yE+vc2+m3QQ0=;
 b=QSpi1Fd1tYkRvNgAZouiz8iEHj7bEZ/VCYoL7znZd6b/phbCgd2kp79KOc800HuIl7dnq+Pdui/YIGiT8+lNLEWVdMQ9I7WTD0azAt0Ol/uhyvWF49QO+KMqTGnklMPz1xcgARdZruNs1zqD1HRP+NFkbfGXDCTc4vHAiOuYgNhyZQ7ae681tcJU6HpOQ5cOKitrbPCityJSIODOHNAw23ahHTiLYHoX3i0EjHQMQvfdcpgfPRFRiBwg7kCu0up+glxosykeXgUZ+flT6J8T6qJhsGoiGZwIu6kt1oPqBKemqQT3GYIwbkyrGcshuhClmK2ehE2Uc+axK9Hvo6ToIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2239.namprd02.prod.outlook.com (10.168.244.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 29 Nov 2019 17:46:48 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 17:46:47 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Philippe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v3 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v3 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVptz4rBlibBI7cEa+Iv11MbbnrA==
Date: Fri, 29 Nov 2019 17:46:47 +0000
Message-ID: <20191129174630.6922-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edb4553f-eed7-4397-6171-08d774f41b3b
x-ms-traffictypediagnostic: MWHPR02MB2239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2239140D2B2EB1CDAF61777ED7460@MWHPR02MB2239.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(54534003)(199004)(189003)(386003)(66946007)(66476007)(305945005)(64756008)(6506007)(66556008)(6486002)(5660300002)(14444005)(6512007)(25786009)(7736002)(66446008)(1076003)(36756003)(52116002)(66066001)(256004)(6436002)(71190400001)(186003)(26005)(86362001)(8936002)(110136005)(4326008)(54906003)(14454004)(102836004)(71200400001)(99286004)(81166006)(50226002)(6116002)(316002)(2906002)(478600001)(2616005)(81156014)(3846002)(8676002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2239;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QmFnnj5aIR07E3YQP1wDpmDFACgjOD8Nn9FImWvzAIUBUKojAvttxUHHP0zTanxSnfMZA91KDbXR3EqbfRDidfLOsiGhpHbpxaehy9J5/z0ACS88ZWl0eYSaT7ANe6wJdPZjPxTrC+rcKo2A05/tT6bBjYF+UyTFMxtQrc3nKV31cazp6rIbnBtN0769REyRO2Jcxxka1n265U7ioNRGNqfLLd7BDE9egui7D9jXoTRqz6/AjZJxQ8lQ1C978PXOyesx+/CzcdINvzj1sLIwroGASCcBpngnm5KLf5Fz+9Mqd8ZXapfpAKBl4RGHkQ0l+IpDMJp+4/ci5USplhQlUdbSmZMYTr9qdv3qwUBUBT68ZxwaiinSVud19701F/xmMK9g7DyAP+SnPxyYfxrf8v6eUMhQVPyo/QPFaCuSSdflmP56h6ZQe5SCX5VSFKKs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb4553f-eed7-4397-6171-08d774f41b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 17:46:47.7251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjCLiitNBAVT+vluJ1wudQV8qMaOMPope4pZZuYF8zZsVimghYx9VBlWHlq8Fu/KVp6zmJoNcGGys3EiT4jKvFi09a1qb6qX0AtVPCO6DMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_05:2019-11-29,2019-11-29 signatures=0
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
YWluZWQuDQoNCg0KRmVsaXBlIEZyYW5jaW9zaSAoNCk6DQogIHFvbS9vYmplY3Q6IGVuYWJsZSBz
ZXR0ZXIgZm9yIHVpbnQgdHlwZXMNCiAgaWNoOTogZml4IGdldHRlciB0eXBlIGZvciBzY2lfaW50
IHByb3BlcnR5DQogIGljaDk6IFNpbXBsaWZ5IGljaDlfbHBjX2luaXRmbg0KICBxb20vb2JqZWN0
OiBVc2UgY29tbW9uIGdldC9zZXQgdWludCBoZWxwZXJzDQoNCiBody9hY3BpL2ljaDkuYyAgICAg
ICB8ICA5OSArKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIGh3L2FjcGkvcGNpaHAuYyAgICAgIHwgICA3
ICstDQogaHcvYWNwaS9waWl4NC5jICAgICAgfCAgMTIgKy0tDQogaHcvaXNhL2xwY19pY2g5LmMg
ICAgfCAgMjcgKystLS0tDQogaHcvbWlzYy9lZHUuYyAgICAgICAgfCAgMTMgKy0tDQogaHcvcGNp
LWhvc3QvcTM1LmMgICAgfCAgMTQgKy0tDQogaHcvcHBjL3NwYXByLmMgICAgICAgfCAgMTggKy0t
LQ0KIGh3L3BwYy9zcGFwcl9kcmMuYyAgIHwgICAzICstDQogaHcvdmZpby9wY2ktcXVpcmtzLmMg
fCAgMjAgKystLQ0KIGluY2x1ZGUvcW9tL29iamVjdC5oIHwgIDQ0ICsrKysrKystLQ0KIG1lbW9y
eS5jICAgICAgICAgICAgIHwgIDE1ICstLQ0KIHFvbS9vYmplY3QuYyAgICAgICAgIHwgMjE2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCiB0YXJnZXQvYXJtL2Nw
dS5jICAgICB8ICAyMiArLS0tLQ0KIHRhcmdldC9pMzg2L3Nldi5jICAgIHwgMTA2ICsrLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KIHVpL2NvbnNvbGUuYyAgICAgICAgIHwgICA0ICstDQogMTUgZmlsZXMg
Y2hhbmdlZCwgMjg4IGluc2VydGlvbnMoKyksIDMzMiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIw
LjENCg0KQ2hhbmdlbG9nOg0KdjEtPnYyOg0KLSBVcGRhdGUgc2NpX2ludCBkaXJlY3RseSBpbnN0
ZWFkIG9mIHVzaW5nIHN0YWNrIHZhcmlhYmxlDQotIERlZmluaW5nIGFuIGVuaGFuY2VkIE9iamVj
dFByb3BlcnR5RmxhZ3MgaW5zdGVhZCBvZiBqdXN0ICdyZWFkb25seScNCi0gRXJyb3Jpbmcgb3V0
IGRpcmVjdGx5IChpbnN0ZWFkIG9mIHVzaW5nIGdvdG9zKSBvbiBkZWZhdWx0IHNldHRlcnMNCi0g
UmV0YWluaW5nIGxhY2sgb2YgZXJycCBwYXNzaW5nIHdoZW4gaXQgd2Fzbid0IHRoZXJlDQp2Mi0+
djM6DQotIFJlbmFtZSBmbGFncyBfUkQgdG8gX1JFQUQgYW5kIF9XUiB0byBfV1JJVEUNCi0gQWRk
IGEgY29udmVuaWVuY2UgX1JFQURXUklURSBmbGFnDQotIERyb3AgdGhlIHVzYWdlIG9mIFVMIGlu
IHRoZSBiaXQgZmxhZyBkZWZpbml0aW9ucw0K

