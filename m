Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CE920659
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pbx3zAZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CE920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3u7-0004sH-3z
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iY3s5-0002yN-67
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iY3rz-00007w-Ux
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iY3rz-00006w-Oq
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574409645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UCkf56YFWycJ2ZyqHYX6XilU67V7nt1y7EbPDibtrUQ=;
 b=Pbx3zAZH483dylkMeDctK+u7s0dADI98syu4sM0A+sif62BEm6WaZXAth7uQNzDYrrX1Eb
 +YtRFFS9raOmbMEL2LJM38Uo+dSQ9nxcI/be1S0HjPvvZR97slam70D0Sjim+52EqCg378
 CTp21OBmkSaSaOWnur5pnXSGkjhlBL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-hiO0UWJXPkGLUkX0sYIklg-1; Fri, 22 Nov 2019 03:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A75B1800D41;
 Fri, 22 Nov 2019 08:00:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1167A60FF9;
 Fri, 22 Nov 2019 08:00:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89FB51138606; Fri, 22 Nov 2019 09:00:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Fix incorrect integer->float conversion caught by clang
Date: Fri, 22 Nov 2019 09:00:37 +0100
Message-Id: <20191122080039.12771-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hiO0UWJXPkGLUkX0sYIklg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: richard.henderson@linaro.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fangrui Song's "[PATCH v2] Fix incorrect integer->float conversions
caught by clang -Wimplicit-int-float-conversion" doesn't apply with
git-am, and it mixes a bug fix, which should be considered for 4.2,
with a cleanup, which should go into 5.0.  I took the liberty to
respin, hope that's alright.

I propose the migration maintainers pick up PATCH 1 for 5.0.

I can submit PATCH 2 for 4.2-rc3.

Fangrui Song (2):
  migration: Fix incorrect integer->float conversion caught by clang
  util/cutils: Fix incorrect integer->float conversion caught by clang

 migration/migration.c | 3 +--
 util/cutils.c         | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

--=20
2.21.0


