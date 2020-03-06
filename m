Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A3BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2B7206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmxTDa3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2B7206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADkr-0007zw-SS
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jADk8-00074J-8D
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jADk7-00062H-8z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:14:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jADk7-0005xU-5O
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a3LTB1dEbmGFhTwBTCeJgnV00EEb4BBjjtrXmeOnKSE=;
 b=ZmxTDa3U/TGbQ/mfwq15WmFEil8B0MEFQh1XB94JKMwqpGB8vslpnz1LAn8Nj2tLCFVSyr
 K70XLB7xg5VgsoAyt6QdTsYLHeXkv2mcFlGerymDx/9IFzc853jefJiJiUmRzXRE9HriFv
 gJ1Yz6ACRgIk/V+nvBxUCKOir7zmrI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-ylZ-ArgGNkuy3pXxswcR4w-1; Fri, 06 Mar 2020 09:14:20 -0500
X-MC-Unique: ylZ-ArgGNkuy3pXxswcR4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E2F800D5C;
 Fri,  6 Mar 2020 14:14:19 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35BA260BEC;
 Fri,  6 Mar 2020 14:14:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/2] block: bdrv_reopen() with backing file in different
 AioContext
Date: Fri,  6 Mar 2020 15:14:11 +0100
Message-Id: <20200306141413.30705-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- Fix bdrv_reopen_can_attach() call [Berto]

Kevin Wolf (2):
  iotests: Refactor blockdev-reopen test for iothreads
  block: bdrv_reopen() with backing file in different AioContext

 block.c                    | 32 ++++++++++++++++++++++-----
 tests/qemu-iotests/245     | 45 +++++++++++++++++++++++++++++---------
 tests/qemu-iotests/245.out |  4 ++--
 3 files changed, 63 insertions(+), 18 deletions(-)

--=20
2.20.1


