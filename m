Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5532072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4nTTEYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5532072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKtj-0002eA-95
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbn-00005s-54
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbd-0008P2-2m
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gv3mjdz+uSzq+uJJFTus6NPzAUxrll/VVcJIM1JiH98=;
 b=P4nTTEYHi3PSB/2p+FhOQwsNQvJ68a317OW6+XAt10sdBuvp+ZJz3LELb3WiZhR9UsTeh1
 Cf4dbWan91rRD4RE8YznzBRL5HJRf71rGm/jhjGwILBHisnJF+RbvUPVO8RfktKvXzQieM
 AWERG93E2psO6LVSGnvMGb4LHpSiKQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-UDIu-vk-P92UN3ViJRjo8w-1; Wed, 04 Nov 2020 10:21:42 -0500
X-MC-Unique: UDIu-vk-P92UN3ViJRjo8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8BEF1899422;
 Wed,  4 Nov 2020 15:21:40 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D81519C4F;
 Wed,  4 Nov 2020 15:21:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/33] util/vfio-helpers: Trace PCI I/O config accesses
Date: Wed,  4 Nov 2020 15:18:23 +0000
Message-Id: <20201104151828.405824-29-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKV2Ugc29t
ZXRpbWUgZ2V0IGtlcm5lbCBwYW5pYyB3aXRoIHNvbWUgZGV2aWNlcyBvbiBBYXJjaDY0Cmhvc3Rz
LiBBbGV4IFdpbGxpYW1zb24gc3VnZ2VzdHMgaXQgbWlnaHQgYmUgYnJva2VuIFBDSWUKcm9vdCBj
b21wbGV4LiBBZGQgdHJhY2UgZXZlbnQgdG8gcmVjb3JkIHRoZSBsYXRlc3QgSS9PCmFjY2VzcyBi
ZWZvcmUgY3Jhc2hpbmcuIEluIGNhc2UsIGFzc2VydCBvdXIgYWNjZXNzZXMgYXJlCmFsaWduZWQu
CgpSZXZpZXdlZC1ieTogRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD4KUmV2aWV3ZWQtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTEw
MzAyMDczMy4yMzAzMTQ4LTMtcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVy
aWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL3ZmaW8taGVscGVycy5jIHwgOCArKysrKysr
KwogdXRpbC90cmFjZS1ldmVudHMgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3V0aWwvdmZpby1oZWxwZXJzLmMgYi91dGlsL3ZmaW8taGVs
cGVycy5jCmluZGV4IDE0YTU0OTUxMGYuLjFkNGVmYWZjYWEgMTAwNjQ0Ci0tLSBhL3V0aWwvdmZp
by1oZWxwZXJzLmMKKysrIGIvdXRpbC92ZmlvLWhlbHBlcnMuYwpAQCAtMjI3LDYgKzIyNywxMCBA
QCBzdGF0aWMgaW50IHFlbXVfdmZpb19wY2lfcmVhZF9jb25maWcoUUVNVVZGSU9TdGF0ZSAqcywg
dm9pZCAqYnVmLAogewogICAgIGludCByZXQ7CiAKKyAgICB0cmFjZV9xZW11X3ZmaW9fcGNpX3Jl
YWRfY29uZmlnKGJ1Ziwgb2ZzLCBzaXplLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcy0+Y29uZmlnX3JlZ2lvbl9pbmZvLm9mZnNldCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHMtPmNvbmZpZ19yZWdpb25faW5mby5zaXplKTsKKyAgICBhc3NlcnQo
UUVNVV9JU19BTElHTkVEKHMtPmNvbmZpZ19yZWdpb25faW5mby5vZmZzZXQgKyBvZnMsIHNpemUp
KTsKICAgICBkbyB7CiAgICAgICAgIHJldCA9IHByZWFkKHMtPmRldmljZSwgYnVmLCBzaXplLCBz
LT5jb25maWdfcmVnaW9uX2luZm8ub2Zmc2V0ICsgb2ZzKTsKICAgICB9IHdoaWxlIChyZXQgPT0g
LTEgJiYgZXJybm8gPT0gRUlOVFIpOwpAQCAtMjM3LDYgKzI0MSwxMCBAQCBzdGF0aWMgaW50IHFl
bXVfdmZpb19wY2lfd3JpdGVfY29uZmlnKFFFTVVWRklPU3RhdGUgKnMsIHZvaWQgKmJ1ZiwgaW50
IHNpemUsIGludAogewogICAgIGludCByZXQ7CiAKKyAgICB0cmFjZV9xZW11X3ZmaW9fcGNpX3dy
aXRlX2NvbmZpZyhidWYsIG9mcywgc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzLT5jb25maWdfcmVnaW9uX2luZm8ub2Zmc2V0LAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHMtPmNvbmZpZ19yZWdpb25faW5mby5zaXplKTsKKyAgICBhc3Nl
cnQoUUVNVV9JU19BTElHTkVEKHMtPmNvbmZpZ19yZWdpb25faW5mby5vZmZzZXQgKyBvZnMsIHNp
emUpKTsKICAgICBkbyB7CiAgICAgICAgIHJldCA9IHB3cml0ZShzLT5kZXZpY2UsIGJ1Ziwgc2l6
ZSwgcy0+Y29uZmlnX3JlZ2lvbl9pbmZvLm9mZnNldCArIG9mcyk7CiAgICAgfSB3aGlsZSAocmV0
ID09IC0xICYmIGVycm5vID09IEVJTlRSKTsKZGlmZiAtLWdpdCBhL3V0aWwvdHJhY2UtZXZlbnRz
IGIvdXRpbC90cmFjZS1ldmVudHMKaW5kZXggMjRjMzE4MDNiMC4uOGQzNjE1ZTcxNyAxMDA2NDQK
LS0tIGEvdXRpbC90cmFjZS1ldmVudHMKKysrIGIvdXRpbC90cmFjZS1ldmVudHMKQEAgLTg1LDMg
Kzg1LDUgQEAgcWVtdV92ZmlvX25ld19tYXBwaW5nKHZvaWQgKnMsIHZvaWQgKmhvc3QsIHNpemVf
dCBzaXplLCBpbnQgaW5kZXgsIHVpbnQ2NF90IGlvdmEKIHFlbXVfdmZpb19kb19tYXBwaW5nKHZv
aWQgKnMsIHZvaWQgKmhvc3QsIHNpemVfdCBzaXplLCB1aW50NjRfdCBpb3ZhKSAicyAlcCBob3N0
ICVwIHNpemUgMHglenggaW92YSAweCUiUFJJeDY0CiBxZW11X3ZmaW9fZG1hX21hcCh2b2lkICpz
LCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSwgYm9vbCB0ZW1wb3JhcnksIHVpbnQ2NF90ICppb3Zh
KSAicyAlcCBob3N0ICVwIHNpemUgMHglenggdGVtcG9yYXJ5ICVkIGlvdmEgJXAiCiBxZW11X3Zm
aW9fZG1hX3VubWFwKHZvaWQgKnMsIHZvaWQgKmhvc3QpICJzICVwIGhvc3QgJXAiCitxZW11X3Zm
aW9fcGNpX3JlYWRfY29uZmlnKHZvaWQgKmJ1ZiwgaW50IG9mcywgaW50IHNpemUsIHVpbnQ2NF90
IHJlZ2lvbl9vZnMsIHVpbnQ2NF90IHJlZ2lvbl9zaXplKSAicmVhZCBjZmcgcHRyICVwIG9mcyAw
eCV4IHNpemUgMHgleCAocmVnaW9uIGFkZHIgMHglIlBSSXg2NCIgc2l6ZSAweCUiUFJJeDY0Iiki
CitxZW11X3ZmaW9fcGNpX3dyaXRlX2NvbmZpZyh2b2lkICpidWYsIGludCBvZnMsIGludCBzaXpl
LCB1aW50NjRfdCByZWdpb25fb2ZzLCB1aW50NjRfdCByZWdpb25fc2l6ZSkgIndyaXRlIGNmZyBw
dHIgJXAgb2ZzIDB4JXggc2l6ZSAweCV4IChyZWdpb24gYWRkciAweCUiUFJJeDY0IiBzaXplIDB4
JSJQUkl4NjQiKSIKLS0gCjIuMjguMAoK


