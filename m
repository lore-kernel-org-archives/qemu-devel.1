Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7BC433E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762B120792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZP6O7vQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762B120792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GH3-00018R-NX
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GET-0005mF-2p
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GEP-0000Tl-MW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9FW2f3OmRD6H9bUWNjnit1SnZohilZbUOB8wjMHoWk=;
 b=ZP6O7vQIMqJkrwiMderrheZKj2CvyfbPEch5TbBFxcK9mVnOtKTMsb89xFo62uPl4Abc17
 eLS9yPy+cY4Af7tVizPvMRjeoHFsLxwmDSlqtZORsa5BxFNv8I2z87+/lpwAstjChZdQsw
 6ibLG2q1xuGgy5jseCxVtdYbjwDJXfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-pMRX0nWiN--wKHJmK6q4qw-1; Wed, 05 Aug 2020 06:01:05 -0400
X-MC-Unique: pMRX0nWiN--wKHJmK6q4qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7A87107BEF8;
 Wed,  5 Aug 2020 10:01:03 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EA927193A;
 Wed,  5 Aug 2020 10:01:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] async: always set ctx->notified in aio_notify()
Date: Wed,  5 Aug 2020 11:00:50 +0100
Message-Id: <20200805100051.361547-3-stefanha@redhat.com>
In-Reply-To: <20200805100051.361547-1-stefanha@redhat.com>
References: <20200805100051.361547-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

