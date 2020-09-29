Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7295C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363932075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc9uil8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363932075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAXK-0006cR-1Q
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9ys-0004tu-4I
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yn-0001ut-Qs
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sr46UlBftEsFfQaYDyC4NzS5NJz/jLKzxGNK+jKvDL8=;
 b=hc9uil8urywvzRr2ezyOrgbyMmDkV0B1NjmnWZIlsq/3rc5YpTTeo7ALfyyT0BAPxO2/7b
 B8diMBJZmzNHq9uR80z7hGnpJXyzhcvzhp6zV/pVmj9c7nEmFjvErzbNgt8yi3w9c6NR7l
 m6tqxp7VAcEuXhz9sVHW486KiNp27o0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-SRV32A6hPcikwbftogPyeQ-1; Tue, 29 Sep 2020 03:23:15 -0400
X-MC-Unique: SRV32A6hPcikwbftogPyeQ-1
Received: by mail-wr1-f71.google.com with SMTP id v5so1385659wrr.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sr46UlBftEsFfQaYDyC4NzS5NJz/jLKzxGNK+jKvDL8=;
 b=YMtRWnc6qS8ZJbfKWP6q/5MSRr0vF8GbeQF9gO1ZWBJaLrUuaMLs8sHcplZNGkj8uR
 m7vO11xvtV4cRcaM0TYgsnsTDxuDIayfV7lzUWb5PJ/xcbR2k7xKzQiucTZYf6WdhZOD
 9wVpMd06o76iXxIpoHExj1bvOB3QpYjzCirx1BkmUvHJXQkxpptCg3xmR6XZf1BSghWI
 PVK5JFWWAXq/IXikw7yVyUkmKlR7o5+dWh6xk2dFXKUM0pohbXvNT5dw0WmXXrouPXDM
 QxQ65118bvwmBY7L0HiysMvcoKlF2O7PHGzcWZfSRe868NGvAYJUtVUGMaCO1k15e6uh
 +srQ==
X-Gm-Message-State: AOAM5303jQfe8km+vIgrgNHHDVWKJxd+OOKFV4lWmb+U8kqmN7hlhPFs
 5JZos82IS1ms/b0GoilktqldsLmNy7Eht8bf7+mHXg2tcTzMbid3j2os8Bt3g8MSshCLFCEkarR
 svSSiIMHfej1gi0M=
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr3169273wmh.152.1601364193954; 
 Tue, 29 Sep 2020 00:23:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw42drn03SCSOmiNlIT8LFyLAYJNKJKXTfsmb3OKRvA6SkjAVMfAYeLetcVU1xkP5RKL48jpA==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr3169251wmh.152.1601364193775; 
 Tue, 29 Sep 2020 00:23:13 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a13sm3913101wme.26.2020.09.29.00.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:23:13 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:23:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 48/48] libvhost-user: return on error in vu_log_queue_fill()
Message-ID: <20200929071948.281157-49-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

vu_panic() is not guaranteed to exit the program. Return early when
errors are encountered.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200921113420.154378-3-stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 4ebfa4cc40..9f1285b8a1 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -2733,6 +2733,7 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
     if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
         if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
+            return;
         }
 
         /* loop over the indirect descriptor table */
-- 
MST


