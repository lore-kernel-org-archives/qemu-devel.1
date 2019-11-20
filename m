Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B75DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81660217D6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQZuhSek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81660217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRF0-0004ps-BG
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXR8O-0006MP-Gi
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXR8N-0007KO-HO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:39:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXR8N-0007K8-Dk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574260746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HNBT50wUIX1sytE6fF5yfmbAxZB8D7eDcI7FmelMh8A=;
 b=YQZuhSek3L5JybDAL1hdZw8lTUbJUR+aglqFYyjlWQZlnMoTqvwtEuMXCk3ouBMibco/xd
 Hda+fmpbIl8ER/rNMoEJ7XeaCsy7lNCmXv3UHTF1NT0eG2RokuLGyl03zOBVBz9BDilsYj
 7SOnQcRBVywDRgtC0Pj3B5Qv0xB4UDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-P8s8LgqQOLCLZsDKBFfWyg-1; Wed, 20 Nov 2019 09:39:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D2112EDD;
 Wed, 20 Nov 2019 14:39:04 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D1BE51F1B;
 Wed, 20 Nov 2019 14:39:01 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] net/virtio: fixes for failover
Date: Wed, 20 Nov 2019 15:38:55 +0100
Message-Id: <20191120143859.24584-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: P8s8LgqQOLCLZsDKBFfWyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes bugs found by coverity and one reported by David
Gilbert.

Jens Freimann (4):
  net/virtio: fix dev_unplug_pending
  net/virtio: return early when failover primary alread added
  net/virtio: avoid passing NULL to qdev_set_parent_bus
  net/virtio: return error when device_opts arg is NULL

 hw/net/virtio-net.c | 58 +++++++++++++++++++++++++++++----------------
 migration/savevm.c  |  3 ++-
 2 files changed, 40 insertions(+), 21 deletions(-)

--=20
2.21.0