YWlvX25vdGlmeSgpIGRvZXMgbm90IHNldCBjdHgtPm5vdGlmaWVkIHdoZW4gY2FsbGVkIHdpdGgK
Y3R4LT5haW9fbm90aWZ5X21lIGRpc2FibGVkLiBUaGVyZWZvcmUgYWlvX25vdGlmeV9tZSBuZWVk
cyB0byBiZSBlbmFibGVkCmR1cmluZyBwb2xsaW5nLgoKVGhpcyBpcyBzdWJvcHRpbWFsIHNpbmNl
IGV4cGVuc2l2ZSBldmVudF9ub3RpZmllcl9zZXQoJmN0eC0+bm90aWZpZXIpCmFuZCBldmVudF9u
b3RpZmllcl90ZXN0X2FuZF9jbGVhcigmY3R4LT5ub3RpZmllcikgY2FsbHMgYXJlIHJlcXVpcmVk
CndoZW4gY3R4LT5haW9fbm90aWZ5X21lIGlzIGVuYWJsZWQuCgpDaGFuZ2UgYWlvX25vdGlmeSgp
IHNvIHRoYXQgYWlvLT5ub3RpZmllZCBpcyBhbHdheXMgc2V0LCByZWdhcmRsZXNzIG9mCmN0eC0+
YWlvX25vdGlmeV9tZS4gVGhpcyB3aWxsIG1ha2UgcG9sbGluZyBjaGVhcGVyIHNpbmNlCmN0eC0+
YWlvX25vdGlmeV9tZSBjYW4gcmVtYWluIGRpc2FibGVkLiBNb3ZlIHRoZQpldmVudF9ub3RpZmll
cl90ZXN0X2FuZF9jbGVhcigpIHRvIHRoZSBmZCBoYW5kbGVyIGZ1bmN0aW9uICh3aGljaCBpcyBu
b3cKbm8gbG9uZ2VyIGFuIGVtcHR5IGZ1bmN0aW9uIHNvICJkdW1teSIgaGFzIGJlZW4gZHJvcHBl
ZCBmcm9tIGl0cyBuYW1lKS4KClRoZSBuZXh0IHBhdGNoIHRha2VzIGFkdmFudGFnZSBvZiB0aGlz
IGJ5IG9wdGltaXppbmcgcG9sbGluZyBpbgp1dGlsL2Fpby1wb3NpeC5jLgoKU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYXN5bmMu
YyB8IDMyICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9hc3lu
Yy5jIGIvdXRpbC9hc3luYy5jCmluZGV4IGQ5Zjk4N2UxMzMuLjNlYzNlOGQxMzUgMTAwNjQ0Ci0t
LSBhL3V0aWwvYXN5bmMuYworKysgYi91dGlsL2FzeW5jLmMKQEAgLTQxOSwyNSArNDE5LDMyIEBA
IEx1cmluZ1N0YXRlICphaW9fZ2V0X2xpbnV4X2lvX3VyaW5nKEFpb0NvbnRleHQgKmN0eCkKIAog
dm9pZCBhaW9fbm90aWZ5KEFpb0NvbnRleHQgKmN0eCkKIHsKLSAgICAvKiBXcml0ZSBlLmcuIGJo
LT5zY2hlZHVsZWQgYmVmb3JlIHJlYWRpbmcgY3R4LT5ub3RpZnlfbWUuICBQYWlycworICAgIC8q
CisgICAgICogV3JpdGUgZS5nLiBiaC0+ZmxhZ3MgYmVmb3JlIHdyaXRpbmcgY3R4LT5ub3RpZmll
ZC4gIFBhaXJzIHdpdGggc21wX21iIGluCisgICAgICogYWlvX25vdGlmeV9hY2NlcHQuCisgICAg
ICovCisgICAgc21wX3dtYigpOworICAgIGF0b21pY19zZXQoJmN0eC0+bm90aWZpZWQsIHRydWUp
OworCisgICAgLyoKKyAgICAgKiBXcml0ZSBjdHgtPm5vdGlmaWVkIGJlZm9yZSByZWFkaW5nIGN0
eC0+bm90aWZ5X21lLiAgUGFpcnMKICAgICAgKiB3aXRoIHNtcF9tYiBpbiBhaW9fY3R4X3ByZXBh
cmUgb3IgYWlvX3BvbGwuCiAgICAgICovCiAgICAgc21wX21iKCk7CiAgICAgaWYgKGF0b21pY19y
ZWFkKCZjdHgtPm5vdGlmeV9tZSkpIHsKICAgICAgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZjdHgt
Pm5vdGlmaWVyKTsKLSAgICAgICAgYXRvbWljX21iX3NldCgmY3R4LT5ub3RpZmllZCwgdHJ1ZSk7
CiAgICAgfQogfQogCiB2b2lkIGFpb19ub3RpZnlfYWNjZXB0KEFpb0NvbnRleHQgKmN0eCkKIHsK
LSAgICBpZiAoYXRvbWljX3hjaGcoJmN0eC0+bm90aWZpZWQsIGZhbHNlKQotI2lmZGVmIFdJTjMy
Ci0gICAgICAgIHx8IHRydWUKLSNlbmRpZgotICAgICkgewotICAgICAgICBldmVudF9ub3RpZmll
cl90ZXN0X2FuZF9jbGVhcigmY3R4LT5ub3RpZmllcik7Ci0gICAgfQorICAgIGF0b21pY19zZXQo
JmN0eC0+bm90aWZpZWQsIGZhbHNlKTsKKworICAgIC8qCisgICAgICogV3JpdGUgY3R4LT5ub3Rp
ZmllZCBiZWZvcmUgcmVhZGluZyBlLmcuIGJoLT5mbGFncy4gIFBhaXJzIHdpdGggc21wX21iIGlu
CisgICAgICogYWlvX25vdGlmeS4KKyAgICAgKi8KKyAgICBzbXBfbWIoKTsKIH0KIAogc3RhdGlj
IHZvaWQgYWlvX3RpbWVybGlzdF9ub3RpZnkodm9pZCAqb3BhcXVlLCBRRU1VQ2xvY2tUeXBlIHR5
cGUpCkBAIC00NDUsOCArNDUyLDExIEBAIHN0YXRpYyB2b2lkIGFpb190aW1lcmxpc3Rfbm90aWZ5
KHZvaWQgKm9wYXF1ZSwgUUVNVUNsb2NrVHlwZSB0eXBlKQogICAgIGFpb19ub3RpZnkob3BhcXVl
KTsKIH0KIAotc3RhdGljIHZvaWQgYWlvX2NvbnRleHRfbm90aWZpZXJfZHVtbXlfY2IoRXZlbnRO
b3RpZmllciAqZSkKK3N0YXRpYyB2b2lkIGFpb19jb250ZXh0X25vdGlmaWVyX2NiKEV2ZW50Tm90
aWZpZXIgKmUpCiB7CisgICAgQWlvQ29udGV4dCAqY3R4ID0gY29udGFpbmVyX29mKGUsIEFpb0Nv
bnRleHQsIG5vdGlmaWVyKTsKKworICAgIGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFyKCZj
dHgtPm5vdGlmaWVyKTsKIH0KIAogLyogUmV0dXJucyB0cnVlIGlmIGFpb19ub3RpZnkoKSB3YXMg
Y2FsbGVkIChlLmcuIGEgQkggd2FzIHNjaGVkdWxlZCkgKi8KQEAgLTUwOCw3ICs1MTgsNyBAQCBB
aW9Db250ZXh0ICphaW9fY29udGV4dF9uZXcoRXJyb3IgKiplcnJwKQogCiAgICAgYWlvX3NldF9l
dmVudF9ub3RpZmllcihjdHgsICZjdHgtPm5vdGlmaWVyLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZmFsc2UsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICBhaW9fY29udGV4dF9ub3Rp
Zmllcl9kdW1teV9jYiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGFpb19jb250ZXh0X25v
dGlmaWVyX2NiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgYWlvX2NvbnRleHRfbm90aWZp
ZXJfcG9sbCk7CiAjaWZkZWYgQ09ORklHX0xJTlVYX0FJTwogICAgIGN0eC0+bGludXhfYWlvID0g
TlVMTDsKLS0gCjIuMjYuMgoK


