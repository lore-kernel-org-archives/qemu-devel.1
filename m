Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E3C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9EA20700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsTvE5Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9EA20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxbd-0001zr-TL
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXu-0003Yt-Uh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXt-0003kU-5I
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jRxXr-0003ej-NU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id x17so9854953wrt.5
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nB3g7cVPtrxnSwQ59aiunL+jtz+a9s2+uCzKtHmRtTI=;
 b=nsTvE5ZyZuu3I1k9HAA7B9pwcdnOJ/sE8AVqMOrH8tj7NAeKie9DQ2RVZiBBnPC9z1
 /6a3n7Ec1qjabIuk/506FUitWc6Dob0NWw3Zchg/GrvD7/vyfol9yJ3EHZULQ003MLQY
 7AVVw9tAzHsDFy6CQIe6t4vVEVwdkpPvmijfuYTrrlcBdWw0gA1+ZraXJwK2/Nu74xlM
 R9Kj3TPyhNHuCFndAxbSrada3f6VuZ8bukXiNAeHi8+9qs0s/VtaWa5I4K7WGGYgu04Q
 LwkojmRKmQj0BJOKCi8a1UyZt4c1lWtEQUJYmsfOyHhqiJoXKXmx6RA4ZvpvMJxtXAr0
 iO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nB3g7cVPtrxnSwQ59aiunL+jtz+a9s2+uCzKtHmRtTI=;
 b=CjJhz9q3gG7JzZjoBfIUx8t1jw0SbelNP2LsZpiDM+h9Eyer5MfNhqEO8AV/sp6sOd
 qVNOYnTTj9C/TdtmXwbCE83uCLkMiuJZiaLFHc58j2t2uvxCViVHhZ/knXEynk9SrxR9
 yPH+JGBQJcRN/d/e9nLDj00fJV78n1xQ3Lg5HaqV8m+dZ6ikz507f+YsQSjEFU32S+U1
 DTNKV2lVk98VhOBIOWeInF+7OFMxwE2eSfx4wwJZHNBjZU7ee6wu6Nf2ZRnjTgtnWaHF
 P1FgnL870RQmxuXSWWgX2wCTzoG+2dqMmZTfowJoXJ5ZJ3Y5rjUf1KtUIrRbBwry/ACZ
 8mmQ==
X-Gm-Message-State: AGi0PuaAI/B8FA6dtiPYNtdBJAB3eJ6FVvd++5fmsnCPWx+ltHmNzn+U
 its8mnwntbm9xXCmHoii96poQvcimcriCQ==
X-Google-Smtp-Source: APiQypIuBV3jl5c0U5M88i5i8MrhQ/bx3M/7OCP/QCU8aHftjPiJ5y4jqqQiaAedxgfrKYDQHYK76g==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr11060723wrx.339.1587731701922; 
 Fri, 24 Apr 2020 05:35:01 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 91sm8462859wra.37.2020.04.24.05.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 05:35:01 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] vmbus: add vmbus protocol definitions
Date: Fri, 24 Apr 2020 15:34:40 +0300
Message-Id: <20200424123444.3481728-3-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424123444.3481728-1-arilou@gmail.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 pbonzini@redhat.com, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a header with data structures and constants used in Hyper-V VMBus
hypervisor <-> guest interactions.

Based on the respective stuff from Linux kernel.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
---
 include/hw/hyperv/vmbus-proto.h | 222 ++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 include/hw/hyperv/vmbus-proto.h

