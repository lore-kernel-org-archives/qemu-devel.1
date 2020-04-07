Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D182CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CACB20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nfy3q4df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CACB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLouI-000261-Oj
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLotR-0000XL-NT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLotQ-000131-4J
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLotQ-00010V-0G
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586268474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mzC+XabShEIaOL5OSC1lBE2IU0ib6Lc7GwHdBD2ONdk=;
 b=Nfy3q4dfZPXXR+t+kDlBjSzkhi60/4/RlQcK7YIb5OPZmGSuuxi9/18UUqHEYSnNzeQhWu
 x39OG2d1F0NNBvyh7OzWv14Yp7Apjl1X8cK6CWq52eXkq3ltasi5wDFjY/yoSziZ4SzOuP
 ZSdZ29vn8jbvl7Lkmz5R6ZNVY2ckG9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-cyEasZuAMim_fC49Ix4Q8A-1; Tue, 07 Apr 2020 10:07:52 -0400
X-MC-Unique: cyEasZuAMim_fC49Ix4Q8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A212149C5;
 Tue,  7 Apr 2020 14:07:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12B685C1BB;
 Tue,  7 Apr 2020 14:07:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/4] async: fix hangs on weakly-ordered architectures
Date: Tue,  7 Apr 2020 10:07:41 -0400
Message-Id: <20200407140746.8041-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: fangying1@huawei.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ARM machines and other weakly-ordered architectures have been suffering
for a long time from hangs in qemu-img and qemu-io.  For QEMU binaries
these are mitigated by the timers that sooner or later fire in the main
loop, but these will not happen for the tools and probably not with I/O
threads either.

The fix is in patch 5.  Patch 1-3 are docs updates that explain the bug,
and patch 4 is a bugfix exposed by the new patch.

Paolo

Paolo Bonzini (5):
  atomics: convert to reStructuredText
  atomics: update documentation
  rcu: do not mention atomic_mb_read/set in documentation
  aio-wait: delegate polling of main AioContext if BQL not held
  async: use explicit memory barriers

 docs/devel/atomics.rst   | 501 +++++++++++++++++++++++++++++++++++++++
 docs/devel/atomics.txt   | 403 -------------------------------
 docs/devel/index.rst     |   1 +
 docs/devel/rcu.txt       |   4 +-
 include/block/aio-wait.h |  22 ++
 include/block/aio.h      |  29 +--
 util/aio-posix.c         |  16 +-
 util/aio-win32.c         |  17 +-
 util/async.c             |  16 +-
 9 files changed, 576 insertions(+), 433 deletions(-)
 create mode 100644 docs/devel/atomics.rst
 delete mode 100644 docs/devel/atomics.txt

--=20
2.18.2


