Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B74C4727D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AC820708
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTHoTE/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AC820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK0m-0000kf-Vr
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJv5-00040e-8R
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJue-0003Q8-Na
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2xhT7syXzz3rk5fFDEFlekGdnSQCQMc7jIOHykHsno=;
 b=bTHoTE/JLBrMXiMUuoKwdG5PB31oKjan0iAZU+6c1kJLctifVNDOQLRDCh6d7fdym1uAPG
 IAfWyUDp5+EW5+OftkoLJ5s47RjUqkdyXWZieDgaxtLk5Rco7c7ELfEQ7q2gBrSeJAGjGw
 0EoJqdKqEI1Cm60w+L1T+sGvwWxiDRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-wAqQJA_1OHKDoZBAqg946g-1; Fri, 02 Oct 2020 08:11:40 -0400
X-MC-Unique: wAqQJA_1OHKDoZBAqg946g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA71F1074644;
 Fri,  2 Oct 2020 12:11:38 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FD8573693;
 Fri,  2 Oct 2020 12:11:35 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/19] s390/sclp: check sccb len before filling in data
Date: Fri,  2 Oct 2020 14:11:04 +0200
Message-Id: <20201002121118.180315-6-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Collin Walling <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Collin Walling <walling@linux.ibm.com>

The SCCB must be checked for a sufficient length before it is filled
with any data. If the length is insufficient, then the SCLP command
is suppressed and the proper response code is set in the SCCB header.

While we're at it, let's cleanup the length check by placing the
calculation inside a macro.

Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20200915194416.107460-5-walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4ae6fb400b40..0d54075309d5 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -78,6 +78,8 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
     }
 }
 
+#define SCCB_REQ_LEN(s, max_cpus) (sizeof(s) + max_cpus * sizeof(CPUEntry))
+
 /* Provide information about the configuration, CPUs and storage */
 static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 {
@@ -86,6 +88,12 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int cpu_count;
     int rnsize, rnmax;
     IplParameterBlock *ipib = s390_ipl_get_iplb();
+    int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
+
+    if (be16_to_cpu(sccb->h.length) < required_len) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
 
     /* CPU information */
     prepare_cpu_entries(machine, read_info->entries, &cpu_count);
@@ -95,12 +103,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
 
-    if (be16_to_cpu(sccb->h.length) <
-            (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        return;
-    }
-
     /* Configuration Characteristic (Extension) */
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR,
                          read_info->conf_char);
@@ -146,18 +148,18 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     MachineState *machine = MACHINE(qdev_get_machine());
     ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
     int cpu_count;
+    int required_len = SCCB_REQ_LEN(ReadCpuInfo, machine->possible_cpus->len);
+
+    if (be16_to_cpu(sccb->h.length) < required_len) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
 
     prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
     cpu_info->nr_configured = cpu_to_be16(cpu_count);
     cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
     cpu_info->nr_standby = cpu_to_be16(0);
 
-    if (be16_to_cpu(sccb->h.length) <
-            (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        return;
-    }
-
     /* The standby offset is 16-byte for each CPU */
     cpu_info->offset_standby = cpu_to_be16(cpu_info->offset_configured
         + cpu_info->nr_configured*sizeof(CPUEntry));
-- 
2.25.4


