Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0044AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF3220732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijoNpIo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF3220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKvB-0004k3-AX
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbK-000861-6z
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbF-0008MP-Cj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSFT8eKoJ5cQvPnVenZnrvLMn9Hkughdr5Pbtm2yll8=;
 b=ijoNpIo9A16CqOzPCrbDn8Lt06Yy1pMxsKt9tUGWo0URk07HkxpFPC86SjIvvR/2iX/4bR
 WZ8KcgVO16lU1xxDbPZmUlGZqxrOAa+fPw/NxGzB6zgSJLmOjjpxR/3of1lJBg8YDJX39f
 /DF2XCNk9G8bPxLUoffcQY2lnBWy/JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-bkBbB6DNPnSSnH2ZIfDPwA-1; Wed, 04 Nov 2020 10:21:22 -0500
X-MC-Unique: bkBbB6DNPnSSnH2ZIfDPwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 601CC101F012;
 Wed,  4 Nov 2020 15:21:20 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE865C3E1;
 Wed,  4 Nov 2020 15:21:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/33] block/nvme: Fix use of write-only doorbells page on
 Aarch64 arch
Date: Wed,  4 Nov 2020 15:18:20 +0000
Message-Id: <20201104151828.405824-26-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKcWVtdV92
ZmlvX3BjaV9tYXBfYmFyKCkgY2FsbHMgbW1hcCgpLCBhbmQgbW1hcCgyKSBzdGF0ZXM6CgogICdv
ZmZzZXQnIG11c3QgYmUgYSBtdWx0aXBsZSBvZiB0aGUgcGFnZSBzaXplIGFzIHJldHVybmVkCiAg
IGJ5IHN5c2NvbmYoX1NDX1BBR0VfU0laRSkuCgpJbiBjb21taXQgZjY4NDUzMjM3Yjkgd2Ugc3Rh
cnRlZCB0byB1c2UgYW4gb2Zmc2V0IG9mIDRLIHdoaWNoCmJyb2tlIHRoaXMgY29udHJhY3Qgb24g
QWFyY2g2NCBhcmNoLgoKRml4IGJ5IG1hcHBpbmcgYXQgb2Zmc2V0IDAsIGFuZCBhbmQgYWNjZXNz
aW5nIGRvb3JiZWxscyBhdCBvZmZzZXQ9NEsuCgpGaXhlczogZjY4NDUzMjM3YjkgKCJibG9jay9u
dm1lOiBNYXAgZG9vcmJlbGxzIHBhZ2VzIHdyaXRlLW9ubHkiKQpSZXBvcnRlZC1ieTogRXJpYyBB
dWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQu
Y29tPgpNZXNzYWdlLWlkOiAyMDIwMTAyOTA5MzMwNi4xMDYzODc5LTI0LXBoaWxtZEByZWRoYXQu
Y29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
VGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ci0tLQogYmxvY2sv
bnZtZS5jIHwgMTEgKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5j
CmluZGV4IGYxZTJmZDM0Y2QuLmM4ZWY2OWNiYjIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYwor
KysgYi9ibG9jay9udm1lLmMKQEAgLTk0LDYgKzk0LDcgQEAgdHlwZWRlZiBzdHJ1Y3Qgewogc3Ry
dWN0IEJEUlZOVk1lU3RhdGUgewogICAgIEFpb0NvbnRleHQgKmFpb19jb250ZXh0OwogICAgIFFF
TVVWRklPU3RhdGUgKnZmaW87CisgICAgdm9pZCAqYmFyMF93b19tYXA7CiAgICAgLyogTWVtb3J5
IG1hcHBlZCByZWdpc3RlcnMgKi8KICAgICB2b2xhdGlsZSBzdHJ1Y3QgewogICAgICAgICB1aW50
MzJfdCBzcV90YWlsOwpAQCAtNzc3LDggKzc3OCwxMCBAQCBzdGF0aWMgaW50IG52bWVfaW5pdChC
bG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBpbnQgbmFtZXNwYWNlLAog
ICAgICAgICB9CiAgICAgfQogCi0gICAgcy0+ZG9vcmJlbGxzID0gcWVtdV92ZmlvX3BjaV9tYXBf
YmFyKHMtPnZmaW8sIDAsIHNpemVvZihOdm1lQmFyKSwKLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTlZNRV9ET09SQkVMTF9TSVpFLCBQUk9UX1dSSVRFLCBlcnJwKTsK
KyAgICBzLT5iYXIwX3dvX21hcCA9IHFlbXVfdmZpb19wY2lfbWFwX2JhcihzLT52ZmlvLCAwLCAw
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihOdm1l
QmFyKSArIE5WTUVfRE9PUkJFTExfU0laRSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBQUk9UX1dSSVRFLCBlcnJwKTsKKyAgICBzLT5kb29yYmVsbHMgPSAodm9p
ZCAqKSgodWludHB0cl90KXMtPmJhcjBfd29fbWFwICsgc2l6ZW9mKE52bWVCYXIpKTsKICAgICBp
ZiAoIXMtPmRvb3JiZWxscykgewogICAgICAgICByZXQgPSAtRUlOVkFMOwogICAgICAgICBnb3Rv
IG91dDsKQEAgLTkxMCw4ICs5MTMsOCBAQCBzdGF0aWMgdm9pZCBudm1lX2Nsb3NlKEJsb2NrRHJp
dmVyU3RhdGUgKmJzKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmlycV9ub3RpZmll
cltNU0lYX1NIQVJFRF9JUlFfSURYXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNl
LCBOVUxMLCBOVUxMKTsKICAgICBldmVudF9ub3RpZmllcl9jbGVhbnVwKCZzLT5pcnFfbm90aWZp
ZXJbTVNJWF9TSEFSRURfSVJRX0lEWF0pOwotICAgIHFlbXVfdmZpb19wY2lfdW5tYXBfYmFyKHMt
PnZmaW8sIDAsICh2b2lkICopcy0+ZG9vcmJlbGxzLAotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpemVvZihOdm1lQmFyKSwgTlZNRV9ET09SQkVMTF9TSVpFKTsKKyAgICBxZW11X3ZmaW9f
cGNpX3VubWFwX2JhcihzLT52ZmlvLCAwLCBzLT5iYXIwX3dvX21hcCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAwLCBzaXplb2YoTnZtZUJhcikgKyBOVk1FX0RPT1JCRUxMX1NJWkUpOwog
ICAgIHFlbXVfdmZpb19jbG9zZShzLT52ZmlvKTsKIAogICAgIGdfZnJlZShzLT5kZXZpY2UpOwot
LSAKMi4yOC4wCgo=


