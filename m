Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A8C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA6A20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeujU3cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA6A20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3j9-0004KD-OX
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS3hM-0001LR-HB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS3hL-0007T8-Eg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:09:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS3hK-0007Rb-Um
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587755353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=65OKKoI/pKsqm6NI9kEtTLS+aiPjHvw24e+mrsVACtk=;
 b=JeujU3cN0zIFS8r0zEu9y4MgWwQYsciQMj0C+hL6f0pFx5FG2K3glb69Bx8jyDA8kXkxEu
 v+2DSMG6SSf11t6Cqp3x+XemcuT+KNQt+/m5YJutNozJxvFwq4I4l1X4QYRS/G93eTrDQi
 aOlJJbQYYhp5wmBbUbqaxejuOYGdYq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-0BMNBMffNUiSxigQhYyNow-1; Fri, 24 Apr 2020 15:09:12 -0400
X-MC-Unique: 0BMNBMffNUiSxigQhYyNow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01EFB1009451;
 Fri, 24 Apr 2020 19:09:11 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9F545D9CC;
 Fri, 24 Apr 2020 19:09:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] qcow2: Allow resize of images with internal snapshots
Date: Fri, 24 Apr 2020 14:09:00 -0500
Message-Id: <20200424190903.522087-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v3:
- patch 1: fix error returns [patchew, Max], R-b dropped
- patch 2,3: unchanged, so add R-b

Eric Blake (3):
  block: Add blk_new_with_bs() helper
  qcow2: Allow resize of images with internal snapshots
  qcow2: Tweak comment about bitmaps vs. resize

 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 23 +++++++++++++++++
 block/crypto.c                 | 10 +++-----
 block/parallels.c              |  8 +++---
 block/qcow.c                   |  8 +++---
 block/qcow2-snapshot.c         | 20 ++++++++++++---
 block/qcow2.c                  | 45 +++++++++++++++++++++++-----------
 block/qed.c                    |  9 +++----
 block/sheepdog.c               | 11 ++++-----
 block/vdi.c                    |  8 +++---
 block/vhdx.c                   |  9 +++----
 block/vmdk.c                   |  9 +++----
 block/vpc.c                    |  8 +++---
 blockdev.c                     |  8 +++---
 blockjob.c                     |  7 ++----
 tests/qemu-iotests/061         | 35 ++++++++++++++++++++++++++
 tests/qemu-iotests/061.out     | 28 +++++++++++++++++++++
 17 files changed, 177 insertions(+), 71 deletions(-)

--=20
2.26.2


