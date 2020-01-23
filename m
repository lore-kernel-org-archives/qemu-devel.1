Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CDAC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88891217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvcxUVB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88891217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWpG-0002gK-3s
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdq-0006gI-KM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdp-000057-Kq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdp-0008Vh-GY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfFv49LFSLdXK1/7HJzZJqCabeu5CMr+Q9T61Qs2V4s=;
 b=AvcxUVB4RCizMNNX+8xrswZivYulAf6IhxKDpfLA+e5W2rVHGMTZi0qF0lziuu/e4GOBn7
 w+owA6CaV06hQMzyQX0xpN9PmaCrI80Ze8jcjkOJSv8rn4Xtsi2odX8nniJw50Xd5vCWzF
 iFD2AWyRSlRcV45nLmlQSz1LrKy5WB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-EdXJv-HhOYimLgGB01mgtg-1; Thu, 23 Jan 2020 02:10:57 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so606769wmt.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EdvlCEDlyygl5LZfs8930w7NjWVUhDfxRmswNGuyQBQ=;
 b=P1xl/GyCIQGJ8ZcS+Y/NlIPwHIW84e3FFGRn91wroLgGBSRmMj9WXlLPkqM7PL62QG
 rYsSVEo07phInB3A63FLQ2I7Zz2R5CCqGPEAWKPCLnnwHtNxdKQVH1xkPe94wbhoJCoB
 SHh9cRtnIQSvCFbvhg12sYmAKy1csjo2aiQ2z9wpcKmQwUoguzO2HVvP1obWzzAj965Y
 0roKFepD0oaJhjTAdwt7obQF022k6vO2QsVPMPplRlQu2Vz6YDap2Bg5rfdXhqA808Gj
 IKfrBV6koU+osDf4AO4UolsKLk/RwjQ/Khd7CUbrVuyuXCTp3VtJfZ9nyeoN4XtujqoM
 u5zw==
X-Gm-Message-State: APjAAAV9nSW+dCquv73MU9VFjyOe+REtrBOwOoaBw+t5uvhqV6M90yGJ
 GmRvKJjbLg/hdY8v5rBgbA1tcjxVGDcmyXM7cHnPjxPT3wpDu0tEQTxDlChMeV1XXptSoVUVSgs
 toVp8l39A/34xi0Y=
X-Received: by 2002:a1c:488a:: with SMTP id v132mr2498159wma.153.1579763456133; 
 Wed, 22 Jan 2020 23:10:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxy2KBbN9jBKdsimGRfOQOZiia3qxi7WRpKHhucsSTf8cgGd4oIC9ht/yvb+ze3tytaIkxwwQ==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr2498146wma.153.1579763455966; 
 Wed, 22 Jan 2020 23:10:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 c2sm1808733wrp.46.2020.01.22.23.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:55 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 15/18] vhost: Add names to section rounded warning
Message-ID: <20200123070913.626488-16-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: EdXJv-HhOYimLgGB01mgtg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the memory region names to section rounding/alignment
warnings.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200116202414.157959-2-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4da0d5a6c5..774d87d98e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -590,9 +590,10 @@ static void vhost_region_add_section(struct vhost_dev =
*dev,
              * match up in the same RAMBlock if they do.
              */
             if (mrs_gpa < prev_gpa_start) {
-                error_report("%s:Section rounded to %"PRIx64
-                             " prior to previous %"PRIx64,
-                             __func__, mrs_gpa, prev_gpa_start);
+                error_report("%s:Section '%s' rounded to %"PRIx64
+                             " prior to previous '%s' %"PRIx64,
+                             __func__, section->mr->name, mrs_gpa,
+                             prev_sec->mr->name, prev_gpa_start);
                 /* A way to cleanly fail here would be better */
                 return;
             }
--=20
MST


