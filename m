Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2DFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917FC20663
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyI9kv/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917FC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudMZ-0004Z5-SV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAS-00042G-OS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAR-0006Kd-Be
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAR-0006FX-2x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9llGFG3+z7QcjC+AlX0yI14eva8q16/+ssJR4lGIrM4=;
 b=AyI9kv/WWGBolrfHpnp9hzHEkFH4q4VYzv9KOLoF/osA1mXhGKMCO3CZ1Zm1AGgNJxFsQb
 IAnyjxrfIwJQ1pHeCOKdeusRZ7hH+Y4NyWu201bft3Knhr1CPLIoXmRbECWvZ3LYfP3/eV
 cVZvr8h7N7PJF6/VldlEbMBrJ21jNJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-55iOx3IrMqSo0alGMHw5UQ-1; Thu, 23 Jan 2020 07:00:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D08766F
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A42F8575F;
 Thu, 23 Jan 2020 12:00:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 085/111] virtiofsd: fix incorrect error handling in lo_do_lookup
Date: Thu, 23 Jan 2020 11:58:15 +0000
Message-Id: <20200123115841.138849-86-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 55iOx3IrMqSo0alGMHw5UQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Ren <renzhen@linux.alibaba.com>

Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e8dc5c7320..05b5f898db 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -814,7 +814,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         close(newfd);
         newfd =3D -1;
     } else {
-        saverr =3D ENOMEM;
         inode =3D calloc(1, sizeof(struct lo_inode));
         if (!inode) {
             goto out_err;
--=20
2.24.1


