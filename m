Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE5622400
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFWpXJvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE5622400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZsTp-0001sH-U7
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kZsTE-0001Sr-Op
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kZsTC-0002Br-M6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604395153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R136c/BJX6VgylIuYMnWG77joN+IYdL96vh0aKfuhWo=;
 b=JFWpXJvdoNjDb1Xfd8WHrj4VPtlonwK5zB/Wc2qyYxdAQHAKnbfb7cDmj/xUyWuu7wuTc8
 3FWwcKPUb+iLx7AXqApJBGrHFtSba6BSW6paU/G3hCeQ6ho/jKhzzgSShfGoYHewWMzaOu
 SeHwR4HqKRiVlEwKx2NmKscmMkfVDGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-RM-f3bBnNcGPQRqRHGzoMQ-1; Tue, 03 Nov 2020 04:19:09 -0500
X-MC-Unique: RM-f3bBnNcGPQRqRHGzoMQ-1
Received: by mail-wm1-f69.google.com with SMTP id u9so1361415wmb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 01:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GjJUSF9n3FF0kFsiuz/y3QDO/6bnST/8OXeU/wO8EBY=;
 b=akC2yFcFgnRas5tbe1WojxVEKAKvxpxRD+bBXD2fYDtFxehQa29RdEVZNftHYsqzO1
 Rk1bac1sj7glr9eS8ojXbpcD6rDLY2WKsd4nj1wFrHEOXonLHT1lf8My9CnsG4njm9j+
 rX0xFRjpn8e1ktmjdA9L1tZN0gwu2nTxZ4PrEfnJshVQ2dDZ4lYyEv7vMk1bsMbgxQ4Y
 1Z08N6iNxQlvQ3/KVlDhhM5UE1aMNeGbrA2SznBuuYO79bZnIOcwlxT6/mSBuT3DDuSi
 WAXSkWOpyvOJKRxS7aGHseFlqQIGv8qSK2vKEXWhiEz+0hOczJAnkqGzW54xkcWz4d1Z
 55Sg==
X-Gm-Message-State: AOAM531n5KZmPlPjOq+TsshrIle+L0YMBkrEbjXV8BfgI6AbhWd5dH8I
 cxRu9Lhd3aRszPm2TModgmoH+/FlayKUZkQQJZGJILpCm2CnorIY8oSAamfOUwCZo+e4pIA+wSi
 JJDmwk9tPJIPABeA=
X-Received: by 2002:adf:e64e:: with SMTP id b14mr24955337wrn.68.1604395148132; 
 Tue, 03 Nov 2020 01:19:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW+y8aL5Yy7BordVoH6KineXkrRj2/5SaT1tXUloa5g52MZPFlpVYSg+PtD/hOBLER8r2GSw==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr24955314wrn.68.1604395147932; 
 Tue, 03 Nov 2020 01:19:07 -0800 (PST)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id e7sm25755423wrm.6.2020.11.03.01.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 01:19:07 -0800 (PST)
Date: Tue, 3 Nov 2020 10:19:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v2] hw/virtio/vhost-backend: Fix Coverity CID
 1432871
Message-ID: <20201103091905.uibhqskpq54epzgq@steredhat>
References: <20201103063541.2463363-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103063541.2463363-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 07:35:41AM +0100, Philippe Mathieu-Daudé wrote:
>Fix uninitialized value issues reported by Coverity:
>
>  Field 'msg.reserved' is uninitialized when calling write().
>
>While the 'struct vhost_msg' does not have a 'reserved' field,
>we still initialize it to have the two parts of the function
>consistent.
>
>Reported-by: Coverity (CID 1432864: UNINIT)
>Fixes: c471ad0e9bd ("vhost_net: device IOTLB support")
>Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>---
>v2: comment 'struct vhost_msg' is also initialized (Peter)
>---
> hw/virtio/vhost-backend.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
>index 88c8ecc9e03..222bbcc62de 100644
>--- a/hw/virtio/vhost-backend.c
>+++ b/hw/virtio/vhost-backend.c
>@@ -257,7 +257,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
>                                               struct vhost_iotlb_msg *imsg)
> {
>     if (dev->backend_cap & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
>-        struct vhost_msg_v2 msg;
>+        struct vhost_msg_v2 msg = {};
>
>         msg.type = VHOST_IOTLB_MSG_V2;
>         msg.iotlb = *imsg;
>@@ -267,7 +267,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
>             return -EFAULT;
>         }
>     } else {
>-        struct vhost_msg msg;
>+        struct vhost_msg msg = {};
>
>         msg.type = VHOST_IOTLB_MSG;
>         msg.iotlb = *imsg;
>-- 
>2.26.2
>
>


