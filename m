Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111462083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5RKi+xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111462083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLo2K-0006CC-3c
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzy-0004lM-O5
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzv-0008J9-Qz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+PQ1XCVWyw8Vzb4sm+9NjeEI3fhUEwkC0Qw/MszMWs=;
 b=M5RKi+xuUsuh+qpWBDXMSLGmV7kKnsu+78F3DpS8wgn6u2aq+dhqi7i2CHVDWuAi5wqkZk
 VvxkbTZ6FMBiSYgVxuKyQ6zTm7Zaharp6YxhF/DQtQc7tyaoo0dbTr8pXbGtM3xFSO+rNn
 5bw0Wv06sidLE3bFnAS+por/KhKOs4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-LWA7ESYZN8GCYacw2ZqUdQ-1; Fri, 25 Sep 2020 09:42:49 -0400
X-MC-Unique: LWA7ESYZN8GCYacw2ZqUdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093B0805EE4;
 Fri, 25 Sep 2020 13:42:48 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9569E7882B;
 Fri, 25 Sep 2020 13:42:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] block: move block exports to libblockdev
Date: Fri, 25 Sep 2020 14:42:28 +0100
Message-Id: <20200925134229.246169-4-stefanha@redhat.com>
In-Reply-To: <20200925134229.246169-1-stefanha@redhat.com>
References: <20200925134229.246169-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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

