Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB8ECA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377E5206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSbwsNkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377E5206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTX3-0003Mi-13
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMTVK-0001Ac-3f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMTVG-0008DJ-Ql
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMTVF-0008BT-Dj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571648244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N0DGlP89YrsIg5D+xLCQD4v5tt3099hQfZE4X5ZSg4w=;
 b=WSbwsNkxTZUqOGI9Xwp7rTokk3nJQ6AsGEwJ3IqJS3V30YVcKwkqaAviu+PDuEZiKHtAph
 5rNHBG0z+qaT2jqcI7pbiNbqea5+jSjvjrEHAGKJVZIHuzqzaV+80vLOzik22HiB/PTRij
 q11Iz+dvdAHGHbHaeu16iIp5YRigBWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-t9TWIAytOKy1dvo9T8JZ0g-1; Mon, 21 Oct 2019 04:57:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30ED21005500;
 Mon, 21 Oct 2019 08:57:20 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 474A25D6B0;
 Mon, 21 Oct 2019 08:57:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] s390x/tcg: Vector instruction fixes
Date: Mon, 21 Oct 2019 10:57:09 +0200
Message-Id: <20191021085715.3797-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: t9TWIAytOKy1dvo9T8JZ0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ivan Warren <ivan@vmfacility.fr>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ivan reported that a simple
    $ go get -v -d github.com/FactomProject/factom

Will result in errors when vector instructions are in use. Turns out
golang makes excessive use of vector instructions, e.g., for crypto, hashes
but also basic math.

I tracked the involved vector instructions and started writing more
tests for them (will upstream them once they are in a better shape). Turns
out there are quite some issues remaining. golang uses instructions not
yet used by the kernel or by glibc.

With these patches, "go get" works again. It wouldn't surprise me if there
are more BUGs in the vector instructions. Will continue writing more tests.

Cc: Ivan Warren <ivan@vmfacility.fr>

v1 -> v2:
- "s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW INDICATION"
-- Fix by inverting the result
- "s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW INDICATION"
-- Reuse gen_ac2_i64()
- "s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION"
-- Reuse gen_accc2_i64()
- Ran against more tests

David Hildenbrand (6):
  s390x/tcg: Fix VECTOR MULTIPLY LOGICAL ODD
  s390x/tcg: Fix VECTOR MULTIPLY AND ADD *
  s390x/tcg: Fix VECTOR SHIFT RIGHT ARITHMETIC BY BYTE
  s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW INDICATION
  s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW INDICATION
  s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION

 target/s390x/translate_vx.inc.c | 30 ++++++++++++------------------
 target/s390x/vec_int_helper.c   | 18 ++++++++++--------
 2 files changed, 22 insertions(+), 26 deletions(-)

--=20
2.21.0


