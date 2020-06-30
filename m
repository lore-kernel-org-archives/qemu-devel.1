Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41FDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32AE2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Utcgm1fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32AE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE6j-0002pY-0f
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE4F-0007Iz-Ne
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE4D-0006QQ-V0
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593515084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Jh5kF+rFa72J9zwOvi/ro9LrJgq9M690I3MFYHPbQo=;
 b=Utcgm1fcz7t0tX/h0MQTHyFGab4qfu6JTsC7bhGg5jDzHe3Nvg40lnryWlLR2saS8ptFOX
 NsPksz0/18hgAN0XkKbPTvyyLaahKQ0+xcEKbERwoE6UmD3uOwd6sh0jBEaWip8rqAPS7T
 WHOYK49qDa4excO6R5GIxxDwv4lEniI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-rggSiahgNA26h0Q7u5ZYyQ-1; Tue, 30 Jun 2020 07:04:43 -0400
X-MC-Unique: rggSiahgNA26h0Q7u5ZYyQ-1
Received: by mail-ed1-f71.google.com with SMTP id 64so16502312edf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Jh5kF+rFa72J9zwOvi/ro9LrJgq9M690I3MFYHPbQo=;
 b=glhECIyLvpOAFCYUMRo9YBnF8LUKDLRHbwRT8VP1HTgvnZU/ZyZoPhVm0ra1UnNIcA
 Nw6GXWlItNnMkWLSQZHueZ8scm4on/M2neBWWizLTQqGdpZT4GDzyT83vUUqBx9mv/XF
 0ZgsPGg05iG1mD/AcmWuoxzPFDnKGWkk6Ff4QF5RhECVbxH23hBorJZNRnixDo1bBhtf
 Q0mqRRKnSXvx0ONYU/9NLJax34MVoiMRkAy9zaV7vDAMsBXobZFvYnX/WrbmkJKDhwnI
 MIS+QJAVGOLNom/SCpBs3d/0GWrWGHSWUPUvwm7xiOH2P3Rw+sraMudzCeMlRGb6/J6o
 Lufg==
X-Gm-Message-State: AOAM5334jlJcKOMc+EebId2C/Bo1v+Gs3uCSl3N72oBOnl1lzV2ohIuE
 lswPo7IKSkG5oVJ05SlRyRLYDj4N+228/Rp7bO9sp4mnCfQ4914HMavLAj3gCcH93rEBmZiF52t
 P3qaHseRAGz0wXbM=
X-Received: by 2002:a17:906:26c3:: with SMTP id
 u3mr17170847ejc.483.1593515081538; 
 Tue, 30 Jun 2020 04:04:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytU3NflAmYOTzg1nG1o/PFFk6FTq86Q5w0prTdzWWJIHjOihbdpI4OCsTZnNvDz+gbXNKsjw==
X-Received: by 2002:a17:906:26c3:: with SMTP id
 u3mr17170836ejc.483.1593515081363; 
 Tue, 30 Jun 2020 04:04:41 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u60sm2513139edc.59.2020.06.30.04.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 04:04:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] hw/block/nvme: Use QEMU_PACKED on hardware/packet
 structures
Date: Tue, 30 Jun 2020 13:04:27 +0200
Message-Id: <20200630110429.19972-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630110429.19972-1-philmd@redhat.com>
References: <20200630110429.19972-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These structures either describe hardware registers, or
commands ('packets') to send to the hardware. To forbid
the compiler to optimize and change fields alignment,
mark the structures as packed.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/block/nvme.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 1720ee1d51..71c5681912 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1,7 +1,7 @@
 #ifndef BLOCK_NVME_H
 #define BLOCK_NVME_H
 
