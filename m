Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29428C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2682074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NguAE4RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2682074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKhY-0000ev-H1
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZc-00065m-8q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZa-0007xu-BM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzuXVeQJ2VZeXPN39nJ7L5qwBZo2wyj0g1Y6BEr9LAQ=;
 b=NguAE4RJzjm+HUqdIAvLUYHFoZMbdUD3wrPwDAF9tsUVhbLtol6pYsy22p4RlsG5cBp0Nf
 GIiGJ1DKbzXdMLCGGBJlbE6IgS1V1DZSsHCN9xKzvZxJe5voqREUcWiFw0cjgNR3lNv//q
 kJSdzjuA1y94p/gxES8nJfl5wAZSDC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-7IKcfCjVNduoFfx_sU7AAw-1; Wed, 04 Nov 2020 10:19:39 -0500
X-MC-Unique: 7IKcfCjVNduoFfx_sU7AAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D87BF186DD29;
 Wed,  4 Nov 2020 15:19:37 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DE5355794;
 Wed,  4 Nov 2020 15:19:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/33] block/nvme: Trace queue pair creation/deletion
Date: Wed,  4 Nov 2020 15:18:04 +0000
Message-Id: <20201104151828.405824-10-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKUmV2aWV3
ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2Vy
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDEwMjkwOTMzMDYuMTA2
Mzg3OS04LXBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJl
ZGhhdC5jb20+Ci0tLQogYmxvY2svbnZtZS5jICAgICAgIHwgMyArKysKIGJsb2NrL3RyYWNlLWV2
ZW50cyB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IDI5ZDI1NDFiOTEuLmU5NWQ1OWQz
MTIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9udm1lLmMKQEAgLTE4MSw2
ICsxODEsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2luaXRfcXVldWUoQkRSVk5WTWVTdGF0ZSAqcywg
TlZNZVF1ZXVlICpxLAogCiBzdGF0aWMgdm9pZCBudm1lX2ZyZWVfcXVldWVfcGFpcihOVk1lUXVl
dWVQYWlyICpxKQogeworICAgIHRyYWNlX252bWVfZnJlZV9xdWV1ZV9wYWlyKHEtPmluZGV4LCBx
KTsKICAgICBpZiAocS0+Y29tcGxldGlvbl9iaCkgewogICAgICAgICBxZW11X2JoX2RlbGV0ZShx
LT5jb21wbGV0aW9uX2JoKTsKICAgICB9CkBAIC0yMTYsNiArMjE3LDggQEAgc3RhdGljIE5WTWVR
dWV1ZVBhaXIgKm52bWVfY3JlYXRlX3F1ZXVlX3BhaXIoQkRSVk5WTWVTdGF0ZSAqcywKICAgICBp
ZiAoIXEpIHsKICAgICAgICAgcmV0dXJuIE5VTEw7CiAgICAgfQorICAgIHRyYWNlX252bWVfY3Jl
YXRlX3F1ZXVlX3BhaXIoaWR4LCBxLCBzaXplLCBhaW9fY29udGV4dCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGV2ZW50X25vdGlmaWVyX2dldF9mZChzLT5pcnFfbm90aWZpZXIp
KTsKICAgICBxLT5wcnBfbGlzdF9wYWdlcyA9IHFlbXVfdHJ5X21lbWFsaWduKHMtPnBhZ2Vfc2l6
ZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMtPnBhZ2Vfc2l6
ZSAqIE5WTUVfTlVNX1JFUVMpOwogICAgIGlmICghcS0+cHJwX2xpc3RfcGFnZXMpIHsKZGlmZiAt
LWdpdCBhL2Jsb2NrL3RyYWNlLWV2ZW50cyBiL2Jsb2NrL3RyYWNlLWV2ZW50cwppbmRleCBjYzVl
MmI1NWNiLi5mNmEwZjk5ZGYxIDEwMDY0NAotLS0gYS9ibG9jay90cmFjZS1ldmVudHMKKysrIGIv
YmxvY2svdHJhY2UtZXZlbnRzCkBAIC0xNTUsNiArMTU1LDggQEAgbnZtZV9kc20odm9pZCAqcywg
dWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcykgInMgJXAgb2Zmc2V0IDB4JSJQUkl4NjQi
IGJ5dGUKIG52bWVfZHNtX2RvbmUodm9pZCAqcywgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBi
eXRlcywgaW50IHJldCkgInMgJXAgb2Zmc2V0IDB4JSJQUkl4NjQiIGJ5dGVzICUiUFJJZDY0IiBy
ZXQgJWQiCiBudm1lX2RtYV9tYXBfZmx1c2godm9pZCAqcykgInMgJXAiCiBudm1lX2ZyZWVfcmVx
X3F1ZXVlX3dhaXQodm9pZCAqcywgdW5zaWduZWQgcV9pbmRleCkgInMgJXAgcSAjJXUiCitudm1l
X2NyZWF0ZV9xdWV1ZV9wYWlyKHVuc2lnbmVkIHFfaW5kZXgsIHZvaWQgKnEsIHVuc2lnbmVkIHNp
emUsIHZvaWQgKmFpb19jb250ZXh0LCBpbnQgZmQpICJpbmRleCAldSBxICVwIHNpemUgJXUgYWlv
Y3R4ICVwIGZkICVkIgorbnZtZV9mcmVlX3F1ZXVlX3BhaXIodW5zaWduZWQgcV9pbmRleCwgdm9p
ZCAqcSkgImluZGV4ICV1IHEgJXAiCiBudm1lX2NtZF9tYXBfcWlvdih2b2lkICpzLCB2b2lkICpj
bWQsIHZvaWQgKnJlcSwgdm9pZCAqcWlvdiwgaW50IGVudHJpZXMpICJzICVwIGNtZCAlcCByZXEg
JXAgcWlvdiAlcCBlbnRyaWVzICVkIgogbnZtZV9jbWRfbWFwX3Fpb3ZfcGFnZXModm9pZCAqcywg
aW50IGksIHVpbnQ2NF90IHBhZ2UpICJzICVwIHBhZ2VbJWRdIDB4JSJQUkl4NjQKIG52bWVfY21k
X21hcF9xaW92X2lvdih2b2lkICpzLCBpbnQgaSwgdm9pZCAqcGFnZSwgaW50IHBhZ2VzKSAicyAl
cCBpb3ZbJWRdICVwIHBhZ2VzICVkIgotLSAKMi4yOC4wCgo=


