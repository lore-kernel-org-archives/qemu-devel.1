Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6F9C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5722087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ezu4kxmO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gBrOXZ5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5722087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcIk-0001P8-Gx
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:36:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGJ-0007Z9-Ml
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcGI-0000Ho-Mz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAv-0005zQ-DT; Tue, 30 Apr 2019 19:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556666918; x=1588202918;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=xA3pbxiImBevyHhA8XuRcJTiyv2JoAMsxaYs6g7wvcc=;
	b=ezu4kxmO0cX7PqfqJdVhDDG4vgDk/E/T9hlguhQjBnYS7A9n/q/s/m++
	kImuZGd57Snm4BC8zL8f9u4hEpoP7o5bEmC3EoAx3w77IMhYK4deFYjeY
	HvBWxiZDn//zHiy8RqmjWWFI7/R1XHsoAQLT9Mlh+xCoT5KA7cZhSE5aQ
	8vXGWlDK6LObt1JRqzgCHyVp2wtg9ie4Hgpqf//qB6Olq89+KjmShbn7w
	x4UOp3flQ39AUcIQg+pY/ZNDN8FKX+4Su9EAAwRc78fKMl1Rr1i4rOCBS
	CFffYlxY0BayPHYgO/qoyHz+VqaOOWdVt1J8D/dTiNSkSh4SK/5k80Idh Q==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; d="scan'208";a="108426282"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO
	NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 07:28:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xA3pbxiImBevyHhA8XuRcJTiyv2JoAMsxaYs6g7wvcc=;
	b=gBrOXZ5HjdagQXqPzu/+QH265VaARcLfMo9+bfpbjX+cZJYfT1w2nQR52tlvoeoygmqh4friXEKHRk5jHqql5htUpUDE/56g2OxCHipNoeMTnPSS8lF5H7LHqWXqCLiYTr0bgUXv8pI8DcOsY/UGSupz2fTga83DmkcgQ7Tlb6A=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
	DM6PR04MB5402.namprd04.prod.outlook.com (20.178.27.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Tue, 30 Apr 2019 23:28:32 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2]) by DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2%2]) with mapi id 15.20.1835.015;
	Tue, 30 Apr 2019 23:28:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build warning
