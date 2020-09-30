Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C27C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA7020719
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOX4Nz0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA7020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZFm-0006um-BB
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ89-0004cB-9d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ87-00068Y-KX
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:14:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5QARRmCXxm1BipHqnlxMxzhlAY+C26xXKhU5QRMwDk=;
 b=GOX4Nz0GaQ38XVyCgvzx1mKG2HfRsh4ZjxcXzGn40ddeKTTpQZCEN8s9cEG9d80QZpMNkF
 STGei19Egjx3r03bE4gSjtHzD8Z0gZi498LKsZyUOfm6cceClD1bOVQkQznXT0E9w3oDLB
 6UZ7R5sNA2P6fb+KnaWS3lYlyiS7NDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-h-QsvQPUPqyR3QvTACwUnw-1; Wed, 30 Sep 2020 06:14:30 -0400
X-MC-Unique: h-QsvQPUPqyR3QvTACwUnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 621571091078;
 Wed, 30 Sep 2020 10:14:29 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20AD31001281;
 Wed, 30 Sep 2020 10:14:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 17/17] util/vfio-helpers: Rework the IOVA allocator to avoid
 IOVA reserved regions
Date: Wed, 30 Sep 2020 11:13:05 +0100
Message-Id: <20200930101305.305302-18-stefanha@redhat.com>
In-Reply-To: <20200930101305.305302-1-stefanha@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgoKSW50cm9kdWNlIHRoZSBx
ZW11X3ZmaW9fZmluZF9maXhlZC90ZW1wX2lvdmEgaGVscGVycyB3aGljaApyZXNwZWN0aXZlbHkg
YWxsb2NhdGUgSU9WQXMgZnJvbSB0aGUgYm90dG9tL3RvcCBwYXJ0cyBvZiB0aGUKdXNhYmxlIElP
VkEgcmFuZ2UsIHdpdGhvdXQgcGlja2luZyB3aXRoaW4gaG9zdCBJT1ZBIHJlc2VydmVkCndpbmRv
d3MuIFRoZSBhbGxvY2F0aW9uIHJlbWFpbnMgYmFzaWM6IGlmIHRoZSBzaXplIGlzIHRvbyBiaWcK
Zm9yIHRoZSByZW1haW5pbmcgb2YgdGhlIGN1cnJlbnQgdXNhYmxlIElPVkEgcmFuZ2UsIHdlIGp1
bXAKdG8gdGhlIG5leHQgb25lLCBsZWF2aW5nIGEgaG9sZSBpbiB0aGUgYWRkcmVzcyBtYXAuCgpT
aWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ck1lc3NhZ2Ut
aWQ6IDIwMjAwOTI5MDg1NTUwLjMwOTI2LTMtZXJpYy5hdWdlckByZWRoYXQuY29tClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL3Zm
aW8taGVscGVycy5jIHwgNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS91dGlsL3ZmaW8taGVscGVycy5jIGIvdXRpbC92ZmlvLWhlbHBlcnMuYwpp
bmRleCBmZTljYTljZTM4Li5jNDY5YmViMDYxIDEwMDY0NAotLS0gYS91dGlsL3ZmaW8taGVscGVy
cy5jCisrKyBiL3V0aWwvdmZpby1oZWxwZXJzLmMKQEAgLTY2Nyw2ICs2NjcsNTAgQEAgc3RhdGlj
IGJvb2wgcWVtdV92ZmlvX3ZlcmlmeV9tYXBwaW5ncyhRRU1VVkZJT1N0YXRlICpzKQogICAgIHJl
dHVybiB0cnVlOwogfQogCitzdGF0aWMgaW50CitxZW11X3ZmaW9fZmluZF9maXhlZF9pb3ZhKFFF
TVVWRklPU3RhdGUgKnMsIHNpemVfdCBzaXplLCB1aW50NjRfdCAqaW92YSkKK3sKKyAgICBpbnQg
aTsKKworICAgIGZvciAoaSA9IDA7IGkgPCBzLT5uYl9pb3ZhX3JhbmdlczsgaSsrKSB7CisgICAg
ICAgIGlmIChzLT51c2FibGVfaW92YV9yYW5nZXNbaV0uZW5kIDwgcy0+bG93X3dhdGVyX21hcmsp
IHsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICB9CisgICAgICAgIHMtPmxvd193YXRl
cl9tYXJrID0KKyAgICAgICAgICAgIE1BWChzLT5sb3dfd2F0ZXJfbWFyaywgcy0+dXNhYmxlX2lv
dmFfcmFuZ2VzW2ldLnN0YXJ0KTsKKworICAgICAgICBpZiAocy0+dXNhYmxlX2lvdmFfcmFuZ2Vz
W2ldLmVuZCAtIHMtPmxvd193YXRlcl9tYXJrICsgMSA+PSBzaXplIHx8CisgICAgICAgICAgICBz
LT51c2FibGVfaW92YV9yYW5nZXNbaV0uZW5kIC0gcy0+bG93X3dhdGVyX21hcmsgKyAxID09IDAp
IHsKKyAgICAgICAgICAgICppb3ZhID0gcy0+bG93X3dhdGVyX21hcms7CisgICAgICAgICAgICBz
LT5sb3dfd2F0ZXJfbWFyayArPSBzaXplOworICAgICAgICAgICAgcmV0dXJuIDA7CisgICAgICAg
IH0KKyAgICB9CisgICAgcmV0dXJuIC1FTk9NRU07Cit9CisKK3N0YXRpYyBpbnQKK3FlbXVfdmZp
b19maW5kX3RlbXBfaW92YShRRU1VVkZJT1N0YXRlICpzLCBzaXplX3Qgc2l6ZSwgdWludDY0X3Qg
KmlvdmEpCit7CisgICAgaW50IGk7CisKKyAgICBmb3IgKGkgPSBzLT5uYl9pb3ZhX3JhbmdlcyAt
IDE7IGkgPj0gMDsgaS0tKSB7CisgICAgICAgIGlmIChzLT51c2FibGVfaW92YV9yYW5nZXNbaV0u
c3RhcnQgPiBzLT5oaWdoX3dhdGVyX21hcmspIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAg
ICAgICB9CisgICAgICAgIHMtPmhpZ2hfd2F0ZXJfbWFyayA9CisgICAgICAgICAgICBNSU4ocy0+
aGlnaF93YXRlcl9tYXJrLCBzLT51c2FibGVfaW92YV9yYW5nZXNbaV0uZW5kICsgMSk7CisKKyAg
ICAgICAgaWYgKHMtPmhpZ2hfd2F0ZXJfbWFyayAtIHMtPnVzYWJsZV9pb3ZhX3Jhbmdlc1tpXS5z
dGFydCArIDEgPj0gc2l6ZSB8fAorICAgICAgICAgICAgcy0+aGlnaF93YXRlcl9tYXJrIC0gcy0+
dXNhYmxlX2lvdmFfcmFuZ2VzW2ldLnN0YXJ0ICsgMSA9PSAwKSB7CisgICAgICAgICAgICAqaW92
YSA9IHMtPmhpZ2hfd2F0ZXJfbWFyayAtIHNpemU7CisgICAgICAgICAgICBzLT5oaWdoX3dhdGVy
X21hcmsgPSAqaW92YTsKKyAgICAgICAgICAgIHJldHVybiAwOworICAgICAgICB9CisgICAgfQor
ICAgIHJldHVybiAtRU5PTUVNOworfQorCiAvKiBNYXAgW2hvc3QsIGhvc3QgKyBzaXplKSBhcmVh
IGludG8gYSBjb250aWd1b3VzIElPVkEgYWRkcmVzcyBzcGFjZSwgYW5kIHN0b3JlCiAgKiB0aGUg
cmVzdWx0IGluIEBpb3ZhIGlmIG5vdCBOVUxMLiBUaGUgY2FsbGVyIG5lZWQgdG8gbWFrZSBzdXJl
IHRoZSBhcmVhIGlzCiAgKiBhbGlnbmVkIHRvIHBhZ2Ugc2l6ZSwgYW5kIG11c3RuJ3Qgb3Zlcmxh
cCB3aXRoIGV4aXN0aW5nIG1hcHBpbmcgYXJlYXMgKHNwbGl0CkBAIC02OTMsNyArNzM3LDExIEBA
IGludCBxZW11X3ZmaW9fZG1hX21hcChRRU1VVkZJT1N0YXRlICpzLCB2b2lkICpob3N0LCBzaXpl
X3Qgc2l6ZSwKICAgICAgICAgICAgIGdvdG8gb3V0OwogICAgICAgICB9CiAgICAgICAgIGlmICgh
dGVtcG9yYXJ5KSB7Ci0gICAgICAgICAgICBpb3ZhMCA9IHMtPmxvd193YXRlcl9tYXJrOworICAg
ICAgICAgICAgaWYgKHFlbXVfdmZpb19maW5kX2ZpeGVkX2lvdmEocywgc2l6ZSwgJmlvdmEwKSkg
eworICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07CisgICAgICAgICAgICAgICAgZ290byBv
dXQ7CisgICAgICAgICAgICB9CisKICAgICAgICAgICAgIG1hcHBpbmcgPSBxZW11X3ZmaW9fYWRk
X21hcHBpbmcocywgaG9zdCwgc2l6ZSwgaW5kZXggKyAxLCBpb3ZhMCk7CiAgICAgICAgICAgICBp
ZiAoIW1hcHBpbmcpIHsKICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOwpAQCAtNzA1LDE1
ICs3NTMsMTYgQEAgaW50IHFlbXVfdmZpb19kbWFfbWFwKFFFTVVWRklPU3RhdGUgKnMsIHZvaWQg
Kmhvc3QsIHNpemVfdCBzaXplLAogICAgICAgICAgICAgICAgIHFlbXVfdmZpb191bmRvX21hcHBp
bmcocywgbWFwcGluZywgTlVMTCk7CiAgICAgICAgICAgICAgICAgZ290byBvdXQ7CiAgICAgICAg
ICAgICB9Ci0gICAgICAgICAgICBzLT5sb3dfd2F0ZXJfbWFyayArPSBzaXplOwogICAgICAgICAg
ICAgcWVtdV92ZmlvX2R1bXBfbWFwcGluZ3Mocyk7CiAgICAgICAgIH0gZWxzZSB7Ci0gICAgICAg
ICAgICBpb3ZhMCA9IHMtPmhpZ2hfd2F0ZXJfbWFyayAtIHNpemU7CisgICAgICAgICAgICBpZiAo
cWVtdV92ZmlvX2ZpbmRfdGVtcF9pb3ZhKHMsIHNpemUsICZpb3ZhMCkpIHsKKyAgICAgICAgICAg
ICAgICByZXQgPSAtRU5PTUVNOworICAgICAgICAgICAgICAgIGdvdG8gb3V0OworICAgICAgICAg
ICAgfQogICAgICAgICAgICAgcmV0ID0gcWVtdV92ZmlvX2RvX21hcHBpbmcocywgaG9zdCwgc2l6
ZSwgaW92YTApOwogICAgICAgICAgICAgaWYgKHJldCkgewogICAgICAgICAgICAgICAgIGdvdG8g
b3V0OwogICAgICAgICAgICAgfQotICAgICAgICAgICAgcy0+aGlnaF93YXRlcl9tYXJrIC09IHNp
emU7CiAgICAgICAgIH0KICAgICB9CiAgICAgaWYgKGlvdmEpIHsKLS0gCjIuMjYuMgoK