QmxvY2sgZXhwb3J0cyBhcmUgdXNlZCBieSBzb2Z0bW11LCBxZW11LXN0b3JhZ2UtZGFlbW9uLCBh
bmQgcWVtdS1uYmQuClRoZXkgYXJlIG5vdCB1c2VkIGJ5IG90aGVyIHByb2dyYW1zIGFuZCBhcmUg
bm90IG90aGVyd2lzZSBuZWVkZWQgaW4KbGliYmxvY2suCgpVbmRvIHRoZSByZWNlbnQgbW92ZSBv
ZiBibG9ja2Rldi1uYmQuYyBmcm9tIGJsb2NrZGV2X3NzIGludG8gYmxvY2tfc3MuClR3byBzdHVi
cyBhcmUgcmVxdWlyZWQgdG8gc3VwcG9ydCB0aGlzOgoxLiBiZHJ2X2Nsb3NlX2FsbCgpIChsaWJi
bG9jaykgY2FsbHMgYmxrX2V4cF9jbG9zZV9hbGwoKSAobGliYmxvY2tkZXYpLgoyLiBxZW11X3N5
c3RlbV9raWxsZWQoKSBpcyBjYWxsZWQgYnkgb3MtcG9zaXguYyAobGliYmxvY2tkZXYpIGFuZCBu
b3QKICAgaW1wbGVtZW50ZWQgaW4gcWVtdS1uYmQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwu
YyAgfCAgNyArKysrKysrCiBzdHVicy9xZW11LXN5c3RlbS1raWxsZWQuYyB8IDEwICsrKysrKysr
KysKIGJsb2NrL2V4cG9ydC9tZXNvbi5idWlsZCAgIHwgIDQgKystLQogbWVzb24uYnVpbGQgICAg
ICAgICAgICAgICAgfCAgNCArKy0tCiBuYmQvbWVzb24uYnVpbGQgICAgICAgICAgICB8ICAyICsr
CiBzdHVicy9tZXNvbi5idWlsZCAgICAgICAgICB8ICAyICsrCiA2IGZpbGVzIGNoYW5nZWQsIDI1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgc3R1YnMv
YmxrLWV4cC1jbG9zZS1hbGwuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL3FlbXUtc3lzdGVt
LWtpbGxlZC5jCgpkaWZmIC0tZ2l0IGEvc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYyBiL3N0dWJz
L2Jsay1leHAtY2xvc2UtYWxsLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MC4uMWM3MTMxNjc2MwotLS0gL2Rldi9udWxsCisrKyBiL3N0dWJzL2Jsay1leHAtY2xvc2UtYWxs
LmMKQEAgLTAsMCArMSw3IEBACisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImJs
b2NrL2V4cG9ydC5oIgorCisvKiBPbmx5IHVzZWQgaW4gcHJvZ3JhbXMgdGhhdCBzdXBwb3J0IGJs
b2NrIGV4cG9ydHMgKGxpYmJsb2NrZGV2LmZhKSAqLwordm9pZCBibGtfZXhwX2Nsb3NlX2FsbCh2
b2lkKQoreworfQpkaWZmIC0tZ2l0IGEvc3R1YnMvcWVtdS1zeXN0ZW0ta2lsbGVkLmMgYi9zdHVi
cy9xZW11LXN5c3RlbS1raWxsZWQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAwLi45YWYxMzE5MTdiCi0tLSAvZGV2L251bGwKKysrIGIvc3R1YnMvcWVtdS1zeXN0ZW0ta2ls
bGVkLmMKQEAgLTAsMCArMSwxMCBAQAorI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRl
ICJzeXNlbXUvcnVuc3RhdGUuaCIKKworLyoKKyAqIFRoaXMgZnVuY3Rpb24gaXMgbmVlZGVkIGJ5
IG9zLXBvc2l4LmMgYnV0IG9ubHkgaW1wbGVtZW50ZWQgYnkgc29mdG1tdSBhbmQKKyAqIHFlbXUt
c3RvcmFnZS1kYWVtb24uIE90aGVyIHByb2dyYW1zIG1heSBoYXZlIG5vIG5lZWQgZm9yIGl0Lgor
ICovCit2b2lkIHFlbXVfc3lzdGVtX2tpbGxlZChpbnQgc2lnbmFsLCBwaWRfdCBwaWQpCit7Cit9
CmRpZmYgLS1naXQgYS9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQgYi9ibG9jay9leHBvcnQvbWVz
b24uYnVpbGQKaW5kZXggNDY5YTdhYTBmNS4uYTI3NzJhMGRjZSAxMDA2NDQKLS0tIGEvYmxvY2sv
ZXhwb3J0L21lc29uLmJ1aWxkCisrKyBiL2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZApAQCAtMSwy
ICsxLDIgQEAKLWJsb2NrX3NzLmFkZChmaWxlcygnZXhwb3J0LmMnKSkKLWJsb2NrX3NzLmFkZCh3
aGVuOiAnQ09ORklHX1ZIT1NUX1VTRVInLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1ibGst
c2VydmVyLmMnKSkKK2Jsb2NrZGV2X3NzLmFkZChmaWxlcygnZXhwb3J0LmMnKSkKK2Jsb2NrZGV2
X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZIT1NUX1VTRVInLCBpZl90cnVlOiBmaWxlcygndmhvc3Qt
dXNlci1ibGstc2VydmVyLmMnKSkKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVp
bGQKaW5kZXggMThkNjg5YjQyMy4uMGU5NTI4YWRhYiAxMDA2NDQKLS0tIGEvbWVzb24uYnVpbGQK
KysrIGIvbWVzb24uYnVpbGQKQEAgLTgzNSw3ICs4MzUsNiBAQCBzdWJkaXIoJ2R1bXAnKQogCiBi
bG9ja19zcy5hZGQoZmlsZXMoCiAgICdibG9jay5jJywKLSAgJ2Jsb2NrZGV2LW5iZC5jJywKICAg
J2Jsb2Nram9iLmMnLAogICAnam9iLmMnLAogICAncWVtdS1pby1jbWRzLmMnLApAQCAtODQ4LDYg
Kzg0Nyw3IEBAIHN1YmRpcignYmxvY2snKQogCiBibG9ja2Rldl9zcy5hZGQoZmlsZXMoCiAgICdi
bG9ja2Rldi5jJywKKyAgJ2Jsb2NrZGV2LW5iZC5jJywKICAgJ2lvdGhyZWFkLmMnLAogICAnam9i
LXFtcC5jJywKICkpCkBAIC0xMTcxLDcgKzExNzEsNyBAQCBpZiBoYXZlX3Rvb2xzCiAgIHFlbXVf
aW8gPSBleGVjdXRhYmxlKCdxZW11LWlvJywgZmlsZXMoJ3FlbXUtaW8uYycpLAogICAgICAgICAg
ICAgIGRlcGVuZGVuY2llczogW2Jsb2NrLCBxZW11dXRpbF0sIGluc3RhbGw6IHRydWUpCiAgIHFl
bXVfbmJkID0gZXhlY3V0YWJsZSgncWVtdS1uYmQnLCBmaWxlcygncWVtdS1uYmQuYycpLAotICAg
ICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBbYmxvY2ssIHFlbXV1dGlsXSwgaW5zdGFsbDogdHJ1
ZSkKKyAgICAgICAgICAgICAgIGRlcGVuZGVuY2llczogW2Jsb2NrZGV2LCBxZW11dXRpbF0sIGlu
c3RhbGw6IHRydWUpCiAKICAgc3ViZGlyKCdzdG9yYWdlLWRhZW1vbicpCiAgIHN1YmRpcignY29u
dHJpYi9yZG1hY20tbXV4JykKZGlmZiAtLWdpdCBhL25iZC9tZXNvbi5idWlsZCBiL25iZC9tZXNv
bi5idWlsZAppbmRleCAwYzAwYTc3NmQzLi4yYmFhYTM2OTQ4IDEwMDY0NAotLS0gYS9uYmQvbWVz
b24uYnVpbGQKKysrIGIvbmJkL21lc29uLmJ1aWxkCkBAIC0xLDUgKzEsNyBAQAogYmxvY2tfc3Mu
YWRkKGZpbGVzKAogICAnY2xpZW50LmMnLAogICAnY29tbW9uLmMnLAorKSkKK2Jsb2NrZGV2X3Nz
LmFkZChmaWxlcygKICAgJ3NlcnZlci5jJywKICkpCmRpZmYgLS1naXQgYS9zdHVicy9tZXNvbi5i
dWlsZCBiL3N0dWJzL21lc29uLmJ1aWxkCmluZGV4IGUwYjMyMmJjMjguLjYwMjM0NTcxYjEgMTAw
NjQ0Ci0tLSBhL3N0dWJzL21lc29uLmJ1aWxkCisrKyBiL3N0dWJzL21lc29uLmJ1aWxkCkBAIC0x
LDYgKzEsNyBAQAogc3R1Yl9zcy5hZGQoZmlsZXMoJ2FyY2hfdHlwZS5jJykpCiBzdHViX3NzLmFk
ZChmaWxlcygnYmRydi1uZXh0LW1vbml0b3Itb3duZWQuYycpKQogc3R1Yl9zcy5hZGQoZmlsZXMo
J2Jsay1jb21taXQtYWxsLmMnKSkKK3N0dWJfc3MuYWRkKGZpbGVzKCdibGstZXhwLWNsb3NlLWFs
bC5jJykpCiBzdHViX3NzLmFkZChmaWxlcygnYmxvY2tkZXYtY2xvc2UtYWxsLWJkcnYtc3RhdGVz
LmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVzKCdjaGFuZ2Utc3RhdGUtaGFuZGxlci5jJykpCiBzdHVi
X3NzLmFkZChmaWxlcygnY2xvY2std2FycC5jJykpCkBAIC0yNSw2ICsyNiw3IEBAIHN0dWJfc3Mu
YWRkKGZpbGVzKCdtb25pdG9yLmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVzKCdtb25pdG9yLWNvcmUu
YycpKQogc3R1Yl9zcy5hZGQoZmlsZXMoJ3BjaS1idXMuYycpKQogc3R1Yl9zcy5hZGQoZmlsZXMo
J3BjaS1ob3N0LXBpaXguYycpKQorc3R1Yl9zcy5hZGQoZmlsZXMoJ3FlbXUtc3lzdGVtLWtpbGxl
ZC5jJykpCiBzdHViX3NzLmFkZChmaWxlcygncWVtdS10aW1lci1ub3RpZnktY2IuYycpKQogc3R1
Yl9zcy5hZGQoZmlsZXMoJ3FtcF9tZW1vcnlfZGV2aWNlLmMnKSkKIHN0dWJfc3MuYWRkKGZpbGVz
KCdxdGVzdC5jJykpCi0tIAoyLjI2LjIKCg==


