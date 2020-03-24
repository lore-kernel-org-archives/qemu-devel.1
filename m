Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A09C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7688A208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5PGiHSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7688A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnPI-0003gJ-Jc
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGnLo-0007XJ-LN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGnLn-0001vi-7J
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:28:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGnLn-0001vU-4L
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585070906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DijHAq+LxDiMc9/Hk150Q5nMLsDd1BUstow1AxFMpTA=;
 b=h5PGiHSuldjasjzR5O1I+y868RMVeLoljGOwveIKu8m+r9E7m99mtFk+waYi9eFEc2ZG3g
 eN/MqzvgKeHKXbjCULgeD7q/6rR9AezhkE/MAinsaeFXwl81sB7TC6RAE2sNihJm3YvHb0
 eqpDg7FvuibVOImil8+g8Fu7SoYZpI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-lVPDzTRJNpeZC8PvUblR_Q-1; Tue, 24 Mar 2020 13:28:01 -0400
X-MC-Unique: lVPDzTRJNpeZC8PvUblR_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61151800D5A;
 Tue, 24 Mar 2020 17:28:00 +0000 (UTC)
Received: from localhost (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC2EE60BE0;
 Tue, 24 Mar 2020 17:27:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 0/3] qemu-img: Fix check's leak/corruption fix
 report
Date: Tue, 24 Mar 2020 18:27:54 +0100
Message-Id: <20200324172757.1173824-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Branch: https://github.com/XanClic/qemu.git fix-check-result-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git fix-check-result-v2

v1: https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg01418.html


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


v2:
- Patch 2:
  - Rewrote the new functions as per Eric=E2=80=99s suggestions (thanks a l=
ot!)
  - Changed the functions=E2=80=99 =E2=80=9Cdoc strings=E2=80=9D to not jus=
t show an example,
    but perhaps more importantly what each parameter means
- Patch 3:
  - Eric said the pre-existing comment explaining why 138 doesn=E2=80=99t
    supported data_file made it sound like qemu-img check had a bug.
    I=E2=80=99m sure it does have bugs, but this isn=E2=80=99t one, so I tr=
ied to
    explain it a bit differently.
  - Use poke_file_be in another place
  - Convert sed | grep | sed to a single sed, as per Eric=E2=80=99s suggest=
ion,
    and avoid \< and \>


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/3:[----] [--] 'qemu-img: Fix check's leak/corruption fix report'
002/3:[0029] [FC] 'iotests: Add poke_file_[bl]e functions'
003/3:[0008] [FC] 'iotests/138: Test leaks/corruptions fixed report'


Max Reitz (3):
  qemu-img: Fix check's leak/corruption fix report
  iotests: Add poke_file_[bl]e functions
  iotests/138: Test leaks/corruptions fixed report

 qemu-img.c                   |  9 ++++++--
 tests/qemu-iotests/138       | 41 ++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/138.out   | 14 ++++++++++++
 tests/qemu-iotests/common.rc | 24 +++++++++++++++++++++
 4 files changed, 84 insertions(+), 4 deletions(-)

--=20
2.25.1


