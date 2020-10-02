Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80383C47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E0A20665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK2xnstd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E0A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKBC-0002dX-4i
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvA-0004ED-KD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJuz-0003Rr-HG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIBGYoiGqV9u2JbSxHXBCyqZdISVN7OjqQg6e5/mb/E=;
 b=JK2xnstdLzc1CNpl7OLCOTXhnTWeWe3lMy8upkscU9umB/XvrPy+1we+vzQcvtym67BN9d
 7lJqsmNcEknMEEBK3Hr8U+H9hTPniwjKS8eNmoxRDGVLoPknmtiN1xCAIiJTuL0o5NlAXC
 +TV1M1FHgYizRbDz+i1RIowdK4BSFsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-DDTXcJbWN8en3tdvbsfVNQ-1; Fri, 02 Oct 2020 08:12:01 -0400
X-MC-Unique: DDTXcJbWN8en3tdvbsfVNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A941DDFB;
 Fri,  2 Oct 2020 12:11:59 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5619D55770;
 Fri,  2 Oct 2020 12:11:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/19] vfio-ccw: plug memory leak while getting region info
Date: Fri,  2 Oct 2020 14:11:09 +0200
Message-Id: <20201002121118.180315-11-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vfio_get_dev_region_info() unconditionally allocates memory
for a passed-in vfio_region_info structure (and does not re-use
an already allocated structure). Therefore, we have to free
the structure we pass to that function in vfio_ccw_get_region()
for every region we successfully obtained information for.

Fixes: 8fadea24de4e ("vfio-ccw: support async command subregion")
Fixes: 46ea3841edaf ("vfio-ccw: Add support for the schib region")
Fixes: f030532f2ad6 ("vfio-ccw: Add support for the CRW region and IRQ")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200928101701.13540-1-cohuck@redhat.com>
---
 hw/vfio/ccw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ff7f36977994..d2755d7fc5ca 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -491,6 +491,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
+    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -503,6 +504,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
+        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -515,6 +517,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
+        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -528,9 +531,9 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
+        g_free(info);
     }
 
-    g_free(info);
     return;
 
 out_err:
-- 
2.25.4


