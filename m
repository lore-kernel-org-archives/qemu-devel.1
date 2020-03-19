Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF51C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85E620722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3fF04vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85E620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEru2-0003pt-VE
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jErtA-0002VK-AA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jErt9-0005JK-6O
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jErt9-0005IZ-2F
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584611694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgQ7hSPoIbjC41jhR4qXZ4pIN0aN9ahfStvF6YdUm/8=;
 b=Y3fF04vkDv/nPDCnqtjshE3xV5a5SuZH9aRTIzxxqXADfTiy1flhRXn/sRYIeCZbkOvJvG
 w4TpWAtNSCzSbrzPDs/ji90kqKzr/ToJjFGWXZdkP4cKHsQJ2pR/H6isKe4i6Eb6tyNo0b
 4MO2orur5a3zvh4skDf8hrgwNrJ8zFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-ZOFvtklOMGKqewjWh1m4lw-1; Thu, 19 Mar 2020 05:54:52 -0400
X-MC-Unique: ZOFvtklOMGKqewjWh1m4lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DC318C35CE;
 Thu, 19 Mar 2020 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED9A69B901;
 Thu, 19 Mar 2020 09:54:43 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 3/3] net: tulip: flush queued packets post receive
Date: Thu, 19 Mar 2020 15:22:11 +0530
Message-Id: <20200319095211.741445-4-ppandit@redhat.com>
In-Reply-To: <20200319095211.741445-1-ppandit@redhat.com>
References: <20200319095211.741445-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Stefan Hajnoczi <stefanha@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
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


