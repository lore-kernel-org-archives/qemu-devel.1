Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2A7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A332074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTTQla6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A332074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKwU-0006vX-JM
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbu-0000C7-So
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbs-0008RH-IP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibeTODLX+Mzom4ZToC9+tF5dVJPoyLG0M5njv6JL8uc=;
 b=MTTQla6dteCow/L0nchNFArQVYjebYpfxgukOXSYvOofYRq8CydAl+NYR+5Y8CeBBsJ/nt
 Xr32GeiJmJHgDeDZ5HtGlrlLNzkyafBR6b5rpHJz2wwLieF/K20E6CfK7oPtQETfTlYI6C
 4BDNZH4Mao7Kzx+Jhx1lXNLH7KWXlFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-4HcHifymMeqvaMKKdJjvng-1; Wed, 04 Nov 2020 10:21:59 -0500
X-MC-Unique: 4HcHifymMeqvaMKKdJjvng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0501868403;
 Wed,  4 Nov 2020 15:21:58 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 099FC60C84;
 Wed,  4 Nov 2020 15:21:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 31/33] util/vfio-helpers: Improve DMA trace events
Date: Wed,  4 Nov 2020 15:18:26 +0000
Message-Id: <20201104151828.405824-32-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
YnVnZ2luZyBwdXJwb3NlLCB0cmFjZSB3aGVyZSBETUEgcmVnaW9ucyBhcmUgbWFwcGVkLgoKUmV2
aWV3ZWQtYnk6IEZhbSBaaGVuZyA8ZmFtQGV1cGhvbi5uZXQ+ClJldmlld2VkLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDExMDMwMjA3
MzMuMjMwMzE0OC02LXBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpu
b2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+Ci0tLQogdXRpbC92ZmlvLWhlbHBlcnMuYyB8IDMgKystCiB1dGlsL3Ry
YWNlLWV2ZW50cyAgIHwgNSArKystLQogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC92ZmlvLWhlbHBlcnMuYyBiL3V0aWwv
dmZpby1oZWxwZXJzLmMKaW5kZXggMjc4YzU0OTAyZS4uYzI0YTUxMGRmOCAxMDA2NDQKLS0tIGEv
dXRpbC92ZmlvLWhlbHBlcnMuYworKysgYi91dGlsL3ZmaW8taGVscGVycy5jCkBAIC02MjcsNyAr
NjI3LDcgQEAgc3RhdGljIGludCBxZW11X3ZmaW9fZG9fbWFwcGluZyhRRU1VVkZJT1N0YXRlICpz
LCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSwKICAgICAgICAgLnZhZGRyID0gKHVpbnRwdHJfdClo
b3N0LAogICAgICAgICAuc2l6ZSA9IHNpemUsCiAgICAgfTsKLSAgICB0cmFjZV9xZW11X3ZmaW9f
ZG9fbWFwcGluZyhzLCBob3N0LCBzaXplLCBpb3ZhKTsKKyAgICB0cmFjZV9xZW11X3ZmaW9fZG9f
bWFwcGluZyhzLCBob3N0LCBpb3ZhLCBzaXplKTsKIAogICAgIGlmIChpb2N0bChzLT5jb250YWlu
ZXIsIFZGSU9fSU9NTVVfTUFQX0RNQSwgJmRtYV9tYXApKSB7CiAgICAgICAgIGVycm9yX3JlcG9y
dCgiVkZJT19NQVBfRE1BIGZhaWxlZDogJXMiLCBzdHJlcnJvcihlcnJubykpOwpAQCAtNzgzLDYg
Kzc4Myw3IEBAIGludCBxZW11X3ZmaW9fZG1hX21hcChRRU1VVkZJT1N0YXRlICpzLCB2b2lkICpo
b3N0LCBzaXplX3Qgc2l6ZSwKICAgICAgICAgICAgIH0KICAgICAgICAgfQogICAgIH0KKyAgICB0
cmFjZV9xZW11X3ZmaW9fZG1hX21hcHBlZChzLCBob3N0LCBpb3ZhMCwgc2l6ZSk7CiAgICAgaWYg
KGlvdmEpIHsKICAgICAgICAgKmlvdmEgPSBpb3ZhMDsKICAgICB9CmRpZmYgLS1naXQgYS91dGls
L3RyYWNlLWV2ZW50cyBiL3V0aWwvdHJhY2UtZXZlbnRzCmluZGV4IDUyZDQzY2RhM2YuLjA4MjM5
OTQxY2IgMTAwNjQ0Ci0tLSBhL3V0aWwvdHJhY2UtZXZlbnRzCisrKyBiL3V0aWwvdHJhY2UtZXZl
bnRzCkBAIC04Miw4ICs4Miw5IEBAIHFlbXVfdmZpb19yYW1fYmxvY2tfYWRkZWQodm9pZCAqcywg
dm9pZCAqcCwgc2l6ZV90IHNpemUpICJzICVwIGhvc3QgJXAgc2l6ZSAweCV6CiBxZW11X3ZmaW9f
cmFtX2Jsb2NrX3JlbW92ZWQodm9pZCAqcywgdm9pZCAqcCwgc2l6ZV90IHNpemUpICJzICVwIGhv
c3QgJXAgc2l6ZSAweCV6eCIKIHFlbXVfdmZpb19maW5kX21hcHBpbmcodm9pZCAqcywgdm9pZCAq
cCkgInMgJXAgaG9zdCAlcCIKIHFlbXVfdmZpb19uZXdfbWFwcGluZyh2b2lkICpzLCB2b2lkICpo
b3N0LCBzaXplX3Qgc2l6ZSwgaW50IGluZGV4LCB1aW50NjRfdCBpb3ZhKSAicyAlcCBob3N0ICVw
IHNpemUgMHglenggaW5kZXggJWQgaW92YSAweCUiUFJJeDY0Ci1xZW11X3ZmaW9fZG9fbWFwcGlu
Zyh2b2lkICpzLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSwgdWludDY0X3QgaW92YSkgInMgJXAg
aG9zdCAlcCBzaXplIDB4JXp4IGlvdmEgMHglIlBSSXg2NAotcWVtdV92ZmlvX2RtYV9tYXAodm9p
ZCAqcywgdm9pZCAqaG9zdCwgc2l6ZV90IHNpemUsIGJvb2wgdGVtcG9yYXJ5LCB1aW50NjRfdCAq
aW92YSkgInMgJXAgaG9zdCAlcCBzaXplIDB4JXp4IHRlbXBvcmFyeSAlZCBpb3ZhICVwIgorcWVt
dV92ZmlvX2RvX21hcHBpbmcodm9pZCAqcywgdm9pZCAqaG9zdCwgdWludDY0X3QgaW92YSwgc2l6
ZV90IHNpemUpICJzICVwIGhvc3QgJXAgPC0+IGlvdmEgMHglIlBSSXg2NCAiIHNpemUgMHglengi
CitxZW11X3ZmaW9fZG1hX21hcCh2b2lkICpzLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSwgYm9v
bCB0ZW1wb3JhcnksIHVpbnQ2NF90ICppb3ZhKSAicyAlcCBob3N0ICVwIHNpemUgMHglenggdGVt
cG9yYXJ5ICVkICZpb3ZhICVwIgorcWVtdV92ZmlvX2RtYV9tYXBwZWQodm9pZCAqcywgdm9pZCAq
aG9zdCwgdWludDY0X3QgaW92YSwgc2l6ZV90IHNpemUpICJzICVwIGhvc3QgJXAgPC0+IGlvdmEg
MHglIlBSSXg2NCIgc2l6ZSAweCV6eCIKIHFlbXVfdmZpb19kbWFfdW5tYXAodm9pZCAqcywgdm9p
ZCAqaG9zdCkgInMgJXAgaG9zdCAlcCIKIHFlbXVfdmZpb19wY2lfcmVhZF9jb25maWcodm9pZCAq
YnVmLCBpbnQgb2ZzLCBpbnQgc2l6ZSwgdWludDY0X3QgcmVnaW9uX29mcywgdWludDY0X3QgcmVn
aW9uX3NpemUpICJyZWFkIGNmZyBwdHIgJXAgb2ZzIDB4JXggc2l6ZSAweCV4IChyZWdpb24gYWRk
ciAweCUiUFJJeDY0IiBzaXplIDB4JSJQUkl4NjQiKSIKIHFlbXVfdmZpb19wY2lfd3JpdGVfY29u
ZmlnKHZvaWQgKmJ1ZiwgaW50IG9mcywgaW50IHNpemUsIHVpbnQ2NF90IHJlZ2lvbl9vZnMsIHVp
bnQ2NF90IHJlZ2lvbl9zaXplKSAid3JpdGUgY2ZnIHB0ciAlcCBvZnMgMHgleCBzaXplIDB4JXgg
KHJlZ2lvbiBhZGRyIDB4JSJQUkl4NjQiIHNpemUgMHglIlBSSXg2NCIpIgotLSAKMi4yOC4wCgo=


