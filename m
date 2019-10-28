Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520AECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236E4214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZdIwDGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236E4214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9Cl-0001wU-HZ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP7yN-0000yN-NI
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP7jG-0003hb-U6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:18:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP7jG-0003ee-Lu
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572279528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wji9qJuwKhcFyI5MbUjbk8bKdp0Oofy5ThRc68qLm88=;
 b=IZdIwDGUDW5QHNYqfP15nUhPNoqsSoDxM1MLKgCJMrEv9SFrZH0JvejnWfbeWpPcDhNYlf
 GU05rdNizslrSPZQGmIY1ICDmzSCIzF8ybzF8bW3L9KECn2CXTWRi5keLbBGlyyYbQp6GP
 8IfxglEWpclqkg4YRMocnoBL7g4Zeog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-KNm-c6AFP6W7nl3ns4rO7g-1; Mon, 28 Oct 2019 12:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6EF3476;
 Mon, 28 Oct 2019 16:18:43 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 277BF600C9;
 Mon, 28 Oct 2019 16:18:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2 0/2] qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
Date: Mon, 28 Oct 2019 17:18:39 +0100
Message-Id: <20191028161841.1198-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KNm-c6AFP6W7nl3ns4rO7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a bug reported on
https://bugs.launchpad.net/qemu/+bug/1850000.  The problem is that
QCOW2_COMPRESSED_SECTOR_MASK is a 32-bit mask when it really needs to be
a 64-bit mask.

The launchpad report mentions only problems with qemu-img check on large
compressed images, but I think it might extend further than that:
- I suppose qcow2_free_any_clusters() would free every compressed offset
  modulo 4G, which isn=E2=80=99t good
- qcow2_update_snapshot_refcount() will probably update compressed
  cluster=E2=80=99s refcounts (in snapshots) modulo 4G, which also isn=E2=
=80=99t good
- And then we have check_refcount_l2() which updates the wrong clusters
  for qemu-img check (as demonstrated in the bug report)

- (qcow2_co_preadv_compressed() is safe because it uses the inverted
  mask, which of course is again just 32 bit)


But I haven=E2=80=99t tested those other cases.


Max Reitz (2):
  qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
  iotests: Add test for 4G+ compressed qcow2 write

 block/qcow2.h              |  2 +-
 tests/qemu-iotests/272     | 79 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/272.out | 10 +++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/272
 create mode 100644 tests/qemu-iotests/272.out

--=20
2.21.0


