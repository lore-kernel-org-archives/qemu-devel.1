Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D125DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945EB20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEeQFp6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945EB20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn4o-00047b-QB
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvY-0003Mw-Hw
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvW-0001Pa-Q1
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R6v2kcHm1yafmRwNtVM4TnE2cecweMPkWTwUrJuLZnU=;
 b=BEeQFp6m2Mwhibvc78NDZYkHEfHXdakh3Z2rfyetHCcBAANXukbhs7yRR8qUeY3uea+BM8
 df6E/Xg/yqPvWyVLgk1gZoNQCJ9MAyhH8+HO74qwXgww0/0Ax/6i/5T43K9AdegilIGQcm
 7DbhcIdmcXcTB7hQ30IaqJnGezm6rEE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-OJdS_zpbMqiebHdh4qzHeg-1; Sat, 04 Jul 2020 14:30:12 -0400
X-MC-Unique: OJdS_zpbMqiebHdh4qzHeg-1
Received: by mail-wr1-f69.google.com with SMTP id j3so16767105wrq.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R6v2kcHm1yafmRwNtVM4TnE2cecweMPkWTwUrJuLZnU=;
 b=SiMcQldDAESwDbxgy7xFWYk4d5VZh3Eu+X752liQIJUasPTc6yuKkqJhB7GI/PHUeq
 QHId5I1hwXXtGWehlK6o3XklRWie/wdMc6t4SH35yHFQ+1UfQaf7Tw4GmwFjer6QJ0Iw
 B7znvX2usGhomMXOLp2b3COlm+31zEOc/RtMQJ1TMNcr5mV6loxYA6es6bZEIctsd/2X
 qpkoTlNYrlpqGP8MhnhfL7Y/icKcZq5IxxKOovBca5HhTQAb48YlR1rW3C6/Tq1/3IaX
 otW7bcxQTCAhV8A1FYsdu3KTIp8DZ6x7USa1fxWleABdEFobFC5+pIHwSqVv2JRY9WUr
 agOg==
X-Gm-Message-State: AOAM531pmZjUxmk2Si4kcELhqgZl4zNgdz0Hk8Vhwb1MNGBRhYjhNmgr
 blkH+56unzwIPSjDQO66gmgFzOPH9QMQ4NrTeJjAeDYkErihRx0eMPwgXYONoiW6ybtGll4uvo7
 20JPWh/IS96NR6+s=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr40604532wrt.236.1593887410769; 
 Sat, 04 Jul 2020 11:30:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHmxUIKpDcaoq5etE66Urw6aSaFK2lSf8tdCdx3xGXy7ZwJNrI3iXB5APm3ohfbv/mVc/4aw==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr40604525wrt.236.1593887410631; 
 Sat, 04 Jul 2020 11:30:10 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 l132sm17730967wmf.6.2020.07.04.11.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:10 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 17/41] numa: Handle virtio-mem in NUMA stats
Message-ID: <20200704182750.1088103-18-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Account the memory to the configured nid.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-15-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/numa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 2725886d06..e9aec69afd 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -824,6 +824,7 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
     MemoryDeviceInfoList *info;
     PCDIMMDeviceInfo     *pcdimm_info;
     VirtioPMEMDeviceInfo *vpi;
+    VirtioMEMDeviceInfo *vmi;
 
     for (info = info_list; info; info = info->next) {
         MemoryDeviceInfo *value = info->value;
@@ -844,6 +845,11 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
                 node_mem[0].node_mem += vpi->size;
                 node_mem[0].node_plugged_mem += vpi->size;
                 break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
+                vmi = value->u.virtio_mem.data;
+                node_mem[vmi->node].node_mem += vmi->size;
+                node_mem[vmi->node].node_plugged_mem += vmi->size;
+                break;
             default:
                 g_assert_not_reached();
             }
-- 
MST


