Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF37C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0CC20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg70C+Ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0CC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9AeK-0004an-V7
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVv-0004N3-9d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVt-00033b-W3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVt-000335-Pu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/UYmOCxGxuVgibBYUMX0KvNJvGmm4H8hzsqVMEI/UA=;
 b=Wg70C+Ch9HFL64BIS5weu3T7sxOUqj7OmhEmpcHJaijYKwNjLIOImj7sdZXQB1GVlrFmz2
 FcBPThJVV/qawYquv6n9r6g8t6JSxMoNHwoT2uic+un+dy+RhCernvOGMs2HcQ14YdNsh1
 2hCxIX7vgxHcVdcORepupG05nsjFz3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-6gIg3OULOzi4R4V0_Q0TgQ-1; Tue, 03 Mar 2020 11:35:11 -0500
X-MC-Unique: 6gIg3OULOzi4R4V0_Q0TgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5510E1005516;
 Tue,  3 Mar 2020 16:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4210591D71;
 Tue,  3 Mar 2020 16:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B88701138611; Tue,  3 Mar 2020 17:35:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/30] docs/devel/qapi-code-gen: Clarify allow-oob
 introspection
Date: Tue,  3 Mar 2020 17:34:38 +0100
Message-Id: <20200303163505.32041-4-armbru@redhat.com>
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mention SchemaInfo variant member "allow-oob" defaults to false.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


