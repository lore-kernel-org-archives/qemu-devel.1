Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8539C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941FF2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1cpEBua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941FF2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRdP-0003LA-Rc
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcY-0001ki-9L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34367
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsRcW-0006Ty-Dc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594043839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVN2UUFevJOMtkf6B6bMrWRFpyvoNches0VgABND0vw=;
 b=O1cpEBuaXTA4J9g0qb0T4LmyjLo7jUc3jK/2MI9FUAlGWA0rBdD4SP5NgS+B+NjH5Dx7LT
 drToZufIrmzSRsnOV/T/dNd9ckyRB2Pw969PdILaco5Ya9V1CTNjuf49F606zGtYQd+baW
 oW4lv19NZxA43zh+h7OjsOKn5eA/Q1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-4bs0ONVuO325tjyu6MJC9w-1; Mon, 06 Jul 2020 09:57:18 -0400
X-MC-Unique: 4bs0ONVuO325tjyu6MJC9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A38D64AD9;
 Mon,  6 Jul 2020 13:57:17 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 324AD60BEC;
 Mon,  6 Jul 2020 13:57:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/5] virtio-blk: default num_queues to -smp N
Date: Mon,  6 Jul 2020 14:56:49 +0100
Message-Id: <20200706135650.438362-5-stefanha@redhat.com>
In-Reply-To: <20200706135650.438362-1-stefanha@redhat.com>
References: <20200706135650.438362-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
YWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYwppbmRleCAzZGY1MzQ0MDViLi44NDVmNjQ3NmNi
IDEwMDY0NAotLS0gYS9ody9jb3JlL21hY2hpbmUuYworKysgYi9ody9jb3JlL21hY2hpbmUuYwpA
QCAtMzIsNiArMzIsNyBAQCBHbG9iYWxQcm9wZXJ0eSBod19jb21wYXRfNV8wW10gPSB7CiAgICAg
eyAidmhvc3Qtc2NzaSIsICJudW1fcXVldWVzIiwgIjEifSwKICAgICB7ICJ2aG9zdC11c2VyLXNj
c2kiLCAibnVtX3F1ZXVlcyIsICIxIn0sCiAgICAgeyAidmlydGlvLWJhbGxvb24tZGV2aWNlIiwg
InBhZ2UtcG9pc29uIiwgImZhbHNlIiB9LAorICAgIHsgInZpcnRpby1ibGstZGV2aWNlIiwgIm51
bS1xdWV1ZXMiLCAiMSJ9LAogICAgIHsgInZpcnRpby1zY3NpLWRldmljZSIsICJudW1fcXVldWVz
IiwgIjEifSwKICAgICB7ICJ2bXBvcnQiLCAieC1yZWFkLXNldC1lYXgiLCAib2ZmIiB9LAogICAg
IHsgInZtcG9ydCIsICJ4LXNpZ25hbC11bnN1cHBvcnRlZC1jbWQiLCAib2ZmIiB9LApkaWZmIC0t
Z2l0IGEvaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMgYi9ody92aXJ0aW8vdmlydGlvLWJsay1w
Y2kuYwppbmRleCA4NDljYzdkZmQ4Li4zN2M2ZTBhZWI0IDEwMDY0NAotLS0gYS9ody92aXJ0aW8v
dmlydGlvLWJsay1wY2kuYworKysgYi9ody92aXJ0aW8vdmlydGlvLWJsay1wY2kuYwpAQCAtNTAs
OSArNTAsMTQgQEAgc3RhdGljIHZvaWQgdmlydGlvX2Jsa19wY2lfcmVhbGl6ZShWaXJ0SU9QQ0lQ
cm94eSAqdnBjaV9kZXYsIEVycm9yICoqZXJycCkKIHsKICAgICBWaXJ0SU9CbGtQQ0kgKmRldiA9
IFZJUlRJT19CTEtfUENJKHZwY2lfZGV2KTsKICAgICBEZXZpY2VTdGF0ZSAqdmRldiA9IERFVklD
RSgmZGV2LT52ZGV2KTsKKyAgICBWaXJ0SU9CbGtDb25mICpjb25mID0gJmRldi0+dmRldi5jb25m
OworCisgICAgaWYgKGNvbmYtPm51bV9xdWV1ZXMgPT0gVklSVElPX0JMS19BVVRPX05VTV9RVUVV
RVMpIHsKKyAgICAgICAgY29uZi0+bnVtX3F1ZXVlcyA9IHZpcnRpb19wY2lfb3B0aW1hbF9udW1f
cXVldWVzKDApOworICAgIH0KIAogICAgIGlmICh2cGNpX2Rldi0+bnZlY3RvcnMgPT0gREVWX05W
RUNUT1JTX1VOU1BFQ0lGSUVEKSB7Ci0gICAgICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IGRldi0+
dmRldi5jb25mLm51bV9xdWV1ZXMgKyAxOworICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSBj
b25mLT5udW1fcXVldWVzICsgMTsKICAgICB9CiAKICAgICBxZGV2X3JlYWxpemUodmRldiwgQlVT
KCZ2cGNpX2Rldi0+YnVzKSwgZXJycCk7Ci0tIAoyLjI2LjIKCg==