diff --git a/include/hw/hyperv/vmbus-proto.h b/include/hw/hyperv/vmbus-proto.h
new file mode 100644
index 0000000000..4628d3b323
--- /dev/null
+++ b/include/hw/hyperv/vmbus-proto.h
@@ -0,0 +1,222 @@
+/*
+ * QEMU Hyper-V VMBus support
+ *
+ * Copyright (c) 2017-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_HYPERV_VMBUS_PROTO_H
+#define HW_HYPERV_VMBUS_PROTO_H
+
+#define VMBUS_VERSION_WS2008                    ((0 << 16) | (13))
+#define VMBUS_VERSION_WIN7                      ((1 << 16) | (1))
+#define VMBUS_VERSION_WIN8                      ((2 << 16) | (4))
+#define VMBUS_VERSION_WIN8_1                    ((3 << 16) | (0))
+#define VMBUS_VERSION_WIN10                     ((4 << 16) | (0))
+#define VMBUS_VERSION_INVAL                     -1
+#define VMBUS_VERSION_CURRENT                   VMBUS_VERSION_WIN10
+
+#define VMBUS_MESSAGE_CONNECTION_ID             1
+#define VMBUS_EVENT_CONNECTION_ID               2
+#define VMBUS_MONITOR_CONNECTION_ID             3
+#define VMBUS_SINT                              2
+
+#define VMBUS_MSG_INVALID               0
+#define VMBUS_MSG_OFFERCHANNEL          1
+#define VMBUS_MSG_RESCIND_CHANNELOFFER  2
+#define VMBUS_MSG_REQUESTOFFERS         3
+#define VMBUS_MSG_ALLOFFERS_DELIVERED   4
+#define VMBUS_MSG_OPENCHANNEL           5
+#define VMBUS_MSG_OPENCHANNEL_RESULT    6
+#define VMBUS_MSG_CLOSECHANNEL          7
+#define VMBUS_MSG_GPADL_HEADER          8
+#define VMBUS_MSG_GPADL_BODY            9
+#define VMBUS_MSG_GPADL_CREATED         10
+#define VMBUS_MSG_GPADL_TEARDOWN        11
+#define VMBUS_MSG_GPADL_TORNDOWN        12
+#define VMBUS_MSG_RELID_RELEASED        13
+#define VMBUS_MSG_INITIATE_CONTACT      14
+#define VMBUS_MSG_VERSION_RESPONSE      15
+#define VMBUS_MSG_UNLOAD                16
+#define VMBUS_MSG_UNLOAD_RESPONSE       17
+#define VMBUS_MSG_COUNT                 18
+
+#define VMBUS_MESSAGE_SIZE_ALIGN        sizeof(uint64_t)
+
+#define VMBUS_PACKET_INVALID                    0x0
+#define VMBUS_PACKET_SYNCH                      0x1
+#define VMBUS_PACKET_ADD_XFER_PAGESET           0x2
+#define VMBUS_PACKET_RM_XFER_PAGESET            0x3
+#define VMBUS_PACKET_ESTABLISH_GPADL            0x4
+#define VMBUS_PACKET_TEARDOWN_GPADL             0x5
+#define VMBUS_PACKET_DATA_INBAND                0x6
+#define VMBUS_PACKET_DATA_USING_XFER_PAGES      0x7
+#define VMBUS_PACKET_DATA_USING_GPADL           0x8
+#define VMBUS_PACKET_DATA_USING_GPA_DIRECT      0x9
+#define VMBUS_PACKET_CANCEL_REQUEST             0xa
+#define VMBUS_PACKET_COMP                       0xb
+#define VMBUS_PACKET_DATA_USING_ADDITIONAL_PKT  0xc
+#define VMBUS_PACKET_ADDITIONAL_DATA            0xd
+
+#define VMBUS_CHANNEL_USER_DATA_SIZE            120
+
+#define VMBUS_OFFER_MONITOR_ALLOCATED           0x1
+#define VMBUS_OFFER_INTERRUPT_DEDICATED         0x1
+
+#define VMBUS_RING_BUFFER_FEAT_PENDING_SZ       (1ul << 0)
+
+#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE      0x1
+#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES  0x2
+#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS          0x4
+#define VMBUS_CHANNEL_NAMED_PIPE_MODE                 0x10
+#define VMBUS_CHANNEL_LOOPBACK_OFFER                  0x100
+#define VMBUS_CHANNEL_PARENT_OFFER                    0x200
+#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION  0x400
+#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER            0x2000
+
+#define VMBUS_PACKET_FLAG_REQUEST_COMPLETION    1
+
+typedef struct vmbus_message_header {
+    uint32_t message_type;
+    uint32_t _padding;
+} vmbus_message_header;
+
+typedef struct vmbus_message_initiate_contact {
+    vmbus_message_header header;
+    uint32_t version_requested;
+    uint32_t target_vcpu;
+    uint64_t interrupt_page;
+    uint64_t monitor_page1;
+    uint64_t monitor_page2;
+} vmbus_message_initiate_contact;
+
+typedef struct vmbus_message_version_response {
+    vmbus_message_header header;
+    uint8_t version_supported;
+    uint8_t status;
+} vmbus_message_version_response;
+
+typedef struct vmbus_message_offer_channel {
+    vmbus_message_header header;
+    uint8_t  type_uuid[16];
+    uint8_t  instance_uuid[16];
+    uint64_t _reserved1;
+    uint64_t _reserved2;
+    uint16_t channel_flags;
+    uint16_t mmio_size_mb;
+    uint8_t  user_data[VMBUS_CHANNEL_USER_DATA_SIZE];
+    uint16_t sub_channel_index;
+    uint16_t _reserved3;
+    uint32_t child_relid;
+    uint8_t  monitor_id;
+    uint8_t  monitor_flags;
+    uint16_t interrupt_flags;
+    uint32_t connection_id;
+} vmbus_message_offer_channel;
+
+typedef struct vmbus_message_rescind_channel_offer {
+    vmbus_message_header header;
+    uint32_t child_relid;
+} vmbus_message_rescind_channel_offer;
+
+typedef struct vmbus_gpa_range {
+    uint32_t byte_count;
+    uint32_t byte_offset;
+    uint64_t pfn_array[];
+} vmbus_gpa_range;
+
+typedef struct vmbus_message_gpadl_header {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t gpadl_id;
+    uint16_t range_buflen;
+    uint16_t rangecount;
+    vmbus_gpa_range range[];
+} QEMU_PACKED vmbus_message_gpadl_header;
+
+typedef struct vmbus_message_gpadl_body {
+    vmbus_message_header header;
+    uint32_t message_number;
+    uint32_t gpadl_id;
+    uint64_t pfn_array[];
+} vmbus_message_gpadl_body;
+
+typedef struct vmbus_message_gpadl_created {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t gpadl_id;
+    uint32_t status;
+} vmbus_message_gpadl_created;
+
+typedef struct vmbus_message_gpadl_teardown {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t gpadl_id;
+} vmbus_message_gpadl_teardown;
+
+typedef struct vmbus_message_gpadl_torndown {
+    vmbus_message_header header;
+    uint32_t gpadl_id;
+} vmbus_message_gpadl_torndown;
+
+typedef struct vmbus_message_open_channel {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t open_id;
+    uint32_t ring_buffer_gpadl_id;
+    uint32_t target_vp;
+    uint32_t ring_buffer_offset;
+    uint8_t  user_data[VMBUS_CHANNEL_USER_DATA_SIZE];
+} vmbus_message_open_channel;
+
+typedef struct vmbus_message_open_result {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t open_id;
+    uint32_t status;
+} vmbus_message_open_result;
+
+typedef struct vmbus_message_close_channel {
+    vmbus_message_header header;
+    uint32_t child_relid;
+} vmbus_message_close_channel;
+
+typedef struct vmbus_ring_buffer {
+    uint32_t write_index;
+    uint32_t read_index;
+    uint32_t interrupt_mask;
+    uint32_t pending_send_sz;
+    uint32_t _reserved1[12];
+    uint32_t feature_bits;
+} vmbus_ring_buffer;
+
+typedef struct vmbus_packet_hdr {
+    uint16_t type;
+    uint16_t offset_qwords;
+    uint16_t len_qwords;
+    uint16_t flags;
+    uint64_t transaction_id;
+} vmbus_packet_hdr;
+
+typedef struct vmbus_pkt_gpa_direct {
+    uint32_t _reserved;
+    uint32_t rangecount;
+    vmbus_gpa_range range[];
+} vmbus_pkt_gpa_direct;
+
+typedef struct vmbus_xferpg_range {
+    uint32_t byte_count;
+    uint32_t byte_offset;
+} vmbus_xferpg_range;
+
+typedef struct vmbus_pkt_xferpg {
+    uint16_t buffer_id;
+    uint8_t sender_owns_set;
+    uint8_t _reserved;
+    uint32_t rangecount;
+    vmbus_xferpg_range range[];
+} vmbus_pkt_xferpg;
+
+#endif
-- 
2.24.1


