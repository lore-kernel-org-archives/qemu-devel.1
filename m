Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2BC3567B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C8F2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvEa2ub0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C8F2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MZx-0003RD-1A
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7MYs-0001bL-2f
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7MYr-0000P3-0m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:02:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7MYq-0000Ov-SZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=te8qvJEQ4NJrIoH5wNT52ObtMA6Da/ph0VWvQSvDJhI=;
 b=BvEa2ub0VY59FJsZ/BKRZyp3dUupR1Kzrtc7UKRtcd/OrPIDuSGSMlixrvdnSrC0eaQHmd
 iOmdiG6taEEXsU/zvZHZFghqktgZZAEB6S2RaJq8ZSADbYmQExo9NGBc8BN+fo88TRKXFp
 ZwiPvVNscR1W68c2RBsGqmQtdGUrI/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-XoyfOPBOMvuzVOIXck1j3g-1; Thu, 27 Feb 2020 12:02:54 -0500
X-MC-Unique: XoyfOPBOMvuzVOIXck1j3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 814BC190B2BE;
 Thu, 27 Feb 2020 17:02:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 193D960C18;
 Thu, 27 Feb 2020 17:02:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/3] qemu-img: Fix check's leak/corruption fix report
Date: Thu, 27 Feb 2020 18:02:48 +0100
Message-Id: <20200227170251.86113-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Cc-ing Eric because of patch 2, mostly)

Hi,

While reviewing the =E2=80=9Cfix two small memleaks=E2=80=9D series
(<20200227012950.12256-1-pannengyuan@huawei.com>) I noticed that we save
ImageCheck.(leaks|corruptions)_fixed from the first run and overwrite
the values obtained in the second run (where they must be zero because
we do not request any fixes in that second run), but we do not overwrite
ImageCheck.has_(leaks|corruptions)_fixed after the second run.  That
smells fishy.

Furthermore, ImageCheck.has_(leaks|corruptions)_fixed are not set based
on whether (leaks|corruptions)_fixed is non-zero, but actually based on
whether the leaks and corruptions fields (respectively) are non-zero.
qcow2=E2=80=99s check implementation reduces the leaks and corruptions valu=
es
when it fixes them, because then there are no leaks and corruptions
after the check anymore.

All in all, after a successful run, you will not see
=E2=80=9Cqemu-img check --output=3Djson=E2=80=9D report corruptions-fixed o=
r leaks-fixed.
Which is a shame.  So this series fixes that and adds a test to ensure
those fields are indeed reported.


Max Reitz (3):
  qemu-img: Fix check's leak/corruption fix report
  iotests: Add poke_file_[bl]e functions
  iotests/138: Test leaks/corruptions fixed report

 qemu-img.c                   |  9 ++++++--
 tests/qemu-iotests/138       | 41 ++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/138.out   | 14 ++++++++++++
 tests/qemu-iotests/common.rc | 37 ++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 4 deletions(-)

--=20
2.24.1


