Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E40C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D117227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="D8zdKLya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D117227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0FP-0004hY-LU
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ii08E-00042l-R9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ii08D-0002Ph-1l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:38 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:16562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ii08C-0002Mv-QF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:02:36 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJHuTSC007105; Thu, 19 Dec 2019 10:02:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=S6WqPn7brfWG3Z6l7/S1xkt2Z1zZeGJMMIdjylrfXpY=;
 b=D8zdKLya7cu48LMlSJ8nOAGMLp2GDETJFn7xVyC7nJsP5kHuSLDizVd5AaRKNIeaTVyc
 1LxglO1DA5kQJt9CTXD1VPVp7s7U860xclwq55rnikNpvaVSJbSydj3vz9rBNEaFxCyH
 xBRo+1U30Dn2S6B6WDGITrNt+8xY25pOV3pDztyUpIvYDKkKWaTB1cdQOZ+2JvtPFtzm
 mVGi0yn6dLtBac9df3BTk1r5gg+jpnxFmU4glEyrXTZYlWXnLPm1jLwQGyrbZCU/Km3O
 eZcipQb0ENIfBA9QJj71m7FcuQf+8CkTZOo0CPQhLxu6wVDZb32Wq8ypxcyxIV8460VV MA== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wvxqqbe8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 10:02:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGF9A1u/tyZ1XsXAdxsF2XxiLHgShzZxDig1VhqH1sskTxRlVdw8ABbCfNPvPIEKC8ZNLZCRdrhC/dizZAHZcNHGLcli18toB/q6gisMHAFeJAquzA6IjZ9jkW+eX6fBJzoLSgHDRlkwuKqidw81pbiVvv9gG1borQhLxBhFL3kZFPU8e35d9rcXlfSC3kRA4GXDhM+bzC6chVKEOh5rdUlVtkIsCBdzrc363uAXx1iVWWVB4HeJOuEfyF6+EbDzTQ2FMdiqeMElgwcCe0RJO/zEi8/V2NFzeCLQjC+2twJW82TABkHz1zoGm6pRNtmpe5nLc+mniJShrQFxxWNtsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6WqPn7brfWG3Z6l7/S1xkt2Z1zZeGJMMIdjylrfXpY=;
 b=kxRo0qUTB/vY1y06RpJ0tzwEUVo6fnJSWJHx+Rfb58utEKwM4rJgmPS262Gu+Q/rE/qWMwBKkuAYFGugLKq7d9OZegw3fRNHzdR05vgCtgk1Df171sWA4PN8vvYFWFfoOGg2NsTya6HI0GiGj1EblgzVWoVNelzJ4NbjOX5y4iYlxfW8SiYjfeZInVNP3pUjqh255DJ9e88VrBjgy6BYww8hF+DTmckHiPse2Hc9hGksveo1DUhw8hLRSCO4XJ5s/+0bngzWxQbrptJwl+Y/21EEjvMY7Nu8TqgSgEqVS+DB7XQ18EuQ4IrK8Ml+3U18XCG0C0R/BEP+vDOLQWtjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2303.namprd02.prod.outlook.com (10.168.245.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 18:02:34 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 18:02:34 +0000
Received: from nutanix.com (82.9.225.166) by
 AM4PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:205:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.4 via Frontend Transport; Thu, 19 Dec 2019 18:02:31 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Phillipe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v4 2/4] ich9: fix getter type for sci_int property
Thread-Topic: [PATCH v4 2/4] ich9: fix getter type for sci_int property
Thread-Index: AQHVtpZ9j2kAYYTqW0eR9OoUIyOwdg==
Date: Thu, 19 Dec 2019 18:02:33 +0000
Message-ID: <20191219180205.25191-3-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: 8d153c7b-d81a-4196-c50f-08d784ad9f85
x-ms-traffictypediagnostic: MWHPR02MB2303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB23030C2A2F6EE56CE2A3C2B1D7520@MWHPR02MB2303.namprd02.prod.outlook.com>
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
x-microsoft-antispam-message-info: UVnbDx2n8wATU1tJxkjNvF7uYcisDg0CyxR+IndOnA1zhEt5YYhp7nDlrntm0RZ3KoSx8MTc/3q60MiPKKaybTNdS1JBe7CXpwkWiZHM6Bpb9sF7wkfbnO/ue9lxuOJWueK/LxgTakd4dtW7sBppnTKtYlTOSMTj4MQY1GJizEnXeqfJIEkx2tM0C4i/AN5mIOWAu68VDrK32ESjZ0AMN5MyJycjfthq3oHogKtEHfq2r0P3HaichT8iBCDFP7g9vyJ40jMjSi9s/9193E20jMWSxuH1Jk8e0ocBBYr4JjR+066RNNEnsqmE6ac6XEEA5EOJeCpFsbOxDtROtgiQ0mrUpm0U04j5EkBH7FBZv+Ra6sro8YGDn2nhKh5iosGhNYAyjHP2WokaW/eAWMq0w8+miDZ73TWQ4w1O4dvSvb3a/JJkMqJzMpvsfGfGCQA2jYoBhP1v5caUgtytN8ND/3ECs9qeqXHZ1DGBnV/Du5+2D2Pqy1zjdtizrE34LI3A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d153c7b-d81a-4196-c50f-08d784ad9f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 18:02:34.0125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AMnxRkCP7KaMyWfSVAJuNAWyVWrjg/08WIYFcrGjossiMkdjld7rBce3oYeNwiAkEy9Uh4OaEggpmMjj3IVkMc7MlgDNt1RKT1znEduGcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_04:2019-12-17,2019-12-19 signatures=0
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
eC5jb20+DQotLS0NCiBody9pc2EvbHBjX2ljaDkuYyB8IDYgKystLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2lz
YS9scGNfaWNoOS5jIGIvaHcvaXNhL2xwY19pY2g5LmMNCmluZGV4IDk5NTE3YzM5NDYuLjlmNGUw
MGRkZGQgMTAwNjQ0DQotLS0gYS9ody9pc2EvbHBjX2ljaDkuYw0KKysrIGIvaHcvaXNhL2xwY19p
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

