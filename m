Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF034C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8C820727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikJnUv4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8C820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHsT-0000y8-P4
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBHne-0003Ky-39
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBHnc-0003j1-Ns
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24201
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBHnc-0003gq-JF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583757983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pa8QNbeLcCahskW5w7Cch3+nbAdBehrY2rXYQPR64YA=;
 b=ikJnUv4XieNpfkxpOYKAVtdQpfn3ngCqZuiYrUZuXLcr9jbdcP/Aq6OEeAMgjv8KZiR09e
 w/eyD9J+hC28yFefRXn6R0CTy9gyV3olW2tOnnEL6Xvyy5a9wblvRPtuK+ykMLPjPUEGQs
 xnyuOsUt1zIb8GpqQa9qKO6ztixUXkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-yJ2975WcP_S90FApG6NlaQ-1; Mon, 09 Mar 2020 08:46:21 -0400
X-MC-Unique: yJ2975WcP_S90FApG6NlaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C92F801F75
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 12:46:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A65C28FBE0;
 Mon,  9 Mar 2020 12:46:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3087D11385F4; Mon,  9 Mar 2020 13:46:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] util/osdep: Improve error report by calling
 error_setg_win32()
Date: Mon,  9 Mar 2020 13:46:14 +0100
Message-Id: <20200309124616.4372-3-armbru@redhat.com>
In-Reply-To: <20200309124616.4372-1-armbru@redhat.com>
References: <20200309124616.4372-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Use error_setg_win32() which adds a hint similar to strerror(errno)).

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200228100726.8414-3-philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/osdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index f7d06050f7..4829c07ff6 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -82,8 +82,8 @@ static int qemu_mprotect__osdep(void *addr, size_t size, =
int prot)
     DWORD old_protect;
=20
     if (!VirtualProtect(addr, size, prot, &old_protect)) {
-        error_report("%s: VirtualProtect failed with error code %ld",
-                     __func__, GetLastError());
+        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError());
+        error_report("%s: VirtualProtect failed: %s", __func__, emsg);
         return -1;
     }
     return 0;
--=20
2.21.1


