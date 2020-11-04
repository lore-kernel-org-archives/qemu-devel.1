Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824F920732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AelltDVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824F920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKxd-0000j1-Ii
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKc2-0000Vg-CB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKc0-0008TM-0e
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AFHdjTsEEWyU+9Ji73dICGnEMrarbV23JrcVT7tAvA=;
 b=AelltDVdVBK3HA3q1su9+SkEyqrYa+1590bwNqbmqv0oCteqUngLoE8EBE73Er3DvhdqO6
 clS/ZB3qo5PPJZNv2PgRrUksWN8rMBQxlSwB+AU+RUvW3PM4ucobz477yDbDl8H67FxqAb
 rh1BCeMu832YV0xUf1DYeSTzA4fXzPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-b6RACBuLMhOaRenmdG-Slg-1; Wed, 04 Nov 2020 10:22:09 -0500
X-MC-Unique: b6RACBuLMhOaRenmdG-Slg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B77081007284;
 Wed,  4 Nov 2020 15:22:07 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57AE360C84;
 Wed,  4 Nov 2020 15:22:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 33/33] util/vfio-helpers: Assert offset is aligned to page size
Date: Wed,  4 Nov 2020 15:18:28 +0000
Message-Id: <20201104151828.405824-34-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKbW1hcCgy
KSBzdGF0ZXM6CgogICdvZmZzZXQnIG11c3QgYmUgYSBtdWx0aXBsZSBvZiB0aGUgcGFnZSBzaXpl
IGFzIHJldHVybmVkCiAgIGJ5IHN5c2NvbmYoX1NDX1BBR0VfU0laRSkuCgpBZGQgYW4gYXNzZXJ0
aW9uIHRvIGJlIHN1cmUgd2UgZG9uJ3QgYnJlYWsgdGhpcyBjb250cmFjdC4KClNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1p
ZDogMjAyMDExMDMwMjA3MzMuMjMwMzE0OC04LXBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ci0tLQogdXRpbC92ZmlvLWhlbHBlcnMuYyB8
IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvdXRpbC92
ZmlvLWhlbHBlcnMuYyBiL3V0aWwvdmZpby1oZWxwZXJzLmMKaW5kZXggNzNmN2JmYTc1NC4uODA0
NzY4ZDVjNiAxMDA2NDQKLS0tIGEvdXRpbC92ZmlvLWhlbHBlcnMuYworKysgYi91dGlsL3ZmaW8t
aGVscGVycy5jCkBAIC0xNjIsNiArMTYyLDcgQEAgdm9pZCAqcWVtdV92ZmlvX3BjaV9tYXBfYmFy
KFFFTVVWRklPU3RhdGUgKnMsIGludCBpbmRleCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBFcnJvciAqKmVycnApCiB7CiAgICAgdm9pZCAqcDsKKyAgICBhc3NlcnQoUUVNVV9JU19BTElH
TkVEKG9mZnNldCwgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKSk7CiAgICAgYXNzZXJ0X2Jhcl9p
bmRleF92YWxpZChzLCBpbmRleCk7CiAgICAgcCA9IG1tYXAoTlVMTCwgTUlOKHNpemUsIHMtPmJh
cl9yZWdpb25faW5mb1tpbmRleF0uc2l6ZSAtIG9mZnNldCksCiAgICAgICAgICAgICAgcHJvdCwg
TUFQX1NIQVJFRCwKLS0gCjIuMjguMAoK


