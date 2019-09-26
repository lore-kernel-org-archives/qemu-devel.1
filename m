Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE99FC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8502120872
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8502120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQre-0005x3-Oy
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDQpE-0004GG-Jp
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDQpA-0007fK-VZ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDQpA-0007eG-Q9; Thu, 26 Sep 2019 06:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA5BE316D76A;
 Thu, 26 Sep 2019 10:16:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1C2A60920;
 Thu, 26 Sep 2019 10:16:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] s390x/mmu: Implement more facilities
Date: Thu, 26 Sep 2019 12:16:22 +0200
Message-Id: <20190926101627.23376-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 26 Sep 2019 10:16:33 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the follow up of:
    [PATCH-for-4.2 v1 0/9] s390x: MMU changes and extensions
Without the general MMU rework. It's based on:
    [PATCH v2 0/7] s390x/mmu: DAT translation rewrite

This series adds adds EDAT2 MMU support, and implements/indicates related
facilities (ESOP-1, ESOP-2, IEP, ...) for TCG. The QEMU CPU model is
updated.

IEP under QEMU TCG seems to work just fine, when eabling it via the "max"
CPU model - via kvm unit tests:
    t460s: ~/git/kvm-unit-tests master $ ./s390x-run s390x/iep.elf -cpu m=
ax
    [...]
    PASS: iep: iep protection: Program interrupt: expected(4) =3D=3D rece=
ived(4)
    SUMMARY: 1 tests

    EXIT: STATUS=3D1

Changes since "[PATCH-for-4.2 v1 0/9] s390x: MMU changes and extensions":
- "s390x/mmu: Add EDAT2 translation support"
-- Fix vaddr offset within 2GB page
- "s390x/mmu: Implement ESOP-2 and ..."
-- Squashed two patches as requested.
-- Also set ilen to "2" in case of MMU_INST_FETCH on mmu_translate_real
- "s390x/mmu: Implement Instruction-Execution-Protection Facility"
-- Make sure s390_cpu_get_phys_page_debug() doesn't choke on IEP
- "s390x/cpumodel: Add new TCG features to QEMU cpu model"
-- Add comment "features introduced after the z13"

Cc: Ilya Leoshkevich <iii@linux.ibm.com>

David Hildenbrand (5):
  s390x/mmu: Add EDAT2 translation support
  s390x/mmu: Implement ESOP-2 and
    access-exception-fetch/store-indication facility
  s390x/mmu: Implement Instruction-Execution-Protection Facility
  s390x/cpumodel: Prepare for changes of QEMU model
  s390x/cpumodel: Add new TCG features to QEMU cpu model

 hw/s390x/s390-virtio-ccw.c  |  2 ++
 target/s390x/cpu.h          |  1 +
 target/s390x/gen-features.c | 11 +++++++++-
 target/s390x/helper.c       |  6 +++++-
 target/s390x/mmu_helper.c   | 42 +++++++++++++++++++++++++++++++++++--
 5 files changed, 58 insertions(+), 4 deletions(-)

--=20
2.21.0


