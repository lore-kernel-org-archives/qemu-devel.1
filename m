Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC00C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643A8206B6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZIhc1dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643A8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKCv-0001UY-LQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jrKCC-00013f-1Y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:49:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jrKC9-0004se-R6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593776968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0cotN0VkpLeRM9l5/avyjvhdml1532rlSJT8aDU2t5w=;
 b=cZIhc1dkrZnP5r0aFr6pXB4Ow85DGZvzwPI3J0jOzWIrUL/TisqYTL3zoNKqXgAdY0kqZu
 bqk4RVQi2Mg+dcwLC4wpTMYwN8lfSE29YSwzBGl2n2z/xc2+imk9TS6CpA1Xye3sCoiexy
 6Whn8bHBVl9ylEQQhreEYudRFWBxIMA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-WbJj_JAMPbaQFF3eT4wY3A-1; Fri, 03 Jul 2020 07:48:17 -0400
X-MC-Unique: WbJj_JAMPbaQFF3eT4wY3A-1
Received: by mail-wr1-f71.google.com with SMTP id a18so31348200wrm.14
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 04:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0cotN0VkpLeRM9l5/avyjvhdml1532rlSJT8aDU2t5w=;
 b=WJzE8I6QFfbPD5mVx0JER4ARBWghqVLy17MZsPriTr06W9UtC4yeQAjZ9L4GPz63wl
 osVjbEv51QheVxG03fSepv1zmVFQJKNCR4C8mOiYHGO4w3aK1cCGJ5NV2s1PTAioVQel
 dtOPX/WPglgt8EBeBNTz/+2hie2hkbYnadiwooV/RDr/BUbXIWgEIc0gfFsWINtihXKb
 DVUYztCw3Pcy4wG6jsvKfi8ttzi82L6OIgx9aasJ8WBsq/CkRzwm/13PCLIUhk4c2oZW
 cVWBR3VDXdxZQoB8exfhDC87S5+4X9DtF5Htp8all8yCdVclMtWgoNZTB5ZdMyN0rsqS
 O20Q==
X-Gm-Message-State: AOAM533tkVpqlckyOU/RaKDo9EGkF1/TR82uMVrm/4w+huHeGuXKr2ty
 nwVSCmHKZ156UjEXhEnghm91Cn6dmSynvmYaFHkkrPggYV20UtbO+/008e8bVOcfh2VR8NcXrfT
 IfdPcs4VGeNWloX4=
X-Received: by 2002:a5d:63ce:: with SMTP id c14mr38847033wrw.254.1593776895815; 
 Fri, 03 Jul 2020 04:48:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxouBZ96Lekv7rFvMlcSvxWVAA3/3WbEuw9Gp4kX3Frs+zROIWAIOURA9CPTKATaNeJW/JWTQ==
X-Received: by 2002:a5d:63ce:: with SMTP id c14mr38847017wrw.254.1593776895532; 
 Fri, 03 Jul 2020 04:48:15 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id v11sm50237532wmb.3.2020.07.03.04.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 04:48:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-net: fix removal of failover device
Date: Fri,  3 Jul 2020 13:48:13 +0200
Message-Id: <20200703114813.5911-1-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you have a networking device and its virtio failover device, and
you remove them in this order:
- virtio device
- the real device

You get qemu crash.
See bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1820120

Bug exist on qemu 4.2 and 5.0.
But in 5.0 don't shows because commit
77b06bba62034a87cc61a9c8de1309ae3e527d97

somehow papers over it.

CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9bb5578e5d..8d84713df3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3398,6 +3398,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     g_free(n->vlans);
 
     if (n->failover) {
+        device_listener_unregister(&n->primary_listener);
         g_free(n->primary_device_id);
         g_free(n->standby_id);
         qobject_unref(n->primary_device_dict);
-- 
2.25.4


