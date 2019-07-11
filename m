Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E48C742A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2409D21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2409D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlfD9-0004Xh-Ut
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlfCt-0003kJ-Fy
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlfCr-0000lb-1S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hlfCp-0000gb-Bk
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0407530C1AEA;
 Thu, 11 Jul 2019 19:58:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F75600D1;
 Thu, 11 Jul 2019 19:58:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 11 Jul 2019 21:57:59 +0200
Message-Id: <20190711195804.30703-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 19:58:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 0/5] block: Generic file truncation/creation
 fallbacks
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Some protocol drivers do not really support file truncation but still
implement .bdrv_co_truncate(): They just don=E2=80=99t do anything when a=
sked to
shrink a file.  This is reflected by qemu-img, which warns if you resize
a file and it has the exact same length afterwards as it had before.

We can just do that generically.  There is no reason for some protocol
drivers to act ashamed and pretend nobody notices.  The only thing we
have to take care of is to zero everything in the first sector past the
desired EOF, so that format probing won=E2=80=99t go wrong.

(RFC: Is it really OK to just do this for all block drivers?)

Similarly, we can add a fallback file creation path: If a block driver
does not support creating a file but it already exists, we can just use
it.  All we have to do is truncate it to the desired size.


This is an RFC because it feels weird and I don=E2=80=99t want people to
associate me with weird stuff too closely.

Well, patch 1 isn=E2=80=99t really an RFC.  It=E2=80=99s just a fix.


I was inspired to this series by Maxim=E2=80=99s patch =E2=80=9Cblock/nvm=
e: add support
for image creation=E2=80=9D (from his =E2=80=9CFew fixes for userspace NV=
ME driver=E2=80=9D
series).


Max Reitz (5):
  block/nbd: Fix hang in .bdrv_close()
  block: Generic truncation fallback
  block: Fall back to fallback truncate function
  block: Generic file creation fallback
  iotests: Add test for fallback truncate/create

 block.c                    | 77 ++++++++++++++++++++++++++++++++------
 block/file-posix.c         | 21 +----------
 block/io.c                 | 69 ++++++++++++++++++++++++++++++++--
 block/nbd.c                | 12 +++++-
 block/sheepdog.c           |  2 +-
 tests/qemu-iotests/259     | 71 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 20 ++++++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 235 insertions(+), 38 deletions(-)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

--=20
2.21.0


