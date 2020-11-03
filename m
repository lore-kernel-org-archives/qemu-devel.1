Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3CAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC84206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oge5vED8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC84206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxpw-0007cU-M3
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOw-0004zL-AL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOt-0006a4-10
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Try6I8+Gzp362j90+uCp08fdMyiL5wC2Bsqj8twh+n4=;
 b=Oge5vED8/T0NSBVeS0SBz8N0ldebBL6XFuz7ghOQbiDew7duBjeKvNIcu2lTB4whFOTq0x
 LJLqvGkzGJC9PsqNoe5whChcIppgNTq6GBF0FirXtE9nrqNOPDJ+aoxuvyoL9GEg5z8sqv
 JBxIHC9L3B2zvXV0EOGV7X7IXjZMcY4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-yoGiQsDEOwiPx8rr2Hn26g-1; Tue, 03 Nov 2020 09:35:04 -0500
X-MC-Unique: yoGiQsDEOwiPx8rr2Hn26g-1
Received: by mail-wr1-f69.google.com with SMTP id j15so7902518wrd.16
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Try6I8+Gzp362j90+uCp08fdMyiL5wC2Bsqj8twh+n4=;
 b=mdN21yfwmoQm6/HAMoCNmYI5T7hvena4F267+Mw1UiBTi0sc+T+rMoax+8+kKFo4Ay
 7XbVYlW4L01IwuHbPBtvoo6xhdd6FNs1refU+dlLazfJUx1PvRdMK54+tLGyTLlXHBvl
 wVcUXZhopoHvHxxFf9C9Vj3YCd+eF5aaSZEOEajzhFN3XeJJ/soR34F19rSoYxAPD1Nj
 nN4kQaspgfe+QV2ZwSdjfdfYU+dTt4w/LWmGg6mYiZofjITKUJUdmgpmCW0jlOokzgYP
 J9UJGuFkQZD1iasms0TrDXtVLhMYlEosX4vNZMiOuRs2Ot6pGeACvgKCYM9L1RBJ+W4m
 FRkA==
X-Gm-Message-State: AOAM5334mzRfQkFlvHvneZSTq87xJ3tShIA/DgswMhDxyvzvwynevq35
 yYBoimV7Cfo9D0ROgH/tyVySdYHozW1O1mROF4c4Jz3aIhjws4Lw8xslBeXe+K0kdgbvBvVWA/o
 c3id520ZAn8X2PCE=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr36861wmj.37.1604414102846;
 Tue, 03 Nov 2020 06:35:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza4rrcu/xR+QjdM8GsHhwuJ9vtUSLavliR20kgMLMjA+Tj66AKFQ72Q6aAv3V9GyDplIH1Sw==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr36844wmj.37.1604414102704;
 Tue, 03 Nov 2020 06:35:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v123sm3205562wme.7.2020.11.03.06.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:02 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/38] vhost-vdpa: Add qemu_close in vhost_vdpa_cleanup
Message-ID: <20201103142306.71782-24-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

fix the bug that fd will still open after the cleanup

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20201016030909.9522-1-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 99c476db8c..fe659ec9e2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -145,6 +145,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
+     if (s->vhost_vdpa.device_fd >= 0) {
+        qemu_close(s->vhost_vdpa.device_fd);
+        s->vhost_vdpa.device_fd = -1;
+    }
 }
 
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
-- 
MST


