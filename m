Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02CC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789D020706
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPp9irZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789D020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdAN-0008Nd-Ij
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZd9O-0007gw-GL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:57:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZd9L-0004ZO-UR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604336261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NHphSXYVwPdSG864F+F8ulYN+k1TQTXyLvb8Pe0RQAg=;
 b=fPp9irZ5aveBGAgHabemVVXLE3j84cMVcLwaqPXv3CO7QHLNs/VIdUl/U9lqTTLziyFpdw
 bZjhfw5JETAmKQMg2VqaowFRfs4LbvMdwWbTOTmUaxZP8MMrxkjAxG/6MvEAGsGsc+aIip
 AarohLKbJzZ4OuUAkcQ9LmYCyV7qYyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-FMShhmYQPlqiMOaHp0q_zA-1; Mon, 02 Nov 2020 11:57:38 -0500
X-MC-Unique: FMShhmYQPlqiMOaHp0q_zA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 253B581F03A;
 Mon,  2 Nov 2020 16:57:29 +0000 (UTC)
Received: from localhost (ovpn-114-65.ams2.redhat.com [10.36.114.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6CAF81F58;
 Mon,  2 Nov 2020 16:57:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Revert "vhost-blk: set features before setting inflight
 feature"
Date: Mon,  2 Nov 2020 16:57:09 +0000
Message-Id: <20201102165709.232180-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jin Yu <jin.yu@intel.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyByZXZlcnRzIGNvbW1pdCBhZGIyOWMwMjczNDFiYTA5NWEzZWY0YmVlZjZhYWVmODZkM2E1
MjBlLgoKVGhlIGNvbW1pdCBicm9rZSAtZGV2aWNlIHZob3N0LXVzZXItYmxrLXBjaSBiZWNhdXNl
IHRoZQp2aG9zdF9kZXZfcHJlcGFyZV9pbmZsaWdodCgpIGZ1bmN0aW9uIGl0IGludHJvZHVjZWQg
c2VnZmF1bHRzIGluCnZob3N0X2Rldl9zZXRfZmVhdHVyZXMoKSB3aGVuIGF0dGVtcHRpbmcgdG8g
YWNjZXNzIHN0cnVjdCB2aG9zdF9kZXYncwp2ZGV2IHBvaW50ZXIgYmVmb3JlIGl0IGhhcyBiZWVu
IGFzc2lnbmVkLgoKVG8gcmVwcm9kdWNlIHRoZSBzZWdmYXVsdCBzaW1wbHkgbGF1bmNoIGEgdmhv
c3QtdXNlci1ibGsgZGV2aWNlIHdpdGggdGhlCmNvbnRyaWIgdmhvc3QtdXNlci1ibGsgZGV2aWNl
IGJhY2tlbmQ6CgogICQgYnVpbGQvY29udHJpYi92aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJs
ayAtcyAvdG1wL3Zob3N0LXVzZXItYmxrLnNvY2sgLXIgLWIgL3Zhci90bXAvZm9vLmltZwogICQg
YnVpbGQvcWVtdS1zeXN0ZW0teDg2XzY0IFwKICAgICAgICAtZGV2aWNlIHZob3N0LXVzZXItYmxr
LXBjaSxpZD1kcnYwLGNoYXJkZXY9Y2hhcjEsYWRkcj00LjAgXAogICAgICAgIC1vYmplY3QgbWVt
b3J5LWJhY2tlbmQtbWVtZmQsaWQ9bWVtLHNpemU9MUcsc2hhcmU9b24gXAogICAgICAgIC1NIG1l
bW9yeS1iYWNrZW5kPW1lbSxhY2NlbD1rdm0gXAogICAgICAgIC1jaGFyZGV2IHNvY2tldCxpZD1j
aGFyMSxwYXRoPS90bXAvdmhvc3QtdXNlci1ibGsuc29jawogIFNlZ21lbnRhdGlvbiBmYXVsdCAo
Y29yZSBkdW1wZWQpCgpDYzogSmluIFl1IDxqaW4ueXVAaW50ZWwuY29tPgpDYzogUmFwaGFlbCBO
b3J3aXR6IDxyYXBoYWVsLm5vcndpdHpAbnV0YW5peC5jb20+CkNjOiBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaCB8ICAxIC0KIGh3
L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgfCAgNiAtLS0tLS0KIGh3L3ZpcnRpby92aG9zdC5jICAg
ICAgICAgfCAxOCAtLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMjUgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaCBiL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LmgKaW5kZXggODM5YmZiMTUzYy4uOTQ1ODUwNjdmNyAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaAorKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9z
dC5oCkBAIC0xNDEsNyArMTQxLDYgQEAgdm9pZCB2aG9zdF9kZXZfcmVzZXRfaW5mbGlnaHQoc3Ry
dWN0IHZob3N0X2luZmxpZ2h0ICppbmZsaWdodCk7CiB2b2lkIHZob3N0X2Rldl9mcmVlX2luZmxp
Z2h0KHN0cnVjdCB2aG9zdF9pbmZsaWdodCAqaW5mbGlnaHQpOwogdm9pZCB2aG9zdF9kZXZfc2F2
ZV9pbmZsaWdodChzdHJ1Y3Qgdmhvc3RfaW5mbGlnaHQgKmluZmxpZ2h0LCBRRU1VRmlsZSAqZik7
CiBpbnQgdmhvc3RfZGV2X2xvYWRfaW5mbGlnaHQoc3RydWN0IHZob3N0X2luZmxpZ2h0ICppbmZs
aWdodCwgUUVNVUZpbGUgKmYpOwotaW50IHZob3N0X2Rldl9wcmVwYXJlX2luZmxpZ2h0KHN0cnVj
dCB2aG9zdF9kZXYgKmhkZXYpOwogaW50IHZob3N0X2Rldl9zZXRfaW5mbGlnaHQoc3RydWN0IHZo
b3N0X2RldiAqZGV2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X2lu
ZmxpZ2h0ICppbmZsaWdodCk7CiBpbnQgdmhvc3RfZGV2X2dldF9pbmZsaWdodChzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYsIHVpbnQxNl90IHF1ZXVlX3NpemUsCmRpZmYgLS1naXQgYS9ody9ibG9jay92
aG9zdC11c2VyLWJsay5jIGIvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYwppbmRleCBmNjdiMjli
YmYzLi5hMDc2YjFlNTRkIDEwMDY0NAotLS0gYS9ody9ibG9jay92aG9zdC11c2VyLWJsay5jCisr
KyBiL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMKQEAgLTEzMSwxMiArMTMxLDYgQEAgc3RhdGlj
IGludCB2aG9zdF91c2VyX2Jsa19zdGFydChWaXJ0SU9EZXZpY2UgKnZkZXYpCiAKICAgICBzLT5k
ZXYuYWNrZWRfZmVhdHVyZXMgPSB2ZGV2LT5ndWVzdF9mZWF0dXJlczsKIAotICAgIHJldCA9IHZo
b3N0X2Rldl9wcmVwYXJlX2luZmxpZ2h0KCZzLT5kZXYpOwotICAgIGlmIChyZXQgPCAwKSB7Ci0g
ICAgICAgIGVycm9yX3JlcG9ydCgiRXJyb3Igc2V0IGluZmxpZ2h0IGZvcm1hdDogJWQiLCAtcmV0
KTsKLSAgICAgICAgZ290byBlcnJfZ3Vlc3Rfbm90aWZpZXJzOwotICAgIH0KLQogICAgIGlmICgh
cy0+aW5mbGlnaHQtPmFkZHIpIHsKICAgICAgICAgcmV0ID0gdmhvc3RfZGV2X2dldF9pbmZsaWdo
dCgmcy0+ZGV2LCBzLT5xdWV1ZV9zaXplLCBzLT5pbmZsaWdodCk7CiAgICAgICAgIGlmIChyZXQg
PCAwKSB7CmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QuYyBiL2h3L3ZpcnRpby92aG9zdC5j
CmluZGV4IGYyNDgyMzc4YzYuLjc5YjJiZTIwZGYgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aG9z
dC5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC5jCkBAIC0xNjQ1LDI0ICsxNjQ1LDYgQEAgaW50IHZo
b3N0X2Rldl9sb2FkX2luZmxpZ2h0KHN0cnVjdCB2aG9zdF9pbmZsaWdodCAqaW5mbGlnaHQsIFFF
TVVGaWxlICpmKQogICAgIHJldHVybiAwOwogfQogCi1pbnQgdmhvc3RfZGV2X3ByZXBhcmVfaW5m
bGlnaHQoc3RydWN0IHZob3N0X2RldiAqaGRldikKLXsKLSAgICBpbnQgcjsKLSAKLSAgICBpZiAo
aGRldi0+dmhvc3Rfb3BzLT52aG9zdF9nZXRfaW5mbGlnaHRfZmQgPT0gTlVMTCB8fAotICAgICAg
ICBoZGV2LT52aG9zdF9vcHMtPnZob3N0X3NldF9pbmZsaWdodF9mZCA9PSBOVUxMKSB7Ci0gICAg
ICAgIHJldHVybiAwOwotICAgIH0KLSAKLSAgICByID0gdmhvc3RfZGV2X3NldF9mZWF0dXJlcyho
ZGV2LCBoZGV2LT5sb2dfZW5hYmxlZCk7Ci0gICAgaWYgKHIgPCAwKSB7Ci0gICAgICAgIFZIT1NU
X09QU19ERUJVRygidmhvc3RfZGV2X3ByZXBhcmVfaW5mbGlnaHQgZmFpbGVkIik7Ci0gICAgICAg
IHJldHVybiByOwotICAgIH0KLQotICAgIHJldHVybiAwOwotfQotCiBpbnQgdmhvc3RfZGV2X3Nl
dF9pbmZsaWdodChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgdmhvc3RfaW5mbGlnaHQgKmluZmxpZ2h0KQogewotLSAKMi4yOC4wCgo=


