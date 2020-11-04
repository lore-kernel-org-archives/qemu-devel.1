Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE8BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4934B206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBHV/ITG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4934B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNmD-0005Ho-9I
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNj9-0000kY-Td
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNj7-0001x3-Uk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ghKT3iuLd9VX4UT4KJCLl/E2c6yAP84MyPy0077dPys=;
 b=UBHV/ITGGZbZ79gl0aqGPnUtfTmvnWRipU+wMx5NcocpON0HsX78i+1O1s0x+VewzgZE7O
 1Q6nzQHOwQEnamw87YEa+MpG+ASLuAH1WiTS7zUCPENnykQ2VV27+rJlmbUHFfk4M4Gcma
 1E7ql44f4tj169umjEv+fH/kIcppgrI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-VrMxgYn-PEO-vyUiwayFlg-1; Wed, 04 Nov 2020 13:41:43 -0500
X-MC-Unique: VrMxgYn-PEO-vyUiwayFlg-1
Received: by mail-wr1-f72.google.com with SMTP id j13so9674426wrn.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ghKT3iuLd9VX4UT4KJCLl/E2c6yAP84MyPy0077dPys=;
 b=tWwSt5+17kHJsPmlIh6PJpPNxWPzTwPsTs7DaT3fHao30ihheH7R/u71zPBzy6xiCU
 fHdcs5SisODXx+hf8S7p4T4mYAIKXeIKnm3Xy5Epx1Z+vbzpb8CG4p5rdBS5iTB0s0GK
 EDioAKtOfZRc6cyVES31itWLYetE7JDlyaMB9Cc2NNiAEjL1AEMYSrPf/ZFFCUSp+CYk
 zh3p/PaWYXTBrj37jZ9tk95I5XTNnOV24Z7I1wvdaNP+jGpu2PgKja/kizaSxcQb7JC5
 7eNPnIXTGq5je7NWcKKk32U3QBGVINc0s0LuVvgP+gdd3mQURcRJ5x92P/2H04kuHuIk
 cbXQ==
X-Gm-Message-State: AOAM532NeTWI2yUlqYQCzoH3K3Ri6ttdWtuedg3hfKYMlx+Jn8Si3jLs
 bSLpIo4IRP0Tvvm6320StKOpWbPZVel/rX5DJ7kez5kKRdEFkiQJiCXIIYToQBqu0LaBg9i9Hkq
 oDHSU2xBs7UpwakY=
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr35629813wrn.247.1604515302264; 
 Wed, 04 Nov 2020 10:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxc+jwNfmhHFJqp/PTDe9owKAjiynSCwtH2vOTe79Z6+4lgB0tLojWQjlTq0LjTg6+kyVHc+w==
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr35629796wrn.247.1604515302091; 
 Wed, 04 Nov 2020 10:41:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id o63sm3565900wmo.2.2020.11.04.10.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:41 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 08/31] hw/acpi : Don't use '#' flag of printf format
Message-ID: <20201104184040.285057-9-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Kai Deng <dengkai1@huawei.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Xinhao Zhang <zhangxinhao1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Don't use '#' flag of printf format ('%#') in
format strings, use '0x' prefix instead

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Message-Id: <20201103102634.273021-1-zhangxinhao1@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/nvdimm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8f7cc16add..8ad5516142 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -556,7 +556,7 @@ static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
 
     fit = fit_buf->fit;
 
-    nvdimm_debug("Read FIT: offset %#x FIT size %#x Dirty %s.\n",
+    nvdimm_debug("Read FIT: offset 0x%x FIT size 0x%x Dirty %s.\n",
                  read_fit->offset, fit->len, fit_buf->dirty ? "Yes" : "No");
 
     if (read_fit->offset > fit->len) {
@@ -664,7 +664,7 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
     label_size = nvdimm->label_size;
     mxfer = nvdimm_get_max_xfer_label_size();
 
-    nvdimm_debug("label_size %#x, max_xfer %#x.\n", label_size, mxfer);
+    nvdimm_debug("label_size 0x%x, max_xfer 0x%x.\n", label_size, mxfer);
 
     label_size_out.func_ret_status = cpu_to_le32(NVDIMM_DSM_RET_STATUS_SUCCESS);
     label_size_out.label_size = cpu_to_le32(label_size);
@@ -680,19 +680,19 @@ static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
     uint32_t ret = NVDIMM_DSM_RET_STATUS_INVALID;
 
     if (offset + length < offset) {
-        nvdimm_debug("offset %#x + length %#x is overflow.\n", offset,
+        nvdimm_debug("offset 0x%x + length 0x%x is overflow.\n", offset,
                      length);
         return ret;
     }
 
     if (nvdimm->label_size < offset + length) {
-        nvdimm_debug("position %#x is beyond label data (len = %" PRIx64 ").\n",
+        nvdimm_debug("position 0x%x is beyond label data (len = %" PRIx64 ").\n",
                      offset + length, nvdimm->label_size);
         return ret;
     }
 
     if (length > nvdimm_get_max_xfer_label_size()) {
-        nvdimm_debug("length (%#x) is larger than max_xfer (%#x).\n",
+        nvdimm_debug("length (0x%x) is larger than max_xfer (0x%x).\n",
                      length, nvdimm_get_max_xfer_label_size());
         return ret;
     }
@@ -716,7 +716,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     get_label_data->offset = le32_to_cpu(get_label_data->offset);
     get_label_data->length = le32_to_cpu(get_label_data->length);
 
-    nvdimm_debug("Read Label Data: offset %#x length %#x.\n",
+    nvdimm_debug("Read Label Data: offset 0x%x length 0x%x.\n",
                  get_label_data->offset, get_label_data->length);
 
     status = nvdimm_rw_label_data_check(nvdimm, get_label_data->offset,
@@ -755,7 +755,7 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     set_label_data->offset = le32_to_cpu(set_label_data->offset);
     set_label_data->length = le32_to_cpu(set_label_data->length);
 
-    nvdimm_debug("Write Label Data: offset %#x length %#x.\n",
+    nvdimm_debug("Write Label Data: offset 0x%x length 0x%x.\n",
                  set_label_data->offset, set_label_data->length);
 
     status = nvdimm_rw_label_data_check(nvdimm, set_label_data->offset,
@@ -838,7 +838,7 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     NvdimmDsmIn *in;
     hwaddr dsm_mem_addr = val;
 
-    nvdimm_debug("dsm memory address %#" HWADDR_PRIx ".\n", dsm_mem_addr);
+    nvdimm_debug("dsm memory address 0x%" HWADDR_PRIx ".\n", dsm_mem_addr);
 
     /*
      * The DSM memory is mapped to guest address space so an evil guest
@@ -852,11 +852,11 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     in->function = le32_to_cpu(in->function);
     in->handle = le32_to_cpu(in->handle);
 
-    nvdimm_debug("Revision %#x Handler %#x Function %#x.\n", in->revision,
+    nvdimm_debug("Revision 0x%x Handler 0x%x Function 0x%x.\n", in->revision,
                  in->handle, in->function);
 
     if (in->revision != 0x1 /* Currently we only support DSM Spec Rev1. */) {
-        nvdimm_debug("Revision %#x is not supported, expect %#x.\n",
+        nvdimm_debug("Revision 0x%x is not supported, expect 0x%x.\n",
                      in->revision, 0x1);
         nvdimm_dsm_no_payload(NVDIMM_DSM_RET_STATUS_UNSUPPORT, dsm_mem_addr);
         goto exit;
-- 
MST


