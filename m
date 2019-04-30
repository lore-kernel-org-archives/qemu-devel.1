Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FABC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7273220652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XxZQHdWM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fAjsez1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7273220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZ9W-0006n7-Ce
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:14:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3x-0002PX-6i
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3w-000755-84
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3t-00073c-RO; Tue, 30 Apr 2019 16:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556654950; x=1588190950;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=/kKF262cHiUAFnySiN2hIvVpZWdUfxx0a+lkNg1Ydy4=;
	b=XxZQHdWMsesrZEm7vmgoF/BkNJ9YHc2a7kgJeE6GTIh/Utt5/MXvtGxO
	AFdKzf7JmfrSPmMWav4CRrrwKNlG1BQypEZdPb7nQvwQubsmWK7uzB3v7
	Bag+W16SBsN61VF1j2Ssuy3K2mnqM2r1CjiK+Eg0xlqXhO6x3L52unx/D
	B9hh559nXUyLqDpkWAbUrz130l7ulin6ytkDAB96NZisjTC/oyr/oPJC0
	jILIZXHFIVFZtkouZQOseYarZVmZ4JxQUcwJ0xgywn0UACmy/P3IT2dpt
	N+ZdaYgZSITb9WMv9HFo5Ggbc+RrP2sfXmE2Se4MeAfVrjfiZ+696eZQD w==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; d="scan'208";a="107206319"
Received: from mail-bn3nam01lp2055.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.55])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 04:09:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/kKF262cHiUAFnySiN2hIvVpZWdUfxx0a+lkNg1Ydy4=;
	b=fAjsez1mFx6Mws1CD7/zusgfp5mMuaAQLhBGenX259PbBKr11b9iEPBrsaAPwr4nnNxizYYiODh2q3zNewWgipbwmZBJ78G6GEppP7j9I5A+E2lMyXqxauVAeXF8xFldvyJYoY7dmJ6/35/5Km8qU5QhuXYuJXXr/+c+LhsrnF0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 20:09:05 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:09:05 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 2/5] hw/usb/hcd-xhci: Fix GCC 9 build warning
Thread-Index: AQHU/5CPjvr6m7B7LkiAX4S+EF98OA==
Date: Tue, 30 Apr 2019 20:09:05 +0000
Message-ID:
 <c4768a18309b3918715f96a1f5b2a9a264a5a9e4.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BY5PR13CA0009.namprd13.prod.outlook.com
	(2603:10b6:a03:180::22) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d5c0873-49da-4d37-f162-08d6cda7b233
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5672; 
x-ms-traffictypediagnostic: BYAPR04MB5672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56728EC98034024CDF56015A903A0@BYAPR04MB5672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(4326008)(50226002)(71190400001)(71200400001)(7736002)(305945005)(316002)(14444005)(256004)(44832011)(186003)(36756003)(8936002)(6436002)(54906003)(2501003)(11346002)(102836004)(2906002)(26005)(6486002)(446003)(486006)(476003)(2616005)(5660300002)(8676002)(25786009)(6116002)(81156014)(81166006)(72206003)(3846002)(86362001)(66066001)(478600001)(73956011)(6512007)(66556008)(118296001)(66446008)(14454004)(66476007)(66946007)(64756008)(68736007)(53936002)(76176011)(97736004)(52116002)(2351001)(386003)(6506007)(5640700003)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5672;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9fl8vOi3rFg1n+IfRoMMMGK4K0SkmYyoS9xHZvb5Zwq+JMKMZZ+RtUIkK55nfRs2JeOAwwA5gFFJaxxqmKL0pt2iYZ4XnzgR+th4SALReX5bpnE1sMQ5WFKA0V8kw9rQBDBhHqsAO64QDFloMgzPyoDXOKJQMI9vlIBzWLIRSmqmWCB4I635IvlSAmNqq2arx/FLWnah3fdehriWU4aVW6o9PSw/OraTothKh0RdmkVSye3WVaN690mDG2bIxZ1uR6G5T4v1p3l/cKBXAod6Kr9ClCT+BmG79+uQliqfc1uwz2x5ADQB9HbfeZWBh1S6MwYsQ2a0rQqe1IxKt3QmJFQ6P7xkG0QICDkrbwC6fDRc9gGiJOFgFiNVdr+v7miEZmsdom5UUNh+xGrm8pcRkYJ60AXEfVp/Mqx/fgLNRJc=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <033AC921E2AC5B47AF4E8024FB3CE262@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5c0873-49da-4d37-f162-08d6cda7b233
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:09:05.5517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 2/5] hw/usb/hcd-xhci: Fix GCC 9 build warning
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
Message-ID: <20190430200905.Dr-VjeJl18Twbi5_KqyU4MR92SnG0L1z1EMGCD00qU0@z>

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
L2hjZC14aGNpLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody91c2IvaGNkLXhoY2kuaCBiL2h3L3VzYi9oY2Qt
eGhjaS5oDQppbmRleCAyNDBjYWE0ZTUxLi45ZTQ5ODhhYmI2IDEwMDY0NA0KLS0tIGEvaHcvdXNi
L2hjZC14aGNpLmgNCisrKyBiL2h3L3VzYi9oY2QteGhjaS5oDQpAQCAtMTMzLDcgKzEzMyw3IEBA
IHR5cGVkZWYgc3RydWN0IFhIQ0lQb3J0IHsNCiAgICAgdWludDMyX3QgcG9ydG5yOw0KICAgICBV
U0JQb3J0ICAqdXBvcnQ7DQogICAgIHVpbnQzMl90IHNwZWVkbWFzazsNCi0gICAgY2hhciBuYW1l
WzE2XTsNCisgICAgY2hhciBuYW1lWzI0XTsNCiAgICAgTWVtb3J5UmVnaW9uIG1lbTsNCiB9IFhI
Q0lQb3J0Ow0KIA0KLS0gDQoyLjIxLjANCg0K

