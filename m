Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABDC00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111A62073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW2xDe1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111A62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLUg-0005kK-6B
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ieLSX-0003tT-Vs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ieLSS-00020s-RY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:00:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ieLSS-00020E-Nh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575907223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=soUnqibGRC15XOorRralnp+o+j9BwuehxjOmIsX8Ejo=;
 b=SW2xDe1MznKtpM7cYZqOYBgont/nL6ZyGVtrZPL2AD2fzytCGkrd5klAeZ1hk14L/Ft/X3
 uN/LICtjueiRsH1gxq/V8gYIKWA0wEUSQ04I2ZWT/wyUCZa4CjHRDTwfM1N6LuY5RhVohj
 YkQncgHTS0FEgBNzuhED4cETn3noJYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-NAxTcuadMpuFB2QL2oSQXw-1; Mon, 09 Dec 2019 11:00:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A94804214;
 Mon,  9 Dec 2019 16:00:20 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E0265D6B7;
 Mon,  9 Dec 2019 16:00:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for 4.2-rc5 0/1] Bitmap fix for 2019-12-09
Date: Mon,  9 Dec 2019 10:00:14 -0600
Message-Id: <20191209160015.20253-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: NAxTcuadMpuFB2QL2oSQXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8350b17be015bb872f28268bdeba1bac6c380efc=
:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191209' =
into staging (2019-12-09 11:07:34 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-12-09

for you to fetch changes up to f56281abd957561b30538cbe606c3793b9b4c56d:

  block/qcow2-bitmap: fix crash bug in qcow2_co_remove_persistent_dirty_bit=
map (2019-12-09 09:23:04 -0600)

[I know I'm not the usual bitmap maintainer, but John agreed that I could
get this posted faster than he could: it affects incremental bitmaps
which is tangentially NBD-related, and we're already on a tight timeline
given this is 4.2-rc5 material]

----------------------------------------------------------------
bitmap fix for 4.2-rc5

- Fix a regression that broke bitmap deletion without a transaction,
and causes a crash with transaction (only transaction is new to 4.2),
when a qcow2 file contains persistent bitmaps from prior shutdown

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (1):
      block/qcow2-bitmap: fix crash bug in qcow2_co_remove_persistent_dirty=
_bitmap

 block/qcow2-bitmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--=20
2.21.0


