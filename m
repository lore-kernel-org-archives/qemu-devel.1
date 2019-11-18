Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B8C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B2322309
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbzbPF1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B2322309
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpXB-00038A-0k
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWpV8-0001lF-J2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWpV7-0006ul-E0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:28:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWpV7-0006uM-Ac
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574116084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gMMwvW/Ngv8qLv/n8ax6ThX9+DIc5Z1hnaqThWVHljc=;
 b=FbzbPF1er6lzujkWqcxFXDuosEy6EUVR0xT/mGkJMRN/l8PxJG+jF0oKtMLjHoxpIzvaNY
 EPU4JYW+V5cP8nL0qLnyJO7zY1p4cjrupxSkl5v7dcs2Y2EX7gr8rgq2lbgR4JST3j9IpT
 Bxy1tXzeNhhDzCnu31kb1K7OFAMjQtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-3wAQCfs0NA2ZQbx8LIGGPw-1; Mon, 18 Nov 2019 17:28:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF8091883521;
 Mon, 18 Nov 2019 22:27:59 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DA718918;
 Mon, 18 Nov 2019 22:27:50 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] hw: Remove dynamic field width from trace events
Date: Mon, 18 Nov 2019 23:27:44 +0100
Message-Id: <20191118222746.31467-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3wAQCfs0NA2ZQbx8LIGGPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes LP#1844817 [2].

(Eric noted in [1] the dtrace via stap backend can not support
the dynamic '*' width format.)

If they are trivial/block/tracing pull in preparation, this
series will be happy to be taken, else it will go via mips-next.

Thanks,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04720.html
[2] https://bugs.launchpad.net/qemu/+bug/1844817

Philippe Mathieu-Daud=C3=A9 (2):
  hw/block/pflash: Remove dynamic field width from trace events
  hw/mips/gt64xxx: Remove dynamic field width from trace events

 hw/block/pflash_cfi01.c |  8 ++++----
 hw/block/pflash_cfi02.c |  8 ++++----
 hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
 hw/block/trace-events   |  8 ++++----
 hw/mips/trace-events    |  4 ++--
 5 files changed, 22 insertions(+), 22 deletions(-)

--=20
2.21.0


