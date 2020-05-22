Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14529206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z30hyoAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14529206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBVk-0005pT-3Y
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQn-0005bt-7F
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQm-00028x-8t
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDajBbKs4gis+0Hzyip6W2ChjFSOOWvPUkN8dD09nr4=;
 b=Z30hyoAufNZRMLZFvoYS6WxQpg4eB7RnyIRa/NYsL+m7KnBgefbr1I/aCUrgXLUlcDWneO
 RQbxHLWOz89ito9Sk/1+ofr7T12ngQsEkU1Yr+96DdiQ1MbwXhO1Bxw1CnGsFAZ6stdHPJ
 wcUmHtmAJwxMLT51dFFQBv4sgiZUXj4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-3W6cMmHJOLmFlN06PQPRrA-1; Fri, 22 May 2020 13:25:58 -0400
X-MC-Unique: 3W6cMmHJOLmFlN06PQPRrA-1
Received: by mail-wr1-f72.google.com with SMTP id g10so4651071wrr.10
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zDajBbKs4gis+0Hzyip6W2ChjFSOOWvPUkN8dD09nr4=;
 b=SLgZsHtPn7rpEbKLK+fq0U0GR6cI57LQ/0dePhVDzDmFzsr5mwvBmyD8MqnQXYxLGW
 SvY4/DJU3yl0D7gV1jDaA3njrt6Jm5eWeA0EoEHn6p4vrL8hbBNdIS6OPbvVUE5QtnXa
 Uz7Pmif2+4Y++QGvF3xYA1JGrmKqS/TkumGlGXYuVXa1SQzN2RaGwrxKX3CtIgaH+2b6
 jbfiIam8WigJwwm/Sib2VE/6CmVjgnctwPYHxSiFjJsaPSIf9EDlhZKh3n8tfgkJ4GAx
 wxS9kfSFqWqBI3TRqrtH2Htrw0jTSWOghkxO84KKMugsdDDIJVaTILvKVTGum1b3dFpV
 I5og==
X-Gm-Message-State: AOAM532ECNUKTzttMTidOFXeaCpPZ7iycPUJaRLoMW1U2kOE2Yqnm79N
 JDtVXHjREmhjSzgDZTBTfy7ZiwRUM2YnQjKFzxrMvgUYLbpP88DYDhQil6tn1DqOhXnqMAuAkBy
 8/ssGeP4+FZgcV4o=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr14280786wma.16.1590168356840; 
 Fri, 22 May 2020 10:25:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyaWYO6dpnbCABYu+g8OxHh0V1WApT9Zdh2WOGUts7j67S9+77L1qYMNNi7VJtPMMSZKAj3A==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr14280761wma.16.1590168356698; 
 Fri, 22 May 2020 10:25:56 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y204sm2077653wmg.36.2020.05.22.10.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/13] arch_init: Remove unused 'qapi-commands-misc.h'
 include
Date: Fri, 22 May 2020 19:25:06 +0200
Message-Id: <20200522172510.25784-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ffaee83bcb2 moved qmp_query_target but forgot to remove
this include.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
-- 
2.21.3


