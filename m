Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A38C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D2F22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="H2w4W3G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D2F22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tfu-0006Xh-8k
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta2-0007hu-Jb
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta1-00067q-KI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:26 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0Ta1-000670-EQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:25 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 266C196F52;
 Wed, 21 Aug 2019 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJqzrWUesMM9moVvWlYjWIG14La+JA2uQqLkOjCIyVA=;
 b=H2w4W3G9ZieSuyLnZQxAd72oBZSjWwOBUYN6mdvj+mEKj8JyV6pOlLTpZAffuhoshRCIhZ
 6lNn7mboUEYqL+WJ3bK4tOrdRZHcYkQohghqAJvJjegT/yi1PvqPcG5fZomBcUdIz8urNB
 84x7scbOPi9UBx6FEMcFkNBp6tztZPk=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:38 +0200
Message-Id: <20190821163341.16309-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJqzrWUesMM9moVvWlYjWIG14La+JA2uQqLkOjCIyVA=;
 b=7wzMrZNzszHcPDuv9AtKGGuU53RzItbuHLWBLkHXqODErecQ3nEpRouB3eBxbLGZByC1s2
 Sl9QwZ3NCB3q38hrA2RmqViYbw+meoVhLHDA7xCqZPY80f2lqwl+VetgX/PIgZrAA6gn7i
 Z4LhA8mNJiz38GtqG8LOQFLwFUYzMjg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405324; a=rsa-sha256; cv=none;
 b=BOufbBvxcdk5EA7O+BvNKUUTL0zxdT/246WtEKDTItcZUI1KFrJApE2KqhBmR/xTk/o5Mr
 oAH1wpN8Pqjs0ENwyglkhSCHvQ2z9NMMBIYAup3aa1ar3ezatGY2pScWKufH+bBsuUnR4q
 +5ua+d2mYTaFAl4jLxwTAZmG/TIPzX0=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 07/10] hw/core/qdev: replace deprecated
 device_legacy_reset when hotplugging device
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the hotplugged device_legacy_reset by device_cold_reset.
Since we're talking hotplug, cold reset seems the proper reset type.

This does change the behavior since the new function propagates
also the reset to eventual child buses. But it should be a bug if
resetting eventual child buses fail.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 85c85822fd..1638bc9f3b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -876,7 +876,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_legacy_reset(dev);
+            device_cold_reset(dev);
         }
         dev->pending_deleted_event =3D false;
=20
--=20
2.22.0


