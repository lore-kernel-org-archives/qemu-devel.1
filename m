Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3FAC28CBC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B522076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXDo02I9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B522076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9Pw-0002xw-C0
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU9KQ-0007xB-LW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU9Gf-0003zo-Ka
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:34:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jU9Ge-0003w6-T2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588253419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nO+EmsvP2uNZFX8yiB87NgL2rmnR5sL9kPGCcHzAwbc=;
 b=VXDo02I9Ns8hk+1kUIAGkits4yWA/Cav6uTvaumCNOWUw8muruyzBHX2Dy5tNKBdwzDztJ
 95+GcuSSPGtAh5Dq7M3kzchc16ek7yoTG7/yYsm9iq9Kx2FrikZhPwnRYfIkW3CWMmsJGs
 Ix9Ab9HNjUvV/7Fwjc9E31hG9vdSW8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-KiW_9laAOZCQFJz5N20Nvg-1; Thu, 30 Apr 2020 09:30:17 -0400
X-MC-Unique: KiW_9laAOZCQFJz5N20Nvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3B6C872FE4;
 Thu, 30 Apr 2020 13:30:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2F2466071;
 Thu, 30 Apr 2020 13:30:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/6] vmdk: Fix zero cluster handling
Date: Thu, 30 Apr 2020 15:30:01 +0200
Message-Id: <20200430133007.170335-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What I was really investigating is why 055 was so slow. I couldn't solve
that, but instead I found out that our VMDK code for zero clusters and
write_zeroes was completely broken. Apart from segfaults when zero
clusters were actually enabled, this caused a compressed backup target
to result in a bigger file than uncompressed with VMDK.

This series tries to fix it (with one bonus performance patch).

Kevin Wolf (6):
  vmdk: Rename VmdkMetaData.valid to new_allocation
  vmdk: Fix zero cluster allocation
  vmdk: Fix partial overwrite of zero cluster
  vmdk: Don't update L2 table for zero write on zero cluster
  vmdk: Flush only once in vmdk_L2update()
  iotests: vmdk: Enable zeroed_grained=3Don by default

 block/vmdk.c             | 47 +++++++++++++++++++++++++---------------
 tests/qemu-iotests/059   |  6 ++---
 tests/qemu-iotests/check |  3 +++
 3 files changed, 35 insertions(+), 21 deletions(-)

--=20
2.25.3


