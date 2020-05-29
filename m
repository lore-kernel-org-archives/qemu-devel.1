Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2EBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BDC20897
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOapio/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BDC20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeher-0007QK-NQ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jehdt-0006uE-19
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:13:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jehdr-00028R-Mp
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590768834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6dFsTSQtluTSTZuB0y/nh90yEdfmymhfTWqxDXaKFLk=;
 b=hOapio/+jBkYTfIwRFl2TUVOEQQwXo1J05NQp0HDh1yK1zQPds0nT/51j1ln9j6HE7eeJz
 XzfNzddpR497MSe4mIS4QuneyE/V33W+WTPxLbJvI6LWPutOESGqbegBp39uNH/94xXgaz
 teT7KdQhmI26M0E95QafyAO37SToOHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-dDalw0wzM8m24kPnwxJ_SQ-1; Fri, 29 May 2020 12:13:52 -0400
X-MC-Unique: dDalw0wzM8m24kPnwxJ_SQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDFAEC1B8;
 Fri, 29 May 2020 16:13:51 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DC997A8D3;
 Fri, 29 May 2020 16:13:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] libvhost-user: advertise vring features
Date: Fri, 29 May 2020 17:13:38 +0100
Message-Id: <20200529161338.456017-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bGlidmhvc3QtdXNlciBpbXBsZW1lbnRzIHNldmVyYWwgdnJpbmcgZmVhdHVyZXMgd2l0aG91dCBh
ZHZlcnRpc2luZwp0aGVtLiBUaGVyZSBpcyBubyB3YXkgZm9yIHRoZSB2aG9zdC11c2VyIG1hc3Rl
ciB0byBkZXRlY3Qgc3VwcG9ydCBmb3IKdGhlc2UgZmVhdHVyZXMuCgpUaGluZ3MgbW9yZSBvciBs
ZXNzIHdvcmsgdG9kYXkgYmVjYXVzZSBRRU1VIGFzc3VtZXMgdGhlIHZob3N0LXVzZXIKYmFja2Vu
ZCBhbHdheXMgaW1wbGVtZW50cyBjZXJ0YWluIGZlYXR1cmUgYml0cyBsaWtlClZJUlRJT19SSU5H
X0ZfRVZFTlRfSURYLiBUaGlzIGlzIG5vdCBkb2N1bWVudGVkIGFueXdoZXJlLgoKVGhpcyBwYXRj
aCBleHBsaWNpdGx5IGFkdmVydGlzZXMgZmVhdHVyZXMgaW1wbGVtZW50ZWQgaW4gbGlidmhvc3Qt
dXNlcgpzbyB0aGF0IHRoZSB2aG9zdC11c2VyIG1hc3RlciBkb2VzIG5vdCBuZWVkIHRvIG1ha2Ug
dW5kb2N1bWVudGVkCmFzc3VtcHRpb25zLgoKRmVhdHVyZSBiaXRzIHRoYXQgbGlidmhvc3QtdXNl
ciBub3cgYWR2ZXJ0aXNlcyBjYW4gYmUgcmVtb3ZlZCBmcm9tCnZob3N0LXVzZXItYmxrLmMuIERl
dmljZXMgc2hvdWxkIG5vdCBiZSByZXNwb25zaWJsZSBmb3IgYWR2ZXJ0aXNpbmcKdnJpbmcgZmVh
dHVyZSBiaXRzLCB0aGF0IGlzIGxpYnZob3N0LXVzZXIncyBqb2IuCgpDYzogTWFyYy1BbmRyw6kg
THVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+CkNjOiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgpDYzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
SSBoYXZlIHRlc3RlZCBtYWtlIGNoZWNrIGFuZCB2aXJ0aW9mc2QuCi0tLQogY29udHJpYi9saWJ2
aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYyAgIHwgMTAgKysrKysrKysrKwogY29udHJpYi92aG9z
dC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jIHwgIDQgKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIvbGli
dmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMgYi9jb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhv
c3QtdXNlci5jCmluZGV4IDNiY2E5OTZjNjIuLmI0Mzg3NGJhMTIgMTAwNjQ0Ci0tLSBhL2NvbnRy
aWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMKKysrIGIvY29udHJpYi9saWJ2aG9zdC11
c2VyL2xpYnZob3N0LXVzZXIuYwpAQCAtNDk1LDYgKzQ5NSwxNiBAQCBzdGF0aWMgYm9vbAogdnVf
Z2V0X2ZlYXR1cmVzX2V4ZWMoVnVEZXYgKmRldiwgVmhvc3RVc2VyTXNnICp2bXNnKQogewogICAg
IHZtc2ctPnBheWxvYWQudTY0ID0KKyAgICAgICAgLyoKKyAgICAgICAgICogVGhlIGZvbGxvd2lu
ZyBWSVJUSU8gZmVhdHVyZSBiaXRzIGFyZSBzdXBwb3J0ZWQgYnkgb3VyIHZpcnRxdWV1ZQorICAg
ICAgICAgKiBpbXBsZW1lbnRhdGlvbjoKKyAgICAgICAgICovCisgICAgICAgIDFVTEwgPDwgVklS
VElPX0ZfTk9USUZZX09OX0VNUFRZIHwKKyAgICAgICAgMVVMTCA8PCBWSVJUSU9fUklOR19GX0lO
RElSRUNUX0RFU0MgfAorICAgICAgICAxVUxMIDw8IFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYIHwK
KyAgICAgICAgMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEgfAorCisgICAgICAgIC8qIHZob3N0
LXVzZXIgZmVhdHVyZSBiaXRzICovCiAgICAgICAgIDFVTEwgPDwgVkhPU1RfRl9MT0dfQUxMIHwK
ICAgICAgICAgMVVMTCA8PCBWSE9TVF9VU0VSX0ZfUFJPVE9DT0xfRkVBVFVSRVM7CiAKZGlmZiAt
LWdpdCBhL2NvbnRyaWIvdmhvc3QtdXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYyBiL2NvbnRyaWIv
dmhvc3QtdXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYwppbmRleCA2ZmQ5MWM3ZTk5Li4yNWVjY2Qw
MmI1IDEwMDY0NAotLS0gYS9jb250cmliL3Zob3N0LXVzZXItYmxrL3Zob3N0LXVzZXItYmxrLmMK
KysrIGIvY29udHJpYi92aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jCkBAIC0zODIsOSAr
MzgyLDcgQEAgdnViX2dldF9mZWF0dXJlcyhWdURldiAqZGV2KQogICAgICAgICAgICAgICAgMXVs
bCA8PCBWSVJUSU9fQkxLX0ZfRElTQ0FSRCB8CiAgICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJ
T19CTEtfRl9XUklURV9aRVJPRVMgfAogICAgICAgICAgICAgICAgI2VuZGlmCi0gICAgICAgICAg
ICAgICAxdWxsIDw8IFZJUlRJT19CTEtfRl9DT05GSUdfV0NFIHwKLSAgICAgICAgICAgICAgIDF1
bGwgPDwgVklSVElPX0ZfVkVSU0lPTl8xIHwKLSAgICAgICAgICAgICAgIDF1bGwgPDwgVkhPU1Rf
VVNFUl9GX1BST1RPQ09MX0ZFQVRVUkVTOworICAgICAgICAgICAgICAgMXVsbCA8PCBWSVJUSU9f
QkxLX0ZfQ09ORklHX1dDRTsKIAogICAgIGlmICh2ZGV2X2Jsay0+ZW5hYmxlX3JvKSB7CiAgICAg
ICAgIGZlYXR1cmVzIHw9IDF1bGwgPDwgVklSVElPX0JMS19GX1JPOwotLSAKMi4yNS40Cgo=


