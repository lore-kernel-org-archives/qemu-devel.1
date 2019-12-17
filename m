Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E36C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB9A24655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hILAafoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB9A24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGjY-0000sd-G8
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGir-000080-44
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGio-0005bN-Ga
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:33:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGio-0005Zz-Af
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nO8L9Ff0gTs0Ghul9qOGY/vgywrMy48c7WRyGNxm0bk=;
 b=hILAafoJCE8SllL86u9H9CT0hSHE8hortfnFc4H98w3KwitSNwp8y/oLPy3kX6V/hmQswl
 CqRYJBk1VTZ4cZCkwQFzaSFeQRf6xgLvn9cf8kMpN7UosocePK9aH7eyxr7/J4wSqwQAsX
 kFpUmNn38Wgeh2+sTdN+mvbyrE6jzzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-UBfwbRvfMCW-lwDPShNRGA-1; Tue, 17 Dec 2019 12:33:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38484189CD14;
 Tue, 17 Dec 2019 17:33:16 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A977C82C;
 Tue, 17 Dec 2019 17:33:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] Fix more GCC9 -O3 warnings
Date: Tue, 17 Dec 2019 18:32:46 +0100
Message-Id: <20191217173252.4672-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UBfwbRvfMCW-lwDPShNRGA-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix some trivial warnings when building with -O3.

Philippe Mathieu-Daud=C3=A9 (6):
  audio/audio: Add missing fall through comment
  hw/display/tcx: Add missing fall through comments
  hw/net/imx_fec: Rewrite fall through comments
  hw/timer/aspeed_timer: Add a fall through comment
  hw/scsi/megasas: Silent GCC9 duplicated-cond warning
  qemu-io-cmds: Silent GCC9 format-overflow warning

 audio/audio.c           | 1 +
 hw/display/tcx.c        | 2 ++
 hw/net/imx_fec.c        | 8 +++++---
 hw/scsi/megasas.c       | 3 ++-
 hw/timer/aspeed_timer.c | 2 +-
 qemu-io-cmds.c          | 1 +
 6 files changed, 12 insertions(+), 5 deletions(-)

--=20
2.21.0


