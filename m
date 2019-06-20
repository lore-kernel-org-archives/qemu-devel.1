Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_DATE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4947C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914422080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914422080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvbt-0001uG-Qa
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hdvYa-000846-Kb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hdvT4-00009z-Dg
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:43:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hduqT-0008OG-Lf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:03:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 760017462E0;
 Thu, 20 Jun 2019 13:02:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 569D37456B8; Thu, 20 Jun 2019 13:02:49 +0200 (CEST)
Message-Id: <cover.1561028123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 20 Jun 2019 12:55:23 +0200
Date: Thu, 20 Jun 2019 12:55:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH v5 0/2] ati-vga: Implement DDC and EDID info
 from monitor
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
Cc: Corey Minyard <cminyard@mvista.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 5 Works with ATI MacOS NDRV, MorphOS and Linux radeonfb so
          hopefully this is good enough for now (each of these access
          DDC bits slightly differently).
Version 4 try to fix an ASan warning about leaking bitbang_i2c.
Version 3 keeps bitbang_i2c.h and moves it to include/hw/i2c/
otherwise same as version 2.

BALATON Zoltan (2):
  i2c: Move bitbang_i2c.h to include/hw/i2c/
  ati-vga: Implement DDC and EDID info from monitor

 hw/display/Kconfig                   |  2 ++
 hw/display/ati.c                     | 60 ++++++++++++++++++++++++++++++=
++++--
 hw/display/ati_int.h                 |  5 +++
 hw/display/ati_regs.h                |  2 ++
 hw/i2c/bitbang_i2c.c                 |  2 +-
 hw/i2c/ppc4xx_i2c.c                  |  1 -
 hw/i2c/versatile_i2c.c               |  2 +-
 {hw =3D> include/hw}/i2c/bitbang_i2c.h |  2 ++
 include/hw/i2c/i2c.h                 |  2 --
 include/hw/i2c/ppc4xx_i2c.h          |  2 +-
 10 files changed, 72 insertions(+), 8 deletions(-)
 rename {hw =3D> include/hw}/i2c/bitbang_i2c.h (80%)

--=20
2.13.7


