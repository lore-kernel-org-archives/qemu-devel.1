Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AAEC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9872064B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9872064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyUL-0003Au-SK
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hmyTs-000276-QO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hmyTr-0001eB-JI
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:45:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hmyTo-0001c7-Rl; Mon, 15 Jul 2019 06:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1C908666F;
 Mon, 15 Jul 2019 10:45:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EE4D1001B00;
 Mon, 15 Jul 2019 10:45:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 12:45:04 +0200
Message-Id: <20190715104508.7568-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 15 Jul 2019 10:45:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1? 0/4] block: Fix three
 .bdrv_has_zero_init()s
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
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

.bdrv_has_zero_init() must not return 1 if the (newly created[1]) image
may not return zeroes when read.

[1] This is guaranteed by the caller.

If the image is preallocated, this generally depends on the protocol
layer, because the format layer will just allocate the necessary
metadata, make it point to data blocks and leave their initialization to
the protocol layer.  For example, qcow2:

- leaves the blocks uninitialized with preallocation=3Dmetadata,
- and passes preallocation=3Dfalloc and =3Dfull on to the protocol node.

In either case, the data then stored in these blocks fully depends on
the protocol level.

Therefore, format drivers have to pass through .bdrv_has_zero_init() to
the data storage node when dealing with preallocated images.

Protocol drivers OTOH have to be accurate in what they return from
.bdrv_has_zero_init().  They are free to return 0 even for preallocated
images.


So let=E2=80=99s look at the existing .bdrv_has_zero_init() implementatio=
ns:

- file-posix: Always returns 1 (for regular files).  Correct, because it
  makes sure the image always reads as 0, preallocated or not.

- file-win32: Same.  (But doesn=E2=80=99t even support preallocation.)

- gluster: Always returns 0.  Safe.

- nfs: Only returns 1 for regular files, similarly to file-posix.  Seems
  reasonable.

- parallels: Always returns 1.  This format does not support
  preallocation, but apparently ensures that it always writes out data
  that reads back as 0 (where necessary), because if the protocol node
  does not have_zero_init, it explicitly writes zeroes to it instead of
  just truncating it.
  So this driver seems OK, too.

- qcow2: Always returns 1.  This is wrong for preallocated images, and
  really wrong for preallocated encrypted images.  Addressed by patch 1.

- qcow: Always returns 1.  Has no preallocation support, so that seems
  OK.

- qed: Same as qcow.

- raw: Always forwards the value from the filtered node.  OK.

- rbd: Always returns 1.  This is a protocol driver, so I=E2=80=99ll just=
 trust
  it knows what it=E2=80=99s doing.

- sheepdog: Always returns 1.  From the fact that its preallocation code
  simply reads the image and writes it back, this seems correct to me.

- ssh: Same as nfs.

- vdi: Always returns 1.  It does support preallocation=3Dmetadata, in
  which case this may be wrong.  Addressed by patch 2.

- vhdx: Similar to vdi, except it doesn=E2=80=99t support @preallocation,=
 but
  has its own option =E2=80=9Csubformat=3Dfixed=E2=80=9D.  Addressed by p=
atch 3.

- vmdk: Hey, this one is already exactly what we want.  If any of the
  extents is flat, it goes to the respective protocol node, and if that
  does not have_zero_init, it returns 0.  Great.
  (Added in commit da7a50f9385.)

- vpc: Hey, this one, too.  With subformat=3Dfixed, it returns what the
  protocol node has to say about has_zero_init.
  (Added in commit 72c6cc94daa.)

So that leaves three cases to fix, which are the first three patches in
this series.  The final patch adds a test case for qcow2.  (It=E2=80=99s
difficult to test the other drivers, because that would require a
protocol driver with image creation support and has_zero_init=3D0, which
is not so easily available.)


Max Reitz (4):
  qcow2: Fix .bdrv_has_zero_init()
  vdi: Fix .bdrv_has_zero_init()
  vhdx: Fix .bdrv_has_zero_init()
  iotests: Convert to preallocated encrypted qcow2

 block/qcow2.c              | 90 +++++++++++++++++++++++++++++++++++++-
 block/vdi.c                | 13 +++++-
 block/vhdx.c               | 21 ++++++++-
 tests/qemu-iotests/188     | 20 ++++++++-
 tests/qemu-iotests/188.out |  4 ++
 5 files changed, 144 insertions(+), 4 deletions(-)

--=20
2.21.0


