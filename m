Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A8AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5038D2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoshmtCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5038D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFjI-0006ST-Gx
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhx-0004iO-PC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhu-0006bs-0H
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nV2+EVRAa9jpQkKlIquVfLJWvJW6APZ35wGYgjVpmM=;
 b=EoshmtCKzi412Pz9NqAphYI3sqNEs4Sxg2/9b1jPjU3C4UQ7Ezj2l9czanspy78l8qB81R
 O/Udktq7i5QwPJ+JJYdhHWooMHdeZMqIimgmtzXoDpxFO0PVx4ASbVrwWQ/sawMIp+3ecJ
 nw/mTCKBC0pqKithEiquVWFvCZQ+Pcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-E7Go2dtUM_O1LLEYN8CBFg-1; Fri, 19 Jun 2020 08:01:14 -0400
X-MC-Unique: E7Go2dtUM_O1LLEYN8CBFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAB8118CA270;
 Fri, 19 Jun 2020 12:01:13 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82ABF5D9E8;
 Fri, 19 Jun 2020 12:01:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 4/6] vhost-user-server: mark fd handlers "external"
Date: Fri, 19 Jun 2020 13:00:44 +0100
Message-Id: <20200619120046.2422205-4-stefanha@redhat.com>
In-Reply-To: <20200619120046.2422205-1-stefanha@redhat.com>
References: <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619120046.2422205-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGV2ZW50IGxvb3AgaGFzIHRoZSBjb25jZXB0IG9mICJleHRlcm5hbCIgZmQgaGFuZGxlcnMg
dGhhdCBwcm9jZXNzCnJlcXVlc3RzIGZyb20gb3V0c2lkZSBjbGllbnRzIHN1Y2ggYXMgdGhlIGd1
ZXN0LiBFeHRlcm5hbCBmZCBoYW5kbGVycwphcmUgZGlzYWJsZWQgZHVyaW5nIGNyaXRpY2FsIHNl
Y3Rpb25zIHdoZXJlIG5ldyByZXF1ZXN0cyBhcmUgbm90CmFsbG93ZWQuCgpUaGUgdmhvc3QtdXNl
ci1zZXJ2ZXIgc2VlbXMgbGlrZSBhbiAiZXh0ZXJuYWwiIGNsaWVudCB0byBtZSBhbmQKdGhlcmVm
b3JlIHNob3VsZCBtYXJrIGl0cyBmaWxlIGRlc2NyaXB0b3JzICJleHRlcm5hbCIuCgpTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC92
aG9zdC11c2VyLXNlcnZlci5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2Vy
dmVyLmMgYi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKaW5kZXggNTIzMGJhMzg4My4uYTU3ODVj
YmY4NiAxMDA2NDQKLS0tIGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhv
c3QtdXNlci1zZXJ2ZXIuYwpAQCAtMjM1LDcgKzIzNSw3IEBAIHNldF93YXRjaChWdURldiAqdnVf
ZGV2LCBpbnQgZmQsIGludCB2dV9ldnQsCiAgICAgICAgIGtpY2tfaW5mby0+ZmQgPSBmZDsKICAg
ICAgICAga2lja19pbmZvLT5jYiA9IGNiOwogICAgICAgICBxZW11X3NldF9ub25ibG9jayhmZCk7
Ci0gICAgICAgIGFpb19zZXRfZmRfaGFuZGxlcihzZXJ2ZXItPmlvYy0+Y3R4LCBmZCwgZmFsc2Us
IGtpY2tfaGFuZGxlciwKKyAgICAgICAgYWlvX3NldF9mZF9oYW5kbGVyKHNlcnZlci0+aW9jLT5j
dHgsIGZkLCB0cnVlLCBraWNrX2hhbmRsZXIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBO
VUxMLCBOVUxMLCBraWNrX2luZm8pOwogICAgICAgICBraWNrX2luZm8tPnZ1X2RldiA9IHZ1X2Rl
djsKICAgICB9CkBAIC0yNjIsNyArMjYyLDcgQEAgc3RhdGljIHZvaWQgcmVtb3ZlX3dhdGNoKFZ1
RGV2ICp2dV9kZXYsIGludCBmZCkKICAgICAgICAgcmV0dXJuOwogICAgIH0KICAgICBzZXJ2ZXIt
PmtpY2tfaW5mb1tpXS5jYiA9IE5VTEw7Ci0gICAgYWlvX3NldF9mZF9oYW5kbGVyKHNlcnZlci0+
aW9jLT5jdHgsIGZkLCBmYWxzZSwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7CisgICAgYWlvX3Nl
dF9mZF9oYW5kbGVyKHNlcnZlci0+aW9jLT5jdHgsIGZkLCB0cnVlLCBOVUxMLCBOVUxMLCBOVUxM
LCBOVUxMKTsKIH0KIAogCkBAIC0zMzMsNyArMzMzLDcgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2Nv
bnRleHQoVnVTZXJ2ZXIgKnNlcnZlcikKICAgICBxaW9fY2hhbm5lbF9kZXRhY2hfYWlvX2NvbnRl
eHQoc2VydmVyLT5pb2MpOwogICAgIGZvciAoaSA9IDA7IGkgPCBzZXJ2ZXItPnZ1X2Rldi5tYXhf
cXVldWVzOyBpKyspIHsKICAgICAgICAgaWYgKHNlcnZlci0+a2lja19pbmZvW2ldLmNiKSB7Ci0g
ICAgICAgICAgICBhaW9fc2V0X2ZkX2hhbmRsZXIoY3R4LCBzZXJ2ZXItPmtpY2tfaW5mb1tpXS5m
ZCwgZmFsc2UsIE5VTEwsCisgICAgICAgICAgICBhaW9fc2V0X2ZkX2hhbmRsZXIoY3R4LCBzZXJ2
ZXItPmtpY2tfaW5mb1tpXS5mZCwgdHJ1ZSwgTlVMTCwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOVUxMLCBOVUxMLCBOVUxMKTsKICAgICAgICAgfQogICAgIH0KQEAgLTM0OSw3ICsz
NDksNyBAQCBzdGF0aWMgdm9pZCBhdHRhY2hfY29udGV4dChWdVNlcnZlciAqc2VydmVyLCBBaW9D
b250ZXh0ICpjdHgpCiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkgPCBzZXJ2ZXItPnZ1X2Rldi5t
YXhfcXVldWVzOyBpKyspIHsKICAgICAgICAgaWYgKHNlcnZlci0+a2lja19pbmZvW2ldLmNiKSB7
Ci0gICAgICAgICAgICBhaW9fc2V0X2ZkX2hhbmRsZXIoY3R4LCBzZXJ2ZXItPmtpY2tfaW5mb1tp
XS5mZCwgZmFsc2UsCisgICAgICAgICAgICBhaW9fc2V0X2ZkX2hhbmRsZXIoY3R4LCBzZXJ2ZXIt
PmtpY2tfaW5mb1tpXS5mZCwgdHJ1ZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBr
aWNrX2hhbmRsZXIsIE5VTEwsIE5VTEwsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JnNlcnZlci0+a2lja19pbmZvW2ldKTsKICAgICAgICAgfQotLSAKMi4yNi4yCgo=


