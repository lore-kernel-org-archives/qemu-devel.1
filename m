Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21860C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB06B206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pEJGb17C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB06B206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igmmd-0003Hd-19
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 04:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2465856dc=pdurrant@amazon.com>)
 id 1igmlx-0002sp-VH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2465856dc=pdurrant@amazon.com>)
 id 1igmlw-0003D1-Ol
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:34:37 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=2465856dc=pdurrant@amazon.com>)
 id 1igmlw-00038v-Jp
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1576488877; x=1608024877;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DDvQ3yiYVhJ9tjd97HjSV//yi9mEV12YY9NIt5fiudc=;
 b=pEJGb17C5UEk7cEi1uDJ1ZBFfCnG30CzpFBYUYV8omPwe95+h2qUT2eg
 HdNS6r2LkQ2ZKoxpeZBr8xAcIff6GlW8sI1TW9GEMXw+OAqkvs34hKQwI
 sww++CCoj1kihsu7RxYWzwqjdUlr8pN/4seopDmQPnzxknRh7gPw9rizs M=;
IronPort-SDR: tG4VUDsXH98xrilH5/vb03JyVOr/zbCtvBy/Tdrt6TTtewQ1v655wvHFSS18FI35wGtAfa7xZ/
 NMlSe+8PBvTA==
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="7777485"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 16 Dec 2019 09:34:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS
 id 5D755A2947; Mon, 16 Dec 2019 09:34:32 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 09:34:28 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 09:34:28 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 16 Dec 2019 09:34:27 +0000
From: "Durrant, Paul" <pdurrant@amazon.com>
To: Julien Grall <julien@xen.org>, Ian Jackson <ian.jackson@citrix.com>
CC: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Stefano
 Stabellini" <sstabellini@kernel.org>, osstest service owner
 <osstest-admin@xenproject.org>, Anthony Perard <anthony.perard@citrix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: xen-block: race condition when stopping the device (WAS: Re:
 [Xen-devel] [xen-4.13-testing test] 144736: regressions - FAIL)
Thread-Topic: xen-block: race condition when stopping the device (WAS: Re:
 [Xen-devel] [xen-4.13-testing test] 144736: regressions - FAIL)
Thread-Index: AQHVshZtoj9Bbp/0YEqGkIeiJVi8AKe8ep0A
Date: Mon, 16 Dec 2019 09:34:27 +0000
Message-ID: <e49691262df2450aa48522dc38f80657@EX13D32EUC003.ant.amazon.com>
References: <osstest-144736-mainreport@xen.org>
 <e05a3bc4-2c1d-7e71-af42-d6362c4f6d07@suse.com>
 <6ea2af3c-b277-1118-7c83-ebcb0809d449@xen.org>
 <24051.30893.31444.319978@mariner.uk.xensource.com>
 <7a0ef296-eb50-fbda-63e2-8d890fad5111@xen.org>
 <a65ae7dca64f4f718f116b9174893730@EX13D32EUC003.ant.amazon.com>
 <65df8a75-a658-1a14-6780-66c8706bcc80@xen.org>
