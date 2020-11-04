Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2762074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be94Jlmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2762074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKeR-0004at-0Y
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZJ-0005L2-6A
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZG-0007vE-Gq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjM2kasnawtpzgGpfjhWZ6lqZjslto+EambDgfSaRbc=;
 b=be94JlmmbZhJqTUlOV4eFfAkqf3hjU1stpe2YAA7ctFMjRNNa7L/205Ny/PfQB7coaMx/Q
 310GJD7EbKSF1/zW0rAfPYqSMQSFcMT8nT702R6hYUb4GIzWdLtAuxNX2CWTQVPJsRd427
 itoLy0xLgzkgoBAsqsJcu8y4OQJtmwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-65iT7XPcNveu--tHGxoDQg-1; Wed, 04 Nov 2020 10:19:19 -0500
X-MC-Unique: 65iT7XPcNveu--tHGxoDQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884858015A3;
 Wed,  4 Nov 2020 15:19:17 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C78A45D9CC;
 Wed,  4 Nov 2020 15:19:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/33] block/nvme: Trace controller capabilities
Date: Wed,  4 Nov 2020 15:18:01 +0000
Message-Id: <20201104151828.405824-7-stefanha@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKQ29udHJv
bGxlcnMgaGF2ZSBkaWZmZXJlbnQgY2FwYWJpbGl0aWVzIGFuZCByZXBvcnQgdGhlbSBpbiB0aGUK
Q0FQIHJlZ2lzdGVyLiBXZSBhcmUgcGFydGljdWxhcmx5IGludGVyZXN0ZWQgYnkgdGhlIHBhZ2Ug
c2l6ZQpsaW1pdHMuCgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgpSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpU
ZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlk
OiAyMDIwMTAyOTA5MzMwNi4xMDYzODc5LTUtcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgICAgICAgfCAx
MyArKysrKysrKysrKysrCiBibG9jay90cmFjZS1ldmVudHMgfCAgMiArKwogMiBmaWxlcyBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2sv
bnZtZS5jCmluZGV4IDZmMWQ3ZjliMmEuLjM2MWI1NzcyYjcgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252
bWUuYworKysgYi9ibG9jay9udm1lLmMKQEAgLTcyNyw2ICs3MjcsMTkgQEAgc3RhdGljIGludCBu
dm1lX2luaXQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IGNoYXIgKmRldmljZSwgaW50IG5h
bWVzcGFjZSwKICAgICAgKiBJbml0aWFsaXphdGlvbiIuICovCiAKICAgICBjYXAgPSBsZTY0X3Rv
X2NwdShyZWdzLT5jYXApOworICAgIHRyYWNlX252bWVfY29udHJvbGxlcl9jYXBhYmlsaXR5X3Jh
dyhjYXApOworICAgIHRyYWNlX252bWVfY29udHJvbGxlcl9jYXBhYmlsaXR5KCJNYXhpbXVtIFF1
ZXVlIEVudHJpZXMgU3VwcG9ydGVkIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAxICsgTlZNRV9DQVBfTVFFUyhjYXApKTsKKyAgICB0cmFjZV9udm1lX2NvbnRyb2xsZXJf
Y2FwYWJpbGl0eSgiQ29udGlndW91cyBRdWV1ZXMgUmVxdWlyZWQiLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5WTUVfQ0FQX0NRUihjYXApKTsKKyAgICB0cmFjZV9udm1l
X2NvbnRyb2xsZXJfY2FwYWJpbGl0eSgiRG9vcmJlbGwgU3RyaWRlIiwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAyIDw8ICgyICsgTlZNRV9DQVBfRFNUUkQoY2FwKSkpOwor
ICAgIHRyYWNlX252bWVfY29udHJvbGxlcl9jYXBhYmlsaXR5KCJTdWJzeXN0ZW0gUmVzZXQgU3Vw
cG9ydGVkIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVk1FX0NBUF9O
U1NSUyhjYXApKTsKKyAgICB0cmFjZV9udm1lX2NvbnRyb2xsZXJfY2FwYWJpbGl0eSgiTWVtb3J5
IFBhZ2UgU2l6ZSBNaW5pbXVtIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAxIDw8ICgxMiArIE5WTUVfQ0FQX01QU01JTihjYXApKSk7CisgICAgdHJhY2VfbnZtZV9jb250
cm9sbGVyX2NhcGFiaWxpdHkoIk1lbW9yeSBQYWdlIFNpemUgTWF4aW11bSIsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMSA8PCAoMTIgKyBOVk1FX0NBUF9NUFNNQVgoY2Fw
KSkpOwogICAgIGlmICghTlZNRV9DQVBfQ1NTKGNhcCkpIHsKICAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiRGV2aWNlIGRvZXNuJ3Qgc3VwcG9ydCBOVk1lIGNvbW1hbmQgc2V0Iik7CiAgICAgICAg
IHJldCA9IC1FSU5WQUw7CmRpZmYgLS1naXQgYS9ibG9jay90cmFjZS1ldmVudHMgYi9ibG9jay90
cmFjZS1ldmVudHMKaW5kZXggMDk1NWM4NWM3OC4uYjkwYjA3YjE1ZiAxMDA2NDQKLS0tIGEvYmxv
Y2svdHJhY2UtZXZlbnRzCisrKyBiL2Jsb2NrL3RyYWNlLWV2ZW50cwpAQCAtMTM0LDYgKzEzNCw4
IEBAIHFlZF9haW9fd3JpdGVfcG9zdGZpbGwodm9pZCAqcywgdm9pZCAqYWNiLCB1aW50NjRfdCBz
dGFydCwgc2l6ZV90IGxlbiwgdWludDY0X3QKIHFlZF9haW9fd3JpdGVfbWFpbih2b2lkICpzLCB2
b2lkICphY2IsIGludCByZXQsIHVpbnQ2NF90IG9mZnNldCwgc2l6ZV90IGxlbikgInMgJXAgYWNi
ICVwIHJldCAlZCBvZmZzZXQgJSJQUkl1NjQiIGxlbiAlenUiCiAKICMgbnZtZS5jCitudm1lX2Nv
bnRyb2xsZXJfY2FwYWJpbGl0eV9yYXcodWludDY0X3QgdmFsdWUpICIweCUwOCJQUkl4NjQKK252
bWVfY29udHJvbGxlcl9jYXBhYmlsaXR5KGNvbnN0IGNoYXIgKmRlc2MsIHVpbnQ2NF90IHZhbHVl
KSAiJXM6ICUiUFJJdTY0CiBudm1lX2tpY2sodm9pZCAqcywgaW50IHF1ZXVlKSAicyAlcCBxdWV1
ZSAlZCIKIG52bWVfZG1hX2ZsdXNoX3F1ZXVlX3dhaXQodm9pZCAqcykgInMgJXAiCiBudm1lX2Vy
cm9yKGludCBjbWRfc3BlY2lmaWMsIGludCBzcV9oZWFkLCBpbnQgc3FpZCwgaW50IGNpZCwgaW50
IHN0YXR1cykgImNtZF9zcGVjaWZpYyAlZCBzcV9oZWFkICVkIHNxaWQgJWQgY2lkICVkIHN0YXR1
cyAweCV4IgotLSAKMi4yOC4wCgo=


