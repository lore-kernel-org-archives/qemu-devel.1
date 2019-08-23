Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37BC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F6D233FD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F6D233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16VX-0007av-FE
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i16U3-0006Gf-4E
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i16U1-0007tO-Mm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i16U1-0007s8-Hu; Fri, 23 Aug 2019 06:07:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61BEF106BB20;
 Fri, 23 Aug 2019 10:07:47 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61E695D6B2;
 Fri, 23 Aug 2019 10:07:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 12:07:32 +0200
Message-Id: <20190823100741.9621-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 23 Aug 2019 10:07:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/9] tcg: probe_write() refactorings and
 watchpoints
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix and refactore some things around probe_write() in s390x code. Introdu=
ce
probe_write() for CONFIG_USER_ONLY. Finally, prepare the watchpoint logic
for being called from probe_write() and add the call.

This is the first step of some changes necessary to handle fault-safe
access accross multiple pages on s390x. The next step is making
probe_write() return an address, similar to tlb_vaddr_to_host(), and
introduing probe_read().

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Cc: Cornelia Huck <cohuck@redhat.com>

David Hildenbrand (9):
  s390x/tcg: Use guest_addr_valid() instead of h2g_valid() in
    probe_write_access()
  s390x/tcg: Fix length calculation in probe_write_access()
  tcg: Factor out CONFIG_USER_ONLY probe_write() from s390x code
  tcg: Enforce single page access in probe_write() for !CONFIG_USER_ONLY
  mips/tcg: Call probe_write() for CONFIG_USER_ONLY as well
  hppa/tcg: Call probe_write() also for CONFIG_USER_ONLY
  s390x/tcg: Pass a size to probe_write() in do_csst()
  exec.c: Factor out core logic of check_watchpoint()
  tcg: Check for watchpoints in probe_write()

 accel/tcg/cputlb.c        | 18 ++++++++++++++++++
 accel/tcg/user-exec.c     | 16 ++++++++++++++++
 exec.c                    | 23 +++++++++++++++++------
 include/exec/exec-all.h   |  4 ++--
 include/hw/core/cpu.h     |  2 ++
 target/hppa/op_helper.c   |  2 --
 target/mips/op_helper.c   |  8 +++-----
 target/s390x/mem_helper.c | 13 ++-----------
 8 files changed, 60 insertions(+), 26 deletions(-)

--=20
2.21.0


