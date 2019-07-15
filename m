Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E6C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91452080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91452080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzrm-0006eP-V2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 08:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmzrc-0006Bv-36
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmzrb-0001k2-2Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hmzrY-0001j0-I8; Mon, 15 Jul 2019 08:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96C9630833A5;
 Mon, 15 Jul 2019 12:13:47 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FEEF5C266;
 Mon, 15 Jul 2019 12:13:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>
Date: Mon, 15 Jul 2019 14:13:33 +0200
Message-Id: <20190715121338.20600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 15 Jul 2019 12:13:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 0/5] hw/block/pflash_cfi01: Add
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Last attempt before sending pull request for rc1.

The pflash device lacks a reset() function.
When a machine is resetted, the flash might be in an
inconsistent state, leading to unexpected behavior:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
Resolve this issue by adding a DeviceReset() handler.

Fix also two minor issues, and clean a bit the codebase.

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00962.=
html
- addressed Laszlo review comments

Since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00395.=
html
- consider migration (Laszlo, Peter)

Since v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01668.=
html
- more reliable migration (Dave)
- dropped patches 6-9 not required for next release

Since v4: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02785.=
html
- document why using READ_ARRAY value 0x00 for migration is safe

$ git backport-diff -u v4
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[----] [--] 'hw/block/pflash_cfi01: Removed an unused timer'
002/5:[----] [--] 'hw/block/pflash_cfi01: Use the correct READ_ARRAY valu=
e'
003/5:[----] [--] 'hw/block/pflash_cfi01: Extract pflash_mode_read_array(=
)'
004/5:[----] [--] 'hw/block/pflash_cfi01: Start state machine as READY to=
 accept commands'
005/5:[----] [--] 'hw/block/pflash_cfi01: Add the DeviceReset() handler'

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (5):
  hw/block/pflash_cfi01: Removed an unused timer
  hw/block/pflash_cfi01: Use the correct READ_ARRAY value
  hw/block/pflash_cfi01: Extract pflash_mode_read_array()
  hw/block/pflash_cfi01: Start state machine as READY to accept commands
  hw/block/pflash_cfi01: Add the DeviceReset() handler

 hw/block/pflash_cfi01.c | 109 +++++++++++++++++++++++++++-------------
 hw/block/trace-events   |   1 +
 2 files changed, 75 insertions(+), 35 deletions(-)

--=20
2.20.1


