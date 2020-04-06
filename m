Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DACC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00A2206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDKWYvUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00A2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXCk-0002I2-RY
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 15:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLXBZ-000117-Pd
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLXBY-0006gF-CC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLXBY-0006fQ-50
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586200407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XpCiK7bXobSLbFTx/Npo5tpDvRVW4TLqXz3hczS0kcc=;
 b=iDKWYvUHzr8IuE4UaKPXCdeG11elKt9yEusxWAsentvPmfa0pm9RkQYUUE+qq15X35lNY1
 oKPWtjtcdjUWtXvP3QLgt2MKo81lqmXP9JySBoSJS7CWzNWojsYz4qs+Cwokir4ciVVGcD
 B57X6xCcnQMX8+zQfNDeYZNDzfPX2pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-P3A3wDr_P1uaNWWgHCWbSA-1; Mon, 06 Apr 2020 15:13:25 -0400
X-MC-Unique: P3A3wDr_P1uaNWWgHCWbSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70F9A18A8C80;
 Mon,  6 Apr 2020 19:13:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29F236EF97;
 Mon,  6 Apr 2020 19:13:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/4] async: fix hangs on weakly-ordered architectures
Date: Mon,  6 Apr 2020 15:13:16 -0400
Message-Id: <20200406191320.13371-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Ying Fang <fangying1@huawei.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch 4 fixes qemu-img and qemu-io hangs on weakly-ordered architectures.
Patch 1-3 are related docs fixes and improvements.

This is RFC because it relies on the iothread being locked during aio_poll
on the main AioContext.  If I add assertions for this however I see a
failure for test 267, so I am posting it as a preview before I debug that.
The doc patches can also go in independently of course.

Paolo

Paolo Bonzini (4):
  atomics: convert to reStructuredText
  atomics: update documentation for C11
  rcu: do not mention atomic_mb_read/set in documentation
  async: use explicit memory barriers

 docs/devel/atomics.rst | 385 +++++++++++++++++++++++++++++++++++++++
 docs/devel/atomics.txt | 403 -----------------------------------------
 docs/devel/index.rst   |   1 +
 docs/devel/rcu.txt     |   4 +-
 util/aio-posix.c       |   9 +-
 util/aio-win32.c       |   8 +-
 util/async.c           |  12 +-
 7 files changed, 413 insertions(+), 409 deletions(-)
 create mode 100644 docs/devel/atomics.rst
 delete mode 100644 docs/devel/atomics.txt

--=20
2.18.2


