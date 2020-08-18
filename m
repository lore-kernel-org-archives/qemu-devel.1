Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E539C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3F72076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgTT7fZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3F72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83nS-00068i-6h
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h4-0004xn-KY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h1-0002UL-Eq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597761266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENnQwlZiy2s0di8Jd6xc923V8L9TxtXZ4z/RSHMFSr8=;
 b=RgTT7fZnqe3Ifq8Tfxo2L3bbuSmHBDIeTIQe97wrJBx+ctUTLljLZox3Ck0JPrKND7mtX6
 zfW7pugnWqwFzJwkCuBJPGDFothgHdmtJgwOaI56I0kZn0Xzb4Qxh1Zz6xEMcELp8IAAuI
 zrAZpHIVAZm02eE4XkxzNyQeqaWZFuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-KZGcSDqNOqiXxGbvOPpf-Q-1; Tue, 18 Aug 2020 10:34:23 -0400
X-MC-Unique: KZGcSDqNOqiXxGbvOPpf-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8453AD32C;
 Tue, 18 Aug 2020 14:34:08 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34E712CFC6;
 Tue, 18 Aug 2020 14:34:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/7] virtio-pci: add virtio_pci_optimal_num_queues() helper
Date: Tue, 18 Aug 2020 15:33:44 +0100
Message-Id: <20200818143348.310613-4-stefanha@redhat.com>
In-Reply-To: <20200818143348.310613-1-stefanha@redhat.com>
References: <20200818143348.310613-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, cohuck@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TXVsdGktcXVldWUgZGV2aWNlcyBhY2hpZXZlIHRoZSBiZXN0IHBlcmZvcm1hbmNlIHdoZW4gZWFj
aCB2Q1BVIGhhcyBhCmRlZGljYXRlZCBxdWV1ZS4gVGhpcyBlbnN1cmVzIHRoYXQgdmlydHF1ZXVl
IHVzZWQgbm90aWZpY2F0aW9ucyBhcmUKaGFuZGxlZCBvbiB0aGUgc2FtZSB2Q1BVIHRoYXQgc3Vi
bWl0dGVkIHZpcnRxdWV1ZSBidWZmZXJzLiAgV2hlbiBhbm90aGVyCnZDUFUgaGFuZGxlcyB0aGUg
dGhlIG5vdGlmaWNhdGlvbiBhbiBJUEkgd2lsbCBiZSBuZWNlc3NhcnkgdG8gd2FrZSB0aGUKc3Vi
bWlzc2lvbiB2Q1BVIGFuZCB0aGlzIGluY3VycyBhIHBlcmZvcm1hbmNlIG92ZXJoZWFkLgoKUHJv
dmlkZSBhIGhlbHBlciBmdW5jdGlvbiB0aGF0IHZpcnRpby1wY2kgZGV2aWNlcyB3aWxsIHVzZSBp
biBsYXRlcgpwYXRjaGVzIHRvIGF1dG9tYXRpY2FsbHkgc2VsZWN0IHRoZSBvcHRpbWFsIG51bWJl
ciBvZiBxdWV1ZXMuCgpUaGUgZnVuY3Rpb24gaGFuZGxlcyBndWVzdHMgd2l0aCBsYXJnZSBudW1i
ZXJzIG9mIENQVXMgYnkgbGltaXRpbmcgdGhlCm51bWJlciBvZiBxdWV1ZXMgdG8gZml0IHdpdGhp
biB0aGUgZm9sbG93aW5nIGNvbnN0cmFpbnRzOgoxLiBUaGUgbWF4aW11bSBudW1iZXIgb2YgTVNJ
LVggdmVjdG9ycy4KMi4gVGhlIG1heGltdW0gbnVtYmVyIG9mIHZpcnRxdWV1ZXMuCgpTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5
OiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNvbT4KLS0tCiBody92aXJ0aW8vdmlydGlv
LXBjaS5oIHwgIDkgKysrKysrKysrCiBody92aXJ0aW8vdmlydGlvLXBjaS5jIHwgMzIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmggYi9ody92aXJ0aW8vdmly
dGlvLXBjaS5oCmluZGV4IGUyZWFhYTkxODIuLjkxMDk2ZjAyOTEgMTAwNjQ0Ci0tLSBhL2h3L3Zp
cnRpby92aXJ0aW8tcGNpLmgKKysrIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuaApAQCAtMjQzLDQg
KzI0MywxMyBAQCB0eXBlZGVmIHN0cnVjdCBWaXJ0aW9QQ0lEZXZpY2VUeXBlSW5mbyB7CiAvKiBS
ZWdpc3RlciB2aXJ0aW8tcGNpIHR5cGUocykuICBAdCBtdXN0IGJlIHN0YXRpYy4gKi8KIHZvaWQg
dmlydGlvX3BjaV90eXBlc19yZWdpc3Rlcihjb25zdCBWaXJ0aW9QQ0lEZXZpY2VUeXBlSW5mbyAq
dCk7CiAKKy8qKgorICogdmlydGlvX3BjaV9vcHRpbWFsX251bV9xdWV1ZXM6CisgKiBAZml4ZWRf
cXVldWVzOiBudW1iZXIgb2YgcXVldWVzIHRoYXQgYXJlIGFsd2F5cyBwcmVzZW50CisgKgorICog
UmV0dXJuczogVGhlIG9wdGltYWwgbnVtYmVyIG9mIHF1ZXVlcyBmb3IgYSBtdWx0aS1xdWV1ZSBk
ZXZpY2UsIGV4Y2x1ZGluZworICogQGZpeGVkX3F1ZXVlcy4KKyAqLwordW5zaWduZWQgdmlydGlv
X3BjaV9vcHRpbWFsX251bV9xdWV1ZXModW5zaWduZWQgZml4ZWRfcXVldWVzKTsKKwogI2VuZGlm
CmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRpby1w
Y2kuYwppbmRleCBjY2RmNTRlODFjLi5mYzY5NTcwZGNjIDEwMDY0NAotLS0gYS9ody92aXJ0aW8v
dmlydGlvLXBjaS5jCisrKyBiL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMKQEAgLTE5LDYgKzE5LDcg
QEAKIAogI2luY2x1ZGUgImV4ZWMvbWVtb3AuaCIKICNpbmNsdWRlICJzdGFuZGFyZC1oZWFkZXJz
L2xpbnV4L3ZpcnRpb19wY2kuaCIKKyNpbmNsdWRlICJody9ib2FyZHMuaCIKICNpbmNsdWRlICJo
dy92aXJ0aW8vdmlydGlvLmgiCiAjaW5jbHVkZSAibWlncmF0aW9uL3FlbXUtZmlsZS10eXBlcy5o
IgogI2luY2x1ZGUgImh3L3BjaS9wY2kuaCIKQEAgLTIwNTgsNiArMjA1OSwzNyBAQCB2b2lkIHZp
cnRpb19wY2lfdHlwZXNfcmVnaXN0ZXIoY29uc3QgVmlydGlvUENJRGV2aWNlVHlwZUluZm8gKnQp
CiAgICAgZ19mcmVlKGJhc2VfbmFtZSk7CiB9CiAKK3Vuc2lnbmVkIHZpcnRpb19wY2lfb3B0aW1h
bF9udW1fcXVldWVzKHVuc2lnbmVkIGZpeGVkX3F1ZXVlcykKK3sKKyAgICAvKgorICAgICAqIDE6
MSB2cSB0byB2Q1BVIG1hcHBpbmcgaXMgaWRlYWwgYmVjYXVzZSB0aGUgc2FtZSB2Q1BVIHRoYXQg
c3VibWl0dGVkCisgICAgICogdmlydHF1ZXVlIGJ1ZmZlcnMgY2FuIGhhbmRsZSB0aGVpciBjb21w
bGV0aW9uLiBXaGVuIGEgZGlmZmVyZW50IHZDUFUKKyAgICAgKiBoYW5kbGVzIGNvbXBsZXRpb24g
aXQgbWF5IG5lZWQgdG8gSVBJIHRoZSB2Q1BVIHRoYXQgc3VibWl0dGVkIHRoZQorICAgICAqIHJl
cXVlc3QgYW5kIHRoaXMgYWRkcyBvdmVyaGVhZC4KKyAgICAgKgorICAgICAqIFZpcnRxdWV1ZXMg
Y29uc3VtZSBndWVzdCBSQU0gYW5kIE1TSS1YIHZlY3RvcnMuIFRoaXMgaXMgd2FzdGVmdWwgaW4K
KyAgICAgKiBndWVzdHMgd2l0aCB2ZXJ5IG1hbnkgdkNQVXMgYW5kIGEgZGV2aWNlIHRoYXQgaXMg
b25seSB1c2VkIGJ5IGEgZmV3CisgICAgICogdkNQVXMuIFVuZm9ydHVuYXRlbHkgb3B0aW1pemlu
ZyB0aGF0IGNhc2UgcmVxdWlyZXMgbWFudWFsIHBpbm5pbmcgaW5zaWRlCisgICAgICogdGhlIGd1
ZXN0LCBzbyB0aG9zZSB1c2VycyBtaWdodCBhcyB3ZWxsIG1hbnVhbGx5IHNldCB0aGUgbnVtYmVy
IG9mCisgICAgICogcXVldWVzLiBUaGVyZSBpcyBubyB1cHBlciBsaW1pdCB0aGF0IGNhbiBiZSBh
cHBsaWVkIGF1dG9tYXRpY2FsbHkgYW5kCisgICAgICogZG9pbmcgc28gYXJiaXRyYXJpbHkgd291
bGQgcmVzdWx0IGluIGEgc3VkZGVuIHBlcmZvcm1hbmNlIGRyb3Agb25jZSB0aGUKKyAgICAgKiB0
aHJlc2hvbGQgbnVtYmVyIG9mIHZDUFVzIGlzIGV4Y2VlZGVkLgorICAgICAqLworICAgIHVuc2ln
bmVkIG51bV9xdWV1ZXMgPSBjdXJyZW50X21hY2hpbmUtPnNtcC5jcHVzOworCisgICAgLyoKKyAg
ICAgKiBUaGUgbWF4aW11bSBudW1iZXIgb2YgTVNJLVggdmVjdG9ycyBpcyBQQ0lfTVNJWF9GTEFH
U19RU0laRSArIDEsIGJ1dCB0aGUKKyAgICAgKiBjb25maWcgY2hhbmdlIGludGVycnVwdCBhbmQg
dGhlIGZpeGVkIHZpcnRxdWV1ZXMgbXVzdCBiZSB0YWtlbiBpbnRvCisgICAgICogYWNjb3VudCB0
b28uCisgICAgICovCisgICAgbnVtX3F1ZXVlcyA9IE1JTihudW1fcXVldWVzLCBQQ0lfTVNJWF9G
TEFHU19RU0laRSAtIGZpeGVkX3F1ZXVlcyk7CisKKyAgICAvKgorICAgICAqIFRoZXJlIGlzIGEg
bGltaXQgdG8gaG93IG1hbnkgdmlydHF1ZXVlcyBhIGRldmljZSBjYW4gaGF2ZS4KKyAgICAgKi8K
KyAgICByZXR1cm4gTUlOKG51bV9xdWV1ZXMsIFZJUlRJT19RVUVVRV9NQVggLSBmaXhlZF9xdWV1
ZXMpOworfQorCiAvKiB2aXJ0aW8tcGNpLWJ1cyAqLwogCiBzdGF0aWMgdm9pZCB2aXJ0aW9fcGNp
X2J1c19uZXcoVmlydGlvQnVzU3RhdGUgKmJ1cywgc2l6ZV90IGJ1c19zaXplLAotLSAKMi4yNi4y
Cgo=


