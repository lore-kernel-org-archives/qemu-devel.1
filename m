Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB315C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1EE21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="PigTDOgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1EE21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOcV-0003ZB-Kh
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iaMyI-0002k9-Kc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iaMyF-0002Gt-Tk
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:49 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:14156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iaMyD-0002AS-Ty
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:47 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASGfY7J031304; Thu, 28 Nov 2019 08:48:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=n7/1w7+F8DmWgNdZlsQxq3sdoTsPo3sX1PfD8oIKTw4=;
 b=PigTDOgXREy2rTURLn8su1imTV7SO4AdBkyK7TpKluD+f1r3y1d/9X87zsIeaU+h2f+t
 naBMIBodTBzXnlYhmcA7NJ3swRcrOLl9oMziJeg9R1o4ZPUVG9T9X0y5hr3rfUZQ7swS
 UdD5jJ55noWpV4pkZtWbTgO8w5W2I+ev8MSG1AwGzqW0F3RrDGK+eTseKP2jkitX+NSz
 6fDy/g0lil1VCy3alTu92uWXOoJ8JrP+H0AVJVsqaOZAzcyDHIdQvRPO2AyIdef7uzdq
 OI/5iMgK7e3SEeJ5tzaCj8bIDXnKPuSGg9Z9NiSIGfO34TFG3k2MLsQbL5OEyLnv6K4f 6Q== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2whjspbe12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Nov 2019 08:48:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGlTgAkWRuCm6HIGQAY6xcI9KOS14X0XmkqOVSP6jxk4MqarHW8IuBqeo4vj4z6IaiD94BS7Fywb/j/ae0HIpoUllpLbr9yYQVYIXn6dzFobNFT5OYsEfoF5Zcz1QzEpEA/zPDctqDgPalUHy9HjmNRg6h8Z1iS3XuWcOTZU92I+XGbPhudd/uks8i1PVLNPo8UqJYfTYVhAnCICkNSjTzZ9lR4OIa/7NG2JICM1jibEM2u1rKbUofCG+xZRam9nx9fFKlKa2QUCo3eRn62mm1KpfdBSCrsd9gprxGwlYbdOmeEGnHMt9A3s6KZoJNPMisganMIYjE+lbJKuWfwL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7/1w7+F8DmWgNdZlsQxq3sdoTsPo3sX1PfD8oIKTw4=;
 b=YqUnmZWulOi97zj/ImuTnYlpRUbXglsBulRzXhpsZHtv/HN6xPdtZi7Uivf32vbQd2UUENT7mXTezJCgHOqwDtwNTRLsUezr/ESWMLQcHz7oY9R/dRH8RGcHyX0X/v3woN5FZheZYSZ4+icbIJUVQLne3zAlgAGKUUnahicONTC1XVIa5zaUGIWSCMfu94eDelrARVrRbiZmyqdwHGRI3QDQseoV984Fwh8blg+NZC7cqkySgo6f5APmC7DMq1VrLXVOdKeq8lUsIXeUl0uAfmSp23ATMsuq8qdpMsasIAIxF3mqukR7P2aYoh9aBJGGq/9qDVJB2BpWNxi3cnrXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2398.namprd02.prod.outlook.com (10.168.243.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 16:48:32 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 16:48:32 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Philippe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v2 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Topic: [PATCH v2 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Index: AQHVpguqWkenqVaL5UG7yy2/hb1RUg==
Date: Thu, 28 Nov 2019 16:48:31 +0000
Message-ID: <20191128164810.54279-4-felipe@nutanix.com>
References: <20191128164810.54279-1-felipe@nutanix.com>
In-Reply-To: <20191128164810.54279-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0154.eurprd05.prod.outlook.com
 (2603:10a6:207:3::32) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a4d6f9a-44a8-401b-a5a6-08d77422cd4b
x-ms-traffictypediagnostic: MWHPR02MB2398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB23983FA43368F1B834941A1AD7470@MWHPR02MB2398.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(102836004)(110136005)(256004)(446003)(36756003)(14454004)(2616005)(6436002)(11346002)(66066001)(4326008)(386003)(6506007)(186003)(26005)(52116002)(76176011)(66556008)(64756008)(1076003)(71190400001)(66946007)(5660300002)(71200400001)(6486002)(66446008)(66476007)(86362001)(6512007)(478600001)(54906003)(8936002)(50226002)(316002)(81166006)(2906002)(8676002)(7736002)(305945005)(81156014)(99286004)(25786009)(6116002)(3846002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2398;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1T77mGLr6zx8PPRMS8vB65M0BQlQoknEqMdlmELylyfsCisv3W0vneKo1x8Rqbui8WOGv1jzQd+65JflJ3u/JMTeA2MC0LgfUAUKuKYqnemK/9thTKGEsFwJe7/S44fRrQ0WiYDZx3yRfVIvl7T5fUIo3Y5C/oJJ4yToHgkJoy9POZj7CYkic0FrrGNIeh+ml24CpIx8HQp4RXLknx53dVrYM6QBVnYnH0xbEv2c8w0LCJpo9dQKOJi10uL4u5UeeU+pH6KTvICa5+4plgqHXhbix3ASqupIUNL8skv+cXIAhHq4HIun0KSMef7W1aMgxYEovhlYGHyk+CQxPf0lIEYJ2Piay+4sI8Ia8t+StYjns3MeSDN1cQA+v3fialII9g4kSHD9b78l1/ePl7bNNuVEh3cV17UXUsXcNAgzPrAWhCaBDTatrwBAhtNst+Zd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4d6f9a-44a8-401b-a5a6-08d77422cd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 16:48:31.9220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weEnvMffeiuOvXhEK7vmhqoU27QaWtHopiEUgiHfPAE/5Drtaes4nK8+XwLhyOJ270s/TJ+vJ8eb8CzIu89pLJdS8LjoMpOqHeSIZL3BgCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_05:2019-11-28,2019-11-28 signatures=0
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

Q3VycmVudGx5LCBpY2g5X2xwY19pbml0Zm4gc2ltcGx5IHNlcnZlcyBhcyBhIGNhbGxlciB0bw0K
aWNoOV9scGNfYWRkX3Byb3BlcnRpZXMuIFRoaXMgc2ltcGxpZmllcyB0aGUgY29kZSBhIGJpdCBi
eSBlbGltaW5hdGluZw0KaWNoOV9scGNfYWRkX3Byb3BlcnRpZXMgYWx0b2dldGhlciBhbmQgZXhl
Y3V0aW5nIGl0cyBsb2dpYyBpbiB0aGUgcGFyZW50DQpvYmplY3QgaW5pdGlhbGlzZXIgZnVuY3Rp
b24uDQoNClNpZ25lZC1vZmYtYnk6IEZlbGlwZSBGcmFuY2lvc2kgPGZlbGlwZUBudXRhbml4LmNv
bT4NCi0tLQ0KIGh3L2lzYS9scGNfaWNoOS5jIHwgMTUgKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9ody9pc2EvbHBjX2ljaDkuYyBiL2h3L2lzYS9scGNfaWNoOS5jDQppbmRleCAzYTljNGYwNTAz
Li45YTU0NTdjODNiIDEwMDY0NA0KLS0tIGEvaHcvaXNhL2xwY19pY2g5LmMNCisrKyBiL2h3L2lz
YS9scGNfaWNoOS5jDQpAQCAtNjM0LDEyICs2MzQsMTQgQEAgc3RhdGljIHZvaWQgaWNoOV9scGNf
Z2V0X3NjaV9pbnQoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5hbWUsDQog
ICAgIHZpc2l0X3R5cGVfdWludDgodiwgbmFtZSwgJmxwYy0+c2NpX2dzaSwgZXJycCk7DQogfQ0K
IA0KLXN0YXRpYyB2b2lkIGljaDlfbHBjX2FkZF9wcm9wZXJ0aWVzKElDSDlMUENTdGF0ZSAqbHBj
KQ0KK3N0YXRpYyB2b2lkIGljaDlfbHBjX2luaXRmbihPYmplY3QgKm9iaikNCiB7DQorICAgIElD
SDlMUENTdGF0ZSAqbHBjID0gSUNIOV9MUENfREVWSUNFKG9iaik7DQorDQogICAgIHN0YXRpYyBj
b25zdCB1aW50OF90IGFjcGlfZW5hYmxlX2NtZCA9IElDSDlfQVBNX0FDUElfRU5BQkxFOw0KICAg
ICBzdGF0aWMgY29uc3QgdWludDhfdCBhY3BpX2Rpc2FibGVfY21kID0gSUNIOV9BUE1fQUNQSV9E
SVNBQkxFOw0KIA0KLSAgICBvYmplY3RfcHJvcGVydHlfYWRkKE9CSkVDVChscGMpLCBBQ1BJX1BN
X1BST1BfU0NJX0lOVCwgInVpbnQ4IiwNCisgICAgb2JqZWN0X3Byb3BlcnR5X2FkZChvYmosIEFD
UElfUE1fUFJPUF9TQ0lfSU5ULCAidWludDgiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIGlj
aDlfbHBjX2dldF9zY2lfaW50LA0KICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEws
IE5VTEwsIE5VTEwpOw0KICAgICBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQ4X3B0cihPQkpFQ1Qo
bHBjKSwgQUNQSV9QTV9QUk9QX0FDUElfRU5BQkxFX0NNRCwNCkBAIC02NDcsMTQgKzY0OSw3IEBA
IHN0YXRpYyB2b2lkIGljaDlfbHBjX2FkZF9wcm9wZXJ0aWVzKElDSDlMUENTdGF0ZSAqbHBjKQ0K
ICAgICBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQ4X3B0cihPQkpFQ1QobHBjKSwgQUNQSV9QTV9Q
Uk9QX0FDUElfRElTQUJMRV9DTUQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZhY3BpX2Rpc2FibGVfY21kLCBPQkpfUFJPUF9GTEFHX1JELCBOVUxMKTsNCiANCi0gICAgaWNo
OV9wbV9hZGRfcHJvcGVydGllcyhPQkpFQ1QobHBjKSwgJmxwYy0+cG0sIE5VTEwpOw0KLX0NCi0N
Ci1zdGF0aWMgdm9pZCBpY2g5X2xwY19pbml0Zm4oT2JqZWN0ICpvYmopDQotew0KLSAgICBJQ0g5
TFBDU3RhdGUgKmxwYyA9IElDSDlfTFBDX0RFVklDRShvYmopOw0KLQ0KLSAgICBpY2g5X2xwY19h
ZGRfcHJvcGVydGllcyhscGMpOw0KKyAgICBpY2g5X3BtX2FkZF9wcm9wZXJ0aWVzKG9iaiwgJmxw
Yy0+cG0sIE5VTEwpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBpY2g5X2xwY19yZWFsaXplKFBDSURl
dmljZSAqZCwgRXJyb3IgKiplcnJwKQ0KLS0gDQoyLjIwLjENCg0K

