Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B06C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED32070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiQMTCn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVuc-0003x7-0w
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVsj-0001p5-Bm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVsf-0000hN-KY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:27:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTVsf-0000h6-3m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588102016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vgrH9Djf6Tqac+155iX/vsMwH9tIG7qAjbDQ8mKYP9Q=;
 b=DiQMTCn9PBXEI3O0iYDKbOQ5KjJfgDAsB9w2WsvVEsTs7SJc+6aZWfaf+Gki3/R37z0w7L
 TcdAtzKVeeRu6YOmHTIXC7Fs5KTetQSJNyhTB8On0lVlEZLwOsgH2TSoJFD2UJd5YxZ9bf
 WwwZnK0JThxr/RSckoXfsg66dAeoZp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-zIdNr59rP6m4LlsqyZ3PEQ-1; Tue, 28 Apr 2020 15:26:53 -0400
X-MC-Unique: zIdNr59rP6m4LlsqyZ3PEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C372107ACCA;
 Tue, 28 Apr 2020 19:26:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 008E41002388;
 Tue, 28 Apr 2020 19:26:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] qcow2: Allow resize of images with internal snapshots
Date: Tue, 28 Apr 2020 14:26:45 -0500
Message-Id: <20200428192648.749066-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-posting this to make Max' life easier when rebasing on top of Kevin's wo=
rk.

Based-on: <20200424125448.63318-1-kwolf@redhat.com>
[PATCH v7 00/10] block: Fix resize (extending) of short overlays

In v4:
- patch 1: fold in Max's touchups to my v3
- patch 1: resolve merge conflict on top of Kevin's block-next branch (trun=
cate signature change)
- patch 2: resolve semantic conflict (truncate signature change)

001/3:[0004] [FC] 'block: Add blk_new_with_bs() helper'
002/3:[0002] [FC] 'qcow2: Allow resize of images with internal snapshots'
003/3:[----] [--] 'qcow2: Tweak comment about bitmaps vs. resize'

Eric Blake (3):
  block: Add blk_new_with_bs() helper
  qcow2: Allow resize of images with internal snapshots
  qcow2: Tweak comment about bitmaps vs. resize

 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 23 +++++++++++++++++
 block/crypto.c                 |  9 +++----
 block/parallels.c              |  8 +++---
 block/qcow.c                   |  8 +++---
 block/qcow2-snapshot.c         | 20 ++++++++++++---
 block/qcow2.c                  | 45 +++++++++++++++++++++++-----------
 block/qed.c                    |  8 +++---
 block/sheepdog.c               | 10 ++++----
 block/vdi.c                    |  8 +++---
 block/vhdx.c                   |  8 +++---
 block/vmdk.c                   |  9 +++----
 block/vpc.c                    |  8 +++---
 blockdev.c                     |  8 +++---
 blockjob.c                     |  7 ++----
 tests/qemu-iotests/061         | 35 ++++++++++++++++++++++++++
 tests/qemu-iotests/061.out     | 28 +++++++++++++++++++++
 17 files changed, 177 insertions(+), 67 deletions(-)

--=20
2.26.2


