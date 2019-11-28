Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE1C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7022176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pBxhw4ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7022176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPiT-0002Jn-JU
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iaMyN-0002m7-TL
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iaMyM-0002KM-3I
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:55 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:65190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iaMyF-0002A0-Ov
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:49 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASGlf7g014210; Thu, 28 Nov 2019 08:48:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=9zPGVjyV5VQnm3bt6A02V0umR+NCvpD843NmYvStucM=;
 b=pBxhw4psSBrPR4mEWz79S6a/zLnTdpBRRR7Rd5LLfAgaK+NohiQowSHJXukcESRoR6at
 ceABUv5g+PQ11HfvgU6SqpuyFV/ZSpw7CUIHO0V4TtnLQxmcPAIVga06IdtJbuWgOJpU
 xb15FPJHxEoAfviueRAlnde7CNY8gJzl9Ke9E1X/sAcXAOtj69+2wpN35CRm+A31gDau
 61Wqql8RMsYICw33PMIrMypOqTQoO/JQgOeLAqai/M0/GCCqknfwGiN7qplOE5fPMmUx
 zGr8t58OWwDiHMzjVhIfEg6znmlb3Pmhv/qbc+xzhFla+fIpWHkOwsvEtoS7l2XxlFHf Ag== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2whhdhujgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Nov 2019 08:48:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZP8cGeDOqo9DoltyMY3it1r7N7B4n/XkNl4J8sdCU3dde78eZavRAknQew4DncpBOuVhoUHOwybmu+ozC5bJSsS9n+1MRIMS6Tu/sb23PwR+IVXkr4IH9H654vl66bCa5kRJgL1HCxJLtWi6NxDdXaWJioMdzITw6bITDmHRd0ZxkQLnWn/D2fpAL/j8MrOqFnN0ZU+g54s03Xcu+1SkRqJzzYiLhpdQkBABOAhX6HfKuikJpfRbfucaA9Aj07liGb1sWxBRTZTAEP+R53dlhS4LiFY/YcQiTxQCadeYnqWBS2h+OFWR3bbYDLaV4t2sneVRG51HZTPJKsBQUGZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zPGVjyV5VQnm3bt6A02V0umR+NCvpD843NmYvStucM=;
 b=iZxw2qeea+/jqWxG12osTJ9+rEsAXR405ckIeUJ6ZN8QHYvOTxVj6ZAZAsQngnwd/9gSIdAC38szEVXxwTBy0mtvGMDyWVs4u3bpCvzwuCQAN4l5kGV7zyyo1BgOcCGbH+0mNwBMwT1pLXNFZ5mu6HXjb3HXWthVUYk+OFxkI+lOoWQ3kOVV4REKsSiauzXph72IZOjZE8fqTSwEgh6zWZv9iPEUtOUOnuj4UnJfjTCOy0utog/ydU26Fd2ujpPYnV1qWDTHlzFimmQ2UsPT3HZ2hQAz/HEG5azS9eO+3GkAX0Q/Ys4OzfMGqq3fbRc640xoTRZIs3an9mWPS3G1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2398.namprd02.prod.outlook.com (10.168.243.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 16:48:29 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 16:48:29 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Philippe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v2 2/4] ich9: fix getter type for sci_int property
Thread-Topic: [PATCH v2 2/4] ich9: fix getter type for sci_int property
Thread-Index: AQHVpgupAr8vV7eYO0SbN77IztInIw==
Date: Thu, 28 Nov 2019 16:48:29 +0000
Message-ID: <20191128164810.54279-3-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: c3ebc907-9432-46bf-d22f-08d77422cbfb
x-ms-traffictypediagnostic: MWHPR02MB2398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB239894288465DE9ABA462A1DD7470@MWHPR02MB2398.namprd02.prod.outlook.com>
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
x-microsoft-antispam-message-info: sakWcFsPGuyDQ4F2JHvM3MlGmytwk1zgsQZBaRt3eq55qRz2GMqcZwbIzE08+d8fo4Z3Uljb1Jy7Q8RuUNtnM2Y+xK/otvhd0aL01G3T4X0tkF3033vpyxql1BX+ws13OcBeABCEmoE5Zx2afyN5B/vWZYV3GLksPdQhhLUrzYHiUOa0M+o+rF+y+07ysY1PcSUKElfFWC0DbxVXDN5qbV+uX53L/bSNMVXWMXNYeBrj6qExJU2B5NjtNvJeU89qo+plaZN5zZmIV97oRFRwzSTQufX19hcSGWfl1GbFUfvIZipmokutFm9wO4KZlIiALNQRSdgp7g/bmAMFBmY8VZV/OU/r78L02o316rEpgN6gGmiTkj8M4fo/k05VFn1AVsQFHoTrB4ninTjTwFHIr1dsek24mwnePhQ2Be+cqIbnwT446UeRaQWv5EGDpU+B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ebc907-9432-46bf-d22f-08d77422cbfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 16:48:29.7642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqyxkR1a/XZU04I+zcTEI9im8N5vNbJ8ag/rIW80CKA17hiXjU304NATgg2jRPR9GUJ3q5V6VxAYEo88YSYgWsvVDVoB3fVnNMvu2mwwctc=
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

