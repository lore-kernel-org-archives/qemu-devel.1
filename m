Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14FCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C04822B45
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ed1SG1hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C04822B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2txH-0005zQ-Lz
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2twM-0004v0-Ep
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:13:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2twK-0007JM-0p
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596535978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wSCqjHdi68Jtiv4q31oG7P3Udn8fDEOtr8GKYHmOiyw=;
 b=ed1SG1hyJX6h3St40VNai3ichtSjit46z4bY+x41vHRH3eHPHYHd05nDA37IiZKt3cSuyc
 NVAYrP5GD3LqXCtP+hE4D6f98qtCEBBi9Icfim6vLoswWsGiWts4UREupfHQwejA+7bLj5
 Wu56ti7YMJjtncbKn/j0NDk6NYqy09Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-h87khE8tNKqOXvVOByWmlA-1; Tue, 04 Aug 2020 06:12:54 -0400
X-MC-Unique: h87khE8tNKqOXvVOByWmlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27AD3100CCC0;
 Tue,  4 Aug 2020 10:12:53 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71B0B19C4F;
 Tue,  4 Aug 2020 10:12:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] nvdimm: read-only file support
Date: Tue,  4 Aug 2020 11:12:41 +0100
Message-Id: <20200804101244.1283503-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlcmUgaXMgY3VycmVudGx5IG5vIHdheSB0byBiYWNrIGFuIE5WRElNTSB3aXRoIGEgcmVhZC1v
bmx5IGZpbGUgc28gaXQgY2FuIGJlDQpzYWZlbHkgc2hhcmVkIGJldHdlZW4gdW50cnVzdGVkIGd1
ZXN0cy4NCg0KSW50cm9kdWNlIGFuIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxyZWFkb25s
eT1vbnxvZmYgb3B0aW9uLg0KDQpKdWxpbyBNb250ZXMgc2VudCBhbiBlYXJsaWVyIHBhdGNoIGhl
cmU6DQpodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA3MDgyMTE5MzYuODAzNy0xLWp1bGlv
Lm1vbnRlc0BpbnRlbC5jb20vDQoNCkVyaWMgRXJuc3QgcmVxdWVzdGVkIHRoaXMgZmVhdHVyZSBh
Z2FpbiBmb3IgS2F0YSBDb250YWluZXJzIHNvIEkgZ2F2ZSBpdCBhIHRyeS4NCg0KU3RlZmFuIEhh
am5vY3ppICgzKToNCiAgbWVtb3J5OiBhZGQgcmVhZG9ubHkgc3VwcG9ydCB0byBtZW1vcnlfcmVn
aW9uX2luaXRfcmFtX2Zyb21fZmlsZSgpDQogIGhvc3RtZW0tZmlsZTogYWRkIHJlYWRvbmx5PW9u
fG9mZiBvcHRpb24NCiAgbnZkaW1tOiBob25vciAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLWZpbGUs
cmVhZG9ubHk9b24gb3B0aW9uDQoNCiBkb2NzL252ZGltbS50eHQgICAgICAgICAgIHwgIDggKysr
KysrKy0NCiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggICAgIHwgIDIgKysNCiBpbmNsdWRlL2V4ZWMv
cmFtX2FkZHIuaCAgIHwgIDUgKysrLS0NCiBpbmNsdWRlL3FlbXUvbW1hcC1hbGxvYy5oIHwgIDIg
KysNCiBiYWNrZW5kcy9ob3N0bWVtLWZpbGUuYyAgIHwgMjYgKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCiBleGVjLmMgICAgICAgICAgICAgICAgICAgIHwgMTggKysrKysrKysrKystLS0tLS0t
DQogaHcvbWVtL252ZGltbS5jICAgICAgICAgICB8ICA0ICsrKysNCiBzb2Z0bW11L21lbW9yeS5j
ICAgICAgICAgIHwgIDcgKysrKystLQ0KIHV0aWwvbW1hcC1hbGxvYy5jICAgICAgICAgfCAxMCAr
KysrKystLS0tDQogdXRpbC9vc2xpYi1wb3NpeC5jICAgICAgICB8ICAyICstDQogcWVtdS1vcHRp
b25zLmh4ICAgICAgICAgICB8ICA1ICsrKystDQogMTEgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0
aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNi4yDQoNCg==


