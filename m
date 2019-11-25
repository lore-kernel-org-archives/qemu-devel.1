Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4D0207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="c4ikAQ/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4D0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGRZ-00067V-M8
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iZGPr-0004PR-2d
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iZGPq-0007pj-35
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:43 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:57362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iZGPp-0007pY-Th
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:42 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAPFWdnQ007388; Mon, 25 Nov 2019 07:36:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=TW99OkJPGvNpk+VsJS+A6yo8TaYTa8Uncc+j5ULJa1Q=;
 b=c4ikAQ/YcXdAtpjxrqHXotng8vOsh6AhnozXgn6g4CYh1oQeahoT6jFQtRCBPXwX7+6f
 jo54iJCpeH4wtoByb38ti0BHU+LCuuKIplELnVFjJeFSz3Ot5MdpYRkpavbxwthhuoYN
 A3MCowg+NPU711g7D3vg0r460DMw8YzN+/ou+oaK9uq5Ild47NTqfK0+xRQQ6CjuhW3J
 OSo9aGBUaUnzJg6B2rCk1GzoxZaWPSzbq3VRU5QKCaIkXtUqu0mX9NLUVXZ4yrz/lQ8E
 VgLi27cDDLYbL65EPbJTOuQe5MF18qQJJKcdL0kQmQEgb7dibZxnDcr5c/RhrncF6PpR tg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wf36euy2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2019 07:36:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlzgF8a+4qt0YQGj91Rz67p5r9b1bzVlCXQhqqHkir4Xa4ZQDr0SMhlMwEFIo+mqvpGL9UCYVzS/pHnVLCsM1kXJYZ0ORv4gs5XVYm+WO+OhymNDJ5SsrLcen9QTSFISQZzEfQzwObV7rfNSGMCfhILWXje7YxnHBFajZ83Xfzhc4b95uoSvp6SPJc7hqxUf1mbd6JJlo5mKpDNkFSo7aKx+xsbonyUgxGtPwYLRe/X4pGgOz9On3dkL6A8jGfmg1jlzAPIWF/55f6fzix+fPRvn81Ua3iXU89FK29INqqDYUVsagamyxr2QeX49dK6hd1BdWqv1yTZHCtGqnQezEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW99OkJPGvNpk+VsJS+A6yo8TaYTa8Uncc+j5ULJa1Q=;
 b=SF/mJmsTBucEkJlkqHr2ZwIv/0nqJDu5XFBf6idbjt8bugr8YebpEFW4XM3mc8fkOBkWS0j78SHtHgGz2gN92gJifuWzLoMiWpok2yGf4MdiACtt9hrFKpon7FoqTZNk0DKsnVTn9CSV6zy/elKFdzGfa42ZEuECtmcoD/qYDU83OOe17jthWWnszl8HivaAgYRkMK8qnq9dXC9+V5RrUTJHTCQW7jUzcaA9PIlQemjS333V+2T7F+0cJfNJSFmBBLdYhE6CVrNrZsgBB3SWSJE8fh1xREzSqrMqMtCED5a5ZbLhZF1bLchYTDj/0d22e84+FZiCYE+oL/j/2Jrhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3183.namprd02.prod.outlook.com (10.164.133.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 15:36:40 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:36:40 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Topic: [PATCH 3/4] ich9: Simplify ich9_lpc_initfn
Thread-Index: AQHVo6YhylH331ZIG06iKIfsf9xAwQ==
Date: Mon, 25 Nov 2019 15:36:40 +0000
Message-ID: <20191125153619.39893-4-felipe@nutanix.com>
References: <20191125153619.39893-1-felipe@nutanix.com>
In-Reply-To: <20191125153619.39893-1-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: 4306dd7d-c457-4b0d-17c3-08d771bd43e6
x-ms-traffictypediagnostic: MWHPR02MB3183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB318368AF6531C1B4624E3717D74A0@MWHPR02MB3183.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(4326008)(6512007)(86362001)(1076003)(3846002)(6116002)(386003)(6506007)(7736002)(305945005)(6436002)(6486002)(478600001)(54906003)(26005)(102836004)(110136005)(2906002)(36756003)(25786009)(14454004)(316002)(446003)(99286004)(256004)(107886003)(66066001)(66446008)(64756008)(66556008)(66476007)(11346002)(2616005)(5660300002)(66946007)(186003)(76176011)(52116002)(50226002)(81166006)(81156014)(8676002)(71200400001)(8936002)(71190400001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3183;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOHuIHJ+d+DmExREUy/Azcn10vMCyVoluGXJlOEOoYR7+rPT98qC+8a7eOEyoqZmR2IM4dVptEg34v/b2LJuQhpgCiAMCudCYW/ddmrEJtUBHJgPl9UJllGHuC0Ps5QpGZCgbjcg/du3iufzb7x84hoxgVoUkypFi9DZ7xuKuYoYMkM9siEHnGaJHqLUVAc2SCIxnfS9guqi5NE5QyooiCiJBozcwHylgYk1D2KkEW3m55BTmkst6OmoaREF8JFlNg8Hpa5MoUemE3VTxvCIwL56fkQzJwiiZ2Wb2Rg3GYpGIE9Aea4d4SLxS27vdq0THJq7ircnAUmz1PelTsc+UQADylrqbgAGkhTlqeFHmbVMZW4DT1AYMMW0MExpq4lKUQMRpokvTsVonKGFFB6fZqslJXkjCtzX62I51rcTl1Y/vE5QElCuN0v/gshz641p
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4306dd7d-c457-4b0d-17c3-08d771bd43e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:36:40.1203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQ9llXtPIn7+Se6k60fGoezL9EC145qwoD+u6qqebaku2EtZRFH6UCcc3mW9494pMMTOV92rXUuswLTJVGsLN8URCxvk8wCF2YQJH00DrWI=
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

Q3VycmVudGx5LCBpY2g5X2xwY19pbml0Zm4gc2ltcGx5IHNlcnZlcyBhcyBhIGNhbGxlciB0bw0K
aWNoOV9scGNfYWRkX3Byb3BlcnRpZXMuIFRoaXMgc2ltcGxpZmllcyB0aGUgY29kZSBhIGJpdCBi
eSBlbGltaW5hdGluZw0KaWNoOV9scGNfYWRkX3Byb3BlcnRpZXMgYWx0b2dldGhlciBhbmQgZXhl
Y3V0aW5nIGl0cyBsb2dpYyBpbiB0aGUgcGFyZW50DQpvYmplY3QgaW5pdGlhbGlzZXIgZnVuY3Rp
b24uDQoNClNpZ25lZC1vZmYtYnk6IEZlbGlwZSBGcmFuY2lvc2kgPGZlbGlwZUBudXRhbml4LmNv
bT4NCi0tLQ0KIGh3L2lzYS9scGNfaWNoOS5jIHwgMTkgKysrKysrKy0tLS0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvaHcvaXNhL2xwY19pY2g5LmMgYi9ody9pc2EvbHBjX2ljaDkuYw0KaW5kZXggMjQwOTc5
ODg1ZC4uMjMyYzc5MTZmMyAxMDA2NDQNCi0tLSBhL2h3L2lzYS9scGNfaWNoOS5jDQorKysgYi9o
dy9pc2EvbHBjX2ljaDkuYw0KQEAgLTYzNiwyNyArNjM2LDIyIEBAIHN0YXRpYyB2b2lkIGljaDlf
bHBjX2dldF9zY2lfaW50KE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBjb25zdCBjaGFyICpuYW1l
LA0KICAgICB2aXNpdF90eXBlX3VpbnQ4KHYsIG5hbWUsICZ2YWx1ZSwgZXJycCk7DQogfQ0KIA0K
LXN0YXRpYyB2b2lkIGljaDlfbHBjX2FkZF9wcm9wZXJ0aWVzKElDSDlMUENTdGF0ZSAqbHBjKQ0K
K3N0YXRpYyB2b2lkIGljaDlfbHBjX2luaXRmbihPYmplY3QgKm9iaikNCiB7DQorICAgIElDSDlM
UENTdGF0ZSAqbHBjID0gSUNIOV9MUENfREVWSUNFKG9iaik7DQorDQogICAgIHN0YXRpYyBjb25z
dCB1aW50OF90IGFjcGlfZW5hYmxlX2NtZCA9IElDSDlfQVBNX0FDUElfRU5BQkxFOw0KICAgICBz
dGF0aWMgY29uc3QgdWludDhfdCBhY3BpX2Rpc2FibGVfY21kID0gSUNIOV9BUE1fQUNQSV9ESVNB
QkxFOw0KIA0KLSAgICBvYmplY3RfcHJvcGVydHlfYWRkKE9CSkVDVChscGMpLCBBQ1BJX1BNX1BS
T1BfU0NJX0lOVCwgInVpbnQ4IiwNCisgICAgb2JqZWN0X3Byb3BlcnR5X2FkZChvYmosIEFDUElf
UE1fUFJPUF9TQ0lfSU5ULCAidWludDgiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIGljaDlf
bHBjX2dldF9zY2lfaW50LA0KICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwsIE5V
TEwsIE5VTEwpOw0KLSAgICBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQ4X3B0cihPQkpFQ1QobHBj
KSwgQUNQSV9QTV9QUk9QX0FDUElfRU5BQkxFX0NNRCwNCisgICAgb2JqZWN0X3Byb3BlcnR5X2Fk
ZF91aW50OF9wdHIob2JqLCBBQ1BJX1BNX1BST1BfQUNQSV9FTkFCTEVfQ01ELA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmYWNwaV9lbmFibGVfY21kLCB0cnVlLCBOVUxMKTsN
Ci0gICAgb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50OF9wdHIoT0JKRUNUKGxwYyksIEFDUElfUE1f
UFJPUF9BQ1BJX0RJU0FCTEVfQ01ELA0KKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQ4X3B0
cihvYmosIEFDUElfUE1fUFJPUF9BQ1BJX0RJU0FCTEVfQ01ELA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmYWNwaV9kaXNhYmxlX2NtZCwgdHJ1ZSwgTlVMTCk7DQogDQotICAg
IGljaDlfcG1fYWRkX3Byb3BlcnRpZXMoT0JKRUNUKGxwYyksICZscGMtPnBtLCBOVUxMKTsNCi19
DQotDQotc3RhdGljIHZvaWQgaWNoOV9scGNfaW5pdGZuKE9iamVjdCAqb2JqKQ0KLXsNCi0gICAg
SUNIOUxQQ1N0YXRlICpscGMgPSBJQ0g5X0xQQ19ERVZJQ0Uob2JqKTsNCi0NCi0gICAgaWNoOV9s
cGNfYWRkX3Byb3BlcnRpZXMobHBjKTsNCisgICAgaWNoOV9wbV9hZGRfcHJvcGVydGllcyhvYmos
ICZscGMtPnBtLCBOVUxMKTsNCiB9DQogDQogc3RhdGljIHZvaWQgaWNoOV9scGNfcmVhbGl6ZShQ
Q0lEZXZpY2UgKmQsIEVycm9yICoqZXJycCkNCi0tIA0KMi4yMC4xDQoNCg==

