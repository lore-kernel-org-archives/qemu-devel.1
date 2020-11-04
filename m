Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68239C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68E420732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fss+KHY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68E420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKy1-0000xO-Qq
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKc0-0000Rq-NM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKby-0008T1-SA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cH2CGoXWvm04g9eHJoqZTGGKfM5E7bMEhprVr3Z+0Y=;
 b=fss+KHY9iKOFreLL3tLr6aXirsB4Hu24HfwuJKMRjmnLJ5/EZuYMZfH9ovKSRGYUvu+q4F
 +aUu8PiYS3WAKdkzKf4TUoixjER1xXJOQUReE5YlPMVO3CHZ0oMSiVgpzo9L0s5JwvHpXZ
 RyyI/boP2bDVoNAuSxQI0aJ/H8HAWRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-VWXyczpqOUmLid0zwfx0aw-1; Wed, 04 Nov 2020 10:22:07 -0500
X-MC-Unique: VWXyczpqOUmLid0zwfx0aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA151099F65;
 Wed,  4 Nov 2020 15:22:05 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CEE35D9CC;
 Wed,  4 Nov 2020 15:21:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/33] util/vfio-helpers: Convert vfio_dump_mapping to trace
 events
Date: Wed,  4 Nov 2020 15:18:27 +0000
Message-Id: <20201104151828.405824-33-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVGhlIFFF
TVVfVkZJT19ERUJVRyBkZWZpbml0aW9uIGlzIG9ubHkgbW9kaWZpYWJsZSBhdCBidWlsZC10aW1l
LgpUcmFjZSBldmVudHMgY2FuIGJlIGVuYWJsZWQgYXQgcnVuLXRpbWUuIEFzIHdlIHByZWZlciB0
aGUgbGF0dGVyLApjb252ZXJ0IHFlbXVfdmZpb19kdW1wX21hcHBpbmdzKCkgdG8gdXNlIHRyYWNl
IGV2ZW50cyBpbnN0ZWFkCm9mIGZwcmludGYoKS4KClJldmlld2VkLWJ5OiBGYW0gWmhlbmcgPGZh
bUBldXBob24ubmV0PgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJl
ZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAxMTAzMDIwNzMzLjIzMDMxNDgtNy1waGlsbWRAcmVk
aGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5j
b20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgotLS0KIHV0
aWwvdmZpby1oZWxwZXJzLmMgfCAxOSArKysrLS0tLS0tLS0tLS0tLS0tCiB1dGlsL3RyYWNlLWV2
ZW50cyAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvdmZpby1oZWxwZXJzLmMgYi91dGlsL3ZmaW8taGVs
cGVycy5jCmluZGV4IGMyNGE1MTBkZjguLjczZjdiZmE3NTQgMTAwNjQ0Ci0tLSBhL3V0aWwvdmZp
by1oZWxwZXJzLmMKKysrIGIvdXRpbC92ZmlvLWhlbHBlcnMuYwpAQCAtNTIxLDIzICs1MjEsMTIg
QEAgUUVNVVZGSU9TdGF0ZSAqcWVtdV92ZmlvX29wZW5fcGNpKGNvbnN0IGNoYXIgKmRldmljZSwg
RXJyb3IgKiplcnJwKQogICAgIHJldHVybiBzOwogfQogCi1zdGF0aWMgdm9pZCBxZW11X3ZmaW9f
ZHVtcF9tYXBwaW5nKElPVkFNYXBwaW5nICptKQotewotICAgIGlmIChRRU1VX1ZGSU9fREVCVUcp
IHsKLSAgICAgICAgcHJpbnRmKCIgIHZmaW8gbWFwcGluZyAlcCAlIiBQUkl4NjQgIiB0byAlIiBQ
Ukl4NjQgIlxuIiwgbS0+aG9zdCwKLSAgICAgICAgICAgICAgICh1aW50NjRfdCltLT5zaXplLCAo
dWludDY0X3QpbS0+aW92YSk7Ci0gICAgfQotfQotCiBzdGF0aWMgdm9pZCBxZW11X3ZmaW9fZHVt
cF9tYXBwaW5ncyhRRU1VVkZJT1N0YXRlICpzKQogewotICAgIGludCBpOwotCi0gICAgaWYgKFFF
TVVfVkZJT19ERUJVRykgewotICAgICAgICBwcmludGYoInZmaW8gbWFwcGluZ3NcbiIpOwotICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgcy0+bnJfbWFwcGluZ3M7ICsraSkgewotICAgICAgICAgICAg
cWVtdV92ZmlvX2R1bXBfbWFwcGluZygmcy0+bWFwcGluZ3NbaV0pOwotICAgICAgICB9CisgICAg
Zm9yIChpbnQgaSA9IDA7IGkgPCBzLT5ucl9tYXBwaW5nczsgKytpKSB7CisgICAgICAgIHRyYWNl
X3FlbXVfdmZpb19kdW1wX21hcHBpbmcocy0+bWFwcGluZ3NbaV0uaG9zdCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5tYXBwaW5nc1tpXS5pb3ZhLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMtPm1hcHBpbmdzW2ldLnNpemUpOwogICAgIH0K
IH0KIApkaWZmIC0tZ2l0IGEvdXRpbC90cmFjZS1ldmVudHMgYi91dGlsL3RyYWNlLWV2ZW50cwpp
bmRleCAwODIzOTk0MWNiLi42MWUwZDRiY2RmIDEwMDY0NAotLS0gYS91dGlsL3RyYWNlLWV2ZW50
cworKysgYi91dGlsL3RyYWNlLWV2ZW50cwpAQCAtODAsNiArODAsNyBAQCBxZW11X211dGV4X3Vu
bG9jayh2b2lkICptdXRleCwgY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmUpICJyZWxl
YXNlZCBtdXRleAogcWVtdV92ZmlvX2RtYV9yZXNldF90ZW1wb3Jhcnkodm9pZCAqcykgInMgJXAi
CiBxZW11X3ZmaW9fcmFtX2Jsb2NrX2FkZGVkKHZvaWQgKnMsIHZvaWQgKnAsIHNpemVfdCBzaXpl
KSAicyAlcCBob3N0ICVwIHNpemUgMHglengiCiBxZW11X3ZmaW9fcmFtX2Jsb2NrX3JlbW92ZWQo
dm9pZCAqcywgdm9pZCAqcCwgc2l6ZV90IHNpemUpICJzICVwIGhvc3QgJXAgc2l6ZSAweCV6eCIK
K3FlbXVfdmZpb19kdW1wX21hcHBpbmcodm9pZCAqaG9zdCwgdWludDY0X3QgaW92YSwgc2l6ZV90
IHNpemUpICJ2ZmlvIG1hcHBpbmcgJXAgdG8gaW92YSAweCUwOCIgUFJJeDY0ICIgc2l6ZSAweCV6
eCIKIHFlbXVfdmZpb19maW5kX21hcHBpbmcodm9pZCAqcywgdm9pZCAqcCkgInMgJXAgaG9zdCAl
cCIKIHFlbXVfdmZpb19uZXdfbWFwcGluZyh2b2lkICpzLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6
ZSwgaW50IGluZGV4LCB1aW50NjRfdCBpb3ZhKSAicyAlcCBob3N0ICVwIHNpemUgMHglenggaW5k
ZXggJWQgaW92YSAweCUiUFJJeDY0CiBxZW11X3ZmaW9fZG9fbWFwcGluZyh2b2lkICpzLCB2b2lk
ICpob3N0LCB1aW50NjRfdCBpb3ZhLCBzaXplX3Qgc2l6ZSkgInMgJXAgaG9zdCAlcCA8LT4gaW92
YSAweCUiUFJJeDY0ICIgc2l6ZSAweCV6eCIKLS0gCjIuMjguMAoK


