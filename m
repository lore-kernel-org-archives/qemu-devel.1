Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E890BC5518B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7462620706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW45bl3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7462620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJCA-0006rs-ER
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6V-0006zz-CL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6S-0004Ot-Di
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6S-0004Oi-27
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QURyugqsBfA9ZpZvz1fnKy9b+23158RatjoiGUDeC9M=;
 b=TW45bl3POljHDCdVICjSQQiggps8fLEkTf3xd+8GFE9vRe15vfvfU5DlE0sBLrAZ5Ipqh1
 GogJ4sD2i9cP491PTzRJNrmW7jhHNtRzGgPsyzjFsvxjgqTaGqj5gLBL8EXxSIXxKEqh3F
 8lmiPz2HoL66uKAHHYjg17k6D4RbID4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-PDc78mVMN6iH6WfH64G-aA-1; Wed, 22 Apr 2020 13:23:56 -0400
X-MC-Unique: PDc78mVMN6iH6WfH64G-aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34E66800FF0;
 Wed, 22 Apr 2020 17:23:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5196084B;
 Wed, 22 Apr 2020 17:23:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] run-coverity-scan: get Coverity token and email from
 special git config section
Date: Wed, 22 Apr 2020 13:23:46 -0400
Message-Id: <20200422172351.26583-4-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-1-pbonzini@redhat.com>
References: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support a [coverity] section in .git/config.  It can be used to retrieve th=
e
token and also, if it is different from user.email, the username of the
submitter.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-sca=
n/run-coverity-scan
index 2e067ef5cf..f7325b570c 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -41,9 +41,10 @@
 #                   is intended mainly for internal use by the Docker supp=
ort
 #
 # User-specifiable environment variables:
-#  COVERITY_TOKEN -- Coverity token
+#  COVERITY_TOKEN -- Coverity token (default: looks at your
+#                    coverity.token config)
 #  COVERITY_EMAIL -- the email address to use for uploads (default:
-#                    looks at your git user.email config)
+#                    looks at your git coverity.email or user.email config=
)
 #  COVERITY_BUILD_CMD -- make command (default: 'make -jN' where N is
 #                    number of CPUs as determined by 'nproc')
 #  COVERITY_TOOL_BASE -- set to directory to put coverity tools
@@ -62,7 +63,7 @@ check_upload_permissions() {
=20
     echo "Checking upload permissions..."
=20
-    if ! up_perm=3D"$(wget https://scan.coverity.com/api/upload_permitted =
--post-data "token=3D$PROJTOKEN&project=3D$PROJNAME" -q -O -)"; then
+    if ! up_perm=3D"$(wget https://scan.coverity.com/api/upload_permitted =
--post-data "token=3D$COVERITY_TOKEN&project=3D$PROJNAME" -q -O -)"; then
         echo "Coverity Scan API access denied: bad token?"
         exit 1
     fi
@@ -100,14 +101,14 @@ update_coverity_tools () {
     cd "$COVERITY_TOOL_BASE"
=20
     echo "Checking for new version of coverity build tools..."
-    wget https://scan.coverity.com/download/linux64 --post-data "token=3D$=
PROJTOKEN&project=3D$PROJNAME&md5=3D1" -O coverity_tool.md5.new
+    wget https://scan.coverity.com/download/linux64 --post-data "token=3D$=
COVERITY_TOKEN&project=3D$PROJNAME&md5=3D1" -O coverity_tool.md5.new
=20
     if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
         # out of date md5 or no md5: download new build tool
         # blow away the old build tool
         echo "Downloading coverity build tools..."
         rm -rf coverity_tool coverity_tool.tgz
-        wget https://scan.coverity.com/download/linux64 --post-data "token=
=3D$PROJTOKEN&project=3D$PROJNAME" -O coverity_tool.tgz
+        wget https://scan.coverity.com/download/linux64 --post-data "token=
=3D$COVERITY_TOKEN&project=3D$PROJNAME" -O coverity_tool.tgz
         if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5=
sum -c --status; then
             echo "Downloaded tarball didn't match md5sum!"
             exit 1
@@ -205,6 +206,9 @@ while [ "$#" -ge 1 ]; do
     esac
 done
=20
+if [ -z "$COVERITY_TOKEN" ]; then
+    COVERITY_TOKEN=3D"$(git config coverity.token)"
+fi
 if [ -z "$COVERITY_TOKEN" ]; then
     echo "COVERITY_TOKEN environment variable not set"
     exit 1
@@ -225,7 +229,6 @@ if [ -z "$SRCDIR" ]; then
     SRCDIR=3D"$PWD"
 fi
=20
-PROJTOKEN=3D"$COVERITY_TOKEN"
 PROJNAME=3DQEMU
 TARBALL=3Dcov-int.tar.xz
=20
@@ -268,6 +271,9 @@ if [ -z "$DESCRIPTION" ]; then
     DESCRIPTION=3D"$(git rev-parse HEAD)"
 fi
=20
+if [ -z "$COVERITY_EMAIL" ]; then
+    COVERITY_EMAIL=3D"$(git config coverity.email)"
+fi
 if [ -z "$COVERITY_EMAIL" ]; then
     COVERITY_EMAIL=3D"$(git config user.email)"
 fi
@@ -393,7 +399,7 @@ if [ "$DRYRUN" =3D yes ]; then
     exit 0
 fi
=20
-curl --form token=3D"$PROJTOKEN" --form email=3D"$COVERITY_EMAIL" \
+curl --form token=3D"$COVERITY_TOKEN" --form email=3D"$COVERITY_EMAIL" \
      --form file=3D@"$TARBALL" --form version=3D"$VERSION" \
      --form description=3D"$DESCRIPTION" \
      https://scan.coverity.com/builds?project=3D"$PROJNAME"
--=20
2.18.2



