Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B56C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6272072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKFJIRzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6272072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKsR-0000EI-TY
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbe-0008Uo-3r
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbY-0008OO-Mw
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuNz3GkacsWeTmhvyPsZFHJuTLmoIxG/n/YnP03+TvU=;
 b=aKFJIRzpFO08r/zJVgGfq6FgV8LlXMP1mP2+ed1Szq16KmlOEBGf1AQ4WL+P67dylUYlR/
 92A/amSzYJUp4lTwHJKrfrFIChgon0E4jmnd/IH0e+qqeaqwaVno3OdlAVidMv85cspTVG
 vHYsCX391064NAH+z3HW9SBXGx9x9ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-43FzwHe2PIC-fJ0orVjPnA-1; Wed, 04 Nov 2020 10:21:34 -0500
X-MC-Unique: 43FzwHe2PIC-fJ0orVjPnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEFD6101F7A7;
 Wed,  4 Nov 2020 15:21:32 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68F8F5DA6B;
 Wed,  4 Nov 2020 15:21:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/33] util/vfio-helpers: Improve reporting unsupported IOMMU
 type
Date: Wed,  4 Nov 2020 15:18:22 +0000
Message-Id: <20201104151828.405824-28-stefanha@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKQ2hhbmdl
IHRoZSBjb25mdXNlICJWRklPIElPTU1VIGNoZWNrIGZhaWxlZCIgZXJyb3IgbWVzc2FnZSBieQp0
aGUgZXhwbGljaXQgIlZGSU8gSU9NTVUgVHlwZTEgaXMgbm90IHN1cHBvcnRlZCIgb25jZS4KCkV4
YW1wbGUgb24gUE9XRVI6CgogJCBxZW11LXN5c3RlbS1wcGM2NCAtZHJpdmUgaWY9bm9uZSxpZD1u
dm1lMCxmaWxlPW52bWU6Ly8wMDAxOjAxOjAwLjAvMSxmb3JtYXQ9cmF3CiBxZW11LXN5c3RlbS1w
cGM2NDogLWRyaXZlIGlmPW5vbmUsaWQ9bnZtZTAsZmlsZT1udm1lOi8vMDAwMTowMTowMC4wLzEs
Zm9ybWF0PXJhdzogVkZJTyBJT01NVSBUeXBlMSBpcyBub3Qgc3VwcG9ydGVkCgpTdWdnZXN0ZWQt
Ynk6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+ClJldmlld2Vk
LWJ5OiBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAxMTAzMDIwNzMzLjIz
MDMxNDgtMi1waGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPgotLS0KIHV0aWwvdmZpby1oZWxwZXJzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS91dGlsL3ZmaW8t
aGVscGVycy5jIGIvdXRpbC92ZmlvLWhlbHBlcnMuYwppbmRleCBjNDY5YmViMDYxLi4xNGE1NDk1
MTBmIDEwMDY0NAotLS0gYS91dGlsL3ZmaW8taGVscGVycy5jCisrKyBiL3V0aWwvdmZpby1oZWxw
ZXJzLmMKQEAgLTMwMCw3ICszMDAsNyBAQCBzdGF0aWMgaW50IHFlbXVfdmZpb19pbml0X3BjaShR
RU1VVkZJT1N0YXRlICpzLCBjb25zdCBjaGFyICpkZXZpY2UsCiAgICAgfQogCiAgICAgaWYgKCFp
b2N0bChzLT5jb250YWluZXIsIFZGSU9fQ0hFQ0tfRVhURU5TSU9OLCBWRklPX1RZUEUxX0lPTU1V
KSkgewotICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiVkZJTyBJT01NVSBj
aGVjayBmYWlsZWQiKTsKKyAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIlZG
SU8gSU9NTVUgVHlwZTEgaXMgbm90IHN1cHBvcnRlZCIpOwogICAgICAgICByZXQgPSAtRUlOVkFM
OwogICAgICAgICBnb3RvIGZhaWxfY29udGFpbmVyOwogICAgIH0KLS0gCjIuMjguMAoK


