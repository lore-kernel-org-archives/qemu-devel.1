Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E368AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EF720BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9de0IJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EF720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB3w-00006O-Eu
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmI-00070g-Mj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmG-0004oe-0b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4t5NY5zyTFxf5JdPvPR+dRhfn/ny8MSoW1vs+UM3VkI=;
 b=O9de0IJ+xfXkT4wuYEBGQsEzzkta3WLIfNqHkyULx13t8SW499sbjVaL8+aLI0ap89YfKG
 WnKu6G4jGUYK1a8ONqvhvmvz1ltlR/Wru1XDne8Stc6uq1BlTN9hKsoXLQLygnb1cx+iqs
 B6QT/5gVBjEh2gwUlPN1TZMeLN+udUY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-dPaoXGiPPXuIhfhmU4rDBg-1; Tue, 03 Nov 2020 23:51:16 -0500
X-MC-Unique: dPaoXGiPPXuIhfhmU4rDBg-1
Received: by mail-wr1-f69.google.com with SMTP id t11so8747070wrv.10
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4t5NY5zyTFxf5JdPvPR+dRhfn/ny8MSoW1vs+UM3VkI=;
 b=YY26dWFZdKTdxJszrfPGg5XIfEEerwTNeA39tQSBn5c292WQIr/WuWFczWAsJS11El
 tOQ+zPkMEFLMoWyUV1n/vfSLjC36Qkq0Xe1jHhMESU4S4mEuxasQX/ptwylQftsveC37
 bIS96stBG447RRM71jRYCU4IWmelP6231s03MPZoTts6xxHZ6eFovZx2tUiPGegdFS/s
 RZGAHU3TR1X2F0EVASWdaCIFBzf5xoVoo3+jiztyIviVHa+f2NwRHghfNJEMjNVK4FYM
 JVe5fJUEuOvCRPpMOOTMB8FGKQn7BcIRJE6bFldAQ8/hp6kayNI5c6Mg0J7FNmWHyjRc
 Iakw==
X-Gm-Message-State: AOAM530mgsv0bJ/HUI/Sf5WEZgqI1aIc10D4xRPt6Smdz4EOJrIxTd3k
 rxb6VUVWcV0GdLWchHieMySI3or3/A/LZEKxKdhRgz5TuD4rMjCJYDi+DGnXvpooDuhy2zeOg9U
 sgra/XUOJvNLgDFg=
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr2308226wmm.115.1604465475000; 
 Tue, 03 Nov 2020 20:51:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzB5LneqeIqlqxcFrlHeD6jODLPG3/6pQPGEz6Ef2D4s/NR30+VTEKZWVqkQ5D2j8GmxfBXRw==
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr2308213wmm.115.1604465474810; 
 Tue, 03 Nov 2020 20:51:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v6sm859879wrs.39.2020.11.03.20.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:14 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/38] hw/virtio/vhost-backend: Fix Coverity CID 1432871
Message-ID: <20201104044937.226370-12-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix uninitialized value issues reported by Coverity:

  Field 'msg.reserved' is uninitialized when calling write().

While the 'struct vhost_msg' does not have a 'reserved' field,
we still initialize it to have the two parts of the function
consistent.

Reported-by: Coverity (CID 1432864: UNINIT)
Fixes: c471ad0e9bd ("vhost_net: device IOTLB support")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201103063541.2463363-1-philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 88c8ecc9e0..222bbcc62d 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -257,7 +257,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg)
 {
     if (dev->backend_cap & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
-        struct vhost_msg_v2 msg;
+        struct vhost_msg_v2 msg = {};
 
         msg.type = VHOST_IOTLB_MSG_V2;
         msg.iotlb = *imsg;
@@ -267,7 +267,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
             return -EFAULT;
         }
     } else {
-        struct vhost_msg msg;
+        struct vhost_msg msg = {};
 
         msg.type = VHOST_IOTLB_MSG;
         msg.iotlb = *imsg;
-- 
MST


