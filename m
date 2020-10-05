Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F058EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849B220639
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3R/gvHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849B220639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSjM-00023x-B8
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeK-0004pE-U7
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeI-00087s-SF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fe09e0wzgCch4/nr31tuc9W2tQkiE8JjpGSm4Q5eDO8=;
 b=H3R/gvHOyfpOzQ5Skigsxumq4pZkpMQ20El79qAGW18ak2k5xogEkFL9IsHF9yGma0bdQq
 Ec5ZoxB+9fIH7UKPv8Xr2EMCew5y8cp3h6JwbrTD+m5RKbpaLuXJGnUefsfIJIcFrE6+ei
 6XCtv+xnWlKhOreWrgvEKzoXr9tgE3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-cs6UsxjYP3qtvSaB0awiVA-1; Mon, 05 Oct 2020 11:43:35 -0400
X-MC-Unique: cs6UsxjYP3qtvSaB0awiVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E1D8730A0;
 Mon,  5 Oct 2020 15:43:34 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2228555770;
 Mon,  5 Oct 2020 15:43:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 02/17] block/nvme: Map doorbells pages write-only
Date: Mon,  5 Oct 2020 16:43:08 +0100
Message-Id: <20201005154323.31347-3-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKUGVyIHRo
ZSBkYXRhc2hlZXQgc2VjdGlvbnMgMy4xLjEzLzMuMS4xNDoKICAiVGhlIGhvc3Qgc2hvdWxkIG5v
dCByZWFkIHRoZSBkb29yYmVsbCByZWdpc3RlcnMuIgoKQXMgd2UgZG9uJ3QgbmVlZCByZWFkIGFj
Y2VzcywgbWFwIHRoZSBkb29yYmVsbHMgd2l0aCB3cml0ZS1vbmx5CnBlcm1pc3Npb24uIFdlIGtl
ZXAgYSByZWZlcmVuY2UgdG8gdGhpcyBtYXBwZWQgYWRkcmVzcyBpbiB0aGUKQkRSVk5WTWVTdGF0
ZSBzdHJ1Y3R1cmUuCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KTWVzc2FnZS1JZDogPDIwMjAwOTIyMDgzODIxLjU3ODUxOS0zLXBoaWxtZEBy
ZWRoYXQuY29tPgotLS0KIGJsb2NrL252bWUuYyB8IDI5ICsrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4IDVhNGRjNmE3
MjIuLjNjODM0ZGE4ZmUgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9ibG9jay9udm1l
LmMKQEAgLTMxLDcgKzMxLDcgQEAKICNkZWZpbmUgTlZNRV9TUV9FTlRSWV9CWVRFUyA2NAogI2Rl
ZmluZSBOVk1FX0NRX0VOVFJZX0JZVEVTIDE2CiAjZGVmaW5lIE5WTUVfUVVFVUVfU0laRSAxMjgK
LSNkZWZpbmUgTlZNRV9CQVJfU0laRSA4MTkyCisjZGVmaW5lIE5WTUVfRE9PUkJFTExfU0laRSA0
MDk2CiAKIC8qCiAgKiBXZSBoYXZlIHRvIGxlYXZlIG9uZSBzbG90IGVtcHR5IGFzIHRoYXQgaXMg
dGhlIGZ1bGwgcXVldWUgY2FzZSB3aGVyZQpAQCAtODQsMTAgKzg0LDYgQEAgdHlwZWRlZiBzdHJ1
Y3QgewogLyogTWVtb3J5IG1hcHBlZCByZWdpc3RlcnMgKi8KIHR5cGVkZWYgdm9sYXRpbGUgc3Ry
dWN0IHsKICAgICBOdm1lQmFyIGN0cmw7Ci0gICAgc3RydWN0IHsKLSAgICAgICAgdWludDMyX3Qg
c3FfdGFpbDsKLSAgICAgICAgdWludDMyX3QgY3FfaGVhZDsKLSAgICB9IGRvb3JiZWxsc1tdOwog
fSBOVk1lUmVnczsKIAogI2RlZmluZSBJTkRFWF9BRE1JTiAgICAgMApAQCAtMTAzLDYgKzk5LDEx
IEBAIHN0cnVjdCBCRFJWTlZNZVN0YXRlIHsKICAgICBBaW9Db250ZXh0ICphaW9fY29udGV4dDsK
ICAgICBRRU1VVkZJT1N0YXRlICp2ZmlvOwogICAgIE5WTWVSZWdzICpyZWdzOworICAgIC8qIE1l
bW9yeSBtYXBwZWQgcmVnaXN0ZXJzICovCisgICAgdm9sYXRpbGUgc3RydWN0IHsKKyAgICAgICAg
dWludDMyX3Qgc3FfdGFpbDsKKyAgICAgICAgdWludDMyX3QgY3FfaGVhZDsKKyAgICB9ICpkb29y
YmVsbHM7CiAgICAgLyogVGhlIHN1Ym1pc3Npb24vY29tcGxldGlvbiBxdWV1ZSBwYWlycy4KICAg
ICAgKiBbMF06IGFkbWluIHF1ZXVlLgogICAgICAqIFsxLi5dOiBpbyBxdWV1ZXMuCkBAIC0yNDcs
MTQgKzI0OCwxNCBAQCBzdGF0aWMgTlZNZVF1ZXVlUGFpciAqbnZtZV9jcmVhdGVfcXVldWVfcGFp
cihCRFJWTlZNZVN0YXRlICpzLAogICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxf
ZXJyKTsKICAgICAgICAgZ290byBmYWlsOwogICAgIH0KLSAgICBxLT5zcS5kb29yYmVsbCA9ICZz
LT5yZWdzLT5kb29yYmVsbHNbaWR4ICogcy0+ZG9vcmJlbGxfc2NhbGVdLnNxX3RhaWw7CisgICAg
cS0+c3EuZG9vcmJlbGwgPSAmcy0+ZG9vcmJlbGxzW2lkeCAqIHMtPmRvb3JiZWxsX3NjYWxlXS5z
cV90YWlsOwogCiAgICAgbnZtZV9pbml0X3F1ZXVlKHMsICZxLT5jcSwgc2l6ZSwgTlZNRV9DUV9F
TlRSWV9CWVRFUywgJmxvY2FsX2Vycik7CiAgICAgaWYgKGxvY2FsX2VycikgewogICAgICAgICBl
cnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsKICAgICAgICAgZ290byBmYWlsOwogICAg
IH0KLSAgICBxLT5jcS5kb29yYmVsbCA9ICZzLT5yZWdzLT5kb29yYmVsbHNbaWR4ICogcy0+ZG9v
cmJlbGxfc2NhbGVdLmNxX2hlYWQ7CisgICAgcS0+Y3EuZG9vcmJlbGwgPSAmcy0+ZG9vcmJlbGxz
W2lkeCAqIHMtPmRvb3JiZWxsX3NjYWxlXS5jcV9oZWFkOwogCiAgICAgcmV0dXJuIHE7CiBmYWls
OgpAQCAtNzEyLDEzICs3MTMsMTIgQEAgc3RhdGljIGludCBudm1lX2luaXQoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIGNvbnN0IGNoYXIgKmRldmljZSwgaW50IG5hbWVzcGFjZSwKICAgICAgICAgZ290
byBvdXQ7CiAgICAgfQogCi0gICAgcy0+cmVncyA9IHFlbXVfdmZpb19wY2lfbWFwX2JhcihzLT52
ZmlvLCAwLCAwLCBOVk1FX0JBUl9TSVpFLAorICAgIHMtPnJlZ3MgPSBxZW11X3ZmaW9fcGNpX21h
cF9iYXIocy0+dmZpbywgMCwgMCwgc2l6ZW9mKE52bWVCYXIpLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgZXJycCk7CiAgICAgaWYg
KCFzLT5yZWdzKSB7CiAgICAgICAgIHJldCA9IC1FSU5WQUw7CiAgICAgICAgIGdvdG8gb3V0Owog
ICAgIH0KLQogICAgIC8qIFBlcmZvcm0gaW5pdGlhbGl6ZSBzZXF1ZW5jZSBhcyBkZXNjcmliZWQg
aW4gTlZNZSBzcGVjICI3LjYuMQogICAgICAqIEluaXRpYWxpemF0aW9uIi4gKi8KIApAQCAtNzQ4
LDYgKzc0OCwxMyBAQCBzdGF0aWMgaW50IG52bWVfaW5pdChCbG9ja0RyaXZlclN0YXRlICpicywg
Y29uc3QgY2hhciAqZGV2aWNlLCBpbnQgbmFtZXNwYWNlLAogICAgICAgICB9CiAgICAgfQogCisg
ICAgcy0+ZG9vcmJlbGxzID0gcWVtdV92ZmlvX3BjaV9tYXBfYmFyKHMtPnZmaW8sIDAsIHNpemVv
ZihOdm1lQmFyKSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZN
RV9ET09SQkVMTF9TSVpFLCBQUk9UX1dSSVRFLCBlcnJwKTsKKyAgICBpZiAoIXMtPmRvb3JiZWxs
cykgeworICAgICAgICByZXQgPSAtRUlOVkFMOworICAgICAgICBnb3RvIG91dDsKKyAgICB9CisK
ICAgICAvKiBTZXQgdXAgYWRtaW4gcXVldWUuICovCiAgICAgcy0+cXVldWVzID0gZ19uZXcoTlZN
ZVF1ZXVlUGFpciAqLCAxKTsKICAgICBzLT5xdWV1ZXNbSU5ERVhfQURNSU5dID0gbnZtZV9jcmVh
dGVfcXVldWVfcGFpcihzLCBhaW9fY29udGV4dCwgMCwKQEAgLTg3Myw3ICs4ODAsOSBAQCBzdGF0
aWMgdm9pZCBudm1lX2Nsb3NlKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnMtPmlycV9ub3RpZmllcltNU0lYX1NIQVJFRF9JUlFfSURYXSwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCBOVUxMLCBOVUxMKTsKICAgICBldmVudF9ub3Rp
Zmllcl9jbGVhbnVwKCZzLT5pcnFfbm90aWZpZXJbTVNJWF9TSEFSRURfSVJRX0lEWF0pOwotICAg
IHFlbXVfdmZpb19wY2lfdW5tYXBfYmFyKHMtPnZmaW8sIDAsICh2b2lkICopcy0+cmVncywgMCwg
TlZNRV9CQVJfU0laRSk7CisgICAgcWVtdV92ZmlvX3BjaV91bm1hcF9iYXIocy0+dmZpbywgMCwg
KHZvaWQgKilzLT5kb29yYmVsbHMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KE52bWVCYXIpLCBOVk1FX0RPT1JCRUxMX1NJWkUpOworICAgIHFlbXVfdmZpb19wY2lfdW5tYXBf
YmFyKHMtPnZmaW8sIDAsICh2b2lkICopcy0+cmVncywgMCwgc2l6ZW9mKE52bWVCYXIpKTsKICAg
ICBxZW11X3ZmaW9fY2xvc2Uocy0+dmZpbyk7CiAKICAgICBnX2ZyZWUocy0+ZGV2aWNlKTsKLS0g
CjIuMjYuMgoK


