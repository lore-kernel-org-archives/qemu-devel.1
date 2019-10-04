Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C64C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2632070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2632070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLqX-0000ot-Dc
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iGLB0-0006ev-Tb
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iGLAy-0004mf-Kz
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iGLAy-0004m3-Ft; Fri, 04 Oct 2019 06:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BCAF89AC7;
 Fri,  4 Oct 2019 10:51:07 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40E705D6B2;
 Fri,  4 Oct 2019 10:51:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] s390x/mmu: DAT translation rewrite
Date: Fri,  4 Oct 2019 12:50:55 +0200
Message-Id: <20191004105102.15821-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 04 Oct 2019 10:51:07 +0000 (UTC)
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
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a split-up of:
    [PATCH-for-4.2 v1 3/9] s390x/mmu: DAT translation rewrite
Rebased on latest upstream changes.

v3 -> v4:
- "s390x/mmu: Inject PGM_ADDRESSING on bogus table addresses"
-- s/goguous/bogus/
- "s390x/mmu: DAT table definition overhaul"
-- Fix SEGMENT_ENTRY_SFAA
-- Drop three unnecessary defines
- "s390x/mmu: Convert to non-recursive page table walk"
-- Reorder "REGION_ENTRY_P" checks
-- Drop default cases that cannot be reached

v2 -> v3:
- "s390x/mmu: Inject PGM_ADDRESSING on boguous table addresses"
-- Keep using cs->as
-- Make read_table_entry() return true/false
- "s390x/mmu: DAT table definition overhaul"
-- Added a comment where to find details about s390x and used definitions

v1 -> v2:
- Cleanup old code first, before switching to non-recursive handling
- Fix EDAT1 translation: I was missing the vaddr offset within the 1MB
  page.

David Hildenbrand (7):
  s390x/mmu: Drop debug logging from MMU code
  s390x/mmu: Move DAT protection handling out of mmu_translate_asce()
  s390x/mmu: Inject DAT exceptions from a single place
  s390x/mmu: Inject PGM_ADDRESSING on bogus table addresses
  s390x/mmu: Use TARGET_PAGE_MASK in mmu_translate_pte()
  s390x/mmu: DAT table definition overhaul
  s390x/mmu: Convert to non-recursive page table walk

 target/s390x/cpu.h        |  78 +++++---
 target/s390x/mem_helper.c |  12 +-
 target/s390x/mmu_helper.c | 365 ++++++++++++++++----------------------
 3 files changed, 220 insertions(+), 235 deletions(-)

--=20
2.21.0


