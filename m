Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75AAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 17:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998A82158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 17:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="U2gDZYFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998A82158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iakPx-0003fd-Ow
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 12:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iakMC-00022a-C7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iakM6-0000GO-An
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:47:00 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:57562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iakM5-00005E-OT
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:46:58 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATHfrO0011297; Fri, 29 Nov 2019 09:46:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=S6WqPn7brfWG3Z6l7/S1xkt2Z1zZeGJMMIdjylrfXpY=;
 b=U2gDZYFKMVaBOcVK3UiTjVfMf6/86TFfDOblCjICZtL0fZxMRPwweeH0AQ9XF+uJuovd
 7tCzZeCjOZqve/1T/HP2J5+/c4sahSfRgoQufL3psJWzq+hpmUVQ4WUyptrHRu5yXhcb
 DjY5aFuG2mvkafArQFqAUZuAGm1hcv1DH0HzPxs7RMGbSWgw8qLUHgmIieR6/12noTxA
 SMRStmcqBnqk4e3BaqD7elsaB6m85Cppdcw7uS+2wIjJ+UDkYBxcSuKQCiHyxxzILsQM
 S6IoBdAK1ARZVAMtCfYActc65Y9Hit3A8zw3STwpnXdyHFBqOrcps1iSTOJ5QP4JvB5/ aw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2whhdhwdb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Nov 2019 09:46:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYb3XQNofUvWvABsOd5/VcT62qIcrZUTzfqUKrUxJ+HUES8twdalGbaXmDxeizrz6jDd/Hdrqshawc7KwPjBz+frvsMf20WxcliGAuxPfa0tLaoPsF76Rd5MrTxAN32bvX3R7Xl9BztejrgQ4zY8aufU4TgDUAgOTb3K7aEjwVwswi7Ho5Ac4LzNB+zYn/HlVROsSqbSFoOXz1gvk2qZbEYrtGy9SEGJIK+/6jFmlH5Lv9pejuLQh3g5gJP7uZN2A9uQEHb/4kkNdO3wGlD40GLf5K0fGv91f9Ld6qaFA8aI+Xj4e/a16nl/RCkIbMEQyIMFT0qyf0LycIJvw/v51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6WqPn7brfWG3Z6l7/S1xkt2Z1zZeGJMMIdjylrfXpY=;
 b=Pck/dJnJdzMpm+yH0JVeAolv7uJSMdf6D+MHuzV5mUuj3zln1xiPNC71ZQ1LtpC2GgiXh6xxItQeM7SabieGWn8eAe0L02Cs6xKPTRD+7acmRUv1c1t2gl8hKLXRRJUDJfCDBMYISbc/sfpz136QM/PpSTc5JglLhnhwgV9sUd6TrkBUWIDLDqE3mFNFs4+Cv3td/UjuoS97zH0KWObQCUXNUf8SMLDwH4Z+tPRLczaH7tennemjYEJ8maADPNW/ZM1IGEFRAaasTrK1ZDXISuQpec/ScBwDBHzSw+qzzTMqT6AlXg1FNIn1G+5ddxxlb8AXJXIbv54UTNr0NVc0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2239.namprd02.prod.outlook.com (10.168.244.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 29 Nov 2019 17:46:52 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 17:46:52 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Philippe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v3 2/4] ich9: fix getter type for sci_int property
Thread-Topic: [PATCH v3 2/4] ich9: fix getter type for sci_int property
Thread-Index: AQHVptz7jwTIuUrhYUeaYyd3XQrOHw==
Date: Fri, 29 Nov 2019 17:46:51 +0000
Message-ID: <20191129174630.6922-3-felipe@nutanix.com>
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
x-ms-office365-filtering-correlation-id: 266de0b7-7e70-49cb-dcad-08d774f41dce
x-ms-traffictypediagnostic: MWHPR02MB2239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB22396928F91AB0F1F3EDBF1AD7460@MWHPR02MB2239.namprd02.prod.outlook.com>
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
x-microsoft-antispam-message-info: 1fDV339HLClPPqNYR4Vxpcdu9bt0M4jaUP318UiSNWERb9I1BbXs2OSd/8DM5FQ5Qv+b6bHvudRBGAmopE0TwlrT1T2O74zKfgPu0SyuXROetBw3EeFiWkAbP5uHyrgttEYB2R6nrYY5AjJf6nDecca2X3dP3whLbbFEYtkt0m79tX0D/akdmKKTL5LevixG3Vc2iBAA+dpyAyOY2C9FCtkQWZ7C8RVFPL2NcdQgD+MQQaY4d3W5QI0UkBoEnng7ar+tEtuVo94kB+F9mD/HYC1E7nPqy3Tx1h/X0rtooDOf2Tc/h1tBNA6BrUt7FtigRP/ZxqUGgFHzNjorAXvgsTwubDzI4564DB4YfNEybHiZb8BxioCifBUuV4kdHmFKgt6Jc+gZO+1rXcvQ9Q9q5TxPOjF1hqNDG93HKYKNhrMMFPiVPP66eywF5eiTRp7F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266de0b7-7e70-49cb-dcad-08d774f41dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 17:46:51.9052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EineCm626MtLwqb3X41W5fqSCr8CQV6yIsJW2pN5xRRvFTx84t6CA71wCzREqS4SZfSmsC2wPwduwpxwunyTbT0nYI2sHNPfsseRJZa1+VM=
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

