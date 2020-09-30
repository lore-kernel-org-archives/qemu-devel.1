Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96632C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A88C20738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7FP2nmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A88C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaR5-0002sG-3P
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNaIR-0002cs-6o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNaIO-0003s2-H8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:29:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601465355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aCMe5NJ/giLgA3Kgy2HLMvGZnGZzDqwEzj6ruTKVtQ4=;
 b=I7FP2nmiERuORxfDMDjiPd5v5JrMmTjjK9xpflA9rVD48W1SebhT58cPlsHHeBpR4zUSjo
 N9is04OwunmLx/8y1238iLKgomH5JehF90BTgF7X2uDwpiDsVs4Vkj+jRgl8yHWJahG05x
 ZiRZg7r36KB08r+LXTnZ/KN9E9hdpRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-kx-axKhRNhGylz7V4At52w-1; Wed, 30 Sep 2020 07:29:11 -0400
X-MC-Unique: kx-axKhRNhGylz7V4At52w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E126B1084C92
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 11:29:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49CE7B40D;
 Wed, 30 Sep 2020 11:29:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2A36343BFAC; Wed, 30 Sep 2020 13:29:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] build spice chardevs as module
Date: Wed, 30 Sep 2020 13:28:58 +0200
Message-Id: <20200930112904.24397-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:=0D
 - fix spice-app=0D
 - init objects before spice=0D
 - meson cleanup=0D
v4:=0D
 - rebase to latestg master, adapt to qom changes.=0D
 - add patches to fix modular builds.=0D
 - pick up review tags.=0D
=0D
Gerd Hoffmann (6):=0D
  ui/spice-app: don't use qemu_chr_open_spice_port directly=0D
  chardev/spice: make qemu_chr_open_spice_port static=0D
  chardev/spice: simplify chardev setup=0D
  meson: add spice_headers dependency.=0D
  meson: add spice dependency to core spice source files.=0D
  chardev/spice: build spice chardevs as module=0D
=0D
 include/chardev/spice.h |  4 ----=0D
 include/ui/qemu-spice.h |  1 -=0D
 chardev/spice.c         | 37 ++++++++++---------------------------=0D
 softmmu/vl.c            |  9 +++++----=0D
 ui/spice-app.c          | 34 ++++++++++++++++++++++------------=0D
 ui/spice-core.c         |  2 --=0D
 util/module.c           |  2 ++=0D
 audio/meson.build       |  2 +-=0D
 chardev/meson.build     |  7 ++++++-=0D
 meson.build             |  2 ++=0D
 monitor/meson.build     |  2 +-=0D
 ui/meson.build          |  2 +-=0D
 12 files changed, 50 insertions(+), 54 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D


