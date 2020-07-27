Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C84C433F2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B14206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RduyVAB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B14206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04DS-0007s2-Mb
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04At-0003KU-OR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Ar-0001Fp-OU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bb6OtX/LD4ZX58mGeq2eGBkZlXvZDtQoKpqNCcHDcU=;
 b=RduyVAB7mw/7dnqvZi73VNmaqAK5WvvTWy2LELl8vIIpyhNF/2QdGBKCEX00VDeXC74qOi
 4zI9UX1VzPupi9exJJbofr2YphJlArVu8YD5ONh8GHk3LEucH8ej9WKdpPZH4bcAwR3YU6
 NFpKVJCe5ybAF8Bqdx27WAf6WZ9sp0A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-Dx5VBl0TOZife9AjLf0bOg-1; Mon, 27 Jul 2020 10:32:15 -0400
X-MC-Unique: Dx5VBl0TOZife9AjLf0bOg-1
Received: by mail-wr1-f71.google.com with SMTP id e14so571507wrr.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2bb6OtX/LD4ZX58mGeq2eGBkZlXvZDtQoKpqNCcHDcU=;
 b=rYfuy8LJYlD8IMWEXzA9B9Mc4dE6plhKK8tgV3mZDLsLZMOyMrTcbDrLT6irYWRME3
 diZiD0jUX7OMmAhs2vV2TtZ1TLVQNPaJsptqcbu4VZEtpopYKj7EapZesB1BBSt9/jTo
 OIbPT0LSzHxP78TOD2GehGPz8fDMxKPH3HVs4iPQkOXin2kfidMC/vNP3/H9wfzwsRJK
 UW7X8igw6iWMEMBsK7IBSKJ4jO5ym1lJs+avksaC5VZlEKR5CjalXeRoMpa8ULc3QPxx
 q0CMc0GQUK7ParjpJIMxhLw0iJWK+zMQpp31nedDA3VXNs0yZWT0QRsbizNcAohrW13K
 nk8A==
X-Gm-Message-State: AOAM533Oj9bdNpy9swdxAYvji+L5CXsf8PDsPWNu382EbhtPiljsSsvf
 Lo5jxDObaSwkgwnvjpCIV9E/2Izle9tWe6aE3fPEuVBfcExxiHCQUtTcdlYEjK2s0XqPcurRmIq
 0tW3oYk8Vpvu6wSY=
X-Received: by 2002:a1c:a756:: with SMTP id q83mr20161364wme.168.1595860333701; 
 Mon, 27 Jul 2020 07:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSzUrpz0v6qmVr2GofypNKloGBrkti1fCXSkbtUlmR3gIbEJ9g7sFB907wvtDwe9V74PM3cw==
X-Received: by 2002:a1c:a756:: with SMTP id q83mr20161349wme.168.1595860333521; 
 Mon, 27 Jul 2020 07:32:13 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id j5sm18383828wmb.15.2020.07.27.07.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:12 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:32:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 3/6] Fix vhost-user buffer over-read on ram hot-unplug
Message-ID: <20200727143104.97776-4-mst@redhat.com>
References: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-stable@nongnu.org, Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS vhost-user protocol
feature introduced a shadow-table, used by the backend to dynamically
determine how a vdev's memory regions have changed since the last
vhost_user_set_mem_table() call. On hot-remove, a memmove() operation
is used to overwrite the removed shadow region descriptor(s). The size
parameter of this memmove was off by 1 such that if a VM with a backend
supporting the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS filled it's
shadow-table (by performing the maximum number of supported hot-add
operatons) and attempted to remove the last region, Qemu would read an
out of bounds value and potentially crash.

This change fixes the memmove() bounds such that this erroneous read can
never happen.

Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
Fixes: f1aeb14b0809 ("Transmit vhost-user memory regions individually")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 31231218dc..d7e2423762 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -672,7 +672,7 @@ static int send_remove_regions(struct vhost_dev *dev,
         memmove(&u->shadow_regions[shadow_reg_idx],
                 &u->shadow_regions[shadow_reg_idx + 1],
                 sizeof(struct vhost_memory_region) *
-                (u->num_shadow_regions - shadow_reg_idx));
+                (u->num_shadow_regions - shadow_reg_idx - 1));
         u->num_shadow_regions--;
     }
 
-- 
MST


