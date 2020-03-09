Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A287FC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DCB20866
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ne8imSap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="WOwwjQYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DCB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMTR-0007L2-D7
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 13:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jBMSS-0006J4-15
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jBMSQ-0006KZ-Uj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:44:51 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jBMSQ-0006Gx-I7; Mon, 09 Mar 2020 13:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1583775890; x=1615311890;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n97lkZ4O6znlL04vfcYVK6YyVu+bEX4cYbJwSXgbGhY=;
 b=ne8imSapCJC3a+Y5d3+Zl0NcdnMydrHDjpKZP4cIfmDsFDJVFrAqV8l3
 Qzw0nRgr14VszukgQ9VQIwFUcOnrbbqvvMgHAPVHUANhkNGe0DT35F4aV
 5M0IwgE0FPqBGlR5ZvsM5Sss5Ol3axhT8cfXNAJhjUPyADTolJMZlyC/k s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Mar 2020 10:44:47 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 09 Mar 2020 10:44:47 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Mar 2020 10:44:46 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 9 Mar 2020 10:44:46 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4118.namprd02.prod.outlook.com (2603:10b6:a02:fb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 17:44:45 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:44:45 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/5] hw/core/loader: Provide rom_add_file() a 'max_size'
 argument
Thread-Topic: [PATCH 3/5] hw/core/loader: Provide rom_add_file() a 'max_size'
 argument
Thread-Index: AQHV9iH8pgFp7kypFky4sl4Jo472YqhAhf8Q
Date: Mon, 9 Mar 2020 17:44:45 +0000
Message-ID: <BYAPR02MB4886288D59FF7AFAF5D6329EDEFE0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200309144353.26457-1-philmd@redhat.com>
 <20200309144353.26457-4-philmd@redhat.com>
In-Reply-To: <20200309144353.26457-4-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a74bd74c-7eb0-462f-5609-08d7c4518e74
x-ms-traffictypediagnostic: BYAPR02MB4118:
x-microsoft-antispam-prvs: <BYAPR02MB4118D2A78856589A793F5C53DEFE0@BYAPR02MB4118.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(33656002)(71200400001)(7416002)(55016002)(316002)(110136005)(81156014)(76116006)(8936002)(5660300002)(86362001)(54906003)(53546011)(6506007)(8676002)(81166006)(7696005)(66446008)(66556008)(66946007)(9686003)(64756008)(66476007)(186003)(26005)(2906002)(478600001)(4326008)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4118;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbRgBsMKNfm/2fgcCP94aYQ8YFHp/GiA9bCMlJ0R6EfqhcWDGKtfvaQqIi63KDoiDBf2079J6LZpxCm0+ONHkN4FU3Oq3e78j9rjy1+TjpJZjNtBqjpZsGFvCm18NWzSAWIUwvMxaTXa946VW+dzbc9+AVlnCH34RnA6gAec/fkKOBdpi2K/lzTppCx4eVFW1I2fPIGlAo27I+ZKs2iq4R4bzs70tZsZqYUTsjiRYkVsE1rjSuHZ6UdMY55oupFCB2Fa6pm1hyUoXGofVGtnp4FS+v5H/fDUE6gLsqre9EJBSGedvVeoLHgDcIgOg1BQePy4ltSYa0cOB/xzi3fFub+A3wJMreTcpGyJFtd/etegn4mn4OsQaKuJjIvGQ70Fh6F3ZxLCoKZRaWDJvWOIfwKh8fHsdZ7OY0EJ0VsFzHv/30RVR/pWBi7V9cK62vc9
x-ms-exchange-antispam-messagedata: WnPnBKv7Y1gAGfQ3KsZvF7TMHTa7x23b8ELNfBk+wEmGSq/VOlPRBAcVNEOeoHjlnv8TT20BxvgXTPaG4mlBN5WwNDgc1ta/OWXnHDu5n/acSzY62mwVbS+QY5e02uT9g8ZWKjPB6jsYLyJKbHm/zA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbfTPkA5GChLGMK4ZsWatWGi0Ok15bGb5A0k/GWVFwTHAsHxmx3fIEpvxIp4HCqOm42yI9kmLlRX8Xr2mM1cY4ywwiHAnakU3ifXTSZYJ/0fZ8s5MvZWks8hBpL0sYwsr718FGAqNSxxReIZjVqN8JMn1dSwj7Mb8lZXjOULbNr7CzUVCbaby+boUw3pVb8sYJIgJl4K/szLCYnuv+0JEUqmyQewpH6LsmH+tWbYeDXpWewoV9WqkwECFpDjqUp0DqIOQAGc+YT11kBtean0rubiXMwJprZm2Kpkubr81O1Dk0QEqYISZH51+wk7tLBNvVTJKfz9fTtlbmjU2W802A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDGmjJ7oJigtM8im+91EK5C1ybZ1TNsVRknqZCbMG3c=;
 b=NVQ4OjLowCeU5VUnJcnLiWsJt6WaR19hVkR/+Nbcomr7PynGlxt8/bvoOVikz0PrfF9oedoormF8LhGEIUx4ovud4FBuc8YMytM7VQCa7Zs0uX5lK1+iYq3OhCJ38RFgmHFdDjQsIol1L6nRy8jPfMatjmLypGJt0r3RKOZEsFhSer3Qy7NL3GJ3R7548k+j9ENgWLVw2ZKd4jy3COPuLcqD8nTpJKFHpQqfvBSm5SG1gIdINv/Oq54/ManYNxwnuPVWCZQ0KGEKz+jbttOxhIR35ZTq+F3ZbO8eLn/4gLz3OuESgNR6DUxgW2Eo2U2mFlLVtxdPobLgJRpmAOliBQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDGmjJ7oJigtM8im+91EK5C1ybZ1TNsVRknqZCbMG3c=;
 b=WOwwjQYtpycHLz3EcmVsfE6Nk5HuK2ret29qnSieF+9eEywmiQp5eqmn6jvimlrzgQcxc4QOkjTFEKl8kreZRjxi4D3AlObdmqIjMmP8tpgth4yKpJs4x+MCvdcp4c9e0Bdu/a56Vsi+9ENIL2loqJ/T8cq2z2YzXBp3OA6kJ0I=
