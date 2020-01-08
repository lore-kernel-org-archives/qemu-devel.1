Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C9DC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F55206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUVPC/7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F55206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9Re-00062l-Ge
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q5-0003vZ-AX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q2-0004XG-8Z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ip9Q2-0004Wn-5Y
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578482553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CtmmA9E68r1HvEbrexz8X2iHJRv6g2zy+89x9DQTmzM=;
 b=GUVPC/7KvyWC1m9Pn1t6t/KMBibvugXnf+CQfxRwSq0rN2VnsX8C9sRpNvrHaEKq3MyaoF
 2zGWKYR6y7Jyiq0cm+n4NgSIjURvxA64emmeQejxAlo7l9qRQA4zB0Qntx4sll6nLZyWcB
 KDwfAUDTAW6cNp0KArIs9bavS+8tcbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-8a-nmlYcOR2-08a_37lazw-1; Wed, 08 Jan 2020 06:22:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37974184B1E3;
 Wed,  8 Jan 2020 11:22:25 +0000 (UTC)
Received: from localhost (ovpn-116-249.ams2.redhat.com [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC3E686C5F;
 Wed,  8 Jan 2020 11:22:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] luks: add qemu-img measure support
Date: Wed,  8 Jan 2020 11:22:16 +0000
Message-Id: <20200108112220.499180-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8a-nmlYcOR2-08a_37lazw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds qemu-img measure support to the "luks" block driver.=
  We
just need to take into account the LUKS header when sizing the image.

Stefan Hajnoczi (4):
  luks: extract block_crypto_calculate_payload_offset()
  luks: implement .bdrv_measure()
  qemu-img: allow qemu-img measure --object without a filename
  iotests: add 282 luks qemu-img measure test

 block/crypto.c             | 146 +++++++++++++++++++++++++++++++++++++
 block/crypto.h             |   5 ++
 block/qcow2.c              |  59 +--------------
 qemu-img.c                 |   6 +-
 tests/qemu-iotests/282     |  93 +++++++++++++++++++++++
 tests/qemu-iotests/282.out |  30 ++++++++
 tests/qemu-iotests/group   |   1 +
 7 files changed, 281 insertions(+), 59 deletions(-)
 create mode 100755 tests/qemu-iotests/282
 create mode 100644 tests/qemu-iotests/282.out

--=20
2.24.1


