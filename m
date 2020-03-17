Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B4C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEB020714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc7/1qtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEB020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEArM-0004Qx-1z
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoN-0007jf-IP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoM-0005La-ER
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoM-0005GN-9b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9aJ6ZhTuZtf5NkualOeUErag8XWQSpDFZwLjlPGywg=;
 b=Lc7/1qtcPBtt5AJc28UybcSbBT9ufhTP2MSYv29pDic17b+JFiDI3zEuXPczPtg9nsO795
 ChOVUVZfvc5H3t6+BHY13MqpMHjcUsvAU0aLXIQp7MveS52L7dgqzf+wH4/cB6Ob6rmI9U
 lM+2dyf+nvGdenGvFN61zkzpd3KGhDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-UIodSZ6_O46d24Vj3q9oHg-1; Tue, 17 Mar 2020 07:55:04 -0400
X-MC-Unique: UIodSZ6_O46d24Vj3q9oHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36B248017DF;
 Tue, 17 Mar 2020 11:55:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73BBC5DE56;
 Tue, 17 Mar 2020 11:55:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 001AC11366CF; Tue, 17 Mar 2020 12:54:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/34] docs/devel/qapi-code-gen: Clarify allow-oob
 introspection
Date: Tue, 17 Mar 2020 12:54:28 +0100
Message-Id: <20200317115459.31821-4-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mention SchemaInfo variant member "allow-oob" defaults to false.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 59d6973e1e..5906602504 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -988,9 +988,9 @@ The SchemaInfo for a command has meta-type "command", a=
nd variant
 members "arg-type", "ret-type" and "allow-oob".  On the wire, the
 "arguments" member of a client's "execute" command must conform to the
 object type named by "arg-type".  The "return" member that the server
-passes in a success response conforms to the type named by
-"ret-type".  When "allow-oob" is set, it means the command supports
-out-of-band execution.
+passes in a success response conforms to the type named by "ret-type".
+When "allow-oob" is true, it means the command supports out-of-band
+execution.  It defaults to false.
=20
 If the command takes no arguments, "arg-type" names an object type
 without members.  Likewise, if the command returns nothing, "ret-type"
--=20
2.21.1


