Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00200C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1134207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9SjVUSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1134207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtLH-0000xh-U2
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJz-0007Z9-PU
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:30:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJy-0001CZ-Li
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pa/qQynYZGINjd9y7NjySQLorQMMjExiLlZQH3LPVAk=;
 b=Y9SjVUSoVsWol8wGhN5r6tLEk17I8/+aCdARh4S5FWJ9KcuyRwXuvO9ULGvtb3zwcptYv+
 NvzRCh2ddM401QTDcmfFrcQFMEvp12ilU7kHKdKPCjXvRMOoU/59WkAxVwoAo6lg7lrjs4
 1q4GqGKldiRlh9qvNnv40aBLIURx3iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-ypCzrAdiPACj_Qh2pWhAXQ-1; Wed, 27 May 2020 06:29:57 -0400
X-MC-Unique: ypCzrAdiPACj_Qh2pWhAXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6DA18FE863;
 Wed, 27 May 2020 10:29:56 +0000 (UTC)
Received: from localhost (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A8815C1B0;
 Wed, 27 May 2020 10:29:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/5] virtio-blk: default num_queues to -smp N
Date: Wed, 27 May 2020 11:29:24 +0100
Message-Id: <20200527102925.128013-5-stefanha@redhat.com>
In-Reply-To: <20200527102925.128013-1-stefanha@redhat.com>
References: <20200527102925.128013-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
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
Y2UgaXMgaW1wcm92ZWQuCgpQZXJmb3JtYW5jZSBpbXByb3ZlcyBmcm9tIDc4ayB0byAxMDRrIElP
UFMgb24gYSAzMiB2Q1BVIGd1ZXN0IHdpdGggMTAxCnZpcnRpby1ibGstcGNpIGRldmljZXMgKGlv
ZW5naW5lPWxpYmFpbywgaW9kZXB0aD0xLCBicz00aywgcnc9cmFuZHJlYWQKd2l0aCBOVk1lIHN0
b3JhZ2UpLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Ci0tLQog
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oIHwgMiArKwogaHcvYmxvY2svdmlydGlvLWJs
ay5jICAgICAgICAgIHwgNiArKysrKy0KIGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAgICAgICB8
IDEgKwogaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMgICAgIHwgNyArKysrKystCiA0IGZpbGVz
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlv
LWJsay5oCmluZGV4IDFlNjJmODY5YjIuLjRlNWU5MDNmNGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
aHcvdmlydGlvL3ZpcnRpby1ibGsuaAorKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYmxr
LmgKQEAgLTMwLDYgKzMwLDggQEAgc3RydWN0IHZpcnRpb19ibGtfaW5oZHIKICAgICB1bnNpZ25l
ZCBjaGFyIHN0YXR1czsKIH07CiAKKyNkZWZpbmUgVklSVElPX0JMS19BVVRPX05VTV9RVUVVRVMg
VUlOVDE2X01BWAorCiBzdHJ1Y3QgVmlydElPQmxrQ29uZgogewogICAgIEJsb2NrQ29uZiBjb25m
OwpkaWZmIC0tZ2l0IGEvaHcvYmxvY2svdmlydGlvLWJsay5jIGIvaHcvYmxvY2svdmlydGlvLWJs
ay5jCmluZGV4IGY1ZjZmYzkyNWUuLjNjMzZiMzgyNTUgMTAwNjQ0Ci0tLSBhL2h3L2Jsb2NrL3Zp
cnRpby1ibGsuYworKysgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMKQEAgLTExMzUsNiArMTEzNSw5
IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19ibGtfZGV2aWNlX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRl
diwgRXJyb3IgKiplcnJwKQogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJEZXZpY2UgbmVlZHMg
bWVkaWEsIGJ1dCBkcml2ZSBpcyBlbXB0eSIpOwogICAgICAgICByZXR1cm47CiAgICAgfQorICAg
IGlmIChjb25mLT5udW1fcXVldWVzID09IFZJUlRJT19CTEtfQVVUT19OVU1fUVVFVUVTKSB7Cisg
ICAgICAgIGNvbmYtPm51bV9xdWV1ZXMgPSAxOworICAgIH0KICAgICBpZiAoIWNvbmYtPm51bV9x
dWV1ZXMpIHsKICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAibnVtLXF1ZXVlcyBwcm9wZXJ0eSBt
dXN0IGJlIGxhcmdlciB0aGFuIDAiKTsKICAgICAgICAgcmV0dXJuOwpAQCAtMTI3NCw3ICsxMjc3
LDggQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19ibGtfcHJvcGVydGllc1tdID0gewogI2VuZGlm
CiAgICAgREVGSU5FX1BST1BfQklUKCJyZXF1ZXN0LW1lcmdpbmciLCBWaXJ0SU9CbG9jaywgY29u
Zi5yZXF1ZXN0X21lcmdpbmcsIDAsCiAgICAgICAgICAgICAgICAgICAgIHRydWUpLAotICAgIERF
RklORV9QUk9QX1VJTlQxNigibnVtLXF1ZXVlcyIsIFZpcnRJT0Jsb2NrLCBjb25mLm51bV9xdWV1
ZXMsIDEpLAorICAgIERFRklORV9QUk9QX1VJTlQxNigibnVtLXF1ZXVlcyIsIFZpcnRJT0Jsb2Nr
LCBjb25mLm51bV9xdWV1ZXMsCisgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19CTEtfQVVU
T19OVU1fUVVFVUVTKSwKICAgICBERUZJTkVfUFJPUF9VSU5UMTYoInF1ZXVlLXNpemUiLCBWaXJ0
SU9CbG9jaywgY29uZi5xdWV1ZV9zaXplLCAyNTYpLAogICAgIERFRklORV9QUk9QX0JPT0woInNl
Zy1tYXgtYWRqdXN0IiwgVmlydElPQmxvY2ssIGNvbmYuc2VnX21heF9hZGp1c3QsIHRydWUpLAog
ICAgIERFRklORV9QUk9QX0xJTksoImlvdGhyZWFkIiwgVmlydElPQmxvY2ssIGNvbmYuaW90aHJl
YWQsIFRZUEVfSU9USFJFQUQsCmRpZmYgLS1naXQgYS9ody9jb3JlL21hY2hpbmUuYyBiL2h3L2Nv
cmUvbWFjaGluZS5jCmluZGV4IGRmNzY2NGJjOGQuLjRhYmEzYmRkM2MgMTAwNjQ0Ci0tLSBhL2h3
L2NvcmUvbWFjaGluZS5jCisrKyBiL2h3L2NvcmUvbWFjaGluZS5jCkBAIC0yOSw2ICsyOSw3IEBA
CiAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIKIAogR2xvYmFsUHJvcGVydHkgaHdfY29t
cGF0XzVfMFtdID0geworICAgIHsgInZpcnRpby1ibGstZGV2aWNlIiwgIm51bS1xdWV1ZXMiLCAi
MSJ9LAogICAgIHsgInZpcnRpby1zY3NpLWRldmljZSIsICJudW1fcXVldWVzIiwgIjEifSwKICAg
ICB7ICJ2aG9zdC1zY3NpIiwgIm51bV9xdWV1ZXMiLCAiMSJ9LAogICAgIHsgInZob3N0LXVzZXIt
c2NzaSIsICJudW1fcXVldWVzIiwgIjEifSwKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8t
YmxrLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMKaW5kZXggMjg4MzhmYTk1OC4u
MmYwZWRlMzg2MyAxMDA2NDQKLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMKKysrIGIv
aHcvdmlydGlvL3ZpcnRpby1ibGstcGNpLmMKQEAgLTUwLDkgKzUwLDE0IEBAIHN0YXRpYyB2b2lk
IHZpcnRpb19ibGtfcGNpX3JlYWxpemUoVmlydElPUENJUHJveHkgKnZwY2lfZGV2LCBFcnJvciAq
KmVycnApCiB7CiAgICAgVmlydElPQmxrUENJICpkZXYgPSBWSVJUSU9fQkxLX1BDSSh2cGNpX2Rl
dik7CiAgICAgRGV2aWNlU3RhdGUgKnZkZXYgPSBERVZJQ0UoJmRldi0+dmRldik7CisgICAgVmly
dElPQmxrQ29uZiAqY29uZiA9ICZkZXYtPnZkZXYuY29uZjsKKworICAgIGlmIChjb25mLT5udW1f
cXVldWVzID09IFZJUlRJT19CTEtfQVVUT19OVU1fUVVFVUVTKSB7CisgICAgICAgIGNvbmYtPm51
bV9xdWV1ZXMgPSB2aXJ0aW9fcGNpX29wdGltYWxfbnVtX3F1ZXVlcygwKTsKKyAgICB9CiAKICAg
ICBpZiAodnBjaV9kZXYtPm52ZWN0b3JzID09IERFVl9OVkVDVE9SU19VTlNQRUNJRklFRCkgewot
ICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSBkZXYtPnZkZXYuY29uZi5udW1fcXVldWVzICsg
MTsKKyAgICAgICAgdnBjaV9kZXYtPm52ZWN0b3JzID0gY29uZi0+bnVtX3F1ZXVlcyArIDE7CiAg
ICAgfQogCiAgICAgcWRldl9zZXRfcGFyZW50X2J1cyh2ZGV2LCBCVVMoJnZwY2lfZGV2LT5idXMp
KTsKLS0gCjIuMjUuNAoK


