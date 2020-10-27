Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8447C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CC622264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVkmzTpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CC622264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSzj-00054h-Po
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStV-0005sM-BY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStR-0003HJ-TS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4EqVGA1hx1j5MwW5SbLdyLuc+AozpdN4r26zP1PQdU=;
 b=FVkmzTpyQR74efuMYh15xuoo68/phy4GHOZ9DWKZS63zZ925edjIvzlOHT/IAnEd+i99Ob
 Hvc5Zw7mdLJPWWs7bAG+KUqFJQEfoOF2x6lZOawuOhhWSYph7ZOXmDy6/JwfJiYgpu5mOj
 LMLUgcuoRqlx26bUAWCi+m/0bumqt+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-HhAaCz4YPbe_pMSsB6msTQ-1; Tue, 27 Oct 2020 13:36:18 -0400
X-MC-Unique: HhAaCz4YPbe_pMSsB6msTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26486100F955;
 Tue, 27 Oct 2020 17:36:15 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 324B67D4FA;
 Tue, 27 Oct 2020 17:36:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] configure: introduce --enable-vhost-user-blk-server
Date: Tue, 27 Oct 2020 17:35:18 +0000
Message-Id: <20201027173528.213464-3-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBjb21waWxlIG91dCB0aGUgdmhvc3QtdXNlci1ibGsgc2VydmVy
LiBJdCBpcyBlbmFibGVkCmJ5IGRlZmF1bHQgb24gTGludXguCgpOb3RlIHRoYXQgdmhvc3QtdXNl
ci1zZXJ2ZXIuYyBkZXBlbmRzIG9uIGxpYnZob3N0LXVzZXIsIHdoaWNoIHJlcXVpcmVzCkNPTkZJ
R19MSU5VWC4gVGhlIENPTkZJR19WSE9TVF9VU0VSIGRlcGVuZGVuY3kgd2FzIGVycm9uZW91cyBz
aW5jZSB0aGF0Cm9wdGlvbiBjb250cm9scyB2aG9zdC11c2VyIGZyb250ZW5kcyAocHJldmlvdXNs
eSBrbm93biBhcyAibWFzdGVyIikgYW5kCm5vdCBkZXZpY2UgYmFja2VuZHMgKHByZXZpb3VzbHkg
a25vd24gYXMgInNsYXZlIikuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogY29uZmlndXJlICAgICAgICAgICAgICAgIHwgMTUgKysrKysr
KysrKysrKysrCiBibG9jay9leHBvcnQvZXhwb3J0LmMgICAgfCAgNCArKy0tCiBibG9jay9leHBv
cnQvbWVzb24uYnVpbGQgfCAgMiArLQogdXRpbC9tZXNvbi5idWlsZCAgICAgICAgIHwgIDIgKy0K
IDQgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9jb25maWd1cmUgYi9jb25maWd1cmUKaW5kZXggNTVlMDdjODJkZC4uYjQ1NWNhOGM3
ZiAxMDA3NTUKLS0tIGEvY29uZmlndXJlCisrKyBiL2NvbmZpZ3VyZQpAQCAtMzI4LDYgKzMyOCw3
IEBAIHZob3N0X2NyeXB0bz0iIgogdmhvc3Rfc2NzaT0iIgogdmhvc3RfdnNvY2s9IiIKIHZob3N0
X3VzZXI9IiIKK3Zob3N0X3VzZXJfYmxrX3NlcnZlcj0iIgogdmhvc3RfdXNlcl9mcz0iIgoga3Zt
PSJhdXRvIgogaGF4PSJhdXRvIgpAQCAtMTI0MCw2ICsxMjQxLDEwIEBAIGZvciBvcHQgZG8KICAg
OzsKICAgLS1lbmFibGUtdmhvc3QtdnNvY2spIHZob3N0X3Zzb2NrPSJ5ZXMiCiAgIDs7CisgIC0t
ZGlzYWJsZS12aG9zdC11c2VyLWJsay1zZXJ2ZXIpIHZob3N0X3VzZXJfYmxrX3NlcnZlcj0ibm8i
CisgIDs7CisgIC0tZW5hYmxlLXZob3N0LXVzZXItYmxrLXNlcnZlcikgdmhvc3RfdXNlcl9ibGtf
c2VydmVyPSJ5ZXMiCisgIDs7CiAgIC0tZGlzYWJsZS12aG9zdC11c2VyLWZzKSB2aG9zdF91c2Vy
X2ZzPSJubyIKICAgOzsKICAgLS1lbmFibGUtdmhvc3QtdXNlci1mcykgdmhvc3RfdXNlcl9mcz0i
eWVzIgpAQCAtMTc4NCw2ICsxNzg5LDcgQEAgZGlzYWJsZWQgd2l0aCAtLWRpc2FibGUtRkVBVFVS
RSwgZGVmYXVsdCBpcyBlbmFibGVkIGlmIGF2YWlsYWJsZToKICAgdmhvc3QtY3J5cHRvICAgIHZo
b3N0LXVzZXItY3J5cHRvIGJhY2tlbmQgc3VwcG9ydAogICB2aG9zdC1rZXJuZWwgICAgdmhvc3Qg
a2VybmVsIGJhY2tlbmQgc3VwcG9ydAogICB2aG9zdC11c2VyICAgICAgdmhvc3QtdXNlciBiYWNr
ZW5kIHN1cHBvcnQKKyAgdmhvc3QtdXNlci1ibGstc2VydmVyICAgIHZob3N0LXVzZXItYmxrIHNl
cnZlciBzdXBwb3J0CiAgIHZob3N0LXZkcGEgICAgICB2aG9zdC12ZHBhIGtlcm5lbCBiYWNrZW5k
IHN1cHBvcnQKICAgc3BpY2UgICAgICAgICAgIHNwaWNlCiAgIHJiZCAgICAgICAgICAgICByYWRv
cyBibG9jayBkZXZpY2UgKHJiZCkKQEAgLTIzNzUsNiArMjM4MSwxMiBAQCBpZiB0ZXN0ICIkdmhv
c3RfbmV0IiA9ICIiOyB0aGVuCiAgIHRlc3QgIiR2aG9zdF9rZXJuZWwiID0gInllcyIgJiYgdmhv
c3RfbmV0PXllcwogZmkKIAorIyBsaWJ2aG9zdC11c2VyIGlzIExpbnV4LW9ubHkKK3Rlc3QgIiR2
aG9zdF91c2VyX2Jsa19zZXJ2ZXIiID0gIiIgJiYgdmhvc3RfdXNlcl9ibGtfc2VydmVyPSRsaW51
eAoraWYgdGVzdCAiJHZob3N0X3VzZXJfYmxrX3NlcnZlciIgPSAieWVzIiAmJiB0ZXN0ICIkbGlu
dXgiID0gIm5vIjsgdGhlbgorICBlcnJvcl9leGl0ICItLWVuYWJsZS12aG9zdC11c2VyLWJsay1z
ZXJ2ZXIgaXMgb25seSBhdmFpbGFibGUgb24gTGludXgiCitmaQorCiAjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKICMgcGtnLWNvbmZpZyBwcm9iZQogCkBAIC02MjYw
LDYgKzYyNzIsOSBAQCBmaQogaWYgdGVzdCAiJHZob3N0X3ZkcGEiID0gInllcyIgOyB0aGVuCiAg
IGVjaG8gIkNPTkZJR19WSE9TVF9WRFBBPXkiID4+ICRjb25maWdfaG9zdF9tYWsKIGZpCitpZiB0
ZXN0ICIkdmhvc3RfdXNlcl9ibGtfc2VydmVyIiA9ICJ5ZXMiIDsgdGhlbgorICBlY2hvICJDT05G
SUdfVkhPU1RfVVNFUl9CTEtfU0VSVkVSPXkiID4+ICRjb25maWdfaG9zdF9tYWsKK2ZpCiBpZiB0
ZXN0ICIkdmhvc3RfdXNlcl9mcyIgPSAieWVzIiA7IHRoZW4KICAgZWNobyAiQ09ORklHX1ZIT1NU
X1VTRVJfRlM9eSIgPj4gJGNvbmZpZ19ob3N0X21hawogZmkKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4
cG9ydC9leHBvcnQuYyBiL2Jsb2NrL2V4cG9ydC9leHBvcnQuYwppbmRleCBjMzQ3OGM2Yzk3Li5i
YWQ2ZjIxYjFjIDEwMDY0NAotLS0gYS9ibG9jay9leHBvcnQvZXhwb3J0LmMKKysrIGIvYmxvY2sv
ZXhwb3J0L2V4cG9ydC5jCkBAIC0yMiwxMyArMjIsMTMgQEAKICNpbmNsdWRlICJxYXBpL3FhcGkt
Y29tbWFuZHMtYmxvY2stZXhwb3J0LmgiCiAjaW5jbHVkZSAicWFwaS9xYXBpLWV2ZW50cy1ibG9j
ay1leHBvcnQuaCIKICNpbmNsdWRlICJxZW11L2lkLmgiCi0jaWYgZGVmaW5lZChDT05GSUdfTElO
VVgpICYmIGRlZmluZWQoQ09ORklHX1ZIT1NUX1VTRVIpCisjaWZkZWYgQ09ORklHX1ZIT1NUX1VT
RVJfQkxLX1NFUlZFUgogI2luY2x1ZGUgInZob3N0LXVzZXItYmxrLXNlcnZlci5oIgogI2VuZGlm
CiAKIHN0YXRpYyBjb25zdCBCbG9ja0V4cG9ydERyaXZlciAqYmxrX2V4cF9kcml2ZXJzW10gPSB7
CiAgICAgJmJsa19leHBfbmJkLAotI2lmIGRlZmluZWQoQ09ORklHX0xJTlVYKSAmJiBkZWZpbmVk
KENPTkZJR19WSE9TVF9VU0VSKQorI2lmZGVmIENPTkZJR19WSE9TVF9VU0VSX0JMS19TRVJWRVIK
ICAgICAmYmxrX2V4cF92aG9zdF91c2VyX2JsaywKICNlbmRpZgogfTsKZGlmZiAtLWdpdCBhL2Js
b2NrL2V4cG9ydC9tZXNvbi5idWlsZCBiL2Jsb2NrL2V4cG9ydC9tZXNvbi5idWlsZAppbmRleCA5
ZmI0ZmJmODFkLi4xOTUyNjQzNWQ4IDEwMDY0NAotLS0gYS9ibG9jay9leHBvcnQvbWVzb24uYnVp
bGQKKysrIGIvYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkCkBAIC0xLDIgKzEsMiBAQAogYmxvY2tk
ZXZfc3MuYWRkKGZpbGVzKCdleHBvcnQuYycpKQotYmxvY2tkZXZfc3MuYWRkKHdoZW46IFsnQ09O
RklHX0xJTlVYJywgJ0NPTkZJR19WSE9TVF9VU0VSJ10sIGlmX3RydWU6IGZpbGVzKCd2aG9zdC11
c2VyLWJsay1zZXJ2ZXIuYycpKQorYmxvY2tkZXZfc3MuYWRkKHdoZW46ICdDT05GSUdfVkhPU1Rf
VVNFUl9CTEtfU0VSVkVSJywgaWZfdHJ1ZTogZmlsZXMoJ3Zob3N0LXVzZXItYmxrLXNlcnZlci5j
JykpCmRpZmYgLS1naXQgYS91dGlsL21lc29uLmJ1aWxkIGIvdXRpbC9tZXNvbi5idWlsZAppbmRl
eCBjNTE1OWFkNzlkLi5mMzU5YWYwZDQ2IDEwMDY0NAotLS0gYS91dGlsL21lc29uLmJ1aWxkCisr
KyBiL3V0aWwvbWVzb24uYnVpbGQKQEAgLTY2LDcgKzY2LDcgQEAgaWYgaGF2ZV9ibG9jawogICB1
dGlsX3NzLmFkZChmaWxlcygnbWFpbi1sb29wLmMnKSkKICAgdXRpbF9zcy5hZGQoZmlsZXMoJ252
ZGltbS11dGlscy5jJykpCiAgIHV0aWxfc3MuYWRkKGZpbGVzKCdxZW11LWNvcm91dGluZS5jJywg
J3FlbXUtY29yb3V0aW5lLWxvY2suYycsICdxZW11LWNvcm91dGluZS1pby5jJykpCi0gIHV0aWxf
c3MuYWRkKHdoZW46IFsnQ09ORklHX0xJTlVYJywgJ0NPTkZJR19WSE9TVF9VU0VSJ10sIGlmX3Ry
dWU6IFsKKyAgdXRpbF9zcy5hZGQod2hlbjogJ0NPTkZJR19MSU5VWCcsIGlmX3RydWU6IFsKICAg
ICBmaWxlcygndmhvc3QtdXNlci1zZXJ2ZXIuYycpLCB2aG9zdF91c2VyCiAgIF0pCiAgIHV0aWxf
c3MuYWRkKGZpbGVzKCdibG9jay1oZWxwZXJzLmMnKSkKLS0gCjIuMjYuMgoK


