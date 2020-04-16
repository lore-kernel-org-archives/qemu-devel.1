Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C7C3815B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F593206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcmo2bGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F593206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAjb-0000Vw-IR
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgw-0005Dw-PR
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgv-0000Xf-PL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:54 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jPAgv-0000XC-K5
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:53 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t40so16301pjb.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=r3DmuhsjF9XmFz6gfXOOjELEtTu/H+9BPOkgH77BTws=;
 b=Wcmo2bGDRfYyuyx3/biHMzNBTnu/PnaHkxYNbXZoICZCvWykxFP/K+yBYlVu9MtCB/
 sLkM6KCEz3PL2Zg1O4znelGyb+OO97Cl+6fqP09ZWwFXzKdx+Hs2tq6GX7o888IlTY8X
 5v66EWCuhaKUhYkRHflW2kgmnIQsBAestGiHCxO+vnWtg3QRHnLl0yv09pQ7Rh7yXEYV
 45tzdqNVAcczLJ8OoytIbFqKnbYDsrDeqc256OUav8UDjmMLD6Nw9ehV7RmDymRdhdh/
 UP5jjru2CJV2rWWz90NC5mBIDtVcGxbQKEoXPzGc+az2IioMMPsuh8BamLIC7vddrTUR
 Rs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=r3DmuhsjF9XmFz6gfXOOjELEtTu/H+9BPOkgH77BTws=;
 b=TT0dEK8YfpMw4EgPgepXoJ0YlWiRTSXmRlCA0FAnLaGAjGrHuP/Yi4hpN3D1i0Weyg
 J+dqVu+rfK0DIiHfXxAEylG+f3Frk9+QlAMtyHzeFt/IYXFtP1hYf8YIzsh8UwuU5iRm
 XVtCgLacpTd0HQdLjpzqloHJnM6h/ErY5eGGKEOQb7pvu/DesakzvY4aKqQc+iOrqV+w
 NUbdJWBxpJfTW+Bgrpx96bG31QlnOmJxqAYviXB+7vn/IGbnCTxC8GXy6gVbmuhJ7IRw
 4nmC2N+eCyVWtcCWXPbMfomJsZozpxFTxUe3mNiM/waHBcVTZYBZ2S5/XYeUBKcSKCb8
 UArA==
X-Gm-Message-State: AGi0Pub2z86lWoUWaUe7Xvi1GWjg3sU7kGMvRC8+/nvxkJdIMoX7jHpp
 ucTFoD92tmR1XIlrlTOx/1I=
X-Google-Smtp-Source: APiQypKvu/3yOwqBwVnNGv02T768Dk7ssWCngb0wDVNPDVqntE1FdSwg67MCXhysGAP4J9k+UXBSwg==
X-Received: by 2002:a17:902:5999:: with SMTP id
 p25mr11795750pli.189.1587067252412; 
 Thu, 16 Apr 2020 13:00:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id q9sm14044947pgt.32.2020.04.16.13.00.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 13:00:51 -0700 (PDT)
Subject: [PATCH v20 QEMU 4/5] linux-headers: update to contain
 virito-balloon free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Thu, 16 Apr 2020 13:00:50 -0700
Message-ID: <20200416200050.13144.98116.stgit@localhost.localdomain>
In-Reply-To: <20200416195641.13144.16955.stgit@localhost.localdomain>
References: <20200416195641.13144.16955.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

Sync the latest upstream changes for free page reporting. To be
replaced by a full linux header sync.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/standard-headers/linux/virtio_balloon.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index af0a6b59dab2..af3b7a1fa263 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12


