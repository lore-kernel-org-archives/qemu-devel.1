Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F9C2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="2RLPtGYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F9C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTk72-0004gL-HD
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTk6N-00047v-MY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTk6M-0002UW-F1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:38:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:24574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTk6L-0002Tm-Oj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:38:02 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TAUbdE005982; Wed, 29 Apr 2020 03:37:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=WiGL5VZzC4yiVvwd+zq0kgsFpy4ZvY6Cs0ml3jOYqoA=;
 b=2RLPtGYB7Aj5o4nw+InSB1vBDbkMVccSV6uf+O1D0e52EupqNCEVfkd1Qs2I7UFgqXsx
 6+AxYbisk/JJ/itokQnv3CD25y4UTosf2qbLWgDDtNhvnSFXVFb0TLVGmMU3JFUwspIQ
 r8T5GfGSf8wSED4UQ0/np5DgmnoRaBEHYCvfFJY/rHn0SaTevwEb5GwOBBqN7H4ihB6O
 IFay8LUN2OI6HQ+4kz3PnVqlWgc7utrySitedmnbO28NMGj9cSSFcq4tFMcCSkggDMBL
 vko79WRGrhnxk9Ywn2ZLFrIHl3GcFj22DCEL4JTH7VKF2dMNAzxCWuidkyWF/gWStoHA 6A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mmr38h6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 03:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8qbTs9qJgRp8vaAOVuEJ/J4SlneE2KC+EG6hhSaeMU3D5uzfiK3hOS1hxjByXvlwsE0FNGTnlEfIGBy/8iNuUH/jOFG7oO0u1nWkSkS6bGNdWTTKxmYT7CvU3/hlk6/3P6pF1Nqg7nz0SunECugOvJGD6xoqpcgrDM+H5fBKBSGw7SkU8cvMg+/yX+9XL7XVquJGYRcC8tyaPCvNMH9LK/P87kv1te4HG3LHgFaIAu8vVdDdp5xFxqNNtTaUufLm+qyQfuZt30RTou9SwHVZP4dSOCR9OL3PalWno3SQClmgh2kgeBZ2N8eRlA64ptSLbnGfrvuPzlJ6Z8/jKsqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiGL5VZzC4yiVvwd+zq0kgsFpy4ZvY6Cs0ml3jOYqoA=;
 b=KFK6bBeNwxc20zbVlOF/QdJLEQSnEEKj7sgYBw6kz/JWhrUnkSIVOLcW9PZ3cLYXazM7tea5SZxghcDQzgWz/aIgWZxUL/kgh9THoDNWQl5xUfulj1AAhqNcYAOG0juQQE7WB29bvYy2bs7eNiFcFw91MZ3CfCImFQnSi8RvOTEMHp3LfL/e6tp6R1eNhXRpJUB/eR/QtE352FIMdybx+iRMWCd+VfGoMUd/PyEZlxG7L4rO8/Z5o/0NV35XvxGhM4El3ihIJTvxDFFdQORfZTto1kDsbE4QblrXSny0CNYi2+DbNwQYQ8HRh+XQnL1tRa0zkjshqH0BLY7JQ+71WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6286.namprd02.prod.outlook.com (2603:10b6:208:1be::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 10:37:47 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 10:37:46 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAIAACeGAgAABVgCAAAdzAIAAATOAgAAL9gCAAATtAIAAESCAgAABVgCAAALAgIAAAhUA
Date: Wed, 29 Apr 2020 10:37:46 +0000
Message-ID: <2C3DB0F5-58C4-4130-90C2-5F292BCA68DF@nutanix.com>
References: <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
 <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
 <20200429045427-mutt-send-email-mst@kernel.org>
 <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
 <20200429060230-mutt-send-email-mst@kernel.org>
 <7F9D8AE0-FC4B-4CF3-A206-FCAEB0DD4CE6@nutanix.com>
 <20200429062136-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429062136-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab22378e-c21d-439e-71f7-08d7ec295b8c
x-ms-traffictypediagnostic: MN2PR02MB6286:
x-microsoft-antispam-prvs: <MN2PR02MB628637755661379EDC8129D1F1AD0@MN2PR02MB6286.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 501PncCwRTj2h92EcHe/firBOc1DqZ7sjeP8pb721pLEKGUy5g2btJgEqjBsbJ6eZ0Js1G55uD/Kr5oygIHmztq7yEuXMWqWEt+1NWL0ynBzK17185Np6GqbpgVI6UNMI1MChpFJTjaWzWt436BPm1HBnC3qWCF277CjCUy46LhhbKZnZMj4jQVofsOEgp54goeE9hL2Hb45vxRpueOHOLp9hG/Bw5AM4CpzNejSeYENrOLdAugrplxtd59Le67faXcDpwgXDYIflGJn4MMMDP6nWrqQRFyfLPcxwKoSTvJDcOBdQlmXHDHnw3DWoK5sXLU/7nChneyGo8Om4iiAFFIn2nzB3jqJsmE40WaAFxwJEdwXdrmMfZ6A9z76O+lWGyRcQH8rhu0c3KX+ijBxZNJznnlaro49i4BwLxlu3MOiW5CX3WkGf1cwLemSvOZv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(346002)(376002)(39850400004)(136003)(76116006)(91956017)(66946007)(5660300002)(8936002)(8676002)(6916009)(36756003)(2906002)(478600001)(33656002)(6486002)(4326008)(26005)(186003)(7416002)(6506007)(6512007)(86362001)(316002)(66446008)(66476007)(44832011)(54906003)(71200400001)(2616005)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bMoNgDbm2LXXgKOvItDAiLrHhFFVbywvtn2fQU6xyv5EVmnLYk8hrvkvhzxXpuMKGZBdiucYl2/JOA70Tw18dZURhYOpVR1kes4FGQEPPPS6LxVa7F7mF+HqgxUVyTHtMxFfw7d4GvJC/m8LBUAJYYKqLBm0f2EuNNlpQmXSsk/bTicVDBpOVqsIc7Vygw8TEdA6YIeG0MgGC3y/CGmH40bvYE30hQLUA03gXO1a03wEFhx+Gn+bwlmjy/MLOzAgMFhO2pPOvp9Aktnl+KgT8zHoVrPj3pTNfnX2p8Aeff4pFzoSWr7/YGZUN20ARxzHQ34MvOPQsknvCX3xi+Z0a0ma7BXgZOc2ZFyArq62lUpj8RkVJPHpkHM/zm8qXjDdgqBA/fcubZniuHycEnCvCXEX000eKHKN4rvzMo3p7kRaCcP07b91HIE9zp1tbhy35YeA7oTbdaRX5xq2Z+PZFDBPfsciVxzk/bdelFvni0TdKOH5Fce0ImnHkzdn4SrOvl7PEHwjVX0PZ0SgNMqsewDhYUcRmk1T1zKSLJEbPL/1ZDke0fjSaWNNe4dBIRl+lfsG/N722zZuiq05v8FY/NzN+qtu5yJqaBjew+lui/fXjDIeyJzd+bs9qWZX6bYqr2LLH072LbcxJtXXDLV0u3s6s9UG4/TcMU+UO+d/+FJX5aujacS+OJTtoVOWOZWShZmJfK4Dcc2mqdjzQuMplYp1GQAjSNJLLNYY3nHU8NO0HNV/itymnuUdbdEheD7xXnEoDb8We4bLJQwdxXre+ML1gljB/Mue4s8E7R9syQw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A59F52C97D44478BC07BCCECEE7CFB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab22378e-c21d-439e-71f7-08d7ec295b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 10:37:46.9210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vls6xxtFu3ty9v+mgVgmMOQurom6iIYKRjtXPKh78WO7m8KSSEWhdzGatfIFuv5aSMERKgzOHpDHo5NndSJUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6286
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_04:2020-04-29,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+Pj4gDQo+Pj4gWWVzLiBTbyBpZiB0aGVyZSdzIG5vIF9FSnggdGhlbiBpdCdzIHJlYXNvbmFi
bGUgdG8gYXNzdW1lIHlvdSBjYW4ndA0KPj4+IGlzb2xhdGUgdGhlIHNsb3QsIGFuZCBzbyBubyBo
b3QtcGx1ZyB3aWxsIGhhcHBlbiBlaXRoZXIuDQo+PiANCj4+IFdoZXJlIGFyZSB5b3UgZ2V0dGlu
ZyB0aGF0Pw0KPiANCj4gSXQncyB3ZWxsIGtub3duLiBGb3IgZXhhbXBsZSwgdGhlIHBjaSBob3Qt
cGx1ZyBzcGVjaWZpY2F0aW9uLCB2ZXJzaW9uDQo+IDEuMSwgc3RhdGVzOg0KPiANCj4gMS42IEFz
c3N1bXB0aW9ucw0KPiANCj4gLi4uDQo+IA0KPiAxLjYuMiBPcmRlcmx5IFJlbW92YWwgYW5kIElu
c2VydGlvbg0KPiANCj4gLi4uDQo+IA0KPiBGdXJ0aGVybW9yZSwgUENJIGFkZC1pbiBjYXJkcyBh
cmUgbm90IGdlbmVyYWxseSBkZXNpZ25lZCB0byBiZSBjb25uZWN0ZWQgdG8gYSBzbG90IHRoYXQN
Cj4gaGFzIHBvd2VyIGFwcGxpZWQuIFRoZXJlZm9yZSwgdGhlIG9wZXJhdGluZy1zeXN0ZW0gdmVu
ZG9yIGFuZCBQbGF0Zm9ybSB2ZW5kb3IgZGVmaW5lIGENCj4gc2VxdWVuY2Ugb2YgdXNlciBhY3Rp
b25zIGFuZCBzeXN0ZW0gYmVoYXZpb3IgdGhhdCBndWFyYW50ZWVzIHRoYXQgcG93ZXIgaXMgYWx3
YXlzDQo+IHJlbW92ZWQgZnJvbSBhIHNsb3QgYmVmb3JlIGEgY2FyZCBpcyBpbnNlcnRlZC4NCj4g
DQo+IEluc2VydGluZyBvciByZW1vdmluZyBhbiBhZGQtaW4gY2FyZCB3aXRob3V0IGZvbGxvd2lu
ZyB0aGUgcHJvcGVyIHNlcXVlbmNlIGxlYWRzIHRvDQo+IHVucHJlZGljdGFibGUgcmVzdWx0cywg
aW5jbHVkaW5nIGRhdGEgY29ycnVwdGlvbiwgYWJub3JtYWwgdGVybWluYXRpb24gb2YgdGhlIG9w
ZXJhdGluZw0KPiBzeXN0ZW0sIG9yIGRhbWFnZSB0byBjYXJkIG9yIFBsYXRmb3JtIGhhcmR3YXJl
LiBVbmxlc3Mgb3RoZXJ3aXNlIHN0YXRlZCwgaXQgaXMgYXNzdW1lZA0KPiB0aHJvdWdob3V0IHRo
ZSByZW1haW5kZXIgb2YgdGhpcyBzcGVjaWZpY2F0aW9uIHRoYXQgdGhlIHVzZXIgYWx3YXlzIGZv
bGxvd3MgdGhlIHByb3Blcg0KPiByZW1vdmFsIGFuZCBpbnNlcnRpb24gc2VxdWVuY2UuDQo+IA0K
PiAuLi4NCj4gDQo+IA0KPiAyLjEgU3lzdGVtIENvbXBvbmVudHMNCj4gDQo+IC4uLg0KPiANCj4g
VGhlIHBoeXNpY2FsDQo+IGluc2VydGlvbiBvciByZW1vdmFsIG11c3Qgbm90IG9jY3VyIHVudGls
IHRoZSBzeXN0ZW0gc29mdHdhcmUgaGFzOg0KPiDigKIgUXVpZXNjZWQgYW55IG9wZXJhdGluZyBz
eXN0ZW0gc2VydmljZXMgb3IgZHJpdmVycyB1c2luZyB0aGUgYWRkLWluIGNhcmQNCj4g4oCiIElz
b2xhdGVkIGFuZCBwb3dlcmVkIGRvd24gdGhlIHNsb3QNCj4g4oCiIEluZGljYXRlZCB0byB0aGUg
dXNlciB0aGF0IGl0IGlzIHJlYWR5DQo+IElmIGFuIGFkZC1pbiBjYXJkIGlzIGluc2VydGVkIG9y
IHJlbW92ZWQgd2l0aG91dCBmb2xsb3dpbmcgdGhlIHByb3BlciBzZXF1ZW5jZSwgdGhpcyBpcw0K
PiBjb25zaWRlcmVkIGFuIGltcHJvcGVyIG9wZXJhdGlvbiBhbmQgZXJyb3IgY29uZGl0aW9ucyBh
bmQgb3RoZXIgdW5leHBlY3RlZCBldmVudHMgYXJlDQo+IHBvc3NpYmxlLCBpbmNsdWRpbmcgZGF0
YSBjb3JydXB0aW9uIGFuZCBoYXJkd2FyZSBkYW1hZ2UuDQo+IA0KPiBhbmQgc28gb24uDQoNCg0K
V2hhdCBkb2VzIGFsbCBvZiB0aGlzIGdvdCB0byBzbyB3aXRoIEFDUEkgaG90IHBsdWcgc3BlYyB3
aGljaCBJIHNob3dlZCB5b3Ugd2hlcmUgaXQgY2xlYXJseSBzYXlzIHRoYXQgYXZhaWxhYmlsaXR5
IG9mIEVKMCBpcyBvcHRpb25hbD8gSG93IGFyZSB3ZSB2aW9sYXRpbmcgdGhlIHNwZWM/IEkgYWxz
byBnYXZlIGV2aWRlbmNlIG9mIExpbnV4IGRldGVjdGluZyBpdCBhdCBydW50aW1lIGFuZCBXaW5k
b3dzIGFsc28gc2VlbXMgdG8gYWxsb3cgaXQuDQoNCj4gDQo+IA0KPj4gVGhpcyBpc27igJl0IHRy
dWUuIOKAnF9TVU7igJ0gaXMgdXNlZCB0byBkZXRlY3QgdGhlIHNsb3QgdW5pcXVlIG51bWJlci4N
Cj4gDQo+IFRoYXQncyBqdXN0IGVudW1lcmF0aW9uLg0KPiANCj4+IFdpbmRvd3MgZG9lcyBhbGxv
dyBob3QgcGx1Z2dpbmcgb24gdGhlIGJyaWRnZSBvbiB3aGljaCBFSjAgaGFzIGJlZW4gdHVybmVk
IG9mZi4NCj4gDQo+IEdpdmVuIG5vIHJlYWwgb3IgdmlydHVhbCBoYXJkd2FyZSB0aGF0IGRvZXMg
dGhhdCwgdGhlcmUncyBubyBndWFyYW50ZWUNCj4gdGhhdCBJIGNhbiBzZWUgdGhhdCBpdCB3aWxs
IGtlZXAgc3VwcG9ydGluZyB0aGF0IGluIGZ1dHVyZSB2ZXJzaW9ucy4NCg0KWW91IGRvIG5vdCBr
bm93IHRoYXQuIEkgZ2F2ZSBldmlkZW5jZSB0aGF0IHdlIGFyZSBub3QgdmlvbGF0aW5nIHRoZSBz
cGVjLg0KDQpJZiBSZWRIYXQgaGFkIG5vdCBtb3ZlZCB0byBxMzUgYW5kIHRoZXkgaGFkIGNvbWUg
dXAgd2l0aCB0aGlzIHBhdGNoIGZvciBpNDQwZngsIHdvdWxkIHlvdSBoYXZlIGdpdmVuIHRoaXMg
bXVjaCBiaWFzZWQgcHVzaGJhY2s/IEkgc2VyaW91c2x5IGRvdWJ0IGl0LiANCg0KDQoNCg==

