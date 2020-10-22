Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB17C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0AF2227F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S16Gsqb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0AF2227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZ25-00005R-T9
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYmb-0006Cm-I9
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYmY-00059x-K3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603366161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwQd8wORDao0+3QpVdU00Rbe1vhC/LwYTHjYaJ28YWs=;
 b=S16Gsqb23xE0XQ8Y8ymmo9Bf9K0ysEW/pQ/5wRacawQGP4AH8YrGuvRsPo8CnuWWGWt9us
 IlBh6/abd+wq1QqTz1fJcxyYECbzuDVKZ6dVLv7sMp0NsfsrLKcDv1zz/Bwi3laaf7dxeD
 gTLc/d3w/IMVGIdQBGc/vVnNd88OhIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-BWo2g1G6PZ-kHiM3IT_58Q-1; Thu, 22 Oct 2020 07:29:19 -0400
X-MC-Unique: BWo2g1G6PZ-kHiM3IT_58Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42CECAD749;
 Thu, 22 Oct 2020 11:29:18 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCD7510013D7;
 Thu, 22 Oct 2020 11:29:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 19/28] util/vhost-user-server: use static library in
 meson.build
Date: Thu, 22 Oct 2020 12:27:17 +0100
Message-Id: <20201022112726.736757-20-stefanha@redhat.com>
In-Reply-To: <20201022112726.736757-1-stefanha@redhat.com>
References: <20201022112726.736757-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 06:53:39
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
b3J0LmMgYi9ibG9jay9leHBvcnQvZXhwb3J0LmMKaW5kZXggYmQ3Y2FjMjQxZi4uNTUwODk3ZTIz
NiAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L2V4cG9ydC5jCisrKyBiL2Jsb2NrL2V4cG9ydC9l
eHBvcnQuYwpAQCAtMTcsMTcgKzE3LDE3IEBACiAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tl
bmQuaCIKICNpbmNsdWRlICJibG9jay9leHBvcnQuaCIKICNpbmNsdWRlICJibG9jay9uYmQuaCIK
LSNpZiBDT05GSUdfTElOVVgKLSNpbmNsdWRlICJibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGst
c2VydmVyLmgiCi0jZW5kaWYKICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCiAjaW5jbHVkZSAicWFw
aS9xYXBpLWNvbW1hbmRzLWJsb2NrLWV4cG9ydC5oIgogI2luY2x1ZGUgInFhcGkvcWFwaS1ldmVu
dHMtYmxvY2stZXhwb3J0LmgiCiAjaW5jbHVkZSAicWVtdS9pZC5oIgorI2lmZGVmIENPTkZJR19W
SE9TVF9VU0VSCisjaW5jbHVkZSAidmhvc3QtdXNlci1ibGstc2VydmVyLmgiCisjZW5kaWYKIAog
c3RhdGljIGNvbnN0IEJsb2NrRXhwb3J0RHJpdmVyICpibGtfZXhwX2RyaXZlcnNbXSA9IHsKICAg
ICAmYmxrX2V4cF9uYmQsCi0jaWYgQ09ORklHX0xJTlVYCisjaWZkZWYgQ09ORklHX1ZIT1NUX1VT
RVIKICAgICAmYmxrX2V4cF92aG9zdF91c2VyX2JsaywKICNlbmRpZgogfTsKZGlmZiAtLWdpdCBh
L2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZCBiL2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZAppbmRl
eCBlZjNhOTU3NmY3Li5mZmZlNmIwOWU4IDEwMDY0NAotLS0gYS9ibG9jay9leHBvcnQvbWVzb24u
YnVpbGQKKysrIGIvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkCkBAIC0xLDIgKzEsMiBAQAogYmxv
Y2tfc3MuYWRkKGZpbGVzKCdleHBvcnQuYycpKQotYmxvY2tfc3MuYWRkKHdoZW46ICdDT05GSUdf
TElOVVgnLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1ibGstc2VydmVyLmMnLCAnLi4vLi4v
Y29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYycpKQorYmxvY2tfc3MuYWRkKHdo
ZW46IFsnQ09ORklHX0xJTlVYJywgJ0NPTkZJR19WSE9TVF9VU0VSJ10sIGlmX3RydWU6IGZpbGVz
KCd2aG9zdC11c2VyLWJsay1zZXJ2ZXIuYycpKQpkaWZmIC0tZ2l0IGEvY29udHJpYi9saWJ2aG9z
dC11c2VyL21lc29uLmJ1aWxkIGIvY29udHJpYi9saWJ2aG9zdC11c2VyL21lc29uLmJ1aWxkCmlu
ZGV4IGU2OGRkMWE1ODEuLmEyNjFlNzY2NWYgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvbGlidmhvc3Qt
dXNlci9tZXNvbi5idWlsZAorKysgYi9jb250cmliL2xpYnZob3N0LXVzZXIvbWVzb24uYnVpbGQK
QEAgLTEsMyArMSw0IEBACiBsaWJ2aG9zdF91c2VyID0gc3RhdGljX2xpYnJhcnkoJ3Zob3N0LXVz
ZXInLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbGVzKCdsaWJ2aG9zdC11c2Vy
LmMnLCAnbGlidmhvc3QtdXNlci1nbGliLmMnKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBidWlsZF9ieV9kZWZhdWx0OiBmYWxzZSkKK3Zob3N0X3VzZXIgPSBkZWNsYXJlX2RlcGVu
ZGVuY3kobGlua193aXRoOiBsaWJ2aG9zdF91c2VyKQpkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQg
Yi9tZXNvbi5idWlsZAppbmRleCA3NjI3YTBhZTQ2Li4yZWM0ZjExNGNlIDEwMDY0NAotLS0gYS9t
ZXNvbi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtMTM5OCw2ICsxMzk4LDExIEBAIHRyYWNl
X2V2ZW50c19zdWJkaXJzICs9IFsKICAgJ3V0aWwnLAogXQogCit2aG9zdF91c2VyID0gbm90X2Zv
dW5kCitpZiAnQ09ORklHX1ZIT1NUX1VTRVInIGluIGNvbmZpZ19ob3N0CisgIHN1YmRpcignY29u
dHJpYi9saWJ2aG9zdC11c2VyJykKK2VuZGlmCisKIHN1YmRpcigncWFwaScpCiBzdWJkaXIoJ3Fv
YmplY3QnKQogc3ViZGlyKCdzdHVicycpCkBAIC0xODMwLDcgKzE4MzUsNiBAQCBpZiBoYXZlX3Rv
b2xzCiAgICAgICAgICAgICAgaW5zdGFsbDogdHJ1ZSkKIAogICBpZiAnQ09ORklHX1ZIT1NUX1VT
RVInIGluIGNvbmZpZ19ob3N0Ci0gICAgc3ViZGlyKCdjb250cmliL2xpYnZob3N0LXVzZXInKQog
ICAgIHN1YmRpcignY29udHJpYi92aG9zdC11c2VyLWJsaycpCiAgICAgc3ViZGlyKCdjb250cmli
L3Zob3N0LXVzZXItZ3B1JykKICAgICBzdWJkaXIoJ2NvbnRyaWIvdmhvc3QtdXNlci1pbnB1dCcp
CmRpZmYgLS1naXQgYS91dGlsL21lc29uLmJ1aWxkIGIvdXRpbC9tZXNvbi5idWlsZAppbmRleCAy
Mjk2ZTgxYjM0Li5jNTE1OWFkNzlkIDEwMDY0NAotLS0gYS91dGlsL21lc29uLmJ1aWxkCisrKyBi
L3V0aWwvbWVzb24uYnVpbGQKQEAgLTY2LDcgKzY2LDkgQEAgaWYgaGF2ZV9ibG9jawogICB1dGls
X3NzLmFkZChmaWxlcygnbWFpbi1sb29wLmMnKSkKICAgdXRpbF9zcy5hZGQoZmlsZXMoJ252ZGlt
bS11dGlscy5jJykpCiAgIHV0aWxfc3MuYWRkKGZpbGVzKCdxZW11LWNvcm91dGluZS5jJywgJ3Fl
bXUtY29yb3V0aW5lLWxvY2suYycsICdxZW11LWNvcm91dGluZS1pby5jJykpCi0gIHV0aWxfc3Mu
YWRkKHdoZW46ICdDT05GSUdfTElOVVgnLCBpZl90cnVlOiBmaWxlcygndmhvc3QtdXNlci1zZXJ2
ZXIuYycpKQorICB1dGlsX3NzLmFkZCh3aGVuOiBbJ0NPTkZJR19MSU5VWCcsICdDT05GSUdfVkhP
U1RfVVNFUiddLCBpZl90cnVlOiBbCisgICAgZmlsZXMoJ3Zob3N0LXVzZXItc2VydmVyLmMnKSwg
dmhvc3RfdXNlcgorICBdKQogICB1dGlsX3NzLmFkZChmaWxlcygnYmxvY2staGVscGVycy5jJykp
CiAgIHV0aWxfc3MuYWRkKGZpbGVzKCdxZW11LWNvcm91dGluZS1zbGVlcC5jJykpCiAgIHV0aWxf
c3MuYWRkKGZpbGVzKCdxZW11LWNvLXNoYXJlZC1yZXNvdXJjZS5jJykpCi0tIAoyLjI2LjIKCg==


