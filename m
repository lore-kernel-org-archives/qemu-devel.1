Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA63DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9592081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCvT0JDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9592081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlMs-0005eD-LM
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3b-0001jc-S1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3Y-0001l1-FH
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7i0b3GPG3H6Dh/tglQZmkCX3+dgrOP3sk2+xsAeedP8=;
 b=PCvT0JDduVIqXsksRvoevv4Bqn3mTkPBVUbmUmRR/SNJ8guUQu4y/R+nIlqaCNhRORUE3d
 iIWU52NgtnMitO7puwo8ULJs9u1EsQbJ7/8QWwCdUsIMCv6MwvEW105WmxDPpyFG+I/FFr
 7RpZgYCozVTCr7nPkh+mxFrPKS7B5yY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-LnAI_Ao5PF-fraJ4Fk8wkA-1; Fri, 12 Jun 2020 10:53:08 -0400
X-MC-Unique: LnAI_Ao5PF-fraJ4Fk8wkA-1
Received: by mail-wm1-f70.google.com with SMTP id g84so2545837wmf.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7i0b3GPG3H6Dh/tglQZmkCX3+dgrOP3sk2+xsAeedP8=;
 b=F/vQUhTkonhA0RN2QFl8PcMV8oi78h4GS1kiZxZPbFRfHMhjRyuYFAsBJ4ngsNWnqz
 zxObz3Ljz+qrxCL1tgfl3EHpoCk5JqY6CsEqiNvL3AVXN/3j3+bjIKr5q6B97rmvJPom
 Pxx2RlHYN7STyyX1BFdHHyxI6g62oyWkunB0mW+Ume+AAGLAr2cBBY5r/0YGsJvFIMAx
 HW8zkUXJj5+rTeeX4+5dwpuDhXwYds7wyZ8O67dDM6y6fNH+iTKxlOlxl+YOGRNpdK4H
 RLWT5ZAQuTEl0l6NfcJEHe4z5hY4lpcJTFqja9iMkwLrBLJ/Ivp5KRtDLAPkls5z7mc7
 pzIw==
X-Gm-Message-State: AOAM532z6nzsPU58D5daOlZgpAdsBgsK0QbwKNdVoYLas+O7Ebvogng1
 N4nE828o5Pi+4oINxOE2rZo0fRHIuPsBdXwUiQgH2MbuvzUue1QMKf/hvJTOAEifjzVeRdj2WOi
 TJoOE7vC6yDByft8=
X-Received: by 2002:a7b:c201:: with SMTP id x1mr13553733wmi.58.1591973586894; 
 Fri, 12 Jun 2020 07:53:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO0ZurgxOIxY6Ld7PFyu/GlaMEhzw3p051F3sGqjFh+91rkas+F1m5zD1X+zowEIEz5GUQ/A==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr13553712wmi.58.1591973586655; 
 Fri, 12 Jun 2020 07:53:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id z12sm11412692wrg.9.2020.06.12.07.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:53:06 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:53:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 56/58] Fix parameter type in vhost migration log path
Message-ID: <20200612141917.9446-57-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.s.norwitz@gmail.com>

The ‘enable’ parameter to the vhost_migration_log() function is given as
an int, but "true"/"false" values are passed in wherever it is invoked.
Inside the function itself it is only ever compared with bool values.
Therefore the parameter value itself should be changed to bool.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <CAFubqFtqNZw=Y-ar3N=3zTQi6LkKg_G-7W7OOHHbE7Y1fV7HAQ@mail.gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede..aa06a36919 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -809,12 +809,12 @@ err_features:
     return r;
 }
 
-static int vhost_migration_log(MemoryListener *listener, int enable)
+static int vhost_migration_log(MemoryListener *listener, bool enable)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
     int r;
-    if (!!enable == dev->log_enabled) {
+    if (enable == dev->log_enabled) {
         return 0;
     }
     if (!dev->started) {
-- 
MST


