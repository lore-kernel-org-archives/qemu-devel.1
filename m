Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F591C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064E4218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUTGu0VU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064E4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPVf-0005Tv-Rx
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSO-0002zp-UJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSM-0004Ef-N8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ2JSVFibEBuSdrDhyhun8v6dNN9NfBaGi/52/sdax4=;
 b=SUTGu0VUM1HHflHXu1F0Xf4jSgqg2BFxpdB6/mYGdLacV69JE2FKHVrHf53vMUoJitmJss
 d6wD383Gvy2yWv0LRp3rHZ5UU0B7VRgzzJOONthJaVaRYigzzqei1dVKLrycvJKDsGEHVp
 Qb19xPtIRqMAtyHSNoRD+k+/I8DD3ak=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-3ZgIFAhaNyCzX7GnW28XRA-1; Tue, 27 Oct 2020 09:56:08 -0400
X-MC-Unique: 3ZgIFAhaNyCzX7GnW28XRA-1
Received: by mail-ed1-f70.google.com with SMTP id cb27so708107edb.11
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hJ2JSVFibEBuSdrDhyhun8v6dNN9NfBaGi/52/sdax4=;
 b=qXCgIsdjRrCZhf8YipLP6fJfyhsQYyXrYMY91HixmkhRlMBUVJHvIf0MuHMgaSOSgt
 d1W6wkZR+kjIKhQmUkv7g1GZpmOO1cY5XGEGbaT06wAGuWtiR2bPqKwetD0nlDbqiV0O
 snGM6m4l3vWAw6BNJFH89UB4TSV+AIfGOaTtFTvV5Pf94s1qdtYKQcHmxCgWbpdizP2X
 HOwgAqRJ0GYnn5wiC71qKBXmE7M/vk1yHlpj+ZaRFouZ0y0dX+cpVZOqlVYpTO+n8ESO
 ZJ768/80YOM5PxMMrbg3rU/eAjrDn801VW0SLwtyZ0ByfBL65O08/5Tzgna3pInuY/R5
 OwBw==
X-Gm-Message-State: AOAM531m90p4KDk3PO2NUB1RNfweYXxIG5sy6rTfURjnMCbDTcX1pu+0
 oSLzwldCMZ0/leadVZIo8vG5xWKNIkdBT/n/W9B8UShUeiGcJdDBIs6AENgzq4B220UVUFvhqLq
 WJcstez5ZJ+P8pCE=
X-Received: by 2002:a17:906:444:: with SMTP id
 e4mr2716816eja.218.1603806966727; 
 Tue, 27 Oct 2020 06:56:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBws8uIONsfcGYcdCt+x1vB07twQn0gDSXUmcWfHyfPueaX4Z30qZk5k0Xz7UVX14DKpAalQ==
X-Received: by 2002:a17:906:444:: with SMTP id
 e4mr2716792eja.218.1603806966504; 
 Tue, 27 Oct 2020 06:56:06 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ck19sm1076488ejb.99.2020.10.27.06.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/25] block/nvme: Report warning with warn_report()
Date: Tue, 27 Oct 2020 14:55:25 +0100
Message-Id: <20201027135547.374946-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of displaying warning on stderr, use warn_report()
which also displays it on the monitor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 739a0a700cb..6f1d7f9b2a1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -399,8 +399,8 @@ static bool nvme_process_completion(NVMeQueuePair *q)
         }
         cid = le16_to_cpu(c->cid);
         if (cid == 0 || cid > NVME_QUEUE_SIZE) {
-            fprintf(stderr, "Unexpected CID in completion queue: %" PRIu32 "\n",
-                    cid);
+            warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
+                        "queue size: %u", cid, NVME_QUEUE_SIZE);
             continue;
         }
         trace_nvme_complete_command(s, q->index, cid);
-- 
2.26.2


