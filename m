Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1391C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1F42072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4a3UU5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1F42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzFo-0007mq-P0
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jEzDJ-0004Q9-RL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jEzDG-0007Cw-Bl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:44:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jEzDG-0007Cg-8i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584639849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgQ7hSPoIbjC41jhR4qXZ4pIN0aN9ahfStvF6YdUm/8=;
 b=Z4a3UU5ZrkHRvnNZFVtEcDBtbniDgKvQL9PcfuFAJ0slgqOz2iTpCBA1cNYdgEznjiqlwa
 UMAKeIuzaUmruFgPyH68qRiMN0gMM5RFwH1SPy4XDyK9T4u2gVlBG9ptEDpUTZZPA0WgDQ
 J3sKMlnbBoMzkTDdo4AjmDet5YOEQAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-b0Mdtl_WNDmngZ9aVyulnA-1; Thu, 19 Mar 2020 13:44:06 -0400
X-MC-Unique: b0Mdtl_WNDmngZ9aVyulnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0433801E78;
 Thu, 19 Mar 2020 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2590F2657E;
 Thu, 19 Mar 2020 17:43:44 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v5 3/3] net: tulip: flush queued packets post receive
Date: Thu, 19 Mar 2020 23:10:50 +0530
Message-Id: <20200319174050.759794-4-ppandit@redhat.com>
In-Reply-To: <20200319174050.759794-1-ppandit@redhat.com>
References: <20200319174050.759794-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <pangpei.lq@antfin.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Call qemu_flush_queued_packets to flush queued packets once they
are read in tulip_receive().

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/net/tulip.c | 2 ++
 1 file changed, 2 insertions(+)

Update v4: call qemu_flush_queued_packets()
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 757f12c710..8d8c9519e7 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -287,6 +287,8 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)
         tulip_desc_write(s, s->current_rx_desc, &desc);
         tulip_next_rx_descriptor(s, &desc);
     } while (s->rx_frame_len);
+
+    qemu_flush_queued_packets(qemu_get_queue(s->nic));
     return size;
 }
=20
--=20
2.25.1


