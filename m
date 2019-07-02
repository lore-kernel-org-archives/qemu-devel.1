Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B9C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B4D21721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4D21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiK2g-0002a3-MG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiK0c-0001S2-2n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiK0a-0008TX-Tw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hiK0Y-0008QE-7q; Tue, 02 Jul 2019 10:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E4D481DE0;
 Tue,  2 Jul 2019 14:43:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-140.brq.redhat.com [10.40.204.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AEBA67142;
 Tue,  2 Jul 2019 14:43:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 16:43:34 +0200
Message-Id: <20190702144335.10717-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 02 Jul 2019 14:43:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 0/1] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 cover from Samuel [1]:

  This patchset allows for building and running ARM targets with TCG
  disabled. It splits the target/arm/helper.c file into logical TCG and
  non TCG dependent files so that one can build and run QEMU binaries wit=
h
  or without TCG enabled.

  The rationale behind this work comes from the NEMU project where we're
  trying to only support x86 and ARM 64-bit architectures, without
  including the TCG code base. We can only do so if we can build and run
  ARM binaries with TCG disabled.

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03271.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00162.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00312.html
- patches 1-12, 14-17, 19-21 accepted, rebased on target-arm.next
- addressed Peter's comment (described in each patch).
v5:
- patches 1-2 accepted, rebased on target-arm.next
- addressed Peter's comment (broken v4 rebase, patch not building...)

Based-on: target-arm.next
$ git backport-diff -u v3 -r target-arm.next..v5
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/1:[0025] [FC] 'target/arm/helper: Move M profile routines to m_helper=
.c'

Thanks a lot to Alex and Peter for their review time, and Samuel for
the original effort.

This single patch is not a 'bugfix', simply code movement.
If it doesn't fit for 4.1-rc0, I'm still glad Peter merged all the
patches from the previous series :_

Regards,

Phil.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html

Philippe Mathieu-Daud=C3=A9 (1):
  target/arm/helper: Move M profile routines to m_helper.c

 target/arm/Makefile.objs |    1 +
 target/arm/helper.c      | 2638 +------------------------------------
 target/arm/m_helper.c    | 2676 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 2681 insertions(+), 2634 deletions(-)
 create mode 100644 target/arm/m_helper.c

--=20
2.20.1


