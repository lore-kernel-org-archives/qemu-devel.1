Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAAEC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BE82073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="OJM76UfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BE82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjqP-0005tb-R6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTjpj-0005Si-NS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTjpi-0004xB-Fd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:20:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:37114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTjpi-0004lL-0K
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:20:50 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TAIMOc022406; Wed, 29 Apr 2020 03:20:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=icMNBYpdd30N+dAVXjvuoqYOzCS2HRrcKDiGGqrQaw0=;
 b=OJM76UfBHUunxhrfDhmsj4e5ghZJNkMrgtpZb0TSzafXFXd/NzgUbcw/5QX33Xs6sL9O
 M82gfmcxeBPedDKRgGsBR1xY1HnyJaCAY/KHLyRJcSRlRXuZkdpIKp5g3CnCmecy1fHf
 E4YQD2/d6KvFdndweC+TzwLHNPfEjYkRjI4+Tt4U/Hfc97FF/Uvb78R6rpHu93gfmYR0
 AaRTwnUt0v4x0o38rKeKCKnxL4+8uNe2hgu3DElMsqcbK3XiouZWOvCCYvb2bQIiPD83
 wSKNA9D+wCbK3yoztKSZOKm/vSgu/EPa0TNeq471/LVKN2ej/lE7KVDANyUP+80+vR2k kQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mmhj8e2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 03:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxUiT77K6whRtSa7ppGCEilf+1Spr8g5U4cFERLcJM38Dn5cDJtr3RlBDCSOhkYB4K26MLXu5NvmB1NG6fM1fLH6duchwK+1N/vt1hvYk23cqY+7A+5aNZFp+0a+FsBvatHA508YblaMFidazYXZRIvUDV56/xiub4ybPovv5Ltxi//p6h+g7E1iprc+o55ZxBx324w6hV9enQzaNLUibyh7UnbEO8YSPan0VlTDhZ9GO4wCO4jnIJq5qdKRtF3mcF4EBLFakBzizEzZ/AvP5cbUj2+jhAvZ84FwQx6kXG7tzUf5C+GLMSODRPvEv93y9TXYWfdLanyD5+Au27dYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icMNBYpdd30N+dAVXjvuoqYOzCS2HRrcKDiGGqrQaw0=;
 b=Cmp7POSJLTgGzOEueIw2UMTOLE/JgjdyXKVzfyBRMDPr/jKepc2UdVKRa/QxN+lp5x9e6hwiUMCMXUGsWqzErdXAC2hQsGzXl/O0z4aQvmOm5fjE3kH7jKt9aPZiMuEtbtO5kFPmzszRwkqiPEa/QhY4z42foDqLB4TrRIIvGTiyMY0rm4fRaGHFollQnjhvFdq1vqlp9SJT3NBRKjATfu7x3XbRsXQS4SchhplsoEP3DchFfPGrf57TWWL+0k4XZpWBS88Va3uO0TU2sBFkY3+N+0OVjqdFq0821QRf/08N18aDYagYrSzHD8r+X10AuY0RpWPcKphIYpLbWVhSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB7055.namprd02.prod.outlook.com (2603:10b6:208:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 10:20:31 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 10:20:31 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAIAACeGAgAABVgCAAAdzAIAAATOAgAAL9gCAAATtAIAAESCAgAABVgA=
Date: Wed, 29 Apr 2020 10:20:31 +0000
Message-ID: <7F9D8AE0-FC4B-4CF3-A206-FCAEB0DD4CE6@nutanix.com>
References: <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
 <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
 <20200429045427-mutt-send-email-mst@kernel.org>
 <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
 <20200429060230-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429060230-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b0118b-3898-49a6-e641-08d7ec26f221
x-ms-traffictypediagnostic: MN2PR02MB7055:
x-microsoft-antispam-prvs: <MN2PR02MB7055BA168095E6EEDAFE0942F1AD0@MN2PR02MB7055.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(26005)(66446008)(5660300002)(64756008)(86362001)(36756003)(66556008)(66946007)(4326008)(33656002)(186003)(76116006)(91956017)(7416002)(6916009)(2616005)(966005)(2906002)(478600001)(54906003)(8676002)(44832011)(6512007)(6486002)(6506007)(316002)(71200400001)(53546011)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvOpDSFf7S4SAKuMrPawkHTJGPPBVxSAgEZSVpfCdJpWqvWWG+20exiIFZtsESoWGyb5Bzo2J4j4gPm8aAGgm8/J0BqLeXVHd5ApfhN+AwCydtJ8xQtYqRlg2QZsawKh45JOge2PLyBytN6mVcAC9V7g0McIfn79uwh2QUHF55l4ilHFX0AnovCfa2hx2JjNZgsTDp27KhE50Tm88RTUGQ/3CRYkVNBOL6Ht1Sqw0JzadyVhh2mPlmD34vOZbYSWuwamnnX3rbj22rIm/buKGQhh/WWzZkSc2iEMCuvnOxuiUh9Wmf/vCLpnFLhn8eReN1kcS2VFUH8zt6+psaTVpjagyqc/flQUB+yA4q8PZuGXRqfCQxXVOS22mFw/AdEGZ/N9M7TmO/8bz3QtHq7yy2YM0NIxBN1/42J3KzD/6CDgbmLrUxKJXqapKzDesfJxkB0LtPUNjq4Y0vA7DDzF+Imnb4s7zKIUSFzDzytRGu0ecx0dK9gPjcFYfuUkWoNiaaNn6Xk1m3bU1cAQ06Ltfg==
x-ms-exchange-antispam-messagedata: zyhLMIVghKD0J4GPyyeZwsfYI2wNkCS/6eRDdMMFUaAhjOMVUh8ARqjB6tGFJyBm0GYO1BRxyVhGBgyrtWj+0sNrvyeFQlJfIlGJjW2CYs7Cr8nyGPZUcQm1Mzew+cvxVk+RnkvAniS71BvkWMqr1v/T9K068BzMK59NzCrPCyWdrvF56ebSPXBZK4bcpkF6xR0s/xc3rahTnUi6DuJwnBn64xxIl8V0G0yEWT1Qj9ez8BdTEa7Iotl84SxpH1cAkICwd9AfSbGpp55tS+SelEWlRdMnEEKurmG8z/bgizM45e8+tCUQ7/33WySi3km0EFbwJ/tmUp8QUknIxMhvz7Y/T6z7+0VDi84CbReVpHs/H00hnzCpBho/R6+/0jFu0Vg8fX0n6BsTgk4YWpwnQk2zgwRAWi05rArtOMn5b2lPKq82ZvzZRXIu3KhB+xTHOexGCMviGIiSh0aZeJj0XvrXEWRot9FpKz3oTh3bat/59mNPyuDbrD1prCpVagDfpZg2cSytT65n1jttZT9M/g5Dmn27uAB4ifRlOq9s2mwQRlXvafdcdZfoB1vNFJlTXcAGbgIAwKHZSfg1gyYm1h8Q7HnGVI1s1NTxzVNZLlqkyhJRuwfrtY9rKMNth9vLTxCdlR1Nbw1tk7SUmT9HZj7yT9POoZRXFUlVjgIDBUpIZSf5MW0iXBZnIUTduXmQq5X8wGqcg5t1ijLM12lcy3izzABuzYbVYbGJSIg01S2arUwsk/TDX3JEZw6PEPVWRCKo+cd7nfGq6ZS0eryVGY1AgAxrkQ93czoPma0UTW0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D83973B52FE6644AB58E62138F3D9D5A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0118b-3898-49a6-e641-08d7ec26f221
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 10:20:31.0455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9mrLI2PXn8ROUNIveExKuEs7hTOsmefy+7bZ1BD9ZQGWB3EsHin8xOniwFHKgpby/jcWAWEX8ppoaeF1q2N8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7055
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_03:2020-04-29,
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

DQoNCj4gT24gQXByIDI5LCAyMDIwLCBhdCAzOjQ1IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXByIDI5LCAyMDIwIGF0IDA5OjE0
OjI2QU0gKzAwMDAsIEFuaSBTaW5oYSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXByIDI5LCAy
MDIwLCBhdCAyOjI2IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToNCj4+PiANCj4+PiBFdmVuIGlmIGl0IHNlZW1zIHRvIHdvcmsgZm9yIGd1ZXN0cyBub3csIGlm
IHdlIGRvbid0IHN0aWNrIHRvIGVtdWxhdGluZw0KPj4+IGNhcGFiaWxpdGllcyB0aGF0IGhhcmR3
YXJlIGludGVyZmFjZXMgcHJvdmlkZSB3ZSBjYW4gbmV2ZXIgYmUgc3VyZSBpdA0KPj4+IHdpbGwg
a2VlcCB3b3JraW5nLg0KPj4gDQo+PiBPUyBlcyB1c2UgQUNQSSBmb3IgUENJIGJyaWRnZXM6IGh0
dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHVi
LmNvbV9xZW11X3FlbXVfYmxvYl9tYXN0ZXJfZG9jc19wY2llLnR4dCZkPUR3SUZhUSZjPXM4ODNH
cFVDT0NoS09IaW9jWXRHY2cmcj1JSVV4SXlSd0c0Ukd5NTd5Mm52TU5ZY0RrcVctTkhveloyUjM4
VlljZzVVJm09OUFudVI2MmlSc1VubVY5Z2drU19scWVuNjdldEhlQ2pBVEZMd0NKV3hRcyZzPUFz
X19OOUJYZjBEVFNaa0Q0Y3hhUXNUZWcwZXhoNUdTUHFrRlNoN2Z4UmsmZT0gDQo+PiBUaGV5IHVz
ZSDigJxfRUow4oCdIHRvIGRldGVjdCBqb3QgdW5wbHVnIGNhcGFiaWxpdHk6IGh0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fdWVmaS5vcmdfc2l0ZXNf
ZGVmYXVsdF9maWxlc19yZXNvdXJjZXNfQUNQSS01RjMucGRmJmQ9RHdJRmFRJmM9czg4M0dwVUNP
Q2hLT0hpb2NZdEdjZyZyPUlJVXhJeVJ3RzRSR3k1N3kybnZNTlljRGtxVy1OSG96WjJSMzhWWWNn
NVUmbT05QW51UjYyaVJzVW5tVjlnZ2tTX2xxZW42N2V0SGVDakFURkx3Q0pXeFFzJnM9U0RnT2hL
R3BubHpmYnZBT0ZsMm05YS10ZFBaRVVjQ3dLV3Nna1ZEYWZ5TSZlPSANCj4+IA0KPj4gNi4zLjMg
X0VKeCAoRWplY3QpIFRoZXNlIGNvbnRyb2wgbWV0aG9kcyBhcmUgb3B0aW9uYWwgYW5kIGFyZSBz
dXBwbGllZCBmb3IgZGV2aWNlcyB0aGF0IHN1cHBvcnQgYSBzb2Z0d2FyZS1jb250cm9sbGVkIFZD
UnN0eWxlIGVqZWN0aW9uIG1lY2hhbmlzbSBvciB0aGF0IHJlcXVpcmUgYW4gYWN0aW9uIGJlIHBl
cmZvcm1lZCBzdWNoIGFzIGlzb2xhdGlvbiBvZiBwb3dlci9kYXRhIGxpbmVzIGJlZm9yZSB0aGUg
ZGV2aWNlIGNhbiBiZSByZW1vdmVkIGZyb20gdGhlIHN5c3RlbS4gVG8gc3VwcG9ydCB3YXJtIChz
eXN0ZW0gaXMgaW4gYSBzbGVlcCBzdGF0ZSkgYW5kIGhvdCAoc3lzdGVtIGlzIGluIFMwKSByZW1v
dmFsLCBhbiBfRUp4IGNvbnRyb2wgbWV0aG9kIGlzIGxpc3RlZCBmb3IgZWFjaCBzbGVlcCBzdGF0
ZSBmcm9tIHdoaWNoIHRoZSBkZXZpY2Ugc3VwcG9ydHMgcmVtb3ZhbCwgd2hlcmUgeCBpcyB0aGUg
c2xlZXBpbmcgc3RhdGUgc3VwcG9ydGVkLiBGb3IgZXhhbXBsZSwgX0VKMCBpbmRpY2F0ZXMgdGhl
IGRldmljZSBzdXBwb3J0cyBob3QgcmVtb3ZhbDsgX0VKMeKAk0VKNCBpbmRpY2F0ZSB0aGUgZGV2
aWNlIHN1cHBvcnRzIHdhcm0gcmVtb3ZhbC4NCj4gDQo+IFllcy4gU28gaWYgdGhlcmUncyBubyBf
RUp4IHRoZW4gaXQncyByZWFzb25hYmxlIHRvIGFzc3VtZSB5b3UgY2FuJ3QNCj4gaXNvbGF0ZSB0
aGUgc2xvdCwgYW5kIHNvIG5vIGhvdC1wbHVnIHdpbGwgaGFwcGVuIGVpdGhlci4NCg0KV2hlcmUg
YXJlIHlvdSBnZXR0aW5nIHRoYXQ/IFRoaXMgaXNu4oCZdCB0cnVlLiDigJxfU1VO4oCdIGlzIHVz
ZWQgdG8gZGV0ZWN0IHRoZSBzbG90IHVuaXF1ZSBudW1iZXIuIFdpbmRvd3MgZG9lcyBhbGxvdyBo
b3QgcGx1Z2dpbmcgb24gdGhlIGJyaWRnZSBvbiB3aGljaCBFSjAgaGFzIGJlZW4gdHVybmVkIG9m
Zi4NCg0KPiANCj4+IA0KPj4gTm90ZSB0aGF0IOKAnHRoZXNlIGNvbnRyb2wgbWV0aG9kcyBhcmUg
b3B0aW9uYWzigJ0gbGluZS4gSWYgdGhlIE9TIGFkaGVyZXMgdG8gdGhlIHNwZWMsIGl0IHNob3Vs
ZCBub3QgZXhwZWN0IHRoZW0gdG8gZXhpc3QgYWxsIHRoZSB0aW1lLg0KPj4gDQo+IA0KPiANCj4g
DQo+IC0tIA0KPiBNU1QNCj4gDQoNCg==

