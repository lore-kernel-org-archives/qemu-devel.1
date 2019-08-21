Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C9C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57E822D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57E822D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MrJ-0008Gn-Cy
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i0MpX-00063y-LR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i0MpW-00019N-K9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i0MpW-000190-Eb; Wed, 21 Aug 2019 05:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB8F61801585;
 Wed, 21 Aug 2019 09:22:57 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98A4C5C231;
 Wed, 21 Aug 2019 09:22:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 11:22:48 +0200
Message-Id: <20190821092252.26541-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 21 Aug 2019 09:22:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/4] s390x/tcg: MOVE (MVC): Fault-safe
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

I can see similar issues with other MEM helpers, but there is more to cle=
an
up and fix, so fix the obvious first.

This was horrible to debug as it barely triggers and we fail at completel=
y
different places. :)

Cc: Stefano Brivio <sbrivio@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>

David Hildenbrand (4):
  s390x/tcg: Use guest_addr_valid() instead of h2g_valid() in
    probe_write_access()
  s390x/tcg: Introduce probe_read_access()
  s390x/tcg: MOVE (MVC): Increment the length once
  s390x/tcg: MOVE (MVC): Fault-safe handling

 target/s390x/internal.h   |  2 ++
 target/s390x/mem_helper.c | 72 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 9 deletions(-)

--=20
2.21.0


