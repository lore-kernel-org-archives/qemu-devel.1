Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EC721872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1ehor7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EC721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3Jq-0000tX-M9
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iO2tx-00005C-Fn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iO2tu-0000VK-Pv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:57:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iO2tu-0000Uv-M2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572022641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h/yG7PNfbSfVzHFrNr8vjWtsCg1UiIUcVyErYHjp8sA=;
 b=Y1ehor7EuHPHhfXqCORVZaIM+MoNQs5+cHom3jx3/x3hNemD3vZsdP8xohjsQMTTgfOsBZ
 U5Mb7vy72ZhKbzP0G3g6BX8ntu/4CQjBfyC4SVe1OujMdvudtjd/ze5PnHIfdckT6SnnCh
 lgDqEpMYMPEd813fZ4RF7Gx0OxBeJIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-68CI_uWrO4yfRmJpubpy9w-1; Fri, 25 Oct 2019 12:57:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E66880183E;
 Fri, 25 Oct 2019 16:57:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B066A60C80;
 Fri, 25 Oct 2019 16:57:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, philmd@redhat.com, lersek@redhat.com,
 kraxel@redhat.com
Subject: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
Date: Fri, 25 Oct 2019 17:57:06 +0100
Message-Id: <20191025165706.177653-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 68CI_uWrO4yfRmJpubpy9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: liq3ea@gmail.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
to only allow the range 0..65535; however both qemu and libvirt document
the special value -1  to mean don't reboot.
Allow it again.

Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error checki=
ng")
RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/nvram/fw_cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac378e..1a9ec44232 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
=20
     if (reboot_timeout) {
         rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
+
         /* validate the input */
-        if (rt_val < 0 || rt_val > 0xffff) {
+        if (rt_val < -1 || rt_val > 0xffff) {
             error_report("reboot timeout is invalid,"
-                         "it should be a value between 0 and 65535");
+                         "it should be a value between -1 and 65535");
             exit(1);
         }
     }
--=20
2.23.0


