Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688CB20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjP0dcLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688CB20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5oLq-0005LE-Kq
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5oKM-0003sC-5v
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:49:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5oKK-0007AA-99
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597229387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Qda3Vaxb3fMagrWQzUSiYjYoPiqmFg223xBIY3hy7M=;
 b=YjP0dcLlJcz+3f5oZceFgk8130R7VeR4uDDhUQM+BuGlI8E/+5C++HRH0DF+gB1523koKa
 L09w/FsFxQPI+Oc38dnAMvnGDsnZ7YV5JN5RSyCecvoazss0LZVsRP66+nzHsxdBvRgzZ5
 PvEOuoqIt5YyBNvcNle2w6c0HBAjZYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-HbNKnpY8PzqngrTssJaHQA-1; Wed, 12 Aug 2020 06:49:44 -0400
X-MC-Unique: HbNKnpY8PzqngrTssJaHQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA6EA91276;
 Wed, 12 Aug 2020 10:49:42 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 680015D6BD;
 Wed, 12 Aug 2020 10:49:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] virtio-blk: undo destructive iov_discard_*() operations
Date: Wed, 12 Aug 2020 11:49:17 +0100
Message-Id: <20200812104918.107116-3-stefanha@redhat.com>
In-Reply-To: <20200812104918.107116-1-stefanha@redhat.com>
References: <20200812104918.107116-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnV6emluZyBkaXNjb3ZlcmVkIHRoYXQgdmlydHF1ZXVlX3VubWFwX3NnKCkgaXMgYmVpbmcgY2Fs
bGVkIG9uIG1vZGlmaWVkCnJlcS0+aW4vb3V0X3NnIGlvdmVjcy4gVGhpcyBtZWFucyBkbWFfbWVt
b3J5X21hcCgpIGFuZApkbWFfbWVtb3J5X3VubWFwKCkgY2FsbHMgZG8gbm90IGhhdmUgbWF0Y2hp
bmcgbWVtb3J5IGFkZHJlc3Nlcy4KCkZ1enppbmcgZGlzY292ZXJlZCB0aGF0IG5vbi1SQU0gYWRk
cmVzc2VzIHRyaWdnZXIgYSBidWc6CgogIHZvaWQgYWRkcmVzc19zcGFjZV91bm1hcChBZGRyZXNz
U3BhY2UgKmFzLCB2b2lkICpidWZmZXIsIGh3YWRkciBsZW4sCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb2wgaXNfd3JpdGUsIGh3YWRkciBhY2Nlc3NfbGVuKQogIHsKICAgICAgaWYgKGJ1
ZmZlciAhPSBib3VuY2UuYnVmZmVyKSB7CiAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5e
XgoKQSBtb2RpZmllZCBpb3YtPmlvdl9iYXNlIGlzIG5vIGxvbmdlciByZWNvZ25pemVkIGFzIGEg
Ym91bmNlIGJ1ZmZlciBhbmQKdGhlIHdyb25nIGJyYW5jaCBpcyB0YWtlbi4KClRoZXJlIGFyZSBt
b3JlIHBvdGVudGlhbCBidWdzOiBkaXJ0eSBtZW1vcnkgaXMgbm90IHRyYWNrZWQgY29ycmVjdGx5
IGFuZApNZW1vcnlSZWdpb24gcmVmY291bnRzIGNhbiBiZSBsZWFrZWQuCgpVc2UgdGhlIG5ldyBp
b3ZfZGlzY2FyZF91bmRvKCkgQVBJIHRvIHJlc3RvcmUgZWxlbS0+aW4vb3V0X3NnIGJlZm9yZQp2
aXJ0cXVldWVfcHVzaCgpIGlzIGNhbGxlZC4KClJlcG9ydGVkLWJ5OiBBbGV4YW5kZXIgQnVsZWtv
diA8YWx4bmRyQGJ1LmVkdT4KQnVnbGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVt
dS8rYnVnLzE4OTAzNjAKRml4ZXM6IDgyNzgwNWEyNDkyYzFiYmYxYzA3MTJlZDE4ZWUwNjliNGVi
ZjNkZDYgKCJ2aXJ0aW8tYmxrOiBDb252ZXJ0IFZpcnRJT0Jsb2NrUmVxLm91dCB0byBzdHJ1Y3Ry
dWUiKQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
Ci0tLQogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oIHwgMiArKwogaHcvYmxvY2svdmly
dGlvLWJsay5jICAgICAgICAgIHwgOSArKysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlv
L3ZpcnRpby1ibGsuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaAppbmRleCBiMTMz
NGMzOTA0Li4wYWY2NTRjYWNlIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8t
YmxrLmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oCkBAIC02OCw2ICs2OCw4
IEBAIHR5cGVkZWYgc3RydWN0IFZpcnRJT0Jsb2NrUmVxIHsKICAgICBpbnQ2NF90IHNlY3Rvcl9u
dW07CiAgICAgVmlydElPQmxvY2sgKmRldjsKICAgICBWaXJ0UXVldWUgKnZxOworICAgIElPVkRp
c2NhcmRVbmRvIGluaGRyX3VuZG87CisgICAgSU9WRGlzY2FyZFVuZG8gb3V0aGRyX3VuZG87CiAg
ICAgc3RydWN0IHZpcnRpb19ibGtfaW5oZHIgKmluOwogICAgIHN0cnVjdCB2aXJ0aW9fYmxrX291
dGhkciBvdXQ7CiAgICAgUUVNVUlPVmVjdG9yIHFpb3Y7CmRpZmYgLS1naXQgYS9ody9ibG9jay92
aXJ0aW8tYmxrLmMgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMKaW5kZXggNDEzNzgzNjkzYy4uMmI3
Y2MzZTFjOCAxMDA2NDQKLS0tIGEvaHcvYmxvY2svdmlydGlvLWJsay5jCisrKyBiL2h3L2Jsb2Nr
L3ZpcnRpby1ibGsuYwpAQCAtODAsNiArODAsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fYmxrX3Jl
cV9jb21wbGV0ZShWaXJ0SU9CbG9ja1JlcSAqcmVxLCB1bnNpZ25lZCBjaGFyIHN0YXR1cykKICAg
ICB0cmFjZV92aXJ0aW9fYmxrX3JlcV9jb21wbGV0ZSh2ZGV2LCByZXEsIHN0YXR1cyk7CiAKICAg
ICBzdGJfcCgmcmVxLT5pbi0+c3RhdHVzLCBzdGF0dXMpOworICAgIGlvdl9kaXNjYXJkX3VuZG8o
JnJlcS0+aW5oZHJfdW5kbyk7CisgICAgaW92X2Rpc2NhcmRfdW5kbygmcmVxLT5vdXRoZHJfdW5k
byk7CiAgICAgdmlydHF1ZXVlX3B1c2gocmVxLT52cSwgJnJlcS0+ZWxlbSwgcmVxLT5pbl9sZW4p
OwogICAgIGlmIChzLT5kYXRhcGxhbmVfc3RhcnRlZCAmJiAhcy0+ZGF0YXBsYW5lX2Rpc2FibGVk
KSB7CiAgICAgICAgIHZpcnRpb19ibGtfZGF0YV9wbGFuZV9ub3RpZnkocy0+ZGF0YXBsYW5lLCBy
ZXEtPnZxKTsKQEAgLTYzMiwxMCArNjM0LDEyIEBAIHN0YXRpYyBpbnQgdmlydGlvX2Jsa19oYW5k
bGVfcmVxdWVzdChWaXJ0SU9CbG9ja1JlcSAqcmVxLCBNdWx0aVJlcUJ1ZmZlciAqbXJiKQogICAg
ICAgICByZXR1cm4gLTE7CiAgICAgfQogCi0gICAgaW92X2Rpc2NhcmRfZnJvbnQoJm91dF9pb3Ys
ICZvdXRfbnVtLCBzaXplb2YocmVxLT5vdXQpKTsKKyAgICBpb3ZfZGlzY2FyZF9mcm9udF91bmRv
YWJsZSgmb3V0X2lvdiwgJm91dF9udW0sIHNpemVvZihyZXEtPm91dCksCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnJlcS0+b3V0aGRyX3VuZG8pOwogCiAgICAgaWYgKGluX2lvdltp
bl9udW0gLSAxXS5pb3ZfbGVuIDwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2luaGRyKSkgewog
ICAgICAgICB2aXJ0aW9fZXJyb3IodmRldiwgInZpcnRpby1ibGsgcmVxdWVzdCBpbmhkciB0b28g
c2hvcnQiKTsKKyAgICAgICAgaW92X2Rpc2NhcmRfdW5kbygmcmVxLT5vdXRoZHJfdW5kbyk7CiAg
ICAgICAgIHJldHVybiAtMTsKICAgICB9CiAKQEAgLTY0NCw3ICs2NDgsOCBAQCBzdGF0aWMgaW50
IHZpcnRpb19ibGtfaGFuZGxlX3JlcXVlc3QoVmlydElPQmxvY2tSZXEgKnJlcSwgTXVsdGlSZXFC
dWZmZXIgKm1yYikKICAgICByZXEtPmluID0gKHZvaWQgKilpbl9pb3ZbaW5fbnVtIC0gMV0uaW92
X2Jhc2UKICAgICAgICAgICAgICAgKyBpbl9pb3ZbaW5fbnVtIC0gMV0uaW92X2xlbgogICAgICAg
ICAgICAgICAtIHNpemVvZihzdHJ1Y3QgdmlydGlvX2Jsa19pbmhkcik7Ci0gICAgaW92X2Rpc2Nh
cmRfYmFjayhpbl9pb3YsICZpbl9udW0sIHNpemVvZihzdHJ1Y3QgdmlydGlvX2Jsa19pbmhkcikp
OworICAgIGlvdl9kaXNjYXJkX2JhY2tfdW5kb2FibGUoaW5faW92LCAmaW5fbnVtLCBzaXplb2Yo
c3RydWN0IHZpcnRpb19ibGtfaW5oZHIpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JnJlcS0+aW5oZHJfdW5kbyk7CiAKICAgICB0eXBlID0gdmlydGlvX2xkbF9wKHZkZXYsICZyZXEt
Pm91dC50eXBlKTsKIAotLSAKMi4yNi4yCgo=


