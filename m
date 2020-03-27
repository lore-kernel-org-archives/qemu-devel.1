Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A68FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC5620675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsBuIhKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC5620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmzJ-0005gH-FE
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwQ-0000ek-Vy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwP-0001VE-Rb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwP-0001TE-NQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paXF4BUdtUbKk4eCMDfsD2R4BGRN/BEYl8hEBt1HBS4=;
 b=RsBuIhKpkJCtLUWR6vu4Np2umNc9E0rByxtZaGvn0qt+9BBChc4IC9BF0nrX0D6/vp7L86
 ChL3yICp4MAfSc/ty9iqIW98wHax4Wsb8oN3/342bA7ert3673rjz9DsQPJmA0VUX7m7+z
 KQsmnBjaLQM+UumhWDUaWBfTBGrpFc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-ZNI5rlmEN4CVIge7hMCfWA-1; Fri, 27 Mar 2020 07:14:18 -0400
X-MC-Unique: ZNI5rlmEN4CVIge7hMCfWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA1A6800D4E;
 Fri, 27 Mar 2020 11:14:17 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07E475E030;
 Fri, 27 Mar 2020 11:14:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 03/13] Fixed integer overflow in e1000e
Date: Fri, 27 Mar 2020 19:13:57 +0800
Message-Id: <1585307647-24456-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
References: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400
Fixed setting max_queue_num if there are no peers in
NICConf. qemu_new_nic() creates NICState with 1 NetClientState(index
0) without peers, set max_queue_num to 0 - It prevents undefined
behavior and possible crashes, especially during pcie hotplug.

Fixes: 6f3fbe4ed06 ("net: Introduce e1000e device emulation")
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index a91dbdc..f2cc155 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev=
, uint8_t *macaddr)
     s->nic =3D qemu_new_nic(&net_e1000e_info, &s->conf,
         object_get_typename(OBJECT(s)), dev->id, s);
=20
-    s->core.max_queue_num =3D s->conf.peers.queues - 1;
+    s->core.max_queue_num =3D s->conf.peers.queues ? s->conf.peers.queues =
- 1 : 0;
=20
     trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
     memcpy(s->core.permanent_mac, macaddr, sizeof(s->core.permanent_mac));
--=20
2.5.0


