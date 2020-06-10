Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE168206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrvhnCra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE168206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj6zs-0007sT-36
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wA-0003Wn-6R
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6w9-0000Pi-CT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWMg4HObNcb0F4Bp7X8vxMJGRNjGiyU+9e6+l42zIY8=;
 b=BrvhnCraMyqORx51fxLGQlJzf12A1vB3nTHk6zbChHJ226kH8zOiw6GGVs3AIXgAjrl1Bj
 NHy/9J6TdYVi6q/9PxuOMPUb3Cr+CZdkgZtaAMU9Yh5VIm1+F+U6Sg21XNMH2+iJ2p5XIT
 jFAAyDU79UPi/HqsaJ3jIq8k2XNJiR4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-KzK_5o-uMiylgxDyNja49Q-1; Wed, 10 Jun 2020 16:02:56 -0400
X-MC-Unique: KzK_5o-uMiylgxDyNja49Q-1
Received: by mail-wr1-f70.google.com with SMTP id t5so1520028wro.20
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CWMg4HObNcb0F4Bp7X8vxMJGRNjGiyU+9e6+l42zIY8=;
 b=S6GYHvwE56jklZhprw+h9TCnuehcWDr8IN0QmsruAbusgp1C79YT1UF3YoqE0U+W4V
 WULiDis5iwVNYHS9Kc2oUbjQDnHpQvNv7glRbLa9an1yZiIRIXQAGhfeGpUEWb8x6bGZ
 t8MEk6rTH8NDLK8zEhtWr2HMsA/KdqLf1xo7Vu3o0aUB80JuOKTmrmkSccaCZYYcU2du
 OR1HdVknCvv80HT2NmN6kJ3Qg1cmDCMf7ar0+17j6vByHhiY5lfJpfwENeYgy0PlFYY4
 P2NBnA4nz93OnbvU5kk9IV/SVHOkKZcN6eWrVl7uUSvy2+zLnoYslm+s98UDGn61Jq8U
 ZTwQ==
X-Gm-Message-State: AOAM532OjdyxjTD+c3yskdF1R7cfKuAevOoUJmA80/a3b/3pCA5KJ5WS
 H+y9H2ZWYDT3npaDmZPEcfgpw03PquOfkDZbC5H+gvbttWZppJIx1AIrmVt7382fNCeFpbTRBO7
 hijOQUNLQvA6puDI=
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr4852523wmg.181.1591819375001; 
 Wed, 10 Jun 2020 13:02:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbyBtjI06ZTZmHCDEOnaR8fSzAPzaAsMJoMvVWxwNDyMzuiKaxX3D6unz34ccmr1ssKmbjoA==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr4852505wmg.181.1591819374813; 
 Wed, 10 Jun 2020 13:02:54 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y37sm1374085wrd.55.2020.06.10.13.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:02:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] hw/tpm: Do not include 'qemu/osdep.h' in header
Date: Wed, 10 Jun 2020 22:02:40 +0200
Message-Id: <20200610200247.21378-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
References: <20200610200247.21378-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:37:41
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From CODING_STYLE.rst:

  Do not include "qemu/osdep.h" from header files since the .c
  file will have already included it.

Remove "qemu/osdep.h" from "tpm_tis.h".

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


