Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C424C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028222166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejK5FPhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028222166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY5h-00032c-UR
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4n-0001No-Ql
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4l-0003mC-W8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9OLUXUREtdkmKMxyiBA8YBDdDMD83hrOzScdDhM9Es=;
 b=ejK5FPhiPFDqwCAlOoizjAA/XStZeuoMVTIVSHOoKgn/Y6Lk+WGwTlDB/pkWuX/Vt22EwG
 NuMQMmiAN2+vY0vK4aRc4shEjJ86UjL9Wi7RtRyCsbTbvEAcg/4cy4X+xYXP5LrDKsNBWg
 LPSnZ+oscGUJ0j6562VcwSFtEJX2BnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-SPt72GRfO7aF73-d1foCcw-1; Tue, 08 Sep 2020 03:29:57 -0400
X-MC-Unique: SPt72GRfO7aF73-d1foCcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72CBD1DDF7
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:56 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 686B87E30C;
 Tue,  8 Sep 2020 07:29:54 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 07/10] roms/Makefile.edk2: enable new ARM/AARCH64 flags up to
 edk2-stable202008
Date: Tue,  8 Sep 2020 09:29:36 +0200
Message-Id: <20200908072939.30178-8-lersek@redhat.com>
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

RWRrMiBjb21taXQgZmZlMDQ4YTA4MDdiICgiQXJtVmlydFBrZzogaGFuZGxlIE5FVFdPUktfVExT
X0VOQUJMRSBpbgpBcm1WaXJ0UWVtdSoiLCAyMDE5LTA2LTI4KSwgcGFydCBvZiBlZGsyLXN0YWJs
ZTIwMTkwOCwgYWxsb3dzIHVzIHRvCmluY2x1ZGUgdGhlIFVFRkkgSFRUUFMgQm9vdCBmZWF0dXJl
IGluIHRoZSBBcm1WaXJ0UWVtdSBmdyBwbGF0Zm9ybSAoQVJNCmFuZCBBQVJDSDY0KS4KCkVkazIg
Y29tbWl0IHJhbmdlIDRjMGY2ZTM0OWQzMi4uMDk4MDc3OWE5ZGRjLCBwYXJ0IG9mIGVkazItc3Rh
YmxlMjAyMDA1LAphZGRlZCBUUE0yIHN1cHBvcnQgdG8gQXJtVmlydFFlbXU7IGVuYWJsZSBpdCBh
cyB3ZWxsLiAoVW5saWtlIHdpdGggT1ZNRgpJQTMyIGFuZCBYNjQsIFRQTS0xLjIgc3VwcG9ydCBp
cyBub3QgaW5jbHVkZWQsIGhlbmNlIHRoZSBUUE0yLXNwZWNpZmljCmZsYWcgbmFtZXMuKQoKQ2M6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmVmOiBodHRwczov
L2J1Z3MubGF1bmNocGFkLm5ldC9xZW11LytidWcvMTg1MjE5NgpTaWduZWQtb2ZmLWJ5OiBMYXN6
bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0KIHJvbXMvTWFrZWZpbGUuZWRrMiB8IDEw
ICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvcm9tcy9NYWtlZmlsZS5lZGsyIGIvcm9tcy9NYWtlZmlsZS5lZGsy
CmluZGV4IDhjZGYzMzdmYzFlOS4uYThlZDMyNTU3NTdmIDEwMDY0NAotLS0gYS9yb21zL01ha2Vm
aWxlLmVkazIKKysrIGIvcm9tcy9NYWtlZmlsZS5lZGsyCkBAIC02NCw3ICs2NCwxMCBAQCBzdWJt
b2R1bGVzOgogCQktLWFyY2g9QUFSQ0g2NCBcCiAJCS0tcGxhdGZvcm09QXJtVmlydFBrZy9Bcm1W
aXJ0UWVtdS5kc2MgXAogCQktRCBORVRXT1JLX0lQNl9FTkFCTEUgXAotCQktRCBORVRXT1JLX0hU
VFBfQk9PVF9FTkFCTEUKKwkJLUQgTkVUV09SS19IVFRQX0JPT1RfRU5BQkxFIFwKKwkJLUQgTkVU
V09SS19UTFNfRU5BQkxFIFwKKwkJLUQgVFBNMl9FTkFCTEUgXAorCQktRCBUUE0yX0NPTkZJR19F
TkFCTEUKIAljcCBlZGsyL0J1aWxkL0FybVZpcnRRZW11LUFBUkNINjQvREVCVUdfJChjYWxsIHRv
b2xjaGFpbixhYXJjaDY0KS9GVi9RRU1VX0VGSS5mZCBcCiAJCSRACiAJdHJ1bmNhdGUgLS1zaXpl
PTY0TSAkQApAQCAtNzUsNyArNzgsMTAgQEAgc3VibW9kdWxlczoKIAkJLS1hcmNoPUFSTSBcCiAJ
CS0tcGxhdGZvcm09QXJtVmlydFBrZy9Bcm1WaXJ0UWVtdS5kc2MgXAogCQktRCBORVRXT1JLX0lQ
Nl9FTkFCTEUgXAotCQktRCBORVRXT1JLX0hUVFBfQk9PVF9FTkFCTEUKKwkJLUQgTkVUV09SS19I
VFRQX0JPT1RfRU5BQkxFIFwKKwkJLUQgTkVUV09SS19UTFNfRU5BQkxFIFwKKwkJLUQgVFBNMl9F
TkFCTEUgXAorCQktRCBUUE0yX0NPTkZJR19FTkFCTEUKIAljcCBlZGsyL0J1aWxkL0FybVZpcnRR
ZW11LUFSTS9ERUJVR18kKGNhbGwgdG9vbGNoYWluLGFybSkvRlYvUUVNVV9FRkkuZmQgXAogCQkk
QAogCXRydW5jYXRlIC0tc2l6ZT02NE0gJEAKLS0gCjIuMTkuMS4zLmczMDI0N2FhNWQyMDEKCgo=


