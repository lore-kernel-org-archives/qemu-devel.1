Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27E7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DB4206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvZaJEAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DB4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Rc-0000pd-Bi
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7MW-0003mr-Hx
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7MT-0006Fi-4y
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ItynTUr+vos01ttRyGi2oG9MsldhdITgU0gRCI6s7U=;
 b=CvZaJEAc0HlE75Lx/E4A2PFflF51d7UJ+wsvWqcqb+24dYkKChAN0nWeDleWIsa+IZ7xas
 6RaVLK0WryvgBxZY0I3eRCaBDEnC8mwuYiFtJQyHEd51yEbOKO4v2jDuoz3Cx2cXwk4f3B
 i5BZhfUlznNIZPFtkAYgh+Hy5GuuZkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-QeMEuu4yOXuyAIxN8bVVbg-1; Wed, 23 Sep 2020 12:11:02 -0400
X-MC-Unique: QeMEuu4yOXuyAIxN8bVVbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB2F186DD30;
 Wed, 23 Sep 2020 16:11:01 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B06D7368B;
 Wed, 23 Sep 2020 16:10:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/13] virtio-blk: undo destructive iov_discard_*() operations
Date: Wed, 23 Sep 2020 17:10:23 +0100
Message-Id: <20200923161031.69474-6-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org
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
aXJ0cXVldWVfcHVzaCgpIGlzIGNhbGxlZC4KCkZpeGVzOiA4Mjc4MDVhMjQ5MmMxYmJmMWMwNzEy
ZWQxOGVlMDY5YjRlYmYzZGQ2ICgidmlydGlvLWJsazogQ29udmVydCBWaXJ0SU9CbG9ja1JlcS5v
dXQgdG8gc3RydWN0cnVlIikKUmVwb3J0ZWQtYnk6IEFsZXhhbmRlciBCdWxla292IDxhbHhuZHJA
YnUuZWR1PgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5j
b20+ClJldmlld2VkLWJ5OiBMaSBRaWFuZyA8bGlxM2VhQGdtYWlsLmNvbT4KQnVnbGluazogaHR0
cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8rYnVnLzE4OTAzNjAKTWVzc2FnZS1JZDogPDIw
MjAwOTE3MDk0NDU1LjgyMjM3OS0zLXN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9o
dy92aXJ0aW8vdmlydGlvLWJsay5oIHwgIDIgKysKIGh3L2Jsb2NrL3ZpcnRpby1ibGsuYyAgICAg
ICAgICB8IDExICsrKysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJs
ay5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oCmluZGV4IDU5NTNjZjg5NjEuLjIx
NGFiNzQ4MjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaAorKysg
Yi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYmxrLmgKQEAgLTcwLDYgKzcwLDggQEAgdHlwZWRl
ZiBzdHJ1Y3QgVmlydElPQmxvY2tSZXEgewogICAgIGludDY0X3Qgc2VjdG9yX251bTsKICAgICBW
aXJ0SU9CbG9jayAqZGV2OwogICAgIFZpcnRRdWV1ZSAqdnE7CisgICAgSU9WRGlzY2FyZFVuZG8g
aW5oZHJfdW5kbzsKKyAgICBJT1ZEaXNjYXJkVW5kbyBvdXRoZHJfdW5kbzsKICAgICBzdHJ1Y3Qg
dmlydGlvX2Jsa19pbmhkciAqaW47CiAgICAgc3RydWN0IHZpcnRpb19ibGtfb3V0aGRyIG91dDsK
ICAgICBRRU1VSU9WZWN0b3IgcWlvdjsKZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3ZpcnRpby1ibGsu
YyBiL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYwppbmRleCAyMjA0YmExNDllLi5iYWMyZDZmYTJiIDEw
MDY0NAotLS0gYS9ody9ibG9jay92aXJ0aW8tYmxrLmMKKysrIGIvaHcvYmxvY2svdmlydGlvLWJs
ay5jCkBAIC04MCw2ICs4MCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19ibGtfcmVxX2NvbXBsZXRl
KFZpcnRJT0Jsb2NrUmVxICpyZXEsIHVuc2lnbmVkIGNoYXIgc3RhdHVzKQogICAgIHRyYWNlX3Zp
cnRpb19ibGtfcmVxX2NvbXBsZXRlKHZkZXYsIHJlcSwgc3RhdHVzKTsKIAogICAgIHN0Yl9wKCZy
ZXEtPmluLT5zdGF0dXMsIHN0YXR1cyk7CisgICAgaW92X2Rpc2NhcmRfdW5kbygmcmVxLT5pbmhk
cl91bmRvKTsKKyAgICBpb3ZfZGlzY2FyZF91bmRvKCZyZXEtPm91dGhkcl91bmRvKTsKICAgICB2
aXJ0cXVldWVfcHVzaChyZXEtPnZxLCAmcmVxLT5lbGVtLCByZXEtPmluX2xlbik7CiAgICAgaWYg
KHMtPmRhdGFwbGFuZV9zdGFydGVkICYmICFzLT5kYXRhcGxhbmVfZGlzYWJsZWQpIHsKICAgICAg
ICAgdmlydGlvX2Jsa19kYXRhX3BsYW5lX25vdGlmeShzLT5kYXRhcGxhbmUsIHJlcS0+dnEpOwpA
QCAtNjMyLDEwICs2MzQsMTIgQEAgc3RhdGljIGludCB2aXJ0aW9fYmxrX2hhbmRsZV9yZXF1ZXN0
KFZpcnRJT0Jsb2NrUmVxICpyZXEsIE11bHRpUmVxQnVmZmVyICptcmIpCiAgICAgICAgIHJldHVy
biAtMTsKICAgICB9CiAKLSAgICBpb3ZfZGlzY2FyZF9mcm9udCgmb3V0X2lvdiwgJm91dF9udW0s
IHNpemVvZihyZXEtPm91dCkpOworICAgIGlvdl9kaXNjYXJkX2Zyb250X3VuZG9hYmxlKCZvdXRf
aW92LCAmb3V0X251bSwgc2l6ZW9mKHJlcS0+b3V0KSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmcmVxLT5vdXRoZHJfdW5kbyk7CiAKICAgICBpZiAoaW5faW92W2luX251bSAtIDFd
Lmlvdl9sZW4gPCBzaXplb2Yoc3RydWN0IHZpcnRpb19ibGtfaW5oZHIpKSB7CiAgICAgICAgIHZp
cnRpb19lcnJvcih2ZGV2LCAidmlydGlvLWJsayByZXF1ZXN0IGluaGRyIHRvbyBzaG9ydCIpOwor
ICAgICAgICBpb3ZfZGlzY2FyZF91bmRvKCZyZXEtPm91dGhkcl91bmRvKTsKICAgICAgICAgcmV0
dXJuIC0xOwogICAgIH0KIApAQCAtNjQ0LDcgKzY0OCw4IEBAIHN0YXRpYyBpbnQgdmlydGlvX2Js
a19oYW5kbGVfcmVxdWVzdChWaXJ0SU9CbG9ja1JlcSAqcmVxLCBNdWx0aVJlcUJ1ZmZlciAqbXJi
KQogICAgIHJlcS0+aW4gPSAodm9pZCAqKWluX2lvdltpbl9udW0gLSAxXS5pb3ZfYmFzZQogICAg
ICAgICAgICAgICArIGluX2lvdltpbl9udW0gLSAxXS5pb3ZfbGVuCiAgICAgICAgICAgICAgIC0g
c2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2luaGRyKTsKLSAgICBpb3ZfZGlzY2FyZF9iYWNrKGlu
X2lvdiwgJmluX251bSwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2luaGRyKSk7CisgICAgaW92
X2Rpc2NhcmRfYmFja191bmRvYWJsZShpbl9pb3YsICZpbl9udW0sIHNpemVvZihzdHJ1Y3Qgdmly
dGlvX2Jsa19pbmhkciksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmVxLT5pbmhk
cl91bmRvKTsKIAogICAgIHR5cGUgPSB2aXJ0aW9fbGRsX3AodmRldiwgJnJlcS0+b3V0LnR5cGUp
OwogCkBAIC03MzksNiArNzQ0LDggQEAgc3RhdGljIGludCB2aXJ0aW9fYmxrX2hhbmRsZV9yZXF1
ZXN0KFZpcnRJT0Jsb2NrUmVxICpyZXEsIE11bHRpUmVxQnVmZmVyICptcmIpCiAKICAgICAgICAg
aWYgKHVubGlrZWx5KGlvdl90b19idWYob3V0X2lvdiwgb3V0X251bSwgMCwgJmR3el9oZHIsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihkd3pfaGRyKSkgIT0gc2l6ZW9m
KGR3el9oZHIpKSkgeworICAgICAgICAgICAgaW92X2Rpc2NhcmRfdW5kbygmcmVxLT5pbmhkcl91
bmRvKTsKKyAgICAgICAgICAgIGlvdl9kaXNjYXJkX3VuZG8oJnJlcS0+b3V0aGRyX3VuZG8pOwog
ICAgICAgICAgICAgdmlydGlvX2Vycm9yKHZkZXYsICJ2aXJ0aW8tYmxrIGRpc2NhcmQvd3JpdGVf
emVyb2VzIGhlYWRlciIKICAgICAgICAgICAgICAgICAgICAgICAgICAiIHRvbyBzaG9ydCIpOwog
ICAgICAgICAgICAgcmV0dXJuIC0xOwotLSAKMi4yNi4yCgo=


