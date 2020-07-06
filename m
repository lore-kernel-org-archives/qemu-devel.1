Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 21:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECEF206BE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 21:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBCFCdST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECEF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsYSF-0007nx-5m
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 17:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jsYRB-0006ch-Ea
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 17:14:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jsYR9-0000F0-Nl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 17:14:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id s26so3843159pfm.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=acjGGWgKUJvrZGoxpYJl7P/XI7BGZw5IGivnyAMuxD8=;
 b=WBCFCdSTS3kipc8fbgW8GzB75GMLoJmpDVAmvzyUTZWCvY6bJ+ODidOlfygSGV8r2R
 WuilLDpX6mwnw7CH8yJXTHOyX4FzUY5Khi0EYxjNzxMWZSXY8QAIaq1RWNhU362nzN45
 iNPK2fsrsmAXLiKW1LdAEjmENbaOMT426KRywzNQR/W6vRsyE8NqEmFJDiOnjrH616Nz
 BHYaWD4z+9NtaUmm9hKHn3De/kXRitq/ZQxmKTx88yYuZy6pUf4trdKjy/FVKqykiY7g
 mzVlZrUnsLar1/MVSjwLfGDNE/PUgJKdWN5fAL1B0CH0/vXeCZGW7VBQs0L4PoYG1kFI
 wjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=acjGGWgKUJvrZGoxpYJl7P/XI7BGZw5IGivnyAMuxD8=;
 b=IzRkKZaauxs9YFDvKbayI5fPw+XX4a2DR1N5U2xgN6qNtlJ+8NZZRRCxrYJ5HS4MVT
 cdHWEda1KiGpGezBnVUOWLXvqkjl1BoRFkPrzb78NvFmVzcIiHBS6I62DNoVflLOvSKb
 2OYTOlda8PrJRSRgzMOzuiqfrdkaDE3+yrULoxpvV68/OgLAu/Sb5uza3wVnNZjHsKlb
 CVqwqwwvPFNe+GC9itrCGoRuchgILVimVk+t3ES01pKrq1kpQP4CMyGn9hjP+lwxZTNU
 XL2dHuGIb0xmTsVMS5iYEsIHxPryrFff9GWMwNeZU+A2kblmXotxVUAm9MT16zQM4Bdw
 xKsA==
X-Gm-Message-State: AOAM532nDYt8FFjhOxCZwbWFS/jZeahjZoP0jMmk+8FB54BzfwhjvUde
 L2ZXXHxk+C15zFS8VCghtv4=
X-Google-Smtp-Source: ABdhPJzhNEioIrZdCtWVT1ZFkq8HYSmAOHrT3tnC+6B+k9bDH9Kd/0EYXS/E3xjF+ZY9duaK9bzJsg==
X-Received: by 2002:a63:6e4c:: with SMTP id j73mr40789500pgc.182.1594070041844; 
 Mon, 06 Jul 2020 14:14:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id n137sm20577800pfd.194.2020.07.06.14.14.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2020 14:14:01 -0700 (PDT)
Subject: [PATCH v2 1/3] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 06 Jul 2020 14:14:00 -0700
Message-ID: <20200706211400.20018.89031.stgit@localhost.localdomain>
In-Reply-To: <20200706211314.20018.89695.stgit@localhost.localdomain>
References: <20200706211314.20018.89695.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a430a..0c0fd7114799 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*


