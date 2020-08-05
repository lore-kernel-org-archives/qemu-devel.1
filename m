Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93577C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5BD20792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV2XdHdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5BD20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GGz-00010D-GK
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GEJ-0005iF-5Q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47160
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GEH-0000Rm-59
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pko9KcEGYzgbCxo8HxvXntBgxu0EM15eGioBrTr77ns=;
 b=FV2XdHdohWn1kQLTJ7EfQIr3sDYv7O99glbvbLOJzIQdpO79i2G89V0YQ9bmzkzeWpcRl8
 geb16xkoJRqiKhYn5iAUw8LLS7Pg25OxFRvyY4rFomxC1Cv214dTiE7o9BeLeQA2bbACKw
 rVwfkpYGpHqNbrkcOKXE5q2syGHbjYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-JCnRwi9pNYeFIx9aRU9NcA-1; Wed, 05 Aug 2020 06:00:57 -0400
X-MC-Unique: JCnRwi9pNYeFIx9aRU9NcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2348015F4;
 Wed,  5 Aug 2020 10:00:56 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0397B1A922;
 Wed,  5 Aug 2020 10:00:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] aio-posix: keep aio_notify_me disabled during polling
Date: Wed,  5 Aug 2020 11:00:48 +0100
Message-Id: <20200805100051.361547-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6DQogKiBBZGRlZCBzbXBfbWIoKSBpbiBhaW9fbm90aWZ5X2FjY2VwdCgpIFtQYW9sb10NCiAq
IEFkZGVkIGNvbW1lbnRzIGFib3V0IG1lbW9yeSBiYXJyaWVyIHBhaXJpbmcgW1Bhb2xvXQ0KICog
RWxpbWluYXRlZCBleHRyYSBhaW9fY29tcHV0ZV90aW1lb3V0KCkgYmVmb3JlIGNhbGxpbmcgcHBv
bGwoKQ0KDQpUaGlzIHBhdGNoIHNlcmllcyBlbGltaW5hdGVzIGN0eC0+bm90aWZpZXIgRXZlbnRO
b3RpZmllciBhY3Rpdml0eSB3aGVuDQphaW9fcG9sbCgpIGlzIGluIHBvbGxpbmcgbW9kZS4gVGhl
cmUgaXMgbm8gbmVlZCB0byB1c2UgdGhlIEV2ZW50Tm90aWZpZXIgc2luY2UNCmEgcG9sbGluZyBo
YW5kbGVyIGNhbiBkZXRlY3QgdGhhdCBhaW9fbm90aWZ5KCkgaGFzIGJlZW4gY2FsbGVkIGJ5IG1v
bml0b3JpbmcgYQ0KZmllbGQgaW4gbWVtb3J5IGluc3RlYWQuDQoNCk9wdGltaXppbmcgb3V0IHRo
ZSBFdmVudE5vdGlmaWVyIGNhbGxzIGltcHJvdmVzIG51bGwtY28gcmFuZG9tIHJlYWQgNEtCDQpp
b2RlcHRoPTEgSU9QUyBieSAxOCUuDQoNCkkgaGF2ZSBub3QgbW9kaWZpZWQgZG9jcy9zcGluL2Fp
b19ub3RpZnkqLnByb21lbGEgYmVjYXVzZSBJJ20gbm90IGZhbWlsaWFyIHdpdGgNCnRoZSBTUElO
IG1vZGVsIGNoZWNrZXIuDQoNClN0ZWZhbiBIYWpub2N6aSAoMyk6DQogIGFzeW5jOiByZW5hbWUg
ZXZlbnRfbm90aWZpZXJfZHVtbXlfY2IvcG9sbCgpDQogIGFzeW5jOiBhbHdheXMgc2V0IGN0eC0+
bm90aWZpZWQgaW4gYWlvX25vdGlmeSgpDQogIGFpby1wb3NpeDoga2VlcCBhaW9fbm90aWZ5X21l
IGRpc2FibGVkIGR1cmluZyBwb2xsaW5nDQoNCiB1dGlsL2Fpby1wb3NpeC5jIHwgNTkgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogdXRpbC9hc3luYy5j
ICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2Vk
LCA1NCBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI2LjINCg0K


