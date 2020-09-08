Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDBC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B412166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO2/MJWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B412166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY5Y-0002de-Bs
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4g-0001BG-CZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4d-0003jd-Lx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9DwJyRauuMZKTrH6KcZP5D3Am23MhGb7OIiHld/F9A=;
 b=CO2/MJWh5tBzZrBAaQ5vxFwXXEH7CRkfBcIhtn1gNSLQpwvncr36LnBfQywqiEuNcZ0V0o
 UFsbI5JQg/C0nZw1YV8FmXQfOdpXEEOqYVua2iGIyyCPs5AEgBoVWTJFgg2PA/cjTDYa14
 xUKm3PWZtw9M5G+3FWXCaV2f+2YtLfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-cEkKp2jMMBWqC8KVKZpt3A-1; Tue, 08 Sep 2020 03:29:48 -0400
X-MC-Unique: cEkKp2jMMBWqC8KVKZpt3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952831091060
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C850B82462;
 Tue,  8 Sep 2020 07:29:46 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 02/10] roms/efirom,
 tests/uefi-test-tools: update edk2's own submodules first
Date: Tue,  8 Sep 2020 09:29:31 +0200
Message-Id: <20200908072939.30178-3-lersek@redhat.com>
In-Reply-To: <20200908072939.30178-1-lersek@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW4gZWRrMiBjb21taXQgMDYwMzNmNWFiYWQzICgiQmFzZVRvb2xzOiBNYWtlIGJyb3RsaSBhIHN1
Ym1vZHVsZSIsCjIwMjAtMDQtMTYpLCBwYXJ0IG9mIGVkazItc3RhYmxlMjAyMDA1LCB0aGUgQnJv
dGxpIGNvbXByZXNzb3IgLwpkZWNvbXByZXNzb3Igc291cmNlIGNvZGUgdGhhdCBlZGsyIGhhZCBm
bGF0dGVuZWQgaW50byBCYXNlVG9vbHMgd2FzCnJlcGxhY2VkIHdpdGggYSBnaXQgc3VibW9kdWxl
LgoKVGhpcyBtZWFucyB3ZSBoYXZlIHRvIGluaXRpYWxpemUgZWRrMidzIG93biBzdWJtb2R1bGVz
IGJlZm9yZSBidWlsZGluZwpCYXNlVG9vbHMgbm90IGp1c3QgaW4gInJvbXMvTWFrZWZpbGUuZWRr
MiIsIGJ1dCBpbiAicm9tcy9NYWtlZmlsZSIgKGZvcgp0aGUgc2FrZSBvZiB0aGUgImVmaXJvbSIg
dGFyZ2V0KSBhbmQgInRlc3RzL3VlZmktdGVzdC10b29scy9NYWtlZmlsZSIgYXMKd2VsbC4KClJp
Z2h0IG5vdyB0aGlzIHBhdGNoIGlzIGVmZmVjdGl2ZWx5IGEgbm8tb3A7IGl0IHdpbGwgYmVjb21l
IG1lYW5pbmdmdWwKYWZ0ZXIgd2UgbW92ZSB0aGUgZWRrMiBzdWJtb2R1bGUgdG8gZWRrMi1zdGFi
bGUyMDIwMDguCgpDYzogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29t
PgpSZWY6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L3FlbXUvK2J1Zy8xODUyMTk2ClNpZ25l
ZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQogcm9tcy9NYWtl
ZmlsZSAgICAgICAgICAgICAgICAgIHwgMSArCiB0ZXN0cy91ZWZpLXRlc3QtdG9vbHMvTWFrZWZp
bGUgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
cm9tcy9NYWtlZmlsZSBiL3JvbXMvTWFrZWZpbGUKaW5kZXggNWQ5ZjE1YjY3NzdmLi5jNTk0ZDk4
ZjcwOTQgMTAwNjQ0Ci0tLSBhL3JvbXMvTWFrZWZpbGUKKysrIGIvcm9tcy9NYWtlZmlsZQpAQCAt
MTQwLDYgKzE0MCw3IEBAIGJ1aWxkLWVmaS1yb21zOiBidWlsZC1weGUtcm9tcwogIyAgICBlZmly
b20KICMKIGVkazItYmFzZXRvb2xzOgorCWNkIGVkazIvQmFzZVRvb2xzICYmIGdpdCBzdWJtb2R1
bGUgdXBkYXRlIC0taW5pdCAtLWZvcmNlCiAJJChNQUtFKSAtQyBlZGsyL0Jhc2VUb29scyBcCiAJ
CVBZVEhPTl9DT01NQU5EPSQke0VESzJfUFlUSE9OX0NPTU1BTkQ6LXB5dGhvbjN9IFwKIAkJRVhU
UkFfT1BURkxBR1M9JyQoRURLMl9CQVNFVE9PTFNfT1BURkxBR1MpJyBcCmRpZmYgLS1naXQgYS90
ZXN0cy91ZWZpLXRlc3QtdG9vbHMvTWFrZWZpbGUgYi90ZXN0cy91ZWZpLXRlc3QtdG9vbHMvTWFr
ZWZpbGUKaW5kZXggMWRjZGRjZGJiYWJmLi40NzFmMGRlOTgxMDkgMTAwNjQ0Ci0tLSBhL3Rlc3Rz
L3VlZmktdGVzdC10b29scy9NYWtlZmlsZQorKysgYi90ZXN0cy91ZWZpLXRlc3QtdG9vbHMvTWFr
ZWZpbGUKQEAgLTk5LDYgKzk5LDcgQEAgQnVpbGQvYmlvcy10YWJsZXMtdGVzdC4lLmVmaTogYnVp
bGQtZWRrMi10b29scwogCSsuL2J1aWxkLnNoICQoZWRrMl9kaXIpIEJpb3NUYWJsZXNUZXN0ICQq
ICRACiAKIGJ1aWxkLWVkazItdG9vbHM6CisJY2QgJChlZGsyX2RpcikvQmFzZVRvb2xzICYmIGdp
dCBzdWJtb2R1bGUgdXBkYXRlIC0taW5pdCAtLWZvcmNlCiAJJChNQUtFKSAtQyAkKGVkazJfZGly
KS9CYXNlVG9vbHMgXAogCQlQWVRIT05fQ09NTUFORD0kJHtFREsyX1BZVEhPTl9DT01NQU5EOi1w
eXRob24zfSBcCiAJCUVYVFJBX09QVEZMQUdTPSckKEVESzJfQkFTRVRPT0xTX09QVEZMQUdTKScg
XAotLSAKMi4xOS4xLjMuZzMwMjQ3YWE1ZDIwMQoKCg==


