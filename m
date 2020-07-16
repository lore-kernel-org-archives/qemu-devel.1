Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB83C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0CC206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="GojVBUcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0CC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvz8C-0002ez-NK
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jvz6D-0007no-AA
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:18:37 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43114 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jvz6B-0008R3-22
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:18:36 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 1BEC44C90A;
 Thu, 16 Jul 2020 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1594887511; x=1596701912; bh=a/hw31nyqTa1gAAqwWlH/JwEKLobmydqIiw
 vsM6UCNo=; b=GojVBUcYoFOr+BibDf9RGhqXtXod0PH8XJcgmtL2IJLeK+oji81
 eSKu+KNyxotlrZe5bg6GgAxxzo6LjnWLkeknJsixYSqiUmbO6MWD0sBXvS+92wUK
 HSjy+stFc1TABAJQ6WecJ/Rs47Y2jGldt4hjCAh8d0I5yd5QK15U2dYg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EWxpkDAFqnvN; Thu, 16 Jul 2020 11:18:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 0099C4C905;
 Thu, 16 Jul 2020 11:18:30 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 16
 Jul 2020 11:18:30 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] net/colo: Match is-enabled probe to tracepoint
Date: Thu, 16 Jul 2020 11:17:54 +0300
Message-ID: <20200716081754.22422-5-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200716081754.22422-1-r.bolshakov@yadro.com>
References: <20200716081754.22422-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:18:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhang Chen <chen.zhang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build of QEMU with dtrace fails on macOS:

  LINK    x86_64-softmmu/qemu-system-x86_64
error: probe colo_compare_miscompare doesn't exist
error: Could not register probes
ld: error creating dtrace DOF section for architecture x86_64

The reason of the error is explained by Adam Leventhal [1]:

  Note that is-enabled probes don't have the stability magic so I'm not
  sure how things would work if only is-enabled probes were used.

net/colo code uses is-enabled probes to determine if other probes should
be used but colo_compare_miscompare itself is not used explicitly.
Linker doesn't include the symbol and build fails.

The issue can be resolved if is-enabled probe matches the actual trace
point that is used inside the test.

1. http://markmail.org/message/6grq2ygr5nwdwsnb

Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet comparison")
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 net/colo-compare.c    | 12 +++++++-----
 net/filter-rewriter.c |  8 ++++++--
 net/trace-events      |  2 --
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 398b7546ff..9525ed703b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -327,7 +327,7 @@ static int colo_compare_packet_payload(Packet *ppkt,
                                        uint16_t len)
 
 {
-    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
+    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
         strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
@@ -492,7 +492,7 @@ sec:
         g_queue_push_head(&conn->primary_list, ppkt);
         g_queue_push_head(&conn->secondary_list, spkt);
 
-        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_TCP_INFO)) {
             qemu_hexdump((char *)ppkt->data, stderr,
                         "colo-compare ppkt", ppkt->size);
             qemu_hexdump((char *)spkt->data, stderr,
@@ -533,7 +533,8 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
                                     ppkt->size - offset)) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
         trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
-        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        if (trace_event_get_state_backends(
+              TRACE_COLO_COMPARE_UDP_MISCOMPARE)) {
             qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
                          ppkt->size);
             qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
@@ -576,7 +577,8 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
                                            ppkt->size);
         trace_colo_compare_icmp_miscompare("Secondary pkt size",
                                            spkt->size);
-        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        if (trace_event_get_state_backends(
+              TRACE_COLO_COMPARE_ICMP_MISCOMPARE)) {
             qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
                          ppkt->size);
             qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
@@ -597,7 +599,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
     uint16_t offset = ppkt->vnet_hdr_len;
 
     trace_colo_compare_main("compare other");
-    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
+    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
         strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 1aaad101b6..ff04165cc4 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -76,7 +76,9 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
     struct tcp_hdr *tcp_pkt;
 
     tcp_pkt = (struct tcp_hdr *)pkt->transport_header;
-    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
+    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_PKT_INFO) ||
+        trace_event_get_state_backends(
+          TRACE_COLO_FILTER_REWRITER_CONN_OFFSET)) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
@@ -180,7 +182,9 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
 
     tcp_pkt = (struct tcp_hdr *)pkt->transport_header;
 
-    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
+    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_PKT_INFO) ||
+        trace_event_get_state_backends(
+          TRACE_COLO_FILTER_REWRITER_CONN_OFFSET)) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
diff --git a/net/trace-events b/net/trace-events
index fa49c71533..bfaff7891d 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -17,10 +17,8 @@ colo_compare_udp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
-colo_compare_miscompare(void) ""
 colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d pdlen= %d offset= %d flags=%d"
 
 # filter-rewriter.c
-colo_filter_rewriter_debug(void) ""
 colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=0x%x"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
-- 
2.26.1


