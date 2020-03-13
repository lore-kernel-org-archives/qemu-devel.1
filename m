Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F509C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2431206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUgg4MU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2431206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpIi-0005jX-Vj
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBv-0000wj-0x
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBu-0004TI-09
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBt-0004SM-S3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rpQjl/4AvtYAvRXnGhGAakMCQznzosD1UbxsdwPAhc=;
 b=PUgg4MU4yaoTxeMJUx68Xa9xrhnB+Z1tqPpyhnGQ0vu5tiAuF6AcNWidFLHRpuT+cUMpr8
 nqPoIuEot4mFX73dE5PCYiRvEJy99Xg8HjS6sm5OMImPkLcORy+5L0U6IQ+YC7QbrkL1pn
 3J5KCLoGyMFx2vOkZaYo+uf+MLPO8fs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-g28bIXPYOfeXfWiBwTcHlg-1; Fri, 13 Mar 2020 14:37:47 -0400
X-MC-Unique: g28bIXPYOfeXfWiBwTcHlg-1
Received: by mail-wm1-f69.google.com with SMTP id g26so3290315wmk.6
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5D+mNrA7Q9tvp/FL52Wgm2fEGpMf3trSL+14VYf2HSA=;
 b=BJi2y1PZ1MjrgqZ46pMyo3cNhGJPUCdV0gaMt3dUJsVeoggUTbHF3Tyx0eZHDZRQW9
 wLIZTXBX3r6UVQOEphOoPWg6asWJeU2cNJ6ZC32ThMAH7QmljvB5EGQsWEc1tSgShyIQ
 NHVaeWyYf+RA67mfSuJ6WprLjXDzIizZJtdI11rODzxNAshwLkyg8PEkExQMARiPioKk
 U7iLGsUEowT97rLHZZdJsk0Wcxna8VNm2yDjYQewosWCWzeThzR9T76OQ9udhYuaEUw3
 NPQBH92s5BGvre3J1mMH5F7U/IUjN7N0OJxkYzj8Z1GNe2EzOHSabiZxHf1wGPIfuct1
 cE2A==
X-Gm-Message-State: ANhLgQ1mPEOY6u45Q5TrdEsttXc+lEPuipxLjkWiSKY2giaU3k2RQxn6
 FVIxT3Ealh1j8Kj0LTP4ivieEXaE4t82u53QZ+DZMRp06LOt9E654bmiB/9KzlC8zfmbc/JDmb6
 uBGccXJ7GljtuceY=
X-Received: by 2002:adf:b650:: with SMTP id i16mr7761467wre.316.1584124666611; 
 Fri, 13 Mar 2020 11:37:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbgojL+JELKTTQY7b07V5DyCa0cnA6l8unuf63XU4fZEe0G8Ebz0T4lqt+EoIkgCebb1/0fg==
X-Received: by 2002:adf:b650:: with SMTP id i16mr7761438wre.316.1584124666470; 
 Fri, 13 Mar 2020 11:37:46 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n14sm6761179wmi.19.2020.03.13.11.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/14] arch_init: Remove unused 'qapi-commands-misc.h' include
Date: Fri, 13 Mar 2020 19:36:48 +0100
Message-Id: <20200313183652.10258-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ffaee83bcb2 moved qmp_query_target but forgot to remove
this include.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 arch_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch_init.c b/arch_init.c
index 705d0b94ad..074fa621b6 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -27,7 +27,6 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #include "hw/audio/soundhw.h"
-#include "qapi/qapi-commands-misc.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
--=20
2.21.1


