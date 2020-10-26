Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9916FC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D3D22404
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWqLZx/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D3D22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Bd-0000Wd-1u
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09s-00071U-0D
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09q-00082u-CP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffM492hetK8u/GqoMVkU0TJmIWrPk8dUIU3q04M7GGw=;
 b=BWqLZx/kD/uePf3MyoWF27bzYpol/ZHk0XwSNSowYTxL/WHuRp4DVFu+NAVjIh66WIbJ7P
 dNfvOiTiTJHv0HhKxuxXP+2/8+B/zHXODXFZQkK8dZf6fz5ppoBSrIRVDptc9Dh/cZPGrv
 vIpHf7Mt1hphd4Z61t68eyym3x03sx4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-8QQ0V6piOtCxFfPiAVEU7w-1; Mon, 26 Oct 2020 06:55:18 -0400
X-MC-Unique: 8QQ0V6piOtCxFfPiAVEU7w-1
Received: by mail-wr1-f72.google.com with SMTP id i6so8168275wrx.11
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ffM492hetK8u/GqoMVkU0TJmIWrPk8dUIU3q04M7GGw=;
 b=rwo9vI8raL6+48yoZhY65EAHrdLYpZhjuh0TGjAKq6SWqZkVvcW9RtX214rc3ReWs3
 OEZO4Z/udaG5Go8ytNP0If09Msl6CQQHUv8XnujhQYXBQvlyjd4yJDhPK6mmmn3LDTZQ
 j7NMDSmNdRnfu/ESIu7KLv+b9IWfFoTCpndKntpab0iIzMuXEUPXCr+yWEUfPLuBffSP
 2Cu42oyqyFzodWGX+dNwshsriES+X8kA3Ot+GGVeIDTC96RaPrz08hBrCF02DpC1UfOT
 iO7iwIwwTaERmWmeEboNM6Kgui1AbyAZUu8By+yoid4K3sgbZjqBulLPQSMJr1xVxMxl
 xXRw==
X-Gm-Message-State: AOAM532sWLZv0AnRBs8oVl1F56AKBhYzGPzFMwOe+47UEyuyvVk8tOgg
 +QFz6RPyIn19Tmcs9JsNuzEOuCSXPpPfr75DjpD0h+3ts1KRrFzaQWQZb6GJQveCFP/+NdHzC2b
 trnXMtqBPCIZAnaM=
X-Received: by 2002:a1c:e1c2:: with SMTP id y185mr14956762wmg.81.1603709716730; 
 Mon, 26 Oct 2020 03:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhIuyInzKn2sgFIiJf08tBwESRjMqdMxn5AcKY1mo1jNirvpBOWrhLuNjMMCTmdogxlmeARg==
X-Received: by 2002:a1c:e1c2:: with SMTP id y185mr14956750wmg.81.1603709716535; 
 Mon, 26 Oct 2020 03:55:16 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e15sm21209863wro.13.2020.10.26.03.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/19] block/nvme: Set request_alignment at initialization
Date: Mon, 26 Oct 2020 11:54:47 +0100
Message-Id: <20201026105504.4023620-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When introducing this driver in commit bdd6a90a9e5
("block: Add VFIO based NVMe driver") we correctly
set the request_alignment in nvme_refresh_limits()
but forgot to set it at initialization. Do it now.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nvme.c b/block/nvme.c
index 029694975b9..aa290996679 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -727,6 +727,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
+    bs->bl.request_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
     /* Reset device to get a clean state. */
-- 
2.26.2


