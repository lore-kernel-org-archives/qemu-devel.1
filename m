Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AC2C47425
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD44E206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6Wx03Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD44E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK5s-0005xS-VM
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJv6-00044j-VR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJue-0003QQ-Om
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYdTw6wiSsSksPC2d/EHbxhpKPPuEoKsh3T6SHWkH9Y=;
 b=T6Wx03ResrvY1wxOOZXOVY/lTUAAfvvta/w/7ZpgLGMJewQT2Ua9tT5Iz5A38qEx9HfuHD
 JxXiWXgHB4AAII5ERQvqxBcPiXvd//MKqGevrugmVSKJala7a1GpfsYO1w2ir1jdhOYTij
 Jtpf4JX/8UDzocFcTkzyXKFVp6J6RF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-85Li0ZK6NZe6-sOYk-xTIQ-1; Fri, 02 Oct 2020 08:11:42 -0400
X-MC-Unique: 85Li0ZK6NZe6-sOYk-xTIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 085311074647;
 Fri,  2 Oct 2020 12:11:41 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FAF460C05;
 Fri,  2 Oct 2020 12:11:40 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/19] s390/sclp: use cpu offset to locate cpu entries
Date: Fri,  2 Oct 2020 14:11:05 +0200
Message-Id: <20201002121118.180315-7-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Collin Walling <walling@linux.ibm.com>

The start of the CPU entry region in the Read SCP Info response data is
denoted by the offset_cpu field. As such, QEMU needs to begin creating
entries at this address.

This is in preparation for when Read SCP Info inevitably introduces new
bytes that push the start of the CPUEntry field further away.

Read CPU Info is unlikely to ever change, so let's not bother
accounting for the offset there.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20200915194416.107460-6-walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 0d54075309d5..1df67c99bfb9 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -89,6 +89,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int rnsize, rnmax;
     IplParameterBlock *ipib = s390_ipl_get_iplb();
     int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
+    int offset_cpu = offsetof(ReadInfo, entries);
+    CPUEntry *entries_start = (void *)sccb + offset_cpu;
 
     if (be16_to_cpu(sccb->h.length) < required_len) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
@@ -96,9 +98,9 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     }
 
     /* CPU information */
-    prepare_cpu_entries(machine, read_info->entries, &cpu_count);
+    prepare_cpu_entries(machine, entries_start, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
-    read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
+    read_info->offset_cpu = cpu_to_be16(offset_cpu);
     read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
-- 
2.25.4


