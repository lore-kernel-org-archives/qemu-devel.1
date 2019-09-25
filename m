Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E8C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FB121655
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FB121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDC7u-0003ZO-9K
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDC5e-0001Kt-W1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDC5d-0007Xl-Uu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDC5a-0007Qw-K1; Wed, 25 Sep 2019 14:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53FF018C8931;
 Wed, 25 Sep 2019 18:32:33 +0000 (UTC)
Received: from localhost (unknown [10.40.205.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE8E8608C2;
 Wed, 25 Sep 2019 18:32:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/3] iotests: Fix 125
Date: Wed, 25 Sep 2019 20:32:28 +0200
Message-Id: <20190925183231.11196-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 25 Sep 2019 18:32:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Hi,

iotest 125 is very broken.  It uses qemu-img info=E2=80=99s =E2=80=9Cdisk=
 size=E2=80=9D to
determine an image=E2=80=99s on-disk size, but it does so in a wrong way:=
 It
just fetches the first number ([0-9]+), but that isn=E2=80=99t very usefu=
l
because qemu-img info emits human-readable values that include units and
decimal points.

We should ust stat -c %b instead.  That=E2=80=99s done in patch 3.
Unfortunately, doing so exposed more problems.

Patch 1 fixes a stupid bug in the test itself that we never noticed
because of what patch 3 fixes.  (Pull patch 3 before patch 1 and you=E2=80=
=99ll
see.)

The other thing is actually a bug in XFS.  Its fallocate()
implementation rounds up the length independently of the offset, so if
you try to fallocate an unaligned range, chances are that it might not
allocate the last block your range touches.  Patch 2 detects that case
and skips the test then.  (Pull patch 3 before patch 2 and you=E2=80=99ll=
 see
the test fail on XFS.)


Max Reitz (3):
  iotests: Fix 125 for growth_mode =3D metadata
  iotests: Disable 125 on broken XFS versions
  iotests: Use stat -c %b in 125

 tests/qemu-iotests/125 | 45 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

--=20
2.21.0


