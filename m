Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E78EC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660C62184C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C62184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQSg-0004Tb-LO
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjQQQ-0002fN-Mz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjQQO-0005dF-OI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hjQQF-0004vh-NY; Fri, 05 Jul 2019 11:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FBE42F8BDA;
 Fri,  5 Jul 2019 15:46:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 371661001B27;
 Fri,  5 Jul 2019 15:46:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:46:30 +0200
Message-Id: <20190705154639.16591-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 05 Jul 2019 15:46:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/9] hw/block/pflash_cfi01: Add
 DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pflash device lacks a reset() function.
When a machine is resetted, the flash might be in an
inconsistent state, leading to unexpected behavior:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
Resolve this issue by adding a DeviceReset() handler.

Fix also two minor issues, and clean a bit the codebase.

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00962.=
html
- addressed Laszlo review comments

Since v2:
- consider migration (Laszlo, Peter)

$ git backport-diff -u v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/9:[----] [--] 'hw/block/pflash_cfi01: Removed an unused timer'
002/9:[0008] [FC] 'hw/block/pflash_cfi01: Use the correct READ_ARRAY valu=
e'
003/9:[----] [-C] 'hw/block/pflash_cfi01: Extract pflash_mode_read_array(=
)'
004/9:[----] [--] 'hw/block/pflash_cfi01: Start state machine as READY to=
 accept commands'
005/9:[----] [--] 'hw/block/pflash_cfi01: Add the DeviceReset() handler'
006/9:[----] [--] 'hw/block/pflash_cfi01: Simplify CFI_QUERY processing'
007/9:[----] [--] 'hw/block/pflash_cfi01: Improve command comments'
008/9:[----] [--] 'hw/block/pflash_cfi01: Replace DPRINTF by qemu_log_mas=
k(GUEST_ERROR)'
009/9:[----] [--] 'hw/block/pflash_cfi01: Hold the PRI table offset in a =
variable'

Functional differences on patch #2 are the 6 lines added for
migration of the 'cmd' field, and the updated commit description.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (9):
  hw/block/pflash_cfi01: Removed an unused timer
  hw/block/pflash_cfi01: Use the correct READ_ARRAY value
  hw/block/pflash_cfi01: Extract pflash_mode_read_array()
  hw/block/pflash_cfi01: Start state machine as READY to accept commands
  hw/block/pflash_cfi01: Add the DeviceReset() handler
  hw/block/pflash_cfi01: Simplify CFI_QUERY processing
  hw/block/pflash_cfi01: Improve command comments
  hw/block/pflash_cfi01: Replace DPRINTF by qemu_log_mask(GUEST_ERROR)
  hw/block/pflash_cfi01: Hold the PRI table offset in a variable

 hw/block/pflash_cfi01.c | 148 ++++++++++++++++++++++------------------
 hw/block/trace-events   |   1 +
 2 files changed, 81 insertions(+), 68 deletions(-)

--=20
2.20.1


