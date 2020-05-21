Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE8D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEBkolKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE8D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkd5-0000v1-Nm
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbka3-0003Vm-7w
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:45:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbka1-00057I-SV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590065145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJrxybmGdrfBbB987Z3tJ0S0qgwtOuPu1SkhX8bjTVs=;
 b=HEBkolKZnL72QHeWvokgqgFUTdG79EW8r14A3JKO5KTDZYweqiBfKRZ1X1HMDZn+PV1H1I
 kUJiaRkXLXiM8ZxQMQ9Kx4ceLXYZFDeCgWCTfldUY5lHikMvb/rUWuqC4Zy7zQK/N/59qF
 5UwS45jC7YquoaO+8DjzcGAMvMQiit4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-7RhToScFNAe45_u0Q4goqg-1; Thu, 21 May 2020 08:45:39 -0400
X-MC-Unique: 7RhToScFNAe45_u0Q4goqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9C14107ACF4;
 Thu, 21 May 2020 12:45:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2176C341E9;
 Thu, 21 May 2020 12:45:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] run-coverity-scan: get Coverity token and email from
 special git config section
Date: Thu, 21 May 2020 08:45:30 -0400
Message-Id: <20200521124535.5329-4-pbonzini@redhat.com>
In-Reply-To: <20200521124535.5329-1-pbonzini@redhat.com>
References: <20200521124535.5329-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Support a [coverity] section in .git/config.  It can be used to retrieve the
token and also, if it is different from user.email, the username of the
submitter.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 2e067ef5cf..990f75138d 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -41,9 +41,10 @@
 #                   is intended mainly for internal use by the Docker support
 #
 # User-specifiable environment variables:
-#  COVERITY_TOKEN -- Coverity token
+#  COVERITY_TOKEN -- Coverity token (default: looks at your
+#                    coverity.token config)
 #  COVERITY_EMAIL -- the email address to use for uploads (default:
-#                    looks at your git user.email config)
+#                    looks at your git coverity.email or user.email config)
 #  COVERITY_BUILD_CMD -- make command (default: 'make -jN' where N is
 #                    number of CPUs as determined by 'nproc')
 #  COVERITY_TOOL_BASE -- set to directory to put coverity tools
@@ -58,11 +59,11 @@ check_upload_permissions() {
     # with status 1 if the check failed (usually a bad token);
     # will exit the script with status 0 if the check indicated that we
     # can't upload yet (ie we are at quota)
-    # Assumes that PROJTOKEN, PROJNAME and DRYRUN have been initialized.
+    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
 
     echo "Checking upload permissions..."
 
-    if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$PROJTOKEN&project=$PROJNAME" -q -O -)"; then
+    if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -q -O -)"; then
         echo "Coverity Scan API access denied: bad token?"
         exit 1
     fi
@@ -94,20 +95,20 @@ check_upload_permissions() {
 update_coverity_tools () {
     # Check for whether we need to download the Coverity tools
     # (either because we don't have a copy, or because it's out of date)
-    # Assumes that COVERITY_TOOL_BASE, PROJTOKEN and PROJNAME are set.
+    # Assumes that COVERITY_TOOL_BASE, COVERITY_TOKEN and PROJNAME are set.
 
     mkdir -p "$COVERITY_TOOL_BASE"
     cd "$COVERITY_TOOL_BASE"
 
     echo "Checking for new version of coverity build tools..."
-    wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
+    wget https://scan.coverity.com/download/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
 
     if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
         # out of date md5 or no md5: download new build tool
         # blow away the old build tool
         echo "Downloading coverity build tools..."
         rm -rf coverity_tool coverity_tool.tgz
-        wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME" -O coverity_tool.tgz
+        wget https://scan.coverity.com/download/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -O coverity_tool.tgz
         if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
             echo "Downloaded tarball didn't match md5sum!"
             exit 1
@@ -205,6 +206,9 @@ while [ "$#" -ge 1 ]; do
     esac
 done
 
+if [ -z "$COVERITY_TOKEN" ]; then
+    COVERITY_TOKEN="$(git config coverity.token)"
+fi
 if [ -z "$COVERITY_TOKEN" ]; then
     echo "COVERITY_TOKEN environment variable not set"
     exit 1
@@ -225,7 +229,6 @@ if [ -z "$SRCDIR" ]; then
     SRCDIR="$PWD"
 fi
 
-PROJTOKEN="$COVERITY_TOKEN"
 PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
@@ -268,6 +271,9 @@ if [ -z "$DESCRIPTION" ]; then
     DESCRIPTION="$(git rev-parse HEAD)"
 fi
 
+if [ -z "$COVERITY_EMAIL" ]; then
+    COVERITY_EMAIL="$(git config coverity.email)"
+fi
 if [ -z "$COVERITY_EMAIL" ]; then
     COVERITY_EMAIL="$(git config user.email)"
 fi
@@ -393,7 +399,7 @@ if [ "$DRYRUN" = yes ]; then
     exit 0
 fi
 
-curl --form token="$PROJTOKEN" --form email="$COVERITY_EMAIL" \
+curl --form token="$COVERITY_TOKEN" --form email="$COVERITY_EMAIL" \
      --form file=@"$TARBALL" --form version="$VERSION" \
      --form description="$DESCRIPTION" \
      https://scan.coverity.com/builds?project="$PROJNAME"
-- 
2.26.2



