Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC518C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFC32064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtkoZkXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFC32064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2pVV-00068T-SY
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 01:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pUl-0005NZ-Da
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:28:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pUi-0004fa-E8
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596518891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FYbdF9A59yOuFAqIJal7DuJ8EsPliIp4vtn9QbCP0Yk=;
 b=CtkoZkXZ0UdrTjf+N+B2vdze10c1Xph15dM+oqYYJZfM38OD/GfbOgZEIzOY1bqoKLK7VR
 6KqT+xSbU1z2VjElraZO63ExBrfGIOOMmRBFrqgLiGQYO8ZizwzmxE1mqqs/smfRMZAJ3U
 DO5StBKJNQylDsyCV/uhH/d7Gt9fpgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-oI8sd39iM7yo7NhTWWIPZA-1; Tue, 04 Aug 2020 01:28:09 -0400
X-MC-Unique: oI8sd39iM7yo7NhTWWIPZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CD39108088A;
 Tue,  4 Aug 2020 05:28:08 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 516505D9F7;
 Tue,  4 Aug 2020 05:28:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] aio-posix: keep aio_notify_me disabled during polling
Date: Tue,  4 Aug 2020 06:28:01 +0100
Message-Id: <20200804052804.1165291-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgZWxpbWluYXRlcyBjdHgtPm5vdGlmaWVyIEV2ZW50Tm90aWZpZXIg
YWN0aXZpdHkgd2hlbg0KYWlvX3BvbGwoKSBpcyBpbiBwb2xsaW5nIG1vZGUuIFRoZXJlIGlzIG5v
IG5lZWQgdG8gdXNlIHRoZSBFdmVudE5vdGlmaWVyIHNpbmNlDQphIHBvbGxpbmcgaGFuZGxlciBj
YW4gZGV0ZWN0IHRoYXQgYWlvX25vdGlmeSgpIGhhcyBiZWVuIGNhbGxlZCBieSBtb25pdG9yaW5n
IGENCmZpZWxkIGluIG1lbW9yeSBpbnN0ZWFkLg0KDQpPcHRpbWl6aW5nIG91dCB0aGUgRXZlbnRO
b3RpZmllciBjYWxscyBpbXByb3ZlcyBudWxsLWNvIHJhbmRvbSByZWFkIDRLQg0KaW9kZXB0aD0x
IElPUFMgYnkgMTglLg0KDQphaW9fY29tcHV0ZV90aW1lb3V0KCkgaXMgbm93IGNhbGxlZCB0d2lj
ZSBpZiBhaW9fcG9sbCgpIG5lZWRzIHRvIGJsb2NrLCB3aGljaA0KbWVhbnMgYW4gZXh0cmEgcWVt
dV9jbG9ja19nZXRfbnMoKSBjYWxsIGlzIG1hZGUgd2hlbiB0aGVyZSBpcyBhbiBhY3RpdmUgdGlt
ZXIuDQpBbiBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBzZXQgdGltZW91dCA9IDAgaWYgY3R4LT5u
b3RpZmllZCBpcyB0cnVlIGJlZm9yZQ0KYmxvY2tpbmcsIGJ1dCBnb2luZyBhcm91bmQgdGhlIGV2
ZW50IGxvb3AgYWdhaW4gY291bGQgc2xvdyB0aGluZ3MgZG93biBtb3JlLg0KDQpJIGhhdmUgbm90
IG1vZGlmaWVkIGRvY3Mvc3Bpbi9haW9fbm90aWZ5Ki5wcm9tZWxhIGJlY2F1c2UgSSdtIG5vdCBm
YW1pbGlhciB3aXRoDQp0aGUgU1BJTiBtb2RlbCBjaGVja2VyLg0KDQpTdGVmYW4gSGFqbm9jemkg
KDMpOg0KICBhc3luYzogcmVuYW1lIGV2ZW50X25vdGlmaWVyX2R1bW15X2NiL3BvbGwoKQ0KICBh
c3luYzogYWx3YXlzIHNldCBjdHgtPm5vdGlmaWVkIGluIGFpb19ub3RpZnkoKQ0KICBhaW8tcG9z
aXg6IGtlZXAgYWlvX25vdGlmeV9tZSBkaXNhYmxlZCBkdXJpbmcgcG9sbGluZw0KDQogdXRpbC9h
aW8tcG9zaXguYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KIHV0aWwvYXN5bmMuYyAgICAgfCAyMiArKysrKysrKystLS0tLS0tLS0tDQogMiBm
aWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjI2LjINCg0K


