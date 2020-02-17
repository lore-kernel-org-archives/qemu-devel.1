Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C94C3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E1D208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E1D208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3WNq-0006u0-W1
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 21:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3WND-0006MR-1W
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 21:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3WNB-0001Sk-AE
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 21:43:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3WNB-0001Qr-4L; Sun, 16 Feb 2020 21:43:01 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B512C747DFE;
 Mon, 17 Feb 2020 03:42:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 83899746381; Mon, 17 Feb 2020 03:42:58 +0100 (CET)
Message-Id: <cover.1581904461.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 17 Feb 2020 02:54:21 +0100
Subject: [RFC PATCH 0/2] Enable hardfloat for PPC
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This is an RFC series to start exploring the possibility of enabling
hardfloat for PPC target that haven't progressed in the last two years.
Hopefully we can work out something now. Previously I've explored this
here:

https://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html

where some ad-hoc benchmarks using lame mp3 encoder is also explained
that has two versions: one using VMX and another only using FP. Both
are mostly floating point bounded. I've run this test on mac99 under
MorphOS before and after my patches, also verifying that md5sum of
resulting mp3 matches (this is no proof for correctness but maybe
shows it did not break too much at least those ops used by this
program).

I've got these measurements on an Intel i7-9700K CPU @ 3.60GHz (did
not bother to take multiple samples so these are just approximate):

1) before patch series using softfloat:
lame: 4:01, lame_vmx: 3:14

2) only enabling hardfloat in fpu/softfloat.c without other changes:
lame: 4:06, lame_vmx: 2:06
(this shows why hardfloat was disabled but VMX can benefit from this)

3) with this series, hardfloat=true:
lame: 3:15, lame_vmx: 1:59
(so the patch does something even if there should be more places to
preserve inexact flag to fully use hardfloat)

4) with this series but forcing softfloat with hardfloat=false:
lame: 4:11, lame_vmx: 2:08
(unfortunately it's slower than before, likely due to adding if () to
helper_reset_fpstatus() that should be avoided to at least get back
previous hardfloat enabled case that's still slower than softfloat so
this series only makes sense if the default can be hardfloat=true at
the moment but even that would need more testing)

I hope others can contribute to this by doing more testing to find out
what else this would break or give some ideas how this could be
improved.

Regards,
BALATON Zoltan

BALATON Zoltan (2):
  target/ppc/cpu: Add hardfloat property
  target/ppc: Enable hardfloat for PPC

 fpu/softfloat.c                 | 14 +++++++-------
 target/ppc/cpu.h                |  2 ++
 target/ppc/fpu_helper.c         |  7 ++++++-
 target/ppc/translate_init.inc.c |  2 ++
 4 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.21.1


