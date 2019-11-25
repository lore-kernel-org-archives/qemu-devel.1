Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A65C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C04207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uGoQOGXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C04207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGRS-0005zH-Du
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iZGPp-0004PP-Jo
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iZGPn-0007p5-UM
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:41 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:1480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iZGPn-0007oj-PQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:36:39 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAPFVfei009365; Mon, 25 Nov 2019 07:36:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=eOwV4DeHBup9OqaefCFkcue4SmcvXAexlK1LjnCrbbk=;
 b=uGoQOGXJQ/PPufxMJJiepvIG2HoG9vE4xfyf3qkuZ1gM0wLIHuyKKoSF86F2/i4glsUn
 myl53o5KqQmbcVSTqLoaFg0zppxMO9lNgjwZ3oaJ3Xilh2Pkv0JpM9W6A0+VXyPo98n2
 ZnshH6yHv9xgP2FPszU1NfKr6dVIzlus1OdgGsM4DXGGScEJi3aTbuy6uZyCzoJcG+AE
 JarjB4iMraDV0Lq3GUwc95fUNtGPTKBCoynCb4KQSxDwrfB3mrtOSQ7Kx2jffhltebU5
 qcC83taqC//1elAbkSMNDDYnyTov07NHdDjG2TdN1PZFHKSVQUrYjw1JNdP79h5XyyLA cQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wf4yn3unq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2019 07:36:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmKS57ASB6U76qQ3ies+J0nigDr1B3mIqgmH7MfsVIn38E4IOzg17CEWOGkfxR6vS9sPQKL2foyFizF/P8toJN7LU9VTwHUWzZs2JJSwOs15mx0V84/MS8pSiH+QclK1yVKoQnS/rAB4i2ixGv4BvD0i6sjZOdbkVXvKKrNrTb/qGl+wk8F27Q57WLNrhh2Q9cdzcxqOE5NQ5mFWB6sEbFQ7WNOBeHa6cfD38YAZkx1oSmertStfHLZ1zV/bnckBGvgYSlrvW2SWrW40ifWu67/3QH54e7Q+xh0GunzpAlPktMFo0L9Vc1uViIQaqVNE4BYhzGBIxM12kix9GmsuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOwV4DeHBup9OqaefCFkcue4SmcvXAexlK1LjnCrbbk=;
 b=D1NcdMnr+Ykpoc9+/5TiYQluQncovW83JeQhnTSg4qC8AWJr9VmMowZ4N12eh7ytLTZgSlEnfLlrDjDcqZ63DrKS0CKh06HhCVwBZiWzUxrx0c53DiiLMK/5/dO/kkwI1FEFqP488qoOrXQYIll7I5FF6qENsItdZzDbbk34D15WiSOf+ZTeFn/1MNN6yX3Q/fHuYZRI1m3ScdRsYWHxTG0Ak98h6pLmkfyFABZE/JFc8XEH1HX/I7KTy++QnfzJPB9btN9b3ZCCpCY8kXNYrXiZNiAXq6M3T/gOCDyPYeHc33UPJledz/uloSJaO6NWDQSZTvrE5O6vHuKzJ4SwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3183.namprd02.prod.outlook.com (10.164.133.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 15:36:38 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:36:38 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/4] ich9: fix getter type for sci_int property
Thread-Topic: [PATCH 2/4] ich9: fix getter type for sci_int property
Thread-Index: AQHVo6YgVQPIYdSUK0GhG0cq3dH2nw==
Date: Mon, 25 Nov 2019 15:36:38 +0000
Message-ID: <20191125153619.39893-3-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: 17099d98-f109-44b7-ffbf-08d771bd42d7
x-ms-traffictypediagnostic: MWHPR02MB3183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3183C6A15C35997DAB843D3ED74A0@MWHPR02MB3183.namprd02.prod.outlook.com>
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
x-microsoft-antispam-message-info: UWEeawA9iadJtrhOolW68ZZRhSl8dBW81sOjrH9Z21+BVdMTRFMqxY01xr5NkkH4YZrYQuR3J9A8Xlv5k8it41uIIN5oNg7TXWoOxSQ9S417PgZw+iXSzNwvTA1BjZjCYhDVF25eWuT/tHyqi6zDGZNLoaPBt+MCW1keR0ovKrVa0YG6dlJfY8Df581Ub3HxYGLRz7lyAm6ofobOVoP+CI6C3fXwzupifFPj+rCpBBpVUUgtCEItztRhqU9L5oFOIGYzfE4g5vDRja+Y+24jE21uVUmOLi1jb+2IIPnaIVq7+t93krjE7Wnl37P1UZpdKSamkk/3VN4WQPH1nv5qKbZ3wJ3JeBttl5XsIGbVGcW18KIxZGzVYDsPoh51lSYhzsWqpvPl4T8zIIsyTOK9WVuzrSkXKeA9qSp1V8M18NNHxx4nFa6clH9ow7AyDYns
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17099d98-f109-44b7-ffbf-08d771bd42d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:36:38.2023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vp1Tl12IRXLMBUgBDGlQi9nPK3NsMzQrpnIERNMcGm03PYl5netCePhJidTBr3rkJwvHWNtOEBWYq1wP5CZS8J2xi1gd+8mSh6lHGmAS6bw=
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

