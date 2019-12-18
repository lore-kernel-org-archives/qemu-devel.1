Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D3C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5BC21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/4UWRAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5BC21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUt3-0004OE-NA
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWZ-00065m-AQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWV-0002Xz-9B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWU-0002Si-Ff
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyIy4BntFzipe+4nd+JmLMonvAUYfdAc7REZjExBXTE=;
 b=c/4UWRAwgFMskPcu/TkdiF2ET0oISp2Mc+OWYC8G4qwEUBqHz/ulhKA9jHMh/Mw7LXreNx
 AUTjmXbrYbVeQEjgFyPPAfAWoWhLMhF9+Jcb8js9oD3wXlbb7TZMJ8EtBLBOg+eZGE9GP3
 X9Zd6UeFxdv3gLwgnUBz/sQ+qasGSBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-V1JQd9kmNvuTVO8TyCq4ow-1; Wed, 18 Dec 2019 03:17:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E3C0801E6D;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D1E620D6;
 Wed, 18 Dec 2019 08:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C2971138408; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/35] net/net: Clean up variable shadowing in
 net_client_init()
Date: Wed, 18 Dec 2019 09:17:01 +0100
Message-Id: <20191218081721.23520-16-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: V1JQd9kmNvuTVO8TyCq4ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Variable int err in inner scope shadows Error *err in outer scope.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191205174635.18758-3-vsementsov@virtuozzo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/net.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/net.c b/net/net.c
index 84aa6d8d00..9e93c3f8a1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1126,16 +1126,13 @@ static int net_client_init(QemuOpts *opts, bool is_=
netdev, Error **errp)
=20
             prefix_addr =3D substrings[0];
=20
-            if (substrings[1]) {
-                /* User-specified prefix length.  */
-                int err;
-
-                err =3D qemu_strtoul(substrings[1], NULL, 10, &prefix_len)=
;
-                if (err) {
-                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                               "ipv6-prefixlen", "a number");
-                    goto out;
-                }
+            /* Handle user-specified prefix length. */
+            if (substrings[1] &&
+                qemu_strtoul(substrings[1], NULL, 10, &prefix_len))
+            {
+                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                           "ipv6-prefixlen", "a number");
+                goto out;
             }
=20
             qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abort);
--=20
2.21.0


