Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D8C3F2D4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0CC246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsRe4ZwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0CC246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fiU-0006aO-Eo
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fhJ-0003z4-CH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fhI-0003WW-Bk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fhH-0003VM-8L
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9wXbDIJbh+XQKrN8+dstIByeULUyHMNTV2YYVdc9pc=;
 b=HsRe4ZwQdnqI5Mz/JR2xQo5Wd+XuKymLnffg5+wCHO4OrcfTVWtkd8OeIe3Y9fE2Hvb2FU
 suFctsSZ//ApLrd+xmAxEawbNstEnLMlNvVYP0GAQ2MIwO8aoqAZIjASptnOJUZWCTGMpe
 Dhzt3NmlKzdyGaP8Lw3rDpydPil/sOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-zyqYP87hMGiwy104Zy5H1Q-1; Mon, 02 Mar 2020 02:41:00 -0500
X-MC-Unique: zyqYP87hMGiwy104Zy5H1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99C79800D4E;
 Mon,  2 Mar 2020 07:40:59 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC5B360BF3;
 Mon,  2 Mar 2020 07:40:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 08/23] dp8393x: Don't clobber packet checksum
Date: Mon,  2 Mar 2020 15:40:21 +0800
Message-Id: <1583134836-23991-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

A received packet consumes pkt_size bytes in the buffer and the frame
checksum that's appended to it consumes another 4 bytes. The Receive
Buffer Address register takes the former quantity into account but
not the latter. So the next packet written to the buffer overwrites
the frame checksum. Fix this.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 911f59e..6329341 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -818,6 +818,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
     address +=3D rx_len;
     address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                         &checksum, 4);
+    address +=3D 4;
     rx_len +=3D 4;
     s->regs[SONIC_CRBA1] =3D address >> 16;
     s->regs[SONIC_CRBA0] =3D address & 0xffff;
--=20
2.5.0


