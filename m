Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2EFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B74207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUmeQcbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B74207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtMr-0003sZ-Iv
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJj-0006yA-SB
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:29:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJj-00011x-24
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tc4tatkSWuWPC/3uFVfrX0ECJPTtXcM+j4bx9wkMw2A=;
 b=HUmeQcbA7yBZYktGxbskHWFyqf9+7/CCXZD+oYtHOc4ZMKAn3BKoPV7mP9GMgF7cMwMIsN
 IaEmktC01Hs8Moeld8YNWZXyaAJsif1u8gvtFZjbHGKIzi9wwUuDmYHt0YBpQjBVy1ewGV
 orb0Fio4wICfWyEp5jwkoVT/8xT2u14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-e73nnzV-PYitsc6LdM45yQ-1; Wed, 27 May 2020 06:29:42 -0400
X-MC-Unique: e73nnzV-PYitsc6LdM45yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E5C0460;
 Wed, 27 May 2020 10:29:41 +0000 (UTC)
Received: from localhost (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33D565C1B0;
 Wed, 27 May 2020 10:29:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] virtio-scsi: introduce a constant for fixed virtqueues
Date: Wed, 27 May 2020 11:29:22 +0100
Message-Id: <20200527102925.128013-3-stefanha@redhat.com>
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

