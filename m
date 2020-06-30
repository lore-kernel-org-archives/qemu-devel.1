Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BEA20780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKNovLgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BEA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDgD-00023M-2f
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDeG-0006dW-N6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:37:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31256
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDeE-0002Gu-Tf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkTG7IRqJeN6JuoPScOrScaWci+d/p8pBXmsF88s47c=;
 b=FKNovLgdyGK/Mhm4xJDYHjvvXEoOqxrwsPT1u/hZZEQUUpE5ZvFaxQM/+qoXhW0EsDwJ9F
 pzndnU2Top/DHf56gLhX4YRDldB6oKlw4hPVbJhSQutwpr9viPJogPh9VcwRet57fmRg+8
 aiTLwHwBmtJROlr5kFn7NVKJtCdtvYE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-JiAy2ysDNgemFlI7voqe2A-1; Tue, 30 Jun 2020 06:37:52 -0400
X-MC-Unique: JiAy2ysDNgemFlI7voqe2A-1
Received: by mail-ed1-f71.google.com with SMTP id cn4so12307570edb.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fkTG7IRqJeN6JuoPScOrScaWci+d/p8pBXmsF88s47c=;
 b=VPDF3VB9k7rnjZLLtss5jtPeeYR2DyFBOXwFuIdAuXvSF5OPjzr8Aj7iCWWNDG2605
 umljhYoLulGH6TSvKlyCJVXTS1RAZ26mtChflukMvxzIlPnxdfUTVKKbydpG7K29jwPA
 jeubZOo3ve38GRF3zeHtKMrN0PnIGJBCWk1sEJCEEe/yEfsqMG1cVo+jqexcx5qcxMEv
 3sTBXkFApwLpKFTAlactpTtr1wZSZi1chMGyw+79IkghfTon9SxsSMxjOSYXyfPEXuZt
 210RHWaWwzOtYrHRENskZ7DcrJSg0UUZSv58O+vfook2EXGRmTTWFs0wHaO1HaPA/I4Z
 XD2Q==
X-Gm-Message-State: AOAM5333htgodO9ir07LkXAx4lAomdAOSDa/sXNC7xH54kDefRCoa1Sp
 kG+UWO/WNIXZvJ+mmHJN9eXgad83/ccayJuUk6M2PsIvgfm0x8OumgcCRj5Tbq7CwSMpM2yhs+L
 QYSmueYavPh/ETpE=
X-Received: by 2002:a05:6402:1246:: with SMTP id
 l6mr14572446edw.224.1593513471311; 
 Tue, 30 Jun 2020 03:37:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMFIl2pDOGNN0g4EqTFUBNGH3wWqnwgJIJqtGgwOTn3uK4kVwV164AbFpzoxBwFuokz3Cwsg==
X-Received: by 2002:a05:6402:1246:: with SMTP id
 l6mr14572430edw.224.1593513471162; 
 Tue, 30 Jun 2020 03:37:51 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o21sm1681416eja.37.2020.06.30.03.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:37:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] hw/block/nvme: Use QEMU_PACKED on hardware/packet
 structures
Date: Tue, 30 Jun 2020 12:37:37 +0200
Message-Id: <20200630103739.9715-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630103739.9715-1-philmd@redhat.com>
References: <20200630103739.9715-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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