x-ms-exchange-crosstenant-network-message-id: a74bd74c-7eb0-462f-5609-08d7c4518e74
x-ms-exchange-crosstenant-originalarrivaltime: 09 Mar 2020 17:44:45.6858 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: +0GS1BnFkciFlgoGNwRLvRzkIJZ9YXc+Gi528XXGC1aAohuMCw6E8U+BZoksYfI2qTupypi7Uz5pzpZ+SqNuUQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4118
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1kZXZlbCA8cWVt
dS1kZXZlbC0NCj4gYm91bmNlcyt0c2ltcHNvbj1xdWljaW5jLmNvbUBub25nbnUub3JnPiBPbiBC
ZWhhbGYgT2YgUGhpbGlwcGUNCj4gTWF0aGlldS1EYXVkw6kNCj4gU2VudDogTW9uZGF5LCBNYXJj
aCA5LCAyMDIwIDk6NDQgQU0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogRWR1
YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPjsgTWljaGFlbCBTLiBUc2lya2luDQo+
IDxtc3RAcmVkaGF0LmNvbT47IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMu
bWU+OyBNYXJrIENhdmUtDQo+IEF5bGFuZCA8bWFyay5jYXZlLWF5bGFuZEBpbGFuZGUuY28udWs+
OyBxZW11LXBwY0Bub25nbnUub3JnOyBHZXJkDQo+IEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNv
bT47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ow0KPiBEYXZpZCBHaWJzb24g
PGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+
IDxwaGlsbWRAcmVkaGF0LmNvbT47IEFydHlvbSBUYXJhc2Vua28gPGF0YXI0cWVtdUBnbWFpbC5j
b20+Ow0KPiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMy81XSBody9jb3JlL2xvYWRlcjogUHJvdmlkZSByb21fYWRkX2ZpbGUoKSBhICdtYXhf
c2l6ZScNCj4gYXJndW1lbnQNCj4NCj4NCj4gLSNkZWZpbmUgcm9tX2FkZF9maWxlX2ZpeGVkKF9m
LCBfYSwgX2kpICAgICAgICAgIFwNCj4gLSAgICByb21fYWRkX2ZpbGUoX2YsIE5VTEwsIF9hLCBf
aSwgZmFsc2UsIE5VTEwsIE5VTEwpDQo+ICsjZGVmaW5lIHJvbV9hZGRfZmlsZV9maXhlZChfZiwg
X2EsIF9pKSBcDQo+ICsgICAgcm9tX2FkZF9maWxlKF9mLCBOVUxMLCBfYSwgLTEsIF9pLCBmYWxz
ZSwgTlVMTCwgTlVMTCkNCj4gICNkZWZpbmUgcm9tX2FkZF9ibG9iX2ZpeGVkKF9mLCBfYiwgX2ws
IF9hKSAgICAgIFwNCj4gICAgICByb21fYWRkX2Jsb2IoX2YsIF9iLCBfbCwgX2wsIF9hLCBOVUxM
LCBOVUxMLCBOVUxMLCBOVUxMLCB0cnVlKQ0KPiAgI2RlZmluZSByb21fYWRkX2ZpbGVfbXIoX2Ys
IF9tciwgX2kpICAgICAgICAgICAgXA0KPiAtICAgIHJvbV9hZGRfZmlsZShfZiwgTlVMTCwgMCwg
X2ksIGZhbHNlLCBfbXIsIE5VTEwpDQo+ICsgICAgcm9tX2FkZF9maWxlKF9mLCBOVUxMLCAwLCAt
MSwgX2ksIGZhbHNlLCBfbXIsIE5VTEwpDQo+ICAjZGVmaW5lIHJvbV9hZGRfZmlsZV9hcyhfZiwg
X2FzLCBfaSkgICAgICAgICAgICBcDQo+IC0gICAgcm9tX2FkZF9maWxlKF9mLCBOVUxMLCAwLCBf
aSwgZmFsc2UsIE5VTEwsIF9hcykNCj4gKyAgICByb21fYWRkX2ZpbGUoX2YsIE5VTEwsIDAsIC0x
LCBfaSwgZmFsc2UsIE5VTEwsIF9hcykNCj4gICNkZWZpbmUgcm9tX2FkZF9maWxlX2ZpeGVkX2Fz
KF9mLCBfYSwgX2ksIF9hcykgICAgICAgICAgXA0KPiAtICAgIHJvbV9hZGRfZmlsZShfZiwgTlVM
TCwgX2EsIF9pLCBmYWxzZSwgTlVMTCwgX2FzKQ0KPiArICAgIHJvbV9hZGRfZmlsZShfZiwgTlVM
TCwgX2EsIC0xLCBfaSwgZmFsc2UsIE5VTEwsIF9hcykNCj4gICNkZWZpbmUgcm9tX2FkZF9ibG9i
X2ZpeGVkX2FzKF9mLCBfYiwgX2wsIF9hLCBfYXMpICAgICAgXA0KPiAgICAgIHJvbV9hZGRfYmxv
YihfZiwgX2IsIF9sLCBfbCwgX2EsIE5VTEwsIE5VTEwsIE5VTEwsIF9hcywgdHJ1ZSkNCg0KVGhl
IGFib3ZlIGxvb2tzIGxpa2UgLTEgcmVwcmVzZW50cyBhbiB1bmtub3duIG1heF9sZW4uDQoNCj4g
KyAgICByb20tPnJvbXNpemUgPSBtYXhfbGVuID8gbWF4X2xlbiA6IHJvbS0+ZGF0YXNpemU7DQoN
ClNvLCBzaG91bGRuJ3QgdGhpcyBjaGVjayBtYXhfbGVuID09IC0xPyAgSW4gZ2VuZXJhbCwgd291
bGRuJ3QgaXQgYmUgYmV0dGVyIHRvICNkZWZpbmUgVU5LTk9XTl9NQVhfTEVOIHRvIG1ha2UgaXQg
bW9yZSBjbGVhciB3aGF0IHRoZSB2YWx1ZSBpcyB1c2VkIGZvcj8NCg==

