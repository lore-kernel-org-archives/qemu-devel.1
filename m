Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71708C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E4122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVeEOUVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E4122522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpqY-00063p-AL
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1itppg-0005Jd-LN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1itppe-0001lZ-Tq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:28:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mrezanin@redhat.com>) id 1itppe-0001l5-H4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579598901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6FvIRCLElz2zgvvs1XONhpKsrBEsz+n4PtxM1+zlEds=;
 b=TVeEOUVhuToxRlGGTU7IdVTNiXumhjhhSBVkdZ6RjjBWQJkV4c+EHWl5BPdAb+nT5hZj46
 ZAuLRrLZBxqUCtnF2K8BVUkw7LngISTShccEzlFSicXyW1rc8TFwK7Z9/Zs1FL2FUDKRH9
 MQ5TvKd2fwgNYWfFwLaguOMwpNyqdYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-0jCrhx7QMd6yLIlN-gLWCQ-1; Tue, 21 Jan 2020 04:28:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C66E10054E3;
 Tue, 21 Jan 2020 09:28:17 +0000 (UTC)
Received: from workimage.localdomain (ovpn-204-25.brq.redhat.com
 [10.40.204.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2FC5DA75;
 Tue, 21 Jan 2020 09:28:15 +0000 (UTC)
From: mrezanin@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Prevent uninitialized warnings
Date: Tue, 21 Jan 2020 10:28:12 +0100
Message-Id: <cover.1579598240.git.mrezanin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0jCrhx7QMd6yLIlN-gLWCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miroslav Rezanina <mrezanin@redhat.com>

Using -Wmaybe-uninitialized when optimalization is enabled can cause=20
several warnings during build. This will break build in case -Werror
is used.

This series fixes two cases of this warnings that can happen during
build of QEMU.

Miroslav Rezanina (2):
  test-logging: Fix -Werror=3Dmaybe-uninitialized warning
  aspeed/i2c: Prevent uninitialized warning

 hw/i2c/aspeed_i2c.c  | 2 +-
 tests/test-logging.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--=20
1.8.3.1


