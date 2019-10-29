Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D033CA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 02:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C020862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 02:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTylI1cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPHRO-0006ZF-RQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 22:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iPHPP-0004jN-Kx
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iPHOW-0002ew-Rg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:38:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iPHOW-0002eb-NV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572316684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mqq0QtQcB1VeeGQg9dyFErPwgJ5qa8fOfYbjpHI7h6o=;
 b=KTylI1cTrlCknpJLNpAJdOU4Mw6TWNp9cm8d1cJkpRPg6kF/7shiUu6LJSF06WYjnodJBx
 i0c7y6Z+/lXW3qw7J3yOHehwtWXTIGQvpQGU/5swM2sv7GtBbHmQWCUK24MPA8xQ/qko+O
 v6kjoQ1jVTltSvont5MXbG+gvg3VQ9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-PSTmyjbXO42rL6AXni4phQ-1; Mon, 28 Oct 2019 22:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 517285E6;
 Tue, 29 Oct 2019 02:37:59 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-230.pek2.redhat.com
 [10.72.12.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 383C219C77;
 Tue, 29 Oct 2019 02:37:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 4/4] COLO-compare: Fix incorrect `if` logic
Date: Tue, 29 Oct 2019 10:37:41 +0800
Message-Id: <1572316661-20043-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1572316661-20043-1-git-send-email-jasowang@redhat.com>
References: <1572316661-20043-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PSTmyjbXO42rL6AXni4phQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, Fan Yang <Fan_Yang@sjtu.edu.cn>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fan Yang <Fan_Yang@sjtu.edu.cn>

'colo_mark_tcp_pkt' should return 'true' when packets are the same, and
'false' otherwise.  However, it returns 'true' when
'colo_compare_packet_payload' returns non-zero while
'colo_compare_packet_payload' is just a 'memcmp'.  The result is that
COLO-compare reports inconsistent TCP packets when they are actually
the same.

Fixes: f449c9e549c ("colo: compare the packet based on the tcp sequence num=
ber")
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7489840..7ee17f2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -319,7 +319,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spk=
t,
     *mark =3D 0;
=20
     if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->s=
eq_end) {
-        if (colo_compare_packet_payload(ppkt, spkt,
+        if (!colo_compare_packet_payload(ppkt, spkt,
                                         ppkt->header_size, spkt->header_si=
ze,
                                         ppkt->payload_size)) {
             *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIM=
ARY;
@@ -329,7 +329,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spk=
t,
=20
     /* one part of secondary packet payload still need to be compared */
     if (!after(ppkt->seq_end, spkt->seq_end)) {
-        if (colo_compare_packet_payload(ppkt, spkt,
+        if (!colo_compare_packet_payload(ppkt, spkt,
                                         ppkt->header_size + ppkt->offset,
                                         spkt->header_size + spkt->offset,
                                         ppkt->payload_size - ppkt->offset)=
) {
@@ -348,7 +348,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spk=
t,
         /* primary packet is longer than secondary packet, compare
          * the same part and mark the primary packet offset
          */
-        if (colo_compare_packet_payload(ppkt, spkt,
+        if (!colo_compare_packet_payload(ppkt, spkt,
                                         ppkt->header_size + ppkt->offset,
                                         spkt->header_size + spkt->offset,
                                         spkt->payload_size - spkt->offset)=
) {
--=20
2.5.0