-typedef struct NvmeBar {
+typedef struct QEMU_PACKED NvmeBar {
     uint64_t    cap;
     uint32_t    vs;
     uint32_t    intms;
@@ -377,7 +377,7 @@ enum NvmePmrmscMask {
 #define NVME_PMRMSC_SET_CBA(pmrmsc, val)   \
     (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
 
-typedef struct NvmeCmd {
+typedef struct QEMU_PACKED NvmeCmd {
     uint8_t     opcode;
     uint8_t     fuse;
     uint16_t    cid;
@@ -422,7 +422,7 @@ enum NvmeIoCommands {
     NVME_CMD_DSM                = 0x09,
 };
 
-typedef struct NvmeDeleteQ {
+typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
     uint16_t    cid;
@@ -432,7 +432,7 @@ typedef struct NvmeDeleteQ {
     uint32_t    rsvd11[5];
 } NvmeDeleteQ;
 
-typedef struct NvmeCreateCq {
+typedef struct QEMU_PACKED NvmeCreateCq {
     uint8_t     opcode;
     uint8_t     flags;
     uint16_t    cid;
@@ -449,7 +449,7 @@ typedef struct NvmeCreateCq {
 #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
 #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
 
-typedef struct NvmeCreateSq {
+typedef struct QEMU_PACKED NvmeCreateSq {
     uint8_t     opcode;
     uint8_t     flags;
     uint16_t    cid;
@@ -474,7 +474,7 @@ enum NvmeQueueFlags {
     NVME_Q_PRIO_LOW     = 3,
 };
 
-typedef struct NvmeIdentify {
+typedef struct QEMU_PACKED NvmeIdentify {
     uint8_t     opcode;
     uint8_t     flags;
     uint16_t    cid;
@@ -486,7 +486,7 @@ typedef struct NvmeIdentify {
     uint32_t    rsvd11[5];
 } NvmeIdentify;
 
-typedef struct NvmeRwCmd {
+typedef struct QEMU_PACKED NvmeRwCmd {
     uint8_t     opcode;
     uint8_t     flags;
     uint16_t    cid;
@@ -528,7 +528,7 @@ enum {
     NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
 };
 
-typedef struct NvmeDsmCmd {
+typedef struct QEMU_PACKED NvmeDsmCmd {
     uint8_t     opcode;
     uint8_t     flags;
     uint16_t    cid;
@@ -547,7 +547,7 @@ enum {
     NVME_DSMGMT_AD  = 1 << 2,
 };
 
-typedef struct NvmeDsmRange {
+typedef struct QEMU_PACKED NvmeDsmRange {
     uint32_t    cattr;
     uint32_t    nlb;
     uint64_t    slba;
@@ -569,14 +569,14 @@ enum NvmeAsyncEventRequest {
     NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
 };
 
-typedef struct NvmeAerResult {
+typedef struct QEMU_PACKED NvmeAerResult {
     uint8_t event_type;
     uint8_t event_info;
     uint8_t log_page;
     uint8_t resv;
 } NvmeAerResult;
 
-typedef struct NvmeCqe {
+typedef struct QEMU_PACKED NvmeCqe {
     uint32_t    result;
     uint32_t    rsvd;
     uint16_t    sq_head;
@@ -634,7 +634,7 @@ enum NvmeStatusCodes {
     NVME_NO_COMPLETE            = 0xffff,
 };
 
-typedef struct NvmeFwSlotInfoLog {
+typedef struct QEMU_PACKED NvmeFwSlotInfoLog {
     uint8_t     afi;
     uint8_t     reserved1[7];
     uint8_t     frs1[8];
@@ -647,7 +647,7 @@ typedef struct NvmeFwSlotInfoLog {
     uint8_t     reserved2[448];
 } NvmeFwSlotInfoLog;
 
-typedef struct NvmeErrorLog {
+typedef struct QEMU_PACKED NvmeErrorLog {
     uint64_t    error_count;
     uint16_t    sqid;
     uint16_t    cid;
@@ -659,7 +659,7 @@ typedef struct NvmeErrorLog {
     uint8_t     resv[35];
 } NvmeErrorLog;
 
-typedef struct NvmeSmartLog {
+typedef struct QEMU_PACKED NvmeSmartLog {
     uint8_t     critical_warning;
     uint8_t     temperature[2];
     uint8_t     available_spare;
@@ -693,7 +693,7 @@ enum LogIdentifier {
     NVME_LOG_FW_SLOT_INFO   = 0x03,
 };
 
-typedef struct NvmePSD {
+typedef struct QEMU_PACKED NvmePSD {
     uint16_t    mp;
     uint16_t    reserved;
     uint32_t    enlat;
@@ -713,7 +713,7 @@ enum {
     NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
 };
 
-typedef struct NvmeIdCtrl {
+typedef struct QEMU_PACKED NvmeIdCtrl {
     uint16_t    vid;
     uint16_t    ssvid;
     uint8_t     sn[20];
@@ -807,7 +807,7 @@ enum NvmeFeatureIds {
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
 };
 
-typedef struct NvmeRangeType {
+typedef struct QEMU_PACKED NvmeRangeType {
     uint8_t     type;
     uint8_t     attributes;
     uint8_t     rsvd2[14];
@@ -817,13 +817,13 @@ typedef struct NvmeRangeType {
     uint8_t     rsvd48[16];
 } NvmeRangeType;
 
-typedef struct NvmeLBAF {
+typedef struct QEMU_PACKED NvmeLBAF {
     uint16_t    ms;
     uint8_t     ds;
     uint8_t     rp;
 } NvmeLBAF;
 
-typedef struct NvmeIdNs {
+typedef struct QEMU_PACKED NvmeIdNs {
     uint64_t    nsze;
     uint64_t    ncap;
     uint64_t    nuse;
-- 
2.21.3


