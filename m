Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1D0C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB936208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fPPfNGdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB936208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXPD-0006CL-Je
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@virtuozzo.com>) id 1hgWuf-0008Cb-6b
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hgWud-0006Fi-IP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:06:17 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com
 ([40.107.1.108]:42113 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1hgWuR-00060E-N2; Thu, 27 Jun 2019 12:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxEcZeLqCoizA36BW0U1iHJ5SjBC1WZUM3r20a5ntw8=;
 b=fPPfNGdOrI9UGUmnBuraWeBuu+oOq9iwEbowu9ybM/myQnNPpMFhQrauG+0mrSHkdL9CRciW7fTm0C54ucoHmA5UIPIfxsv3A4n5yL+r1Ox8KxyBIv/OD+Pyn5zTVMW5DMv8NwucS7rv5J1KhkyFnmjHM08+lge+cMf793/jysQ=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4677.eurprd08.prod.outlook.com (10.255.78.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Thu, 27 Jun 2019 16:05:55 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881%3]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 16:05:55 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] Re-evaluating subcluster allocation for qcow2 images
Thread-Index: AQHVLPCb4B1OTPiTIEWxN+ewhowOEKavjMGAgAAWOgCAAAeGAA==
Date: Thu, 27 Jun 2019 16:05:55 +0000
Message-ID: <434b102d-9d8e-ccc2-cb53-7f49a3fbd6fb@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
In-Reply-To: <w51a7e3domn.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::11)
 To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dfc1a4d-a198-4dfc-03b9-08d6fb1955b4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4677; 
