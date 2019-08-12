Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF5C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC192208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC192208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx8VH-0005lX-VK
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 07:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hx8UP-0004BT-VZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 07:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hx8UO-0002T2-VU
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 07:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hx8UO-0002SZ-Qq; Mon, 12 Aug 2019 07:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C44CB30613C5;
 Mon, 12 Aug 2019 11:27:47 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-110.ams2.redhat.com [10.36.117.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083A5600C4;
 Mon, 12 Aug 2019 11:27:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 13:27:31 +0200
Message-Id: <20190812112737.6652-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 12 Aug 2019 11:27:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 0/6] s390x/mmu: Storage key
 reference and change bit handling
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
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first two patches are modified patches from:
    [PATCH-for-4.2 v1 0/9] s390x: MMU changes and extensions

This series primarily fixes minor things in the storage key handling code
in the MMU and implements fairly reliable reference and change bit handli=
ng
for TCG. To track the reference and change bit, we have to invalidate
TLB entries whenever the storage key is changed by the guest and make sur=
e
not TLB entry is writable in case the storage key does not indicate a
change already.

With this series, the kvm-unit-test "skey" now passes. \o/

David Hildenbrand (6):
  s390x/mmu: ASC selection in s390_cpu_get_phys_page_debug()
  s390x/tcg: Rework MMU selection for instruction fetches
  s390x/tcg: Flush the TLB of all CPUs on SSKE and RRBE
  s390x/mmu: Trace the right value if setting/getting the storage key
    fails
  s390x/mmu: Better storage key reference and change bit handling
  s390x/mmu: Factor out storage key handling

 target/s390x/cpu.h        |   7 ++
 target/s390x/helper.c     |   5 ++
 target/s390x/mem_helper.c |   4 ++
 target/s390x/mmu_helper.c | 131 ++++++++++++++++++++++++--------------
 4 files changed, 98 insertions(+), 49 deletions(-)

--=20
2.21.0


