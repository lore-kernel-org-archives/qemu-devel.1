Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45565C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 17:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A6E206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpvbLD8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A6E206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipyLq-0003Zk-3z
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 12:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipyAh-0004qI-Oh
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipyAg-0003j6-LP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:34:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipyAg-0003hK-GM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578677646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IK9e0vaf6oFJwdDH1Z3FkKjQHviZuSu3zT8Gr5xF4kk=;
 b=XpvbLD8oCwHGgAWNRe+4aOkn+Ndz6uBb5cTfHTFg0xH2FY7S9gEKYYyYa/gjeJxDBt+m+m
 MkXtfAhtTcSOrAoGpWhzp/JFfEu6Gafjj6wzCOiHKlkRDkFCdox2GFZ1d58vidPOmBawz9
 fL2IHiISLIS791lXhaldmI8VqsiccNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-N9qKbkM6P3-YkKeEKJdSYg-1; Fri, 10 Jan 2020 12:34:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D8731800D6B;
 Fri, 10 Jan 2020 17:33:46 +0000 (UTC)
Received: from secure.mitica (ovpn-116-240.ams2.redhat.com [10.36.116.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B55A419C4F;
 Fri, 10 Jan 2020 17:33:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/28] migration: Fix the re-run check of the migrate-incoming
 command
Date: Fri, 10 Jan 2020 18:31:57 +0100
Message-Id: <20200110173215.3865-11-quintela@redhat.com>
In-Reply-To: <20200110173215.3865-1-quintela@redhat.com>
References: <20200110173215.3865-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: N9qKbkM6P3-YkKeEKJdSYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Darren Kenny <darren.kenny@oracle.com>,
 qemu-arm@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

The current check sets an error but doesn't fail the command.
This may cause a problem if new connection attempt by the same URI
affects the first connection.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index f79d0bf89a..e55edee606 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1784,6 +1784,7 @@ void qmp_migrate_incoming(const char *uri, Error **er=
rp)
     }
     if (!once) {
         error_setg(errp, "The incoming migration has already been started"=
);
+        return;
     }
=20
     qemu_start_incoming_migration(uri, &local_err);
--=20
2.24.1


