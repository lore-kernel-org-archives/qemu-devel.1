Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD32C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2BA2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2BA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhz5-00089b-NJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hnhyZ-0006it-E1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hnhyY-00083q-EW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hnhyW-0007zj-8Z; Wed, 17 Jul 2019 07:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F2CE3066779;
 Wed, 17 Jul 2019 11:19:55 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4737119C68;
 Wed, 17 Jul 2019 11:19:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Date: Wed, 17 Jul 2019 13:19:44 +0200
Message-Id: <20190717111947.30356-2-thuth@redhat.com>
In-Reply-To: <20190717111947.30356-1-thuth@redhat.com>
References: <20190717111947.30356-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 17 Jul 2019 11:19:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/4] tests/qemu-iotests/check: Allow tests
 without groups
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The regular expressions in the "check" script currently expect that there
is always a space after the test number in the group file, so you can't
have a test in there without a group unless the line still ends with a
space - which is quite error prone since some editors might remove spaces
at the end of lines automatically.
Thus let's fix the regular expressions so that it is also possible to
have lines with one test number only in the group file.

Suggested-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f925606cc5..c24874ff4a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -488,7 +488,7 @@ testlist options
 BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",t }'=
 \
         | while read id
         do
-            if grep -s "^$id " "$source_iotests/group" >/dev/null
+            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/nul=
l
             then
                 # in group file ... OK
                 echo $id >>$tmp.list
@@ -547,7 +547,7 @@ else
         touch $tmp.list
     else
         # no test numbers, do everything from group file
-        sed -n -e '/^[0-9][0-9][0-9]*/s/[         ].*//p' <"$source_iote=
sts/group" >$tmp.list
+        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_io=
tests/group" >$tmp.list
     fi
 fi
=20
--=20
2.21.0


