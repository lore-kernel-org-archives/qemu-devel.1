Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C90C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9F62067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWMyKKAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9F62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutmW-0003j7-AP
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutle-00021c-8Q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutlc-0006cl-GJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/yD2zU1ff7FhDAxEU3pV5lfrMSjbvYcorTA8NlNopo=;
 b=XWMyKKAGBcMqs2Jy/EXaU5YZ07Z+mU94qYHuia9FaA7r8od1KrpHZdQCUvAixUNlvCGiBE
 cAlspSzisiryB7NeBRPov+E0EEtPAWK3vyh7Sfzi6Os67fPXJ77y/HIjbKUBX5cHuL49tW
 Jn3ojo0zQkY3dtqYOKfEfonqhLsHaY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-5J4X8ZqrP9qjPNN5Ko4n-Q-1; Mon, 13 Jul 2020 04:24:50 -0400
X-MC-Unique: 5J4X8ZqrP9qjPNN5Ko4n-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE24107ACCA
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:24:49 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8030D27DE7C;
 Mon, 13 Jul 2020 08:24:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] chardev: don't abort on attempt to add duplicated chardev
Date: Mon, 13 Jul 2020 12:24:18 +0400
Message-Id: <20200713082424.2947383-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
References: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a regression from commit d2623129a7d ("qom: Drop parameter @errp
of object_property_add() & friends").

(qemu) chardev-add id=null,backend=null
(qemu) chardev-add id=null,backend=null
Unexpected error in object_property_try_add() at /home/elmarco/src/qemu/qom/object.c:1166:
attempt to add duplicate property 'null' to object (type 'container')

That case is currently not covered in the test suite, but will be with
the queued patch "char: fix use-after-free with dup chardev &
reconnect".

Fixes: d2623129a7dec1d3041ad1221dda1ca49c667532
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index e5b43cb4b87..a0626d04d50 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -996,7 +996,11 @@ static Chardev *chardev_new(const char *id, const char *typename,
     }
 
     if (id) {
-        object_property_add_child(get_chardevs_root(), id, obj);
+        object_property_try_add_child(get_chardevs_root(), id, obj,
+                                      &local_err);
+        if (local_err) {
+            goto end;
+        }
         object_unref(obj);
     }
 
-- 
2.27.0.221.ga08a83db2b


