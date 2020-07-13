Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02074C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47F520738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoJf5t/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47F520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzBc-0006IC-Vm
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAa-0004bm-GO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAW-0006ZD-Gn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ma574VSKhZuu56MlEF6B4gIcqKvOYKPIygT95t5Oglc=;
 b=LoJf5t/vYQCtZwy5Xnd2UCkgUDl5Cd54TC2ToQ5HZehNqnxzQWAA2VLJo1Jcj1W06S29Hp
 fF2FQfm0o7Ur057r6kv6FtSbqBZDhQGNsUxYb6sxQcbhw5dhFLPTIaXlLhAHgHfCe4pd49
 i1BjSixWIjFh+v+6S6lpVg5JjqdoHoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-h-rT5Px4N8yL0HJcdBrtPw-1; Mon, 13 Jul 2020 10:10:54 -0400
X-MC-Unique: h-rT5Px4N8yL0HJcdBrtPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58CA018FF66C
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:10:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1EB85C3E7;
 Mon, 13 Jul 2020 14:10:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 31F563F126; Mon, 13 Jul 2020 16:10:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] ui: fix vc_chr_write call in text_console_do_init
Date: Mon, 13 Jul 2020 16:10:48 +0200
Message-Id: <20200713141049.2241-4-kraxel@redhat.com>
In-Reply-To: <20200713141049.2241-1-kraxel@redhat.com>
References: <20200713141049.2241-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case the string doesn't fit into the buffer snprintf returns the size
it would need, so len can be larger than the buffer.  Fix this by simply
using g_strdup_printf() instead of a static buffer.

Reported-by: Wenxiang Qian <leonwxqian@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200701181801.27935-1-kraxel@redhat.com
---
 ui/console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 08f75c9bf624..0579be792f33 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2184,12 +2184,12 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
     text_console_resize(s);
 
     if (chr->label) {
-        char msg[128];
-        int len;
+        char *msg;
 
         s->t_attrib.bgcol = QEMU_COLOR_BLUE;
-        len = snprintf(msg, sizeof(msg), "%s console\r\n", chr->label);
-        vc_chr_write(chr, (uint8_t *)msg, len);
+        msg = g_strdup_printf("%s console\r\n", chr->label);
+        vc_chr_write(chr, (uint8_t *)msg, strlen(msg));
+        g_free(msg);
         s->t_attrib = s->t_attrib_default;
     }
 
-- 
2.18.4


