Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D06CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F8421D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atySZt8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F8421D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyni-00059H-0L
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNyag-0005SO-98
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNyae-0007Io-9E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:21:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNyad-0007IR-Vo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572006071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Axo4xQL7qyrmpCyj/sZJm5xfxc1OFpspIWVHDGLjY08=;
 b=atySZt8qB8kSrvkfixHL0SsiSlPBAirlcQKvM56OvWAIOh1cbfRxelAcmeoS2XWVsmnf4W
 kVG9KJyjZqDYa1YIBOYB/F1WJrfZVP9Z6BzUhS4nNEsT2dxbfdrXno54qyvzPLa7XoX77K
 HSC/QAThLshlvQeokyIUh8iUsLqXP/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-t61CRNePMoKdlTeL29aL7w-1; Fri, 25 Oct 2019 08:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 252665E9;
 Fri, 25 Oct 2019 12:21:07 +0000 (UTC)
Received: from localhost (ovpn-117-235.ams2.redhat.com [10.36.117.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9947657A7;
 Fri, 25 Oct 2019 12:20:55 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/11] libqos: tolerate wait-unplug migration state
Date: Fri, 25 Oct 2019 14:19:28 +0200
Message-Id: <20191025121930.6855-10-jfreimann@redhat.com>
In-Reply-To: <20191025121930.6855-1-jfreimann@redhat.com>
References: <20191025121930.6855-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: t61CRNePMoKdlTeL29aL7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/libqos/libqos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index d71557c5cb..f229eb2cb8 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -125,7 +125,8 @@ void migrate(QOSState *from, QOSState *to, const char *=
uri)
             break;
         }
=20
-        if ((strcmp(st, "setup") =3D=3D 0) || (strcmp(st, "active") =3D=3D=
 0)) {
+        if ((strcmp(st, "setup") =3D=3D 0) || (strcmp(st, "active") =3D=3D=
 0)
+            || (strcmp(st, "wait-unplug") =3D=3D 0)) {
             qobject_unref(rsp);
             g_usleep(5000);
             continue;
--=20
2.21.0


