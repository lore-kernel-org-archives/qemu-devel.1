Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C1C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A91205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A91205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqlg-0001mL-MM
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHqRE-00064V-7Z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHqRD-0008Kl-4s
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iHqR7-0008Ir-9V; Tue, 08 Oct 2019 10:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CE2130ADBB4;
 Tue,  8 Oct 2019 14:26:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-43.brq.redhat.com [10.40.204.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D5819C69;
 Tue,  8 Oct 2019 14:25:42 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] hw: Convert various reset() handler to DeviceReset
Date: Tue,  8 Oct 2019 16:25:31 +0200
Message-Id: <20191008142539.7793-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 08 Oct 2019 14:26:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
- Removed the pci-host devices
- Removed the vmcoreinfo conversion (elmarco) but add a comment.
- Added Igor's R-b tag.

Following the thread discussion between Peter/Markus/Damien about
reset handlers:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
I started to remove qemu_register_reset() calls from few qdevified
devices (the trivial ones).

Regards,

Phil.

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06367.html

Philippe Mathieu-Daud=C3=A9 (8):
  hw/acpi/piix4: Convert reset handler to DeviceReset
  hw/isa/piix4: Convert reset handler to DeviceReset
  hw/ide/piix: Convert reset handler to DeviceReset
  hw/ide/sii3112: Convert reset handler to DeviceReset
  hw/ide/via82c: Convert reset handler to DeviceReset
  hw/isa/vt82c686: Convert reset handler to DeviceReset
  hw/input/lm832x: Convert reset handler to DeviceReset
  hw/misc/vmcoreinfo: Document its reset handler

 hw/acpi/piix4.c      |  7 +++----
 hw/ide/piix.c        |  8 +++-----
 hw/ide/sii3112.c     |  7 +++----
 hw/ide/via.c         | 10 ++++------
 hw/input/lm832x.c    | 12 +++++-------
 hw/isa/piix4.c       |  7 +++----
 hw/isa/vt82c686.c    | 11 ++++-------
 hw/misc/vmcoreinfo.c |  1 +
 8 files changed, 26 insertions(+), 37 deletions(-)

--=20
2.21.0


