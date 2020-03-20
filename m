Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5C8C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB852051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEhvV65A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB852051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEz3-00085R-Ik
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jFEvw-0004Nm-LN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jFEvv-0001Ax-CQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jFEvv-0001Ap-8U
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584700278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t32fXUBu3z7m4utGiErxnaXstVu42nkJQtglpvtuQh0=;
 b=fEhvV65AlgwHJsiE0hhcLnamDEZIjoprbgjIE6aAnEm6m+O6BLnDPxyeu/icoy72fyWsks
 WWHh/o+HY5jlGfdN9X5Lkeuyfk5wit1PfwqyyQ0GTeriwB0j9/ksAIb5osnSkrhk1PNNju
 QlM0OTCBEpBrGIrOfHCNJ5qpKDMD5rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-K8s1Hv7XPg6BswRa9Pec1w-1; Fri, 20 Mar 2020 06:31:17 -0400
X-MC-Unique: K8s1Hv7XPg6BswRa9Pec1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74319DB20;
 Fri, 20 Mar 2020 10:31:16 +0000 (UTC)
Received: from localhost (ovpn-114-252.ams2.redhat.com [10.36.114.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CB0D60BFB;
 Fri, 20 Mar 2020 10:31:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 3/4] virtio-blk: default num_queues to -smp N
Date: Fri, 20 Mar 2020 10:30:40 +0000
Message-Id: <20200320103041.129527-4-stefanha@redhat.com>
In-Reply-To: <20200320103041.129527-1-stefanha@redhat.com>
References: <20200320103041.129527-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QXV0b21hdGljYWxseSBzaXplIHRoZSBudW1iZXIgb2YgdmlydGlvLWJsay1wY2kgcmVxdWVzdCB2
aXJ0cXVldWVzIHRvCm1hdGNoIHRoZSBudW1iZXIgb2YgdkNQVXMuICBPdGhlciB0cmFuc3BvcnRz
IGNvbnRpbnVlIHRvIGRlZmF1bHQgdG8gMQpyZXF1ZXN0IHZpcnRxdWV1ZS4KCkEgMToxIHZpcnRx
dWV1ZTp2Q1BVIG1hcHBpbmcgZW5zdXJlcyB0aGF0IGNvbXBsZXRpb24gaW50ZXJydXB0cyBhcmUK
aGFuZGxlZCBvbiB0aGUgc2FtZSB2Q1BVIHRoYXQgc3VibWl0dGVkIHRoZSByZXF1ZXN0LiAgTm8g
SVBJIGlzCm5lY2Vzc2FyeSB0byBjb21wbGV0ZSBhbiBJL08gcmVxdWVzdCBhbmQgcGVyZm9ybWFu
Y2UgaXMgaW1wcm92ZWQuCgpQZXJmb3JtYW5jZSBpbXByb3ZlcyBmcm9tIDc4ayB0byAxMDRrIElP
UFMgb24gYSAzMiB2Q1BVIGd1ZXN0IHdpdGggMTAxCnZpcnRpby1ibGstcGNpIGRldmljZXMgKGlv
ZW5naW5lPWxpYmFpbywgaW9kZXB0aD0xLCBicz00aywgcnc9cmFuZHJlYWQKd2l0aCBOVk1lIHN0
b3JhZ2UpLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Ci0tLQog
aHcvYmxvY2svdmlydGlvLWJsay5jICAgICAgICAgIHwgNiArKysrKy0KIGh3L2NvcmUvbWFjaGlu
ZS5jICAgICAgICAgICAgICB8IDEgKwogaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMgICAgIHwg
OSArKysrKysrKy0KIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaCB8IDIgKysKIDQgZmls
ZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9ody9ibG9jay92aXJ0aW8tYmxrLmMgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMKaW5kZXggMTQy
ODYzYTNiMi4uZWQ1ZGY3MTc3OSAxMDA2NDQKLS0tIGEvaHcvYmxvY2svdmlydGlvLWJsay5jCisr
KyBiL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYwpAQCAtMTEzNSw2ICsxMTM1LDkgQEAgc3RhdGljIHZv
aWQgdmlydGlvX2Jsa19kZXZpY2VfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVy
cnApCiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkRldmljZSBuZWVkcyBtZWRpYSwgYnV0IGRy
aXZlIGlzIGVtcHR5Iik7CiAgICAgICAgIHJldHVybjsKICAgICB9CisgICAgaWYgKGNvbmYtPm51
bV9xdWV1ZXMgPT0gVklSVElPX0JMS19BVVRPX05VTV9RVUVVRVMpIHsKKyAgICAgICAgY29uZi0+
bnVtX3F1ZXVlcyA9IDE7CisgICAgfQogICAgIGlmICghY29uZi0+bnVtX3F1ZXVlcykgewogICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJudW0tcXVldWVzIHByb3BlcnR5IG11c3QgYmUgbGFyZ2Vy
IHRoYW4gMCIpOwogICAgICAgICByZXR1cm47CkBAIC0xMjcxLDcgKzEyNzQsOCBAQCBzdGF0aWMg
UHJvcGVydHkgdmlydGlvX2Jsa19wcm9wZXJ0aWVzW10gPSB7CiAjZW5kaWYKICAgICBERUZJTkVf
UFJPUF9CSVQoInJlcXVlc3QtbWVyZ2luZyIsIFZpcnRJT0Jsb2NrLCBjb25mLnJlcXVlc3RfbWVy
Z2luZywgMCwKICAgICAgICAgICAgICAgICAgICAgdHJ1ZSksCi0gICAgREVGSU5FX1BST1BfVUlO
VDE2KCJudW0tcXVldWVzIiwgVmlydElPQmxvY2ssIGNvbmYubnVtX3F1ZXVlcywgMSksCisgICAg
REVGSU5FX1BST1BfVUlOVDE2KCJudW0tcXVldWVzIiwgVmlydElPQmxvY2ssIGNvbmYubnVtX3F1
ZXVlcywKKyAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0JMS19BVVRPX05VTV9RVUVVRVMp
LAogICAgIERFRklORV9QUk9QX1VJTlQxNigicXVldWUtc2l6ZSIsIFZpcnRJT0Jsb2NrLCBjb25m
LnF1ZXVlX3NpemUsIDI1NiksCiAgICAgREVGSU5FX1BST1BfQk9PTCgic2VnLW1heC1hZGp1c3Qi
LCBWaXJ0SU9CbG9jaywgY29uZi5zZWdfbWF4X2FkanVzdCwgdHJ1ZSksCiAgICAgREVGSU5FX1BS
T1BfTElOSygiaW90aHJlYWQiLCBWaXJ0SU9CbG9jaywgY29uZi5pb3RocmVhZCwgVFlQRV9JT1RI
UkVBRCwKZGlmZiAtLWdpdCBhL2h3L2NvcmUvbWFjaGluZS5jIGIvaHcvY29yZS9tYWNoaW5lLmMK
aW5kZXggNGJiY2VjOGZiZC4uYzk5M2I4ZjQ4OSAxMDA2NDQKLS0tIGEvaHcvY29yZS9tYWNoaW5l
LmMKKysrIGIvaHcvY29yZS9tYWNoaW5lLmMKQEAgLTMxLDYgKzMxLDcgQEAKIEdsb2JhbFByb3Bl
cnR5IGh3X2NvbXBhdF80XzJbXSA9IHsKICAgICB7ICJ2aXJ0aW8tYmxrLWRldmljZSIsICJxdWV1
ZS1zaXplIiwgIjEyOCJ9LAogICAgIHsgInZpcnRpby1zY3NpLWRldmljZSIsICJ2aXJ0cXVldWVf
c2l6ZSIsICIxMjgifSwKKyAgICB7ICJ2aXJ0aW8tYmxrLWRldmljZSIsICJudW0tcXVldWVzIiwg
IjEifSwKICAgICB7ICJ2aXJ0aW8tYmxrLWRldmljZSIsICJ4LWVuYWJsZS13Y2UtaWYtY29uZmln
LXdjZSIsICJvZmYiIH0sCiAgICAgeyAidmlydGlvLWJsay1kZXZpY2UiLCAic2VnLW1heC1hZGp1
c3QiLCAib2ZmIn0sCiAgICAgeyAidmlydGlvLXNjc2ktZGV2aWNlIiwgIm51bV9xdWV1ZXMiLCAi
MSJ9LApkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMgYi9ody92aXJ0aW8v
dmlydGlvLWJsay1wY2kuYwppbmRleCBlZmIyYzIyYTFkLi5iZjYyOGRlNjc1IDEwMDY0NAotLS0g
YS9ody92aXJ0aW8vdmlydGlvLWJsay1wY2kuYworKysgYi9ody92aXJ0aW8vdmlydGlvLWJsay1w
Y2kuYwpAQCAtMTcsNiArMTcsNyBAQAogCiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgogCisjaW5j
bHVkZSAiaHcvYm9hcmRzLmgiCiAjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiCiAjaW5j
bHVkZSAiaHcvdmlydGlvL3ZpcnRpby1ibGsuaCIKICNpbmNsdWRlICJ2aXJ0aW8tcGNpLmgiCkBA
IC01MCw5ICs1MSwxNSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fYmxrX3BjaV9yZWFsaXplKFZpcnRJ
T1BDSVByb3h5ICp2cGNpX2RldiwgRXJyb3IgKiplcnJwKQogewogICAgIFZpcnRJT0Jsa1BDSSAq
ZGV2ID0gVklSVElPX0JMS19QQ0kodnBjaV9kZXYpOwogICAgIERldmljZVN0YXRlICp2ZGV2ID0g
REVWSUNFKCZkZXYtPnZkZXYpOworICAgIFZpcnRJT0Jsa0NvbmYgKmNvbmYgPSAmZGV2LT52ZGV2
LmNvbmY7CisKKyAgICAvKiAxOjEgdnEgdG8gdmNwdSBtYXBwaW5nIGlzIGlkZWFsIGJlY2F1c2Ug
aXQgYXZvaWRzIElQSXMgKi8KKyAgICBpZiAoY29uZi0+bnVtX3F1ZXVlcyA9PSBWSVJUSU9fQkxL
X0FVVE9fTlVNX1FVRVVFUykgeworICAgICAgICBjb25mLT5udW1fcXVldWVzID0gY3VycmVudF9t
YWNoaW5lLT5zbXAuY3B1czsKKyAgICB9CiAKICAgICBpZiAodnBjaV9kZXYtPm52ZWN0b3JzID09
IERFVl9OVkVDVE9SU19VTlNQRUNJRklFRCkgewotICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMg
PSBkZXYtPnZkZXYuY29uZi5udW1fcXVldWVzICsgMTsKKyAgICAgICAgdnBjaV9kZXYtPm52ZWN0
b3JzID0gY29uZi0+bnVtX3F1ZXVlcyArIDE7CiAgICAgfQogCiAgICAgcWRldl9zZXRfcGFyZW50
X2J1cyh2ZGV2LCBCVVMoJnZwY2lfZGV2LT5idXMpKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
dmlydGlvL3ZpcnRpby1ibGsuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaAppbmRl
eCAxZTYyZjg2OWIyLi40ZTVlOTAzZjRhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92
aXJ0aW8tYmxrLmgKKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oCkBAIC0zMCw2
ICszMCw4IEBAIHN0cnVjdCB2aXJ0aW9fYmxrX2luaGRyCiAgICAgdW5zaWduZWQgY2hhciBzdGF0
dXM7CiB9OwogCisjZGVmaW5lIFZJUlRJT19CTEtfQVVUT19OVU1fUVVFVUVTIFVJTlQxNl9NQVgK
Kwogc3RydWN0IFZpcnRJT0Jsa0NvbmYKIHsKICAgICBCbG9ja0NvbmYgY29uZjsKLS0gCjIuMjQu
MQoK


