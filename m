Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFD920767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgKTv6r9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFD920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfBp-0002Xy-KS
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfB4-0001Vs-0V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kCfB2-0005v1-Ch
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nGjmJH/3NbHPzzFzN8AJV+tMt3zsZYmZtsBmylGI+hc=;
 b=DgKTv6r9x5vwv0LKVCOIx+HEkegJXbPjNmwaNe37zpfN5iJVl8o2NF94uQvR/i8fIQdWRL
 vD5QIFcNtRZHi7q+8XqikKgeyeZeqXr0TG559Qv0MKQi/Oc4MORRIFdgu2mtp0vj0ikEWd
 IsbdZWandqFx6VDB0/KF5CTlbD/J8oY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-MZGW5lj8OKKdIPqt15G-9g-1; Mon, 31 Aug 2020 04:28:29 -0400
X-MC-Unique: MZGW5lj8OKKdIPqt15G-9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A5BA10ABDA4;
 Mon, 31 Aug 2020 08:28:28 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-88.pek2.redhat.com [10.72.12.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A86295D9D3;
 Mon, 31 Aug 2020 08:28:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/9] vhost-vdpa: mandate vhostdev
Date: Mon, 31 Aug 2020 16:27:30 +0800
Message-Id: <20200831082737.10983-3-jasowang@redhat.com>
In-Reply-To: <20200831082737.10983-1-jasowang@redhat.com>
References: <20200831082737.10983-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-stable@nongnu.org, lulu@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost-dev is mandatory for vhost-vdpa to be initialized otherwise
net_vhost_vdpa_init will pass an uninitialized pointer to qemu_open()
which will lead a SIGSEV:

#0  0x0000555555c3a640 in strstart (str=str@entry=0x0, val=val@entry=0x555555dbcb65 "/dev/fdset/", ptr=ptr@entry=0x7fffffffdfb8) at ../util/cutils.c:77
#1  0x0000555555c572a7 in qemu_open (name=name@entry=0x0, flags=flags@entry=2) at ../util/osdep.c:294
#2  0x000055555584314a in net_vhost_vdpa_init (device=0x555555c81baa "vhost-vdpa", vhostdev=0x0, name=0x555556396600 "hn0", peer=0x0) at ../net/vhost-vdpa.c:187
#3  0x000055555584314a in net_init_vhost_vdpa (netdev=<optimized out>, name=0x555556396600 "hn0", peer=0x0, errp=<optimized out>) at ../net/vhost-vdpa.c:227
#4  0x000055555587e8c9 in net_client_init1 (netdev=0x555556398790, is_netdev=is_netdev@entry=true, errp=errp@entry=0x7fffffffe290) at ../net/net.c:1008
#5  0x000055555587ecc7 in net_client_init (opts=0x555556192ff0, is_netdev=<optimized out>, errp=0x7fffffffe290) at ../net/net.c:1113
#6  0x0000555555c33082 in qemu_opts_foreach
    (list=<optimized out>, func=func@entry=0x55555587ed50 <net_init_netdev>, opaque=opaque@entry=0x0, errp=errp@entry=0x7fffffffe290) at ../util/qemu-option.c:1172
#7  0x0000555555880057 in net_init_clients (errp=errp@entry=0x7fffffffe290) at ../net/net.c:1494
#8  0x0000555555a7f8e9 in qemu_init (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/vl.c:4250
#9  0x00005555557f26cd in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:49

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bc0e0d2d35..b7221beaa1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -206,7 +206,7 @@ static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **errp)
     }
     if (strcmp(netdev, name) == 0 &&
         !g_str_has_prefix(driver, "virtio-net-")) {
-        error_setg(errp, "vhost-vdpa requires frontend driver virtio-net-*");
+        error_setg(errp, "Vhost-vdpa requires frontend driver virtio-net-*");
         return -1;
     }
     return 0;
@@ -224,5 +224,9 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                           (char *)name, errp)) {
         return -1;
     }
+    if (!opts->has_vhostdev) {
+        error_setg(errp, "vhost-vdpa requires vhostdev to be set");
+        return -1;
+    }
     return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name, opts->vhostdev);
 }
-- 
2.20.1


