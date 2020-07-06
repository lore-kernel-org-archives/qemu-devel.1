Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829D0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9682053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZEFSUH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9682053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVlU-0004tP-Jp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jsVkp-0004UP-Qw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:22:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jsVkn-0004KD-FU
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594059728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2GXHvxeG0EM7Qb4JzcTnqkqth+vhgL9R3rll0zkfg08=;
 b=BZEFSUH65BrI0Q/zvg9BFSGLYD5dCqvI/RYa2AQEs6zR9w1SZo8hrhd7L+f9ArxZ/lpxGt
 k8L5kEr0aTzRwYt90JKFzox/NM1fz8XMN/zokV+sFAQTEeLGWDfIGJpsTVT531/B8Y51aH
 62Pb6q3+5AzR9Is83zayVco8Wj/OdRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-mK4VejiAN4eafexFkVaezQ-1; Mon, 06 Jul 2020 14:22:06 -0400
X-MC-Unique: mK4VejiAN4eafexFkVaezQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5FEE8005B0
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 18:22:05 +0000 (UTC)
Received: from localhost (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5264C10021B3;
 Mon,  6 Jul 2020 18:21:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] chardev: don't abort on attempt to add duplicated chardev
Date: Mon,  6 Jul 2020 22:21:56 +0400
Message-Id: <20200706182156.334207-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: eric.auger@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a regression from commit
d2623129a7dec1d3041ad1221dda1ca49c667532 ("qom: Drop parameter @errp of
object_property_add() & friends").

(qemu) chardev-add id=null,backend=null
(qemu) chardev-add id=null,backend=null
Unexpected error in object_property_try_add() at /home/elmarco/src/qemu/qom/object.c:1166:
attempt to add duplicate property 'null' to object (type 'container')

That case is currently not covered in the test suite, but will be with
the queued patch "char: fix use-after-free with dup chardev &
reconnect".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index e3051295ac3..876e41bb592 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -998,7 +998,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
     }
 
     if (id) {
-        object_property_add_child(get_chardevs_root(), id, obj);
+        object_property_try_add_child(get_chardevs_root(), id, obj, &local_err);
+        if (local_err) {
+            goto end;
+        }
         object_unref(obj);
     }
 
-- 
2.27.0.90.geebb51ba8c