In-Reply-To: <65df8a75-a658-1a14-6780-66c8706bcc80@xen.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.122]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 52.95.49.90
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KW3NuaXBdDQo+ID4+DQo+ID4+IFRoaXMgZmVl
bHMgbGlrZSBhIHJhY2UgY29uZGl0aW9uIGJldHdlZW4gdGhlIGluaXQvZnJlZSBjb2RlIHdpdGgN
Cj4gPj4gaGFuZGxlci4gQW50aG9ueSwgZG9lcyBpdCByaW5nIGFueSBiZWxsPw0KPiA+Pg0KPiA+
DQo+ID4gIEZyb20gdGhhdCBzdGFjayBidCBpdCBsb29rcyBsaWtlIGFuIGlvdGhyZWFkIG1hbmFn
ZWQgdG8gcnVuIGFmdGVyIHRoZQ0KPiBzcmluZyB3YXMgTlVMTGVkLiBUaGlzIHNob3VsZCBub3Qg
YmUgYWJsZSBoYXBwZW4gYXMgdGhlIGRhdGFwbGFuZSBzaG91bGQNCj4gaGF2ZSBiZWVuIG1vdmVk
IGJhY2sgb250byBRRU1VJ3MgbWFpbiB0aHJlYWQgY29udGV4dCBiZWZvcmUgdGhlIHJpbmcgaXMN
Cj4gdW5tYXBwZWQuDQo+IA0KPiBNeSBrbm93bGVkZ2Ugb2YgdGhpcyBjb2RlIGlzIGZhaXJseSBs
aW1pdGVkLCBzbyBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQo+IA0KPiBibGtfc2V0X2Fpb19j
b250ZXh0KCkgd291bGQgc2V0IHRoZSBjb250ZXh0IGZvciB0aGUgYmxvY2sgYWlvLiBBRkFJQ1Qs
DQo+IHRoZSBvbmx5IGFpbyBmb3IgdGhlIGJsb2NrIGlzIHhlbl9ibG9ja19jb21wbGV0ZV9haW8o
KS4NCg0KTm90IHF1aXRlLiB4ZW5fYmxvY2tfZGF0YXBsYW5lX3N0YXJ0KCkgY2FsbHMgeGVuX2Rl
dmljZV9iaW5kX2V2ZW50X2NoYW5uZWwoKSBhbmQgdGhhdCB3aWxsIGFkZCBhbiBldmVudCBjaGFu
bmVsIGZkIGludG8gdGhlIGFpbyBjb250ZXh0LCBzbyB0aGUgc2hhcmVkIHJpbmcgaXMgcG9sbGVk
IGJ5IHRoZSBpb3RocmVhZCBhcyB3ZWxsIGFzIGJsb2NrIGkvbyBjb21wbGV0aW9uLg0KDQo+IA0K
PiBJbiB0aGUgc3RhY2sgYWJvdmUsIHdlIGFyZSBub3QgZGVhbGluZyB3aXRoIGEgYmxvY2sgYWlv
IGJ1dCBhbiBhaW8gdGllDQo+IHRvIHRoZSBldmVudCBjaGFubmVsIChzZWUgdGhlIGNhbGwgZnJv
bSB4ZW5fZGV2aWNlX3BvbGwpLiBTbyBJIGRvbid0DQo+IHRoaW5rIHRoZSBibGtfc2V0X2Fpb19j
b250ZXh0KCkgd291bGQgYWZmZWN0IHRoZSBhaW8uDQo+IA0KDQpGb3IgdGhlIHJlYXNvbiBJIG91
dGxpbmUgYWJvdmUsIGl0IGRvZXMuDQoNCj4gU28gaXQgd291bGQgYmUgcG9zc2libGUgdG8gZ2V0
IHRoZSBpb3RocmVhZCBydW5uaW5nIGJlY2F1c2Ugd2UgcmVjZWl2ZWQNCj4gYSBub3RpZmljYXRp
b24gb24gdGhlIGV2ZW50IGNoYW5uZWwgd2hpbGUgd2UgYXJlIHN0b3BwaW5nIHRoZSBibG9jayAo
aS5lDQo+IHhlbl9ibG9ja19kYXRhcGxhbmVfc3RvcCgpKS4NCj4gDQoNCldlIHNob3VsZCBhc3N1
bWUgYW4gaW90aHJlYWQgY2FuIGVzc2VudGlhbGx5IHJ1biBhdCBhbnkgdGltZSwgYXMgaXQgaXMg
YSBwb2xsaW5nIGVudGl0eS4gSXQgc2hvdWxkIGV2ZW50dWFsbHkgYmxvY2sgcG9sbGluZyBvbiBm
ZHMgYXNzaWduIHRvIGl0cyBhaW8gY29udGV4dCBidXQgSSBkb24ndCB0aGluayB0aGUgYWJzdHJh
Y3Rpb24gZ3VhcmFudGVlcyB0aGF0IGl0IGNhbm5vdCBiZSBhd29rZW4gZm9yIG90aGVyIHJlYXNv
bnMgKGUuZy4gb2ZmIGEgdGltZW91dCkuIEhvd2V2ZXIgYW5kIGV2ZW50IGZyb20gdGhlIGZyb250
ZW5kIHdpbGwgY2VydGFpbmx5IGNhdXNlIHRoZSBldnRjaG4gZmQgcG9sbCB0byB3YWtlIHVwLg0K
DQo+IElmIHhlbl9ibG9ja19kYXRhcGxhbmVfc3RvcCgpIGdyYWIgdGhlIGNvbnRleHQgbG9jayBm
aXJzdCwgdGhlbiB0aGUNCj4gaW90aHJlYWQgZGVhbGluZyB3aXRoIHRoZSBldmVudCBtYXkgd2Fp
dCBvbiB0aGUgbG9jayB1bnRpbCBpdHMgcmVsZWFzZWQuDQo+IA0KPiBCeSB0aGUgdGltZSB0aGUg
bG9jayBpcyBncmFiYmVkLCB3ZSBtYXkgaGF2ZSBmcmVlIGFsbCB0aGUgcmVzb3VyY2VzDQo+IChp
bmNsdWRpbmcgc3JpbmdzKS4gU28gdGhlIGV2ZW50IGlvdGhyZWFkIHdpbGwgZW5kIHVwIHRvIGRl
cmVmZXJlbmNlIGENCj4gTlVMTCBwb2ludGVyLg0KPiANCg0KSSB0aGluayB0aGUgcHJvYmxlbSBt
YXkgYWN0dWFsbHkgYmUgdGhhdCB4ZW5fYmxvY2tfZGF0YXBsYW5lX2V2ZW50KCkgZG9lcyBub3Qg
YWNxdWlyZSB0aGUgY29udGV4dCBhbmQgdGh1cyBpcyBub3Qgc3luY2hyb25pemVkIHdpdGggeGVu
X2Jsb2NrX2RhdGFwbGFuZV9zdG9wKCkuIFRoZSBkb2N1bWVudGF0aW9uIGluIG11bHRpcGxlLWlv
dGhyZWFkcy50eHQgaXMgbm90IGNsZWFyIHdoZXRoZXIgYSBwb2xsIGhhbmRsZXIgY2FsbGVkIGJ5
IGFuIGlvdGhyZWFkIG5lZWRzIHRvIGFjcXVpcmUgdGhlIGNvbnRleHQgdGhvdWdoOyBUQkggSSB3
b3VsZCBub3QgaGF2ZSB0aG91Z2h0IGl0IG5lY2Vzc2FyeS4NCg0KPiBJdCBmZWVscyB0byBtZSB3
ZSBuZWVkIGEgd2F5IHRvIHF1aWVzY2UgYWxsIHRoZSBpb3RocmVhZHMgKGJsaywNCj4gZXZlbnQs
Li4uKSBiZWZvcmUgY29udGludWluZy4gQnV0IEkgYW0gYSBiaXQgdW5zdXJlIGhvdyB0byBkbyB0
aGlzIGluDQo+IFFFTVUuDQo+IA0KDQpMb29raW5nIGF0IHZpcnRpby1ibGsuYyBJIHNlZSB0aGF0
IGl0IGRvZXMgc2VlbSB0byBjbG9zZSBvZmYgaXRzIGV2dGNobiBlcXVpdmFsZW50IGZyb20gaW90
aHJlYWQgY29udGV4dCB2aWEgYWlvX3dhaXRfYmhfb25lc2hvdCgpLiBTbyBJIHdvbmRlciB3aGV0
aGVyIHRoZSAncmlnaHQnIHRoaW5nIHRvIGRvIGlzIHRvIGNhbGwgeGVuX2RldmljZV91bmJpbmRf
ZXZlbnRfY2hhbm5lbCgpIHVzaW5nIHRoZSBzYW1lIG1lY2hhbmlzbSB0byBlbnN1cmUgeGVuX2Js
b2NrX2RhdGFwbGFuZV9ldmVudCgpIGNhbid0IHJhY2UuDQoNCiAgUGF1bA0KDQo+IENoZWVycywN
Cj4gDQo+IC0tDQo+IEp1bGllbiBHcmFsbA0K

