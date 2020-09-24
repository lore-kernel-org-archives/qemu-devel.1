Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F9FC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B6220BED
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5Tpw03B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B6220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLT14-0007w1-CW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyg-00060a-D4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSye-0003tZ-N8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iEGZL8A2wC+bPXPY44DglRT86oA+ZDMni9MGh+VyTuE=;
 b=K5Tpw03BMtiNg5wxIhI2xuu0XzYxaVZEhP8WOxX+gEAcElb1pbXdBz5S8FghHzBfdt1GRx
 9vj27Y9t+nuulL0zu+MkiTpnQZhyw+cGeaivFbyjF3DUyUIlSLTKn8cx385kJehpGnLGzU
 6CxeIVT5RRELSx8yQxvlKeR2uJ3X/xI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-a2-lhwdnOvyaK55lMGFadQ-1; Thu, 24 Sep 2020 11:15:56 -0400
X-MC-Unique: a2-lhwdnOvyaK55lMGFadQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C641C802B5E;
 Thu, 24 Sep 2020 15:15:54 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B55F75576C;
 Thu, 24 Sep 2020 15:15:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] block/export: convert vhost-user-blk-server to block
 exports API
Date: Thu, 24 Sep 2020 16:15:36 +0100
Message-Id: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6DQogKiBSZXBsYWNlIHVuaXgtc29ja2V0PXN0ciB3aXRoIGFkZHI9U29ja2V0QWRkcmVzcyBm
b3IgY29uc2lzdGVuY3kgd2l0aCBOQkQgYW5kDQogICBmZCBwYXNzaW5nIHN1cHBvcnQuIFRoZSBu
ZXcgc3ludGF4IGlzOg0KICAgLS1leHBvcnQgdmhvc3QtdXNlci1ibGssYWRkci50eXBlPXVuaXgs
YWRkci5wYXRoPS90bXAvdmhvc3QtdXNlci1ibGsuc29jaywuLi4NCiAqIE1ha2UgYWRkcj1Tb2Nr
ZXRBZGRyZXNzIG1hbmRhdG9yeSBpbnN0ZWFkIG9mIG9wdGlvbmFsIFtNYXJrdXNdDQogKiBVcGRh
dGUgdGVzdC12aG9zdC11c2VyLWJsay5jIHRvIHVzZSBuZXcgc3ludGF4DQogKiBBZGQgcGF0Y2gg
bW92aW5nIHZob3N0LXVzZXItc2VydmVyLmggdG8gaW5jbHVkZS8NCiAqIEFkZCBwYXRjaCB0byB1
c2UgbGlidmhvc3QtdXNlci5hIGluc3RlYWQgb2YgY29tcGlsaW5nIGl0IG11bHRpcGxlIHRpbWVz
DQoNClRoaXMgcGF0Y2ggc2VyaWVzIGNvbnZlcnRzIENvaWJ5IFh1J3Mgdmhvc3QtdXNlci1ibGst
c2VydmVyIGZyb20gYSBRT00gb2JqZWN0DQp0byB0aGUgYmxvY2sgZXhwb3J0cyBBUEkuIFRoZSBi
bG9jayBleHBvcnRzIEFQSSBwcm92aWRlcyBhIHN0YW5kYXJkIFFNUCBhbmQNCmNvbW1hbmQtbGlu
ZSBpbnRlcmZhY2UgZm9yIG1hbmFnaW5nIGJsb2NrIGV4cG9ydHMgKE5CRCwgRlVTRSwgdmhvc3Qt
dXNlci1ibGssDQpldGMpLiBBIGZhaXIgYW1vdW50IG9mIGluaXQvc2h1dGRvd24gY29kZSBpcyBy
ZW1vdmVkIGJlY2F1c2UgdGhlIGJsb2NrIGV4cG9ydHMNCkFQSSBhbHJlYWR5IHRha2VzIGNhcmUg
b2YgdGhhdCBmdW5jdGlvbmFsaXR5Lg0KDQpNb3N0IG9mIHRoZSBwYXRjaGVzIGFyZSB2aG9zdC11
c2VyLWJsay1zZXJ2ZXIgY2xlYW51cHMuDQoNClRoZSBzeW50YXggZm9yIGxhdW5jaGluZyBxZW11
LXN0b3JhZ2UtZGFlbW9uIGlzOg0KDQogICQgcWVtdS1zdG9yYWdlLWRhZW1vbiBcDQogICAgICAt
LWJsb2NrZGV2IGZpbGUsbm9kZS1uYW1lPWRyaXZlMCxmaWxlbmFtZT10ZXN0LmltZyBcDQogICAg
ICAtLWV4cG9ydCB2aG9zdC11c2VyLWJsayxub2RlLW5hbWU9ZHJpdmUwLGlkPWV4cG9ydDAsd3Jp
dGFibGU9b24sYWRkci50eXBlPXVuaXgsYWRkci5wYXRoPS90bXAvdmhvc3QtdXNlci1ibGsuc29j
aw0KDQpRRU1VIGNhbiBjb25uZWN0IHRvIHRoZSB2aG9zdC11c2VyLWJsayBleHBvcnQgbGlrZSB0
aGlzOg0KDQogICQgcWVtdS1zeXN0ZW0teDg2XzY0IFwNCiAgICAgIC1NIGFjY2VsPWt2bSxtZW1v
cnktYmFja2VuZD1tZW0gXA0KICAgICAgLW0gMUcgXA0KICAgICAgLW9iamVjdCBtZW1vcnktYmFj
a2VuZC1tZW1mZCxzaXplPTFHLGlkPW1lbSBcDQogICAgICAtY3B1IGhvc3QgXA0KICAgICAgLWNo
YXJkZXYgc29ja2V0LHBhdGg9L3RtcC92aG9zdC11c2VyLWJsay5zb2NrLGlkPWNoYXIwIFwNCiAg
ICAgIC1kZXZpY2Ugdmhvc3QtdXNlci1ibGstcGNpLGNoYXJkZXY9Y2hhcjANCg0KQmFzZWQtb246
IDIwMjAwOTE4MDgwOTEyLjMyMTI5OS0xLWNvaWJ5Lnh1QGdtYWlsLmNvbSAoIltQQVRDSCB2MTAg
MC83XSB2aG9zdC11c2VyIGJsb2NrIGRldmljZSBiYWNrZW5kIGltcGxlbWVudGF0aW9uIikNCkJh
c2VkLW9uOiAyMDIwMDkwNzE4MjAxMS41MjEwMDctMS1rd29sZkByZWRoYXQuY29tICgiW1BBVENI
IDAwLzI5XSBibG9jay9leHBvcnQ6IEFkZCBpbmZyYXN0cnVjdHVyZSBhbmQgUUFQSSBmb3IgYmxv
Y2sgZXhwb3J0cyIpDQoNClN0ZWZhbiBIYWpub2N6aSAoMTMpOg0KICBibG9jay9leHBvcnQ6IHNo
b3J0ZW4gc2VyaWFsIHN0cmluZyB0byBmaXQNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogcy9m
aWxlZHMvZmllbGRzLyB0eXBvIGZpeA0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBkcm9wIHVu
bmVjZXNzYXJ5IFFPTSBjYXN0DQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IGRyb3AgdW5uZWNl
c3Nhcnkgd2F0Y2ggZGVsZXRpb24NCiAgYmxvY2svZXhwb3J0OiBjb25zb2xpZGF0ZSByZXF1ZXN0
IHN0cnVjdHMgaW50byBWdUJsb2NrUmVxDQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IGRyb3Ag
dW51c2VkIERldmljZVBhbmljTm90aWZpZXINCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogZml4
IG1lbW9yeSBsZWFrIGluIHZ1X21lc3NhZ2VfcmVhZCgpDQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2
ZXI6IGNoZWNrIEVPRiB3aGVuIHJlYWRpbmcgcGF5bG9hZA0KICB1dGlsL3Zob3N0LXVzZXItc2Vy
dmVyOiByZXdvcmsgdnVfY2xpZW50X3RyaXAoKSBjb3JvdXRpbmUgbGlmZWN5Y2xlDQogIGJsb2Nr
L2V4cG9ydDogcmVwb3J0IGZsdXNoIGVycm9ycw0KICBibG9jay9leHBvcnQ6IGNvbnZlcnQgdmhv
c3QtdXNlci1ibGsgc2VydmVyIHRvIGJsb2NrIGV4cG9ydCBBUEkNCiAgdXRpbC92aG9zdC11c2Vy
LXNlcnZlcjogbW92ZSBoZWFkZXIgdG8gaW5jbHVkZS8NCiAgdXRpbC92aG9zdC11c2VyLXNlcnZl
cjogdXNlIHN0YXRpYyBsaWJyYXJ5IGluIG1lc29uLmJ1aWxkDQoNCiBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBxYXBpL2Jsb2NrLWV4cG9ydC5q
c29uICAgICAgICAgICAgICAgICAgICAgfCAgMjEgKy0NCiBibG9jay9leHBvcnQvdmhvc3QtdXNl
ci1ibGstc2VydmVyLmggICAgICAgfCAgMjMgKy0NCiB7dXRpbCA9PiBpbmNsdWRlL3FlbXV9L3Zo
b3N0LXVzZXItc2VydmVyLmggfCAgMzIgKy0NCiBibG9jay9leHBvcnQvZXhwb3J0LmMgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDggKy0NCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2Vy
dmVyLmMgICAgICAgfCA1MjUgKysrKysrLS0tLS0tLS0tLS0tLS0tDQogdGVzdHMvcXRlc3Qvdmhv
c3QtdXNlci1ibGstdGVzdC5jICAgICAgICAgIHwgICAyICstDQogdXRpbC92aG9zdC11c2VyLXNl
cnZlci5jICAgICAgICAgICAgICAgICAgIHwgMzM0ICsrKysrKy0tLS0tLS0NCiBibG9jay9leHBv
cnQvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGJsb2NrL21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtDQogY29udHJpYi9saWJ2aG9zdC11
c2VyL21lc29uLmJ1aWxkICAgICAgICAgIHwgICAxICsNCiBtZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAg
ICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiB1dGlsL21lc29uLmJ1aWxkICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDQgKy0NCiAxNCBmaWxlcyBjaGFuZ2VkLCAzNzYgaW5zZXJ0aW9u
cygrKSwgNTg4IGRlbGV0aW9ucygtKQ0KIHJlbmFtZSB7dXRpbCA9PiBpbmNsdWRlL3FlbXV9L3Zo
b3N0LXVzZXItc2VydmVyLmggKDcyJSkNCg0KLS0gDQoyLjI2LjINCg0K


