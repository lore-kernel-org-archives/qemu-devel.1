Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44413C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3221A2313B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOvaG+e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3221A2313B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fnd-0006tD-6I
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3fmf-0005dt-EJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:18:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3fmc-0000Sk-QK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596719890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w7g7wQ+5/3bK8j7IvCTaX4yW+PgfAhrfIv+6gmDTrI0=;
 b=hOvaG+e4tLrYBJWyYkHmlIoWHkBStYJpwzknT+ekG+BTpkTVTlzKd71pdgg+ymr+EfUlSE
 1M5tUK458bDyru7dAdtOxz5bVHLajEJMZGAi8fafN7kYIcoGzMNRM1I7NyngTWcU+ZvTRV
 PoV9L2nhJvTFvrx580v5aPouUVWA7hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-GUVyy8r0Nbesus6KnW9-Zw-1; Thu, 06 Aug 2020 09:18:08 -0400
X-MC-Unique: GUVyy8r0Nbesus6KnW9-Zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E07558;
 Thu,  6 Aug 2020 13:18:07 +0000 (UTC)
Received: from localhost (ovpn-114-7.ams2.redhat.com [10.36.114.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF977B93D;
 Thu,  6 Aug 2020 13:18:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] aio-posix: keep aio_notify_me disabled during polling
Date: Thu,  6 Aug 2020 14:17:59 +0100
Message-Id: <20200806131802.569478-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djM6DQogKiBVc2Ugc21wX3dtYigpIGluIGFpb19ub3RpZnlfYWNjZXB0KCkgW1Bhb2xvXQ0KICog
RmxhdHRlbiBpZiBzdGF0ZW1lbnQgaW4gYWlvX3BvbGwoKSBbUGFvbG9dDQoNCnYyOg0KICogQWRk
ZWQgc21wX21iKCkgaW4gYWlvX25vdGlmeV9hY2NlcHQoKSBbUGFvbG9dDQogKiBBZGRlZCBjb21t
ZW50cyBhYm91dCBtZW1vcnkgYmFycmllciBwYWlyaW5nIFtQYW9sb10NCiAqIEVsaW1pbmF0ZWQg
ZXh0cmEgYWlvX2NvbXB1dGVfdGltZW91dCgpIGJlZm9yZSBjYWxsaW5nIHBwb2xsKCkNCg0KVGhp
cyBwYXRjaCBzZXJpZXMgZWxpbWluYXRlcyBjdHgtPm5vdGlmaWVyIEV2ZW50Tm90aWZpZXIgYWN0
aXZpdHkgd2hlbg0KYWlvX3BvbGwoKSBpcyBpbiBwb2xsaW5nIG1vZGUuIFRoZXJlIGlzIG5vIG5l
ZWQgdG8gdXNlIHRoZSBFdmVudE5vdGlmaWVyIHNpbmNlDQphIHBvbGxpbmcgaGFuZGxlciBjYW4g
ZGV0ZWN0IHRoYXQgYWlvX25vdGlmeSgpIGhhcyBiZWVuIGNhbGxlZCBieSBtb25pdG9yaW5nIGEN
CmZpZWxkIGluIG1lbW9yeSBpbnN0ZWFkLg0KDQpPcHRpbWl6aW5nIG91dCB0aGUgRXZlbnROb3Rp
ZmllciBjYWxscyBpbXByb3ZlcyBudWxsLWNvIHJhbmRvbSByZWFkIDRLQg0KaW9kZXB0aD0xIElP
UFMgYnkgMTglLg0KDQpJIGhhdmUgbm90IG1vZGlmaWVkIGRvY3Mvc3Bpbi9haW9fbm90aWZ5Ki5w
cm9tZWxhIGJlY2F1c2UgSSdtIG5vdCBmYW1pbGlhciB3aXRoDQp0aGUgU1BJTiBtb2RlbCBjaGVj
a2VyLg0KDQpTdGVmYW4gSGFqbm9jemkgKDMpOg0KICBhc3luYzogcmVuYW1lIGV2ZW50X25vdGlm
aWVyX2R1bW15X2NiL3BvbGwoKQ0KICBhc3luYzogYWx3YXlzIHNldCBjdHgtPm5vdGlmaWVkIGlu
IGFpb19ub3RpZnkoKQ0KICBhaW8tcG9zaXg6IGtlZXAgYWlvX25vdGlmeV9tZSBkaXNhYmxlZCBk
dXJpbmcgcG9sbGluZw0KDQogdXRpbC9haW8tcG9zaXguYyB8IDQ3ICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogdXRpbC9hc3luYy5jICAgICB8IDM2ICsr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNDgg
aW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNi4yDQoNCg==


