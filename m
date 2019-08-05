Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C705C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9157520B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9157520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huex3-0003Uu-Jf
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52002)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1huevt-0002Q2-EK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1huevs-0000Pb-GB
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1huevs-0000P7-Ar; Mon, 05 Aug 2019 11:29:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC96D20260;
 Mon,  5 Aug 2019 15:29:54 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A12560CCE;
 Mon,  5 Aug 2019 15:29:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:29:38 +0200
Message-Id: <20190805152947.28536-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 05 Aug 2019 15:29:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 0/9] s390x: MMU changes and
 extensions
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

This series rewrites the MMU DAT translation code completely, adds EDAT2
MMU support, and implements/indicates related facilities
(ESOP-1, ESOP-2, IEP, ...) for TCG. The QEMU CPU model is updated.

This series is based on the new 4.2 compat machines from Cornelia.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>

David Hildenbrand (9):
  s390x/mmu: Better ASC selection in s390_cpu_get_phys_page_debug()
  s390x/tcg: Rework MMU selection for instruction fetches
  s390x/mmu: DAT translation rewrite
  s390x/mmu: Add EDAT2 translation support
  s390x/mmu: Implement access-exception-fetch/store-indication facility
  s390x/mmu: Implement enhanced suppression-on-protection facility 2
  s390x/mmu: Implement Instruction-Execution-Protection Facility
  s390x/cpumodel: Prepare for changes of QEMU model
  s390x/cpumodel: Add new TCG features to QEMU cpu model

 hw/s390x/s390-virtio-ccw.c  |   2 +
 target/s390x/cpu.h          |  85 ++++++--
 target/s390x/gen-features.c |  10 +-
 target/s390x/helper.c       |  10 +-
 target/s390x/mem_helper.c   |  13 +-
 target/s390x/mmu_helper.c   | 410 ++++++++++++++++++------------------
 6 files changed, 294 insertions(+), 236 deletions(-)

--=20
2.21.0


