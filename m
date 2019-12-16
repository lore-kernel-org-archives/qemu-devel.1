Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6779EC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A3E206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/xDBmqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A3E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguMZ-0005Gl-3m
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igtrp-00052a-7m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igtro-0004OO-35
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igtrn-0004NU-VX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576516147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pBZ1ig66DZCy55xtov1gHowe4TOTAUf36efY0pqCG68=;
 b=C/xDBmqXmBkAL42AsoMXorU2RHy8LaJP8pqecP29hgFxRd4OSJokhUt0cD3RujTk0I6oH/
 SWRnhybyGrodwW29gIQShAGUCI72f2nnQCk7QFezq+vgeMVebATJ93KxO0h2yPe9Ptqr50
 c2mkfcytlnNo7xBMFjqb7k46yJD6uyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-FYxy9LbvNYaZkssOFNeOfw-1; Mon, 16 Dec 2019 12:09:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0078107ACC4;
 Mon, 16 Dec 2019 17:09:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 912696FEE8;
 Mon, 16 Dec 2019 17:09:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 00/10] iotests: Remove duplicated blockdev_create()
Date: Mon, 16 Dec 2019 18:08:47 +0100
Message-Id: <20191216170857.11880-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FYxy9LbvNYaZkssOFNeOfw-1
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We kept copying (and occasionally slightly modifying) the
blockdev_create() function first added in 206. With now nine tests
sharing duplicates of almost the same function (and me being about to
add the tenth one), it's probably time to unify them into a single
iotests.py function.

Kevin Wolf (10):
  iotests: Create VM.blockdev_create()
  iotests: 255: Drop blockdev_create()
  iotests: 206: Convert to VM.blockdev_create()
  iotests: 210: Convert to VM.blockdev_create()
  iotests: 212: Convert to VM.blockdev_create()
  iotests: 213: Convert to VM.blockdev_create()
  iotests: 237: Convert to VM.blockdev_create()
  iotests: 266: Convert to VM.blockdev_create()
  iotests: 207: Remove duplication with VM.blockdev_create()
  iotests: 211: Remove duplication with VM.blockdev_create()

 tests/qemu-iotests/206        | 232 ++++++++++++++++------------------
 tests/qemu-iotests/207        |   8 +-
 tests/qemu-iotests/210        |  81 ++++++------
 tests/qemu-iotests/211        |  12 +-
 tests/qemu-iotests/212        | 101 +++++++--------
 tests/qemu-iotests/213        | 113 ++++++++---------
 tests/qemu-iotests/237        | 139 ++++++++++----------
 tests/qemu-iotests/255        |  10 --
 tests/qemu-iotests/266        |  69 +++++-----
 tests/qemu-iotests/266.out    |  14 ++
 tests/qemu-iotests/iotests.py |  16 +++
 11 files changed, 374 insertions(+), 421 deletions(-)

--=20
2.20.1


