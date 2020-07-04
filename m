Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39584C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0909C20772
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM182bj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0909C20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn9n-0005J6-8Z
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvW-0003Hu-23
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvU-0001PD-3V
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iWDsFI9FTPaIYFz+N5tNzGyrP1poUpyqulcQXZoBxbc=;
 b=LM182bj/piyS/4VhY4DULwKxnC53uaD/3lQOyY60F+7BnfIvHJIwT/GjDRNvhAspVKtR5q
 l74Yxsj5gcV79JP8T2DZ1HfBabaLzEpkQ4QoxWXO5JA0PPPOFOEw2NET1umIHGK8Lj9BlM
 JnOwOec6ctbDGrSMb0hedAu2RcZMRZg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-o8_5sEFPM9O1kSKFxiwJ8g-1; Sat, 04 Jul 2020 14:30:09 -0400
X-MC-Unique: o8_5sEFPM9O1kSKFxiwJ8g-1
Received: by mail-wr1-f72.google.com with SMTP id i14so36213788wru.17
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iWDsFI9FTPaIYFz+N5tNzGyrP1poUpyqulcQXZoBxbc=;
 b=WuDF3CKuKRmp1vxDXLfLvctUQvld1nzK4F9ZXBpdvRuEoCUqhpvAOITe39z/BZb2tV
 4o/QuXaa2agpvkyZGGxSSIDHv5KqIUUhenEygGLiiVHpOY0uy4e8X2lC5hjDY+bfKzLW
 Oke1yhj+LMVU20hhz2ruqrs6+MpqBNwTN6gNvfJLDDhScRB7gfOPgtblgCS83jN/g/yP
 +KQ768q3TXqVBLNn7b+BXLnPJuqrtgtaHbEOsNwOwQOJUu+Hm9eVkLgN4dzWDGZ+1it9
 yDo0HDrE+m7mU063/xQZGoJeu/sOxuIedyMhP4hySMqRNrWVJtBNNwOYR/k1nz+pUsyO
 xozQ==
X-Gm-Message-State: AOAM530aM10+7CQTUOvtcrRWuXWsZWZuu9g2YfkzPLZF6dyjZboMOFaM
 Wo4pQ23+2+BjE+5tNzXukY5zV5rE4gDiKUMdu92DONwC0DIsNXBQ3/ktEDTpIlKFzxtGsXG0GGu
 SfW32By71bZcxVBg=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr41524255wrs.365.1593887408055; 
 Sat, 04 Jul 2020 11:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwz4D+oj/8FDX+qX2CEY79GF9mGPebi3j3euQoGNIdhFibF9mYEJq1sQN3S8Q2Qdrw/+F18w==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr41524250wrs.365.1593887407851; 
 Sat, 04 Jul 2020 11:30:07 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b62sm17081843wmh.38.2020.07.04.11.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:07 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/41] hmp: Handle virtio-mem when printing memory device
 info
Message-ID: <20200704182750.1088103-17-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Print the memory device info just like for other memory devices.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-14-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 monitor/hmp-cmds.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 2b0b58a336..2ec13e4cc3 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1821,6 +1821,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
     MemoryDeviceInfoList *info;
     VirtioPMEMDeviceInfo *vpi;
+    VirtioMEMDeviceInfo *vmi;
     MemoryDeviceInfo *value;
     PCDIMMDeviceInfo *di;
 
@@ -1855,6 +1856,21 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                 monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
                 monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
                 break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
+                vmi = value->u.virtio_mem.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               vmi->id ? vmi->id : "");
+                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vmi->memaddr);
+                monitor_printf(mon, "  node: %" PRId64 "\n", vmi->node);
+                monitor_printf(mon, "  requested-size: %" PRIu64 "\n",
+                               vmi->requested_size);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", vmi->size);
+                monitor_printf(mon, "  max-size: %" PRIu64 "\n", vmi->max_size);
+                monitor_printf(mon, "  block-size: %" PRIu64 "\n",
+                               vmi->block_size);
+                monitor_printf(mon, "  memdev: %s\n", vmi->memdev);
+                break;
             default:
                 g_assert_not_reached();
             }
-- 
MST