Thread-Index: AQHU/6xs8MY4iO8AKkC1lf7A3j3a/Q==
Date: Tue, 30 Apr 2019 23:28:31 +0000
Message-ID:
 <ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
	To DM6PR04MB4908.namprd04.prod.outlook.com
	(2603:10b6:5:19::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87fd24ec-dd2a-4038-9822-08d6cdc38ec4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR04MB5402; 
x-ms-traffictypediagnostic: DM6PR04MB5402:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB54027678A12450A4D1E93203903A0@DM6PR04MB5402.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(366004)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(72206003)(54906003)(6506007)(386003)(76176011)(446003)(14444005)(256004)(36756003)(4326008)(11346002)(102836004)(99286004)(66066001)(5660300002)(86362001)(44832011)(486006)(316002)(26005)(186003)(476003)(66476007)(2616005)(52116002)(66556008)(64756008)(73956011)(66946007)(66446008)(2906002)(6116002)(3846002)(50226002)(2351001)(6512007)(8936002)(6436002)(14454004)(71200400001)(71190400001)(6916009)(53936002)(6486002)(118296001)(81156014)(81166006)(2501003)(478600001)(68736007)(25786009)(5640700003)(8676002)(7736002)(305945005)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB5402;
	H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uUDALsqKXjmNEDqZkLUIT8+Edm+/HKFHKbKgBXldkHJu1C18gi0ASg0nct15dyhb7xAu3NqUsU5ziQnQXx68pVEn7lWexG/wsw9XSXor6u1c3372OE9AhlupqeP9tp2e9lCSVZhAIU1FdXRQdDwsNIOybSYX1Khn3IUlLQEFda40rB892OICGTHEu/c+XFg9HApzRGZTpHAbEtP+yQTIE35hmwet1a/sXqpPliMD53/JxG3I7hi4EyF2hiGf6bgrE7FKAS5X/JNMuhDyQBJ383QCQUthKOQf1Xe8JB1qH/nBJpIVPswnsB2SSJFdW+vTUwP2qj/hyHR7w7Vh4wSqxAI9Jw2DfY5e2jcwGHtljz9rDp8UwOjbK5qt2pmHuZRrjiCnwQcJn6fRRUPpewUj1b248hMJfR4mDIggfwqKW8Y=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <F5CC77A795856C4BB7501572F80D9079@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fd24ec-dd2a-4038-9822-08d6cdc38ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 23:28:31.8700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5402
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build warning
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430232831.GE-2qCn0HYrgIEtUngxUjIKqQU-_4ckTM7U1GKWg204@z>

Rml4IHRoaXMgYnVpbGQgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9o
Y2QteGhjaS5jOjMzMzk6NjY6IGVycm9yOiDigJglZOKAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBi
ZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5dGVzIGludG8gYSByZWdpb24g
b2Ygc2l6ZSA1IFstV2Vycm9yPWZvcm1hdC10cnVuY2F0aW9uPV0NCiAzMzM5IHwgICAgICAgICAg
ICAgc25wcmludGYocG9ydC0+bmFtZSwgc2l6ZW9mKHBvcnQtPm5hbWUpLCAidXNiMiBwb3J0ICMl
ZCIsIGkrMSk7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCmh3L3VzYi9oY2QteGhjaS5jOjMzMzk6NTQ6
IG5vdGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0aGUgcmFuZ2UgWzEsIDIxNDc0ODM2NDddDQog
MzMzOSB8ICAgICAgICAgICAgIHNucHJpbnRmKHBvcnQtPm5hbWUsIHNpemVvZihwb3J0LT5uYW1l
KSwgInVzYjIgcG9ydCAjJWQiLCBpKzEpOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdGRpby5oOjg2NywNCiAgICAgICAgICAgICAgICAg
ZnJvbSAvaG9tZS9hbGlzdGFpci9xZW11L2luY2x1ZGUvcWVtdS9vc2RlcC5oOjk5LA0KICAgICAg
ICAgICAgICAgICBmcm9tIGh3L3VzYi9oY2QteGhjaS5jOjIxOg0KL3Vzci9pbmNsdWRlL2JpdHMv
c3RkaW8yLmg6Njc6MTA6IG5vdGU6IOKAmF9fYnVpbHRpbl9fX3NucHJpbnRmX2Noa+KAmSBvdXRw
dXQgYmV0d2VlbiAxMyBhbmQgMjIgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgMTYN
CiAgIDY3IHwgICByZXR1cm4gX19idWlsdGluX19fc25wcmludGZfY2hrIChfX3MsIF9fbiwgX19V
U0VfRk9SVElGWV9MRVZFTCAtIDEsDQogICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KICAgNjggfCAgICAg
ICAgX19ib3MgKF9fcyksIF9fZm10LCBfX3ZhX2FyZ19wYWNrICgpKTsNCiAgICAgIHwgICAgICAg
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogaHcvdXNi
L2hjZC14aGNpLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlm
ZiAtLWdpdCBhL2h3L3VzYi9oY2QteGhjaS5jIGIvaHcvdXNiL2hjZC14aGNpLmMNCmluZGV4IGVj
MjhiZWUzMTkuLjJiMDYxNzcyYjIgMTAwNjQ0DQotLS0gYS9ody91c2IvaGNkLXhoY2kuYw0KKysr
IGIvaHcvdXNiL2hjZC14aGNpLmMNCkBAIC0zMzIyLDYgKzMzMjIsNyBAQCBzdGF0aWMgdm9pZCB1
c2JfeGhjaV9pbml0KFhIQ0lTdGF0ZSAqeGhjaSkNCiAgICAgdXNiX2J1c19uZXcoJnhoY2ktPmJ1
cywgc2l6ZW9mKHhoY2ktPmJ1cyksICZ4aGNpX2J1c19vcHMsIGRldik7DQogDQogICAgIGZvciAo
aSA9IDA7IGkgPCB1c2Jwb3J0czsgaSsrKSB7DQorICAgICAgICBnX2Fzc2VydChpIDwgTUFYKE1B
WFBPUlRTXzIsIE1BWFBPUlRTXzMpKTsNCiAgICAgICAgIHNwZWVkbWFzayA9IDA7DQogICAgICAg
ICBpZiAoaSA8IHhoY2ktPm51bXBvcnRzXzIpIHsNCiAgICAgICAgICAgICBpZiAoeGhjaV9nZXRf
ZmxhZyh4aGNpLCBYSENJX0ZMQUdfU1NfRklSU1QpKSB7DQotLSANCjIuMjEuMA0KDQo=

