Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1DDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF452469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGjC7Ugi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF452469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7m7j-0002TN-BA
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dhildenb@redhat.com>) id 1j7m70-000234-Cy
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dhildenb@redhat.com>) id 1j7m6y-00015O-Vi
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:19:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dhildenb@redhat.com>) id 1j7m6y-000154-SE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582921192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BoeuqhzkLH2s1Se84FxubtT7QWT99owlm7Jl3tcNgeI=;
 b=GGjC7UgiKY/raZ1kGvxFTIYa90S2wALcg/5mvPnWn48jzNoL+EbdpXJhAzxp0P/YbESyqX
 YfRsJ1XXfgbR7Oq+/f6Ej1ueWcVR+Y3gdvUusNFO4R6fdE3JelFYSNL2zs6LfXvponUxDv
 dJ20zLZitHihUBCP8+UQPBqF9NuP90w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-GGddV5zVMOulHJ91MIgPwg-1; Fri, 28 Feb 2020 15:19:49 -0500
X-MC-Unique: GGddV5zVMOulHJ91MIgPwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56612100550E;
 Fri, 28 Feb 2020 20:19:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F226060C18;
 Fri, 28 Feb 2020 20:19:45 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id A946E35AE1;
 Fri, 28 Feb 2020 20:19:45 +0000 (UTC)
From: David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Date: Fri, 28 Feb 2020 15:19:45 -0500 (EST)
Message-Id: <4D19362F-16B2-4C83-8B6D-48AD87046750@redhat.com>
References: <20200228195522.GY180973@xz-x1>
In-Reply-To: <20200228195522.GY180973@xz-x1>
To: Peter Xu <peterx@redhat.com>
Thread-Topic: util: vfio-helpers: Implement ram_block_resized()
Thread-Index: 6rcNLbQK+YmtQRfnxGSUytbW4op4vQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gQW0gMjguMDIuMjAyMCB1bSAyMDo1NSBzY2hyaWViIFBldGVyIFh1IDxwZXRlcnhAcmVk
aGF0LmNvbT46DQo+IA0KPiDvu79PbiBUaHUsIEZlYiAyNywgMjAyMCBhdCAxMToxMjowMkFNICsw
MTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+ICtzdGF0aWMgdm9pZCBxZW11X3ZmaW9f
ZG1hX21hcF9yZXNpemUoUUVNVVZGSU9TdGF0ZSAqcywgdm9pZCAqaG9zdCwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IG9sZF9zaXplLCBzaXplX3QgbmV3
X3NpemUpDQo+PiArew0KPj4gKyAgICBJT1ZBTWFwcGluZyAqbTsNCj4+ICsgICAgaW50IGluZGV4
ID0gMDsNCj4+ICsNCj4+ICsgICAgcWVtdV9tdXRleF9sb2NrKCZzLT5sb2NrKTsNCj4+ICsgICAg
bSA9IHFlbXVfdmZpb19maW5kX21hcHBpbmcocywgaG9zdCwgJmluZGV4KTsNCj4+ICsgICAgaWYg
KCFtKSB7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsgICAgYXNzZXJ0KG0t
PnNpemUgPT0gb2xkX3NpemUpOw0KPj4gKw0KPj4gKyAgICAvKiBOb3RlOiBOb3QgYXRvbWljIC0g
d2UgbmVlZCBhIG5ldyBpb2N0bCBmb3IgdGhhdC4gKi8NCj4+ICsgICAgcWVtdV92ZmlvX3VuZG9f
bWFwcGluZyhzLCBtLT5pb3ZhLCBtLT5zaXplKTsNCj4+ICsgICAgcWVtdV92ZmlvX2RvX21hcHBp
bmcocywgaG9zdCwgbS0+aW92YSwgbmV3X3NpemUpOw0KPiANCj4gQW5vdGhlciB3YXkgdG8gYXNr
IG15IHByZXZpb3VzIHF1ZXN0aW9uIDEgKGluIHRoZSBvdGhlciByZXBseSk6IENhbiB3ZQ0KPiBz
aW1wbHkgbWFwL3VubWFwIHRoZSBleHRyYSwgd2hpbGUga2VlcCB0aGUgc2hhcmVkIHVudG91Y2hl
ZD8NCg0KQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCB0aGUga2VybmVsIGltcGxlbWVudGF0aW9uLCB1
bmZvcnR1bmF0ZWx5IG5vLiBZb3UgbWlnaHQgYmUgYWJsZSB0byBncm93IChieSBtYXBwaW5nIHRo
ZSBkZWx0YSksIGJ1dCBzaHJpbmtpbmcgaXMgbm90IHBvc3NpYmxlIEFGQUlSLiBBbmQgSSAqdGhp
bmsqIHdpdGggbWFueSByZXNpemVzLCB0aGVyZSBjb3VsZCBiZSBhbiBpc3N1ZSBpZiBJIHJlbWVt
YmVyIGNvcnJlY3RseS4NCg0KVGhhbmtzIQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPj4gKw0KPj4g
KyAgICBtLT5zaXplID0gbmV3X3NpemU7DQo+PiArICAgIGFzc2VydChxZW11X3ZmaW9fdmVyaWZ5
X21hcHBpbmdzKHMpKTsNCj4+ICsNCj4+ICsgICAgcWVtdV9tdXRleF91bmxvY2soJnMtPmxvY2sp
Ow0KPj4gK30NCj4gDQo+IC0tIA0KPiBQZXRlciBYdQ0KPiANCg==


