Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63C1C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4012074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3uY6Goq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4012074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkB9-0000fJ-I4
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRk9k-0007QM-FE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRk9i-0006MX-Ot
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:17:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRk9i-0006FP-4B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587680232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iy10fsFF88XFVb0OgFdush86HymFRJ++qKX+Y4K7dc4=;
 b=b3uY6Goq3e3u2x54NYltq8igVmLQA6qiBj4Kx6WzaW4vUMZQ2qQkmZfCO2xFcPVt19nEqz
 zSIibzhaU+4ZvmGSX3Uh9PBkocFbyPYuyboZhMjAjpw0jtFKRtuOvUp9n1aSI+N6ePozjP
 Vfp2DU+FH0ipBVcNuqB1efWkdKdey0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-w3j-GmxsOuqdHtuThzrFUQ-1; Thu, 23 Apr 2020 18:17:09 -0400
X-MC-Unique: w3j-GmxsOuqdHtuThzrFUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 903CE1895910;
 Thu, 23 Apr 2020 22:17:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF0891FDE1;
 Thu, 23 Apr 2020 22:17:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] qcow2: Allow resize of images with internal snapshots
Date: Thu, 23 Apr 2020 17:17:04 -0500
Message-Id: <20200423221707.477404-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v2:
- new patch 1 [Max]
- split off and reword unrelated change into patch 3 [Max]
- improve the test: grep for items of interest, check $? [Max]
- improve commit message explaining partial failure [Max]

Eric Blake (3):
  block: Add blk_new_with_bs() helper
  qcow2: Allow resize of images with internal snapshots
  qcow2: Tweak comment about bitmaps vs. resize

 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 23 +++++++++++++++++++
 block/crypto.c                 |  8 +++----
 block/parallels.c              |  7 +++---
 block/qcow.c                   |  7 +++---
 block/qcow2-snapshot.c         | 20 ++++++++++++----
 block/qcow2.c                  | 42 +++++++++++++++++++++++-----------
 block/qed.c                    |  7 +++---
 block/sheepdog.c               |  9 ++++----
 block/vdi.c                    |  7 +++---
 block/vhdx.c                   |  7 +++---
 block/vmdk.c                   |  9 ++++----
 block/vpc.c                    |  7 +++---
 blockdev.c                     |  8 +++----
 blockjob.c                     |  7 ++----
 tests/qemu-iotests/061         | 35 ++++++++++++++++++++++++++++
 tests/qemu-iotests/061.out     | 28 +++++++++++++++++++++++
 17 files changed, 167 insertions(+), 66 deletions(-)

--=20
2.26.2


