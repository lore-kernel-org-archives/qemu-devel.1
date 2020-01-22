Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD304C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A2524656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q//XH7SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A2524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu983-0005F0-3R
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8zl-0004Cs-N8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8zk-0006N5-Gq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:56:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43367
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8zk-0006M6-Cc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfFv49LFSLdXK1/7HJzZJqCabeu5CMr+Q9T61Qs2V4s=;
 b=Q//XH7SWwWFycgLnV2GE/hfRGwiQFI/PaOj0UCYSIKp0CRyr0+abLODgUgdCgxvzKVFTq/
 lCvCrXLagUGx8ZTNGAdIJuu/AjO7V0UGn9lDykpz96yUpONvPNvHdYmFoWeOlu6CL3qJek
 /WXg9GxTCinNHWqaCvuUaPNe0uDqJes=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-H36N8YsHPxaa59tLGSO8YQ-1; Wed, 22 Jan 2020 00:52:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id w205so1612537wmb.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EdvlCEDlyygl5LZfs8930w7NjWVUhDfxRmswNGuyQBQ=;
 b=WMzm4g+XVO3WCkDJE6/citmKDdx+lvfAvMku43XKl2ZmLmsHBSQEIYUUtRGzxXMV8g
 hdY6BFmXT8H7AkX1oT2L9kaLN/Wm3RA6K2/e1ebTiCo7O5VIcJhBJ3Y9IXA8f36YOEsI
 ZThczp8Du/sEHg53uJ84Nfsah9UQXpMzFc8PqYKmD+q0l6ScgHvZ7EXXNA30z0XL9Sfb
 aITtYwTtjPIJuTH4qnJ0IYW6//GRBb0K6Iwln7yRgAaur3CYBmUomgnFcqYbK1S8ruL4
 1HEDx3FR0QByZsjnoUgTe0u8VkUEzv7hkWSB/zBpZNGoQSnMshHqvnPyd0t8z0ULnBqZ
 h8tQ==
X-Gm-Message-State: APjAAAVAGlhDNTVJOH3V7GBUEB8y0iEibldl0mmCdkS8KKMIvlXkpMwY
 CQpzux7iiw+N/jr6WcG4INi1HEv9u+KitLJ91A+C7owRP9TdlyNKYvgA48yrXzNASZLoO0g3WGV
 LvgwpdmT0eZxi6bE=
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr9031720wru.52.1579672351333;
 Tue, 21 Jan 2020 21:52:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYr1MIy6k1BrsQIYe+CBStkKXLBVLc0qgHfRnoPaCg7SX3mcsoJRF6DzpVNraANblBO0dq2A==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr9031703wru.52.1579672351064;
 Tue, 21 Jan 2020 21:52:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 s16sm57581474wrn.78.2020.01.21.21.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:52:30 -0800 (PST)
Date: Wed, 22 Jan 2020 00:52:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] vhost: Add names to section rounded warning
Message-ID: <20200122055115.429945-16-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: H36N8YsHPxaa59tLGSO8YQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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


