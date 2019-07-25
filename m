Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F9C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9554A2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9554A2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqg5m-0007Yj-Fk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqg5P-0006PV-Vh
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqg5O-00057v-RD
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqg5M-00055x-9z; Thu, 25 Jul 2019 11:55:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B12C2D1EE8;
 Thu, 25 Jul 2019 15:55:15 +0000 (UTC)
Received: from localhost (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1234C60148;
 Thu, 25 Jul 2019 15:55:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 17:55:09 +0200
Message-Id: <20190725155512.9827-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 15:55:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] block: Make various formats' block_status
 recurse again
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

69f47505ee66afaa513305de0c1895a224e52c45 changed block_status so that it
would only go down to the protocol layer if the format layer returned
BDRV_BLOCK_RECURSE, thus indicating that it has no sufficient
information whether a given range in the image is zero or not.
Generally, this is because the image is preallocated and thus all ranges
appear as zeroes.

However, it only implemented this preallocation detection for qcow2.
There are more formats that support preallocation, though: vdi, vhdx,
vmdk, vpc.  (Funny how they all start with =E2=80=9Cv=E2=80=9D.)

For vdi, vmdk, and vpc, the fix is rather simple, because they really
have different subformats depending on whether an image is preallocated
or not.  This makes the check very simple.

vhdx is more like qcow2, where after the image has been created, it
isn=E2=80=99t clear whether it=E2=80=99s been preallocated or everything =
is allocated
because everything was already written to.  69f47505ee added a heuristic
to qcow2 to get around this, but I think that=E2=80=99s too much for vhdx=
.  I
just left it unfixed, because I don=E2=80=99t care that much, honestly (a=
nd I
don=E2=80=99t think anyone else does).


Max Reitz (3):
  vdi: Make block_status recurse for fixed images
  vmdk: Make block_status recurse for flat extents
  vpc: Do not return RAW from block_status

 block/vdi.c  | 3 ++-
 block/vmdk.c | 3 +++
 block/vpc.c  | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

--=20
2.21.0


