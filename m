Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FCC5ACD7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEAA2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGite4Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEAA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJMv-0004ce-66
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJL0-0002o0-MC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJKy-0002BL-Dt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJKy-00024N-84
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XdHAbce1xcaizlcpBIzNQO6ufcEmq5UDCmJOUrsZgk=;
 b=jGite4HjU3NryDCJMWCPrziOnWhEe0RI3lQ3Cn6KIPym4vBRjiS6vZAIK0CUlhPKbjDMJi
 zyAcB4r2VuK2hFWqVhz8qN4D9X/di3cqg8gr4cNSbHUYG4kd5c7oGfes9ESyrfEh3vJDLd
 //d1eMxqA3V3lqnRbZ+qdoD31bV6ilQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-63cQ4by3Oaq2VGZWGcBchg-1; Tue, 17 Mar 2020 17:01:17 -0400
X-MC-Unique: 63cQ4by3Oaq2VGZWGcBchg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A6E107ACCD
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D94F41001B3F;
 Tue, 17 Mar 2020 21:01:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3EBE711366D1; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/30] docs/devel/qapi-code-gen: Clarify allow-oob introspection
Date: Tue, 17 Mar 2020 22:00:49 +0100
Message-Id: <20200317210115.8864-5-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mention SchemaInfo variant member "allow-oob" defaults to false.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200317115459.31821-4-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index e73979e182..3ce03e6efa 100644
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


