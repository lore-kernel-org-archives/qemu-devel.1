Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1537C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3791020639
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FONkG08n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3791020639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKq4-0004mo-0c
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbC-0007xi-IF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKay-0008JM-To
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVT/KVUIXsVLz0AZTMnyWFtSTWyK78cI6I9B6y85dzw=;
 b=FONkG08nBE42vFXhR2mTq+KorL7qiLh4KU4pFJIpXUMSRAeReQQwePDtSIHNl73JZFcKz2
 VK/5ZaPt8pMh9/suX7cdpEEHNfPs1vRASvLemRgMNZysQQR/WpArvPNMcpikcG/9i5vp5G
 FTqzXfvAgSTpilPxcbmtvVL/tp1gnhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-yHsa2DOeMlKFrkvklLmg4Q-1; Wed, 04 Nov 2020 10:21:02 -0500
X-MC-Unique: yHsa2DOeMlKFrkvklLmg4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF55C809DEB;
 Wed,  4 Nov 2020 15:20:59 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D69310013D9;
 Wed,  4 Nov 2020 15:20:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/33] block/nvme: Change size and alignment of IDENTIFY
 response buffer
Date: Wed,  4 Nov 2020 15:18:16 +0000
Message-Id: <20201104151828.405824-22-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

RnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgoKSW4gcHJlcGFyYXRpb24g
b2YgNjRrQiBob3N0IHBhZ2Ugc3VwcG9ydCwgbGV0J3MgY2hhbmdlIHRoZSBzaXplCmFuZCBhbGln
bm1lbnQgb2YgdGhlIElERU5USUZZIGNvbW1hbmQgcmVzcG9uc2UgYnVmZmVyIHNvIHRoYXQKdGhl
IFZGSU8gRE1BIE1BUCBzdWNjZWVkcy4gV2UgYWxpZ24gb24gdGhlIGhvc3QgcGFnZSBzaXplLgoK
U2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTAyOTA5
MzMwNi4xMDYzODc5LTIwLXBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBI
YWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+Ci0tLQogYmxvY2svbnZtZS5jIHwgOSArKysrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IGJkMzg2MGFjNGUuLjc2Mjg2MjNjMDUg
MTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9udm1lLmMKQEAgLTUyMiwxOSAr
NTIyLDIwIEBAIHN0YXRpYyBib29sIG52bWVfaWRlbnRpZnkoQmxvY2tEcml2ZXJTdGF0ZSAqYnMs
IGludCBuYW1lc3BhY2UsIEVycm9yICoqZXJycCkKICAgICAgICAgLm9wY29kZSA9IE5WTUVfQURN
X0NNRF9JREVOVElGWSwKICAgICAgICAgLmNkdzEwID0gY3B1X3RvX2xlMzIoMHgxKSwKICAgICB9
OworICAgIHNpemVfdCBpZF9zaXplID0gUUVNVV9BTElHTl9VUChzaXplb2YoKmlkKSwgcWVtdV9y
ZWFsX2hvc3RfcGFnZV9zaXplKTsKIAotICAgIGlkID0gcWVtdV90cnlfbWVtYWxpZ24ocy0+cGFn
ZV9zaXplLCBzaXplb2YoKmlkKSk7CisgICAgaWQgPSBxZW11X3RyeV9tZW1hbGlnbihxZW11X3Jl
YWxfaG9zdF9wYWdlX3NpemUsIGlkX3NpemUpOwogICAgIGlmICghaWQpIHsKICAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLCAiQ2Fubm90IGFsbG9jYXRlIGJ1ZmZlciBmb3IgaWRlbnRpZnkgcmVzcG9u
c2UiKTsKICAgICAgICAgZ290byBvdXQ7CiAgICAgfQotICAgIHIgPSBxZW11X3ZmaW9fZG1hX21h
cChzLT52ZmlvLCBpZCwgc2l6ZW9mKCppZCksIHRydWUsICZpb3ZhKTsKKyAgICByID0gcWVtdV92
ZmlvX2RtYV9tYXAocy0+dmZpbywgaWQsIGlkX3NpemUsIHRydWUsICZpb3ZhKTsKICAgICBpZiAo
cikgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJDYW5ub3QgbWFwIGJ1ZmZlciBmb3IgRE1B
Iik7CiAgICAgICAgIGdvdG8gb3V0OwogICAgIH0KIAotICAgIG1lbXNldChpZCwgMCwgc2l6ZW9m
KCppZCkpOworICAgIG1lbXNldChpZCwgMCwgaWRfc2l6ZSk7CiAgICAgY21kLmRwdHIucHJwMSA9
IGNwdV90b19sZTY0KGlvdmEpOwogICAgIGlmIChudm1lX2FkbWluX2NtZF9zeW5jKGJzLCAmY21k
KSkgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJGYWlsZWQgdG8gaWRlbnRpZnkgY29udHJv
bGxlciIpOwpAQCAtNTU2LDcgKzU1Nyw3IEBAIHN0YXRpYyBib29sIG52bWVfaWRlbnRpZnkoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIGludCBuYW1lc3BhY2UsIEVycm9yICoqZXJycCkKICAgICBzLT5z
dXBwb3J0c193cml0ZV96ZXJvZXMgPSAhIShvbmNzICYgTlZNRV9PTkNTX1dSSVRFX1pFUk9FUyk7
CiAgICAgcy0+c3VwcG9ydHNfZGlzY2FyZCA9ICEhKG9uY3MgJiBOVk1FX09OQ1NfRFNNKTsKIAot
ICAgIG1lbXNldChpZCwgMCwgc2l6ZW9mKCppZCkpOworICAgIG1lbXNldChpZCwgMCwgaWRfc2l6
ZSk7CiAgICAgY21kLmNkdzEwID0gMDsKICAgICBjbWQubnNpZCA9IGNwdV90b19sZTMyKG5hbWVz
cGFjZSk7CiAgICAgaWYgKG52bWVfYWRtaW5fY21kX3N5bmMoYnMsICZjbWQpKSB7Ci0tIAoyLjI4
LjAKCg==


