Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543D0C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABD8223AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQnzIRwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABD8223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxTN-0001zr-Ke
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOY-0004RZ-SN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOX-0006Rh-8c
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4t5NY5zyTFxf5JdPvPR+dRhfn/ny8MSoW1vs+UM3VkI=;
 b=fQnzIRwRyw0v3Ytg9G61HLlIlcx3wL+n/5u8DD5zSPZKJzBcc7WV9L4nmia3KDZDrlaZX3
 IngAFlpNaL8gv33Vx5OArb1AFeDvkt8fke0uP/bM6yFCppYQ5nWT/g8/PD0SfgM4FeCKB9
 jrIWs/65U6pGyC5YcsZ2LX5c9JcKuIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210--JzF20M8MySZowuuoKzrzA-1; Tue, 03 Nov 2020 09:34:35 -0500
X-MC-Unique: -JzF20M8MySZowuuoKzrzA-1
Received: by mail-wm1-f70.google.com with SMTP id l16so2703643wmh.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4t5NY5zyTFxf5JdPvPR+dRhfn/ny8MSoW1vs+UM3VkI=;
 b=XDJFyD5vNFkAw09MyD2MWyOO6knihCEsqf30Tnmei7t5IbtZiWSdIjYTQ5SrLSmsaR
 8z3X5YM6DWUUEFrucngHhKGg31jGzYXvtpSCUhVvtOsttosVLjHRzp41AbrGSH4RO3tV
 12Y5A/bX816imKinEWab6qM0hX8OTIrIZg4pYcPB/WNXPIH8EbLpz42URSnFGRcYBWfC
 adaOuJqjHpWm9+Fe2lwctEeujM9U5HAkcMyFiUQ7ch4bFbbiXR9OyvNMzEKzSs7mefAo
 wSHmS8Hfc24dB6oJoeBxjQjbYGfS1UUixb1yKlFRL17vIbyV+66DLcW0ZjzXyDn3YGyr
 zfdg==
X-Gm-Message-State: AOAM5333bb5VVvkJePjE/1pAmq4Ok1PtBF56A/YzVywEml6bTVkHeHlB
 NwRBHuM3JCuREoeQb63GutqqFFBb44KEthuHN41HCFHSIBUUw+0k4+xVXcQ7T4dOmAyMpudV+W9
 3TlZsIXRE2aM5/Ls=
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr26129648wrm.373.1604414072888; 
 Tue, 03 Nov 2020 06:34:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwireeXor2w1ab/4FxGfEn44C89A1cVQHfyhSkn3leFSmAyEHLXzqE6R+joZWF3lxMKZfoVRA==
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr26129631wrm.373.1604414072695; 
 Tue, 03 Nov 2020 06:34:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j71sm3391633wmj.10.2020.11.03.06.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:32 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/38] hw/virtio/vhost-backend: Fix Coverity CID 1432871
Message-ID: <20201103142306.71782-12-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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


