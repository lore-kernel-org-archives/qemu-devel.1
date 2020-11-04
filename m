Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BCEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5B520759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk9+vFx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5B520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKwj-0007Xk-Cv
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbs-0000AD-OD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbp-0008QZ-1K
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIZZ5Hi8D4fcT+xa9s+gZYl3zzMRkTliQG4Od6XVvZo=;
 b=Xk9+vFx2dlVzYSejS1mWRbuhGc39Wc90bHH1i2H3Kq3cx/OvnxIFItBspAJtQWTMRsBPvu
 WQEwrLjSwKOy2J3WlZL3iUbIIwbiYuutC0AqKRiHCxT7VGeVGO8/pH/dSdJn5sMqrUc23p
 E3bvG9dEJ4Th730jx/5i9P+KnYn0hOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-DiWugDmTNjK3oZpa5F_aCw-1; Wed, 04 Nov 2020 10:21:52 -0500
X-MC-Unique: DiWugDmTNjK3oZpa5F_aCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4930879519;
 Wed,  4 Nov 2020 15:21:50 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 748FA73672;
 Wed,  4 Nov 2020 15:21:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 30/33] util/vfio-helpers: Trace where BARs are mapped
Date: Wed,  4 Nov 2020 15:18:25 +0000
Message-Id: <20201104151828.405824-31-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKRm9yIGRl
YnVnZ2luZyBwdXJwb3NlLCB0cmFjZSB3aGVyZSBhIEJBUiBpcyBtYXBwZWQuCgpSZXZpZXdlZC1i
eTogRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTEwMzAyMDczMy4yMzAz
MTQ4LTUtcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4KLS0tCiB1dGlsL3ZmaW8taGVscGVycy5jIHwgMiArKwogdXRpbC90cmFjZS1ldmVu
dHMgICB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS91dGlsL3ZmaW8taGVscGVycy5jIGIvdXRpbC92ZmlvLWhlbHBlcnMuYwppbmRleCBjZDYyODdj
M2E5Li4yNzhjNTQ5MDJlIDEwMDY0NAotLS0gYS91dGlsL3ZmaW8taGVscGVycy5jCisrKyBiL3V0
aWwvdmZpby1oZWxwZXJzLmMKQEAgLTE2Niw2ICsxNjYsOCBAQCB2b2lkICpxZW11X3ZmaW9fcGNp
X21hcF9iYXIoUUVNVVZGSU9TdGF0ZSAqcywgaW50IGluZGV4LAogICAgIHAgPSBtbWFwKE5VTEws
IE1JTihzaXplLCBzLT5iYXJfcmVnaW9uX2luZm9baW5kZXhdLnNpemUgLSBvZmZzZXQpLAogICAg
ICAgICAgICAgIHByb3QsIE1BUF9TSEFSRUQsCiAgICAgICAgICAgICAgcy0+ZGV2aWNlLCBzLT5i
YXJfcmVnaW9uX2luZm9baW5kZXhdLm9mZnNldCArIG9mZnNldCk7CisgICAgdHJhY2VfcWVtdV92
ZmlvX3BjaV9tYXBfYmFyKGluZGV4LCBzLT5iYXJfcmVnaW9uX2luZm9baW5kZXhdLm9mZnNldCAs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemUsIG9mZnNldCwgcCk7CiAgICAg
aWYgKHAgPT0gTUFQX0ZBSUxFRCkgewogICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVy
cm5vLCAiRmFpbGVkIHRvIG1hcCBCQVIgcmVnaW9uIik7CiAgICAgICAgIHAgPSBOVUxMOwpkaWZm
IC0tZ2l0IGEvdXRpbC90cmFjZS1ldmVudHMgYi91dGlsL3RyYWNlLWV2ZW50cwppbmRleCAwNzUz
ZTRhMGVkLi41MmQ0M2NkYTNmIDEwMDY0NAotLS0gYS91dGlsL3RyYWNlLWV2ZW50cworKysgYi91
dGlsL3RyYWNlLWV2ZW50cwpAQCAtODgsMyArODgsNCBAQCBxZW11X3ZmaW9fZG1hX3VubWFwKHZv
aWQgKnMsIHZvaWQgKmhvc3QpICJzICVwIGhvc3QgJXAiCiBxZW11X3ZmaW9fcGNpX3JlYWRfY29u
ZmlnKHZvaWQgKmJ1ZiwgaW50IG9mcywgaW50IHNpemUsIHVpbnQ2NF90IHJlZ2lvbl9vZnMsIHVp
bnQ2NF90IHJlZ2lvbl9zaXplKSAicmVhZCBjZmcgcHRyICVwIG9mcyAweCV4IHNpemUgMHgleCAo
cmVnaW9uIGFkZHIgMHglIlBSSXg2NCIgc2l6ZSAweCUiUFJJeDY0IikiCiBxZW11X3ZmaW9fcGNp
X3dyaXRlX2NvbmZpZyh2b2lkICpidWYsIGludCBvZnMsIGludCBzaXplLCB1aW50NjRfdCByZWdp
b25fb2ZzLCB1aW50NjRfdCByZWdpb25fc2l6ZSkgIndyaXRlIGNmZyBwdHIgJXAgb2ZzIDB4JXgg
c2l6ZSAweCV4IChyZWdpb24gYWRkciAweCUiUFJJeDY0IiBzaXplIDB4JSJQUkl4NjQiKSIKIHFl
bXVfdmZpb19yZWdpb25faW5mbyhjb25zdCBjaGFyICpkZXNjLCB1aW50NjRfdCByZWdpb25fb2Zz
LCB1aW50NjRfdCByZWdpb25fc2l6ZSwgdWludDMyX3QgY2FwX29mZnNldCkgInJlZ2lvbiAnJXMn
IGFkZHIgMHglIlBSSXg2NCIgc2l6ZSAweCUiUFJJeDY0IiBjYXBfb2ZzIDB4JSJQUkl4MzIKK3Fl
bXVfdmZpb19wY2lfbWFwX2JhcihpbnQgaW5kZXgsIHVpbnQ2NF90IHJlZ2lvbl9vZnMsIHVpbnQ2
NF90IHJlZ2lvbl9zaXplLCBpbnQgb2ZzLCB2b2lkICpob3N0KSAibWFwIHJlZ2lvbiBiYXIjJWQg
YWRkciAweCUiUFJJeDY0IiBzaXplIDB4JSJQUkl4NjQiIG9mcyAweCV4IGhvc3QgJXAiCi0tIAoy
LjI4LjAKCg==


