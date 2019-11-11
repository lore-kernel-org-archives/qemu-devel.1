Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FEC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AC220856
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6NN8Asp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AC220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU78P-0003Hv-Cn
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1iU776-0002B7-On
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1iU775-0004ZW-0W
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:40:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1iU774-0004Y8-LC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573468801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BP+SGIz8u85ASVCXHPrWAbzi7lv+3IJQAeG64WowNj8=;
 b=Y6NN8AspUKdqsE2ApUrk1yYdRQNgNoe8QDbZHNFPGDuvj1ozT+kMH2jyKA/hkGI1ARuABh
 oFaRXCrKdywXLTRrmOSQ3mBpHQznJlndNwQQxDnrex7EthbnCPpOojlVDZ0O9YJxNeoffl
 ZLOUwJ/mF8s9M4bqP5z3ChcDqiMVrM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-358ut86VOt2x3uBKxOLCow-1; Mon, 11 Nov 2019 05:37:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F5C1005509
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 10:37:58 +0000 (UTC)
Received: from moe.redhat.com (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4077E5C883;
 Mon, 11 Nov 2019 10:37:55 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] A pair of memory access problems
Date: Mon, 11 Nov 2019 11:37:40 +0100
Message-Id: <cover.1573468531.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 358ut86VOt2x3uBKxOLCow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: alex.williamson@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first patch fixes a crasher, the second fixes a memleak.

Michal Privoznik (2):
  hw/vfio/pci: Fix double free of migration_blocker
  vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()

 hw/vfio/pci.c       | 2 ++
 util/vfio-helpers.c | 1 +
 2 files changed, 3 insertions(+)

--=20
2.23.0


