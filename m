Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ED520829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLfv7Fam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ED520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1D8L-000158-EO
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 14:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1D4n-0006me-LY
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 14:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1D4j-0001T8-9K
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 14:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596132879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISqQ5uIw5KF4G3fNDYh9e7g0ivRbimnlWj30R7n1OSQ=;
 b=aLfv7FamhXbzonEYYGTgn3AcX/1dvOW2Odf+0Dtg61nlr4YxbTvrFACZE20Ncn1x1YsAjC
 bLPNIOtYZ8k5WrUH6n/29Yzze/3mtowIBn00/6gQHAFu48SdFrCzUigyUMa+X62ig9e8+y
 a2un6rf6whTi07CfliVqC9i/v+UVGVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-MxbGVOVQPCGPAgMfeoBSxw-1; Thu, 30 Jul 2020 14:14:34 -0400
X-MC-Unique: MxbGVOVQPCGPAgMfeoBSxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C548119200C2;
 Thu, 30 Jul 2020 18:14:33 +0000 (UTC)
Received: from localhost (ovpn-114-112.ams2.redhat.com [10.36.114.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C13B6111F;
 Thu, 30 Jul 2020 18:14:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 2/2] tracetool: carefully define SDT_USE_VARIADIC
Date: Thu, 30 Jul 2020 19:14:14 +0100
Message-Id: <20200730181414.160066-3-stefanha@redhat.com>
In-Reply-To: <20200730181414.160066-1-stefanha@redhat.com>
References: <20200730181414.160066-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGR0cmFjZSBiYWNrZW5kIGRlZmluZXMgU0RUX1VTRV9WQVJJQURJQyBhcyBhIHdvcmthcm91
bmQgZm9yIGEKY29uZmxpY3Qgd2l0aCBhIExUVG5nIFVTVCBoZWFkZXIgZmlsZSwgd2hpY2ggcmVx
dWlyZXMgU0RUX1VTRV9WQVJJQURJQwp0byBiZSBkZWZpbmVkLgoKTFRUbmcgVVNUIDxsdHRuZy90
cmFjZXBvaW50Lmg+IGJyZWFrcyBpZiBpbmNsdWRlZCBhZnRlciBnZW5lcmF0ZWQgZHRyYWNlCmhl
YWRlcnMgYmVjYXVzZSBTRFRfVVNFX1ZBUklBRElDIHdpbGwgYWxyZWFkeSBiZSBkZWZpbmVkOgoK
ICAjaWZkZWYgTFRUTkdfVVNUX0hBVkVfU0RUX0lOVEVHUkFUSU9OCiAgI2RlZmluZSBTRFRfVVNF
X1ZBUklBRElDIDwtLSBlcnJvciwgaXQncyBhbHJlYWR5IGRlZmluZWQKICAjaW5jbHVkZSA8c3lz
L3NkdC5oPgoKQmUgbW9yZSBjYXJlZnVsIHdoZW4gZGVmaW5pbmcgU0RUX1VTRV9WQVJJQURJQy4g
VGhpcyBmaXhlcyB0aGUgYnVpbGQKd2hlbiBib3RoIHRoZSBkdHJhY2UgYW5kIHVzdCB0cmFjZXJz
IGFyZSBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUuCgpGaXhlczogMjdlMDhiYWI5NGY3YzZlYmUw
Yjc1OTM4Yzk4YzM5NGM5NjllM2ZkOCAoInRyYWNldG9vbDogd29yayBhcm91bmQgdXN0IDxzeXMv
c2R0Lmg+IGluY2x1ZGUgY29uZmxpY3QiKQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwNzI5MTUzOTI2LjEyNzA4My0x
LXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPgotLS0KIHNjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQvZHRyYWNlLnB5
IHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
c2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9kdHJhY2UucHkgYi9zY3JpcHRzL3RyYWNldG9vbC9i
YWNrZW5kL2R0cmFjZS5weQppbmRleCBiN2ZlNGMxYjUwLi5mYzBjOGZjNTJmIDEwMDY0NAotLS0g
YS9zY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2R0cmFjZS5weQorKysgYi9zY3JpcHRzL3RyYWNl
dG9vbC9iYWNrZW5kL2R0cmFjZS5weQpAQCAtNDQsMTEgKzQ0LDE1IEBAIGRlZiBnZW5lcmF0ZV9o
X2JlZ2luKGV2ZW50cywgZ3JvdXApOgogICAgICMgcmVxdWlyZSBTRFRfVVNFX1ZBUklBRElDIHRv
IGJlIGRlZmluZWQuIElmIGR0cmFjZSBpbmNsdWRlcyA8c3lzL3NkdC5oPgogICAgICMgZmlyc3Qg
d2l0aG91dCBkZWZpbmluZyBTRFRfVVNFX1ZBUklBRElDIHRoZW4gdXN0IGJyZWFrcyBiZWNhdXNl
IHRoZQogICAgICMgU1RBUF9QUk9CRVYoKSBtYWNybyBpcyBub3QgZGVmaW5lZC4KKyAgICBvdXQo
JyNpZm5kZWYgU0RUX1VTRV9WQVJJQURJQycpCiAgICAgb3V0KCcjZGVmaW5lIFNEVF9VU0VfVkFS
SUFESUMgMScpCisgICAgb3V0KCcjZW5kaWYnKQogCiAgICAgb3V0KCcjaW5jbHVkZSAiJXMiJyAl
IGhlYWRlciwKICAgICAgICAgJycpCiAKKyAgICBvdXQoJyN1bmRlZiBTRFRfVVNFX1ZBUklBRElD
JykKKwogICAgICMgU3lzdGVtVGFwIGRlZmluZXMgPHByb3ZpZGVyPl88bmFtZT5fRU5BQkxFRCgp
IGJ1dCBvdGhlciBEVHJhY2UKICAgICAjIGltcGxlbWVudGF0aW9ucyBtaWdodCBub3QuCiAgICAg
Zm9yIGUgaW4gZXZlbnRzOgotLSAKMi4yNi4yCgo=


