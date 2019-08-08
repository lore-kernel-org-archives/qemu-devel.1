Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C6C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E925217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E925217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjXS-0002XA-O8
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57011)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvjWh-00019p-SP
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvjWg-0005rg-HE
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvjWf-0005qz-VV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33BFC316E532;
 Thu,  8 Aug 2019 14:36:20 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470451001956;
 Thu,  8 Aug 2019 14:35:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 16:34:54 +0200
Message-Id: <20190808143457.14111-4-philmd@redhat.com>
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 08 Aug 2019 14:36:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/6] net/filter-rewriter: Use the tcp_header
 structure
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tcp_header structure comes convenient macros to avoid
manipulating the TCP header flags/offset bits manually.
Replace the tcp_hdr structure by the tcp_header equivalent,
and use the TCP_HEADER_FLAGS macro.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 net/filter-rewriter.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 31da08a2f4..62e0de1293 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -73,23 +73,26 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
                                   Connection *conn,
                                   Packet *pkt, ConnectionKey *key)
 {
-    struct tcp_hdr *tcp_pkt;
+    struct tcp_header *tcp_pkt;
+    uint8_t tcp_flags;
+
+    tcp_pkt =3D (struct tcp_header *)pkt->transport_header;
+    tcp_flags =3D TCP_HEADER_FLAGS(tcp_pkt);
=20
-    tcp_pkt =3D (struct tcp_hdr *)pkt->transport_header;
     if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)=
) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_ds=
t),
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
-                    tcp_pkt->th_flags);
+                    tcp_flags);
         trace_colo_filter_rewriter_conn_offset(conn->offset);
     }
=20
-    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_SYN=
)) &&
+    if (((tcp_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_SYN)) &&
         conn->tcp_state =3D=3D TCPS_SYN_SENT) {
         conn->tcp_state =3D TCPS_ESTABLISHED;
     }
=20
-    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_SYN)) {
+    if (((tcp_flags & (TH_ACK | TH_SYN)) =3D=3D TH_SYN)) {
         /*
          * we use this flag update offset func
          * run once in independent tcp connection
@@ -97,7 +100,7 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
         conn->tcp_state =3D TCPS_SYN_RECEIVED;
     }
=20
-    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_ACK)) {
+    if (((tcp_flags & (TH_ACK | TH_SYN)) =3D=3D TH_ACK)) {
         if (conn->tcp_state =3D=3D TCPS_SYN_RECEIVED) {
             /*
              * offset =3D secondary_seq - primary seq
@@ -119,13 +122,13 @@ static int handle_primary_tcp_pkt(RewriterState *rf=
,
          * Passive close step 3
          */
         if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
-            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1))) {
+            (ldl_be_p(&tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1)))=
 {
             conn->tcp_state =3D TCPS_CLOSED;
             g_hash_table_remove(rf->connection_track_table, key);
         }
     }
=20
-    if ((tcp_pkt->th_flags & TH_FIN) =3D=3D TH_FIN) {
+    if ((tcp_flags & TH_FIN) =3D=3D TH_FIN) {
         /*
          * Passive close.
          * Step 1:
@@ -176,20 +179,22 @@ static int handle_secondary_tcp_pkt(RewriterState *=
rf,
                                     Connection *conn,
                                     Packet *pkt, ConnectionKey *key)
 {
-    struct tcp_hdr *tcp_pkt;
+    struct tcp_header *tcp_pkt;
+    uint8_t tcp_flags;
=20
-    tcp_pkt =3D (struct tcp_hdr *)pkt->transport_header;
+    tcp_pkt =3D (struct tcp_header *)pkt->transport_header;
+    tcp_flags =3D TCP_HEADER_FLAGS(tcp_pkt);
=20
     if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)=
) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_ds=
t),
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
-                    tcp_pkt->th_flags);
+                    tcp_flags);
         trace_colo_filter_rewriter_conn_offset(conn->offset);
     }
=20
     if (conn->tcp_state =3D=3D TCPS_SYN_RECEIVED &&
-        ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_SYN=
))) {
+        ((tcp_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_SYN))) {
         /*
          * save offset =3D secondary_seq and then
          * in handle_primary_tcp_pkt make offset
@@ -200,11 +205,11 @@ static int handle_secondary_tcp_pkt(RewriterState *=
rf,
=20
     /* VM active connect */
     if (conn->tcp_state =3D=3D TCPS_CLOSED &&
-        ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_SYN)) {
+        ((tcp_flags & (TH_ACK | TH_SYN)) =3D=3D TH_SYN)) {
         conn->tcp_state =3D TCPS_SYN_SENT;
     }
=20
-    if ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_ACK) {
+    if ((tcp_flags & (TH_ACK | TH_SYN)) =3D=3D TH_ACK) {
         /* Only need to adjust seq while offset is Non-zero */
         if (conn->offset) {
             /* handle packets to the primary from the secondary*/
@@ -219,7 +224,7 @@ static int handle_secondary_tcp_pkt(RewriterState *rf=
,
      * Passive close step 2:
      */
     if (conn->tcp_state =3D=3D TCPS_CLOSE_WAIT &&
-        (tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_FIN)=
) {
+        (tcp_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_FIN)) {
         conn->fin_ack_seq =3D ntohl(tcp_pkt->th_seq);
         conn->tcp_state =3D TCPS_LAST_ACK;
     }
@@ -237,7 +242,7 @@ static int handle_secondary_tcp_pkt(RewriterState *rf=
,
      * CLOSING status.
      */
     if (conn->tcp_state =3D=3D TCPS_ESTABLISHED &&
-        (tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D TH_FIN) {
+        (tcp_flags & (TH_ACK | TH_FIN)) =3D=3D TH_FIN) {
         conn->tcp_state =3D TCPS_FIN_WAIT_1;
     }
=20
--=20
2.20.1


