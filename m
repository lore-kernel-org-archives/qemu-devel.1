Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E21C83002
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C33225A9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnjv9rkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C33225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyUg-0006aq-Ki
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCK-0001uz-AS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCI-0002zn-6G
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+LTzTUIb2928C1uSf4ZQhp/G7K/O8pDRPsM875ErhY=;
 b=Vnjv9rkHOYQ0DGO4ToMkJR/VexMCQBD6et4cnVnp09kfg3oikIO5Znr8WCXaot5PCJpkgx
 9ktSvpyYGhsLENElXTlt39uH8Ex0HyBFroFBOumoujfZyehNeTY5vhh8537Maea3wXF2g/
 P6jRHNKUJTTK2BWl0/EGL0gFoSp6qO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-yZMAddtWMWmXaOOy1GgsGw-1; Fri, 09 Oct 2020 15:36:55 -0400
X-MC-Unique: yZMAddtWMWmXaOOy1GgsGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B9157039;
 Fri,  9 Oct 2020 19:36:54 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4667EEB4;
 Fri,  9 Oct 2020 19:36:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 14/30] util/vhost-user-server: fix memory leak in
 vu_message_read()
Date: Fri,  9 Oct 2020 20:35:13 +0100
Message-Id: <20201009193529.322822-15-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZmRzW10gaXMgbGVha2VkIHdoZW4gcWlvX2NoYW5uZWxfcmVhZHZfZnVsbCgpIGZhaWxzLgoKVXNl
IHZtc2ctPmZkc1tdIGluc3RlYWQgb2Yga2VlcGluZyBhIGxvY2FsIGZkc1tdIGFycmF5LiBUaGVu
IHdlIGNhbgpyZXVzZSBnb3RvIGZhaWwgdG8gY2xlYW4gdXAgZmRzLiB2bXNnLT5mZF9udW0gbXVz
dCBiZSB6ZXJvZWQgYmVmb3JlIHRoZQpsb29wIHRvIG1ha2UgdGhpcyBzYWZlLgoKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAy
MDIwMDkyNDE1MTU0OS45MTM3MzctOC1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL3Zob3N0LXVz
ZXItc2VydmVyLmMgfCA1MCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jIGIvdXRpbC92aG9zdC11c2VyLXNlcnZl
ci5jCmluZGV4IDg5MjgxNTgyN2QuLjVhNjBlMmNhMmEgMTAwNjQ0Ci0tLSBhL3V0aWwvdmhvc3Qt
dXNlci1zZXJ2ZXIuYworKysgYi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKQEAgLTEwMCwyMSAr
MTAwLDExIEBAIHZ1X21lc3NhZ2VfcmVhZChWdURldiAqdnVfZGV2LCBpbnQgY29ubl9mZCwgVmhv
c3RVc2VyTXNnICp2bXNnKQogICAgIH07CiAgICAgaW50IHJjLCByZWFkX2J5dGVzID0gMDsKICAg
ICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsKLSAgICAvKgotICAgICAqIFN0b3JlIGZkcy9uZmRz
IHJldHVybmVkIGZyb20gcWlvX2NoYW5uZWxfcmVhZHZfZnVsbCBpbnRvCi0gICAgICogdGVtcG9y
YXJ5IHZhcmlhYmxlcy4KLSAgICAgKgotICAgICAqIFZob3N0VXNlck1zZyBpcyBhIHBhY2tlZCBz
dHJ1Y3R1cmUsIGdjYyB3aWxsIGNvbXBsYWluIGFib3V0IHBhc3NpbmcKLSAgICAgKiBwb2ludGVy
IHRvIGEgcGFja2VkIHN0cnVjdHVyZSBtZW1iZXIgaWYgd2UgcGFzcyAmVmhvc3RVc2VyTXNnLmZk
X251bQotICAgICAqIGFuZCAmVmhvc3RVc2VyTXNnLmZkcyBkaXJlY3RseSB3aGVuIGNhbGxpbmcg
cWlvX2NoYW5uZWxfcmVhZHZfZnVsbCwKLSAgICAgKiB0aHVzIHR3byB0ZW1wb3JhcnkgdmFyaWFi
bGVzIG5mZHMgYW5kIGZkcyBhcmUgdXNlZCBoZXJlLgotICAgICAqLwotICAgIHNpemVfdCBuZmRz
ID0gMCwgbmZkc190ID0gMDsKICAgICBjb25zdCBzaXplX3QgbWF4X2ZkcyA9IEdfTl9FTEVNRU5U
Uyh2bXNnLT5mZHMpOwotICAgIGludCAqZmRzX3QgPSBOVUxMOwogICAgIFZ1U2VydmVyICpzZXJ2
ZXIgPSBjb250YWluZXJfb2YodnVfZGV2LCBWdVNlcnZlciwgdnVfZGV2KTsKICAgICBRSU9DaGFu
bmVsICppb2MgPSBzZXJ2ZXItPmlvYzsKIAorICAgIHZtc2ctPmZkX251bSA9IDA7CiAgICAgaWYg
KCFpb2MpIHsKICAgICAgICAgZXJyb3JfcmVwb3J0X2Vycihsb2NhbF9lcnIpOwogICAgICAgICBn
b3RvIGZhaWw7CkBAIC0xMjIsNDEgKzExMiw0NyBAQCB2dV9tZXNzYWdlX3JlYWQoVnVEZXYgKnZ1
X2RldiwgaW50IGNvbm5fZmQsIFZob3N0VXNlck1zZyAqdm1zZykKIAogICAgIGFzc2VydChxZW11
X2luX2Nvcm91dGluZSgpKTsKICAgICBkbyB7CisgICAgICAgIHNpemVfdCBuZmRzID0gMDsKKyAg
ICAgICAgaW50ICpmZHMgPSBOVUxMOworCiAgICAgICAgIC8qCiAgICAgICAgICAqIHFpb19jaGFu
bmVsX3JlYWR2X2Z1bGwgbWF5IGhhdmUgc2hvcnQgcmVhZHMsIGtlZXBpbmcgY2FsbGluZyBpdAog
ICAgICAgICAgKiB1bnRpbCBnZXR0aW5nIFZIT1NUX1VTRVJfSERSX1NJWkUgb3IgMCBieXRlcyBp
biB0b3RhbAogICAgICAgICAgKi8KLSAgICAgICAgcmMgPSBxaW9fY2hhbm5lbF9yZWFkdl9mdWxs
KGlvYywgJmlvdiwgMSwgJmZkc190LCAmbmZkc190LCAmbG9jYWxfZXJyKTsKKyAgICAgICAgcmMg
PSBxaW9fY2hhbm5lbF9yZWFkdl9mdWxsKGlvYywgJmlvdiwgMSwgJmZkcywgJm5mZHMsICZsb2Nh
bF9lcnIpOwogICAgICAgICBpZiAocmMgPCAwKSB7CiAgICAgICAgICAgICBpZiAocmMgPT0gUUlP
X0NIQU5ORUxfRVJSX0JMT0NLKSB7CisgICAgICAgICAgICAgICAgYXNzZXJ0KGxvY2FsX2VyciA9
PSBOVUxMKTsKICAgICAgICAgICAgICAgICBxaW9fY2hhbm5lbF95aWVsZChpb2MsIEdfSU9fSU4p
OwogICAgICAgICAgICAgICAgIGNvbnRpbnVlOwogICAgICAgICAgICAgfSBlbHNlIHsKICAgICAg
ICAgICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vycik7Ci0gICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOworICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsKICAgICAgICAgICAgIH0K
ICAgICAgICAgfQotICAgICAgICByZWFkX2J5dGVzICs9IHJjOwotICAgICAgICBpZiAobmZkc190
ID4gMCkgewotICAgICAgICAgICAgaWYgKG5mZHMgKyBuZmRzX3QgPiBtYXhfZmRzKSB7CisKKyAg
ICAgICAgaWYgKG5mZHMgPiAwKSB7CisgICAgICAgICAgICBpZiAodm1zZy0+ZmRfbnVtICsgbmZk
cyA+IG1heF9mZHMpIHsKICAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkEgbWF4aW11bSBv
ZiAlenUgZmRzIGFyZSBhbGxvd2VkLCAiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJo
b3dldmVyIGdvdCAlbHUgZmRzIG5vdyIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1h
eF9mZHMsIG5mZHMgKyBuZmRzX3QpOworICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXhf
ZmRzLCB2bXNnLT5mZF9udW0gKyBuZmRzKTsKKyAgICAgICAgICAgICAgICBnX2ZyZWUoZmRzKTsK
ICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7CiAgICAgICAgICAgICB9Ci0gICAgICAgICAgICBt
ZW1jcHkodm1zZy0+ZmRzICsgbmZkcywgZmRzX3QsCi0gICAgICAgICAgICAgICAgICAgbmZkc190
ICpzaXplb2Yodm1zZy0+ZmRzWzBdKSk7Ci0gICAgICAgICAgICBuZmRzICs9IG5mZHNfdDsKLSAg
ICAgICAgICAgIGdfZnJlZShmZHNfdCk7CisgICAgICAgICAgICBtZW1jcHkodm1zZy0+ZmRzICsg
dm1zZy0+ZmRfbnVtLCBmZHMsIG5mZHMgKiBzaXplb2Yodm1zZy0+ZmRzWzBdKSk7CisgICAgICAg
ICAgICB2bXNnLT5mZF9udW0gKz0gbmZkczsKKyAgICAgICAgICAgIGdfZnJlZShmZHMpOwogICAg
ICAgICB9Ci0gICAgICAgIGlmIChyZWFkX2J5dGVzID09IFZIT1NUX1VTRVJfSERSX1NJWkUgfHwg
cmMgPT0gMCkgewotICAgICAgICAgICAgYnJlYWs7CisKKyAgICAgICAgaWYgKHJjID09IDApIHsg
Lyogc29ja2V0IGNsb3NlZCAqLworICAgICAgICAgICAgZ290byBmYWlsOwogICAgICAgICB9Ci0g
ICAgICAgIGlvdi5pb3ZfYmFzZSA9IChjaGFyICopdm1zZyArIHJlYWRfYnl0ZXM7Ci0gICAgICAg
IGlvdi5pb3ZfbGVuID0gVkhPU1RfVVNFUl9IRFJfU0laRSAtIHJlYWRfYnl0ZXM7Ci0gICAgfSB3
aGlsZSAodHJ1ZSk7CiAKLSAgICB2bXNnLT5mZF9udW0gPSBuZmRzOworICAgICAgICBpb3YuaW92
X2Jhc2UgKz0gcmM7CisgICAgICAgIGlvdi5pb3ZfbGVuIC09IHJjOworICAgICAgICByZWFkX2J5
dGVzICs9IHJjOworICAgIH0gd2hpbGUgKHJlYWRfYnl0ZXMgIT0gVkhPU1RfVVNFUl9IRFJfU0la
RSk7CisKICAgICAvKiBxaW9fY2hhbm5lbF9yZWFkdl9mdWxsIHdpbGwgbWFrZSBzb2NrZXQgZmRz
IGJsb2NraW5nLCB1bmJsb2NrIHRoZW0gKi8KICAgICB2bXNnX3VuYmxvY2tfZmRzKHZtc2cpOwog
ICAgIGlmICh2bXNnLT5zaXplID4gc2l6ZW9mKHZtc2ctPnBheWxvYWQpKSB7Ci0tIAoyLjI2LjIK
Cg==


