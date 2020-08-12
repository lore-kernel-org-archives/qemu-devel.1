Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07420C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22E420781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgFmkvra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22E420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5oLB-0004lC-UP
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5oK6-0003eg-F2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:49:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5oK3-00077X-LU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597229370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gUDQ32AHBp1nfSHgJ75ZEyv6YxqcPG2HqWc+zH5vGUw=;
 b=VgFmkvra85x7NlUacvTiAoBvs/ohORXCi9BL/2sASm1g3D9O2ZRjOhf/55xW09aQjoyHKi
 fXl+nGWHpA1mDY4FYn3OKvhooyWPgGGYK2IvKBshR/Eti4WgxqtZCZS94OJ56wiJJ+eHyE
 n/lcbSGsJyRDxlA7mECBAoMe6cqz6HE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-i4HzSOPkPAeHtL62HJTM-w-1; Wed, 12 Aug 2020 06:49:28 -0400
X-MC-Unique: i4HzSOPkPAeHtL62HJTM-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16A4101C8AA;
 Wed, 12 Aug 2020 10:49:26 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 067F810631E2;
 Wed, 12 Aug 2020 10:49:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] virtio: restore elem->in/out_sg after
 iov_discard_front/back()
Date: Wed, 12 Aug 2020 11:49:15 +0100
Message-Id: <20200812104918.107116-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qm90aCB2aXJ0aW8tYmxrIGFuZCB2aXJ0aW8tY3J5cHRvIHVzZSBkZXN0cnVjdGl2ZSBpb3ZfZGlz
Y2FyZF9mcm9udC9iYWNrKCkNCm9wZXJhdGlvbnMgb24gZWxlbS0+aW4vb3V0X3NnLiB2aXJ0cXVl
dWVfcHVzaCgpIGNhbGxzIGRtYV9tZW1vcnlfdW5tYXAoKSBvbiB0PQ0KaGUNCm1vZGlmaWVkIGlv
dmVjIGFycmF5cy4gVGhlIG1lbW9yeSBhZGRyZXNzZXMgbWF5IG5vdCBtYXRjaCB0aG9zZSBvcmln
aW5hbGx5DQptYXBwZWQgd2l0aCBkbWFfbWVtb3J5X21hcCgpLg0KDQpUaGlzIHJhaXNlcyBzZXZl
cmFsIGlzc3VlczoNCjEuIE1lbW9yeVJlZ2lvbiByZWZlcmVuY2VzIGNhbiBiZSBsZWFrZWQuDQoy
LiBEaXJ0eSBtZW1vcnkgbWF5IG5vdCBiZSB0cmFja2VkLg0KMy4gVGhlIG5vbi1SQU0gYm91bmNl
IGJ1ZmZlciBjYW4gYmUgbGVha2VkLg0KDQpUaGlzIHBhdGNoIHNlcmllcyBzb2x2ZXMgdGhlIGlz
c3VlIGluIHR3byB3YXlzOg0KMS4gdmlydGlvLWJsayB1c2VzIGEgbmV3IGlvdl9kaXNjYXJkX3Vu
ZG8oKSBBUEkgdG8gcmVzdG9yZSBpb3ZlYyBhcnJheXMuDQoyLiB2aXJ0aW8tY3J5cHRvIHVzZXMg
Z19tZW1kdXAoKSB0byBhdm9pZCBtb2RpZnlpbmcgdGhlIG9yaWdpbmFsIGlvdmVjIGFycmF5cy4N
Cg0KVGhlIGdfbWVtZHVwKCkgYXBwcm9hY2ggaXMgc2xvd2VyIHRoYW4gaW92X2Rpc2NhcmRfdW5k
bygpIGJ1dCBsZXNzDQpjb21wbGV4L2ZyYWdpbGUuIEkgYW0gbGVzcyBmYW1pbGlhciB3aXRoIHRo
ZSB2aXJ0aW8tY3J5cHRvIGNvZGUgYW5kIGl0IHVzZXMNCm1vcmUgY29tcGxleCBzZXF1ZW5jZXMg
b2YgaW92X2Rpc2NhcmRfZnJvbnQvYmFjaygpIGNhbGxzIHRoYW4gdmlydGlvLWJsay4gSWYNCmFu
eW9uZSBmZWVscyBsaWtlIG9wdGltaXppbmcgdmlydGlvLWNyeXB0bywgcGxlYXNlIGdvIGFoZWFk
Lg0KDQpUaGUgdmlydGlvLWJsayBidWcgd2FzIGZvdW5kIGJ5IEFsZXhhbmRlciBCdWxla292J3Mg
ZnV6emluZyBlZmZvcnQuIEkgZm91bmQgdD0NCmhlDQp2aXJ0aW8tY3J5cHRvIGJ1ZyB0aHJvdWdo
IGNvZGUgaW5zcGVjdGlvbi4NCg0KU3RlZmFuIEhham5vY3ppICgzKToNCiAgdXRpbC9pb3Y6IGFk
ZCBpb3ZfZGlzY2FyZF91bmRvKCkNCiAgdmlydGlvLWJsazogdW5kbyBkZXN0cnVjdGl2ZSBpb3Zf
ZGlzY2FyZF8qKCkgb3BlcmF0aW9ucw0KICB2aXJ0aW8tY3J5cHRvOiBkb24ndCBtb2RpZnkgZWxl
bS0+aW4vb3V0X3NnDQoNCiBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tYmxrLmggfCAgIDIgKw0K
IGluY2x1ZGUvcWVtdS9pb3YuaCAgICAgICAgICAgICB8ICAyMyArKysrKw0KIGh3L2Jsb2NrL3Zp
cnRpby1ibGsuYyAgICAgICAgICB8ICAgOSArLQ0KIGh3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMg
ICAgICB8ICAxNyArKystDQogdGVzdHMvdGVzdC1pb3YuYyAgICAgICAgICAgICAgIHwgMTY1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIHV0aWwvaW92LmMgICAgICAgICAgICAg
ICAgICAgICB8ICA1MCArKysrKysrKystDQogNiBmaWxlcyBjaGFuZ2VkLCAyNTcgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCg0KLS09MjANCjIuMjYuMg0KDQo=


