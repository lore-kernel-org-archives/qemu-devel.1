Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF95C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549162465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ppsK6RUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549162465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0A5-0006HF-0e
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ii08H-000467-Ck
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ii08F-0002dZ-Uc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:41 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:41878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ii08F-0002Yn-Jq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:39 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJHuNb7016852; Thu, 19 Dec 2019 10:02:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=FrN/3cE/GL71upbprZOwMng6lo6UJ/TnJrSz3CAHChQ=;
 b=ppsK6RUJZ/BzVz64TfuD+6MTCfBQcjVMgAGWYK3B9Wld1B5WClyfVpVY9Dz7skfYT3pC
 SuCBdLBimxmNHpjgYCuLMbmCDVJysAV2WDetm0LQ0Nz9XVwAk4osAjgctxiSkOY9SRBv
 HCLGO2lUUUd4hYwje0L8icWKBHQBqupuWpM27spun/O126SQQfK3nKuhoBhaXwuzwRu8
 u2JkBq+0MSS8WwisQjL4K8bApxo2evO0c+Q+FAlId4i7nWPeYm+wFjcodhk6jB6yLtrG
 ZY4FZewF0oY/nFMh4ZwZ54FbKGJ70r8vZQV7AF91WrNBKzcci4HOz0Dbs9rZc2SzpRl6 CQ== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2wvvy0bn3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 10:02:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyzCJSlxF6uQD8doSLek7Ha7eOAOUcUYP7+0Jtuqql7aNa5YbZOaGyveZDrKUmxQJ5HlhfHyV02vFUOSAmzMbpyrcEddN+GGLbQhF5EDMq63Dj2wFMTsrYX9wzRN/UI4yvWOPDak3cAjO7MUtZxwUXwu4G21cM2dNqxOuLBrp88ZgHOFR/blq3sLnSYfa1CXcvSMoFf0ryraAWGKswFKFZIhJWW30TBfXj4ad1DL8g78VBqVReqQ2lHcVnbKGSvn0MK6Q5GEmMdx4BRCrnqCik3Ocp241JuEPhcw3XXSGvNAaJYFyDwyh5FSnbcQCgCLaRAHpTdQi2KU0MV8g7xpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrN/3cE/GL71upbprZOwMng6lo6UJ/TnJrSz3CAHChQ=;
 b=nvTAL0yfU08WTlAoxEjZD4cULqc7ZQATo9E8ycuMddGrECNnk8nzLBOPmGrhqiHSrPLRIDfNsbCqEaVJYqSg9nUISohBDwCxL5YH+rxSphHAJ74qmQRrXK6J6sgeIX5gcSud/gtXcqUMPc/4IalO/yL92kNqqUbxuqTBc2afa7Rfh6+ETb3T8RyGBJbIlxUnJoXgKL1HyWvT7puHp/NAURbsmJv31Kow0qZXK4ZPPO0Tyuj1uujgxVpBu24WMAOo6T7mA2VqZBRMjeS71qcN0CL4xXQWSuVrR1snqhjOoCM4iC078o5Wqs86p8BPpjLj8x4sw3B3+Uk58+Mkw4gn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2303.namprd02.prod.outlook.com (10.168.245.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 18:02:36 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 18:02:36 +0000
Received: from nutanix.com (82.9.225.166) by
 AM4PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:205:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.4 via Frontend Transport; Thu, 19 Dec 2019 18:02:34 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Phillipe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v4 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Topic: [PATCH v4 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Index: AQHVtpZ+XRpRLxgYrk+jiKZGoI3x4Q==
Date: Thu, 19 Dec 2019 18:02:36 +0000
Message-ID: <20191219180205.25191-4-felipe@nutanix.com>
References: <20191219180205.25191-1-felipe@nutanix.com>
In-Reply-To: <20191219180205.25191-1-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: ddb5fec0-fdf6-49f1-07e4-08d784ada107
x-ms-traffictypediagnostic: MWHPR02MB2303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2303395AC8B31F8AEA7A7395D7520@MWHPR02MB2303.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(66476007)(5660300002)(16526019)(186003)(66446008)(26005)(956004)(2906002)(4326008)(36756003)(8886007)(52116002)(1076003)(7696005)(81166006)(8936002)(81156014)(86362001)(8676002)(478600001)(66946007)(2616005)(64756008)(55016002)(107886003)(71200400001)(110136005)(66556008)(54906003)(316002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2303;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gId7gTAWPBqM2CFI5z8IG7e0/W3jyvCNKaRzbNEd1k8rsgSGkBPvvorj9s/vRsvwqJVovRHNRHHZkWW2PpGb54+U/0c6WwCNCttizKL+eWxbwtAwoc9c2GxxvxO8M1dBms1osAsMwqNdQsfTyvytW+y3sYtk4770gSaGKOcJU0a+5sLjQpCF9PDd7q91eeQCQ9tyPnGUiy/5/GCXi0/zm1vRugogZpBNja+WaLbR+gdhDVJVnPFWe6GG7uzyLFDuGy6Pn24rowZ9+bFcTuNSnIZR2r3bJOgmZQjt/iFT/baP9K6yCmz6MEpv5k9PWnWjZ54jhl6yj/VOR2FInsIceoexG8IWuzCbv1dGzisAUF+59tOikP4P+7R8lc+Bdzgvo0672MlQjOWCfbgMFyGqDTVZzMUSZNSWN5PMD1N0gLYcLrGV2WdfPpyOa6sbX8+iLMKF1TFDPaijY8S4/nAP4SsdU1+5+D1Q95zppEZzlZn1uLdbie5dk7fpK80PiVzB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb5fec0-fdf6-49f1-07e4-08d784ada107
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 18:02:36.5534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dB9L9uPdHj6DJWGI+w0eoHFmkYHdHRhJGSolCIOp/1YsvzLLgad7DVwPv/7Wg+7spXcAECkqvvkAbMCcZl+zVXxTntuAMhlsxGFTzYaMeDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2303
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

