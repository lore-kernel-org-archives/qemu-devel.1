Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F2C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA6420722
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1UaNQzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA6420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuNP-0002uf-T8
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kDuMe-0001Ym-Ry
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kDuMd-0005cY-8G
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599159218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVyI7uvdPvRx+1RKCkYnkMlTbAG6DGXcgOuqzNcY20I=;
 b=P1UaNQzWQEEG332KarEAwxeaKS5ZnPWjIEMQQhzdy7f38KI61wj+KVFhoBLRuqEi/xDdeF
 FHoHtf6wVwMJWqJO1zD/SZwL/x5VDcFjT/7EgE+VblYWDRb9gaTA/hOkCeeHGC6sKW4Z3w
 41zJYxzrlJaAzcFJMglu6Bft/qnk1Ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-0iZj_lCpM0O1yjtPNldNpQ-1; Thu, 03 Sep 2020 14:53:36 -0400
X-MC-Unique: 0iZj_lCpM0O1yjtPNldNpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F11E8185A0C9
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 18:53:35 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-218.ams2.redhat.com
 [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10896672C6;
 Thu,  3 Sep 2020 18:53:31 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] vhost-vdpa: improve error reporting
Date: Thu,  3 Sep 2020 20:53:27 +0200
Message-Id: <20200903185327.774708-3-lvivier@redhat.com>
In-Reply-To: <20200903185327.774708-1-lvivier@redhat.com>
References: <20200903185327.774708-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use Error framework to report the id of the device and the details of
the error (vhostdev name and errno).

For instance:

 qemu-system-x86_64 ... -netdev vhost-vdpa,id=hostnet1 ...
 hostnet1: Cannot open '/dev/vhost-vdpa-0': No such file or directory

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/vhost-vdpa.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 24103ef241e4..8260902334ae 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -176,7 +176,8 @@ static NetClientInfo net_vhost_vdpa_info = {
 };
 
 static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
-                               const char *name, const char *vhostdev)
+                               const char *name, const char *vhostdev,
+                               Error **errp)
 {
     NetClientState *nc = NULL;
     VhostVDPAState *s;
@@ -189,11 +190,15 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
     s = DO_UPCAST(VhostVDPAState, nc, nc);
     vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
     if (vdpa_device_fd == -1) {
-        return -errno;
+        error_setg_errno(errp, errno, "%s: Cannot open '%s'", name, vhostdev);
+        return -1;
     }
     s->vhost_vdpa.device_fd = vdpa_device_fd;
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
-    assert(s->vhost_net);
+    if (ret == -1) {
+        error_setg(errp, "%s: Cannot add vhost-vdpa '%s'", name, vhostdev);
+        return -1;
+    }
     return ret;
 }
 
@@ -229,5 +234,6 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
     }
     return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                opts->has_vhostdev ?
-                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV);
+                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV,
+                               errp);
 }
-- 
2.26.2


