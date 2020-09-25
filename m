Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FBAC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AE8206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwpDu56V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AE8206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLo2m-0006k4-Fq
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzo-0004QH-Kh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLnzm-0008GZ-QJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:42:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQ6mKk/Xvpoh0FwSh8rFgMjwPJbPcXVa/7jUk56NGb0=;
 b=SwpDu56VAsPYZsghCASe5ANvmQqDna/7qrFymXVZlLHBq/5JYAG/2lwqSrORxN9DmpQ3Oy
 4XyZE/iAtC5Bz5L+HgB6wsj7NfteeBVpb3DF7kb+qFgRhcNacLpSWtneNDQCOMMygNdHWO
 aNEzuSxKFM4JfBZ07OtORqNGx4PL1xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-G77nen3mPeGzG8tz11lYAA-1; Fri, 25 Sep 2020 09:42:40 -0400
X-MC-Unique: G77nen3mPeGzG8tz11lYAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C73048030A6;
 Fri, 25 Sep 2020 13:42:38 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E2DE55785;
 Fri, 25 Sep 2020 13:42:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] util/vhost-user-server: use static library in meson.build
Date: Fri, 25 Sep 2020 14:42:26 +0100
Message-Id: <20200925134229.246169-2-stefanha@redhat.com>
In-Reply-To: <20200925134229.246169-1-stefanha@redhat.com>
References: <20200925134229.246169-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG9uJ3QgY29tcGlsZSBjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jIGFnYWlu
LiBJbnN0ZWFkIGJ1aWxkCnRoZSBzdGF0aWMgbGlicmFyeSBvbmNlIGFuZCB0aGVuIHJldXNlIGl0
IHRocm91Z2hvdXQgUUVNVS4KCkFsc28gc3dpdGNoIGZyb20gQ09ORklHX0xJTlVYIHRvIENPTkZJ
R19WSE9TVF9VU0VSLCB3aGljaCBpcyB3aGF0IHRoZQp2aG9zdC11c2VyIHRvb2xzICh2aG9zdC11
c2VyLWdwdSwgZXRjKSBkby4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9leHBvcnQvZXhwb3J0LmMgICAgICAgICAgICAgfCA4
ICsrKystLS0tCiBibG9jay9leHBvcnQvbWVzb24uYnVpbGQgICAgICAgICAgfCAyICstCiBjb250
cmliL2xpYnZob3N0LXVzZXIvbWVzb24uYnVpbGQgfCAxICsKIG1lc29uLmJ1aWxkICAgICAgICAg
ICAgICAgICAgICAgICB8IDYgKysrKystCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAg
ICAgfCAyICstCiB1dGlsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCA0ICsrKy0KIDYg
ZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9ibG9jay9leHBvcnQvZXhwb3J0LmMgYi9ibG9jay9leHBvcnQvZXhwb3J0LmMKaW5kZXgg
YmQ3Y2FjMjQxZi4uNTUwODk3ZTIzNiAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L2V4cG9ydC5j
CisrKyBiL2Jsb2NrL2V4cG9ydC9leHBvcnQuYwpAQCAtMTcsMTcgKzE3LDE3IEBACiAjaW5jbHVk
ZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQuaCIKICNpbmNsdWRlICJibG9jay9leHBvcnQuaCIKICNp
bmNsdWRlICJibG9jay9uYmQuaCIKLSNpZiBDT05GSUdfTElOVVgKLSNpbmNsdWRlICJibG9jay9l
eHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmgiCi0jZW5kaWYKICNpbmNsdWRlICJxYXBpL2Vy
cm9yLmgiCiAjaW5jbHVkZSAicWFwaS9xYXBpLWNvbW1hbmRzLWJsb2NrLWV4cG9ydC5oIgogI2lu
Y2x1ZGUgInFhcGkvcWFwaS1ldmVudHMtYmxvY2stZXhwb3J0LmgiCiAjaW5jbHVkZSAicWVtdS9p
ZC5oIgorI2lmZGVmIENPTkZJR19WSE9TVF9VU0VSCisjaW5jbHVkZSAidmhvc3QtdXNlci1ibGst
c2VydmVyLmgiCisjZW5kaWYKIAogc3RhdGljIGNvbnN0IEJsb2NrRXhwb3J0RHJpdmVyICpibGtf
ZXhwX2RyaXZlcnNbXSA9IHsKICAgICAmYmxrX2V4cF9uYmQsCi0jaWYgQ09ORklHX0xJTlVYCisj
aWZkZWYgQ09ORklHX1ZIT1NUX1VTRVIKICAgICAmYmxrX2V4cF92aG9zdF91c2VyX2JsaywKICNl
bmRpZgogfTsKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZCBiL2Jsb2NrL2V4
cG9ydC9tZXNvbi5idWlsZAppbmRleCBlZjNhOTU3NmY3Li40NjlhN2FhMGY1IDEwMDY0NAotLS0g
YS9ibG9jay9leHBvcnQvbWVzb24uYnVpbGQKKysrIGIvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxk
CkBAIC0xLDIgKzEsMiBAQAogYmxvY2tfc3MuYWRkKGZpbGVzKCdleHBvcnQuYycpKQotYmxvY2tf
c3MuYWRkKHdoZW46ICdDT05GSUdfTElOVVgnLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1i
bGstc2VydmVyLmMnLCAnLi4vLi4vY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIu
YycpKQorYmxvY2tfc3MuYWRkKHdoZW46ICdDT05GSUdfVkhPU1RfVVNFUicsIGlmX3RydWU6IGZp
bGVzKCd2aG9zdC11c2VyLWJsay1zZXJ2ZXIuYycpKQpkaWZmIC0tZ2l0IGEvY29udHJpYi9saWJ2
aG9zdC11c2VyL21lc29uLmJ1aWxkIGIvY29udHJpYi9saWJ2aG9zdC11c2VyL21lc29uLmJ1aWxk
CmluZGV4IGU2OGRkMWE1ODEuLmEyNjFlNzY2NWYgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvbGlidmhv
c3QtdXNlci9tZXNvbi5idWlsZAorKysgYi9jb250cmliL2xpYnZob3N0LXVzZXIvbWVzb24uYnVp
bGQKQEAgLTEsMyArMSw0IEBACiBsaWJ2aG9zdF91c2VyID0gc3RhdGljX2xpYnJhcnkoJ3Zob3N0
LXVzZXInLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbGVzKCdsaWJ2aG9zdC11
c2VyLmMnLCAnbGlidmhvc3QtdXNlci1nbGliLmMnKSwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBidWlsZF9ieV9kZWZhdWx0OiBmYWxzZSkKK3Zob3N0X3VzZXIgPSBkZWNsYXJlX2Rl
cGVuZGVuY3kobGlua193aXRoOiBsaWJ2aG9zdF91c2VyKQpkaWZmIC0tZ2l0IGEvbWVzb24uYnVp
bGQgYi9tZXNvbi5idWlsZAppbmRleCA0YzZjNzMxMGZhLi5lYjg0Yjk3ZWJiIDEwMDY0NAotLS0g
YS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtNzg4LDYgKzc4OCwxMSBAQCB0cmFj
ZV9ldmVudHNfc3ViZGlycyArPSBbCiAgICd1dGlsJywKIF0KIAordmhvc3RfdXNlciA9IG5vdF9m
b3VuZAoraWYgJ0NPTkZJR19WSE9TVF9VU0VSJyBpbiBjb25maWdfaG9zdAorICBzdWJkaXIoJ2Nv
bnRyaWIvbGlidmhvc3QtdXNlcicpCitlbmRpZgorCiBzdWJkaXIoJ3FhcGknKQogc3ViZGlyKCdx
b2JqZWN0JykKIHN1YmRpcignc3R1YnMnKQpAQCAtMTE2OSw3ICsxMTc0LDYgQEAgaWYgaGF2ZV90
b29scwogICAgICAgICAgICAgIGluc3RhbGw6IHRydWUpCiAKICAgaWYgJ0NPTkZJR19WSE9TVF9V
U0VSJyBpbiBjb25maWdfaG9zdAotICAgIHN1YmRpcignY29udHJpYi9saWJ2aG9zdC11c2VyJykK
ICAgICBzdWJkaXIoJ2NvbnRyaWIvdmhvc3QtdXNlci1ibGsnKQogICAgIHN1YmRpcignY29udHJp
Yi92aG9zdC11c2VyLWdwdScpCiAgICAgc3ViZGlyKCdjb250cmliL3Zob3N0LXVzZXItaW5wdXQn
KQpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNv
bi5idWlsZAppbmRleCBjNzI4MjFiMDlhLi5hYThkMDk4NWUxIDEwMDY0NAotLS0gYS90ZXN0cy9x
dGVzdC9tZXNvbi5idWlsZAorKysgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApAQCAtMTkxLDcg
KzE5MSw3IEBAIHFvc190ZXN0X3NzLmFkZCgKICkKIHFvc190ZXN0X3NzLmFkZCh3aGVuOiAnQ09O
RklHX1ZJUlRGUycsIGlmX3RydWU6IGZpbGVzKCd2aXJ0aW8tOXAtdGVzdC5jJykpCiBxb3NfdGVz
dF9zcy5hZGQod2hlbjogJ0NPTkZJR19WSE9TVF9VU0VSJywgaWZfdHJ1ZTogZmlsZXMoJ3Zob3N0
LXVzZXItdGVzdC5jJykpCi1xb3NfdGVzdF9zcy5hZGQod2hlbjogJ0NPTkZJR19MSU5VWCcsIGlm
X3RydWU6IGZpbGVzKCd2aG9zdC11c2VyLWJsay10ZXN0LmMnKSkKK3Fvc190ZXN0X3NzLmFkZCh3
aGVuOiAnQ09ORklHX1ZIT1NUX1VTRVInLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1ibGst
dGVzdC5jJykpCiAKIGV4dHJhX3F0ZXN0X2RlcHMgPSB7CiAgICdiaW9zLXRhYmxlcy10ZXN0Jzog
W2lvXSwKZGlmZiAtLWdpdCBhL3V0aWwvbWVzb24uYnVpbGQgYi91dGlsL21lc29uLmJ1aWxkCmlu
ZGV4IDIyOTZlODFiMzQuLjliMmE3YTVkZTkgMTAwNjQ0Ci0tLSBhL3V0aWwvbWVzb24uYnVpbGQK
KysrIGIvdXRpbC9tZXNvbi5idWlsZApAQCAtNjYsNyArNjYsOSBAQCBpZiBoYXZlX2Jsb2NrCiAg
IHV0aWxfc3MuYWRkKGZpbGVzKCdtYWluLWxvb3AuYycpKQogICB1dGlsX3NzLmFkZChmaWxlcygn
bnZkaW1tLXV0aWxzLmMnKSkKICAgdXRpbF9zcy5hZGQoZmlsZXMoJ3FlbXUtY29yb3V0aW5lLmMn
LCAncWVtdS1jb3JvdXRpbmUtbG9jay5jJywgJ3FlbXUtY29yb3V0aW5lLWlvLmMnKSkKLSAgdXRp
bF9zcy5hZGQod2hlbjogJ0NPTkZJR19MSU5VWCcsIGlmX3RydWU6IGZpbGVzKCd2aG9zdC11c2Vy
LXNlcnZlci5jJykpCisgIHV0aWxfc3MuYWRkKHdoZW46ICdDT05GSUdfVkhPU1RfVVNFUicsIGlm
X3RydWU6IFsKKyAgICBmaWxlcygndmhvc3QtdXNlci1zZXJ2ZXIuYycpLCB2aG9zdF91c2VyCisg
IF0pCiAgIHV0aWxfc3MuYWRkKGZpbGVzKCdibG9jay1oZWxwZXJzLmMnKSkKICAgdXRpbF9zcy5h
ZGQoZmlsZXMoJ3FlbXUtY29yb3V0aW5lLXNsZWVwLmMnKSkKICAgdXRpbF9zcy5hZGQoZmlsZXMo
J3FlbXUtY28tc2hhcmVkLXJlc291cmNlLmMnKSkKLS0gCjIuMjYuMgoK


