Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5C6208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhYV+CQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5C6208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtKh-0008UM-MW
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJg-0006p3-2h
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:29:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJf-00011L-71
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzfuoH281zyXLe3OPWvxcTWK2OHxNTXKDxKKnbkGlAs=;
 b=QhYV+CQGS/gWM4fLwn+UWjlentJyTZETkjY8SxzBvh4rOemeJ2vgL1aDEdoBaoS0CwjBI7
 DDSz7iEsCzep9Rrh64rvSGgoAI4+bfJbgt/6LCrdmETai+jqqBwpb7v/j0+iPheey+QgVG
 +96tG4r4AlZXLAQ34nJjoMpc693Wpic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-TD_f2IsLO8iujHOjnreCOA-1; Wed, 27 May 2020 06:29:41 -0400
X-MC-Unique: TD_f2IsLO8iujHOjnreCOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92FB680183C;
 Wed, 27 May 2020 10:29:39 +0000 (UTC)
Received: from localhost (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ADF46C77F;
 Wed, 27 May 2020 10:29:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/5] virtio-pci: add virtio_pci_optimal_num_queues() helper
Date: Wed, 27 May 2020 11:29:21 +0100
Message-Id: <20200527102925.128013-2-stefanha@redhat.com>
In-Reply-To: <20200527102925.128013-1-stefanha@redhat.com>
References: <20200527102925.128013-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
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
ciBvZiBxdWV1ZXMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ci0tLQogaHcvdmlydGlvL3ZpcnRpby1wY2kuaCB8IDkgKysrKysrKysrCiBody92
aXJ0aW8vdmlydGlvLXBjaS5jIHwgNyArKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5oIGIvaHcvdmlydGlv
L3ZpcnRpby1wY2kuaAppbmRleCBlMmVhYWE5MTgyLi45MTA5NmYwMjkxIDEwMDY0NAotLS0gYS9o
dy92aXJ0aW8vdmlydGlvLXBjaS5oCisrKyBiL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgKQEAgLTI0
Myw0ICsyNDMsMTMgQEAgdHlwZWRlZiBzdHJ1Y3QgVmlydGlvUENJRGV2aWNlVHlwZUluZm8gewog
LyogUmVnaXN0ZXIgdmlydGlvLXBjaSB0eXBlKHMpLiAgQHQgbXVzdCBiZSBzdGF0aWMuICovCiB2
b2lkIHZpcnRpb19wY2lfdHlwZXNfcmVnaXN0ZXIoY29uc3QgVmlydGlvUENJRGV2aWNlVHlwZUlu
Zm8gKnQpOwogCisvKioKKyAqIHZpcnRpb19wY2lfb3B0aW1hbF9udW1fcXVldWVzOgorICogQGZp
eGVkX3F1ZXVlczogbnVtYmVyIG9mIHF1ZXVlcyB0aGF0IGFyZSBhbHdheXMgcHJlc2VudAorICoK
KyAqIFJldHVybnM6IFRoZSBvcHRpbWFsIG51bWJlciBvZiBxdWV1ZXMgZm9yIGEgbXVsdGktcXVl
dWUgZGV2aWNlLCBleGNsdWRpbmcKKyAqIEBmaXhlZF9xdWV1ZXMuCisgKi8KK3Vuc2lnbmVkIHZp
cnRpb19wY2lfb3B0aW1hbF9udW1fcXVldWVzKHVuc2lnbmVkIGZpeGVkX3F1ZXVlcyk7CisKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRpby92aXJ0
aW8tcGNpLmMKaW5kZXggZDAyOGMxN2MyNC4uMGM0ZjAxMDBjYSAxMDA2NDQKLS0tIGEvaHcvdmly
dGlvL3ZpcnRpby1wY2kuYworKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jCkBAIC0xOSw2ICsx
OSw3IEBACiAKICNpbmNsdWRlICJleGVjL21lbW9wLmgiCiAjaW5jbHVkZSAic3RhbmRhcmQtaGVh
ZGVycy9saW51eC92aXJ0aW9fcGNpLmgiCisjaW5jbHVkZSAiaHcvYm9hcmRzLmgiCiAjaW5jbHVk
ZSAiaHcvdmlydGlvL3ZpcnRpby5oIgogI2luY2x1ZGUgIm1pZ3JhdGlvbi9xZW11LWZpbGUtdHlw
ZXMuaCIKICNpbmNsdWRlICJody9wY2kvcGNpLmgiCkBAIC0yMDI0LDYgKzIwMjUsMTIgQEAgdm9p
ZCB2aXJ0aW9fcGNpX3R5cGVzX3JlZ2lzdGVyKGNvbnN0IFZpcnRpb1BDSURldmljZVR5cGVJbmZv
ICp0KQogICAgIGdfZnJlZShiYXNlX25hbWUpOwogfQogCit1bnNpZ25lZCB2aXJ0aW9fcGNpX29w
dGltYWxfbnVtX3F1ZXVlcyh1bnNpZ25lZCBmaXhlZF9xdWV1ZXMpCit7CisgICAgLyogMToxIHZx
IHRvIHZjcHUgbWFwcGluZyBpcyBpZGVhbCBiZWNhdXNlIGl0IGF2b2lkcyBJUElzICovCisgICAg
cmV0dXJuIE1JTihjdXJyZW50X21hY2hpbmUtPnNtcC5jcHVzLCBWSVJUSU9fUVVFVUVfTUFYIC0g
Zml4ZWRfcXVldWVzKTsKK30KKwogLyogdmlydGlvLXBjaS1idXMgKi8KIAogc3RhdGljIHZvaWQg
dmlydGlvX3BjaV9idXNfbmV3KFZpcnRpb0J1c1N0YXRlICpidXMsIHNpemVfdCBidXNfc2l6ZSwK
LS0gCjIuMjUuNAoK


