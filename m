Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA60C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AEF205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ykq7wUfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AEF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxj4b-0004EJ-CW
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shaju.abraham@nutanix.com>) id 1hxj3o-0003hg-CJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shaju.abraham@nutanix.com>) id 1hxj3n-0004sX-5k
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:30:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:16200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shaju.abraham@nutanix.com>)
 id 1hxj3j-0004qf-59; Tue, 13 Aug 2019 22:30:43 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x7E2Jl2L009978; Tue, 13 Aug 2019 19:30:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=T7/Usmah/OERe8jUCGo6c0wIYTgyVzKAR7CCuFXJg4I=;
 b=Ykq7wUfbayjrfcdVtex/M+DqvQiM2ME+qz2QlcIIKwizEoSkdU8QVhByDvHL3YzjOXav
 UHKXbCZxErWp8PszDY7J1/VL6880q5diZjy3EqsFOcCHuMAETGbr5Z9BC2sr+Y80Y8ZW
 FCPCRei2/5J4AYZ2ATsnHUNiUxICRHpSmoqenWoGSyeaVlTy20Gz0nsF0qn3D5ZxbefQ
 6R0vLm3gpuYl58xNE6i+61KsrcY4wx0WYweLPf2YhZ9DxMHv+6/Sh9YSIRmMYctFtD59
 RJn6zHijP5hrJYir/YORlSJj9WEyvMxbJ6xHHcYGtTfwJ1vvGZOcVOaNWAO0DcZN4/0P aQ== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2ubf9uanhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Aug 2019 19:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSsi4Hcs2rYPsO4uUP6EWNH/klsECMpXwcUQKVb8BZHjxWUWZ6I+VEJ4aYTH8kVu1DIty3sjSPHCXTjfEnj9Nt3UwZKjkNQZi0tqqD8lc8H/1PezCKFvsXB/tbfxwqv2D7HDLDUN2esUfONpuP+sgKp2pY2c9rf5cOUWqoIaQFfa48x+Jh79MVXanZn95N1OU9rjmPXTLyc7hzEtpmfFt4C8V0y3rq6tAtK5muCMkgGP2ozy3jm5zwUem1BbVkzit6KuvyTW7ZcL73v03bSuT58N73diLwP2XI2BK9tE4pNhKjGptjlflRCnl+Wzq2loApHkrvUx4aBXB0ybTbu7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7/Usmah/OERe8jUCGo6c0wIYTgyVzKAR7CCuFXJg4I=;
 b=W0LbiRSrHUEVbQwkJvFL58Q3fDtZUfTbphtrVxOBfC+Gz7SNQ4kJIZpyAeVUy7WHCKZSnfHWRG8t2pnNcbEs0EQnrBxbXrmIqHIZm5aUQzrFPv7Ra7ulyRWUfddk9M2T07FAmUTMJOwvfvJfabBWLClae/nutdRjKPvmuxSX8CP7k/jwpBxYgTzE1BHIhtEPVKTmMlovfPoOhgI0xHGTCv/HhGgr7DcdYaIDsJwjJxFAlG2fR/79V0myNLKA2b4vtwMyRHW0DeRbAPM/VU0vyAUWDPRTajt5XmPGh74EOwiZ8S6Y0nFQ72moUt78CNEb6Wiz1pwlmIR74A8OA5vAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH2PR02MB6232.namprd02.prod.outlook.com (52.132.230.90) by
 CH2PR02MB6728.namprd02.prod.outlook.com (10.141.156.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Wed, 14 Aug 2019 02:30:38 +0000
Received: from CH2PR02MB6232.namprd02.prod.outlook.com
 ([fe80::3dae:7cab:4413:83ce]) by CH2PR02MB6232.namprd02.prod.outlook.com
 ([fe80::3dae:7cab:4413:83ce%2]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 02:30:37 +0000
From: Shaju Abraham <shaju.abraham@nutanix.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] Fix Guest VM crash due to iSCSI Sense Key
 error
Thread-Index: AQHVNTiRlO1P+Y+W70266g1lIkgPlqb56NGAgACZcwA=
Date: Wed, 14 Aug 2019 02:30:37 +0000
Message-ID: <E8B4337F-05BF-4467-8C05-FF8C26A41BF9@nutanix.com>
References: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
 <9d75160a-1355-81ce-c9ec-2994c1781643@redhat.com>
In-Reply-To: <9d75160a-1355-81ce-c9ec-2994c1781643@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.68.105.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fec8533e-3846-4e5c-9313-08d7205f64bd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CH2PR02MB6728; 
x-ms-traffictypediagnostic: CH2PR02MB6728:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CH2PR02MB67286E02256238A284561D47FBAD0@CH2PR02MB6728.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(11346002)(102836004)(7736002)(14444005)(4326008)(256004)(33656002)(305945005)(966005)(14454004)(26005)(6506007)(486006)(66066001)(186003)(2616005)(476003)(53546011)(25786009)(44832011)(8676002)(6116002)(3846002)(2501003)(76176011)(53936002)(66556008)(110136005)(316002)(99286004)(6486002)(81156014)(446003)(64756008)(478600001)(81166006)(5660300002)(71200400001)(71190400001)(8936002)(6436002)(6246003)(36756003)(2906002)(6512007)(66446008)(6306002)(76116006)(91956017)(66476007)(229853002)(86362001)(66946007)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR02MB6728;
 H:CH2PR02MB6232.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sBrRiocEp7R1Sx7Pzt23i3hdhkBNGbK8TdvZrUjaA0ejnkueiNuOWl/vo/R6oyujkC0ahpYluIozqjxVwYmYgAS0Vnq0s08X6nOLjqkSoFfya3/LgoluXZvalj1E0QSsxmoHmdUcDVz4SO/yHidWmCbXlLcr/E5GKEFOvBQK5Vu3TwCl50Wkap2Z2xO0AmR08XxNI4PsciVOtbsYIhCYHqY/oOdSDPkRllXp4BF8nJ09IcHqZfA8ijJ8RauG4JhB3RnH64zFDLr/5sE7ZB/koLRr1WaVf5ACsk67RYJgbN8iqUdi3oSxvlDnWjgtz2zCMbaAhHNjK4876rjIeU8jjfL/Vt1pz/DAtKScw7GaC/R82BzyJJj+dcyRxLSZp1PUg97vijBuWnbih2/yCQdu16/jT88UWpjPidAme6VSRrA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <097AA3FD854F464CBDD81405FCD098FD@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec8533e-3846-4e5c-9313-08d7205f64bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 02:30:37.7883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cu7xXRXXrCTcbTgfgcO+iXe68O2jZZqzzGpXhloohG5ZPpZJqQKtGiGNb6CC9FeeC4zJygpqaAT/jW28SS08dHegcu6K4bh0XaNPISE7JiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-13_07:2019-08-13,2019-08-13 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
Subject: Re: [Qemu-devel] [PATCH] Fix Guest VM crash due to iSCSI Sense Key
 error
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBkbyBub3QgaGF2ZSBhIHRlc3QgY2FzZSB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZS4gSXQgaXMg
c2VlbiByYXJlbHkuIFRoZSBmaXggbG9va3MgZ29vZCB0byBtZSwgd2lsbCBjb25maXJtIGlmIEkg
YW0gYWJsZSB0byByZXByb2R1Y2UgdGhlIGVycm9yIHNjZW5hcmlvLg0KDQpSZWdhcmRzDQpTaGFq
dQ0KDQrvu79PbiA4LzE0LzE5LCA0OjIxIEFNLCAiSm9obiBTbm93IiA8anNub3dAcmVkaGF0LmNv
bT4gd3JvdGU6DQoNCiAgICANCiAgICANCiAgICBPbiA3LzcvMTkgMTA6NTUgUE0sIHNoYWp1LmFi
cmFoYW1AbnV0YW5peC5jb20gd3JvdGU6DQogICAgPiBGcm9tOiBTaGFqdSBBYnJhaGFtIDxzaGFq
dS5hYnJhaGFtQG51dGFuaXguY29tPg0KICAgID4gDQogICAgPiBEdXJpbmcgdGhlICBJREUgRE1B
IHRyYW5zZmVyIGZvciBhIElTQ1NJIHRhcmdldCx3aGVuIGxpYmlzY3NpIGVuY291bnRlcnMNCiAg
ICA+IGEgU0VOU0UgS0VZIGVycm9yLCBpdCBzZXRzIHRoZSB0YXNrLT5zZW5zZSB0byAgdGhlIHZh
bHVlICJDT01NQU5EIEFCT1JURUQiLg0KICAgID4gVGhlIGZ1bmN0aW9uIGlzY3NpX3RyYW5zbGF0
ZV9zZW5zZSgpIGxhdGVyIHRyYW5zbGF0ZXJzIHRoaXMgZXJyb3IgdG8gLUVDQU5DRUxFRA0KICAg
ID4gYW5kIHRoaXMgdmFsdWUgaXMgcGFzc2VkIHRvIHRoZSBjYWxsYmFjayBmdW5jdGlvbi4gSW4g
dGhlIGNhc2Ugb2YgIElERSBETUEgcmVhZA0KICAgID4gb3Igd3JpdGUsIHRoZSBjYWxsYmFjayBm
dW5jdGlvbiByZXR1cm5zIGltbWVkaWF0ZWx5IGlmIHRoZSB2YWx1ZSBvZiB0aGUgcmV0DQogICAg
PiBhcmd1bWVudCBpcyAtRUNBTkNFTEVELg0KICAgID4gTGF0ZXIgd2hlbiBpZGVfY2FuY2VsX2Rt
YV9zeW5jKCkgZnVuY3Rpb24gaXMgaW52b2tlZCAgdGhlIGFzc2VydGlvbg0KICAgID4gInMtPmJ1
cy0+ZG1hLT5haW9jYiA9PSAoKHZvaWQgKikwKSIgZmFpbHMgYW5kIHRoZSBxZW11IHByb2Nlc3Mg
Z2V0cyB0ZXJtaW5hdGVkLg0KICAgID4gRml4IHRoZSBpc3N1ZSBieSBtYWtpbmcgdGhlIHZhbHVl
IG9mIHMtPmJ1cy0+ZG1hLT5haW9jYiA9IE5VTEwgd2hlbg0KICAgID4gLUVDQU5DRUxFRCBpcyBw
YXNzZWQgdG8gdGhlIGNhbGxiYWNrLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBTaGFq
dSBBYnJhaGFtIDxzaGFqdS5hYnJhaGFtQG51dGFuaXguY29tPg0KICAgID4gLS0tDQogICAgPiAg
aHcvaWRlL2NvcmUuYyB8IDEgKw0KICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KICAgID4gDQogICAgPiBkaWZmIC0tZ2l0IGEvaHcvaWRlL2NvcmUuYyBiL2h3L2lkZS9jb3Jl
LmMNCiAgICA+IGluZGV4IDZhZmFkZjguLjc4ZWEzNTcgMTAwNjQ0DQogICAgPiAtLS0gYS9ody9p
ZGUvY29yZS5jDQogICAgPiArKysgYi9ody9pZGUvY29yZS5jDQogICAgPiBAQCAtODQxLDYgKzg0
MSw3IEBAIHN0YXRpYyB2b2lkIGlkZV9kbWFfY2Iodm9pZCAqb3BhcXVlLCBpbnQgcmV0KQ0KICAg
ID4gICAgICBib29sIHN0YXlfYWN0aXZlID0gZmFsc2U7DQogICAgPiAgDQogICAgPiAgICAgIGlm
IChyZXQgPT0gLUVDQU5DRUxFRCkgew0KICAgID4gKyAgICAgICAgcy0+YnVzLT5kbWEtPmFpb2Ni
ID0gTlVMTDsNCiAgICA+ICAgICAgICAgIHJldHVybjsNCiAgICA+ICAgICAgfQ0KICAgID4gIA0K
ICAgID4gDQogICAgDQogICAgSG9wZWZ1bGx5IGp1c3QgYXMgYWRlcXVhdGVseSBhZGRyZXNzZWQg
YnkgdGhlIHBhdGNoZXMgaW4NCiAgICANCiAgICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdGh1Yi5jb21fam5zbm93X3FlbXVfY29tbWl0c19p
ZGUmZD1Ed0lDYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9c1ktWGVOcWN1eV9ydUJROVQ3
QTJMbUc2a3R5WVhYU3hSQjFsamt4TWVwSSZtPWxtTm5ITG5zWktFYVprdW5XQk1sZE5QaUw4N3Vu
NFEyQnJ0c2EwekNLaVEmcz1LR21BdGV6NUFja1RwTnVnek16eE1PYmtaS1EzQTV2SUlpdWtTaFZZ
VVhNJmU9IA0KICAgIA0KICAgIGJ1dCBpZiB5b3Ugd2FudGVkIHRvIGdpdmUgaXQgYSB0ZXN0IGFu
ZCBjb25maXJtIGZvciBtZSwgSSB3b3VsZG4ndCBiZQ0KICAgIHVwc2V0IGJ5IHRoYXQuDQogICAg
DQogICAgLS1qcw0KICAgIA0KDQo=

