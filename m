Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B811C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB0A2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsP5/qoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB0A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMXa-00055x-UZ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jGMWQ-0003mV-M6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jGMWP-0000t4-Kq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jGMWP-0000sP-IM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584967777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVE0rc5UgDMuPPGqt/A4H+FWifCqAZzhBTjHm2+rASY=;
 b=SsP5/qoTE1ya/+rqvoAbr7PUii5cZjzZy199Ni9bYthbPFkO7MgP2hrKYlQKbuZjOr8j7y
 v6g7YzjmwC133IP0IlxFJRYdgsfP1uJO+a5WQaCl17j+ACmg+ji7ouv+MHJj+oYSRGRkDs
 eecSaiEWa/GfPaMKADaCbFXXTG+TKHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-smMkgOjrNpKV-4phGIkZcg-1; Mon, 23 Mar 2020 08:49:35 -0400
X-MC-Unique: smMkgOjrNpKV-4phGIkZcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0202B1088380;
 Mon, 23 Mar 2020 12:49:34 +0000 (UTC)
Received: from localhost (ovpn-113-18.ams2.redhat.com [10.36.113.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C67BBBE5;
 Mon, 23 Mar 2020 12:49:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.0 2/2] s390/ipl: fix off-by-one in
 update_machine_ipl_properties()
Date: Mon, 23 Mar 2020 13:49:23 +0100
Message-Id: <20200323124923.24014-3-cohuck@redhat.com>
In-Reply-To: <20200323124923.24014-1-cohuck@redhat.com>
References: <20200323124923.24014-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Halil Pasic <pasic@linux.ibm.com>

In update_machine_ipl_properties() the array ascii_loadparm needs to
hold the 8 char loadparm and a string terminating zero char.

Let's increase the size of ascii_loadparm accordingly.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 0a01e082a428 ("s390/ipl: sync back loadparm")
Fixes: Coverity CID 1421966
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200320143101.41764-1-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b81942e1e6f9..8c3e01957176 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -546,7 +546,7 @@ static void update_machine_ipl_properties(IplParameterB=
lock *iplb)
     /* Sync loadparm */
     if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
         uint8_t *ebcdic_loadparm =3D iplb->loadparm;
-        char ascii_loadparm[8];
+        char ascii_loadparm[9];
         int i;
=20
         for (i =3D 0; i < 8 && ebcdic_loadparm[i]; i++) {
--=20
2.21.1


