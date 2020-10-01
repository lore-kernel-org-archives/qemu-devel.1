Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC76EC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2433220780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+34vDQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2433220780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzva-0008ID-Vf
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNzqb-0003b6-Tj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNzqY-0002nJ-Uo
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNeHQoVA2L35DcRBRd+F87afg3Mh/4wlkWCIdSOSOVc=;
 b=A+34vDQwRpsaae/IDmvA0pNSCu5FQBkqNwbgn6i7ZnBfS8gsfohlDgXqlcMwSvuIAegfOj
 jG/kOZPPQs2ZgTMFR8A2/mzBRzeKnK329q6eBrEMNyqDD8UNyc2tEww0ykGMaPYxz0VVDv
 fYt+4SpKBM2Vr+ISA7udf5GHzrfp+Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-5VNBoQLeMduCe_RakCAmfg-1; Thu, 01 Oct 2020 10:46:11 -0400
X-MC-Unique: 5VNBoQLeMduCe_RakCAmfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3369081E20C;
 Thu,  1 Oct 2020 14:46:10 +0000 (UTC)
Received: from localhost (ovpn-115-144.ams2.redhat.com [10.36.115.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 223C319931;
 Thu,  1 Oct 2020 14:46:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] block/export: add vhost-user-blk multi-queue support
Date: Thu,  1 Oct 2020 15:46:03 +0100
Message-Id: <20201001144604.559733-2-stefanha@redhat.com>
In-Reply-To: <20201001144604.559733-1-stefanha@redhat.com>
References: <20201001144604.559733-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBxYXBpL2Js
b2NrLWV4cG9ydC5qc29uICAgICAgICAgICAgICAgfCAgNiArKysrKy0KIGJsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyB8IDI0ICsrKysrKysrKysrKysrKysrKy0tLS0tLQogMiBm
aWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3FhcGkvYmxvY2stZXhwb3J0Lmpzb24gYi9xYXBpL2Jsb2NrLWV4cG9ydC5qc29uCmluZGV4
IGE3OTNlMzRhZjkuLjE3MDIwZGUyNTcgMTAwNjQ0Ci0tLSBhL3FhcGkvYmxvY2stZXhwb3J0Lmpz
b24KKysrIGIvcWFwaS9ibG9jay1leHBvcnQuanNvbgpAQCAtOTMsMTEgKzkzLDE1IEBACiAjICAg
ICAgICBTb2NrZXRBZGRyZXNzIHR5cGVzIGFyZSBzdXBwb3J0ZWQuIFBhc3NlZCBmZHMgbXVzdCBi
ZSBVTklYIGRvbWFpbgogIyAgICAgICAgc29ja2V0cy4KICMgQGxvZ2ljYWwtYmxvY2stc2l6ZTog
TG9naWNhbCBibG9jayBzaXplIGluIGJ5dGVzLiBEZWZhdWx0cyB0byA1MTIgYnl0ZXMuCisjIEBu
dW0tcXVldWVzOiBOdW1iZXIgb2YgcmVxdWVzdCB2aXJ0cXVldWVzLiBNdXN0IGJlIGdyZWF0ZXIg
dGhhbiAwLiBEZWZhdWx0cworIyAgICAgICAgICAgICAgdG8gMS4KICMKICMgU2luY2U6IDUuMgog
IyMKIHsgJ3N0cnVjdCc6ICdCbG9ja0V4cG9ydE9wdGlvbnNWaG9zdFVzZXJCbGsnLAotICAnZGF0
YSc6IHsgJ2FkZHInOiAnU29ja2V0QWRkcmVzcycsICcqbG9naWNhbC1ibG9jay1zaXplJzogJ3Np
emUnIH0gfQorICAnZGF0YSc6IHsgJ2FkZHInOiAnU29ja2V0QWRkcmVzcycsCisJICAgICcqbG9n
aWNhbC1ibG9jay1zaXplJzogJ3NpemUnLAorICAgICAgICAgICAgJypudW0tcXVldWVzJzogJ3Vp
bnQxNid9IH0KIAogIyMKICMgQE5iZFNlcnZlckFkZE9wdGlvbnM6CmRpZmYgLS1naXQgYS9ibG9j
ay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgYi9ibG9jay9leHBvcnQvdmhvc3QtdXNl
ci1ibGstc2VydmVyLmMKaW5kZXggODEwNzJhNWE0Ni4uYmY4NGI0NWVjZCAxMDA2NDQKLS0tIGEv
YmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCisrKyBiL2Jsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwpAQCAtMjEsNyArMjEsNyBAQAogI2luY2x1ZGUgInV0aWwv
YmxvY2staGVscGVycy5oIgogCiBlbnVtIHsKLSAgICBWSE9TVF9VU0VSX0JMS19NQVhfUVVFVUVT
ID0gMSwKKyAgICBWSE9TVF9VU0VSX0JMS19OVU1fUVVFVUVTX0RFRkFVTFQgPSAxLAogfTsKIHN0
cnVjdCB2aXJ0aW9fYmxrX2luaGRyIHsKICAgICB1bnNpZ25lZCBjaGFyIHN0YXR1czsKQEAgLTI0
Miw2ICsyNDIsNyBAQCBzdGF0aWMgdWludDY0X3QgdnVfYmxrX2dldF9mZWF0dXJlcyhWdURldiAq
ZGV2KQogICAgICAgICAgICAgICAgMXVsbCA8PCBWSVJUSU9fQkxLX0ZfRElTQ0FSRCB8CiAgICAg
ICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19CTEtfRl9XUklURV9aRVJPRVMgfAogICAgICAgICAg
ICAgICAgMXVsbCA8PCBWSVJUSU9fQkxLX0ZfQ09ORklHX1dDRSB8CisgICAgICAgICAgICAgICAx
dWxsIDw8IFZJUlRJT19CTEtfRl9NUSB8CiAgICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19G
X1ZFUlNJT05fMSB8CiAgICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19SSU5HX0ZfSU5ESVJF
Q1RfREVTQyB8CiAgICAgICAgICAgICAgICAxdWxsIDw8IFZJUlRJT19SSU5HX0ZfRVZFTlRfSURY
IHwKQEAgLTMzNCw3ICszMzUsOSBAQCBzdGF0aWMgdm9pZCBibGtfYWlvX2RldGFjaCh2b2lkICpv
cGFxdWUpCiAKIHN0YXRpYyB2b2lkCiB2dV9ibGtfaW5pdGlhbGl6ZV9jb25maWcoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2Js
a19jb25maWcgKmNvbmZpZywgdWludDMyX3QgYmxrX3NpemUpCisgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZpcnRpb19ibGtfY29uZmlnICpjb25maWcsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgYmxrX3NpemUsCisgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDE2X3QgbnVtX3F1ZXVlcykKIHsKICAgICBjb25maWctPmNhcGFjaXR5ID0gYmRydl9nZXRsZW5n
dGgoYnMpID4+IEJEUlZfU0VDVE9SX0JJVFM7CiAgICAgY29uZmlnLT5ibGtfc2l6ZSA9IGJsa19z
aXplOwpAQCAtMzQyLDcgKzM0NSw3IEBAIHZ1X2Jsa19pbml0aWFsaXplX2NvbmZpZyhCbG9ja0Ry
aXZlclN0YXRlICpicywKICAgICBjb25maWctPnNlZ19tYXggPSAxMjggLSAyOwogICAgIGNvbmZp
Zy0+bWluX2lvX3NpemUgPSAxOwogICAgIGNvbmZpZy0+b3B0X2lvX3NpemUgPSAxOwotICAgIGNv
bmZpZy0+bnVtX3F1ZXVlcyA9IFZIT1NUX1VTRVJfQkxLX01BWF9RVUVVRVM7CisgICAgY29uZmln
LT5udW1fcXVldWVzID0gbnVtX3F1ZXVlczsKICAgICBjb25maWctPm1heF9kaXNjYXJkX3NlY3Rv
cnMgPSAzMjc2ODsKICAgICBjb25maWctPm1heF9kaXNjYXJkX3NlZyA9IDE7CiAgICAgY29uZmln
LT5kaXNjYXJkX3NlY3Rvcl9hbGlnbm1lbnQgPSBjb25maWctPmJsa19zaXplID4+IDk7CkBAIC0z
NjQsNiArMzY3LDcgQEAgc3RhdGljIGludCB2dV9ibGtfZXhwX2NyZWF0ZShCbG9ja0V4cG9ydCAq
ZXhwLCBCbG9ja0V4cG9ydE9wdGlvbnMgKm9wdHMsCiAgICAgQmxvY2tFeHBvcnRPcHRpb25zVmhv
c3RVc2VyQmxrICp2dV9vcHRzID0gJm9wdHMtPnUudmhvc3RfdXNlcl9ibGs7CiAgICAgRXJyb3Ig
KmxvY2FsX2VyciA9IE5VTEw7CiAgICAgdWludDY0X3QgbG9naWNhbF9ibG9ja19zaXplOworICAg
IHVpbnQxNl90IG51bV9xdWV1ZXMgPSBWSE9TVF9VU0VSX0JMS19OVU1fUVVFVUVTX0RFRkFVTFQ7
CiAKICAgICB2ZXhwLT53cml0YWJsZSA9IG9wdHMtPndyaXRhYmxlOwogICAgIHZleHAtPmJsa2Nm
Zy53Y2UgPSAwOwpAQCAtMzgxLDE2ICszODUsMjQgQEAgc3RhdGljIGludCB2dV9ibGtfZXhwX2Ny
ZWF0ZShCbG9ja0V4cG9ydCAqZXhwLCBCbG9ja0V4cG9ydE9wdGlvbnMgKm9wdHMsCiAgICAgfQog
ICAgIHZleHAtPmJsa19zaXplID0gbG9naWNhbF9ibG9ja19zaXplOwogICAgIGJsa19zZXRfZ3Vl
c3RfYmxvY2tfc2l6ZShleHAtPmJsaywgbG9naWNhbF9ibG9ja19zaXplKTsKKworICAgIGlmICh2
dV9vcHRzLT5oYXNfbnVtX3F1ZXVlcykgeworICAgICAgICBudW1fcXVldWVzID0gdnVfb3B0cy0+
bnVtX3F1ZXVlczsKKyAgICB9CisgICAgaWYgKG51bV9xdWV1ZXMgPT0gMCkgeworICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJudW0tcXVldWVzIG11c3QgYmUgZ3JlYXRlciB0aGFuIDAiKTsKKyAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7CisgICAgfQorCiAgICAgdnVfYmxrX2luaXRpYWxpemVfY29u
ZmlnKGJsa19icyhleHAtPmJsayksICZ2ZXhwLT5ibGtjZmcsCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbG9naWNhbF9ibG9ja19zaXplKTsKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbG9naWNhbF9ibG9ja19zaXplLCBudW1fcXVldWVzKTsKIAogICAgIGJsa19zZXRfYWxs
b3dfYWlvX2NvbnRleHRfY2hhbmdlKGV4cC0+YmxrLCB0cnVlKTsKICAgICBibGtfYWRkX2Fpb19j
b250ZXh0X25vdGlmaWVyKGV4cC0+YmxrLCBibGtfYWlvX2F0dGFjaGVkLCBibGtfYWlvX2RldGFj
aCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZleHApOwogCiAgICAgaWYgKCF2
aG9zdF91c2VyX3NlcnZlcl9zdGFydCgmdmV4cC0+dnVfc2VydmVyLCB2dV9vcHRzLT5hZGRyLCBl
eHAtPmN0eCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJfQkxL
X01BWF9RVUVVRVMsICZ2dV9ibGtfaWZhY2UsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlcnJwKSkgeworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnVtX3F1ZXVl
cywgJnZ1X2Jsa19pZmFjZSwgZXJycCkpIHsKICAgICAgICAgYmxrX3JlbW92ZV9haW9fY29udGV4
dF9ub3RpZmllcihleHAtPmJsaywgYmxrX2Fpb19hdHRhY2hlZCwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBibGtfYWlvX2RldGFjaCwgdmV4cCk7CiAgICAgICAgIHJl
dHVybiAtRUFERFJOT1RBVkFJTDsKLS0gCjIuMjYuMgoK


