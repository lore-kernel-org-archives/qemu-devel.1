Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7062070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTYJSo26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7062070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRee-0006Un-L2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcT-0001bc-TE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcN-0006Sa-Sy
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594043831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSP7/djMhy25kGi63d6m5Qu/kXKQoqJaN2oMWV9dQSg=;
 b=aTYJSo26MV2RrGR6Vr1EAC9MWuXyymzSCxHiXQQbrGqG6E7toFCQPyBX54YL0kl9J8X7GM
 4xDRiOmBHi9tvEP5WL3gBk+7erPZCemwE1jNd/6E8x932H6RW96EBGMSvzm+/ypDDeyOSv
 mexevkPvW3088wpVX3ObJUmaLx7NDzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-goE85UbSMSSoS1l_CdAbsg-1; Mon, 06 Jul 2020 09:57:07 -0400
X-MC-Unique: goE85UbSMSSoS1l_CdAbsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B4CF107ACCA;
 Mon,  6 Jul 2020 13:57:06 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF295C1B2;
 Mon,  6 Jul 2020 13:56:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/5] virtio-pci: add virtio_pci_optimal_num_queues() helper
Date: Mon,  6 Jul 2020 14:56:46 +0100
Message-Id: <20200706135650.438362-2-stefanha@redhat.com>
In-Reply-To: <20200706135650.438362-1-stefanha@redhat.com>
References: <20200706135650.438362-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaHcvdmly
dGlvL3ZpcnRpby1wY2kuaCB8ICA5ICsrKysrKysrKwogaHcvdmlydGlvL3ZpcnRpby1wY2kuYyB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQx
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5oIGIvaHcv
dmlydGlvL3ZpcnRpby1wY2kuaAppbmRleCBlMmVhYWE5MTgyLi45MTA5NmYwMjkxIDEwMDY0NAot
LS0gYS9ody92aXJ0aW8vdmlydGlvLXBjaS5oCisrKyBiL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgK
QEAgLTI0Myw0ICsyNDMsMTMgQEAgdHlwZWRlZiBzdHJ1Y3QgVmlydGlvUENJRGV2aWNlVHlwZUlu
Zm8gewogLyogUmVnaXN0ZXIgdmlydGlvLXBjaSB0eXBlKHMpLiAgQHQgbXVzdCBiZSBzdGF0aWMu
ICovCiB2b2lkIHZpcnRpb19wY2lfdHlwZXNfcmVnaXN0ZXIoY29uc3QgVmlydGlvUENJRGV2aWNl
VHlwZUluZm8gKnQpOwogCisvKioKKyAqIHZpcnRpb19wY2lfb3B0aW1hbF9udW1fcXVldWVzOgor
ICogQGZpeGVkX3F1ZXVlczogbnVtYmVyIG9mIHF1ZXVlcyB0aGF0IGFyZSBhbHdheXMgcHJlc2Vu
dAorICoKKyAqIFJldHVybnM6IFRoZSBvcHRpbWFsIG51bWJlciBvZiBxdWV1ZXMgZm9yIGEgbXVs
dGktcXVldWUgZGV2aWNlLCBleGNsdWRpbmcKKyAqIEBmaXhlZF9xdWV1ZXMuCisgKi8KK3Vuc2ln
bmVkIHZpcnRpb19wY2lfb3B0aW1hbF9udW1fcXVldWVzKHVuc2lnbmVkIGZpeGVkX3F1ZXVlcyk7
CisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRp
by92aXJ0aW8tcGNpLmMKaW5kZXggN2JjOGMxYzA1Ni4uYzQ4NTcwYzAzZiAxMDA2NDQKLS0tIGEv
aHcvdmlydGlvL3ZpcnRpby1wY2kuYworKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jCkBAIC0x
OSw2ICsxOSw3IEBACiAKICNpbmNsdWRlICJleGVjL21lbW9wLmgiCiAjaW5jbHVkZSAic3RhbmRh
cmQtaGVhZGVycy9saW51eC92aXJ0aW9fcGNpLmgiCisjaW5jbHVkZSAiaHcvYm9hcmRzLmgiCiAj
aW5jbHVkZSAiaHcvdmlydGlvL3ZpcnRpby5oIgogI2luY2x1ZGUgIm1pZ3JhdGlvbi9xZW11LWZp
bGUtdHlwZXMuaCIKICNpbmNsdWRlICJody9wY2kvcGNpLmgiCkBAIC0yMDI4LDYgKzIwMjksMzcg
QEAgdm9pZCB2aXJ0aW9fcGNpX3R5cGVzX3JlZ2lzdGVyKGNvbnN0IFZpcnRpb1BDSURldmljZVR5
cGVJbmZvICp0KQogICAgIGdfZnJlZShiYXNlX25hbWUpOwogfQogCit1bnNpZ25lZCB2aXJ0aW9f
cGNpX29wdGltYWxfbnVtX3F1ZXVlcyh1bnNpZ25lZCBmaXhlZF9xdWV1ZXMpCit7CisgICAgLyoK
KyAgICAgKiAxOjEgdnEgdG8gdkNQVSBtYXBwaW5nIGlzIGlkZWFsIGJlY2F1c2UgdGhlIHNhbWUg
dkNQVSB0aGF0IHN1Ym1pdHRlZAorICAgICAqIHZpcnRxdWV1ZSBidWZmZXJzIGNhbiBoYW5kbGUg
dGhlaXIgY29tcGxldGlvbi4gV2hlbiBhIGRpZmZlcmVudCB2Q1BVCisgICAgICogaGFuZGxlcyBj
b21wbGV0aW9uIGl0IG1heSBuZWVkIHRvIElQSSB0aGUgdkNQVSB0aGF0IHN1Ym1pdHRlZCB0aGUK
KyAgICAgKiByZXF1ZXN0IGFuZCB0aGlzIGFkZHMgb3ZlcmhlYWQuCisgICAgICoKKyAgICAgKiBW
aXJ0cXVldWVzIGNvbnN1bWUgZ3Vlc3QgUkFNIGFuZCBNU0ktWCB2ZWN0b3JzLiBUaGlzIGlzIHdh
c3RlZnVsIGluCisgICAgICogZ3Vlc3RzIHdpdGggdmVyeSBtYW55IHZDUFVzIGFuZCBhIGRldmlj
ZSB0aGF0IGlzIG9ubHkgdXNlZCBieSBhIGZldworICAgICAqIHZDUFVzLiBVbmZvcnR1bmF0ZWx5
IG9wdGltaXppbmcgdGhhdCBjYXNlIHJlcXVpcmVzIG1hbnVhbCBwaW5uaW5nIGluc2lkZQorICAg
ICAqIHRoZSBndWVzdCwgc28gdGhvc2UgdXNlcnMgbWlnaHQgYXMgd2VsbCBtYW51YWxseSBzZXQg
dGhlIG51bWJlciBvZgorICAgICAqIHF1ZXVlcy4gVGhlcmUgaXMgbm8gdXBwZXIgbGltaXQgdGhh
dCBjYW4gYmUgYXBwbGllZCBhdXRvbWF0aWNhbGx5IGFuZAorICAgICAqIGRvaW5nIHNvIGFyYml0
cmFyaWx5IHdvdWxkIHJlc3VsdCBpbiBhIHN1ZGRlbiBwZXJmb3JtYW5jZSBkcm9wIG9uY2UgdGhl
CisgICAgICogdGhyZXNob2xkIG51bWJlciBvZiB2Q1BVcyBpcyBleGNlZWRlZC4KKyAgICAgKi8K
KyAgICB1bnNpZ25lZCBudW1fcXVldWVzID0gY3VycmVudF9tYWNoaW5lLT5zbXAuY3B1czsKKwor
ICAgIC8qCisgICAgICogVGhlIG1heGltdW0gbnVtYmVyIG9mIE1TSS1YIHZlY3RvcnMgaXMgUENJ
X01TSVhfRkxBR1NfUVNJWkUgKyAxLCBidXQgdGhlCisgICAgICogY29uZmlnIGNoYW5nZSBpbnRl
cnJ1cHQgYW5kIHRoZSBmaXhlZCB2aXJ0cXVldWVzIG11c3QgYmUgdGFrZW4gaW50bworICAgICAq
IGFjY291bnQgdG9vLgorICAgICAqLworICAgIG51bV9xdWV1ZXMgPSBNSU4obnVtX3F1ZXVlcywg
UENJX01TSVhfRkxBR1NfUVNJWkUgLSBmaXhlZF9xdWV1ZXMpOworCisgICAgLyoKKyAgICAgKiBU
aGVyZSBpcyBhIGxpbWl0IHRvIGhvdyBtYW55IHZpcnRxdWV1ZXMgYSBkZXZpY2UgY2FuIGhhdmUu
CisgICAgICovCisgICAgcmV0dXJuIE1JTihudW1fcXVldWVzLCBWSVJUSU9fUVVFVUVfTUFYIC0g
Zml4ZWRfcXVldWVzKTsKK30KKwogLyogdmlydGlvLXBjaS1idXMgKi8KIAogc3RhdGljIHZvaWQg
dmlydGlvX3BjaV9idXNfbmV3KFZpcnRpb0J1c1N0YXRlICpidXMsIHNpemVfdCBidXNfc2l6ZSwK
LS0gCjIuMjYuMgoK


