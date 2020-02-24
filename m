Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91417C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B17520828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFa5GRhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B17520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6B4m-0001Iq-Gw
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j6B45-0000Hc-5k
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j6B44-0007jR-Aw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j6B44-0007jA-35
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582540455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uJ3af6MDdHqEwz7VlIRxdjTfb03ShW5vEahplUG2jPo=;
 b=bFa5GRhC1Ji/uQJyeToaS9MJrxmmUYwxf+IkPZZvw+f2Jqls7zU5QUa3QPdi8gufNy8//6
 DVtTxHXbn1yY/Zd3yH6Une1JCI2FvqEDkXKEhi7U+NnIbSsW7o3mEvWFZWRFxGNGp4sqVx
 aHWUwQ9BB3Y3Vr1iPhHUk8doeGcBdPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-U-qXZyt8Mca-krqk87OJ7g-1; Mon, 24 Feb 2020 05:34:12 -0500
X-MC-Unique: U-qXZyt8Mca-krqk87OJ7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2B9107ACC7;
 Mon, 24 Feb 2020 10:34:11 +0000 (UTC)
Received: from localhost (unknown [10.36.118.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C4181001920;
 Mon, 24 Feb 2020 10:34:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
Date: Mon, 24 Feb 2020 10:34:04 +0000
Message-Id: <20200224103406.1894923-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

UUxJU1RfUkVNT1ZFKCkgYW5kIGZyaWVuZHMgbGVhdmUgZGFuZ2xpbmcgbGlua2VkIGxpc3QgcG9p
bnRlcnMgaW4gdGhlIG5vZGUgdGhhdAp3YXMgcmVtb3ZlZC4gIFRoaXMgbWFrZXMgaXQgaW1wb3Nz
aWJsZSB0byBkZWNpZGUgd2hldGhlciBhIG5vZGUgaXMgY3VycmVudGx5IGluCmEgbGlzdCBvciBu
b3QuICBJdCBhbHNvIG1ha2VzIGRlYnVnZ2luZyBoYXJkZXIuCgpCYXNlZC1vbjogMjAyMDAyMjIw
ODUwMzAuMTc2MDY0MC0xLXN0ZWZhbmhhQHJlZGhhdC5jb20KICAgICAgICAgICgiW1BVTEwgMDAv
MzFdIEJsb2NrIHBhdGNoZXMiKQoKU3RlZmFuIEhham5vY3ppICgyKToKICBxZW11L3F1ZXVlLmg6
IGNsZWFyIGxpbmtlZCBsaXN0IHBvaW50ZXJzIG9uIHJlbW92ZQogIGFpby1wb3NpeDogcmVtb3Zl
IGNvbmZ1c2luZyBRTElTVF9TQUZFX1JFTU9WRSgpCgogaW5jbHVkZS9xZW11L3F1ZXVlLmggfCAx
OSArKysrKysrKysrKysrKystLS0tCiB1dGlsL2Fpby1wb3NpeC5jICAgICB8ICAyICstCiAyIGZp
bGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgotLSAKMi4yNC4x
Cgo=