VGhlIGV2ZW50IGFuZCBjb250cm9sIHZpcnRxdWV1ZXMgYXJlIGFsd2F5cyBwcmVzZW50LCByZWdh
cmRsZXNzIG9mIHRoZQptdWx0aS1xdWV1ZSBjb25maWd1cmF0aW9uLiAgRGVmaW5lIGEgY29uc3Rh
bnQgc28gdGhhdCB2aXJ0cXVldWUgbnVtYmVyCmNhbGN1bGF0aW9ucyBhcmUgZWFzaWVyIHRvIHJl
YWQuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
ClJldmlld2VkLWJ5OiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0LmNvbT4KLS0tCiBpbmNs
dWRlL2h3L3ZpcnRpby92aXJ0aW8tc2NzaS5oIHwgMyArKysKIGh3L3Njc2kvdmhvc3QtdXNlci1z
Y3NpLmMgICAgICAgfCAyICstCiBody9zY3NpL3ZpcnRpby1zY3NpLmMgICAgICAgICAgIHwgNyAr
KysrLS0tCiBody92aXJ0aW8vdmhvc3Qtc2NzaS1wY2kuYyAgICAgIHwgMyArKy0KIGh3L3ZpcnRp
by92aG9zdC11c2VyLXNjc2ktcGNpLmMgfCAzICsrLQogaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBj
aS5jICAgICB8IDMgKystCiA2IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNjc2kuaCBi
L2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1zY3NpLmgKaW5kZXggMjRlNzY4OTA5ZC4uOWYyOTNi
Y2I4MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNjc2kuaAorKysgYi9p
bmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tc2NzaS5oCkBAIC0zNiw2ICszNiw5IEBACiAjZGVmaW5l
IFZJUlRJT19TQ1NJX01BWF9UQVJHRVQgIDI1NQogI2RlZmluZSBWSVJUSU9fU0NTSV9NQVhfTFVO
ICAgICAxNjM4MwogCisvKiBOdW1iZXIgb2YgdmlydHF1ZXVlcyB0aGF0IGFyZSBhbHdheXMgcHJl
c2VudCAqLworI2RlZmluZSBWSVJUSU9fU0NTSV9WUV9OVU1fRklYRUQgICAgMgorCiB0eXBlZGVm
IHN0cnVjdCB2aXJ0aW9fc2NzaV9jbWRfcmVxIFZpcnRJT1NDU0lDbWRSZXE7CiB0eXBlZGVmIHN0
cnVjdCB2aXJ0aW9fc2NzaV9jbWRfcmVzcCBWaXJ0SU9TQ1NJQ21kUmVzcDsKIHR5cGVkZWYgc3Ry
dWN0IHZpcnRpb19zY3NpX2N0cmxfdG1mX3JlcSBWaXJ0SU9TQ1NJQ3RybFRNRlJlcTsKZGlmZiAt
LWdpdCBhL2h3L3Njc2kvdmhvc3QtdXNlci1zY3NpLmMgYi9ody9zY3NpL3Zob3N0LXVzZXItc2Nz
aS5jCmluZGV4IGNiYjVkOTc1OTkuLmY4YmQxNThjMzEgMTAwNjQ0Ci0tLSBhL2h3L3Njc2kvdmhv
c3QtdXNlci1zY3NpLmMKKysrIGIvaHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYwpAQCAtMTE1LDcg
KzExNSw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3VzZXJfc2NzaV9yZWFsaXplKERldmljZVN0YXRl
ICpkZXYsIEVycm9yICoqZXJycCkKICAgICAgICAgZ290byBmcmVlX3ZpcnRpbzsKICAgICB9CiAK
LSAgICB2c2MtPmRldi5udnFzID0gMiArIHZzLT5jb25mLm51bV9xdWV1ZXM7CisgICAgdnNjLT5k
ZXYubnZxcyA9IFZJUlRJT19TQ1NJX1ZRX05VTV9GSVhFRCArIHZzLT5jb25mLm51bV9xdWV1ZXM7
CiAgICAgdnNjLT5kZXYudnFzID0gZ19uZXcwKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUsIHZzYy0+
ZGV2Lm52cXMpOwogICAgIHZzYy0+ZGV2LnZxX2luZGV4ID0gMDsKICAgICB2c2MtPmRldi5iYWNr
ZW5kX2ZlYXR1cmVzID0gMDsKZGlmZiAtLWdpdCBhL2h3L3Njc2kvdmlydGlvLXNjc2kuYyBiL2h3
L3Njc2kvdmlydGlvLXNjc2kuYwppbmRleCA5YjcyMDk0YTYxLi5mM2Q2MDY4M2JkIDEwMDY0NAot
LS0gYS9ody9zY3NpL3ZpcnRpby1zY3NpLmMKKysrIGIvaHcvc2NzaS92aXJ0aW8tc2NzaS5jCkBA
IC0xOTEsNyArMTkxLDcgQEAgc3RhdGljIHZvaWQgdmlydGlvX3Njc2lfc2F2ZV9yZXF1ZXN0KFFF
TVVGaWxlICpmLCBTQ1NJUmVxdWVzdCAqc3JlcSkKICAgICBWaXJ0SU9TQ1NJUmVxICpyZXEgPSBz
cmVxLT5oYmFfcHJpdmF0ZTsKICAgICBWaXJ0SU9TQ1NJQ29tbW9uICp2cyA9IFZJUlRJT19TQ1NJ
X0NPTU1PTihyZXEtPmRldik7CiAgICAgVmlydElPRGV2aWNlICp2ZGV2ID0gVklSVElPX0RFVklD
RShyZXEtPmRldik7Ci0gICAgdWludDMyX3QgbiA9IHZpcnRpb19nZXRfcXVldWVfaW5kZXgocmVx
LT52cSkgLSAyOworICAgIHVpbnQzMl90IG4gPSB2aXJ0aW9fZ2V0X3F1ZXVlX2luZGV4KHJlcS0+
dnEpIC0gVklSVElPX1NDU0lfVlFfTlVNX0ZJWEVEOwogCiAgICAgYXNzZXJ0KG4gPCB2cy0+Y29u
Zi5udW1fcXVldWVzKTsKICAgICBxZW11X3B1dF9iZTMycyhmLCAmbik7CkBAIC04OTIsMTAgKzg5
MiwxMSBAQCB2b2lkIHZpcnRpb19zY3NpX2NvbW1vbl9yZWFsaXplKERldmljZVN0YXRlICpkZXYs
CiAgICAgICAgICAgICAgICAgc2l6ZW9mKFZpcnRJT1NDU0lDb25maWcpKTsKIAogICAgIGlmIChz
LT5jb25mLm51bV9xdWV1ZXMgPT0gMCB8fAotICAgICAgICAgICAgcy0+Y29uZi5udW1fcXVldWVz
ID4gVklSVElPX1FVRVVFX01BWCAtIDIpIHsKKyAgICAgICAgICAgIHMtPmNvbmYubnVtX3F1ZXVl
cyA+IFZJUlRJT19RVUVVRV9NQVggLSBWSVJUSU9fU0NTSV9WUV9OVU1fRklYRUQpIHsKICAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCBudW1iZXIgb2YgcXVldWVzICg9ICUiIFBSSXUz
MiAiKSwgIgogICAgICAgICAgICAgICAgICAgICAgICAgICJtdXN0IGJlIGEgcG9zaXRpdmUgaW50
ZWdlciBsZXNzIHRoYW4gJWQuIiwKLSAgICAgICAgICAgICAgICAgICBzLT5jb25mLm51bV9xdWV1
ZXMsIFZJUlRJT19RVUVVRV9NQVggLSAyKTsKKyAgICAgICAgICAgICAgICAgICBzLT5jb25mLm51
bV9xdWV1ZXMsCisgICAgICAgICAgICAgICAgICAgVklSVElPX1FVRVVFX01BWCAtIFZJUlRJT19T
Q1NJX1ZRX05VTV9GSVhFRCk7CiAgICAgICAgIHZpcnRpb19jbGVhbnVwKHZkZXYpOwogICAgICAg
ICByZXR1cm47CiAgICAgfQpkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNjc2ktcGNpLmMg
Yi9ody92aXJ0aW8vdmhvc3Qtc2NzaS1wY2kuYwppbmRleCA1ZGE2YmI2NDQ5Li4yYjI1ZGI5YTNj
IDEwMDY0NAotLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2NzaS1wY2kuYworKysgYi9ody92aXJ0aW8v
dmhvc3Qtc2NzaS1wY2kuYwpAQCAtNTAsNyArNTAsOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF9zY3Np
X3BjaV9yZWFsaXplKFZpcnRJT1BDSVByb3h5ICp2cGNpX2RldiwgRXJyb3IgKiplcnJwKQogICAg
IFZpcnRJT1NDU0lDb21tb24gKnZzID0gVklSVElPX1NDU0lfQ09NTU9OKHZkZXYpOwogCiAgICAg
aWYgKHZwY2lfZGV2LT5udmVjdG9ycyA9PSBERVZfTlZFQ1RPUlNfVU5TUEVDSUZJRUQpIHsKLSAg
ICAgICAgdnBjaV9kZXYtPm52ZWN0b3JzID0gdnMtPmNvbmYubnVtX3F1ZXVlcyArIDM7CisgICAg
ICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IHZzLT5jb25mLm51bV9xdWV1ZXMgKworICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBWSVJUSU9fU0NTSV9WUV9OVU1fRklYRUQgKyAxOwogICAgIH0K
IAogICAgIHFkZXZfc2V0X3BhcmVudF9idXModmRldiwgQlVTKCZ2cGNpX2Rldi0+YnVzKSk7CmRp
ZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdXNlci1zY3NpLXBjaS5jIGIvaHcvdmlydGlvL3Zo
b3N0LXVzZXItc2NzaS1wY2kuYwppbmRleCA2ZjMzNzVmZTU1Li44MDcxMGFiMTcwIDEwMDY0NAot
LS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci1zY3NpLXBjaS5jCisrKyBiL2h3L3ZpcnRpby92aG9z
dC11c2VyLXNjc2ktcGNpLmMKQEAgLTU2LDcgKzU2LDggQEAgc3RhdGljIHZvaWQgdmhvc3RfdXNl
cl9zY3NpX3BjaV9yZWFsaXplKFZpcnRJT1BDSVByb3h5ICp2cGNpX2RldiwgRXJyb3IgKiplcnJw
KQogICAgIFZpcnRJT1NDU0lDb21tb24gKnZzID0gVklSVElPX1NDU0lfQ09NTU9OKHZkZXYpOwog
CiAgICAgaWYgKHZwY2lfZGV2LT5udmVjdG9ycyA9PSBERVZfTlZFQ1RPUlNfVU5TUEVDSUZJRUQp
IHsKLSAgICAgICAgdnBjaV9kZXYtPm52ZWN0b3JzID0gdnMtPmNvbmYubnVtX3F1ZXVlcyArIDM7
CisgICAgICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IHZzLT5jb25mLm51bV9xdWV1ZXMgKworICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fU0NTSV9WUV9OVU1fRklYRUQgKyAxOwog
ICAgIH0KIAogICAgIHFkZXZfc2V0X3BhcmVudF9idXModmRldiwgQlVTKCZ2cGNpX2Rldi0+YnVz
KSk7CmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXNjc2ktcGNpLmMgYi9ody92aXJ0aW8v
dmlydGlvLXNjc2ktcGNpLmMKaW5kZXggZTgyZTdlNTY4MC4uYzUyZDY4MDUzYSAxMDA2NDQKLS0t
IGEvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5jCisrKyBiL2h3L3ZpcnRpby92aXJ0aW8tc2Nz
aS1wY2kuYwpAQCAtNTEsNyArNTEsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fc2NzaV9wY2lfcmVh
bGl6ZShWaXJ0SU9QQ0lQcm94eSAqdnBjaV9kZXYsIEVycm9yICoqZXJycCkKICAgICBjaGFyICpi
dXNfbmFtZTsKIAogICAgIGlmICh2cGNpX2Rldi0+bnZlY3RvcnMgPT0gREVWX05WRUNUT1JTX1VO
U1BFQ0lGSUVEKSB7Ci0gICAgICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IHZzLT5jb25mLm51bV9x
dWV1ZXMgKyAzOworICAgICAgICB2cGNpX2Rldi0+bnZlY3RvcnMgPSB2cy0+Y29uZi5udW1fcXVl
dWVzICsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX1NDU0lfVlFfTlVNX0ZJ
WEVEICsgMTsKICAgICB9CiAKICAgICAvKgotLSAKMi4yNS40Cgo=


