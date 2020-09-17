Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE054C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DAC20770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWvCw6PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAC20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqVn-00020V-4v
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqTr-0000aq-5L
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqTn-0008WK-Hl
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600335926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE6Ac8pBnUa/ZYBkVcJrlTvMckV1JEQyDqyHau2eeWE=;
 b=hWvCw6PUWmyzhiHt8ZvZyUJowEPmCovgumgxYZUxWGRYP8AJDaEr8hAhqhfk/GAI/ZlhTz
 Gl3SLbPOTM1PtX0yIoNAvmo13xTM2dqelEAtK1CJPt7V+TCmhn4T5+kiD3BYEOGdWGDK1R
 +BitIjyNQwRzNokufYyuPy8UAvzRxLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-wYtZVFgMNu-POgv5y-cylA-1; Thu, 17 Sep 2020 05:45:20 -0400
X-MC-Unique: wYtZVFgMNu-POgv5y-cylA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B53D101872D;
 Thu, 17 Sep 2020 09:45:19 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDF0371775;
 Thu, 17 Sep 2020 09:45:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] virtio-blk: undo destructive iov_discard_*() operations
Date: Thu, 17 Sep 2020 10:44:54 +0100
Message-Id: <20200917094455.822379-3-stefanha@redhat.com>
In-Reply-To: <20200917094455.822379-1-stefanha@redhat.com>
References: <20200917094455.822379-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Ci0tLQogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oIHwgIDIgKysKIGh3L2Jsb2NrL3Zp
cnRpby1ibGsuYyAgICAgICAgICB8IDExICsrKysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92
aXJ0aW8vdmlydGlvLWJsay5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oCmluZGV4
IDI5YzlmMzIzNTMuLmRmMzg3NmQ0OWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zp
cnRpby1ibGsuaAorKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYmxrLmgKQEAgLTcyLDYg
KzcyLDggQEAgdHlwZWRlZiBzdHJ1Y3QgVmlydElPQmxvY2tSZXEgewogICAgIGludDY0X3Qgc2Vj
dG9yX251bTsKICAgICBWaXJ0SU9CbG9jayAqZGV2OwogICAgIFZpcnRRdWV1ZSAqdnE7CisgICAg
SU9WRGlzY2FyZFVuZG8gaW5oZHJfdW5kbzsKKyAgICBJT1ZEaXNjYXJkVW5kbyBvdXRoZHJfdW5k
bzsKICAgICBzdHJ1Y3QgdmlydGlvX2Jsa19pbmhkciAqaW47CiAgICAgc3RydWN0IHZpcnRpb19i
bGtfb3V0aGRyIG91dDsKICAgICBRRU1VSU9WZWN0b3IgcWlvdjsKZGlmZiAtLWdpdCBhL2h3L2Js
b2NrL3ZpcnRpby1ibGsuYyBiL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYwppbmRleCAyMjA0YmExNDll
Li5iYWMyZDZmYTJiIDEwMDY0NAotLS0gYS9ody9ibG9jay92aXJ0aW8tYmxrLmMKKysrIGIvaHcv
YmxvY2svdmlydGlvLWJsay5jCkBAIC04MCw2ICs4MCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19i
bGtfcmVxX2NvbXBsZXRlKFZpcnRJT0Jsb2NrUmVxICpyZXEsIHVuc2lnbmVkIGNoYXIgc3RhdHVz
KQogICAgIHRyYWNlX3ZpcnRpb19ibGtfcmVxX2NvbXBsZXRlKHZkZXYsIHJlcSwgc3RhdHVzKTsK
IAogICAgIHN0Yl9wKCZyZXEtPmluLT5zdGF0dXMsIHN0YXR1cyk7CisgICAgaW92X2Rpc2NhcmRf
dW5kbygmcmVxLT5pbmhkcl91bmRvKTsKKyAgICBpb3ZfZGlzY2FyZF91bmRvKCZyZXEtPm91dGhk
cl91bmRvKTsKICAgICB2aXJ0cXVldWVfcHVzaChyZXEtPnZxLCAmcmVxLT5lbGVtLCByZXEtPmlu
X2xlbik7CiAgICAgaWYgKHMtPmRhdGFwbGFuZV9zdGFydGVkICYmICFzLT5kYXRhcGxhbmVfZGlz
YWJsZWQpIHsKICAgICAgICAgdmlydGlvX2Jsa19kYXRhX3BsYW5lX25vdGlmeShzLT5kYXRhcGxh
bmUsIHJlcS0+dnEpOwpAQCAtNjMyLDEwICs2MzQsMTIgQEAgc3RhdGljIGludCB2aXJ0aW9fYmxr
X2hhbmRsZV9yZXF1ZXN0KFZpcnRJT0Jsb2NrUmVxICpyZXEsIE11bHRpUmVxQnVmZmVyICptcmIp
CiAgICAgICAgIHJldHVybiAtMTsKICAgICB9CiAKLSAgICBpb3ZfZGlzY2FyZF9mcm9udCgmb3V0
X2lvdiwgJm91dF9udW0sIHNpemVvZihyZXEtPm91dCkpOworICAgIGlvdl9kaXNjYXJkX2Zyb250
X3VuZG9hYmxlKCZvdXRfaW92LCAmb3V0X251bSwgc2l6ZW9mKHJlcS0+b3V0KSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmcmVxLT5vdXRoZHJfdW5kbyk7CiAKICAgICBpZiAoaW5f
aW92W2luX251bSAtIDFdLmlvdl9sZW4gPCBzaXplb2Yoc3RydWN0IHZpcnRpb19ibGtfaW5oZHIp
KSB7CiAgICAgICAgIHZpcnRpb19lcnJvcih2ZGV2LCAidmlydGlvLWJsayByZXF1ZXN0IGluaGRy
IHRvbyBzaG9ydCIpOworICAgICAgICBpb3ZfZGlzY2FyZF91bmRvKCZyZXEtPm91dGhkcl91bmRv
KTsKICAgICAgICAgcmV0dXJuIC0xOwogICAgIH0KIApAQCAtNjQ0LDcgKzY0OCw4IEBAIHN0YXRp
YyBpbnQgdmlydGlvX2Jsa19oYW5kbGVfcmVxdWVzdChWaXJ0SU9CbG9ja1JlcSAqcmVxLCBNdWx0
aVJlcUJ1ZmZlciAqbXJiKQogICAgIHJlcS0+aW4gPSAodm9pZCAqKWluX2lvdltpbl9udW0gLSAx
XS5pb3ZfYmFzZQogICAgICAgICAgICAgICArIGluX2lvdltpbl9udW0gLSAxXS5pb3ZfbGVuCiAg
ICAgICAgICAgICAgIC0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2luaGRyKTsKLSAgICBpb3Zf
ZGlzY2FyZF9iYWNrKGluX2lvdiwgJmluX251bSwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2lu
aGRyKSk7CisgICAgaW92X2Rpc2NhcmRfYmFja191bmRvYWJsZShpbl9pb3YsICZpbl9udW0sIHNp
emVvZihzdHJ1Y3QgdmlydGlvX2Jsa19pbmhkciksCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmcmVxLT5pbmhkcl91bmRvKTsKIAogICAgIHR5cGUgPSB2aXJ0aW9fbGRsX3AodmRldiwg
JnJlcS0+b3V0LnR5cGUpOwogCkBAIC03MzksNiArNzQ0LDggQEAgc3RhdGljIGludCB2aXJ0aW9f
YmxrX2hhbmRsZV9yZXF1ZXN0KFZpcnRJT0Jsb2NrUmVxICpyZXEsIE11bHRpUmVxQnVmZmVyICpt
cmIpCiAKICAgICAgICAgaWYgKHVubGlrZWx5KGlvdl90b19idWYob3V0X2lvdiwgb3V0X251bSwg
MCwgJmR3el9oZHIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihkd3pf
aGRyKSkgIT0gc2l6ZW9mKGR3el9oZHIpKSkgeworICAgICAgICAgICAgaW92X2Rpc2NhcmRfdW5k
bygmcmVxLT5pbmhkcl91bmRvKTsKKyAgICAgICAgICAgIGlvdl9kaXNjYXJkX3VuZG8oJnJlcS0+
b3V0aGRyX3VuZG8pOwogICAgICAgICAgICAgdmlydGlvX2Vycm9yKHZkZXYsICJ2aXJ0aW8tYmxr
IGRpc2NhcmQvd3JpdGVfemVyb2VzIGhlYWRlciIKICAgICAgICAgICAgICAgICAgICAgICAgICAi
IHRvbyBzaG9ydCIpOwogICAgICAgICAgICAgcmV0dXJuIC0xOwotLSAKMi4yNi4yCgo=


