Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F72C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1363D207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4R63ePP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1363D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHgR-00085V-8p
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcQ-0007v0-C3
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcO-0004Rc-Co
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R6v2kcHm1yafmRwNtVM4TnE2cecweMPkWTwUrJuLZnU=;
 b=h4R63ePPjbotzcZ2zskdZIssEh8I6mm71SS1g8ysQtM01apKarnny8ysgov49zq2LuEavn
 nus0xkiugsTKw17bpsizDMYoYwBi5qtwJNVsUdggmIz2R1tWvViiIoVogqlkzay0B5Eiwy
 9/kyhZW4pZk3WIEVgFSLxKUKLETyNUg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-nzM1CqzNO1i42tSHCTEpnw-1; Fri, 03 Jul 2020 05:04:19 -0400
X-MC-Unique: nzM1CqzNO1i42tSHCTEpnw-1
Received: by mail-wr1-f71.google.com with SMTP id j16so25789364wrw.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R6v2kcHm1yafmRwNtVM4TnE2cecweMPkWTwUrJuLZnU=;
 b=GlUtf9qDTZ0YpElIu9iijzx6M5bFqzbl6Q5/NZhl0YO1Mi0+9JsBfvGszgyKhUosZr
 pkITkOW+pHkhxBMYTKuotsfvJJEGH4BqROR5MZqVzRDziINFxIS+U2kjeOtgvArnEqVS
 gEUNVVx0g5XCqidgI9U5LlitJTt58k29Pt7uywDsEZgTFHg2GT0iTv75Yi9TNmzSw4Z6
 kShwNulTLXVRCY5/YDzBmGGTiOyx5GjR/XMyNtwChpfa+fGF3r3A5LS8oGY28eVeaj1D
 qvbmFDMpj1m21JUsLSuzY5yE8SGBZqSn0pM3hUtVy28LgIfb0fUeGBkumj1rUzRSnUBe
 xbtA==
X-Gm-Message-State: AOAM530ZXcE/jWUwp4YSwNgN/kX0pjOun8je9fUuc0pn1KKI4lYVfu7i
 hT7/BmyK8IzrxN3Sx65JHjbGa72NDKOtbgXDb6c9y3mQGZdPvVU18nLQJqKaEwqdCRg85akiMQN
 sxepnaQK3Tn1KDPA=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr20442951wmo.169.1593767058369; 
 Fri, 03 Jul 2020 02:04:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX13F5rNl5wkLnQF3uIQ7bjHGzLfg2YT9BI2s8cjEPte+6QLIUVG3Wcy4GPdmrHd1g1g/kvA==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr20442937wmo.169.1593767058223; 
 Fri, 03 Jul 2020 02:04:18 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 k14sm13241600wrn.76.2020.07.03.02.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:17 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] numa: Handle virtio-mem in NUMA stats
Message-ID: <20200703090252.368694-18-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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


