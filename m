Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B06C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7942311A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjf/9pE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7942311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTBH-0001fd-2Y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyn-00069S-JH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyl-0003uf-HL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/i7M8x0JtS+aV98vuz04DrGNw45KYP2zPxbS/98mBc=;
 b=Fjf/9pE6mDuv5eh6p5ux4ead5I2pHvZ7NbYuq36PcOVLO6jSUxEjKqedfgv/uXHAF0+Fvn
 p5F9qyJjtKQS51pXSiT4K01bnBoWaQGWgBL550vpzf8rjN0//90ZVneIjwe82mycglCwN+
 sSru2bOljURVMPCOXO0fCNz9LmmjvcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-uACrMnFCOV-Z175BO-_dzw-1; Thu, 24 Sep 2020 11:16:09 -0400
X-MC-Unique: uACrMnFCOV-Z175BO-_dzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0A8802B4A;
 Thu, 24 Sep 2020 15:16:08 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC235C1DC;
 Thu, 24 Sep 2020 15:16:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/13] block/export: consolidate request structs into
 VuBlockReq
Date: Thu, 24 Sep 2020 16:15:41 +0100
Message-Id: <20200924151549.913737-6-stefanha@redhat.com>
In-Reply-To: <20200924151549.913737-1-stefanha@redhat.com>
References: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T25seSBvbmUgc3RydWN0IGlzIG5lZWRlZCBwZXIgcmVxdWVzdC4gRHJvcCByZXFfZGF0YSBhbmQg
dGhlIHNlcGFyYXRlClZ1QmxvY2tSZXEgaW5zdGFuY2UuIEluc3RlYWQgbGV0IHZ1X3F1ZXVlX3Bv
cCgpIGFsbG9jYXRlIGV2ZXJ5dGhpbmcgYXQKb25jZS4KClRoaXMgZml4ZXMgdGhlIHJlcV9kYXRh
IG1lbW9yeSBsZWFrIGluIHZ1X2Jsb2NrX3ZpcnRpb19wcm9jZXNzX3JlcSgpLgoKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGJsb2NrL2V4
cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyB8IDY4ICsrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA0NyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgYi9ibG9j
ay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKaW5kZXggZmI3NzY0YTczMC4uZWYwN2E4
N2ViMSAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCisr
KyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwpAQCAtMjUsNyArMjUsNyBA
QCBzdHJ1Y3QgdmlydGlvX2Jsa19pbmhkciB7CiB9OwogCiB0eXBlZGVmIHN0cnVjdCBWdUJsb2Nr
UmVxIHsKLSAgICBWdVZpcnRxRWxlbWVudCAqZWxlbTsKKyAgICBWdVZpcnRxRWxlbWVudCBlbGVt
OwogICAgIGludDY0X3Qgc2VjdG9yX251bTsKICAgICBzaXplX3Qgc2l6ZTsKICAgICBzdHJ1Y3Qg
dmlydGlvX2Jsa19pbmhkciAqaW47CkBAIC0zOSwxNCArMzksMTAgQEAgc3RhdGljIHZvaWQgdnVf
YmxvY2tfcmVxX2NvbXBsZXRlKFZ1QmxvY2tSZXEgKnJlcSkKICAgICBWdURldiAqdnVfZGV2ID0g
JnJlcS0+c2VydmVyLT52dV9kZXY7CiAKICAgICAvKiBJTyBzaXplIHdpdGggMSBleHRyYSBzdGF0
dXMgYnl0ZSAqLwotICAgIHZ1X3F1ZXVlX3B1c2godnVfZGV2LCByZXEtPnZxLCByZXEtPmVsZW0s
IHJlcS0+c2l6ZSArIDEpOworICAgIHZ1X3F1ZXVlX3B1c2godnVfZGV2LCByZXEtPnZxLCAmcmVx
LT5lbGVtLCByZXEtPnNpemUgKyAxKTsKICAgICB2dV9xdWV1ZV9ub3RpZnkodnVfZGV2LCByZXEt
PnZxKTsKIAotICAgIGlmIChyZXEtPmVsZW0pIHsKLSAgICAgICAgZnJlZShyZXEtPmVsZW0pOwot
ICAgIH0KLQotICAgIGdfZnJlZShyZXEpOworICAgIGZyZWUocmVxKTsKIH0KIAogc3RhdGljIFZ1
QmxvY2tEZXYgKmdldF92dV9ibG9ja19kZXZpY2VfYnlfc2VydmVyKFZ1U2VydmVyICpzZXJ2ZXIp
CkBAIC04OSwyMCArODUsMTIgQEAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIHZ1X2Jsb2NrX2Zs
dXNoKFZ1QmxvY2tSZXEgKnJlcSkKICAgICBibGtfY29fZmx1c2goYmFja2VuZCk7CiB9CiAKLXN0
cnVjdCByZXFfZGF0YSB7Ci0gICAgVnVTZXJ2ZXIgKnNlcnZlcjsKLSAgICBWdVZpcnRxICp2cTsK
LSAgICBWdVZpcnRxRWxlbWVudCAqZWxlbTsKLX07Ci0KIHN0YXRpYyB2b2lkIGNvcm91dGluZV9m
biB2dV9ibG9ja192aXJ0aW9fcHJvY2Vzc19yZXEodm9pZCAqb3BhcXVlKQogewotICAgIHN0cnVj
dCByZXFfZGF0YSAqZGF0YSA9IG9wYXF1ZTsKLSAgICBWdVNlcnZlciAqc2VydmVyID0gZGF0YS0+
c2VydmVyOwotICAgIFZ1VmlydHEgKnZxID0gZGF0YS0+dnE7Ci0gICAgVnVWaXJ0cUVsZW1lbnQg
KmVsZW0gPSBkYXRhLT5lbGVtOworICAgIFZ1QmxvY2tSZXEgKnJlcSA9IG9wYXF1ZTsKKyAgICBW
dVNlcnZlciAqc2VydmVyID0gcmVxLT5zZXJ2ZXI7CisgICAgVnVWaXJ0cUVsZW1lbnQgKmVsZW0g
PSAmcmVxLT5lbGVtOwogICAgIHVpbnQzMl90IHR5cGU7Ci0gICAgVnVCbG9ja1JlcSAqcmVxOwog
CiAgICAgVnVCbG9ja0RldiAqdmRldl9ibGsgPSBnZXRfdnVfYmxvY2tfZGV2aWNlX2J5X3NlcnZl
cihzZXJ2ZXIpOwogICAgIEJsb2NrQmFja2VuZCAqYmFja2VuZCA9IHZkZXZfYmxrLT5iYWNrZW5k
OwpAQCAtMTExLDE4ICs5OSwxMyBAQCBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gdnVfYmxvY2tf
dmlydGlvX3Byb2Nlc3NfcmVxKHZvaWQgKm9wYXF1ZSkKICAgICBzdHJ1Y3QgaW92ZWMgKm91dF9p
b3YgPSBlbGVtLT5vdXRfc2c7CiAgICAgdW5zaWduZWQgaW5fbnVtID0gZWxlbS0+aW5fbnVtOwog
ICAgIHVuc2lnbmVkIG91dF9udW0gPSBlbGVtLT5vdXRfbnVtOworCiAgICAgLyogcmVmZXIgdG8g
aHcvYmxvY2svdmlydGlvX2Jsay5jICovCiAgICAgaWYgKGVsZW0tPm91dF9udW0gPCAxIHx8IGVs
ZW0tPmluX251bSA8IDEpIHsKICAgICAgICAgZXJyb3JfcmVwb3J0KCJ2aXJ0aW8tYmxrIHJlcXVl
c3QgbWlzc2luZyBoZWFkZXJzIik7Ci0gICAgICAgIGZyZWUoZWxlbSk7Ci0gICAgICAgIHJldHVy
bjsKKyAgICAgICAgZ290byBlcnI7CiAgICAgfQogCi0gICAgcmVxID0gZ19uZXcwKFZ1QmxvY2tS
ZXEsIDEpOwotICAgIHJlcS0+c2VydmVyID0gc2VydmVyOwotICAgIHJlcS0+dnEgPSB2cTsKLSAg
ICByZXEtPmVsZW0gPSBlbGVtOwotCiAgICAgaWYgKHVubGlrZWx5KGlvdl90b19idWYob3V0X2lv
diwgb3V0X251bSwgMCwgJnJlcS0+b3V0LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNp
emVvZihyZXEtPm91dCkpICE9IHNpemVvZihyZXEtPm91dCkpKSB7CiAgICAgICAgIGVycm9yX3Jl
cG9ydCgidmlydGlvLWJsayByZXF1ZXN0IG91dGhkciB0b28gc2hvcnQiKTsKQEAgLTIwMiwzNiAr
MTg1LDI3IEBAIHN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiB2dV9ibG9ja192aXJ0aW9fcHJvY2Vz
c19yZXEodm9pZCAqb3BhcXVlKQogCiBlcnI6CiAgICAgZnJlZShlbGVtKTsKLSAgICBnX2ZyZWUo
cmVxKTsKLSAgICByZXR1cm47CiB9CiAKIHN0YXRpYyB2b2lkIHZ1X2Jsb2NrX3Byb2Nlc3NfdnEo
VnVEZXYgKnZ1X2RldiwgaW50IGlkeCkKIHsKLSAgICBWdVNlcnZlciAqc2VydmVyOwotICAgIFZ1
VmlydHEgKnZxOwotICAgIHN0cnVjdCByZXFfZGF0YSAqcmVxX2RhdGE7CisgICAgVnVTZXJ2ZXIg
KnNlcnZlciA9IGNvbnRhaW5lcl9vZih2dV9kZXYsIFZ1U2VydmVyLCB2dV9kZXYpOworICAgIFZ1
VmlydHEgKnZxID0gdnVfZ2V0X3F1ZXVlKHZ1X2RldiwgaWR4KTsKIAotICAgIHNlcnZlciA9IGNv
bnRhaW5lcl9vZih2dV9kZXYsIFZ1U2VydmVyLCB2dV9kZXYpOwotICAgIGFzc2VydChzZXJ2ZXIp
OwotCi0gICAgdnEgPSB2dV9nZXRfcXVldWUodnVfZGV2LCBpZHgpOwotICAgIGFzc2VydCh2cSk7
Ci0gICAgVnVWaXJ0cUVsZW1lbnQgKmVsZW07CiAgICAgd2hpbGUgKDEpIHsKLSAgICAgICAgZWxl
bSA9IHZ1X3F1ZXVlX3BvcCh2dV9kZXYsIHZxLCBzaXplb2YoVnVWaXJ0cUVsZW1lbnQpICsKLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihWdUJsb2NrUmVxKSk7Ci0g
ICAgICAgIGlmIChlbGVtKSB7Ci0gICAgICAgICAgICByZXFfZGF0YSA9IGdfbmV3MChzdHJ1Y3Qg
cmVxX2RhdGEsIDEpOwotICAgICAgICAgICAgcmVxX2RhdGEtPnNlcnZlciA9IHNlcnZlcjsKLSAg
ICAgICAgICAgIHJlcV9kYXRhLT52cSA9IHZxOwotICAgICAgICAgICAgcmVxX2RhdGEtPmVsZW0g
PSBlbGVtOwotICAgICAgICAgICAgQ29yb3V0aW5lICpjbyA9IHFlbXVfY29yb3V0aW5lX2NyZWF0
ZSh2dV9ibG9ja192aXJ0aW9fcHJvY2Vzc19yZXEsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlcV9kYXRhKTsKLSAgICAgICAgICAgIGFpb19jb19l
bnRlcihzZXJ2ZXItPmlvYy0+Y3R4LCBjbyk7Ci0gICAgICAgIH0gZWxzZSB7CisgICAgICAgIFZ1
QmxvY2tSZXEgKnJlcTsKKworICAgICAgICByZXEgPSB2dV9xdWV1ZV9wb3AodnVfZGV2LCB2cSwg
c2l6ZW9mKFZ1QmxvY2tSZXEpKTsKKyAgICAgICAgaWYgKCFyZXEpIHsKICAgICAgICAgICAgIGJy
ZWFrOwogICAgICAgICB9CisKKyAgICAgICAgcmVxLT5zZXJ2ZXIgPSBzZXJ2ZXI7CisgICAgICAg
IHJlcS0+dnEgPSB2cTsKKworICAgICAgICBDb3JvdXRpbmUgKmNvID0KKyAgICAgICAgICAgIHFl
bXVfY29yb3V0aW5lX2NyZWF0ZSh2dV9ibG9ja192aXJ0aW9fcHJvY2Vzc19yZXEsIHJlcSk7Cisg
ICAgICAgIHFlbXVfY29yb3V0aW5lX2VudGVyKGNvKTsKICAgICB9CiB9CiAKLS0gCjIuMjYuMgoK


