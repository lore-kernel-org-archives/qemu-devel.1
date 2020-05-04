Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14BE20752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKph9I5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14BE20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcJ9-0003we-Qx
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc70-0006wl-Ux
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc70-0006si-47
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9taWolQYkCkuJj9pxcX5BmM/ZyUeLHeMpX/AHRl8L3g=;
 b=KKph9I5oI8Rx7Eoegt9vwz/bMRF3eWQN6gK77hewpENsii1eJmE0BcizIuk2L6khUKKSjn
 LxdmCBC3P9GriJ2hUEZ0ZwLSSJMTPCHgNkyrwKIL/tuJAahrEqcpoZOGDaRldS7RdJrzeD
 vLHxG4OiI5u3izVWlJw/q82cpo/D0rs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-v2L9NNQTMR6vC-2awv1MtQ-1; Mon, 04 May 2020 10:30:21 -0400
X-MC-Unique: v2L9NNQTMR6vC-2awv1MtQ-1
Received: by mail-wm1-f70.google.com with SMTP id h6so4982796wmi.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XOQ+yPY5ryjCd6v8gxzikDIi0OmSlMhwsIFIToytNIs=;
 b=KZtn5m9nqOM7oqoUP9OnLjcJs6yz/GXDfnLGF/xpAuVOU7cfSawe08qojThZJ4VObc
 oMA1MJ3YH4a9FavXWkPY5DkU9/8LV54FEMYBFSa/8v4VbBjpMEmjhDpdBuH2VBxhlgCD
 jJzNRJ5bj0Xw04yJ7s86hFz0sS3W8toikLto+B4ZE04ZctF7XVHbox5ip/NtGxTJ0Q3P
 JP6jQuvCzjREcc84Qrt8xe1mNyY1wHL9HPxLGvfxkvHWU/v6rKprI8hXtuuxj9HNSAH/
 8QHzb+SSqmor2TvvZ1B/iRTM0NdSc1V3ZfW3PwVZCiJTGHCBkk/tN5Rdy1EQSoaxJUcn
 R1rg==
X-Gm-Message-State: AGi0Pua0OieNAKWPdesYSevIk6jFPt1DXfUj3IfsJAwIXr+UMxE2/07L
 VHgtOvEkbtS85OovCCnNKnDB1p66KxA+tBHEvMW6YBMXZhZXCXPiOTUYEIaEIgZy+7xTj0GxjHH
 JiRnRfIRuxTEmp90=
X-Received: by 2002:a1c:98c3:: with SMTP id
 a186mr15045142wme.178.1588602620308; 
 Mon, 04 May 2020 07:30:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOfwH+e8R062AIGPe8KDrUBcGvAE6MxhOSQ1L0MT5uefnz8EMnTOU1Lbh9wh592JlJpVQt5A==
X-Received: by 2002:a1c:98c3:: with SMTP id
 a186mr15045121wme.178.1588602620114; 
 Mon, 04 May 2020 07:30:20 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 x16sm12527958wrn.76.2020.05.04.07.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:19 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/29] hw/i386/vmport: Remove unused 'hw/input/i8042.h' include
Message-ID: <20200504142814.157589-28-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Remove unused "hw/input/i8042.h" include.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200504083342.24273-3-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/vmport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1f31e27c8a..114141c6f3 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
-#include "hw/input/i8042.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "trace.h"
--=20
MST


