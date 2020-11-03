Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2880C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6076920786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMCyuLfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6076920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZm23-0007oC-EI
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlkH-0002PW-Cq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlkE-0003fO-Au
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tInFlNUhYIQeb69gl/XYovY2WBBHKAlRLVs6ZNnRMyA=;
 b=dMCyuLfbKg8S3P4QxJfGmX4yXmaFeANvkRtAETPQtzBug8nu4iYBAYkmG0A8xchOk2XiY7
 hZavXWGHgWfA1h5I9KFKNdFVFT2rIZnjDQpvaKCWMqV0/RU2GVYQnl5+Xk06Th8zV4jLfE
 eEediZThIQVrLRlpTPdxsGY5EU4tIEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-4RPriYJHOYOWKsYe_Af0SA-1; Mon, 02 Nov 2020 21:08:17 -0500
X-MC-Unique: 4RPriYJHOYOWKsYe_Af0SA-1
Received: by mail-wr1-f69.google.com with SMTP id j13so7253018wrn.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tInFlNUhYIQeb69gl/XYovY2WBBHKAlRLVs6ZNnRMyA=;
 b=BGEIJ+fWql1bVWDWBpa6TAx3H/jTGKI8ELpzSvKcdtVckVJ1E7fs4HGaVgDi7ba8uy
 57AZ1xYq7r17F6M/w7DtzA64hFO6JUkonssVv4d5eEdwmo//c5ApuHyE8Bx7we8/CXxk
 JVVQdYkexdDs94mqN3YIo2x+17odDDfPx4DNWZUsaSAMYc6ruWdW0x7qc8jCpSwX7J0s
 vF8n/zEOGukI756upUj1/Vif75kdqPPAT1D2+qaumxDC8pCF+Et6+XBNrP8FgRf/u3ra
 jZg0caflCXiEpVDUtvWw9XYQtyoB2JUMPsWlUf6BcdZqt8fYVVP3jJ1NQrsS9rt/iLpG
 01Mg==
X-Gm-Message-State: AOAM530R/IKAmK94e2qlL6oMIN/PRNZzE3dhl8R4OfRCCVYpdCvX1Tg8
 j1+wwinUFbhsHB/d0X2o5ea4Q8rLN/TDd1ndn7K0Tz6f2WwxXE0Aajw+87sTm6RAaQqOS7v3/xO
 MhPKDneYNSOxBMuk=
X-Received: by 2002:adf:cc88:: with SMTP id p8mr24888707wrj.201.1604369295649; 
 Mon, 02 Nov 2020 18:08:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOpUUrfDlUhnkHSiSuu/bd3I8JnVT89AEnrPLITqEKtiSuHkLZ/Qt8wk3j/mKjr6Nu29BMcA==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr24888696wrj.201.1604369295517; 
 Mon, 02 Nov 2020 18:08:15 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id q2sm23622584wrw.40.2020.11.02.18.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:08:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 7/7] util/vfio-helpers: Assert offset is aligned to
 page size
Date: Tue,  3 Nov 2020 03:07:33 +0100
Message-Id: <20201103020733.2303148-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103020733.2303148-1-philmd@redhat.com>
References: <20201103020733.2303148-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mmap(2) states:

  'offset' must be a multiple of the page size as returned
   by sysconf(_SC_PAGE_SIZE).

Add an assertion to be sure we don't break this contract.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 73f7bfa7540..804768d5c66 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -162,6 +162,7 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
                             Error **errp)
 {
     void *p;
+    assert(QEMU_IS_ALIGNED(offset, qemu_real_host_page_size));
     assert_bar_index_valid(s, index);
     p = mmap(NULL, MIN(size, s->bar_region_info[index].size - offset),
              prot, MAP_SHARED,
-- 
2.26.2


