Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF9FC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988F2207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDOlzHdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988F2207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3fV-0008Fn-9j
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ir3e7-0006Wp-9Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ir3e5-00021A-Tp
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:36:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ir3e5-00020a-Q5
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578937017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vd+tLD4cNWYyhaWzCvxlFruo6Y1I+QZifVnflRkh57k=;
 b=CDOlzHdocQRAG6v5v5XIw8h7E5nSGKZBQPfpPlCNdGaifq10+Hz050kGY9YPs8jjNLj81y
 Gt1UYO79FmbDHPGQhF3TSVpQnsXH+b/I5kKhHF9nGCVkucUuihR23JRCZTV67ZXRWJ8nsx
 U4NMGv8AAes0fRGpsTMr94oWHd9rtGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-x7Tu-G_qNburn0CQ6dHRQw-1; Mon, 13 Jan 2020 12:36:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB65801E77
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 17:36:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 656065C1B0;
 Mon, 13 Jan 2020 17:36:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 0/3] exclude hyperv synic sections from vhost
Date: Mon, 13 Jan 2020 17:36:44 +0000
Message-Id: <20200113173647.84842-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: x7Tu-G_qNburn0CQ6dHRQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hyperv's synic (that we emulate) is a feature that allows the guest
to place some magic (4k) pages of RAM anywhere it likes in GPA.
This confuses vhost's RAM section merging when these pages
land over the top of hugepages.

Since they're not normal RAM, and they shouldn't have vhost DMAing
into them, exclude them from the vhost set.

This v2 is a complete rework after the v1 review; I've now got
a flag on MemoryRegion's that we set.

bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041


Dr. David Alan Gilbert (3):
  vhost: Add names to section rounded warning
  memory: Allow a MemoryRegion to be marked no_vhost
  hyperv/synic: Mark regions as no vhost

 hw/hyperv/hyperv.c    |  8 ++++++++
 hw/virtio/vhost.c     | 10 ++++++----
 include/exec/memory.h | 21 +++++++++++++++++++++
 memory.c              | 15 +++++++++++++++
 4 files changed, 50 insertions(+), 4 deletions(-)

--=20
2.24.1


