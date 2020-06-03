Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5A22067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qu8buPta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5A22067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgPmG-00026T-GX
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 05:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jgPla-0000jp-F7
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:32:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jgPlZ-0007zd-Fc
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591176775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FIulsg1S5QMQBnVWsvODhTiJ36wqdKVZ0oa+wc2og+g=;
 b=Qu8buPta+KI1AuIDBrH/ydqVQ5Qjf+xuJ+XdleJgWIe6pNd7MBnjuMo1SrR+a2BVbVmJ0T
 Sp/S5GJMEyNGhrAoyWkmTZcZ0Va4B0WlWYrtIHIAi/XRbaZE5rS2MECzB8C3U1ki7Q89w8
 FPSSvXoY6KLVE5sctdw2h+iSG/gbIiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-HmF9yeWhPCK_Y5pThZFtsQ-1; Wed, 03 Jun 2020 05:32:52 -0400
X-MC-Unique: HmF9yeWhPCK_Y5pThZFtsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BB23A0BE0;
 Wed,  3 Jun 2020 09:32:51 +0000 (UTC)
Received: from dritchie.redhat.com (ovpn-112-109.rdu2.redhat.com
 [10.10.112.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B98C45F32;
 Wed,  3 Jun 2020 09:32:41 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] virtio-blk: Avoid processing requests on the main context
 on restart
Date: Wed,  3 Jun 2020 11:32:38 +0200
Message-Id: <20200603093240.40489-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On restart, we were scheduling a BH to process queued requests, which=0D
would run before starting up the data plane, leading to those requests=0D
being assigned and started on coroutines on the main context.=0D
=0D
This could cause requests to be wrongly processed in parallel from=0D
different threads (the main thread and the iothread managing the data=0D
plane), potentially leading to multiple issues.=0D
=0D
Fixes https://bugzilla.redhat.com/show_bug.cgi?id=3D1812765=0D
=0D
See "virtio-blk: Disable request queuing while switching contexts" for=0D
previous discussion:=0D
=0D
 - https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00304.html=0D
=0D
Sergio Lopez (2):=0D
  virtio-blk: Refactor the code that processes queued requests=0D
  virtio-blk: On restart, process queued requests in the proper context=0D
=0D
 include/hw/virtio/virtio-blk.h  |  1 +=0D
 hw/block/dataplane/virtio-blk.c |  8 ++++++++=0D
 hw/block/virtio-blk.c           | 30 +++++++++++++++++++++---------=0D
 3 files changed, 30 insertions(+), 9 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


