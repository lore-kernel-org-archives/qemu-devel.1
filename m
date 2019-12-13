Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5054C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F332073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC79HyeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F332073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiYX-0006P9-Ks
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifiXV-0005Ux-SI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifiXS-0001OP-DP
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifiXS-0001MX-2C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TcN1f1qIARYSl/MZEqR8n1uVEpiN301tXW3/hUKFLz4=;
 b=IC79HyeZ8bApKI5y+axWoFO0QBjqG9P6rWkilBaiHQlSHelX7Ipm9smcyjXv90PGwOdjEZ
 Y3z8fKHFy3Euqt9irk27eN2bdCrfcvvevpow5hYzWmI7LKvhF0l7LJIJADg5ry/Eu5zzw6
 NOfveh2Twn6zeqY38BRgAdKwICw48s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-6KzFvIc2PnmABQYL4M1TPw-1; Fri, 13 Dec 2019 05:51:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D62DB800EB4;
 Fri, 13 Dec 2019 10:51:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A704E10013A1;
 Fri, 13 Dec 2019 10:51:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/i386/pc: Extract the port92 device
Date: Fri, 13 Dec 2019 11:50:56 +0100
Message-Id: <20191213105100.8173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6KzFvIc2PnmABQYL4M1TPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In this series we
- remove the old DPRINTF() macro in hw/i386/pc.c
- extract the TYPE_PORT92 device from the same file,
  reducing it by 5%.

Philippe Mathieu-Daud=C3=A9 (4):
  hw/i386/pc: Convert DPRINTF() to trace events
  hw/i386/pc: Use TYPE_PORT92 instead of hardcoded string
  hw/i386/pc: Inline port92_init()
  hw/i386/pc: Extract the port92 device

 include/hw/i386/pc.h  |   3 +
 hw/i386/pc.c          | 138 ++----------------------------------------
 hw/i386/port92.c      | 126 ++++++++++++++++++++++++++++++++++++++
 hw/i386/Makefile.objs |   1 +
 hw/i386/trace-events  |   8 +++
 5 files changed, 144 insertions(+), 132 deletions(-)
 create mode 100644 hw/i386/port92.c

--=20
2.21.0


