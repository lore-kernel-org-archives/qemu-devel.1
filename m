Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EA7C2D0D1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C065206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ek+mjTLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C065206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihezD-0001Pt-OD
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihexM-0007wK-Rb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihexK-00035C-NJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:25:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihexK-0002yv-6a
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576697157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d8d3NOr/AJwNt7vzL94QAStUbvgp3xH1pd/+9y3hkZ0=;
 b=ek+mjTLHTOQcNSHk/dHQvj4eR83KV93+73b8c+gTvPprYH3OZw3El78yWY8okKL286EHuD
 yIFGAaSJ846GkBREMeXUTFUowvd8TuugzVJ3nxepl/dtuPmTugHQpZ10qyK0up3Cf2OB+s
 F3XNI4+Jetq50fEalq6qALa6bGotRzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Q_lPehRgNsK5fS0IdCXJ9Q-1; Wed, 18 Dec 2019 14:25:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B8A6107ACC4;
 Wed, 18 Dec 2019 19:25:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1697D60C81;
 Wed, 18 Dec 2019 19:25:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Fix more GCC9 -O3 warnings
Date: Wed, 18 Dec 2019 20:25:20 +0100
Message-Id: <20191218192526.13845-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Q_lPehRgNsK5fS0IdCXJ9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Olivier Danet <odanet@caramail.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, Markus Armbruster <armbru@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix some trivial warnings when building with -O3.

v2:
- addressed Thomas and Aleksandar comments
- dropped 'hw/scsi/megasas: Silent GCC9 duplicated-cond warning'
- dropped 'qemu-io-cmds: Silent GCC9 format-overflow warning'

Philippe Mathieu-Daud=C3=A9 (6):
  audio/audio: Add missing fall through comment
  hw/display/tcx: Add missing fall through comments
  hw/timer/aspeed_timer: Add a fall through comment
  hw/net/imx_fec: Rewrite fall through comments
  hw/net/imx_fec: Remove unuseful FALLTHROUGH comments
  hw/pci-host/designware: Remove unuseful FALLTHROUGH comment

 audio/audio.c            | 1 +
 hw/display/tcx.c         | 2 ++
 hw/net/imx_fec.c         | 7 ++++---
 hw/pci-host/designware.c | 2 +-
 hw/timer/aspeed_timer.c  | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Olivier Danet <odanet@caramail.com>
Cc: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
--=20
2.21.0


