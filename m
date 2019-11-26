Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE986C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A112075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vQo32AA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A112075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXaW-0002XS-Qj
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iZXZE-0001ic-NW
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iZXZC-0004jE-Og
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:55:31 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:11698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iZXZC-0004j2-Gg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:55:30 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQ9lfaN025892; Tue, 26 Nov 2019 01:55:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=hh6JRPx9Am6gKkV6gqLwHFc/W4wrznL+WR9Ipz4/En8=;
 b=vQo32AA7ndWbfK9gtUH/fStIE9H6r75lKe8NOzdeWlxe2hgx0LQ32UGAH4qKUupg40E8
 N7xgIQL84hbC+VN+YNyBLWUgOFqHqVInZOLmjY/FOdpoH2OFK3F+FVMa/XSr6VcXFg42
 QvD4DtLivRY47iouRXfhWyEHIuVc7PelX2iqaOKEfCfo5Z7c9zXDZrSVZLlMzT13oi7h
 coUEhcrxbnxuOoI7sCrYxulpJ9A/PvnY6uECVCeL9egK7g2zWpQjYM6RPP+Dn8aOy2bG
 Nw15YFVhHDd8cTiPkmTfMGom+IN6DzRcWfDJkYVx0ZtjtbLWRnL3paLD5KnlcIu+vGon VA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wf4yn600u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Nov 2019 01:55:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyTzgXmbrxCPjVTDNMIZY0vYm183qSCGMv+qvE+B+MRBmEozYOPMCEnpsBVrXh0Ayt/F0GYNg6o5e8g94az7/6YI39kOKHWiGkWNwLZ4niBQN88FYPC9IlVeQSfxdoKvK6zZWYYwqmJd/fo2+VXppshkakoNfw0n2iDB5vtmNnnrJzuL6YhOx+Xtz6CP/7YDR+EQFlggERXZjanPVeXXsLSI1bNGjk5sKuXGrUXD2gbRpXwLtlP+XQG18jyyIaqEO1yt7Si12LUUbAD2qwkpwR0NR22wmwMIyQ0Zpgft6NyBuxuTkZEW2asvvMXA/9zGJAD0K0q42+noZuJY8t6uSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh6JRPx9Am6gKkV6gqLwHFc/W4wrznL+WR9Ipz4/En8=;
 b=JgkhzNTKBRNuRdc1QfYZwlmIFKk0s+7WEa3Uc9tEE7RyH9BtDr1jLkF53dDyjMeDitSgkFFxVzA+Yk8rNlCI5W6bazzKhjd1gG4mrHR2YbLS+x75+D3evX9jCZJLo2hZiudEzyhjHlYj8yHKrDNg9pdF0T8Nb6X3x0n4huhrESWYRT/ij07kf67xMrNXikcSR1Ns4JzghbjhPrbHYbOttMBK7/MuBdVEKZPa4a4xM8jfaWqdQUCiGbh4AGgFZ06vMD0VA3lQWpCjhofKj2WKzu/WwZNqQMWZ3IyioXmL4dmbRyW0rP/wt4zN2o0/H56fjcmq2D5jPahCMagSQ6s7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2192.namprd02.prod.outlook.com (10.168.245.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.24; Tue, 26 Nov 2019 09:55:27 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 09:55:27 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 2/4] ich9: fix getter type for sci_int property
Thread-Topic: [PATCH 2/4] ich9: fix getter type for sci_int property
Thread-Index: AQHVo6YgVQPIYdSUK0GhG0cq3dH2n6ecF68AgAEgRQA=
Date: Tue, 26 Nov 2019 09:55:27 +0000
Message-ID: <A32BEB22-B87F-4CDC-8CE4-AE039DC82558@nutanix.com>
References: <20191125153619.39893-1-felipe@nutanix.com>
 <20191125153619.39893-3-felipe@nutanix.com>
 <deed1398-8b39-02b9-6da5-6d1fc4edff4b@redhat.com>
