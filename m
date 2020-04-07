Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A01C2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B595A2063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghvK4xkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B595A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLn7d-0005hV-Tf
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLn6i-0004DQ-UQ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLn6h-0007w5-Te
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLn6U-0007q5-1G
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586261597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oEvCz3yhhcDH8yi0DAfu1xhasW4XpPF2rydImtpMQOE=;
 b=ghvK4xkUsHfQjqoVpHkXaPGiS/OYSEVeOIjZ6x5GqiFINMapIYShaPCb0wGaUPUo6NiYP7
 Jm34iZOIjCAgMMcc2HbvndK0FcTMFH1vBoXi1bSIQTrqfJ4TtT7ecVCESxZVOt1Igiv/35
 lbQsrRdo9I9vOFs++0Y8y4HtCO/WD8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-PzR4tiaYMQ-lib4HQXw81A-1; Tue, 07 Apr 2020 08:13:16 -0400
X-MC-Unique: PzR4tiaYMQ-lib4HQXw81A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A94A0CBF;
 Tue,  7 Apr 2020 12:13:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD86C100164D;
 Tue,  7 Apr 2020 12:13:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v3 0/3] block: Fix blk->in_flight during
 blk_wait_while_drained()
Date: Tue,  7 Apr 2020 14:12:56 +0200
Message-Id: <20200407121259.21350-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, s.reiter@proxmox.com,
 qemu-devel@nongnu.org, dietmar@proxmox.com, stefanha@redhat.com,
 mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes deadlocks when draining a BlockBackend in an iothread that
receives new requests at the same time.

v3:
- Call blk_inc/dec_in_flight() in blk_prw() rather than inside the
  coroutines [Max]

v2:
- Rework the whole thing so that direct callers of blk_co_*() aren't
  broken after the series [Max]

Kevin Wolf (3):
  block-backend: Reorder flush/pdiscard function definitions
  block: Increase BB.in_flight for coroutine and sync interfaces
  block: Fix blk->in_flight during blk_wait_while_drained()

 include/sysemu/block-backend.h |   1 -
 block/block-backend.c          | 206 ++++++++++++++++++++-------------
 2 files changed, 128 insertions(+), 79 deletions(-)

--=20
2.20.1


