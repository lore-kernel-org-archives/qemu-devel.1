Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5913DC35DF1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A1824691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfL4t8Ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A1824691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KR2-0000aj-9h
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7KPh-0007n8-Qk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7KPg-0000Ln-EK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7KPg-0000Lg-Af
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582814719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lqRreKUvlKKr8Mhc4Kmd7XzILfN7OdpZLwZTluyP8R0=;
 b=gfL4t8TaXoqEjJRviegWm9ppecqRjihPQue0SMNKeieEZavVTkCXGeSMgtMSHtYyzPLyPQ
 i/8pmj215T9rHlA7xgY5r6DHsWUlKaXMDoaT0f03lWW/kM1obJmu3/2q5/FuwnU2Zaf1Il
 KvMuzm/2LIyawmtViTaLOJh3+Q/Z+Lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ZtgW8vLKMPae3VGIJ-JETg-1; Thu, 27 Feb 2020 09:45:13 -0500
X-MC-Unique: ZtgW8vLKMPae3VGIJ-JETg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF12FDBA7;
 Thu, 27 Feb 2020 14:45:11 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E5AB8C090;
 Thu, 27 Feb 2020 14:45:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Explicit mention of padding bytes
Date: Thu, 27 Feb 2020 08:45:08 -0600
Message-Id: <20200227144508.1078501-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although we already covered the need for padding bytes with our
changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
relied on the earlier text for implicitly covering 7 padding bytes.
For consistency with other parts of the header, it does not hurt to be
explicit that this version of the header is using padding bytes, and
if we later add other extension fields, we can rework the allocation
of those padding bytes to match those additions.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qcow2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 5597e244746e..193ac7c5c1af 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -209,6 +209,8 @@ version 2.
                     Available compression type values:
                         0: zlib <https://www.zlib.net/>

+          105 - m:  Zero padding to round up the header size to the next
+                    multiple of 8.

 =3D=3D=3D Header padding =3D=3D=3D

--=20
2.25.1


