Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356E9206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNMB+xtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356E9206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfU3-0007Rl-FI
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfT7-0005Z6-AU
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfT4-0006z1-J1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lg93mmx8nphNH1y4bYZrwT9M+1WJW6lG0NFyoN2HHMc=;
 b=TNMB+xtVttGNGM+ysYmUvxSm4xJdRKhNs5JJ0eLwRnJBJAbym1WmoT8WYxFsuKz3posQqi
 NewoqMA3CEkQ7f4dlGPmgUCGWOdE7n20B30J6g+dbyGyMBeQRnXPn/nTctmcqyhXaj+K7W
 igx4chAHgc7O6PtvogQ0Zo4/WxtR5E8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-bvhjp0dkNF-XxB8H7bF99w-1; Fri, 12 Jun 2020 04:55:11 -0400
X-MC-Unique: bvhjp0dkNF-XxB8H7bF99w-1
Received: by mail-wm1-f71.google.com with SMTP id b63so3581511wme.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lg93mmx8nphNH1y4bYZrwT9M+1WJW6lG0NFyoN2HHMc=;
 b=JKuIODMTBMgAz3tWe+yJJofthmynX2EqRz9NVcWS2IHg6BVi9r3AcJ7AQqMZxW9Hpl
 S5YbIbxST5OX7Hwnh6BCM7JkWRRkPQM5HgkFxhGsujUQCpUdRUE06AcigTMn0UjRBS1m
 BpThXSbfAXHdR5hqPTgSBtTDRSKMEb7oyNmpFX3E1z3+Vymw3dWLERbzaGwr1a7e1xex
 4/wpIZSgZaNHb0UE4u7xdX6ODRAClBFLOLQ1vBzHh6+gXUhMolXKAq59IkgdqEeYBAYh
 dTJe0ccUQJP11W4Q1DuMQXjcowAuA8u5IFpRpg6t5sOUeTxMelNK/aPw2DBupj10RbBH
 KZ/w==
X-Gm-Message-State: AOAM5330V/XC4m3ky42aBGMgxSmfm3ddh2yO+BA7ADISEGwNWP4QtvX4
 ZNGhif9bS/gfXODDlQOiy4aM57RGx/Buyt3RyJA2nHhoj0/KGdwXPDysiLKeObwAhzdQbv7t53k
 aGWNR/1nLK7XNoV4=
X-Received: by 2002:a05:600c:2153:: with SMTP id
 v19mr11856736wml.47.1591952109702; 
 Fri, 12 Jun 2020 01:55:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK1SsH1g/ZqIDz1SJ2QIRIb/Emcyy4zImtouMadvAKTPVupewtUyXwEsQmPV4xP9JbliUHRg==
X-Received: by 2002:a05:600c:2153:: with SMTP id
 v19mr11856720wml.47.1591952109469; 
 Fri, 12 Jun 2020 01:55:09 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d24sm7693353wmb.45.2020.06.12.01.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/12] hw/tpm: Do not include 'qemu/osdep.h' in header
Date: Fri, 12 Jun 2020 10:54:36 +0200
Message-Id: <20200612085444.8362-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:54:57
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From CODING_STYLE.rst:

  Do not include "qemu/osdep.h" from header files since the .c
  file will have already included it.

Remove "qemu/osdep.h" from "tpm_tis.h".

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_tis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 5554989395..f6b5872ba6 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -24,7 +24,6 @@
 #ifndef TPM_TPM_TIS_H
 #define TPM_TPM_TIS_H
 
-#include "qemu/osdep.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_ppi.h"
 
-- 
2.21.3