x-ms-traffictypediagnostic: DBBPR08MB4677:
x-microsoft-antispam-prvs: <DBBPR08MB4677A2819E1A6471C709F091B6FD0@DBBPR08MB4677.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(39850400004)(346002)(396003)(189003)(199004)(229853002)(186003)(14444005)(8676002)(486006)(11346002)(2616005)(476003)(256004)(4326008)(2501003)(68736007)(5660300002)(7736002)(6506007)(386003)(305945005)(99286004)(478600001)(8936002)(561944003)(2906002)(81166006)(81156014)(53936002)(53546011)(107886003)(76176011)(52116002)(66476007)(66446008)(64756008)(66556008)(6246003)(66946007)(73956011)(36756003)(6436002)(26005)(25786009)(316002)(6486002)(31686004)(6512007)(102836004)(446003)(3846002)(6116002)(86362001)(54906003)(110136005)(66066001)(31696002)(71190400001)(71200400001)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4677;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +CfsS2z/e8qoallCXxwYLet7DM+XXk5bGTi9INhoxtKsrYS4vADxVUC8SfO00EA+vSdUPGGdo5mVNiP0ksGYijgHNMCM/Rxl0/Y6U4h20djy3c67UhaIIr3vvlRHTh/g8N2yYM56FgYBMlbH/0p8KC1+DWg4CYCvnlIy5/eVDEmMZB7VNz1inYqJr/16j6yjUBfj8YH1DFNBgmfYW7gk4f353p8nieYtg/Ssg3WNvYMtOdBU01wCna9m/d+V1ZRaqNzzY2E3XTfrVVfxoUMm/WjQBKGk2qzR+8kpGa6JjitATe7LAqyBIko/QR0mkoYpnxGUywWcS/aBLbf1hfOp4nSyNOGiT1LsF+6/VcHeihwD70t147T5jEtmMH1Jo5/OpMZYef+H4LRKbjGKhydmeNzcGGnuhV0IbWUFNdH3L84=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A285D82C49DF544B09499A1072E5577@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfc1a4d-a198-4dfc-03b9-08d6fb1955b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:05:55.3696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4677
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.108
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNi8yNy8xOSA2OjM4IFBNLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gT24gVGh1IDI3IEp1
biAyMDE5IDA0OjE5OjI1IFBNIENFU1QsIERlbmlzIEx1bmV2IHdyb3RlOg0KPg0KPj4gUmlnaHQg
bm93IFFDT1cyIGlzIG5vdCB2ZXJ5IGVmZmljaWVudCB3aXRoIGRlZmF1bHQgY2x1c3RlciBzaXpl
ICg2NGspDQo+PiBmb3IgZmFzdCBwZXJmb3JtYW5jZSB3aXRoIGJpZyBkaXNrcy4gTm93YWRheXMg
cHBsIHVzZXMgcmVhbGx5IEJJRw0KPj4gaW1hZ2VzIGFuZCAxLTItMy04IFRiIGRpc2tzIGFyZSBy
ZWFsbHkgY29tbW9uLiBVbmZvcnR1bmF0ZWx5IHBwbCB3YW50DQo+PiB0byBnZXQgcmFuZG9tIElP
IGZhc3QgdG9vLiAgVGh1cyBtZXRhZGF0YSBjYWNoZSBzaG91bGQgYmUgaW4gbWVtb3J5IGFzDQo+
PiBpbiB0aGUgYW55IG90aGVyIGNhc2Ugd2Ugd2lsbCBnZXQgSU9QU2VzIGhhbHZlZCAoMSBvcGVy
YXRpb24gZm9yDQo+PiBtZXRhZGF0YSBjYWNoZSByZWFkIGFuZCBvbmUgb3BlcmF0aW9uIGZvciBy
ZWFsIHJlYWQpLiBGb3IgOCBUYiBpbWFnZQ0KPj4gdGhpcyByZXN1bHRzIGluIDEgR2IgUkFNIGZv
ciB0aGF0LiBGb3IgMSBNYiBjbHVzdGVyIHdlIGdldCA2NCBNYiB3aGljaA0KPj4gaXMgbXVjaCBt
b3JlIHJlYXNvbmFibGUuDQo+IENvcnJlY3QsIHRoZSBMMiBtZXRhZGF0YSBzaXplIGlzIGEgd2Vs
bC1rbm93biBwcm9ibGVtIHRoYXQgaGFzIGJlZW4NCj4gZGlzY3Vzc2VkIGV4dGVuc2l2ZWx5LCBh
bmQgdGhhdCBoYXMgcmVjZWl2ZWQgcGxlbnR5IG9mIGF0dGVudGlvbi4NCj4NCj4+IFRob3VnaCB3
aXRoIDEgTWIgY2x1c3RlciB0aGUgcmVjbGFpbSBwcm9jZXNzIGJlY29tZXMgbXVjaC1tdWNoDQo+
PiB3b3JzZS4gSSBjYW4gbm90IGdpdmUgZXhhY3QgbnVtYmVyLCB1bmZvcnR1bmF0ZWx5LiAgQUZB
SVIgdGhlIGltYWdlDQo+PiBvY2N1cGllcyAzMC01MCUgbW9yZSBzcGFjZS4gR3V5cywgSSB3b3Vs
ZCBhcHByZWNpYXRlIGlmIHlvdSB3aWxsDQo+PiBjb3JyZWN0IG1lIGhlcmUgd2l0aCByZWFsIG51
bWJlcnMuDQo+IENvcnJlY3QsIGJlY2F1c2UgdGhlIGNsdXN0ZXIgc2l6ZSBpcyB0aGUgc21hbGxl
c3QgdW5pdCBvZiBhbGxvY2F0aW9uLCBzbw0KPiBhIDE2S0Igd3JpdGUgb24gYW4gZW1wdHkgYXJl
YSBvZiB0aGUgaW1hZ2Ugd2lsbCBhbHdheXMgYWxsb2NhdGUgYQ0KPiBjb21wbGV0ZSAxTUIgY2x1
c3Rlci4NCg0KPj4gVGh1cyBpbiByZXNwZWN0IHRvIHRoaXMgcGF0dGVybnMgc3ViY2x1c3RlcnMg
Y291bGQgZ2l2ZSB1cyBiZW5lZml0cyBvZg0KPj4gZmFzdCByYW5kb20gSU8gYW5kIGdvb2QgcmVj
bGFpbSByYXRlLg0KPiBFeGFjdGx5LCBidXQgdGhhdCBmYXN0IHJhbmRvbSBJL08gd291bGQgb25s
eSBoYXBwZW4gd2hlbiBhbGxvY2F0aW5nIG5ldw0KPiBjbHVzdGVycy4gT25jZSB0aGUgY2x1c3Rl
cnMgYXJlIGFsbG9jYXRlZCBpdCBkb2Vzbid0IHByb3ZpZGUgYW55DQo+IGFkZGl0aW9uYWwgcGVy
Zm9ybWFuY2UgYmVuZWZpdC4NCg0KTm8sIEkgYW0gdGFsa2luZyBhYm91dCB0aGUgc2l0dWF0aW9u
IGFmdGVyIHRoZSBhbGxvY2F0aW9uLiBUaGF0IGlzIHRoZSBtYWluDQpwb2ludCB3aHkgSSBoYXZl
IGEgZmVlbGluZyB0aGF0IHN1Yi1jbHVzdGVyIGNvdWxkIHByb3ZpZGUgYSBiZW5lZml0Lg0KDQpP
Sy4gVGhlIHNpdHVhdGlvbiAoMSkgaXMgdGhlIGZvbGxvd2luZzoNCi0gdGhlIGRpc2sgaXMgY29t
cGxldGVseSBhbGxvY2F0ZWQNCi0gUUNPVzIgaW1hZ2Ugc2l6ZSBpcyA4IFRiDQotIHdlIGhhdmUg
aW1hZ2Ugd2l0aCAxIE1iIGNsdXN0ZXIvNjRrIHN1Yi1jbHVzdGVyIChmb3Igc2ltcGxpY2l0eSkN
Ci0gTDIgbWV0YWRhdGEgY2FjaGUgc2l6ZSBpcyAxMjggTWIgKDY0IE1iIEwyIHRhYmxlcywgNjQg
TWIgb3RoZXIgZGF0YSkNCi0gaG9sZXMgYXJlIG1hZGUgb24gYSBzdWItY2x1c3RlciBiYXNlcywg
aS5lLiB3aXRoIDY0IEtiIGdyYW51bGFyaXR5DQoNCkluIHRoaXMgY2FzZSByYW5kb20gSU8gdGVz
dCB3aWxsIGdpdmUgbmVhciBuYXRpdmUgSU9QUyByZXN1bHQuIE1ldGFkYXRhDQppcyBpbiBtZW1v
cnksIG5vIGFkZGl0aW9uYWwgcmVhZHMgYXJlIHJlcXVpcmVkLiBXYXN0ZWQgaG9zdCBmaWxlc3lz
dGVtDQpzcGFjZSAoZHVlIHRvIGNsdXN0ZXIgc2l6ZSkgaXMga2VwdCBhdCBtaW5pbXVtLCBpLmUu
IG9uIHRoZSBsZXZlbCBvZg0KdGhlICJwcmUtc3ViY2x1c3RlciIgUUNPVzIuDQoNClNpdHVhdGlv
biAoMik6DQotIDggVGIgUUNPVzIgaW1hZ2UgaXMgY29tcGxldGVseSBhbGxvY2F0ZWQNCi0gMSBN
YiBjbHVzdGVyIHNpemUsIDEyOCBNYiBMMiBjYWNoZSBzaXplDQoNCk5lYXIgc2FtZSBwZXJmb3Jt
YW5jZSBhcyAoMSksIGJ1dCBtdWNoIGxlc3MgZGlzayBzcGFjZSBzYXZpbmdzIGZvcg0KaG9sZXMu
DQoNClNpdHVhdGlvbiAoMyk6DQotIDggVGIgUUNPVzIgaW1hZ2UsIGNvbXBsZXRlbHkgYWxsb2Nh
dGVkDQotIDY0IEtiIGNsdXN0ZXIgc2l6ZSwgMTI4IE1CIEwyIGNhY2hlDQoNClJhbmRvbSBJTyBw
ZXJmb3JtYW5jZSBoYWx2ZWQgZnJvbSAoMSkgYW5kICgyKSBkdWUgdG8gbWV0YWRhdGENCnJlLXJl
YWQgZm9yIGVhY2ggc3Vic2VxdWVudCBvcGVyYXRpb24uIFNhbWUgZGlzayBzcGFjZSBzYXZpbmdz
DQphcyBpbiBjYXNlICgxKS4NCg0KUGxlYXNlIG5vdGUsIEkgYW0gbm90IHRhbGtpbmcgbm93IGFi
b3V0IHlvdXIgY2FzZSB3aXRoIENPVy4gSGVyZQ0KdGhlIGFsbG9jYXRpb24gaXMgcGVyZm9ybWVk
IG9uIHRoZSBzdWItY2x1c3RlciBiYXNpcywgaS5lLiB0aGUgYWJzY2VuY2UNCm9mIHRoZSBzdWIt
Y2x1c3RlciBpbiB0aGUgaW1hZ2UgbWVhbnMgaG9sZSBvbiB0aGF0IG9mZnNldC4gVGhpcyBpcw0K
aW1wb3J0YW50IGRpZmZlcmVuY2UuDQoNCj4+IEkgd291bGQgY29uc2lkZXIgNjRrIGNsdXN0ZXIv
OGsgc3ViY2x1c3RlciBhcyB0b28gZXh0cmVtZSBmb3IgbWUuICBJbg0KPj4gcmVhbGl0eSB3ZSB3
b3VsZCBlbmQgdXAgd2l0aCBjb21wbGV0ZWx5IGZyYWdtZW50ZWQgaW1hZ2UgdmVyeSBzb29uLg0K
PiBZb3UgbWVhbiBiZWNhdXNlIG9mIHRoZSA2NGsgY2x1c3RlciBzaXplLCBvciBiZWNhdXNlIG9m
IHRoZSA4aw0KPiBzdWJjbHVzdGVyIHNpemU/IElmIGl0J3MgdGhlIGZvcm1lciwgeWVzLiBJZiBp
dCdzIHRoZSBsYXR0ZXIsIGl0IGNhbiBiZQ0KPiBzb2x2ZWQgYnkgcHJlYWxsb2NhdGluZyB0aGUg
Y2x1c3RlciB3aXRoIGZhbGxvY2F0ZSgpLiBCdXQgdGhlbiB5b3Ugd291bGQNCj4gbG9zZSB0aGUg
YmVuZWZpdCBvZiB0aGUgZ29vZCByZWNsYWltIHJhdGUuDQoNCllvdSBhcmUgb3B0aW1pemluZyBD
T1cgc3BlZWQgYW5kIHlvdXIgcHJvcG9zYWwgaXMgb24gdGhhdC4gVGh1cyB5b3UNCmdldHRpbmcg
bWluaW1hbCBhbGxvY2F0aW9uIHVuaXQgYXMgYSBjbHVzdGVyLiBJIGFtIHRhbGtpbmcgYWJvdXQg
YSBiaXQNCmRpZmZlcmVudCBwYXR0ZXJuIG9mIHN1YmNsdXN0ZXIgYmVuZWZpdHMgd2hlbiB0aGUg
b2Zmc2V0IGFsbG9jYXRpb24gdW5pdA0KaXMgY2x1c3RlciB3aGlsZSB0aGUgc3BhY2UgYWxsb2Nh
dGlvbiB1bml0IGlzIHN1Yi1jbHVzdGVyLg0KDQpUaGlzIGlzIGltcG9ydGFudCBkaWZmZXJlbmNl
IGFuZCB0aGF0IGlzIHdoeSBJIGFtIHRhbGtpbmcgdGhhdCBmb3IgbXkNCmNhc2UgOCBLYiBzcGFj
ZSBhbGxvY2F0aW9uIHVuaXQgaXMgdG9vIGV4dHJlbWUuIFRoZXNlIGNhc2Ugc2hvdWxkDQpiZSBz
b21laG93IHNlcGFyYXRlZC4NCg0KRGVuDQo=

