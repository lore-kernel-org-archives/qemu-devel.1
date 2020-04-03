Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A14FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2021D206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJXjceoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2021D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQvB-0007jD-7x
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQuV-0007Cx-M8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQuT-0000Jf-D9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:19:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQuT-0000JD-AL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585937957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NHND7+mScEhgpgEgKhvx6knVFTH7cl7RolzgUKYwi8s=;
 b=HJXjceoyf2jQOeILvqNHIt04bny3TC6rN+ltd0u6Z5fcXRVTfoMTm25+nEdvCW93mN06a6
 fVMjy+EqLgK1nScruRZsdqPOrF5BCAuisNqhp2kGdcRUvDu5LK5qz7X1kcLW8rHXrNhAjF
 SQSgiNbEg2x3HeTitH3gaHsVmd/aAdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-QU4vygijOoSZ2EmLnJdieg-1; Fri, 03 Apr 2020 14:19:10 -0400
X-MC-Unique: QU4vygijOoSZ2EmLnJdieg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBD6D107ACC4;
 Fri,  3 Apr 2020 18:19:09 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F05755C296;
 Fri,  3 Apr 2020 18:19:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0? v2] qcow2: Explicit mention of padding bytes
Date: Fri,  3 Apr 2020 13:19:07 -0500
Message-Id: <20200403181907.878751-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 "open list:qcow2" <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although we already covered the need for padding bytes with our
changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
relied on the rest of the text for implicitly covering 7 padding
bytes.  For consistency with other parts of the header (such as the
header extension format listing padding from n - m, or the snapshot
table entry mentioning variable padding), we might as well call out
the remaining 7 bytes as padding until such time (as any) as they gain
another meaning.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v2: Call out explicit byte range rather than '105 - m' [Max]

Safe for 5.0 as it is just a doc fix, but only if we actually want it.

 docs/interop/qcow2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 640e0eca4000..80728bc2008d 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -210,3 +210,4 @@ version 2.
                     Available compression type values:
                         0: zlib <https://www.zlib.net/>

+        105 - 111:  Padding, leave as zero.

 =3D=3D=3D Header padding =3D=3D=3D

--=20
2.26.0.rc2


