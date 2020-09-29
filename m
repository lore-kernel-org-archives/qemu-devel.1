Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D229C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23A920679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIJwiP5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23A920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFBu-00005U-Ve
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAa-0006no-PT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNFAX-000321-HH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXFbv5NoGcKF/JmNbwZmfw/Fty3z1ubjCgX7uQaUL64=;
 b=IIJwiP5y9NR/4D+9E/1mMA75avCwno+3zat/RTV1zz9UJrXPgdJeJuIMWUiLMicCzXr3JX
 RDBa7gV2ACa7QGLBoEhmLEfoQgWrnLVjK5QW73pMXbLHkecthOLZQc29w8dYaDElhuPhWj
 FZy9fhzahKmkw8jk04kbCMYoI7irV9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-Yx4vMOBTO8WutPOmolJfWQ-1; Tue, 29 Sep 2020 08:55:40 -0400
X-MC-Unique: Yx4vMOBTO8WutPOmolJfWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51A1D8D84A1;
 Tue, 29 Sep 2020 12:55:39 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1A795578A;
 Tue, 29 Sep 2020 12:55:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] qemu-storage-daemon: avoid compiling blockdev_ss twice
Date: Tue, 29 Sep 2020 13:55:14 +0100
Message-Id: <20200929125516.186715-3-stefanha@redhat.com>
In-Reply-To: <20200929125516.186715-1-stefanha@redhat.com>
References: <20200929125516.186715-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW50cm9kdWNlIGxpYmJsa2Rldi5mYSB0byBhdm9pZCByZWNvbXBpbGluZyBibG9ja2Rldl9zcyB0
d2ljZS4KClN1Z2dlc3RlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4K
UmV2aWV3ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+ClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBtZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKystLQogc3RvcmFnZS1kYWVtb24vbWVz
b24uYnVpbGQgfCAgMyArLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkCmluZGV4
IGViODRiOTdlYmIuLjE4ZDY4OWI0MjMgMTAwNjQ0Ci0tLSBhL21lc29uLmJ1aWxkCisrKyBiL21l
c29uLmJ1aWxkCkBAIC04NTcsNyArODU3LDYgQEAgYmxvY2tkZXZfc3MuYWRkKGZpbGVzKAogYmxv
Y2tkZXZfc3MuYWRkKHdoZW46ICdDT05GSUdfUE9TSVgnLCBpZl90cnVlOiBmaWxlcygnb3MtcG9z
aXguYycpKQogc29mdG1tdV9zcy5hZGQod2hlbjogJ0NPTkZJR19XSU4zMicsIGlmX3RydWU6IFtm
aWxlcygnb3Mtd2luMzIuYycpXSkKIAotc29mdG1tdV9zcy5hZGRfYWxsKGJsb2NrZGV2X3NzKQog
c29mdG1tdV9zcy5hZGQoZmlsZXMoCiAgICdib290ZGV2aWNlLmMnLAogICAnZG1hLWhlbHBlcnMu
YycsCkBAIC05NTIsNiArOTUxLDE1IEBAIGJsb2NrID0gZGVjbGFyZV9kZXBlbmRlbmN5KGxpbmtf
d2hvbGU6IFtsaWJibG9ja10sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaW5rX2FyZ3M6
ICdAYmxvY2suc3ltcycsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6
IFtjcnlwdG8sIGlvXSkKIAorYmxvY2tkZXZfc3MgPSBibG9ja2Rldl9zcy5hcHBseShjb25maWdf
aG9zdCwgc3RyaWN0OiBmYWxzZSkKK2xpYmJsb2NrZGV2ID0gc3RhdGljX2xpYnJhcnkoJ2Jsb2Nr
ZGV2JywgYmxvY2tkZXZfc3Muc291cmNlcygpICsgZ2VuaCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGVwZW5kZW5jaWVzOiBibG9ja2Rldl9zcy5kZXBlbmRlbmNpZXMoKSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbmFtZV9zdWZmaXg6ICdmYScsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJ1aWxkX2J5X2RlZmF1bHQ6IGZhbHNlKQorCitibG9ja2RldiA9IGRl
Y2xhcmVfZGVwZW5kZW5jeShsaW5rX3dob2xlOiBbbGliYmxvY2tkZXZdLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBbYmxvY2tdKQorCiBxbXBfc3MgPSBxbXBf
c3MuYXBwbHkoY29uZmlnX2hvc3QsIHN0cmljdDogZmFsc2UpCiBsaWJxbXAgPSBzdGF0aWNfbGli
cmFyeSgncW1wJywgcW1wX3NzLnNvdXJjZXMoKSArIGdlbmgsCiAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXBlbmRlbmNpZXM6IHFtcF9zcy5kZXBlbmRlbmNpZXMoKSwKQEAgLTk2OCw3ICs5NzYs
NyBAQCBmb3JlYWNoIG0gOiBibG9ja19tb2RzICsgc29mdG1tdV9tb2RzCiAgICAgICAgICAgICAg
ICAgaW5zdGFsbF9kaXI6IGNvbmZpZ19ob3N0WydxZW11X21vZGRpciddKQogZW5kZm9yZWFjaAog
Ci1zb2Z0bW11X3NzLmFkZChhdXRoeiwgYmxvY2ssIGNoYXJkZXYsIGNyeXB0bywgaW8sIHFtcCkK
K3NvZnRtbXVfc3MuYWRkKGF1dGh6LCBibG9ja2RldiwgY2hhcmRldiwgY3J5cHRvLCBpbywgcW1w
KQogY29tbW9uX3NzLmFkZChxb20sIHFlbXV1dGlsKQogCiBjb21tb25fc3MuYWRkX2FsbCh3aGVu
OiAnQ09ORklHX1NPRlRNTVUnLCBpZl90cnVlOiBbc29mdG1tdV9zc10pCmRpZmYgLS1naXQgYS9z
dG9yYWdlLWRhZW1vbi9tZXNvbi5idWlsZCBiL3N0b3JhZ2UtZGFlbW9uL21lc29uLmJ1aWxkCmlu
ZGV4IDA0MDlhY2MzZjUuLmM1YWRjZTgxYzMgMTAwNjQ0Ci0tLSBhL3N0b3JhZ2UtZGFlbW9uL21l
c29uLmJ1aWxkCisrKyBiL3N0b3JhZ2UtZGFlbW9uL21lc29uLmJ1aWxkCkBAIC0xLDcgKzEsNiBA
QAogcXNkX3NzID0gc3Muc291cmNlX3NldCgpCiBxc2Rfc3MuYWRkKGZpbGVzKCdxZW11LXN0b3Jh
Z2UtZGFlbW9uLmMnKSkKLXFzZF9zcy5hZGQoYmxvY2ssIGNoYXJkZXYsIHFtcCwgcW9tLCBxZW11
dXRpbCkKLXFzZF9zcy5hZGRfYWxsKGJsb2NrZGV2X3NzKQorcXNkX3NzLmFkZChibG9ja2Rldiwg
Y2hhcmRldiwgcW1wLCBxb20sIHFlbXV1dGlsKQogCiBzdWJkaXIoJ3FhcGknKQogCi0tIAoyLjI2
LjIKCg==


