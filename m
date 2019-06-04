Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5002DC28CC6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6A82075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6A82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYB94-0000VO-CT
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 11:14:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYB7W-00082Q-7s
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYB7V-0007Ap-2T
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYB7U-0007AF-TJ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DAC3C18B2E1
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 15:12:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F7405B683;
	Tue,  4 Jun 2019 15:12:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CF38D11386A3; Tue,  4 Jun 2019 17:12:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 17:12:50 +0200
Message-Id: <20190604151251.9903-2-armbru@redhat.com>
In-Reply-To: <20190604151251.9903-1-armbru@redhat.com>
References: <20190604151251.9903-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 04 Jun 2019 15:12:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] vl: Fix -drive / -blockdev persistent
 reservation management
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-system-FOO's main() acts on command line arguments in its own
idiosyncratic order.  There's not much method to its madness.
Whenever we find a case where one kind of command line argument needs
to refer to something created for another kind later, we rejigger the
order.

Recent commit cda4aa9a5a "vl: Create block backends before setting
machine properties" was such a rejigger.  Block backends are now
created before "delayed" objects.  This broke persistent reservation
management.  Reproducer:

    $ qemu-system-x86_64 -object pr-manager-helper,id=3Dpr-helper0,path=3D=
/tmp/pr-helper0.sock-drive -drive file=3D/dev/mapper/crypt,file.pr-manage=
r=3Dpr-helper0,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-2
    qemu-system-x86_64: -drive file=3D/dev/mapper/crypt,file.pr-manager=3D=
pr-helper0,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-2: No persistent r=
eservation manager with id 'pr-helper0'

The delayed pr-manager-helper object is created too late for use by
-drive or -blockdev.  Normal objects are still created in time.

pr-manager-helper has always been a delayed object (commit 7c9e527659
"scsi, file-posix: add support for persistent reservation
management").  Turns out there's no real reason for that.  Make it a
normal object.

Fixes: cda4aa9a5a08777cf13e164c0543bd4888b8adce
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index f023a8ca73..cc6246d2af 100644
--- a/vl.c
+++ b/vl.c
@@ -2751,8 +2751,7 @@ static bool object_create_initial(const char *type,=
 QemuOpts *opts)
         exit(0);
     }
=20
-    if (g_str_equal(type, "rng-egd") ||
-        g_str_has_prefix(type, "pr-manager-")) {
+    if (g_str_equal(type, "rng-egd")) {
         return false;
     }
=20
--=20
2.21.0


