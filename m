Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720AEC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47760218F0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47760218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqc3Q-0001P3-VL
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hqc3F-0000z4-Lq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hqc3E-00034s-Kx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hqc3E-00034Y-F6; Thu, 25 Jul 2019 07:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 705B73084248;
 Thu, 25 Jul 2019 11:36:47 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CAAB5B6A5;
 Thu, 25 Jul 2019 11:36:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 13:36:31 +0200
Message-Id: <20190725113638.4702-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 25 Jul 2019 11:36:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 0/7] virtio-balloon: fixes
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we discovered yet another issue with current PBP code, we decided
to use a temporary PBP only, limited to one series of inflation requests.

Patch #1 is a fix for a wrong sign extension (MST brought this up but
wasn't sure if it is broken - I think it is indeed broken). Patch #2 fixe=
d
QEMU segfaults. Patch #3 and #4 are cleanups that make follow-up fixes
easier. Patch #5 avoids using RAMBlock addresses as tokens and patch #6
fixes all kinds of issues related to using a global PBP. Patch #7 gets
rid of a temporary workaround from patch #5.

We want to have patches 1-6 in 4.1 and backport them to 4.0. Patch #1
needs backports to basically all QEMU releases with virtio-balloon.

Did a quick sanity test, hopefully no other BUG sneeked in. Will do some
more testing.

v3 -> v4:
- Add "virtio-balloon: No need to track subpages for the PBP anymore",
  which doesn't need a stable backport

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-stable@nongnu.org

David Hildenbrand (7):
  virtio-balloon: Fix wrong sign extension of PFNs
  virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZE
  virtio-balloon: Simplify deflate with pbp
  virtio-balloon: Better names for offset variables in inflate/deflate
    code
  virtio-balloon: Rework pbp tracking data
  virtio-balloon: Use temporary PBP only
  virtio-balloon: No need to track subpages for the PBP anymore

 hw/virtio/virtio-balloon.c         | 120 ++++++++++++++---------------
 include/hw/virtio/virtio-balloon.h |   3 -
 2 files changed, 60 insertions(+), 63 deletions(-)

--=20
2.21.0


