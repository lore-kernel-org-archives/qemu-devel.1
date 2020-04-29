Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D7CC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6012083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qkBx4L/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6012083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThwI-000498-7f
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:19:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jThrh-0006XC-Lg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jThrN-0005PV-1K
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:14:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:7376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jThrM-0005Eh-8T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:14:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T8EB5q000532; Wed, 29 Apr 2020 01:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Vm9DrqwiQOFGouzqnyC1R1qYnZCGoMFMBs5ecJtbHcs=;
 b=qkBx4L/35syp5DJx3JX/sYtyNa8Km0DQZl1AU3ws/gE6iFOGD0COy/YbBKziK5GNanro
 rO3pim0QLX3NlZvgFpliFFISUovpUdL28Eqxpx4p1ePvulLzAyLOcRs3zHa7+lnT+TFs
 krYxTWZgIr/C9NGSFhMgVqbU3Dyx4Jllw03a0azrQUYPctt1BUZIoaxEok8G9vZ1P6E1
 Ee08Het/Iv6bWh/u1Hn8rV/PjYPPyzovzCAMU1Zozz9yXIzSkGPHXWCLTybZMlbGLnVE
 pLybzOiJCm2QNJ0GFl+osyGEy17PcYcp5PWuVbopCN11Plsiie9lUDcRPEvoBNFt3Zg8 Ag== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mmr3898d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 01:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJAZNXlj135chxfUXPiiZE0/FLdW3qF5lhP+c4tf3JdvomIasMHQvo6kQXl4VU2jHY0Qjvs9nHWTpWh0eE2c4PAzlNXr5e4JZDGJiy5C4VqMAeiOlSyHQOnyEbpsBqy9lgjo037U2dcVwZwgxaQxFzneX9CFcEIq7YihEBeXmkNpUCxTZutZaKRt6y2ziqswtMsULntEDM9VQac4n0HyUqnsLm0GsUC5spQWmuxJwq1WA9ZZspsnRBOc3lJeKCh8ulqsrLVsbQDMzQ66g4IOOKQZESU6BpGOg8lQc3dgxUEycpbdAJX91kGq0iCKvjjbon2GumCOhfLNYR8+ZnkXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm9DrqwiQOFGouzqnyC1R1qYnZCGoMFMBs5ecJtbHcs=;
 b=HS20/mytjdd+i7LIStLVjzoDeRRMVMlKhbV5/z36SjOf282LastzyuoPuw/H3uwNjV3pH6JFVXDZ/F8VwRDTiNVh60bb2kFHl7P9c+KfLWlRc67ihuOKdswwkeXNHn1nv5U5nzu2EzlsUAtVY54nUgz87jGkPVxgVhXUoKrflOrk+7EoL0thqSnKWDvcrPyLm2WYgW67VKVtGYE7oyp32QwoP4Hst315ECzQSZbWO4gC0Xu6PtlnEiVUu7yKXxy9/XxOvWZzan3CIuYCM1euax8aw7BiEZmqLxJdXsZp89LLDbIkP1k7KrIdxDQRpAr11FnhWouji9ZFLhdhvT0ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6784.namprd02.prod.outlook.com (2603:10b6:208:15f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 08:14:02 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 08:14:02 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAIAACeGAgAABVgCAAAdzAIAAATOA
Date: Wed, 29 Apr 2020 08:14:01 +0000
Message-ID: <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
References: <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429035457-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3754ef19-66d7-4904-cc48-08d7ec1546a9
x-ms-traffictypediagnostic: MN2PR02MB6784:
x-microsoft-antispam-prvs: <MN2PR02MB67841F35E87216DC379B8D9CF1AD0@MN2PR02MB6784.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(4326008)(8936002)(86362001)(6512007)(966005)(26005)(6506007)(6916009)(8676002)(71200400001)(478600001)(54906003)(53546011)(316002)(7416002)(2906002)(6486002)(186003)(66556008)(66446008)(44832011)(5660300002)(91956017)(2616005)(76116006)(66946007)(64756008)(36756003)(66476007)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5M/wRKlrUmM2mQBrADIGJuh4JPXBCK2hJpvg/EyJef0eQP5IxCrC7aIIlntVEac7j+fftBLqOdDfJZW9IfLhpz1R69OLeal74CM+Uaqo/fmPQ6YQAESn601/ztA0xj+JMmvsMcK3J0xnhmVKn9oXPlMiWNJPwN0ogRNpnT5VjVRoELFWFUcIGLBgO2zloYy1L/2aMUNZRAXNWKDargQr9y+WBibpCNUKturvwPMS1F3z/C4ISLWhkqGpIf+DYUPj/KrrqHYvYSGj/fTqmE6Tb/wVO/nYofRiUgZQo5ABKTk75wKONegfvGoe0PP3cfSxyXER1BzfWxKlsjvZF+l60TFb6papGGdFNGklHD01y4753e1Yhv3V3qDa0cmkV5JJGvfg6TeczOAeQXMMwjpSHYrmsuSXSyBdf81nmzb+JdMsuFM7MY+JQWMPxwdbjIyjgbabvgz/kgzs0bwDGxPg181hZkcqE8LQhbeqH5PF9qr0P6Zqd96wYsT4ydAfn0A73f3aHdxDfglP9hetiy5eAQ==
x-ms-exchange-antispam-messagedata: bpVyvW5z3RLHCyX93UjKOJJOxYL0f4Lok2MGjQPOpkNxgkniVLG4+5h899kBD5naLmJ03o8VVIVNWwcrRlwUYaK6noWz/Jb2hF9OXZtOvW1GN1vvh8WZqxZ17TVTclZC+XkcEJscAbkkUE5WLnd6FfalFnV1KImfhtv/DIYtPqqBWAADlIjgrhU8h3M2pTm/uFHZfwjXUfbwPIhJzOEt0kKtkAmtKIdbfe4RciEHgKuY/0C2drnU352aeeSC9xqrFcS8TdcVqzRB5CuQvfeTQzuX9G5KCx20JyRHnheTNplfb6hDQ9wmVmT8sdJylti7w0UkBfnozPLNrAgSRbJcafdkwALfKNhV3IvK1M7tIra09bKQgDKex1gUsOZNjlyGw+bF8YXTTBteuVk6GNRRGPyrBdv/vMm25PDxXkQszVetUlyRRxd3SA0zE8bVO3ulxR0727qN9SnNpNHmmOYnYIo/qwDdZV0M9/rYNrIAmdnnLJlvY8D2k1+375e0I+8Eak0T69hKhd5z5QzIZ6Sne3158dydsd8EZVJKvfbRVFBupT/RB99ysaKB41fCkdQDMSg7cPMCSunbUScyk1hqyQEJ04+uDxNbdPTzoqxDDGWjrKC9uMd6QkxlzENF5+GhYA3BqW2BSGUyaw5e5FMATWnzM1JJ2byU5+sG8V8Yx2hflTq4QlUSmcoJV+ws85i+WN2gkFqUp++YM2L29hopDw0wrvIvcQJiE4+e5FYXAjXSsGb27kJITmAxw5Iz4cTbNPzMKC2I9CzDX1/A0Ln5G3c/3AY2Ic/la90McQR3rbs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <32E163985581B54C82FA29F51EBFAFC6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3754ef19-66d7-4904-cc48-08d7ec1546a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 08:14:01.8536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cS2AyPpJ+1lDnZgcQyaJ24T6Qh6nb98VpgEAiHVr/RNlCBlbT7LfSwg20RGQKBHoFStaLJg/SUxjSG4aZmG3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6784
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_02:2020-04-28,
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

DQoNCj4gT24gQXByIDI5LCAyMDIwLCBhdCAxOjM5IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXByIDI5LCAyMDIwIGF0IDA3OjQz
OjA0QU0gKzAwMDAsIEFuaSBTaW5oYSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXByIDI5LCAy
MDIwLCBhdCAxOjA4IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToNCj4+PiANCj4+PiBPbiBXZWQsIEFwciAyOSwgMjAyMCBhdCAwNzowMjo1NkFNICswMDAwLCBB
bmkgU2luaGEgd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIEFwciAyOSwgMjAyMCwgYXQg
MTI6MjcgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+
Pj4gDQo+Pj4+PiBPbiBXZWQsIEFwciAyOSwgMjAyMCBhdCAwNjo1NDo1MkFNICswMDAwLCBBbmkg
U2luaGEgd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEFwciAyOSwgMjAyMCwg
YXQgMTI6MjIgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0K
Pj4+Pj4+PiANCj4+Pj4+Pj4gT24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMDY6MTE6MjBBTSArMDAw
MCwgQW5pIFNpbmhhIHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBB
cHIgMjksIDIwMjAsIGF0IDEwOjU4IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBvIGlmIHRoZXJlJ3MgYSBuZWVkIHRv
IGRpc2FibGUNCj4+Pj4+Pj4+PiBqdXN0IG9uZSBvZiB0aGVzZSwgY29tbWl0IGxvZyBuZWVkcyB0
byBkbyBhIGJldHRlciBqb2IgZG9jdW1lbnRpbmcgdGhlDQo+Pj4+Pj4+Pj4gdXNlY2FzZS4NCj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gVGhlIHVzZSBjYXNlIGlzIHNpbXBsZS4gV2l0aCB0aGlzIGZlYXR1
cmUgYWRtaW5zIHdpbGwgYmUgYWJsZSB0byBkbyB3aGF0IHRoZXkgd2VyZSBmb3JjZWQgdG8gZG8g
ZnJvbSBXaW5kb3dzIGRyaXZlciBsZXZlbCBidXQgbm93IGF0IHRoZSBidXMgbGV2ZWwuIEhlbmNl
LCANCj4+Pj4+Pj4+IChhKSBUaGV5IG5lZWQgbm90IGhhdmUgYWNjZXNzIHRvIHRoZSBndWVzdCBW
TSB0byBjaGFuZ2Ugb3IgdXBkYXRlIHdpbmRvd3MgZHJpdmVyIHJlZ2lzdHJ5IHNldHRpbmdzLiBU
aGV5IGNhbiBlbmFibGUgdGhlIHNhbWUgc2V0dGluZyBmcm9tIGFkbWluIG1hbmFnZW1lbnQgY29u
c29sZSB3aXRob3V0IGFueSBhY2Nlc3MgdG8gVk0uDQo+Pj4+Pj4+PiAoYikgSXQgaXMgbW9yZSBy
b2J1c3QuIE5vIG5lZWQgdG8gbWVzcyB3aXRoIGRyaXZlciBzZXR0aW5ncy4gSW5jb3JyZWN0IHNl
dHRpbmdzIGNhbiBicmljayBndWVzdCBPUy4gQWxzbyBubyBndWVzdCBzcGVjaWZpYyBrbm93aG93
IHJlcXVpcmVkLg0KPj4+Pj4+Pj4gKGMpIEl0IGlzIG1vcmUgc2NhbGFibGUgc2luY2UgYSBzaW5n
bGUgY2x1c3RlciB3aWRlIHNldHRpbmcgY2FuIGJlIHVzZWQgZm9yIGFsbCBWTSBwb3dlciBvbnMg
YW5kIHRoZSBtYW5hZ2VtZW50IHBsYW5lIGNhbiB0YWtlIGNhcmUgb2YgdGhlIHJlc3QgYXV0b21h
dGljYWxseS4gTm8gbmVlZCB0byBhY2Nlc3MgaW5kaXZpZHVhbCBWTXMgdG8gZW5mb3JjZSB0aGlz
Lg0KPj4+Pj4+Pj4gKGQpIEkgYW0gdG9sZCB0aGF0IHRoZSBkcml2ZXIgbGV2ZWwgc29sdXRpb24g
ZG9lcyBub3QgcGVyc2lzdCBhY3Jvc3MgYSByZWJvb3QuIA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBB
bmkNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IExvb2tzIGxpa2UgZGlzYWJsaW5nIGJvdGggcGx1ZyBhbmQg
dW5wbHVnIHdvdWxkIGFsc28gYWRkcmVzcyB0aGVzZSBuZWVkcy4NCj4+Pj4+PiANCj4+Pj4+PiBO
byB0aGUgZHJpdmVyIGxldmVsIHNvbHV0aW9uIGRvZXMgbm90IHByZXZlbnQgaG90IHBsdWdnaW5n
IG9mIGRldmljZXMgYnV0IGJsb2NrcyBqdXN0IGhvdCB1bnBsdWdnaW5nLiBUaGUgc29sdXRpb24g
SSBhbSBwcm9wb3NpbmcgdHJpZXMgdG8gZG8gdGhlIHNhbWUgYnV0IGZyb20gdGhlIGJ1cy9oeXBl
cnZpc29yIGxldmVsLg0KPj4+Pj4gDQo+Pj4+PiBXaHkgZG9lcyB0aGUgZHJpdmVyIGxldmVsIHNv
bHV0aW9uIG5lZWQgdG8gcHJldmVudCBqdXN0IGhvdCB1bnBsdWdnaW5nPw0KPj4+PiANCj4+Pj4g
QmVjYXVzZSBpdCBub3QgZmFpciB0byBwcmV2ZW50IGVuZCB1c2VycyBmcm9tIGhvdCBwbHVnZ2lu
ZyBuZXcgZGV2aWNlcyB3aGVuIGl0IGlzIHRoZSAoYWNjaWRlbnRhbD8pIGhvdCB1bnBsdWdnaW5n
IG9mIGV4aXN0aW5nIGRldmljZXMgd2hpY2ggY2F1c2VzIGlzc3Vlcy4NCj4+PiANCj4+PiBBY2Np
ZGVudGFsPyBTbyBtYXliZSB3aGF0IHlvdSBuZWVkIGlzIGFjdHVhbGx5IHNvbWV0aGluZyBlbHNl
IHRoZW4gLQ0KPj4+IGF2b2lkICpyZW1vdmluZyogdGhlIGRldmljZSB3aGVuIGl0J3MgcG93ZXJl
ZCBkb3duLg0KPj4gDQo+PiBZb3UgZG9u4oCZdCBnZXQgaXQuIEl0IGlzIG5vdCBoeXBlcnZpc29y
IGFkbWlucyB3aG8gYXJlIHVucGx1Z2dpbmcgaXQuIEl0IGlzIHRoZSBlbmQgdXNlcnMuIEV2ZW4g
UmVkSGF0IGN1c3RvbWVycyB3YW50IHRoaXMgZmVhdHVyZS4gU2VlIGZvbGxvd2luZyByZXNvdXJj
ZXM6IA0KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX193d3cucmVkaGF0LmNvbV9hcmNoaXZlc19saWJ2aXItMkRsaXN0XzIwMjAtMkRGZWJydWFy
eV9tc2cwMDExMC5odG1sJmQ9RHdJRmFRJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPUlJVXhJ
eVJ3RzRSR3k1N3kybnZNTlljRGtxVy1OSG96WjJSMzhWWWNnNVUmbT1NZjcwX3lVOUxVYlJGWk95
NHJZTTVONDNCX01EYk83U3hFTVNTSktWYUpZJnM9S2dSMS1LbHpMLWJHcjUxdVkxdnVwT0lnVHBU
ak5BZWNidU9VSXBjdU1VcyZlPSANCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0zQV9fYnVnemlsbGEucmVkaGF0LmNvbV9zaG93LTVGYnVnLmNnaS0z
RmlkLTNEMTgwMjU5MiZkPUR3SUZhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1JSVV4SXlS
d0c0Ukd5NTd5Mm52TU5ZY0RrcVctTkhveloyUjM4VlljZzVVJm09TWY3MF95VTlMVWJSRlpPeTRy
WU01TjQzQl9NRGJPN1N4RU1TU0pLVmFKWSZzPUtWaXM5Z3pWZUE3bm5HYXVacFhXbV9zRW5sX1Vw
c0l6U2xnZ3diNjBGZzgmZT0gDQo+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtM0FfX2J1Z3ppbGxhLnJlZGhhdC5jb21fc2hvdy01RmJ1Zy5jZ2ktM0Zp
ZC0zRDE3OTA4OTkmZD1Ed0lGYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9SUlVeEl5UndH
NFJHeTU3eTJudk1OWWNEa3FXLU5Ib3paMlIzOFZZY2c1VSZtPU1mNzBfeVU5TFViUkZaT3k0cllN
NU40M0JfTURiTzdTeEVNU1NKS1ZhSlkmcz1ZMEs4dGl5cXBtS2VYVTI0NXBuaFRUQXIyZTNZU3V4
eHc0QmtpRHhHd0I4JmU9IA0KPiANCj4gVGhhdCBkb2Vzbid0IHNlZW0gdG8gcmVxdWlyZSB0aGF0
IGhvdHBsdWcga2VlcHMgd29ya2luZy4NCg0KTGlrZSBJIHNhaWQsIHRoYXQgaXMgYmVjYXVzZSBQ
Q0lFIGxpbWl0cyB0aGlzIGF0IHRoaXMgbW9tZW50LiBXZSBjYW4gZG8gYmV0dGVyIHRoYW4gdGhp
cyBzb2x1dGlvbiBvbiBpNDQwZnguIFdlIGNhbiBiZSBuYXJyb3dlciBpbiBsaW1pdGluZyBqdXN0
IGhvdCB1bnBsdWcgbGVhdmluZyBob3QgcGx1Z2dpbmcgYXMgaXMuIFdoeSBzaG91bGQgd2UgYWx3
YXlzIGdvIHdpdGggdGhlIGxlYXN0IGNvbW1vbiBkZW5vbWluYXRvciBmb3IgYWxsIHRoZSBmZWF0
dXJlcz8gV2h5IGRvIHdlIGhhdmUgdG8gYmUgbGltaXRlZCB3aGVuIHdlIGNhbiBkbyBiZXR0ZXI/
DQoNCg0KPiANCj4+IE15IGFwcHJvYWNoIGlzIG11Y2ggbW9yZSBmaW5lIGdyYWluZWQgdGhhbiBq
dXN0IGRpc2FibGUgZXZlcnl0aGluZyBhcHByb2FjaCB0aGF0IHdlIGhhdmUgZm9yIHEzNS4gRm9y
IGk0NDBmeCB3ZSBjYW4gZG8gYmV0dGVyIHRoYW4gdGhhdC4NCj4+IA0KPj4gDQo+Pj4gDQo+Pj4+
PiANCj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+PiAtLSANCj4+Pj4+Pj4gTVNUDQoNCg==

