Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC6C3B186
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A872082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5QLu7rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A872082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40039 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1GpX-0007j4-6d
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Gnr-0006B7-3W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Gnp-0001Ke-Nw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Gnp-0001Hk-K3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581370873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7BTCCwQJaIuwN17Popi7xqFM4a9sdcVlcb3nowwPBE=;
 b=d5QLu7rYvgb290NNVGlJO7CKaLxHTWGUZqeXu5YI6LtdAxJAOkHH3/2oI8L9jg488VLpFp
 iqyOMEDpJZ94femUpV98MM99/euX5hM6PTX9oiKzT6LqcuYE5zS6JIudUGOcCbgQeGkjdF
 H5OEmL93ganzC9xbDEEMUkT5ZbpGVjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-6JQrVBidMR-cLnMd3VoM1w-1; Mon, 10 Feb 2020 16:41:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A72800D48;
 Mon, 10 Feb 2020 21:41:10 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE265D9CA;
 Mon, 10 Feb 2020 21:41:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu PATCH 0/3] NBD_INFO_INIT_STATE extension
Date: Mon, 10 Feb 2020 15:41:06 -0600
Message-Id: <20200210214109.751734-1-eblake@redhat.com>
In-Reply-To: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6JQrVBidMR-cLnMd3VoM1w-1
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
Cc: vsementsov@virtuozzo.com, rjones@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See the cross-posted cover letter for more details.

Based-on: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08075.ht=
ml

Eric Blake (3):
  nbd: Preparation for NBD_INFO_INIT_STATE
  nbd: Add .bdrv_known_zeroes() client support
  nbd: Add .bdrv_known_zeroes() server support

 block/block-backend.c          |  9 +++++++++
 block/nbd.c                    | 15 +++++++++++++++
 docs/interop/nbd.txt           |  1 +
 include/block/nbd.h            | 13 +++++++++++++
 include/sysemu/block-backend.h |  1 +
 nbd/client.c                   | 24 ++++++++++++++++++++----
 nbd/common.c                   |  2 ++
 nbd/server.c                   | 11 +++++++++++
 nbd/trace-events               |  1 +
 qemu-nbd.c                     | 13 +++++++++++++
 tests/qemu-iotests/223.out     |  4 ++++
 tests/qemu-iotests/233.out     |  1 +
 12 files changed, 91 insertions(+), 4 deletions(-)

--=20
2.24.1


