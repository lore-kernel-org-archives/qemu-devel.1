Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2CDC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AC420674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyBVsGjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AC420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdlY-0000iS-5w
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd95-0003WW-8N
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd94-0001O6-9z
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd93-0001Mh-3T
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEnP2IFRb3mCM1tNR7tauzbmbG9nebhnPEsn2Tpezpg=;
 b=YyBVsGjgy/cMqsjxpX1UQFDoKkTxg73nBXJrw949kVIlnsRmxj1cEt8dRaFUYO8gXXla+e
 BnVzIC01FPw2FISHbFOCgKRACDjd8URkXgo2jHjMzxDNtwwRM4bWnJA/+AFF6RlVlM/MIg
 5zC9vGhm8mV2DOjmUK6kVdiJE6NS+fc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-Z9B4jUr-Os2TtgLe2wyiLg-1; Sun, 15 Mar 2020 19:58:10 -0400
X-MC-Unique: Z9B4jUr-Os2TtgLe2wyiLg-1
Received: by mail-wr1-f72.google.com with SMTP id g4so474645wrv.12
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OTAkvp+UIu0li7JE8XuABf9SXmqEcQOx5Vqcp1Jmo2A=;
 b=MLMr4gnQ2KK9njmG8z2bgUCaCdH1S+6pSbx6xfW/C4BmkXd6W9VASmI3ADw7IpEqZh
 fJwpbJAfjAVMKpsq1IQiTMcgav/ePU/971CmUsDgd8s6Ogcc4mJh2tgpO/oL4KE4cmT/
 VcsoOLvhuTOhEzWvttrG1xWi14ERs3zm6bekmJv0B/pxTc5vFHU3tQaN5uWjvJS/30VV
 MkpAaQ/+jxE6LcSqBmpAzGfhJ4H/5MDJ6ULPZsFLxn5pvF58juBCSXYjFL08oRgM0lP7
 6daZfIu1MKBIwht2M1hWH+9aO4BWMwJG/eIG8inea2RNiTPWiZsMlhxSWGM14zwOAydC
 EeZg==
X-Gm-Message-State: ANhLgQ0JWhSEoLnsk3ZDlM/qvyMf7xyT/wnR8gThNN5FZPb2dNo8opF1
 MZ44lDk/1tA6rw/aF1im0Tt+lu6ZNVA4wxMa8kjAvyBYIMbc9fdtdsTH+3Cwxxr0EmbXJFu8MPm
 XDnao0LD4YLKk/pI=
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr25137796wmj.10.1584316689384; 
 Sun, 15 Mar 2020 16:58:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu0f1L96zFMffMbFE774ZSJEzFMM9nUowdLFwMr3G3FVbBDk7Pl/gXiOUgxXlp3/SqIGadvww==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr25137782wmj.10.1584316689224; 
 Sun, 15 Mar 2020 16:58:09 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id b82sm21472374wmb.46.2020.03.15.16.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:58:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] arch_init: Remove unused 'qapi-commands-misc.h'
 include
Date: Mon, 16 Mar 2020 00:57:13 +0100
Message-Id: <20200315235716.28448-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ffaee83bcb2 moved qmp_query_target but forgot to remove
this include.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


