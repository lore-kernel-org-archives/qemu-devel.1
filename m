Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F2C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF869206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlMEVJAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF869206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQIW-0008Fl-V9
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:29:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTQG9-0003Sf-0J
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTQG8-0001pw-BL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35817
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTQG7-0001pY-Sd
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588080407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UUkZADRWSLy/0kXuXCZYF8emAsm5jHqCUvgzgPa1DUY=;
 b=VlMEVJAPhFU2VnhDYVSvdd1kSZkibAkro0JoE/3HTw4ahF4vEVggb0j0cXyGFALuJkPP8+
 cSxVhRvD1l8krfFRm1jTVnhJOYRjvG2FXKPGdz9E3EFdO0RM0XVwI0djIRPmiAr7JtIUcv
 +am7IN/xXa3d6mePnK4WNuuD4/WtXx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-mo8_qeMBOvSz9OPQAo3b0w-1; Tue, 28 Apr 2020 09:26:32 -0400
X-MC-Unique: mo8_qeMBOvSz9OPQAo3b0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF17107ACF2;
 Tue, 28 Apr 2020 13:26:30 +0000 (UTC)
Received: from localhost (ovpn-112-143.ams2.redhat.com [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AF2A99E1;
 Tue, 28 Apr 2020 13:26:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty() directly
Date: Tue, 28 Apr 2020 15:26:25 +0200
Message-Id: <20200428132629.796753-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Branch: https://github.com/XanClic/qemu.git fix-bdrv_make_empty-v1
Branch: https://git.xanclic.moe/XanClic/qemu.git fix-bdrv_make_empty-v1

Hi,

Right now, there is no centralized bdrv_make_empty() function.  Not only
is it bad style to call BlockDriver methods directly, it is also wrong,
unless the caller has a BdrvChild with BLK_PERM_WRITE taken.

This series fixes that.

Note that as far as I=E2=80=99m aware this series shouldn=E2=80=99t visibly=
 fix anything
at this point; but =E2=80=9Cblock: Introduce real BdrvChildRole=E2=80=9D
(https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00737.html)
makes the iotest break when run with -o data_file=3D$SOMETHING, without
this series applied beforehand.  (That is because without that series,
external data files are treated much like metadata children, so the
format driver always takes the WRITE permission if the file is writable;
but after that series, it only does so when it itself has a parent
requestion the WRITE permission.)


Max Reitz (4):
  block: Add bdrv_make_empty()
  block: Use bdrv_make_empty() where possible
  block: Add blk_make_empty()
  block: Use blk_make_empty() after commits

 include/block/block.h          |  1 +
 include/sysemu/block-backend.h |  2 ++
 block.c                        | 23 +++++++++++++++++++++++
 block/block-backend.c          |  5 +++++
 block/commit.c                 |  8 +++++++-
 block/replication.c            |  6 ++----
 block/vvfat.c                  |  4 +---
 qemu-img.c                     | 19 ++++++++++++++-----
 8 files changed, 55 insertions(+), 13 deletions(-)

--=20
2.25.4


