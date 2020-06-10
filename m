Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC60C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45E520734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg7zlEzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45E520734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisYU-0002Lz-RO
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKc-0007ew-Iz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKb-0008FV-Mw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m70XDKVx5FpSNAmS9FGjLCI+V05BcMupEqmlBSYDPOk=;
 b=Sg7zlEzxbSP8KiZMHPr3F7gw2fxCdI3KC9P8uV0/fP86AjmojYY0tHqrnSFSsF3kvGhGuD
 bOTyxqqITD3Ss5a2xGo7XpwiO7WASsgw2RwVjyclZi+5GRx5LIlXrrM7etR3EVxxwgRbDp
 JXpKvR6yY/WpGP43845GA/cEZDFG6mc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-oR2SV-jPP3qlcTN4lI5xxw-1; Wed, 10 Jun 2020 00:27:14 -0400
X-MC-Unique: oR2SV-jPP3qlcTN4lI5xxw-1
Received: by mail-wr1-f70.google.com with SMTP id z10so518113wrs.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m70XDKVx5FpSNAmS9FGjLCI+V05BcMupEqmlBSYDPOk=;
 b=PHk2KNqA+cJBD0OiDOby+bLrRKz0WuznimbNOEuh84/efHaMoP0fj4TmRqtQyCPc5V
 v0ayGGFIvgUDG+pDwuv571TTSglhAPvRWLng3xNZKeaYkU1OEc8ovIqgI5aTG71rWYpv
 2m8+tZdrDSuDSGI1rqCZkW5d9I0kYVA8mbItmhfwks0WjMaQ5vaSOK/DeOn0hNbUBAUo
 kBHwiV8T1EXgKZg8VQu0BAQimS7Ya3007ylcZIDBwziiPe35PiHrLop4hUIwGU2dc2aA
 e5cTH2YKO+qc+3zdxTWNMyyuL31I8LkoaWD4W5rk6Qs51o4hqfj4XQMTKoec+swagJbD
 XiYw==
X-Gm-Message-State: AOAM533NGCVpERjaHArj8GSwpl4cEBAKohDI03s5J25or7wjYUNekEqU
 FcMACeJPYktWPviqZFwXKdABKVAyWNS7eFmN0uSwSErPS4dqNS10x9ybLcqi3objsXwn/kg722G
 SDli6JWAXvBStuyw=
X-Received: by 2002:a1c:1d44:: with SMTP id d65mr1128949wmd.179.1591763233104; 
 Tue, 09 Jun 2020 21:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5+mHMbci/9Hal4JeswoKmAAnd2pAaAeF15lNGXmHzArRf3w7l+BDViaRH0KNAxGbvWQK7ug==
X-Received: by 2002:a1c:1d44:: with SMTP id d65mr1128933wmd.179.1591763232910; 
 Tue, 09 Jun 2020 21:27:12 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id q1sm5099009wmc.15.2020.06.09.21.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:12 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/56] test/tpm-emu: include sockets and channel headers in
 tpm-emu header
Message-ID: <20200610042613.1459309-18-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Include sockets and channel headers to that the header is
self-contained.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20200609125409.24179-2-eric.auger@redhat.com>
---
 tests/qtest/tpm-emu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/tpm-emu.h b/tests/qtest/tpm-emu.h
index a4f1d64226..73f3bed0c4 100644
--- a/tests/qtest/tpm-emu.h
+++ b/tests/qtest/tpm-emu.h
@@ -16,6 +16,9 @@
 #define TPM_RC_FAILURE 0x101
 #define TPM2_ST_NO_SESSIONS 0x8001
 
+#include "qemu/sockets.h"
+#include "io/channel.h"
+
 struct tpm_hdr {
     uint16_t tag;
     uint32_t len;
-- 
MST


