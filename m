Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC03C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67242072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqZ8KUu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67242072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPMF-0001a2-QL
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1isPLJ-0000Ph-Ud
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1isPLI-0006B8-Oi
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:59:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1isPLI-0006Ac-LI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579258747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP3i3b+KJ8LF5wKOhIYJtOyv16mfUNIgOXKP1wF/oBk=;
 b=XqZ8KUu8rM8PcGHWEuaIsacH1o/uAA4X7daQ9caCKUeco9c5/1p7Fj2QAD4hz8K3lcALbt
 1BAyBWA7J1hlhGzZQ9rY/tq/cyxVbEQ3mlg8sOuqCFKMM2oK1QVTJmZVslFqdkG9yvzD4Y
 Vf6urQchI09fILKMWpO0ITGKEPYz5Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-M6qQMiC5M9yoeTBrOC2vnA-1; Fri, 17 Jan 2020 05:59:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D4D6BC1A;
 Fri, 17 Jan 2020 10:59:05 +0000 (UTC)
Received: from localhost (ovpn-117-75.ams2.redhat.com [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84C4B5C1D8;
 Fri, 17 Jan 2020 10:59:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] block: Fix VM size field width in snapshot dump
Date: Fri, 17 Jan 2020 11:58:58 +0100
Message-Id: <20200117105859.241818-2-mreitz@redhat.com>
In-Reply-To: <20200117105859.241818-1-mreitz@redhat.com>
References: <20200117105859.241818-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: M6qQMiC5M9yoeTBrOC2vnA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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
---
 block/qapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 9a5d0c9b27..ffa539250d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -657,7 +657,7 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
     char *sizing =3D NULL;
=20
     if (!sn) {
-        qemu_printf("%-10s%-20s%7s%20s%15s",
+        qemu_printf("%-10s%-20s%11s%20s%15s",
                     "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK");
     } else {
         ti =3D sn->date_sec;
@@ -672,7 +672,7 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
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


