Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E44CC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4CA208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4JrK2r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4CA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0ea-0004OI-5m
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0cu-00018G-4q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0cs-0004AB-0i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0cr-00043d-Ro
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/SDmzKoLyVjSdrtiXPQkLc2t/jZBGbtNUWd0UkpEb4=;
 b=W4JrK2r08P2R0oD98lVnKF1xpcJhos7KZoMaGttfFKLTaL/2gePiaGnjzNtrqfPu4xuUwO
 4jdgtlQNSCqgmVsQ70HbWL8gP87X/2333qRXFwbp4+327vOYtGlJGSJzuF77GPTk5n6v0N
 tSVJNji05LwYX69eYUEqntWEwP4fLpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-lMRCue08NFmIKRT7KW8QAw-1; Wed, 11 Mar 2020 08:38:13 -0400
X-MC-Unique: lMRCue08NFmIKRT7KW8QAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DA88017DF;
 Wed, 11 Mar 2020 12:38:12 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83587100164D;
 Wed, 11 Mar 2020 12:38:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] thread: add lock guard macros
Date: Wed, 11 Mar 2020 12:36:22 +0000
Message-Id: <20200311123624.277221-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9jayBndWFyZHMgYXV0b21hdGljYWxseSBjYWxsIHFlbXVfKHJlY18pbXV0ZXhfdW5sb2NrKCkg
d2hlbiByZXR1cm5pbmcgZnJvbSBhCmZ1bmN0aW9uIG9yIGxlYXZpbmcgbGVhdmluZyBhIGxleGlj
YWwgc2NvcGUuICBUaGlzIHNpbXBsaWZpZXMgY29kZSBhbmQKZWxpbWluYXRlcyBsZWFrcyAoZXNw
ZWNpYWxseSBpbiBlcnJvciBjb2RlIHBhdGhzKS4KClRoaXMgc2VyaWVzIGFkZHMgbG9jayBndWFy
ZHMgZm9yIFFlbXVNdXRleCBhbmQgUWVtdVJlY011dGV4LiAgSXQgZG9lcyBub3QKY29udmVydCB0
aGUgZW50aXJlIHRyZWUgYnV0IGluY2x1ZGVzIGV4YW1wbGUgY29udmVyc2lvbnMuCgpTdGVmYW4g
SGFqbm9jemkgKDIpOgogIHRocmVhZDogYWRkIFFlbXVSZWNNdXRleCBsb2NrIGd1YXJkcwogIHRo
cmVhZDogYWRkIFFlbXVNdXRleCBsb2NrIGd1YXJkcwoKIGluY2x1ZGUvcWVtdS90aHJlYWQuaCB8
IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHBsdWdpbnMv
Y29yZS5jICAgICAgICB8ICA2ICsrLS0tCiBwbHVnaW5zL2xvYWRlci5jICAgICAgfCAxNSArKysr
KystLS0tLS0tCiB1dGlsL3FlbXUtdGltZXIuYyAgICAgfCAyMiArKysrKysrKystLS0tLS0tLS0K
IDQgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pCgotLSAK
Mi4yNC4xCgo=


