Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6298320637
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hpn7veaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6298320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ebv-0002Br-Hw
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2eal-0000Xw-OW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2eak-0007Bi-Nx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2eak-00079z-KD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581700644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XOL0f/zn56TGD4z+RPzEjpgVHsuCHK+Ay9Y2kUAWPik=;
 b=Hpn7veaWrZkzNo1TMgdqlEMkqDy8cijwkyvvYlfOtsSm8n/7KtQo2j6+QtG6+n6fySpnk6
 5srnE5Nte1FBJet0FfrSmRZQHpIZwjsmnhz5SPZ1z1n39oQ1n2Mjl8MlOiCkU6imW18qxS
 r5ndHs6IS+4N7OSv8A2H8yUnuDa08cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-nhGsjmjxPKqCUCStuUpJVg-1; Fri, 14 Feb 2020 12:17:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1169B1005512;
 Fri, 14 Feb 2020 17:17:22 +0000 (UTC)
Received: from localhost (ovpn-116-135.ams2.redhat.com [10.36.116.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25A4C19C4F;
 Fri, 14 Feb 2020 17:17:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] aio-posix: towards an O(1) event loop
Date: Fri, 14 Feb 2020 17:17:07 +0000
Message-Id: <20200214171712.541358-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nhGsjmjxPKqCUCStuUpJVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgbWFrZXMgQWlvSGFuZGxlciBkZWxldGlvbiBhbmQgZGlzcGF0Y2gg
TygxKSB3aXRoIHJlc3BlY3QgdG8KdGhlIHRvdGFsIG51bWJlciBvZiByZWdpc3RlcmVkIGhhbmRs
ZXJzLiAgVGhlIGV2ZW50IGxvb3AgaGFzIHNjYWxhYmlsaXR5CnByb2JsZW1zIHdoZW4gbWFueSBB
aW9IYW5kbGVycyBhcmUgcmVnaXN0ZXJlZCBiZWNhdXNlIGl0IGlzIE8obikuICBMaW51eAplcG9s
bCg3KSBpcyB1c2VkIHRvIGF2b2lkIHNjYW5uaW5nIG92ZXIgYWxsIHBvbGxmZHMgYnV0IHBhcnRz
IG9mIHRoZSBjb2RlIHN0aWxsCnNjYW4gYWxsIEFpb0hhbmRsZXJzLgoKVGhpcyBzZXJpZXMgcmVk
dWNlcyBRRU1VIENQVSB1dGlsaXphdGlvbiBhbmQgdGhlcmVmb3JlIGluY3JlYXNlcyBJT1BTLApl
c3BlY2lhbGx5IGZvciBndWVzdHMgdGhhdCBoYXZlIG1hbnkgZGV2aWNlcy4gIEl0IHdhcyB0ZXN0
ZWQgd2l0aCAzMiB2Q1BVcywgMgp2aXJ0aW8tYmxrLG51bS1xdWV1ZXM9MSxpb3RocmVhZD1pb3Ro
cmVhZDEsIGFuZCA5OQp2aXJ0aW8tYmxrLG51bS1xdWV1ZXM9MzIsaW90aHJlYWQ9aW90aHJlYWQx
IGRldmljZXMuICBVc2luZyBhbiBJT1RocmVhZCBpcwpuZWNlc3NhcnkgYmVjYXVzZSB0aGlzIHNl
cmllcyBkb2VzIG5vdCBpbXByb3ZlIHRoZSBnbGliIG1haW4gbG9vcCwgYSBub24tZ29hbApzaW5j
ZSB0aGUgZ2xpYiBBUEkgaXMgaW5oZXJlbnRseSBPKG4pLgoKQWlvQ29udGV4dCBwb2xsaW5nIHJl
bWFpbnMgTyhuKSBhbmQgd2lsbCBiZSBhZGRyZXNzZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaApzZXJp
ZXMuICBUaGlzIHBhdGNoIHNlcmllcyBpbmNyZWFzZXMgSU9QUyBmcm9tIDI2MGsgdG8gMzAwayB3
aGVuIEFpb0NvbnRleHQKcG9sbGluZyBpcyBjb21tZW50ZWQgb3V0Cihydz1yYW5kcmVhZCxicz00
ayxpb2RlcHRoPTMyLGlvZW5naW5lPWxpYmFpbyxkaXJlY3Q9MSkuCgpTdGVmYW4gSGFqbm9jemkg
KDUpOgogIGFpby1wb3NpeDogZml4IHVzZSBhZnRlciBsZWF2aW5nIHNjb3BlIGluIGFpb19wb2xs
KCkKICBhaW8tcG9zaXg6IGRvbid0IHBhc3MgbnMgdGltZW91dCB0byBlcG9sbF93YWl0KCkKICBx
ZW11L3F1ZXVlLmg6IGFkZCBRTElTVF9TQUZFX1JFTU9WRSgpCiAgYWlvLXBvc2l4OiBtYWtlIEFp
b0hhbmRsZXIgZGVsZXRpb24gTygxKQogIGFpby1wb3NpeDogbWFrZSBBaW9IYW5kbGVyIGRpc3Bh
dGNoIE8oMSkgd2l0aCBlcG9sbAoKIGJsb2NrLmMgICAgICAgICAgICAgIHwgICA1ICstCiBjaGFy
ZGV2L3NwaWNlLmMgICAgICB8ICAgNCArLQogaW5jbHVkZS9ibG9jay9haW8uaCAgfCAgIDYgKy0K
IGluY2x1ZGUvcWVtdS9xdWV1ZS5oIHwgIDE3ICsrKysrCiB1dGlsL2Fpby1wb3NpeC5jICAgICB8
IDE3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiA1IGZpbGVz
IGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkKCi0tIAoyLjI0LjEK
Cg==


