Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37969C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E89222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcHqUyK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E89222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ETr-00039V-7f
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2EQe-0006Vm-LW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2EQd-0007sN-Ju
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2EQd-0007rs-GJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/w/8VtAx2c3iD4K1lyp6dvbtw7YhI3frPIBSSwV6uk=;
 b=bcHqUyK1QvUfPtRqZspDEXqJ2ZJjaFwE2Y1qxzi7lNe+Xy6QPn73lKr4qiL+2RLzWhTZpg
 KZZ2KmGzNweyCvCk767lzeFTQJcS+R1BN44kYQsEAcGO3bUJckwSrt9PSfIR1qkM8+i4nS
 WStEkSGI0HQhKQo/cEehRYAETmSGxEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-c0BUiphbMAWrP8-OiowZFA-1; Thu, 13 Feb 2020 08:21:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7F485B6EF
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:21:12 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59B785C1D8;
 Thu, 13 Feb 2020 13:21:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] git: Make submodule check only needed modules
Date: Thu, 13 Feb 2020 14:20:30 +0100
Message-Id: <20200213132030.57757-7-quintela@redhat.com>
In-Reply-To: <20200213132030.57757-1-quintela@redhat.com>
References: <20200213132030.57757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: c0BUiphbMAWrP8-OiowZFA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If one is compiling more than one tree from the same source, it is
possible that they need different submodules.  Change the check to see
that all modules that we are interested in are updated, discarding the
ones that we don't care about.

Signed-off-by: Juan Quintela <quintela@redhat.com>

---

v1->v2:
patchw insists in not using modules
---
 scripts/git-submodule.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 98ca0f2737..65ed877aef 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -59,10 +59,14 @@ status)
     fi
=20
     test -f "$substat" || exit 1
-    CURSTATUS=3D$($GIT submodule status $modules)
-    OLDSTATUS=3D$(cat $substat)
-    test "$CURSTATUS" =3D "$OLDSTATUS"
-    exit $?
+    for module in $modules; do
+        CURSTATUS=3D$($GIT submodule status $module)
+        OLDSTATUS=3D$(cat $substat | grep $module)
+        if test "$CURSTATUS" !=3D "$OLDSTATUS"; then
+            exit 1
+        fi
+    done
+    exit 0
     ;;
 update)
     if test -z "$maybe_modules"
--=20
2.24.1


