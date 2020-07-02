Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A965C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CD8206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/j2LPw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CD8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0Od-00069f-DL
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jr0Ni-00051k-UK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:40:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jr0Nh-0001SF-6w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593700803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=5aQcL1wGR/DIPxmdOuyjfyVjJ4SjBWpZhKDL4MpDHiU=;
 b=C/j2LPw1ElTlNU2pES4I2++AVPIQRUXdsrF3sa9nGHYx6Gtxa7KtWToRp+C9bOlCfKiRN3
 NnL7Z0nM4qai4TdlQWXAZVxRC8IYaS9RiRePYWFGM3hzTLr7Rtm3U11k2PKGGNlpiTC6I1
 stBlBllrcHAVAyuP0iLXq3bT5FAL2C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-M3O4io16OeGKbybaB4SWEw-1; Thu, 02 Jul 2020 10:40:02 -0400
X-MC-Unique: M3O4io16OeGKbybaB4SWEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFAC01940928;
 Thu,  2 Jul 2020 14:39:58 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDDD110013D2;
 Thu,  2 Jul 2020 14:39:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure / util: Auto-detect the availability of openpty()
Date: Thu,  2 Jul 2020 16:39:55 +0200
Message-Id: <20200702143955.678-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent versions of Solaris (v11.4) now feature an openpty() function,
too, causing a build failure since we ship our own implementation of
openpty() for Solaris in util/qemu-openpty.c so far. Since there are
now both variants available in the wild, with and without this function,
let's introduce a proper HAVE_OPENPTY define for this to fix the build
failure.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Untested, since I do not have a VM with Solaris. Michele,
 Peter, I'd really appreciate a "Tested-by:" from you here. Thanks!

 configure           | 9 ++++++++-
 util/qemu-openpty.c | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4a22dcd563..0b5fd30fc4 100755
--- a/configure
+++ b/configure
@@ -5134,10 +5134,14 @@ extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
 int main(void) { return openpty(0, 0, 0, 0, 0); }
 EOF
 
-if ! compile_prog "" "" ; then
+have_openpty="no"
+if compile_prog "" "" ; then
+  have_openpty="yes"
+else
   if compile_prog "" "-lutil" ; then
     libs_softmmu="-lutil $libs_softmmu"
     libs_tools="-lutil $libs_tools"
+    have_openpty="yes"
   fi
 fi
 
@@ -7380,6 +7384,9 @@ fi
 if test "$have_broken_size_max" = "yes" ; then
     echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
 fi
+if test "$have_openpty" = "yes" ; then
+    echo "HAVE_OPENPTY=y" >> $config_host_mak
+fi
 
 # Work around a system header bug with some kernel/XFS header
 # versions where they both try to define 'struct fsxattr':
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..14e5c8ae8f 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -52,7 +52,8 @@
 #endif
 
 #ifdef __sun__
-/* Once Solaris has openpty(), this is going to be removed. */
+
+#if !defined(HAVE_OPENPTY)
 static int openpty(int *amaster, int *aslave, char *name,
                    struct termios *termp, struct winsize *winp)
 {
@@ -93,6 +94,7 @@ err:
         close(mfd);
         return -1;
 }
+#endif
 
 static void cfmakeraw (struct termios *termios_p)
 {
-- 
2.18.1


