Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7233C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710E2206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpkUxqkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710E2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdFa-0003dj-JQ
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2r-00050Q-2i
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2q-00047C-3w
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8CkVk2pIsA5qUp0zix2BjSa/yukK7tJBsycJrJlL6k=;
 b=GpkUxqkk1BEAj0ytg56Jxd2G7+m2/hUSSb+iT9NXUSZB4v7NebnWam87hObCLy60Cpf0ht
 fBdJj4gxWDLv/hg1FMNSThwy7XGQkjBlJDm7DK33yEJotoeHPTrsJ5XzLAD40G6TdJT2cx
 za4c+icKD9kxMVYBH/WowrKFmNqa1YE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-cYAe6a1KOROa2gD_fr1vtA-1; Mon, 04 May 2020 11:30:10 -0400
X-MC-Unique: cYAe6a1KOROa2gD_fr1vtA-1
Received: by mail-wr1-f70.google.com with SMTP id 30so474702wrp.22
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Loi2SqFjSui4Z2kBKxGGjw07sOKKiVmfF0icDHu39aI=;
 b=Jeo35db6rLeu7N3Gz/wOUM8c2q2iR63NF/SYI3HYXNx9m75M/XfFQJRBYJ/2HCbihS
 AoYzW7/RgqTO97i23BMs7owjsatLBhq89/UqkqkwXAtk5f2x3jYbH6VCMBpp7G3fFJLs
 M12zgKFLMifX68UcF4hCZ5exK6rnNMNDAqorCO6s4NWcMvZLHr6EfDBL7ZC26q4PajQj
 U6mY6gBgROV6mbbk4uCS2gEBhds+MAdME+6Iys2v/yca2f9zqUBXqFiLdDCaZq5QL05w
 pfa8Uz4r9Bk+g1b0ByPy2VY6msHrRoUcdVD5RyH3dXhVZlGaJ9o+bWOL+2fB+SkbPf6J
 S+1Q==
X-Gm-Message-State: AGi0PuZlaL1Bdx3i8i6raOlUuwCANTVas/KeX6LIiGX6/ZgrGeS53AFm
 8d2mHqJ14DnIce49CVRfkoD9ClRe9/+BDDgB9CSeqKrgQFTa4nMYBKKJKb93nITHYsuq+SRF+HI
 hrScv9ctSgnizu2o=
X-Received: by 2002:adf:fac4:: with SMTP id a4mr15444356wrs.134.1588606208432; 
 Mon, 04 May 2020 08:30:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJm0cfJlbqPAJwYrwFKRafzCoYVnnGzHPxQFg4t8os1gRI2OP5f3Fz//NjR/oYIdxM+SAh86g==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr15444325wrs.134.1588606208276; 
 Mon, 04 May 2020 08:30:08 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id b66sm15039450wmh.12.2020.05.04.08.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:30:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/12] arch_init: Remove unused 'qapi-commands-misc.h'
 include
Date: Mon,  4 May 2020 17:29:19 +0200
Message-Id: <20200504152922.21365-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
index d9eb0ec1dd..8afea4748b 100644
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
2.21.3


