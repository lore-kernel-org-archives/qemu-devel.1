Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DD420888
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDCepfP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DD420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlWp-0006fQ-LF
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl5Q-0004vp-DA
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:55:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl5O-00028k-NL
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m70XDKVx5FpSNAmS9FGjLCI+V05BcMupEqmlBSYDPOk=;
 b=NDCepfP0ROoV/mXfUeJQC7HVb7wya67D4bYZqLU2WmZK8uXd080R9vKz8o1UFoSl0zCcW2
 E49JGXw1goyEnwN2pFnG3XcPrDUfw/vv49XFOSyZawQ8YTvSnMrgUNd+2g7E563NyzrF7U
 ZCsIthSzPryS40ykBjffqaaM5J0CPVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-Vtqtt5jeNAqx1Z82JIupxQ-1; Fri, 12 Jun 2020 10:51:42 -0400
X-MC-Unique: Vtqtt5jeNAqx1Z82JIupxQ-1
Received: by mail-wm1-f71.google.com with SMTP id t145so2545589wmt.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m70XDKVx5FpSNAmS9FGjLCI+V05BcMupEqmlBSYDPOk=;
 b=Nk5tBCrAS4Jckq2UoQ2dreUyZhwvw8oicqtXK0DIyM1FeXVs00Wpm2OVE1f3nvJXgv
 WUXygn0Rav4qkJUd4lHlF2sKoBzRtLLMgF6YbMRtcClj0eyV8Bj5rup0FZcneUZOazUR
 V6+3y/ofoZ1mR8pD6vyd6yza7K7sjFBQIq/xUt/cFN35Z+uPYXDqsyIqUo0gZVUu6If9
 4fdB+ExI3T6DaqgtMeFAI+5u78Tohs/mZnIsGGnjxBrtOrFUaGfLYK8glZ8SMVDF3nqV
 mZJ8sQosz2qY4RFPGb/yVuS3v1eJT3mA/xiW6VdhYwNVx5ik5vJQqMB2BvtqvNVrr0G7
 sv7w==
X-Gm-Message-State: AOAM5323A3oejSvoKqZWc2I4RJr9AMeeNIDKh43xHP9DYI4TWCZnzyb5
 hHYW93AGMSQ/8iR23CQJECuOKrPJ4hwyWlHf07OmjkzHR9WCeVsoGY2/o8rix6ebVQG+jeF2OSO
 hBh6bm0IbGw9I3Ko=
X-Received: by 2002:a5d:4490:: with SMTP id j16mr16683019wrq.276.1591973501698; 
 Fri, 12 Jun 2020 07:51:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx231ZEhbrTsyz0l2P+lW3nSQj/sZnaC/ZBlLB/1jvAXnpEnzsMOpmRrYAMXbDKg1z7QngRtw==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr16682996wrq.276.1591973501496; 
 Fri, 12 Jun 2020 07:51:41 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id g187sm9833498wma.17.2020.06.12.07.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:41 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 17/58] test/tpm-emu: include sockets and channel headers in
 tpm-emu header
Message-ID: <20200612141917.9446-18-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


