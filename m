Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DBECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F2C2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7k/s3Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F2C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFmK-00048H-Nx
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fziglio@redhat.com>) id 1iNFjN-0002Eg-HS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fziglio@redhat.com>) id 1iNFjM-00007z-HN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:27:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1iNFjM-00007Z-DQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571833630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGzk93WfUIysNZwO3uWZD42RzDLieVYJKoUgml5RCA8=;
 b=K7k/s3Ui+Cu+LeNUV7RBUAgWuFjkMwH5GY5w+EqtqaDcHIpanAXIzL0oKEfXTARwQmHEYk
 Us/7mokuAH01vF5EN7asu9sZ+MvJhYD8fqSh5j6X/ByazBmsYNHDUZhPw/qsw9eyHCqlWT
 GL3ZO2E2O6ulLIjktwF3EerAlAv2Jl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-BKHL_aazPmaA7aF3o3yCHA-1; Wed, 23 Oct 2019 08:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42999801E5C;
 Wed, 23 Oct 2019 12:27:03 +0000 (UTC)
Received: from fziglio.remote.csb (unknown [10.34.247.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36285600CC;
 Wed, 23 Oct 2019 12:26:59 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
Date: Wed, 23 Oct 2019 13:26:52 +0100
Message-Id: <20191023122652.2999-3-fziglio@redhat.com>
In-Reply-To: <20191023122652.2999-1-fziglio@redhat.com>
References: <20191023122652.2999-1-fziglio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BKHL_aazPmaA7aF3o3yCHA-1
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 util/qemu-timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index d428fec567..094a20a05a 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -322,11 +322,7 @@ int qemu_timeout_ns_to_ms(int64_t ns)
     ms =3D DIV_ROUND_UP(ns, SCALE_MS);
=20
     /* To avoid overflow problems, limit this to 2^31, i.e. approx 25 days=
 */
-    if (ms > (int64_t) INT32_MAX) {
-        ms =3D INT32_MAX;
-    }
-
-    return (int) ms;
+    return (int) MIN(ms, (int64_t) INT32_MAX);
 }
=20
=20
--=20
2.21.0


