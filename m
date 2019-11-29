Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E519C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE102158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="B49l0cYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE102158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iake1-0002wa-Vw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iakMD-00026C-24
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iakM9-0000Ku-3P
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:47:02 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:6854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iakM7-00009s-85
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:47:01 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATHfgY4014254; Fri, 29 Nov 2019 09:46:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=FrN/3cE/GL71upbprZOwMng6lo6UJ/TnJrSz3CAHChQ=;
 b=B49l0cYOF7dRhSiHux6Nvi5mfc+9FuQq3/Xz+1NvD6etOMBDZGJv/DNkU1TugDJ6e13/
 pGWFtMsWAumO2l/e1fw8nLDvfijvk9jkHLLbsp6fRKrISWNpoOnFsMm/wcH21E6gn63R
 mjvMkS1UMG1BjLlPZ0ZO3rQ7OeT5PwmG0noQWDEf+K83Y1gfiWGFoP1TpnjRnSKOm4JN
 g5tPFv/zdQnMhVoN7A+H0G+x4RXxveMBfigDlEz6M2WRjP/Pkm1rgQmhi3J05ncXcBuF
 /J5C8eZXOnDAZRmrFOEiFfD9rxbvbslhBLLvNLKB3IO2q4Afgs1kHhHDdT5Qg/54ASFe Hw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2whjspd8t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Nov 2019 09:46:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSmp+A7TSF1cZTtNFAhB2fbyieX1hPIw1upvnAcW/m9Z6oS7UbLmngOAQkIX3g0wAsCYh2IbdDmze4dYVxreXra5dD5nXUz6z6Gh0zpoQlyU4OTc64LGxmQJjlHpPp182+8atW8WFbHhTIWY3uFgZahofDTuA7K8VMgjBEc2ppgr8zFe8I1527j+vo2Rs93dxlO7qYLHJXZjpXF8KZxkuKLb48vRHsY3RiiDJ6LXlSiGqSUuH342a4LJFR6TT29ihgKDLfoJvSVKd4MtzU4H8Cu009aJBC1EyS2xyi0nxdM3jon+59sZbvgD9jKoucj5aUiY8HUTBK/U1EsyKiNjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrN/3cE/GL71upbprZOwMng6lo6UJ/TnJrSz3CAHChQ=;
 b=LkL2mnNAmWRHD0gOqa88tE82lsYwJrOHKN63joDUoagy1BBequ7Sx2EXg8IAyVcA6TUNXFfa6hxtLgSXkZTDfig6BtfcI00jV2gSnCJAoskq3gBW9WOsIWDySziKqcMrkntu0dUmI0Km4sOa9X/HuO5yyvYwnSQIxH9ykew8KW957u0avcTqXIvcSTdiNWxWmCfXRZLp0prvXOMO3urI5KBwH0TnNA8VmEjHPuyS5LdSXiRPIB4pSXz267QsZ1nzpB+Ajun8c8kjguB2Q2Qh/WJHESsDuvYgk4uG91u4axy4l1qxe2fQF/5MUx07HclQXMF9H4KiUHHJtKqwGldCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2239.namprd02.prod.outlook.com (10.168.244.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 29 Nov 2019 17:46:54 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 17:46:54 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Philippe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v3 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Topic: [PATCH v3 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Index: AQHVptz8CY4ZFQonbkmrpmwTWOQDJQ==
Date: Fri, 29 Nov 2019 17:46:54 +0000
Message-ID: <20191129174630.6922-4-felipe@nutanix.com>
References: <20191129174630.6922-1-felipe@nutanix.com>
In-Reply-To: <20191129174630.6922-1-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: dd197e26-9ac5-4d24-8dc1-08d774f41f0c
x-ms-traffictypediagnostic: MWHPR02MB2239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2239A6E21D46184EF4C5162AD7460@MWHPR02MB2239.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(199004)(189003)(386003)(66946007)(66476007)(305945005)(64756008)(6506007)(76176011)(66556008)(6486002)(5660300002)(6512007)(25786009)(7736002)(66446008)(1076003)(36756003)(52116002)(66066001)(256004)(6436002)(71190400001)(186003)(26005)(86362001)(8936002)(110136005)(446003)(4326008)(54906003)(14454004)(102836004)(71200400001)(99286004)(81166006)(50226002)(6116002)(316002)(2906002)(478600001)(2616005)(81156014)(11346002)(3846002)(8676002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2239;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddGTh1plmwEwkWaDLFOcHJMYlNTmlOXyMuoRqw4Px1mBSuw1tp9f3R4AeW6wmEvBzUa3AKd08jOzEgXUQOl4eqa1ENy4cPnrRAGy0tySpxmCWzX0RcHvaz2wzNUXLlfaEelpaRHOhFoKQlBQmlcIgsn+CsB4TnEdJseVyh/GPj+90Ti1F4JIzx81scMt6Pv8gqCruN1eZrR4g5BP6N9gyI0Nsr/w33PMR4lZInxJhWED/HuY75TgojBGvQAJk5HszyIjmJkh4W7LmTHNpnrgOoaJqdTQECT7uQ1lNG6QXGAl2EbG4swqkhlb0wvn2vGkllTkbroemEXTQT9BkS5ZmCDf5p4gnqs1F814VA0KEIQvYoZfA0as4vizxHi2yPE7H6JOce+RH6PRCuBt6c9+aZREpEaqsa3iQiMTRWNM3Ooy5nX3ucNSbBZjMtMZgiNK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd197e26-9ac5-4d24-8dc1-08d774f41f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 17:46:54.1181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoefaRg7uMH2+HHRcnORxJRRyt1qJQeEiYnV5eHtlUUO+L3VZNis4IyGlUb0cFjI1mJqq0rJiLjlW5dODteLvOqfY89QyNp4xjWsr5t/FzA=
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

Q3VycmVudGx5LCBpY2g5X2xwY19pbml0Zm4gc2ltcGx5IHNlcnZlcyBhcyBhIGNhbGxlciB0bw0K
aWNoOV9scGNfYWRkX3Byb3BlcnRpZXMuIFRoaXMgc2ltcGxpZmllcyB0aGUgY29kZSBhIGJpdCBi
eSBlbGltaW5hdGluZw0KaWNoOV9scGNfYWRkX3Byb3BlcnRpZXMgYWx0b2dldGhlciBhbmQgZXhl
Y3V0aW5nIGl0cyBsb2dpYyBpbiB0aGUgcGFyZW50DQpvYmplY3QgaW5pdGlhbGlzZXIgZnVuY3Rp
b24uDQoNClNpZ25lZC1vZmYtYnk6IEZlbGlwZSBGcmFuY2lvc2kgPGZlbGlwZUBudXRhbml4LmNv
bT4NCi0tLQ0KIGh3L2lzYS9scGNfaWNoOS5jIHwgMTUgKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9ody9pc2EvbHBjX2ljaDkuYyBiL2h3L2lzYS9scGNfaWNoOS5jDQppbmRleCA5ZjRlMDBkZGRk
Li5jNDBiYjNjNDIwIDEwMDY0NA0KLS0tIGEvaHcvaXNhL2xwY19pY2g5LmMNCisrKyBiL2h3L2lz
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
ICZhY3BpX2Rpc2FibGVfY21kLCBPQkpfUFJPUF9GTEFHX1JFQUQsIE5VTEwpOw0KIA0KLSAgICBp
Y2g5X3BtX2FkZF9wcm9wZXJ0aWVzKE9CSkVDVChscGMpLCAmbHBjLT5wbSwgTlVMTCk7DQotfQ0K
LQ0KLXN0YXRpYyB2b2lkIGljaDlfbHBjX2luaXRmbihPYmplY3QgKm9iaikNCi17DQotICAgIElD
SDlMUENTdGF0ZSAqbHBjID0gSUNIOV9MUENfREVWSUNFKG9iaik7DQotDQotICAgIGljaDlfbHBj
X2FkZF9wcm9wZXJ0aWVzKGxwYyk7DQorICAgIGljaDlfcG1fYWRkX3Byb3BlcnRpZXMob2JqLCAm
bHBjLT5wbSwgTlVMTCk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIGljaDlfbHBjX3JlYWxpemUoUENJ
RGV2aWNlICpkLCBFcnJvciAqKmVycnApDQotLSANCjIuMjAuMQ0KDQo=

