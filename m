Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D8DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B66620838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOcBTlQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B66620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2th-0003Eh-Aw
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Zq-000523-7y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Zo-0004I2-DP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MDskohJQMSq5qXNfK2qVL2vZ4k1Q0QegeQsO6DKwRI=;
 b=IOcBTlQewYKtyxjFrOfLM3O4VFWXF0mJU5HoOaCGuTePJiD2MrmAKEpm6pHOqzzeqj6sl/
 tlXk6xJUNjpbqizCM3+scyTBMERRytVmIXaodfkkB4TMoiGgVxqtb/WFDP1R9mu+Y4b0A5
 TQG7+rGpNO8qCZMnL9px9MeVnwxYS54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-1X6fbN74NYC0dscwGB_QgA-1; Mon, 12 Oct 2020 14:29:36 -0400
X-MC-Unique: 1X6fbN74NYC0dscwGB_QgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA85107B475;
 Mon, 12 Oct 2020 18:29:34 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ACEA6EF54;
 Mon, 12 Oct 2020 18:29:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 24/30] block/export: add vhost-user-blk multi-queue support
Date: Mon, 12 Oct 2020 19:27:54 +0100
Message-Id: <20201012182800.157697-25-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWxsb3cgdGhlIG51bWJlciBvZiBxdWV1ZXMgdG8gYmUgY29uZmlndXJlZCB1c2luZyAtLWV4cG9y
dAp2aG9zdC11c2VyLWJsayxudW0tcXVldWVzPU4uIFRoaXMgc2V0dGluZyBzaG91bGQgbWF0Y2gg
dGhlIFFFTVUgLS1kZXZpY2UKdmhvc3QtdXNlci1ibGstcGNpLG51bS1xdWV1ZXM9TiBzZXR0aW5n
IGJ1dCBRRU1VIHZob3N0LXVzZXItYmxrLmMgbG93ZXJzCml0cyBvd24gdmFsdWUgaWYgdGhlIHZo
b3N0LXVzZXItYmxrIGJhY2tlbmQgb2ZmZXJzIGZld2VyIHF1ZXVlcyB0aGFuClFFTVUuCgpUaGUg
dmhvc3QtdXNlci1ibGstc2VydmVyLmMgY29kZSBpcyBhbHJlYWR5IGNhcGFibGUgb2YgbXVsdGkt
cXVldWUuIEFsbAp2aXJ0cXVldWUgcHJvY2Vzc2luZyBydW5zIGluIHRoZSBzYW1lIEFpb0NvbnRl
eHQuIE5vIG5ldyBsb2NraW5nIGlzCm5lZWRlZC4KCkFkZCB0aGUgbnVtLXF1ZXVlcz1OIG9wdGlv
biBhbmQgc2V0IHRoZSBWSVJUSU9fQkxLX0ZfTVEgZmVhdHVyZSBiaXQuCk5vdGUgdGhhdCB0aGUg
ZmVhdHVyZSBiaXQgb25seSBhbm5vdW5jZXMgdGhlIHByZXNlbmNlIG9mIHRoZSBudW1fcXVldWVz
CmNvbmZpZ3VyYXRpb24gc3BhY2UgZmllbGQuIEl0IGRvZXMgbm90IHByb21pc2UgdGhhdCB0aGVy
ZSBpcyBtb3JlIHRoYW4gMQp2aXJ0cXVldWUsIHNvIHdlIGNhbiBzZXQgaXQgdW5jb25kaXRpb25h
bGx5LgoKSSB0ZXN0ZWQgbXVsdGktcXVldWUgYnkgcnVubmluZyBhIHJhbmRvbSByZWFkIGZpbyB0
ZXN0IHdpdGggbnVtam9icz00IG9uCmFuIC1zbXAgNCBndWVzdC4gQWZ0ZXIgdGhlIGJlbmNobWFy
ayBmaW5pc2hlZCB0aGUgZ3Vlc3QgL3Byb2MvaW50ZXJydXB0cwpmaWxlIHNob3dlZCBhY3Rpdml0
eSBvbiBhbGwgNCB2aXJ0aW8tYmxrIE1TSS1YLiBUaGUgL3N5cy9ibG9jay92ZGEvbXEvCmRpcmVj
dG9yeSBzaG93cyB0aGF0IExpbnV4IGJsay1tcSBoYXMgNCBxdWV1ZXMgY29uZmlndXJlZC4KCkFu
IGF1dG9tYXRlZCB0ZXN0IGlzIGluY2x1ZGVkIGluIHRoZSBuZXh0IGNvbW1pdC4KClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KQWNrZWQtYnk6IE1h
cmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDEwMDEx
NDQ2MDQuNTU5NzMzLTItc3RlZmFuaGFAcmVkaGF0LmNvbQpbRml4ZWQgYWNjaWRlbnRhbCB0YWIg
Y2hhcmFjdGVycyBhcyBzdWdnZXN0ZWQgYnkgTWFya3VzIEFybWJydXN0ZXIKLS1TdGVmYW5dClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBx
YXBpL2Jsb2NrLWV4cG9ydC5qc29uICAgICAgICAgICAgICAgfCAxMCArKysrKysrLS0tCiBibG9j
ay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgfCAyNCArKysrKysrKysrKysrKysrKyst
LS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9xYXBpL2Jsb2NrLWV4cG9ydC5qc29uIGIvcWFwaS9ibG9jay1leHBvcnQu
anNvbgppbmRleCA4YTRjZWQ4MTdmLi40ODBjNDk3NjkwIDEwMDY0NAotLS0gYS9xYXBpL2Jsb2Nr
LWV4cG9ydC5qc29uCisrKyBiL3FhcGkvYmxvY2stZXhwb3J0Lmpzb24KQEAgLTkzLDExICs5Mywx
NSBAQAogIyAgICAgICAgU29ja2V0QWRkcmVzcyB0eXBlcyBhcmUgc3VwcG9ydGVkLiBQYXNzZWQg
ZmRzIG11c3QgYmUgVU5JWCBkb21haW4KICMgICAgICAgIHNvY2tldHMuCiAjIEBsb2dpY2FsLWJs
b2NrLXNpemU6IExvZ2ljYWwgYmxvY2sgc2l6ZSBpbiBieXRlcy4gRGVmYXVsdHMgdG8gNTEyIGJ5
dGVzLgorIyBAbnVtLXF1ZXVlczogTnVtYmVyIG9mIHJlcXVlc3QgdmlydHF1ZXVlcy4gTXVzdCBi
ZSBncmVhdGVyIHRoYW4gMC4gRGVmYXVsdHMKKyMgICAgICAgICAgICAgIHRvIDEuCiAjCiAjIFNp
bmNlOiA1LjIKICMjCiB7ICdzdHJ1Y3QnOiAnQmxvY2tFeHBvcnRPcHRpb25zVmhvc3RVc2VyQmxr
JywKLSAgJ2RhdGEnOiB7ICdhZGRyJzogJ1NvY2tldEFkZHJlc3MnLCAnKmxvZ2ljYWwtYmxvY2st
c2l6ZSc6ICdzaXplJyB9IH0KKyAgJ2RhdGEnOiB7ICdhZGRyJzogJ1NvY2tldEFkZHJlc3MnLAor
CSAgICAnKmxvZ2ljYWwtYmxvY2stc2l6ZSc6ICdzaXplJywKKyAgICAgICAgICAgICcqbnVtLXF1
ZXVlcyc6ICd1aW50MTYnfSB9CiAKICMjCiAjIEBOYmRTZXJ2ZXJBZGRPcHRpb25zOgpAQCAtMjMz
LDggKzIzNyw4IEBACiB7ICd1bmlvbic6ICdCbG9ja0V4cG9ydE9wdGlvbnMnLAogICAnYmFzZSc6
IHsgJ3R5cGUnOiAnQmxvY2tFeHBvcnRUeXBlJywKICAgICAgICAgICAgICdpZCc6ICdzdHInLAot
CSAgICAnKmZpeGVkLWlvdGhyZWFkJzogJ2Jvb2wnLAotCSAgICAnKmlvdGhyZWFkJzogJ3N0cics
CisgICAgICAgICAgICAnKmZpeGVkLWlvdGhyZWFkJzogJ2Jvb2wnLAorICAgICAgICAgICAgJypp
b3RocmVhZCc6ICdzdHInLAogICAgICAgICAgICAgJ25vZGUtbmFtZSc6ICdzdHInLAogICAgICAg
ICAgICAgJyp3cml0YWJsZSc6ICdib29sJywKICAgICAgICAgICAgICcqd3JpdGV0aHJvdWdoJzog
J2Jvb2wnIH0sCmRpZmYgLS1naXQgYS9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVy
LmMgYi9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKaW5kZXggYTFjMzc1NDhl
MS4uMzg1YzA0ZGE3NSAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNl
cnZlci5jCisrKyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwpAQCAtMjEs
NyArMjEsNyBAQAogI2luY2x1ZGUgInV0aWwvYmxvY2staGVscGVycy5oIgogCiBlbnVtIHsKLSAg
ICBWSE9TVF9VU0VSX0JMS19NQVhfUVVFVUVTID0gMSwKKyAgICBWSE9TVF9VU0VSX0JMS19OVU1f
UVVFVUVTX0RFRkFVTFQgPSAxLAogfTsKIHN0cnVjdCB2aXJ0aW9fYmxrX2luaGRyIHsKICAgICB1
bnNpZ25lZCBjaGFyIHN0YXR1czsKQEAgLTI0Miw2ICsyNDIsNyBAQCBzdGF0aWMgdWludDY0X3Qg
dnVfYmxrX2dldF9mZWF0dXJlcyhWdURldiAqZGV2KQogICAgICAgICAgICAgICAgMXVsbCA8PCBW
SVJUSU9fQkxLX0ZfRElTQ0FSRCB8CiAgICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19CTEtf
Rl9XUklURV9aRVJPRVMgfAogICAgICAgICAgICAgICAgMXVsbCA8PCBWSVJUSU9fQkxLX0ZfQ09O
RklHX1dDRSB8CisgICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19CTEtfRl9NUSB8CiAgICAg
ICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19GX1ZFUlNJT05fMSB8CiAgICAgICAgICAgICAgICAx
dWxsIDw8IFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQyB8CiAgICAgICAgICAgICAgICAxdWxs
IDw8IFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYIHwKQEAgLTMzOCw3ICszMzksOSBAQCBzdGF0aWMg
dm9pZCBibGtfYWlvX2RldGFjaCh2b2lkICpvcGFxdWUpCiAKIHN0YXRpYyB2b2lkCiB2dV9ibGtf
aW5pdGlhbGl6ZV9jb25maWcoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcgKmNvbmZpZywgdWludDMyX3QgYmxr
X3NpemUpCisgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRpb19ibGtfY29uZmln
ICpjb25maWcsCisgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYmxrX3NpemUsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2X3QgbnVtX3F1ZXVlcykKIHsKICAgICBjb25m
aWctPmNhcGFjaXR5ID0gYmRydl9nZXRsZW5ndGgoYnMpID4+IEJEUlZfU0VDVE9SX0JJVFM7CiAg
ICAgY29uZmlnLT5ibGtfc2l6ZSA9IGJsa19zaXplOwpAQCAtMzQ2LDcgKzM0OSw3IEBAIHZ1X2Js
a19pbml0aWFsaXplX2NvbmZpZyhCbG9ja0RyaXZlclN0YXRlICpicywKICAgICBjb25maWctPnNl
Z19tYXggPSAxMjggLSAyOwogICAgIGNvbmZpZy0+bWluX2lvX3NpemUgPSAxOwogICAgIGNvbmZp
Zy0+b3B0X2lvX3NpemUgPSAxOwotICAgIGNvbmZpZy0+bnVtX3F1ZXVlcyA9IFZIT1NUX1VTRVJf
QkxLX01BWF9RVUVVRVM7CisgICAgY29uZmlnLT5udW1fcXVldWVzID0gbnVtX3F1ZXVlczsKICAg
ICBjb25maWctPm1heF9kaXNjYXJkX3NlY3RvcnMgPSAzMjc2ODsKICAgICBjb25maWctPm1heF9k
aXNjYXJkX3NlZyA9IDE7CiAgICAgY29uZmlnLT5kaXNjYXJkX3NlY3Rvcl9hbGlnbm1lbnQgPSBj
b25maWctPmJsa19zaXplID4+IDk7CkBAIC0zNjgsNiArMzcxLDcgQEAgc3RhdGljIGludCB2dV9i
bGtfZXhwX2NyZWF0ZShCbG9ja0V4cG9ydCAqZXhwLCBCbG9ja0V4cG9ydE9wdGlvbnMgKm9wdHMs
CiAgICAgQmxvY2tFeHBvcnRPcHRpb25zVmhvc3RVc2VyQmxrICp2dV9vcHRzID0gJm9wdHMtPnUu
dmhvc3RfdXNlcl9ibGs7CiAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7CiAgICAgdWludDY0
X3QgbG9naWNhbF9ibG9ja19zaXplOworICAgIHVpbnQxNl90IG51bV9xdWV1ZXMgPSBWSE9TVF9V
U0VSX0JMS19OVU1fUVVFVUVTX0RFRkFVTFQ7CiAKICAgICB2ZXhwLT53cml0YWJsZSA9IG9wdHMt
PndyaXRhYmxlOwogICAgIHZleHAtPmJsa2NmZy53Y2UgPSAwOwpAQCAtMzg1LDE1ICszODksMjMg
QEAgc3RhdGljIGludCB2dV9ibGtfZXhwX2NyZWF0ZShCbG9ja0V4cG9ydCAqZXhwLCBCbG9ja0V4
cG9ydE9wdGlvbnMgKm9wdHMsCiAgICAgfQogICAgIHZleHAtPmJsa19zaXplID0gbG9naWNhbF9i
bG9ja19zaXplOwogICAgIGJsa19zZXRfZ3Vlc3RfYmxvY2tfc2l6ZShleHAtPmJsaywgbG9naWNh
bF9ibG9ja19zaXplKTsKKworICAgIGlmICh2dV9vcHRzLT5oYXNfbnVtX3F1ZXVlcykgeworICAg
ICAgICBudW1fcXVldWVzID0gdnVfb3B0cy0+bnVtX3F1ZXVlczsKKyAgICB9CisgICAgaWYgKG51
bV9xdWV1ZXMgPT0gMCkgeworICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJudW0tcXVldWVzIG11
c3QgYmUgZ3JlYXRlciB0aGFuIDAiKTsKKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7CisgICAgfQor
CiAgICAgdnVfYmxrX2luaXRpYWxpemVfY29uZmlnKGJsa19icyhleHAtPmJsayksICZ2ZXhwLT5i
bGtjZmcsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9naWNhbF9ibG9ja19zaXpl
KTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9naWNhbF9ibG9ja19zaXplLCBudW1f
cXVldWVzKTsKIAogICAgIGJsa19hZGRfYWlvX2NvbnRleHRfbm90aWZpZXIoZXhwLT5ibGssIGJs
a19haW9fYXR0YWNoZWQsIGJsa19haW9fZGV0YWNoLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmV4cCk7CiAKICAgICBpZiAoIXZob3N0X3VzZXJfc2VydmVyX3N0YXJ0KCZ2ZXhw
LT52dV9zZXJ2ZXIsIHZ1X29wdHMtPmFkZHIsIGV4cC0+Y3R4LAotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9CTEtfTUFYX1FVRVVFUywgJnZ1X2Jsa19pZmFjZSwK
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycnApKSB7CisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBudW1fcXVldWVzLCAmdnVfYmxrX2lmYWNlLCBlcnJwKSkgewog
ICAgICAgICBibGtfcmVtb3ZlX2Fpb19jb250ZXh0X25vdGlmaWVyKGV4cC0+YmxrLCBibGtfYWlv
X2F0dGFjaGVkLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJsa19h
aW9fZGV0YWNoLCB2ZXhwKTsKICAgICAgICAgcmV0dXJuIC1FQUREUk5PVEFWQUlMOwotLSAKMi4y
Ni4yCgo=


