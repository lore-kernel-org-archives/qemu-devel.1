Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0174F20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbg5EuNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0174F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMp36-0004d7-Md
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 03:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMp1j-0002iX-6w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMp1i-0005s0-3V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMp1h-0005pP-Ul
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571730980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lnu+O8bz7gJa5hQzmmGc8TgKxI9BbXzl9kBoZ8kZQBE=;
 b=Hbg5EuNcSoPkIxcA+DAAj+BrRcJmleAZxzPfiZK6SIsLAdeWJWolif8QvILDBVqpNVv1cq
 wnXC64JFL5uweyVr5IrQb8S/20PllQ7od5ffR8dChwwQ9FNmDuvSdtH1PGmiHktKvvIglv
 1XvU8MzP392DP0anWo1cOitNmQtiMC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-WbSwAS4MPTqYpTKlW4H-yA-1; Tue, 22 Oct 2019 03:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3175A1800D79
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:56:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3CEC60C4E;
 Tue, 22 Oct 2019 07:56:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C3571132D6D; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] qapi: Eliminate accidental global frontend state
Date: Tue, 22 Oct 2019 09:56:06 +0200
Message-Id: <20191022075615.956-4-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
References: <20191022075615.956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WbSwAS4MPTqYpTKlW4H-yA-1
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

The frontend can't be run more than once due to its global state.
A future commit will want to do that.

The only global frontend state remaining is accidental:
QAPISchemaParser.__init__()'s parameter previously_included=3D[].
Python evaluates the default once, at definition time.  Any
modifications to it are visible in subsequent calls.  Well-known
Python trap.  Change the default to None and replace it by the real
default in the function body.  Use the opportunity to convert
previously_included to a set.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191018074345.24034-4-armbru@redhat.com>
---
 scripts/qapi/common.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 5abab44302..9d5c05f6a1 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -391,8 +391,9 @@ class QAPIDoc(object):
=20
 class QAPISchemaParser(object):
=20
-    def __init__(self, fname, previously_included=3D[], incl_info=3DNone):
-        previously_included.append(os.path.abspath(fname))
+    def __init__(self, fname, previously_included=3DNone, incl_info=3DNone=
):
+        previously_included =3D previously_included or set()
+        previously_included.add(os.path.abspath(fname))
=20
         try:
             if sys.version_info[0] >=3D 3:
--=20
2.21.0


