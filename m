Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093EFC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C679D206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFA2K+qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83Q5-0007Ge-Uu
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h6-00052s-D5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k82h2-0002Ui-8r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597761267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gvVRr63NaVLTha3tZ0afugXNCMQNgh+pilq0gGN5Mc=;
 b=LFA2K+qi4VHxQCRRpQTD9Nz1gt+ZCMSfhhcTzIji2JqDJZ3C0ygMhg3/ODXjeUaWATcnt2
 o7w9a6VwVmnn1OuqF98relXbEtlL4fidgD5c0hSDE6aDfufA6U2Uf01Q8sE6huMJfO32jr
 TEaGhuuE3hErxsueBaYz7L1VrVoDRaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Dqkbuv7nP3OrUqcFGbZVSA-1; Tue, 18 Aug 2020 10:34:24 -0400
X-MC-Unique: Dqkbuv7nP3OrUqcFGbZVSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C42C31015113;
 Tue, 18 Aug 2020 14:34:14 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F3CE10013C2;
 Tue, 18 Aug 2020 14:34:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 6/7] virtio-blk-pci: default num_queues to -smp N
Date: Tue, 18 Aug 2020 15:33:47 +0100
Message-Id: <20200818143348.310613-7-stefanha@redhat.com>
In-Reply-To: <20200818143348.310613-1-stefanha@redhat.com>
References: <20200818143348.310613-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QXV0b21hdGljYWxseSBzaXplIHRoZSBudW1iZXIgb2YgdmlydGlvLWJsay1wY2kgcmVxdWVzdCB2
aXJ0cXVldWVzIHRvCm1hdGNoIHRoZSBudW1iZXIgb2YgdkNQVXMuICBPdGhlciB0cmFuc3BvcnRz
IGNvbnRpbnVlIHRvIGRlZmF1bHQgdG8gMQpyZXF1ZXN0IHZpcnRxdWV1ZS4KCkEgMToxIHZpcnRx
dWV1ZTp2Q1BVIG1hcHBpbmcgZW5zdXJlcyB0aGF0IGNvbXBsZXRpb24gaW50ZXJydXB0cyBhcmUK
aGFuZGxlZCBvbiB0aGUgc2FtZSB2Q1BVIHRoYXQgc3VibWl0dGVkIHRoZSByZXF1ZXN0LiAgTm8g
SVBJIGlzCm5lY2Vzc2FyeSB0byBjb21wbGV0ZSBhbiBJL08gcmVxdWVzdCBhbmQgcGVyZm9ybWFu
Y2UgaXMgaW1wcm92ZWQuICBUaGUKbWF4aW11bSBudW1iZXIgb2YgTVNJLVggdmVjdG9ycyBhbmQg
dmlydHF1ZXVlcyBsaW1pdCBhcmUgcmVzcGVjdGVkLgoKUGVyZm9ybWFuY2UgaW1wcm92ZXMgZnJv
bSA3OGsgdG8gMTA0ayBJT1BTIG9uIGEgMzIgdkNQVSBndWVzdCB3aXRoIDEwMQp2aXJ0aW8tYmxr
LXBjaSBkZXZpY2VzIChpb2VuZ2luZT1saWJhaW8sIGlvZGVwdGg9MSwgYnM9NGssIHJ3PXJhbmRy
ZWFkCndpdGggTlZNZSBzdG9yYWdlKS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IENvcm5lbGlhIEh1Y2sgPGNvaHVja0By
ZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEubGludXhA
Z21haWwuY29tPgotLS0KIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaCB8IDIgKysKIGh3
L2Jsb2NrL3ZpcnRpby1ibGsuYyAgICAgICAgICB8IDYgKysrKystCiBody9jb3JlL21hY2hpbmUu
YyAgICAgICAgICAgICAgfCAxICsKIGh3L3ZpcnRpby92aXJ0aW8tYmxrLXBjaS5jICAgICB8IDcg
KysrKysrLQogNCBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaCBiL2luY2x1ZGUv
aHcvdmlydGlvL3ZpcnRpby1ibGsuaAppbmRleCBiMTMzNGMzOTA0Li43NTM5YzJiODQ4IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYmxrLmgKKysrIGIvaW5jbHVkZS9ody92
aXJ0aW8vdmlydGlvLWJsay5oCkBAIC0zMCw2ICszMCw4IEBAIHN0cnVjdCB2aXJ0aW9fYmxrX2lu
aGRyCiAgICAgdW5zaWduZWQgY2hhciBzdGF0dXM7CiB9OwogCisjZGVmaW5lIFZJUlRJT19CTEtf
QVVUT19OVU1fUVVFVUVTIFVJTlQxNl9NQVgKKwogc3RydWN0IFZpcnRJT0Jsa0NvbmYKIHsKICAg
ICBCbG9ja0NvbmYgY29uZjsKZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYyBiL2h3
L2Jsb2NrL3ZpcnRpby1ibGsuYwppbmRleCA0MTM3ODM2OTNjLi4yMjA0YmExNDllIDEwMDY0NAot
LS0gYS9ody9ibG9jay92aXJ0aW8tYmxrLmMKKysrIGIvaHcvYmxvY2svdmlydGlvLWJsay5jCkBA
IC0xMTQ3LDYgKzExNDcsOSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fYmxrX2RldmljZV9yZWFsaXpl
KERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiRGV2aWNlIG5lZWRzIG1lZGlhLCBidXQgZHJpdmUgaXMgZW1wdHkiKTsKICAgICAgICAgcmV0
dXJuOwogICAgIH0KKyAgICBpZiAoY29uZi0+bnVtX3F1ZXVlcyA9PSBWSVJUSU9fQkxLX0FVVE9f
TlVNX1FVRVVFUykgeworICAgICAgICBjb25mLT5udW1fcXVldWVzID0gMTsKKyAgICB9CiAgICAg
aWYgKCFjb25mLT5udW1fcXVldWVzKSB7CiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIm51bS1x
dWV1ZXMgcHJvcGVydHkgbXVzdCBiZSBsYXJnZXIgdGhhbiAwIik7CiAgICAgICAgIHJldHVybjsK
QEAgLTEyODEsNyArMTI4NCw4IEBAIHN0YXRpYyBQcm9wZXJ0eSB2aXJ0aW9fYmxrX3Byb3BlcnRp
ZXNbXSA9IHsKICNlbmRpZgogICAgIERFRklORV9QUk9QX0JJVCgicmVxdWVzdC1tZXJnaW5nIiwg
VmlydElPQmxvY2ssIGNvbmYucmVxdWVzdF9tZXJnaW5nLCAwLAogICAgICAgICAgICAgICAgICAg
ICB0cnVlKSwKLSAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51bS1xdWV1ZXMiLCBWaXJ0SU9CbG9j
aywgY29uZi5udW1fcXVldWVzLCAxKSwKKyAgICBERUZJTkVfUFJPUF9VSU5UMTYoIm51bS1xdWV1
ZXMiLCBWaXJ0SU9CbG9jaywgY29uZi5udW1fcXVldWVzLAorICAgICAgICAgICAgICAgICAgICAg
ICBWSVJUSU9fQkxLX0FVVE9fTlVNX1FVRVVFUyksCiAgICAgREVGSU5FX1BST1BfVUlOVDE2KCJx
dWV1ZS1zaXplIiwgVmlydElPQmxvY2ssIGNvbmYucXVldWVfc2l6ZSwgMjU2KSwKICAgICBERUZJ
TkVfUFJPUF9CT09MKCJzZWctbWF4LWFkanVzdCIsIFZpcnRJT0Jsb2NrLCBjb25mLnNlZ19tYXhf
YWRqdXN0LCB0cnVlKSwKICAgICBERUZJTkVfUFJPUF9MSU5LKCJpb3RocmVhZCIsIFZpcnRJT0Js
b2NrLCBjb25mLmlvdGhyZWFkLCBUWVBFX0lPVEhSRUFELApkaWZmIC0tZ2l0IGEvaHcvY29yZS9t
YWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYwppbmRleCA5ZWUyYWEwZjdiLi43ZjY1ZmE4NzQz
IDEwMDY0NAotLS0gYS9ody9jb3JlL21hY2hpbmUuYworKysgYi9ody9jb3JlL21hY2hpbmUuYwpA
QCAtMzEsNiArMzEsNyBAQAogR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzVfMVtdID0gewogICAg
IHsgInZob3N0LXNjc2kiLCAibnVtX3F1ZXVlcyIsICIxIn0sCiAgICAgeyAidmhvc3QtdXNlci1z
Y3NpIiwgIm51bV9xdWV1ZXMiLCAiMSJ9LAorICAgIHsgInZpcnRpby1ibGstZGV2aWNlIiwgIm51
bS1xdWV1ZXMiLCAiMSJ9LAogICAgIHsgInZpcnRpby1zY3NpLWRldmljZSIsICJudW1fcXVldWVz
IiwgIjEifSwKIH07CiBjb25zdCBzaXplX3QgaHdfY29tcGF0XzVfMV9sZW4gPSBHX05fRUxFTUVO
VFMoaHdfY29tcGF0XzVfMSk7CmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLWJsay1wY2ku
YyBiL2h3L3ZpcnRpby92aXJ0aW8tYmxrLXBjaS5jCmluZGV4IDg0OWNjN2RmZDguLjM3YzZlMGFl
YjQgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aXJ0aW8tYmxrLXBjaS5jCisrKyBiL2h3L3ZpcnRp
by92aXJ0aW8tYmxrLXBjaS5jCkBAIC01MCw5ICs1MCwxNCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9f
YmxrX3BjaV9yZWFsaXplKFZpcnRJT1BDSVByb3h5ICp2cGNpX2RldiwgRXJyb3IgKiplcnJwKQog
ewogICAgIFZpcnRJT0Jsa1BDSSAqZGV2ID0gVklSVElPX0JMS19QQ0kodnBjaV9kZXYpOwogICAg
IERldmljZVN0YXRlICp2ZGV2ID0gREVWSUNFKCZkZXYtPnZkZXYpOworICAgIFZpcnRJT0Jsa0Nv
bmYgKmNvbmYgPSAmZGV2LT52ZGV2LmNvbmY7CisKKyAgICBpZiAoY29uZi0+bnVtX3F1ZXVlcyA9
PSBWSVJUSU9fQkxLX0FVVE9fTlVNX1FVRVVFUykgeworICAgICAgICBjb25mLT5udW1fcXVldWVz
ID0gdmlydGlvX3BjaV9vcHRpbWFsX251bV9xdWV1ZXMoMCk7CisgICAgfQogCiAgICAgaWYgKHZw
Y2lfZGV2LT5udmVjdG9ycyA9PSBERVZfTlZFQ1RPUlNfVU5TUEVDSUZJRUQpIHsKLSAgICAgICAg
dnBjaV9kZXYtPm52ZWN0b3JzID0gZGV2LT52ZGV2LmNvbmYubnVtX3F1ZXVlcyArIDE7CisgICAg
ICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IGNvbmYtPm51bV9xdWV1ZXMgKyAxOwogICAgIH0KIAog
ICAgIHFkZXZfcmVhbGl6ZSh2ZGV2LCBCVVMoJnZwY2lfZGV2LT5idXMpLCBlcnJwKTsKLS0gCjIu
MjYuMgoK


