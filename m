Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CE9C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A662084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmzbKnQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A662084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sn0-0004WC-KR
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfq-00073V-Vo
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfp-0001HL-R2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfp-0001Gq-NN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUkymaXxsrUBHOeYB4neDB0KIBMTPed4qcRzCegXv08=;
 b=AmzbKnQNTVrnvuhcqL7KOFMYVw0WWtRT3ZmfTuum54KuA/aLYSAz9msJF/r6h0Ka1HGXpl
 EQDKAzpkfi3ACdMq0ATzKfOcIWQHt3XD4MHyy2alL/3NdD75zinrLojxoCzXoHIDFMB+IW
 BDVRQHH05yh1zs2a5dSTHOkTZzDEXdg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-LX2RVNIaMAuUCWZQAd05eQ-1; Wed, 26 Feb 2020 04:08:07 -0500
X-MC-Unique: LX2RVNIaMAuUCWZQAd05eQ-1
Received: by mail-wm1-f70.google.com with SMTP id t17so460191wmi.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XaK3jxvT8IURsZc2FPYAI9xgrRGt+WXCR/pHTLcG0Wc=;
 b=lCYa45pvWXVOHdaNZgohzqZ6WHB/KhEUYLlZKgjma/0VFQ35C9uxpgWWfWYHyfCLUX
 6XrTNwyP7pcug8D4YLLtyH3pe6pUZJJPtZiJiaYM0VW1redOQDUwDEMccl4+s+D3qgC1
 EETR4WaulVnWWxOWvdy7CNlVS91dH06r0M2CI47aCnWkX2+UMdgQVaPp9KGnPo6L3RSM
 H8b5fNcCed4O/MhFxgcr0T1LKu8fRUQLMctRFeAfSueUxR4we4evNY4mEO3oZRCyOg10
 jODQN0enU9fBTAgc20lnO8WW2BaE7ZlqJOUUdNcmVkt6fHKuGqFBvT2EvTTFx6DJjOTZ
 CG0w==
X-Gm-Message-State: APjAAAVR7TuZUILkHM4DabFxJvk1ym3n4uPISscEnJUGYIqqHVvqppz3
 FJIRa2TwP5NyOZ0LOlx6BaVkYLPN+nsjOdrsL/mi6XDe1KJBoLw5xSRbn5EMx/46z7zRImvCpU4
 n/PW7KPyCEvGt/g0=
X-Received: by 2002:a5d:6692:: with SMTP id l18mr4131814wru.382.1582708085971; 
 Wed, 26 Feb 2020 01:08:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7Kus5jBDrlO3hQHqPAF7t7xOAcOIUtLbdY4GW46VQMjiOJ2AGdW81GF0ELPd0gRfTylUF/Q==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr4131790wru.382.1582708085783; 
 Wed, 26 Feb 2020 01:08:05 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 n3sm2356562wrs.8.2020.02.26.01.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:08:04 -0800 (PST)
Date: Wed, 26 Feb 2020 04:08:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/30] Fixed assert in vhost_user_set_mem_table_postcopy
Message-ID: <20200226090010.708934-31-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

The current vhost_user_set_mem_table_postcopy() implementation
populates each region of the VHOST_USER_SET_MEM_TABLE message without
first checking if there are more than VHOST_MEMORY_MAX_NREGIONS already
populated. This can cause memory corruption if too many regions are
added to the message during the postcopy step.

This change moves an existing assert up such that attempting to
construct a VHOST_USER_SET_MEM_TABLE message with too many memory
regions will gracefully bring down qemu instead of corrupting memory.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Message-Id: <1579143426-18305-2-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 35baf4f347..08e7e63790 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -443,6 +443,7 @@ static int vhost_user_set_mem_table_postcopy(struct vho=
st_dev *dev,
                                      &offset);
         fd =3D memory_region_get_fd(mr);
         if (fd > 0) {
+            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
                                                   reg->memory_size,
                                                   reg->guest_phys_addr,
@@ -455,7 +456,6 @@ static int vhost_user_set_mem_table_postcopy(struct vho=
st_dev *dev,
             msg.payload.memory.regions[fd_num].guest_phys_addr =3D
                 reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             fds[fd_num++] =3D fd;
         } else {
             u->region_rb_offset[i] =3D 0;
--=20
MST


