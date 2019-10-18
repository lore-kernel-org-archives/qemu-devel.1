Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F03CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A3220700
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A3220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLT3y-0002qD-1u
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSmw-0008Ce-GN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSmu-0001m0-9R
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:59:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSmu-0001le-3d
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4965210DCC9F;
 Fri, 18 Oct 2019 13:59:27 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8DCB60161;
 Fri, 18 Oct 2019 13:59:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/i386/pc: Extract pc_gsi_create() and pc_i8259_create()
Date: Fri, 18 Oct 2019 15:59:05 +0200
Message-Id: <20191018135910.24286-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 18 Oct 2019 13:59:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are few patches extracted from the previous too big series:
hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html

Dropped "Move kvm_i8259_init() declaration to sysemu/kvm.h" (thuth),
no logical changes:

$ git backport-diff -u pc_split_i440fx_piix-v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[----] [-C] 'hw/i386/pc: Extract pc_gsi_create()'
002/5:[----] [--] 'hw/i386/pc: Reduce gsi_handler scope'
003/5:[----] [--] 'hw/i386/pc: Move gsi_state creation code'
004/5:[----] [--] 'hw/i386/pc: Extract pc_i8259_create()'
005/5:[----] [--] 'hw/i386/pc: Remove kvm_i386.h include'

Based-on: <20191018134754.16362-1-philmd@redhat.com>
hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge [v2]
https://mid.mail-archive.com/20191018134754.16362-1-philmd@redhat.com

Philippe Mathieu-Daud=C3=A9 (5):
  hw/i386/pc: Extract pc_gsi_create()
  hw/i386/pc: Reduce gsi_handler scope
  hw/i386/pc: Move gsi_state creation code
  hw/i386/pc: Extract pc_i8259_create()
  hw/i386/pc: Remove kvm_i386.h include

 hw/i386/pc.c         | 36 +++++++++++++++++++++++++++++++++++-
 hw/i386/pc_piix.c    | 23 ++---------------------
 hw/i386/pc_q35.c     | 28 ++++------------------------
 include/hw/i386/pc.h |  3 ++-
 4 files changed, 43 insertions(+), 47 deletions(-)

--=20
2.21.0


