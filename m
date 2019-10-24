Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D37CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57BC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfA6DEcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57BC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNawF-0003xC-Bh
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatG-0000sW-OG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004pT-6b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatC-0004md-6N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEH6dJqIX2o6eSh9nLq+VexyA00m5Ca/Dv9zvsmSO0o=;
 b=SfA6DEcTUyLWrfMVP8eQ0XVfqAEfPcOP4qbmgZCwbzcqQv7dIrc97PCTc5pW6uV34K+so9
 6khj0twruinrTUf1i2G+4wYA78he40POeG0ho+bnxu0UVjY/gi60Ndpd2Z3vw9Mr2+YESK
 KanJvJDW9LjsECQiUMeZv86PxzKHRcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-KLQ0sS5zOeCkDQ1UCIesKA-1; Thu, 24 Oct 2019 07:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80BF81005512;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E27360BF3;
 Thu, 24 Oct 2019 11:02:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 489951132A0B; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/19] qemu-doc: Belatedly document QMP command deprecation
Date: Thu, 24 Oct 2019 13:02:23 +0200
Message-Id: <20191024110237.30963-6-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: KLQ0sS5zOeCkDQ1UCIesKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 24fb413300 "qmp: Introduce blockdev-change-medium" (v2.5.0)
deprecated change.

Commit 2ff3025797 "migrate: move max-bandwidth and downtime-limit to
migrate_set_parameter" (v2.8.0) deprecated migrate_set_downtime and
migrate_set_speed.

These wre missed in commit eb22aeca65 "docs: document deprecation
policy & deprecated features in appendix" (v2.10.0).

Commit 73af8dd8d7 "migration: Make xbzrle_cache_size a migration
parameter" (v2.11.0) deprecated migrate-set-cache-size and
query-migrate-cache-size, but neglected to update qemu-doc.

Make up for that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-deprecated.texi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 7239e0959d..f727bd3932 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -149,6 +149,18 @@ QEMU 4.1 has three options, please migrate to one of t=
hese three:
=20
 @section QEMU Machine Protocol (QMP) commands
=20
+@subsection change (since 2.5.0)
+
+Use ``blockdev-change-medium'' or ``change-vnc-password'' instead.
+
+@subsection migrate_set_downtime and migrate_set_speed (since 2.8.0)
+
+Use ``migrate-set-parameters'' instead.
+
+@subsection migrate-set-cache-size and query-migrate-cache-size (since 2.1=
1.0)
+
+Use ``migrate-set-parameters'' and ``query-migrate-parameters'' instead.
+
 @subsection query-block result field dirty-bitmaps[i].status (since 4.0)
=20
 The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
--=20
2.21.0


