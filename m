Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD346C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A273E217F9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273E217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhIS-0002ui-MQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hnhI1-0001y1-14
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hnhI0-0001Vb-07
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1hnhHz-0001VR-Qy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1684D8666A;
 Wed, 17 Jul 2019 10:35:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E111E19C68;
 Wed, 17 Jul 2019 10:35:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 12:35:47 +0200
Message-Id: <20190717103550.24657-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 17 Jul 2019 10:35:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v2 0/3] virtio-balloon: fixes for
 PartialBalloonedPage
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

Some v4.1 (also v4.0 stable) fixes for virtio-balloon that only trigger
when the pagesize is > BALLOON_PAGE_SIZE (4k).

v1 -> v2:
- Added "virtio-balloon: fix memory leak on unrealize()"
- Added "virtio-balloon: reset pbp on device resets"

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>

David Hildenbrand (3):
  virtio-balloon: fix QEMU crashes on pagesize > BALLOON_PAGE_SIZE
  virtio-balloon: fix memory leak on unrealize()
  virtio-balloon: reset pbp on device resets

 hw/virtio/virtio-balloon.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--=20
2.21.0


