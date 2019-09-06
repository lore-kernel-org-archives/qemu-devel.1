Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E762EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60722070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60722070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i699s-00050M-AA
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i6983-0003Jh-HV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i6981-0002Yo-61
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i6980-0002Y5-UL; Fri, 06 Sep 2019 03:57:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1DA1C049E23;
 Fri,  6 Sep 2019 07:57:55 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BF6D1000321;
 Fri,  6 Sep 2019 07:57:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:22 +0200
Message-Id: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 06 Sep 2019 07:57:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/28] s390x/tcg: mem_helper: Fault-safe
 handling
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the successor of
    "[PATCH v1 0/4] s390x/tcg: MOVE (MVC): Fault-safe handling"

----

This series fixes a bunch of issues related to some mem helpers and makes
sure that they are fault-safe, meaning no system state is modified in cas=
e
a fault is triggered.

I can spot tons of other issues with other mem helpers that will have
to be fixed later. Also, fault-safe handling for some instructions
(especially TR) might be harder to implement (you don't know what will
actually be accessed upfront - we might need a buffer and go over
inputs twice). Focusing on the MOVE instructions for now.

----

Newer versions of glibc use memcpy() in memmove() for forward moves. The
implementation makese use of MVC. The TCG implementation of MVC is
currently not able to handle faults reliably when crossing pages. MVC
can cross with 256 bytes at most two pages.

In case we get a fault on the second page, we already moved data. When
continuing after the fault we might try to move already overwritten data,
which is very bad in case we have overlapping data on a forward move.

Triggered for now only by rpmbuild (crashes when checking the spec file)
and rpm (database corruptions). This fixes installing Fedora rawhide (31)
under TCG.

This was horrible to debug as it barely triggers and we fail at completel=
y
different places.

Cc: Stefano Brivio <sbrivio@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>

v1 -> v2:
- Include many fixes
- Fix more instructions
- Use the new probe_access() function
- Include "tests/tcg: target/s390x: Test MVO"

David Hildenbrand (28):
  s390x/tcg: Reset exception_index to -1 instead of 0
  s390x/tcg: MVCL: Zero out unused bits of address
  s390x/tcg: MVCL: Detect destructive overlaps
  s390x/tcg: MVCL: Process max 2k bytes at a time
  s390x/tcg: MVC: Increment the length once
  s390x/tcg: MVC: Use is_destructive_overlap()
  s390x/tcg: MVPG: Check for specification exceptions
  s390x/tcg: MVPG: Properly wrap the addresses
  s390x/tcg: MVCLU/MVCLE: Process max 4k bytes at a time
  s390x/tcg: MVCS/MVCP: Check for special operation exceptions
  s390x/tcg: MVCS/MVCP: Properly wrap the length
  s390x/tcg: MVST: Check for specification exceptions
  s390x/tcg: MVST: Fix storing back the addresses to registers
  s390x/tcg: Always use MMU_USER_IDX for CONFIG_USER_ONLY
  s390x/tcg: Fault-safe memset
  s390x/tcg: Fault-safe memmove
  s390x/tcg: MVCS/MVCP: Use access_memmove_idx()
  s390x/tcg: MVC: Fault-safe handling on destructive overlaps
  s390x/tcg: MVCLU: Fault-safe handling
  s390x/tcg: OC: Fault-safe handling
  s390x/tcg: XC: Fault-safe handling
  s390x/tcg: NC: Fault-safe handling
  s390x/tcg: MVCIN: Fault-safe handling
  s390x/tcg: MVN: Fault-safe handling
  s390x/tcg: MVZ: Fault-safe handling
  s390x/tcg: MVST: Fault-safe handling
  s390x/tcg: MVO: Fault-safe handling
  tests/tcg: target/s390x: Test MVO

 target/s390x/cpu.h              |   4 +
 target/s390x/helper.h           |   2 +-
 target/s390x/insn-data.def      |   2 +-
 target/s390x/mem_helper.c       | 672 ++++++++++++++++++++++----------
 target/s390x/translate.c        |  12 +-
 tests/tcg/s390x/Makefile.target |   1 +
 tests/tcg/s390x/mvo.c           |  25 ++
 7 files changed, 507 insertions(+), 211 deletions(-)
 create mode 100644 tests/tcg/s390x/mvo.c

--=20
2.21.0


