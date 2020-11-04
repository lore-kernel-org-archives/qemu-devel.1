Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B6EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0BA206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4NBg8+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0BA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKud-0003o3-KG
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbp-00007z-4r
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbm-0008Pq-T3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/OR/Joj1lfC3YR1bSF0Av5jtRi+lNka4XhjiATL/DU=;
 b=b4NBg8+RGCftaGWeKaHGE+MCLQewScEjEBGqSVWqXwTGTSGwBgpbVu/bq8vdqK208dnbix
 h+T9qNODVP2ZfyXEhCXRSClkA6FnIfckbWNN0oGcTSUQqe1LmM8wkNQOITisBpFFAZWRKq
 zytf9TsXhpI5CCVPcqnd3W7vJV8Hipc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-VGrwqsxeMauHQ9gEV0mu1Q-1; Wed, 04 Nov 2020 10:21:50 -0500
X-MC-Unique: VGrwqsxeMauHQ9gEV0mu1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F153387951B;
 Wed,  4 Nov 2020 15:21:48 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EB8C6EF7E;
 Wed,  4 Nov 2020 15:21:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 29/33] util/vfio-helpers: Trace PCI BAR region info
Date: Wed,  4 Nov 2020 15:18:24 +0000
Message-Id: <20201104151828.405824-30-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKRm9yIGRl
YnVnIHB1cnBvc2UsIHRyYWNlIEJBUiByZWdpb25zIGluZm8uCgpSZXZpZXdlZC1ieTogRmFtIFpo
ZW5nIDxmYW1AZXVwaG9uLm5ldD4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTEwMzAyMDczMy4yMzAzMTQ4LTQtcGhp
bG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4K
LS0tCiB1dGlsL3ZmaW8taGVscGVycy5jIHwgOCArKysrKysrKwogdXRpbC90cmFjZS1ldmVudHMg
ICB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS91
dGlsL3ZmaW8taGVscGVycy5jIGIvdXRpbC92ZmlvLWhlbHBlcnMuYwppbmRleCAxZDRlZmFmY2Fh
Li5jZDYyODdjM2E5IDEwMDY0NAotLS0gYS91dGlsL3ZmaW8taGVscGVycy5jCisrKyBiL3V0aWwv
dmZpby1oZWxwZXJzLmMKQEAgLTEzNiw2ICsxMzYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNz
ZXJ0X2Jhcl9pbmRleF92YWxpZChRRU1VVkZJT1N0YXRlICpzLCBpbnQgaW5kZXgpCiAKIHN0YXRp
YyBpbnQgcWVtdV92ZmlvX3BjaV9pbml0X2JhcihRRU1VVkZJT1N0YXRlICpzLCBpbnQgaW5kZXgs
IEVycm9yICoqZXJycCkKIHsKKyAgICBnX2F1dG9mcmVlIGNoYXIgKmJhcm5hbWUgPSBOVUxMOwog
ICAgIGFzc2VydF9iYXJfaW5kZXhfdmFsaWQocywgaW5kZXgpOwogICAgIHMtPmJhcl9yZWdpb25f
aW5mb1tpbmRleF0gPSAoc3RydWN0IHZmaW9fcmVnaW9uX2luZm8pIHsKICAgICAgICAgLmluZGV4
ID0gVkZJT19QQ0lfQkFSMF9SRUdJT05fSU5ERVggKyBpbmRleCwKQEAgLTE0NSw2ICsxNDYsMTAg
QEAgc3RhdGljIGludCBxZW11X3ZmaW9fcGNpX2luaXRfYmFyKFFFTVVWRklPU3RhdGUgKnMsIGlu
dCBpbmRleCwgRXJyb3IgKiplcnJwKQogICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVy
cm5vLCAiRmFpbGVkIHRvIGdldCBCQVIgcmVnaW9uIGluZm8iKTsKICAgICAgICAgcmV0dXJuIC1l
cnJubzsKICAgICB9CisgICAgYmFybmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiYmFyWyVkXSIsIGlu
ZGV4KTsKKyAgICB0cmFjZV9xZW11X3ZmaW9fcmVnaW9uX2luZm8oYmFybmFtZSwgcy0+YmFyX3Jl
Z2lvbl9pbmZvW2luZGV4XS5vZmZzZXQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHMtPmJhcl9yZWdpb25faW5mb1tpbmRleF0uc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcy0+YmFyX3JlZ2lvbl9pbmZvW2luZGV4XS5jYXBfb2Zmc2V0KTsKIAogICAgIHJl
dHVybiAwOwogfQpAQCAtNDE2LDYgKzQyMSw5IEBAIHN0YXRpYyBpbnQgcWVtdV92ZmlvX2luaXRf
cGNpKFFFTVVWRklPU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmRldmljZSwKICAgICAgICAgcmV0ID0g
LWVycm5vOwogICAgICAgICBnb3RvIGZhaWw7CiAgICAgfQorICAgIHRyYWNlX3FlbXVfdmZpb19y
ZWdpb25faW5mbygiY29uZmlnIiwgcy0+Y29uZmlnX3JlZ2lvbl9pbmZvLm9mZnNldCwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+Y29uZmlnX3JlZ2lvbl9pbmZvLnNpemUsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMtPmNvbmZpZ19yZWdpb25faW5mby5jYXBf
b2Zmc2V0KTsKIAogICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHMtPmJhcl9yZWdpb25f
aW5mbyk7IGkrKykgewogICAgICAgICByZXQgPSBxZW11X3ZmaW9fcGNpX2luaXRfYmFyKHMsIGks
IGVycnApOwpkaWZmIC0tZ2l0IGEvdXRpbC90cmFjZS1ldmVudHMgYi91dGlsL3RyYWNlLWV2ZW50
cwppbmRleCA4ZDM2MTVlNzE3Li4wNzUzZTRhMGVkIDEwMDY0NAotLS0gYS91dGlsL3RyYWNlLWV2
ZW50cworKysgYi91dGlsL3RyYWNlLWV2ZW50cwpAQCAtODcsMyArODcsNCBAQCBxZW11X3ZmaW9f
ZG1hX21hcCh2b2lkICpzLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSwgYm9vbCB0ZW1wb3Jhcnks
IHVpbnQ2NF90ICppbwogcWVtdV92ZmlvX2RtYV91bm1hcCh2b2lkICpzLCB2b2lkICpob3N0KSAi
cyAlcCBob3N0ICVwIgogcWVtdV92ZmlvX3BjaV9yZWFkX2NvbmZpZyh2b2lkICpidWYsIGludCBv
ZnMsIGludCBzaXplLCB1aW50NjRfdCByZWdpb25fb2ZzLCB1aW50NjRfdCByZWdpb25fc2l6ZSkg
InJlYWQgY2ZnIHB0ciAlcCBvZnMgMHgleCBzaXplIDB4JXggKHJlZ2lvbiBhZGRyIDB4JSJQUkl4
NjQiIHNpemUgMHglIlBSSXg2NCIpIgogcWVtdV92ZmlvX3BjaV93cml0ZV9jb25maWcodm9pZCAq
YnVmLCBpbnQgb2ZzLCBpbnQgc2l6ZSwgdWludDY0X3QgcmVnaW9uX29mcywgdWludDY0X3QgcmVn
aW9uX3NpemUpICJ3cml0ZSBjZmcgcHRyICVwIG9mcyAweCV4IHNpemUgMHgleCAocmVnaW9uIGFk
ZHIgMHglIlBSSXg2NCIgc2l6ZSAweCUiUFJJeDY0IikiCitxZW11X3ZmaW9fcmVnaW9uX2luZm8o
Y29uc3QgY2hhciAqZGVzYywgdWludDY0X3QgcmVnaW9uX29mcywgdWludDY0X3QgcmVnaW9uX3Np
emUsIHVpbnQzMl90IGNhcF9vZmZzZXQpICJyZWdpb24gJyVzJyBhZGRyIDB4JSJQUkl4NjQiIHNp
emUgMHglIlBSSXg2NCIgY2FwX29mcyAweCUiUFJJeDMyCi0tIAoyLjI4LjAKCg==


