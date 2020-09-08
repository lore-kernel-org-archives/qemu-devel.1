Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90708C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BA2218AC
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUExA8aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BA2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY9n-0000Qg-50
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4l-0001Jx-Pa
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4k-0003lz-0H
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeOzfZxRrCb+8/H1zC/N+Q8LyzPvP3uJveuIN/oj5Vk=;
 b=AUExA8aaoNjiPS1Am1OmcHlFql3MIGwZF60uqgN+gkF7cl7Va3pHMeCPSzMagLlN48G0yE
 tLi57FmMXQhjaRJKBSt/AzGZ539l5Br6+xavaPqtur2wfYpTMUgMH69C3Y0kXrcE5GkCht
 mlPZOoi40luP1igWSNEaqqGwhMyKEcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-MNLmh2oxOzGIZ__w7BjgTQ-1; Tue, 08 Sep 2020 03:29:54 -0400
X-MC-Unique: MNLmh2oxOzGIZ__w7BjgTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D71718B9ECB
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:54 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 397E47E30C;
 Tue,  8 Sep 2020 07:29:53 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 06/10] roms/Makefile.edk2: complete replacing TPM2*_ENABLE
 macros
Date: Tue,  8 Sep 2020 09:29:35 +0200
Message-Id: <20200908072939.30178-7-lersek@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QXQgdGFnICJlZGsyLXN0YWJsZTIwMjAwOCIsIHRoZSBUUE0yX0VOQUJMRSBhbmQgVFBNMl9DT05G
SUdfRU5BQkxFIG1hY3JvcwphcmUgdXNlbGVzcyAoZm9yIElBMzIgYW5kIFg2NCkuIFRoZWlyIHJv
bGVzIGhhdmUgYmVlbiBhYnNvcmJlZCBieQpUUE1fRU5BQkxFIGFuZCBUUE1fQ09ORklHX0VOQUJM
RSwgcmVzcGVjdGl2ZWx5LiBSZW1vdmUgdGhlIG9sZCBidWlsZApmbGFncy4KCkNjOiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+ClJlZjogaHR0cHM6Ly9idWdzLmxh
dW5jaHBhZC5uZXQvcWVtdS8rYnVnLzE4NTIxOTYKU2lnbmVkLW9mZi1ieTogTGFzemxvIEVyc2Vr
IDxsZXJzZWtAcmVkaGF0LmNvbT4KLS0tCiByb21zL01ha2VmaWxlLmVkazIgfCAxMiArKy0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3JvbXMvTWFrZWZpbGUuZWRrMiBiL3JvbXMvTWFrZWZpbGUuZWRrMgppbmRl
eCA3YzA2NjQ1Yzk1Y2EuLjhjZGYzMzdmYzFlOSAxMDA2NDQKLS0tIGEvcm9tcy9NYWtlZmlsZS5l
ZGsyCisrKyBiL3JvbXMvTWFrZWZpbGUuZWRrMgpAQCAtODksOSArODksNyBAQCBzdWJtb2R1bGVz
OgogCQktRCBORVRXT1JLX0hUVFBfQk9PVF9FTkFCTEUgXAogCQktRCBORVRXT1JLX1RMU19FTkFC
TEUgXAogCQktRCBUUE1fRU5BQkxFIFwKLQkJLUQgVFBNX0NPTkZJR19FTkFCTEUgXAotCQktRCBU
UE0yX0VOQUJMRSBcCi0JCS1EIFRQTTJfQ09ORklHX0VOQUJMRQorCQktRCBUUE1fQ09ORklHX0VO
QUJMRQogCWNwIGVkazIvQnVpbGQvT3ZtZklhMzIvREVCVUdfJChjYWxsIHRvb2xjaGFpbixpMzg2
KS9GVi9PVk1GX0NPREUuZmQgJEAKIAogLi4vcGMtYmlvcy9lZGsyLWkzODYtc2VjdXJlLWNvZGUu
ZmQ6IHN1Ym1vZHVsZXMKQEAgLTEwNCw4ICsxMDIsNiBAQCBzdWJtb2R1bGVzOgogCQktRCBORVRX
T1JLX1RMU19FTkFCTEUgXAogCQktRCBUUE1fRU5BQkxFIFwKIAkJLUQgVFBNX0NPTkZJR19FTkFC
TEUgXAotCQktRCBUUE0yX0VOQUJMRSBcCi0JCS1EIFRQTTJfQ09ORklHX0VOQUJMRSBcCiAJCS1E
IFNFQ1VSRV9CT09UX0VOQUJMRSBcCiAJCS1EIFNNTV9SRVFVSVJFCiAJY3AgZWRrMi9CdWlsZC9P
dm1mSWEzMi9ERUJVR18kKGNhbGwgdG9vbGNoYWluLGkzODYpL0ZWL09WTUZfQ09ERS5mZCAkQApA
QCAtMTE5LDkgKzExNSw3IEBAIHN1Ym1vZHVsZXM6CiAJCS1EIE5FVFdPUktfSFRUUF9CT09UX0VO
QUJMRSBcCiAJCS1EIE5FVFdPUktfVExTX0VOQUJMRSBcCiAJCS1EIFRQTV9FTkFCTEUgXAotCQkt
RCBUUE1fQ09ORklHX0VOQUJMRSBcCi0JCS1EIFRQTTJfRU5BQkxFIFwKLQkJLUQgVFBNMl9DT05G
SUdfRU5BQkxFCisJCS1EIFRQTV9DT05GSUdfRU5BQkxFCiAJY3AgZWRrMi9CdWlsZC9Pdm1mWDY0
L0RFQlVHXyQoY2FsbCB0b29sY2hhaW4seDg2XzY0KS9GVi9PVk1GX0NPREUuZmQgJEAKIAogLi4v
cGMtYmlvcy9lZGsyLXg4Nl82NC1zZWN1cmUtY29kZS5mZDogc3VibW9kdWxlcwpAQCAtMTM1LDgg
KzEyOSw2IEBAIHN1Ym1vZHVsZXM6CiAJCS1EIE5FVFdPUktfVExTX0VOQUJMRSBcCiAJCS1EIFRQ
TV9FTkFCTEUgXAogCQktRCBUUE1fQ09ORklHX0VOQUJMRSBcCi0JCS1EIFRQTTJfRU5BQkxFIFwK
LQkJLUQgVFBNMl9DT05GSUdfRU5BQkxFIFwKIAkJLUQgU0VDVVJFX0JPT1RfRU5BQkxFIFwKIAkJ
LUQgU01NX1JFUVVJUkUKIAljcCBlZGsyL0J1aWxkL092bWYzMjY0L0RFQlVHXyQoY2FsbCB0b29s
Y2hhaW4seDg2XzY0KS9GVi9PVk1GX0NPREUuZmQgJEAKLS0gCjIuMTkuMS4zLmczMDI0N2FhNWQy
MDEKCgo=


