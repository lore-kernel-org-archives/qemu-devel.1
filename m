Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB799C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B6B2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW61n5OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B6B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKmi-0007mH-0K
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKah-0007ii-Rq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKad-0008BZ-5N
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBGbTbP0mIaJCRUrfStVTozZGOjxjeHijDHeNpd3GaM=;
 b=OW61n5OPv7rZ9GIGJ2pi7BV4cERRy5MuPWJ0vIv76teU2GJpE85AtVNSoO8pdJt9/fgXX6
 HD0y8KoaQVoG3ndYIXicjVpjH35YPh3wGvKGhwi+jjlPrqV5PLYgkoanOEd4K+NVjGgvI0
 IXtbPAVIZylG0MSYgCqgsLjdwDzCfSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-CBk2r6niPzOef1cOM25H6Q-1; Wed, 04 Nov 2020 10:20:43 -0500
X-MC-Unique: CBk2r6niPzOef1cOM25H6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA7D96D582;
 Wed,  4 Nov 2020 15:20:40 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2EE65D9CC;
 Wed,  4 Nov 2020 15:20:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/33] block/nvme: Simplify ADMIN queue access
Date: Wed,  4 Nov 2020 15:18:12 +0000
Message-Id: <20201104151828.405824-18-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKV2UgZG9u
J3QgbmVlZCB0byBkZXJlZmVyZW5jZSBmcm9tIEJEUlZOVk1lU3RhdGUgZWFjaCB0aW1lLgpVc2Ug
YSBOVk1lUXVldWVQYWlyIHBvaW50ZXIgb24gdGhlIGFkbWluIHF1ZXVlLgpUaGUgbnZtZV9pbml0
KCkgYmVjb21lcyBlYXNpZXIgdG8gcmV2aWV3LCBtYXRjaGluZyB0aGUgc3R5bGUKb2YgbnZtZV9h
ZGRfaW9fcXVldWUoKS4KClJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+Ck1lc3NhZ2Ut
aWQ6IDIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMTYtcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgfCAxMiAr
KysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IDA5MDJh
YTU1NDIuLmVlZDEyZjQ5MzMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9u
dm1lLmMKQEAgLTcwMCw2ICs3MDAsNyBAQCBzdGF0aWMgaW50IG52bWVfaW5pdChCbG9ja0RyaXZl
clN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBpbnQgbmFtZXNwYWNlLAogICAgICAgICAg
ICAgICAgICAgICAgRXJyb3IgKiplcnJwKQogewogICAgIEJEUlZOVk1lU3RhdGUgKnMgPSBicy0+
b3BhcXVlOworICAgIE5WTWVRdWV1ZVBhaXIgKnE7CiAgICAgQWlvQ29udGV4dCAqYWlvX2NvbnRl
eHQgPSBiZHJ2X2dldF9haW9fY29udGV4dChicyk7CiAgICAgaW50IHJldDsKICAgICB1aW50NjRf
dCBjYXA7CkBAIC03ODEsMTkgKzc4MiwxOCBAQCBzdGF0aWMgaW50IG52bWVfaW5pdChCbG9ja0Ry
aXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBpbnQgbmFtZXNwYWNlLAogCiAgICAg
LyogU2V0IHVwIGFkbWluIHF1ZXVlLiAqLwogICAgIHMtPnF1ZXVlcyA9IGdfbmV3KE5WTWVRdWV1
ZVBhaXIgKiwgMSk7Ci0gICAgcy0+cXVldWVzW0lOREVYX0FETUlOXSA9IG52bWVfY3JlYXRlX3F1
ZXVlX3BhaXIocywgYWlvX2NvbnRleHQsIDAsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZNRV9RVUVVRV9TSVpFLAotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycnApOwot
ICAgIGlmICghcy0+cXVldWVzW0lOREVYX0FETUlOXSkgeworICAgIHEgPSBudm1lX2NyZWF0ZV9x
dWV1ZV9wYWlyKHMsIGFpb19jb250ZXh0LCAwLCBOVk1FX1FVRVVFX1NJWkUsIGVycnApOworICAg
IGlmICghcSkgewogICAgICAgICByZXQgPSAtRUlOVkFMOwogICAgICAgICBnb3RvIG91dDsKICAg
ICB9CisgICAgcy0+cXVldWVzW0lOREVYX0FETUlOXSA9IHE7CiAgICAgcy0+cXVldWVfY291bnQg
PSAxOwogICAgIFFFTVVfQlVJTERfQlVHX09OKChOVk1FX1FVRVVFX1NJWkUgLSAxKSAmIDB4RjAw
MCk7CiAgICAgcmVncy0+YXFhID0gY3B1X3RvX2xlMzIoKChOVk1FX1FVRVVFX1NJWkUgLSAxKSA8
PCBBUUFfQUNRU19TSElGVCkgfAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICgoTlZNRV9R
VUVVRV9TSVpFIC0gMSkgPDwgQVFBX0FTUVNfU0hJRlQpKTsKLSAgICByZWdzLT5hc3EgPSBjcHVf
dG9fbGU2NChzLT5xdWV1ZXNbSU5ERVhfQURNSU5dLT5zcS5pb3ZhKTsKLSAgICByZWdzLT5hY3Eg
PSBjcHVfdG9fbGU2NChzLT5xdWV1ZXNbSU5ERVhfQURNSU5dLT5jcS5pb3ZhKTsKKyAgICByZWdz
LT5hc3EgPSBjcHVfdG9fbGU2NChxLT5zcS5pb3ZhKTsKKyAgICByZWdzLT5hY3EgPSBjcHVfdG9f
bGU2NChxLT5jcS5pb3ZhKTsKIAogICAgIC8qIEFmdGVyIHNldHRpbmcgdXAgYWxsIGNvbnRyb2wg
cmVnaXN0ZXJzIHdlIGNhbiBlbmFibGUgZGV2aWNlIG5vdy4gKi8KICAgICByZWdzLT5jYyA9IGNw
dV90b19sZTMyKChjdHozMihOVk1FX0NRX0VOVFJZX0JZVEVTKSA8PCBDQ19JT0NRRVNfU0hJRlQp
IHwKLS0gCjIuMjguMAoK


