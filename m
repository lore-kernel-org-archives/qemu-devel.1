Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABAEC606CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463ED20861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463ED20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZri-0007LI-GX
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 16:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkZr0-0006o1-BG
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkZqz-0007J8-Du
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkZqz-0007IC-8J
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD4E53082E4B;
 Mon,  8 Jul 2019 20:03:01 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF48608C6;
 Mon,  8 Jul 2019 20:02:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 00:02:49 +0400
Message-Id: <20190708200250.12017-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 08 Jul 2019 20:03:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] archive-source: also create a stash for
 submodules
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
Cc: Fam Zheng <fam@euphon.net>, thuth@redhat.com, philmd@redhat.com,
 kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"git archive" fails when a submodule has a modification, because "git
stash create" doesn't handle submodules. Let's teach our
archive-source.sh to handle modifications in submodules the same way
as qemu tree, by creating a stash.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/archive-source.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index ca94e49978..fb5d6b3918 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -39,14 +39,16 @@ function cleanup() {
 }
 trap "cleanup" 0 1 2 3 15
=20
-if git diff-index --quiet HEAD -- &>/dev/null
-then
-    HEAD=3DHEAD
-else
-    HEAD=3D$(git stash create)
-fi
+function tree_ish() {
+    local retval=3D'HEAD'
+    if ! git diff-index --quiet --ignore-submodules=3Dall HEAD -- &>/dev=
/null
+    then
+        retval=3D$(git stash create)
+    fi
+    echo "$retval"
+}
=20
-git archive --format tar $HEAD > "$tar_file"
+git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 for sm in $submodules; do
     status=3D"$(git submodule status "$sm")"
@@ -62,7 +64,7 @@ for sm in $submodules; do
             echo "WARNING: submodule $sm is out of sync"
             ;;
     esac
-    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_f=
ile"
+    (cd $sm; git archive --format tar --prefix "$sm/" $(tree_ish)) > "$s=
ub_file"
     test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
     tar --concatenate --file "$tar_file" "$sub_file"
     test $? -ne 0 && error "failed append submodule $sm to $tar_file"
--=20
2.22.0.214.g8dca754b1e


