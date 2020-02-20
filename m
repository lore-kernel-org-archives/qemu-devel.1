Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F0C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB61B208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="UwL23DeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB61B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4mIY-0008RW-2Y
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=31285a090=pdurrant@amazon.co.uk>)
 id 1j4mHy-00081o-CX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=31285a090=pdurrant@amazon.co.uk>)
 id 1j4mHx-0007kN-4d
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:54:50 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=31285a090=pdurrant@amazon.co.uk>)
 id 1j4mHr-0007c9-TC; Thu, 20 Feb 2020 08:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1582206884; x=1613742884;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g4ijhDYuJ3ncYPOAmJGJ2XO3GIUAd9gN9Tr0CE9zfpo=;
 b=UwL23DeIBHC1OZ7SZEQOz0vic2GuIgMc0NV+gekEk/l+bL6lL86gGNY0
 KqzEkOUnY9qVhkTxNOWw8nViLLelipIzSI54TasuCOpk3zqTq78Aa7E1p
 AeRzd2TgXGtuXMWEvHrfJEJ3GHZqBTSURTKlsxXKo6Jt2v3mMk4AjCYBC M=;
IronPort-SDR: i3n99YIbcDxWB3rJtRrCLdb70ZCl5dnSfu60gvIz1jYU0aalW/Uq6GB7epg09S20gthREigk4s
 Rq348+Ihhxtg==
X-IronPort-AV: E=Sophos;i="5.70,464,1574121600"; d="scan'208";a="17318865"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 20 Feb 2020 13:54:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS
 id 1DF23A2DDB; Thu, 20 Feb 2020 13:54:17 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 20 Feb 2020 13:54:16 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 20 Feb 2020 13:54:15 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Thu, 20 Feb 2020 13:54:15 +0000
From: "Durrant, Paul" <pdurrant@amazon.co.uk>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?= <hpoussin@reactos.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Aleksandar Rikalo" <aleksandar.rikalo@rt-rk.com>, Richard Henderson
 <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, "Alistair Francis" <alistair@alistair23.me>, Richard
 Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>, Eric
 Auger <eric.auger@redhat.com>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, John Snow
 <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Igor
 Mitsyanko" <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael Walle" <michael@walle.cc>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>, "Paolo Bonzini" <pbonzini@redhat.com>
Subject: RE: [Xen-devel] [PATCH v3 19/20] Let cpu_[physical]_memory() calls
 pass a boolean 'is_write' argument
Thread-Topic: [Xen-devel] [PATCH v3 19/20] Let cpu_[physical]_memory() calls
 pass a boolean 'is_write' argument
Thread-Index: AQHV5+7vcjjW/3OJHE2x9C8aUbSeQqgkGmwg
Date: Thu, 20 Feb 2020 13:54:15 +0000
Message-ID: <3879f3fc2c3641a28412938601327bb7@EX13D32EUC003.ant.amazon.com>
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-20-philmd@redhat.com>
In-Reply-To: <20200220130548.29974-20-philmd@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.112]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYZW4tZGV2ZWwgPHhlbi1kZXZl
bC1ib3VuY2VzQGxpc3RzLnhlbnByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YNCj4gUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kNCj4gU2VudDogMjAgRmVicnVhcnkgMjAyMCAxMzowNg0KPiBUbzogUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgcWVtdS1kZXZlbEBub25nbnUu
b3JnDQo+IENjOiBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgRG1pdHJ5IEZsZXl0bWFuDQo+
IDxkbWl0cnkuZmxleXRtYW5AZ21haWwuY29tPjsga3ZtQHZnZXIua2VybmVsLm9yZzsgTWljaGFl
bCBTLiBUc2lya2luDQo+IDxtc3RAcmVkaGF0LmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+OyBHZXJkIEhvZmZtYW5uDQo+IDxrcmF4ZWxAcmVkaGF0LmNvbT47IEVkZ2FyIEUu
IElnbGVzaWFzIDxlZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20+OyBTdGVmYW5vDQo+IFN0YWJlbGxp
bmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBNYXR0aGV3IFJvc2F0bw0KPiA8bWpyb3NhdG9A
bGludXguaWJtLmNvbT47IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgRGF2aWQgSGlsZGVuYnJhbmQN
Cj4gPGRhdmlkQHJlZGhhdC5jb20+OyBIYWxpbCBQYXNpYyA8cGFzaWNAbGludXguaWJtLmNvbT47
IENocmlzdGlhbg0KPiBCb3JudHJhZWdlciA8Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbT47IEhlcnbD
qSBQb3Vzc2luZWF1DQo+IDxocG91c3NpbkByZWFjdG9zLm9yZz47IE1hcmNlbCBBcGZlbGJhdW0g
PG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPjsNCj4gQW50aG9ueSBQZXJhcmQgPGFudGhvbnku
cGVyYXJkQGNpdHJpeC5jb20+OyB4ZW4tDQo+IGRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnOyBB
bGVrc2FuZGFyIFJpa2FsbyA8YWxla3NhbmRhci5yaWthbG9AcnQtDQo+IHJrLmNvbT47IFJpY2hh
cmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+OyBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0K
PiA8cGhpbG1kQHJlZGhhdC5jb20+OyBMYXVyZW50IFZpdmllciA8bHZpdmllckByZWRoYXQuY29t
PjsgVGhvbWFzIEh1dGgNCj4gPHRodXRoQHJlZGhhdC5jb20+OyBFZHVhcmRvIEhhYmtvc3QgPGVo
YWJrb3N0QHJlZGhhdC5jb20+OyBTdGVmYW4gV2VpbA0KPiA8c3dAd2VpbG5ldHouZGU+OyBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPjsgUmljaGFyZA0KPiBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBQYXVsIER1cnJhbnQgPHBhdWxAeGVu
Lm9yZz47DQo+IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47IHFlbXUtczM5MHhA
bm9uZ251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAa2FvZC5vcmc+OyBKb2huIFNub3cNCj4gPGpzbm93QHJlZGhhdC5jb20+OyBEYXZpZCBHaWJz
b24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT47IElnb3INCj4gTWl0c3lhbmtvIDxpLm1p
dHN5YW5rb0BnbWFpbC5jb20+OyBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNvbT47DQo+
IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+OyBxZW11LXBwY0Bub25nbnUub3JnOyBQ
YW9sbyBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbWGVuLWRl
dmVsXSBbUEFUQ0ggdjMgMTkvMjBdIExldCBjcHVfW3BoeXNpY2FsXV9tZW1vcnkoKSBjYWxscw0K
PiBwYXNzIGEgYm9vbGVhbiAnaXNfd3JpdGUnIGFyZ3VtZW50DQo+IA0KPiBVc2UgYW4gZXhwbGlj
aXQgYm9vbGVhbiB0eXBlLg0KPiANCj4gVGhpcyBjb21taXQgd2FzIHByb2R1Y2VkIHdpdGggdGhl
IGluY2x1ZGVkIENvY2NpbmVsbGUgc2NyaXB0DQo+IHNjcmlwdHMvY29jY2luZWxsZS9leGVjX3J3
X2NvbnN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogUGF1bCBEdXJyYW50IDxwYXVsQHhlbi5v
cmc+DQo=

