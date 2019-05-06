Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F1C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39C8205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="A3UYPLVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39C8205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfWL-0003bU-3O
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:27:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35303)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<590216e2666653bac21d950aaba98f87d0a53324@lizzy.crudebyte.com>)
	id 1hNfTl-0001XV-Tu
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<590216e2666653bac21d950aaba98f87d0a53324@lizzy.crudebyte.com>)
	id 1hNfTl-0005fj-0q
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:24:33 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:47307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<590216e2666653bac21d950aaba98f87d0a53324@lizzy.crudebyte.com>)
	id 1hNfTk-0004zc-Qe
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:Message-Id:Sender:
	Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T+6uJPoWkfQD/iVYDTZBTRiGcUZBD2zXjAiXeKoQClw=;
	b=A3UYPLVO84NTGWQ2gdfsTeZRRJ
	QubENPHv1XGK95x5a53qRG4QuZOF7ZKJkDJoGCw7wE0OJ9f8ZC05+Hvommr7FheHvrxmrg0S+rChC
	5H2XDz2g7Lfd52UBUa2hf0KTvAHAswrqQeNmtc/o/BOeJULSJhufKJ4iCGenVugbtGvq0Hgf0xETn
	xUrpqD6gKXa8qJBcmVQOfcVW5zAIeWde+7yR+XwJ84XHCIVLuvLfHGq/RPx7PP/D/4i3YNkeW4/u/
	d4dNlk1YiSyB+5JS4cfcUssAhIHOhn8N+0CzANhjBWOoiJgVbXMaHVNXHVvaGOckJxAZWJkmqBLBN
	wjfqJuKQ==;
Message-Id: <cover.1557093245.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Mon, 6 May 2019 16:37:15 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v3 0/5] 9p: Fix file ID collisions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v3 of a proposed patch set for fixing file ID collisions with 9pfs. 

That's it from my side for now regarding this overall issue. I am waiting for
your comments on this patch set before doing anything else.

Patch 1 to 4 are identical to the previous version. New patch 5 adds an
optional qemu virtfs device parameter "vii" (very important inode[s]) , which
allows host admins to configure which fs device(s) should get the largest inode
namespaces on guest.

I will also send a (6th) patch against libvirt which allows to configure the
"vii" feature of patch 5 via xml config instead of qemu command line argument.

I am yet unresolved whether or not to use persistency for file IDs that is
introduced with patch 3. After applying the entire patch set, the
persistency feature is disabled by default at compile time, but you can
enable it with macro QPP_TABLE_PERSISTENCY_LIMIT.

Christian Schoenebeck (5):
  9p: mitigates most QID path collisions
  9P: trivial cleanup of QID path collision mitigation
  9p: persistency of QID path beyond reboots / suspensions
  9p: use variable length suffixes for inode mapping
  9p: adds virtfs 'vii' device parameter

 fsdev/9p-marshal.h         |    6 +-
 fsdev/file-op-9p.h         |    1 +
 fsdev/qemu-fsdev-opts.c    |    6 +
 fsdev/qemu-fsdev.c         |    3 +
 hw/9pfs/9p.c               | 1199 +++++++++++++++++++++++++++++++++++++++++++-
 hw/9pfs/9p.h               |  173 +++++++
 hw/9pfs/trace-events       |   14 +-
 hw/9pfs/virtio-9p-device.c |    1 +
 qemu-options.hx            |    5 +-
 vl.c                       |    9 +-
 10 files changed, 1378 insertions(+), 39 deletions(-)

-- 
2.11.0