In-Reply-To: <deed1398-8b39-02b9-6da5-6d1fc4edff4b@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93d66bb8-7294-429a-92ba-08d77256c3fb
x-ms-traffictypediagnostic: MWHPR02MB2192:
x-microsoft-antispam-prvs: <MWHPR02MB2192DF8577DC8258927E6C1ED7450@MWHPR02MB2192.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(51914003)(256004)(64756008)(66066001)(6512007)(66556008)(316002)(6916009)(186003)(5660300002)(229853002)(6486002)(36756003)(76116006)(26005)(86362001)(6116002)(478600001)(102836004)(6506007)(3846002)(99286004)(53546011)(8676002)(71200400001)(71190400001)(7736002)(446003)(91956017)(11346002)(2906002)(4326008)(2616005)(81156014)(33656002)(54906003)(8936002)(305945005)(66446008)(66946007)(14454004)(76176011)(25786009)(6246003)(66476007)(6436002)(81166006)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2192;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xnc6Y7X7YEZCvG7UzW9/ol41U8dly3IAWmV677p5DBzCC4r6V2qkm+VQpKjuAZ26bSQMU4LPMJs1NOXpM7i57rg8TyYV8vb03V4c85O5aQzLSRN8GRBC9oVqKzoZZrTCHbo4pS3KXk9M5ckFJHp86BU/XuhLD97vYwJzqEJKbxucnJIFWeXAqCSouIxJxKnCauljkCDhGXb4BXBQp0X2ByX2W8hTqha7vtja5ZuEUX6mQDo568FxWXOKuQFpJKz+L72YDZErE2FaT8MjQ5KZbJn0FAVEMQyIQo7q/R10Ztf1SWQ13ANMSF2pfd0VtepwhLvgB2FuW+8wmsVgm0j84EDSL0HtqBLwsHvd8JUNusiqUWji5mBp+b4dzIfwIxNbNtgYSZz0OR8/A0a8AkCOvlYvRAdnLHRbR+tmGf+Av2wHQcEvEixHT55qtShA/Eb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCF03612E29B0740A3192ACD3E0E4B81@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d66bb8-7294-429a-92ba-08d77256c3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 09:55:27.3004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQ70/DJ5H/gj+6yYjfQGrScCFVjdKptECT4nZV5kByq/H78kwsS9+HT5HWAtnqugpgFgu1t+AAajI22c77SYek/MWGd6iY1I4+c5opXo+3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2192
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_01:2019-11-26,2019-11-26 signatures=0
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
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkNCg0KPiBPbiBOb3YgMjUsIDIwMTksIGF0IDQ6NDMgUE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8yNS8xOSA0OjM2IFBN
LCBGZWxpcGUgRnJhbmNpb3NpIHdyb3RlOg0KPj4gV2hlbiBRT00gQVBJcyB3ZXJlIGFkZGVkIHRv
IGljaDkgaW4gNmYxNDI2YWIsIHRoZSBnZXR0ZXIgZm9yIHNjaV9pbnQgd2FzDQo+PiB3cml0dGVu
IHVzaW5nIHVpbnQzMl90LiBIb3dldmVyLCB0aGUgb2JqZWN0IHByb3BlcnR5IGlzIHVpbnQ4X3Qu
IFRoaXMNCj4+IGZpeGVzIHRoZSBnZXR0ZXIgZm9yIGNvcnJlY3RuZXNzLg0KPj4gU2lnbmVkLW9m
Zi1ieTogRmVsaXBlIEZyYW5jaW9zaSA8ZmVsaXBlQG51dGFuaXguY29tPg0KPj4gLS0tDQo+PiAg
aHcvaXNhL2xwY19pY2g5LmMgfCA2ICsrKy0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaXNhL2xwY19pY2g5
LmMgYi9ody9pc2EvbHBjX2ljaDkuYw0KPj4gaW5kZXggNTU1NWNlMzM0Mi4uMjQwOTc5ODg1ZCAx
MDA2NDQNCj4+IC0tLSBhL2h3L2lzYS9scGNfaWNoOS5jDQo+PiArKysgYi9ody9pc2EvbHBjX2lj
aDkuYw0KPj4gQEAgLTYzMSw5ICs2MzEsOSBAQCBzdGF0aWMgdm9pZCBpY2g5X2xwY19nZXRfc2Np
X2ludChPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUsIEVycm9yICoqZXJycCkN
Cj4+ICB7DQo+PiAgICAgIElDSDlMUENTdGF0ZSAqbHBjID0gSUNIOV9MUENfREVWSUNFKG9iaik7
DQo+PiAtICAgIHVpbnQzMl90IHZhbHVlID0gbHBjLT5zY2lfZ3NpOw0KPj4gKyAgICB1aW50OF90
IHZhbHVlID0gbHBjLT5zY2lfZ3NpOw0KPj4gIC0gICAgdmlzaXRfdHlwZV91aW50MzIodiwgbmFt
ZSwgJnZhbHVlLCBlcnJwKTsNCj4+ICsgICAgdmlzaXRfdHlwZV91aW50OCh2LCBuYW1lLCAmdmFs
dWUsIGVycnApOw0KPiANCj4gTWF5YmUgZGlyZWN0bHkgYXM6DQo+IA0KPiAgICAgICB2aXNpdF90
eXBlX3VpbnQ4KHYsIG5hbWUsICZscGMtPnNjaV9nc2ksIGVycnApOw0KPiANCg0KVGhhbmtzIGZv
ciB0aGUgc3VnZ2VzdGlvbi4gSSdsbCBpbXByb3ZlIGl0IG9uIGEgdjIgd2hpY2ggSSdtIHNlbmRp
bmcNCm91dCBhbnl3YXkgZm9yIG90aGVyIHJlYXNvbnMuDQoNCkZvciBteSBvd24gc2FrZTogd2h5
IGlzIHRoZSBmaWVsZCBjYWxsZWQgInNjaV9nc2kiLCBidXQNCkFDUElfUE1fUFJPUF9TQ0lfSU5U
IChhbmQgdGhlIGdldHRlcikgYXJlIGNhbGxlZCAic2NpX2ludCI/DQoNClRoYW5rcywNCkYuDQoN
Cj4gV2l0aC93aXRob3V0IHN0YWNrIHZhcmlhYmxlOg0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiANCj4+ICB9DQo+PiAgICBzdGF0
aWMgdm9pZCBpY2g5X2xwY19hZGRfcHJvcGVydGllcyhJQ0g5TFBDU3RhdGUgKmxwYykNCj4+IEBA
IC02NDEsNyArNjQxLDcgQEAgc3RhdGljIHZvaWQgaWNoOV9scGNfYWRkX3Byb3BlcnRpZXMoSUNI
OUxQQ1N0YXRlICpscGMpDQo+PiAgICAgIHN0YXRpYyBjb25zdCB1aW50OF90IGFjcGlfZW5hYmxl
X2NtZCA9IElDSDlfQVBNX0FDUElfRU5BQkxFOw0KPj4gICAgICBzdGF0aWMgY29uc3QgdWludDhf
dCBhY3BpX2Rpc2FibGVfY21kID0gSUNIOV9BUE1fQUNQSV9ESVNBQkxFOw0KPj4gIC0gICAgb2Jq
ZWN0X3Byb3BlcnR5X2FkZChPQkpFQ1QobHBjKSwgQUNQSV9QTV9QUk9QX1NDSV9JTlQsICJ1aW50
MzIiLA0KPj4gKyAgICBvYmplY3RfcHJvcGVydHlfYWRkKE9CSkVDVChscGMpLCBBQ1BJX1BNX1BS
T1BfU0NJX0lOVCwgInVpbnQ4IiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBpY2g5X2xw
Y19nZXRfc2NpX2ludCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBOVUxMLCBO
VUxMLCBOVUxMKTsNCj4+ICAgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50OF9wdHIoT0JKRUNU
KGxwYyksIEFDUElfUE1fUFJPUF9BQ1BJX0VOQUJMRV9DTUQsDQo+IA0KDQo=

