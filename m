Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B7C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4093F2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4093F2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVZC-00057m-4q
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hoVZ0-0004ij-Js
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hoVYx-0004Wz-5a
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1hoVYo-0003Yz-G8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:16:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0EF530C5859;
 Fri, 19 Jul 2019 16:01:29 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4281001B02;
 Fri, 19 Jul 2019 16:01:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 18:01:17 +0200
Message-Id: <20190719160120.26581-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 19 Jul 2019 16:01:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/3] virtio-balloon: PartialBalloonedPage
 rework
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael pointed out that stroing and using the address of a RAMBlock
might not be safe. So let's rework the pbp handling, cleaning up the
code.

Did a sanity test with hugepage backing on x86.64.

We might want to have this in 4.1. I'll let Michael decide.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>

David Hildenbrand (3):
  virtio-balloon: simplify deflate with pbp
  virtio-balloon: Better names for offset variables in inflate/deflate
    code
  virtio-balloon: Rework pbp tracking data

 hw/virtio/virtio-balloon.c         | 90 ++++++++++++++----------------
 include/hw/virtio/virtio-balloon.h | 15 ++++-
 2 files changed, 53 insertions(+), 52 deletions(-)

--=20
2.21.0


