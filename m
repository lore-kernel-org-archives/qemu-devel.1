Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2DCC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586C020659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N94aifm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586C020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oWH-0001sh-Ge
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oSS-0004Ry-Jt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oSR-0007jc-EF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oSR-0007jY-AS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgzQoCkToAaLJGU81K+sbb7vCdZYQlGr8ipRHTLnR4o=;
 b=N94aifm8xxXoWLnOdkx84MKIx3sqVBMcqbGlSu8Ch9zsJRJ4yVqcv7vS4a30bqmWKbhlPG
 AiNVhyGRAFrVcFwljLwkEVHGHYztYY1bUMwt08O4/RCzrfYbYKCMQAvHM4BZPoev8NJFoo
 GqD4f27eZPCB9EsRQhy6tGHr3X718v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-97MWK5_zPqGW3VSV-RO6Aw-1; Thu, 20 Feb 2020 11:13:41 -0500
X-MC-Unique: 97MWK5_zPqGW3VSV-RO6Aw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15741DB62;
 Thu, 20 Feb 2020 16:13:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 517DA60C87;
 Thu, 20 Feb 2020 16:13:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/18] block: Fix VM size field width in snapshot dump
Date: Thu, 20 Feb 2020 17:07:09 +0100
Message-Id: <20200220160710.533297-18-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When printing the snapshot list (e.g. with qemu-img snapshot -l), the VM
size field is only seven characters wide.  As of de38b5005e9, this is
not necessarily sufficient: We generally print three digits, and this
may require a decimal point.  Also, the unit field grew from something
as plain as "M" to " MiB".  This means that number and unit may take up
eight characters in total; but we also want spaces in front.

Considering previously the maximum width was four characters and the
field width was chosen to be three characters wider, let us adjust the
field width to be eleven now.

Fixes: de38b5005e946aa3714963ea4c501e279e7d3666
Buglink: https://bugs.launchpad.net/qemu/+bug/1859989
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200117105859.241818-2-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 3f09477cc5..afd9f3b4a7 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -664,7 +664,7 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
     char *sizing =3D NULL;
=20
     if (!sn) {
-        qemu_printf("%-10s%-20s%7s%20s%15s",
+        qemu_printf("%-10s%-20s%11s%20s%15s",
                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
     } else {
         ti =3D sn->date_sec;
@@ -679,7 +679,7 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
                  (int)(secs % 60),
                  (int)((sn->vm_clock_nsec / 1000000) % 1000));
         sizing =3D size_to_str(sn->vm_state_size);
-        qemu_printf("%-10s%-20s%7s%20s%15s",
+        qemu_printf("%-10s%-20s%11s%20s%15s",
                     sn->id_str, sn->name,
                     sizing,
                     date_buf,
--=20
2.24.1


