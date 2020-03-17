Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1016DC5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF0B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcR3eNv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF0B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELih-0007Lm-0C
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELan-0002lj-LS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELal-0003KP-AQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELak-0003Hi-Pi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCCSGLhwJCGa6fW/xmoL2oVSV5CWJA33+UBKKk99HzE=;
 b=GcR3eNv2EHkCgoISlg0zvopNxjwCBTSBGWcVmpw23VI1+bphZJsZkXoli3/zrK+3BMlVo9
 RRiC8VBQe6dAKqtbVBv0hVWT+1PjRajS4+JTJsUOslqZEhWimhckz9Gd278eBLhYlHtMNf
 Cm4z7ReKOnIb610qqMS0BBr2Q/5QW2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-5I3DhKzKNEaRFtnLm1G8zw-1; Tue, 17 Mar 2020 19:25:42 -0400
X-MC-Unique: 5I3DhKzKNEaRFtnLm1G8zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463A3DB60;
 Tue, 17 Mar 2020 23:25:40 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4E260BE0;
 Tue, 17 Mar 2020 23:25:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/20] hw/ide: Move MAX_IDE_DEVS define to hw/ide/internal.h
Date: Tue, 17 Mar 2020 19:23:28 -0400
Message-Id: <20200317232329.22362-20-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

We can move this define now that less files use it to internal.h to
further reduce dependency on hw/ide.h.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: e68675d2f6252f229cf788b7cd163bb76fa3e26b.1584457537.git.balaton=
@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide.h          | 2 --
 include/hw/ide/internal.h | 2 ++
 hw/mips/mips_r4k.c        | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/ide.h b/include/hw/ide.h
index d52c211f32..c5ce5da4f4 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -4,8 +4,6 @@
 #include "hw/isa/isa.h"
 #include "exec/memory.h"
=20
-#define MAX_IDE_DEVS=092
-
 /* ide-isa.c */
 ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1bc1fc73e5..55da35d768 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -27,6 +27,8 @@ typedef struct IDEDMAOps IDEDMAOps;
 #define TYPE_IDE_BUS "IDE"
 #define IDE_BUS(obj) OBJECT_CHECK(IDEBus, (obj), TYPE_IDE_BUS)
=20
+#define MAX_IDE_DEVS 2
+
 /* Bits of HD_STATUS */
 #define ERR_STAT=09=090x01
 #define INDEX_STAT=09=090x02
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index ad8b75e286..3487013a4a 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "hw/mips/bios.h"
 #include "hw/ide.h"
+#include "hw/ide/internal.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/rtc/mc146818rtc.h"
--=20
2.21.1


