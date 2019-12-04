Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BCEC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9482068E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzZgIzKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9482068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icS37-0006HX-Hy
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5a-0007GO-Ee
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5K-0000U2-7Y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5K-00007m-2h
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcQfbWOSujNj2P6dQg61amOzZoiTXvVBDPQOllhUYpQ=;
 b=AzZgIzKa9xKtrjP284tvJgTPZrYYFU5VHoCUIgD7gxBwqHNaaMR1VbUWEFL/3EUG/2eNja
 lw43jOMVJm3PvlW1tdHHPPIAM0VSyxNlYAhaDSW7Ypgg+/yYlgRyGR/aUpWcfTVAGbLsHH
 ztJFEKVRjzBhAjneBscDs3SlY/K8q+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-JAQm_k9SOUSeBuStts26fQ-1; Wed, 04 Dec 2019 04:36:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 277BF107ACC4
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9BA260C63;
 Wed,  4 Dec 2019 09:36:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC27E1135A63; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/18] tests-blockjob: Use error_free_or_abort()
Date: Wed,  4 Dec 2019 10:36:25 +0100
Message-Id: <20191204093625.14836-19-armbru@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JAQm_k9SOUSeBuStts26fQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-blockjob.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index e670a20617..4eeb184caf 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -48,9 +48,8 @@ static BlockJob *mk_job(BlockBackend *blk, const char *id=
,
             g_assert_cmpstr(job->job.id, =3D=3D, blk_name(blk));
         }
     } else {
-        g_assert_nonnull(err);
+        error_free_or_abort(&err);
         g_assert_null(job);
-        error_free(err);
     }
=20
     return job;
--=20
2.21.0