V2hlbiBRT00gQVBJcyB3ZXJlIGFkZGVkIHRvIGljaDkgaW4gNmYxNDI2YWIsIHRoZSBnZXR0ZXIg
Zm9yIHNjaV9pbnQgd2FzDQp3cml0dGVuIHVzaW5nIHVpbnQzMl90LiBIb3dldmVyLCB0aGUgb2Jq
ZWN0IHByb3BlcnR5IGlzIHVpbnQ4X3QuIFRoaXMNCmZpeGVzIHRoZSBnZXR0ZXIgZm9yIGNvcnJl
Y3RuZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgRnJhbmNpb3NpIDxmZWxpcGVAbnV0YW5p
eC5jb20+DQotLS0NCiBody9pc2EvbHBjX2ljaDkuYyB8IDYgKysrLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2lz
YS9scGNfaWNoOS5jIGIvaHcvaXNhL2xwY19pY2g5LmMNCmluZGV4IDU1NTVjZTMzNDIuLjI0MDk3
OTg4NWQgMTAwNjQ0DQotLS0gYS9ody9pc2EvbHBjX2ljaDkuYw0KKysrIGIvaHcvaXNhL2xwY19p
Y2g5LmMNCkBAIC02MzEsOSArNjMxLDkgQEAgc3RhdGljIHZvaWQgaWNoOV9scGNfZ2V0X3NjaV9p
bnQoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5hbWUsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApDQogew0K
ICAgICBJQ0g5TFBDU3RhdGUgKmxwYyA9IElDSDlfTFBDX0RFVklDRShvYmopOw0KLSAgICB1aW50
MzJfdCB2YWx1ZSA9IGxwYy0+c2NpX2dzaTsNCisgICAgdWludDhfdCB2YWx1ZSA9IGxwYy0+c2Np
X2dzaTsNCiANCi0gICAgdmlzaXRfdHlwZV91aW50MzIodiwgbmFtZSwgJnZhbHVlLCBlcnJwKTsN
CisgICAgdmlzaXRfdHlwZV91aW50OCh2LCBuYW1lLCAmdmFsdWUsIGVycnApOw0KIH0NCiANCiBz
dGF0aWMgdm9pZCBpY2g5X2xwY19hZGRfcHJvcGVydGllcyhJQ0g5TFBDU3RhdGUgKmxwYykNCkBA
IC02NDEsNyArNjQxLDcgQEAgc3RhdGljIHZvaWQgaWNoOV9scGNfYWRkX3Byb3BlcnRpZXMoSUNI
OUxQQ1N0YXRlICpscGMpDQogICAgIHN0YXRpYyBjb25zdCB1aW50OF90IGFjcGlfZW5hYmxlX2Nt
ZCA9IElDSDlfQVBNX0FDUElfRU5BQkxFOw0KICAgICBzdGF0aWMgY29uc3QgdWludDhfdCBhY3Bp
X2Rpc2FibGVfY21kID0gSUNIOV9BUE1fQUNQSV9ESVNBQkxFOw0KIA0KLSAgICBvYmplY3RfcHJv
cGVydHlfYWRkKE9CSkVDVChscGMpLCBBQ1BJX1BNX1BST1BfU0NJX0lOVCwgInVpbnQzMiIsDQor
ICAgIG9iamVjdF9wcm9wZXJ0eV9hZGQoT0JKRUNUKGxwYyksIEFDUElfUE1fUFJPUF9TQ0lfSU5U
LCAidWludDgiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIGljaDlfbHBjX2dldF9zY2lfaW50
LA0KICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOw0KICAg
ICBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQ4X3B0cihPQkpFQ1QobHBjKSwgQUNQSV9QTV9QUk9Q
X0FDUElfRU5BQkxFX0NNRCwNCi0tIA0KMi4yMC4xDQoNCg==

