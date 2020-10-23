Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C18C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6C420878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViNW3hER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6C420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzJe-0007Av-C8
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVyvT-0007lz-QU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVyvP-0000zx-Ne
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghFFnLOFkfjPoQsbyc4rZOBW07tC/ZmnO//U6wIqPqo=;
 b=ViNW3hER5LcHjfjouneMy2uq2THsA+hXTH4gWuOFZhWX9Yg+Izuwywu+UJzvaRwc6sxfWZ
 ZNS/b1TvdV1zPIhr7C8Weu/ehsh5zoX4g+9Apdo9fDshFOIbWAkyP37x0SGgRg18DSeq24
 SPBxl6ZLBJNn+Etwm+JofQyo3AnTfac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-a2lZ7z02NN26NzZD1fbTKA-1; Fri, 23 Oct 2020 11:24:11 -0400
X-MC-Unique: a2lZ7z02NN26NzZD1fbTKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51949805F14;
 Fri, 23 Oct 2020 15:23:40 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8D2E5C1CF;
 Fri, 23 Oct 2020 15:23:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 19/28] util/vhost-user-server: use static library in
 meson.build
Date: Fri, 23 Oct 2020 16:21:38 +0100
Message-Id: <20201023152147.1016281-20-stefanha@redhat.com>
In-Reply-To: <20201023152147.1016281-1-stefanha@redhat.com>
References: <20201023152147.1016281-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG9uJ3QgY29tcGlsZSBjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jIGFnYWlu
LiBJbnN0ZWFkIGJ1aWxkCnRoZSBzdGF0aWMgbGlicmFyeSBvbmNlIGFuZCB0aGVuIHJldXNlIGl0
IHRocm91Z2hvdXQgUUVNVS4KCkFsc28gc3dpdGNoIGZyb20gQ09ORklHX0xJTlVYIHRvIENPTkZJ
R19WSE9TVF9VU0VSLCB3aGljaCBpcyB3aGF0IHRoZQp2aG9zdC11c2VyIHRvb2xzICh2aG9zdC11
c2VyLWdwdSwgZXRjKSBkby4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA5MjQxNTE1NDkuOTEzNzM3LTE0LXN0ZWZh
bmhhQHJlZGhhdC5jb20KW0FkZGVkIENPTkZJR19MSU5VWCBhZ2FpbiBiZWNhdXNlIGxpYnZob3N0
LXVzZXIgZG9lc24ndCBidWlsZCBvbiBtYWNPUy4KLS1TdGVmYW5dClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9leHBvcnQvZXhw
b3J0LmMgICAgICAgICAgICAgfCA4ICsrKystLS0tCiBibG9jay9leHBvcnQvbWVzb24uYnVpbGQg
ICAgICAgICAgfCAyICstCiBjb250cmliL2xpYnZob3N0LXVzZXIvbWVzb24uYnVpbGQgfCAxICsK
IG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICB8IDYgKysrKystCiB1dGlsL21lc29u
LmJ1aWxkICAgICAgICAgICAgICAgICAgfCA0ICsrKy0KIDUgZmlsZXMgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9leHBvcnQvZXhw
b3J0LmMgYi9ibG9jay9leHBvcnQvZXhwb3J0LmMKaW5kZXggYmQ3Y2FjMjQxZi4uYTI0ZmFkY2Zi
NSAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L2V4cG9ydC5jCisrKyBiL2Jsb2NrL2V4cG9ydC9l
eHBvcnQuYwpAQCAtMTcsMTcgKzE3LDE3IEBACiAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tl
bmQuaCIKICNpbmNsdWRlICJibG9jay9leHBvcnQuaCIKICNpbmNsdWRlICJibG9jay9uYmQuaCIK
LSNpZiBDT05GSUdfTElOVVgKLSNpbmNsdWRlICJibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGst
c2VydmVyLmgiCi0jZW5kaWYKICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCiAjaW5jbHVkZSAicWFw
aS9xYXBpLWNvbW1hbmRzLWJsb2NrLWV4cG9ydC5oIgogI2luY2x1ZGUgInFhcGkvcWFwaS1ldmVu
dHMtYmxvY2stZXhwb3J0LmgiCiAjaW5jbHVkZSAicWVtdS9pZC5oIgorI2lmIGRlZmluZWQoQ09O
RklHX0xJTlVYKSAmJiBkZWZpbmVkKENPTkZJR19WSE9TVF9VU0VSKQorI2luY2x1ZGUgInZob3N0
LXVzZXItYmxrLXNlcnZlci5oIgorI2VuZGlmCiAKIHN0YXRpYyBjb25zdCBCbG9ja0V4cG9ydERy
aXZlciAqYmxrX2V4cF9kcml2ZXJzW10gPSB7CiAgICAgJmJsa19leHBfbmJkLAotI2lmIENPTkZJ
R19MSU5VWAorI2lmIGRlZmluZWQoQ09ORklHX0xJTlVYKSAmJiBkZWZpbmVkKENPTkZJR19WSE9T
VF9VU0VSKQogICAgICZibGtfZXhwX3Zob3N0X3VzZXJfYmxrLAogI2VuZGlmCiB9OwpkaWZmIC0t
Z2l0IGEvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkIGIvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxk
CmluZGV4IGVmM2E5NTc2ZjcuLmZmZmU2YjA5ZTggMTAwNjQ0Ci0tLSBhL2Jsb2NrL2V4cG9ydC9t
ZXNvbi5idWlsZAorKysgYi9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQKQEAgLTEsMiArMSwyIEBA
CiBibG9ja19zcy5hZGQoZmlsZXMoJ2V4cG9ydC5jJykpCi1ibG9ja19zcy5hZGQod2hlbjogJ0NP
TkZJR19MSU5VWCcsIGlmX3RydWU6IGZpbGVzKCd2aG9zdC11c2VyLWJsay1zZXJ2ZXIuYycsICcu
Li8uLi9jb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jJykpCitibG9ja19zcy5h
ZGQod2hlbjogWydDT05GSUdfTElOVVgnLCAnQ09ORklHX1ZIT1NUX1VTRVInXSwgaWZfdHJ1ZTog
ZmlsZXMoJ3Zob3N0LXVzZXItYmxrLXNlcnZlci5jJykpCmRpZmYgLS1naXQgYS9jb250cmliL2xp
YnZob3N0LXVzZXIvbWVzb24uYnVpbGQgYi9jb250cmliL2xpYnZob3N0LXVzZXIvbWVzb24uYnVp
bGQKaW5kZXggZTY4ZGQxYTU4MS4uYTI2MWU3NjY1ZiAxMDA2NDQKLS0tIGEvY29udHJpYi9saWJ2
aG9zdC11c2VyL21lc29uLmJ1aWxkCisrKyBiL2NvbnRyaWIvbGlidmhvc3QtdXNlci9tZXNvbi5i
dWlsZApAQCAtMSwzICsxLDQgQEAKIGxpYnZob3N0X3VzZXIgPSBzdGF0aWNfbGlicmFyeSgndmhv
c3QtdXNlcicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZXMoJ2xpYnZob3N0
LXVzZXIuYycsICdsaWJ2aG9zdC11c2VyLWdsaWIuYycpLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJ1aWxkX2J5X2RlZmF1bHQ6IGZhbHNlKQordmhvc3RfdXNlciA9IGRlY2xhcmVf
ZGVwZW5kZW5jeShsaW5rX3dpdGg6IGxpYnZob3N0X3VzZXIpCmRpZmYgLS1naXQgYS9tZXNvbi5i
dWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IDc2MjdhMGFlNDYuLjJlYzRmMTE0Y2UgMTAwNjQ0Ci0t
LSBhL21lc29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC0xMzk4LDYgKzEzOTgsMTEgQEAg
dHJhY2VfZXZlbnRzX3N1YmRpcnMgKz0gWwogICAndXRpbCcsCiBdCiAKK3Zob3N0X3VzZXIgPSBu
b3RfZm91bmQKK2lmICdDT05GSUdfVkhPU1RfVVNFUicgaW4gY29uZmlnX2hvc3QKKyAgc3ViZGly
KCdjb250cmliL2xpYnZob3N0LXVzZXInKQorZW5kaWYKKwogc3ViZGlyKCdxYXBpJykKIHN1YmRp
cigncW9iamVjdCcpCiBzdWJkaXIoJ3N0dWJzJykKQEAgLTE4MzAsNyArMTgzNSw2IEBAIGlmIGhh
dmVfdG9vbHMKICAgICAgICAgICAgICBpbnN0YWxsOiB0cnVlKQogCiAgIGlmICdDT05GSUdfVkhP
U1RfVVNFUicgaW4gY29uZmlnX2hvc3QKLSAgICBzdWJkaXIoJ2NvbnRyaWIvbGlidmhvc3QtdXNl
cicpCiAgICAgc3ViZGlyKCdjb250cmliL3Zob3N0LXVzZXItYmxrJykKICAgICBzdWJkaXIoJ2Nv
bnRyaWIvdmhvc3QtdXNlci1ncHUnKQogICAgIHN1YmRpcignY29udHJpYi92aG9zdC11c2VyLWlu
cHV0JykKZGlmZiAtLWdpdCBhL3V0aWwvbWVzb24uYnVpbGQgYi91dGlsL21lc29uLmJ1aWxkCmlu
ZGV4IDIyOTZlODFiMzQuLmM1MTU5YWQ3OWQgMTAwNjQ0Ci0tLSBhL3V0aWwvbWVzb24uYnVpbGQK
KysrIGIvdXRpbC9tZXNvbi5idWlsZApAQCAtNjYsNyArNjYsOSBAQCBpZiBoYXZlX2Jsb2NrCiAg
IHV0aWxfc3MuYWRkKGZpbGVzKCdtYWluLWxvb3AuYycpKQogICB1dGlsX3NzLmFkZChmaWxlcygn
bnZkaW1tLXV0aWxzLmMnKSkKICAgdXRpbF9zcy5hZGQoZmlsZXMoJ3FlbXUtY29yb3V0aW5lLmMn
LCAncWVtdS1jb3JvdXRpbmUtbG9jay5jJywgJ3FlbXUtY29yb3V0aW5lLWlvLmMnKSkKLSAgdXRp
bF9zcy5hZGQod2hlbjogJ0NPTkZJR19MSU5VWCcsIGlmX3RydWU6IGZpbGVzKCd2aG9zdC11c2Vy
LXNlcnZlci5jJykpCisgIHV0aWxfc3MuYWRkKHdoZW46IFsnQ09ORklHX0xJTlVYJywgJ0NPTkZJ
R19WSE9TVF9VU0VSJ10sIGlmX3RydWU6IFsKKyAgICBmaWxlcygndmhvc3QtdXNlci1zZXJ2ZXIu
YycpLCB2aG9zdF91c2VyCisgIF0pCiAgIHV0aWxfc3MuYWRkKGZpbGVzKCdibG9jay1oZWxwZXJz
LmMnKSkKICAgdXRpbF9zcy5hZGQoZmlsZXMoJ3FlbXUtY29yb3V0aW5lLXNsZWVwLmMnKSkKICAg
dXRpbF9zcy5hZGQoZmlsZXMoJ3FlbXUtY28tc2hhcmVkLXJlc291cmNlLmMnKSkKLS0gCjIuMjYu
MgoK