V2hlbiBRT00gQVBJcyB3ZXJlIGFkZGVkIHRvIGljaDkgaW4gNmYxNDI2YWIsIHRoZSBnZXR0ZXIg
Zm9yIHNjaV9pbnQgd2FzDQp3cml0dGVuIHVzaW5nIHVpbnQzMl90LiBIb3dldmVyLCB0aGUgb2Jq
ZWN0IHByb3BlcnR5IGlzIHVpbnQ4X3QuIFRoaXMNCmZpeGVzIHRoZSBnZXR0ZXIgZm9yIGNvcnJl
Y3RuZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgRnJhbmNpb3NpIDxmZWxpcGVAbnV0YW5p
eC5jb20+DQotLS0NCiBody9pc2EvbHBjX2ljaDkuYyB8IDYgKystLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2lz
YS9scGNfaWNoOS5jIGIvaHcvaXNhL2xwY19pY2g5LmMNCmluZGV4IGY1NTI2ZjljM2IuLjNhOWM0
ZjA1MDMgMTAwNjQ0DQotLS0gYS9ody9pc2EvbHBjX2ljaDkuYw0KKysrIGIvaHcvaXNhL2xwY19p
Y2g5LmMNCkBAIC02MzEsOSArNjMxLDcgQEAgc3RhdGljIHZvaWQgaWNoOV9scGNfZ2V0X3NjaV9p
bnQoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5hbWUsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApDQogew0K
ICAgICBJQ0g5TFBDU3RhdGUgKmxwYyA9IElDSDlfTFBDX0RFVklDRShvYmopOw0KLSAgICB1aW50
MzJfdCB2YWx1ZSA9IGxwYy0+c2NpX2dzaTsNCi0NCi0gICAgdmlzaXRfdHlwZV91aW50MzIodiwg
bmFtZSwgJnZhbHVlLCBlcnJwKTsNCisgICAgdmlzaXRfdHlwZV91aW50OCh2LCBuYW1lLCAmbHBj
LT5zY2lfZ3NpLCBlcnJwKTsNCiB9DQogDQogc3RhdGljIHZvaWQgaWNoOV9scGNfYWRkX3Byb3Bl
cnRpZXMoSUNIOUxQQ1N0YXRlICpscGMpDQpAQCAtNjQxLDcgKzYzOSw3IEBAIHN0YXRpYyB2b2lk
IGljaDlfbHBjX2FkZF9wcm9wZXJ0aWVzKElDSDlMUENTdGF0ZSAqbHBjKQ0KICAgICBzdGF0aWMg
Y29uc3QgdWludDhfdCBhY3BpX2VuYWJsZV9jbWQgPSBJQ0g5X0FQTV9BQ1BJX0VOQUJMRTsNCiAg
ICAgc3RhdGljIGNvbnN0IHVpbnQ4X3QgYWNwaV9kaXNhYmxlX2NtZCA9IElDSDlfQVBNX0FDUElf
RElTQUJMRTsNCiANCi0gICAgb2JqZWN0X3Byb3BlcnR5X2FkZChPQkpFQ1QobHBjKSwgQUNQSV9Q
TV9QUk9QX1NDSV9JTlQsICJ1aW50MzIiLA0KKyAgICBvYmplY3RfcHJvcGVydHlfYWRkKE9CSkVD
VChscGMpLCBBQ1BJX1BNX1BST1BfU0NJX0lOVCwgInVpbnQ4IiwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICBpY2g5X2xwY19nZXRfc2NpX2ludCwNCiAgICAgICAgICAgICAgICAgICAgICAgICBO
VUxMLCBOVUxMLCBOVUxMLCBOVUxMKTsNCiAgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50OF9w
dHIoT0JKRUNUKGxwYyksIEFDUElfUE1fUFJPUF9BQ1BJX0VOQUJMRV9DTUQsDQotLSANCjIuMjAu
MQ0KDQo=

