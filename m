Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30BFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59775206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhxcyS9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59775206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJMV-0006GC-E3
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOJJC-0002p0-Qe
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOJJ9-00076o-KV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601638382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vA9FhMMn/cQZcVsvdoq7mQaQxFyrINk/F97XY+h7nOQ=;
 b=VhxcyS9trBIdfwcTgFzh0vYzY0I4XdecjvSAK5EZSfhgitdVOfwh5S3obuE03iahc1ub1i
 ZnNuiQJlOtk7w2Lb1/NO7aiIrybJ7NSrC/TsxfeK8+6lt4rMcfEA1Uk4xONxHxhCoL2JWW
 Kv9gzHH4xIw9EEfGX3IKsOirkeWG6DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-dk79FbgTMva5QVPnFqEx8g-1; Fri, 02 Oct 2020 07:32:58 -0400
X-MC-Unique: dk79FbgTMva5QVPnFqEx8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6606C1074644;
 Fri,  2 Oct 2020 11:32:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-9.ams2.redhat.com
 [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A964460C05;
 Fri,  2 Oct 2020 11:32:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] block: deprecate the sheepdog block driver
Date: Fri,  2 Oct 2020 12:32:43 +0100
Message-Id: <20201002113243.2347710-3-berrange@redhat.com>
In-Reply-To: <20201002113243.2347710-1-berrange@redhat.com>
References: <20201002113243.2347710-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This thread from a little over a year ago:

  http://lists.wpkg.org/pipermail/sheepdog/2019-March/thread.html

states that sheepdog is no longer actively developed. The only mentioned
users are some companies who are said to have it for legacy reasons with
plans to replace it by Ceph. There is talk about cutting out existing
features to turn it into a simple demo of how to write a distributed
block service. There is no evidence of anyone working on that idea:

  https://github.com/sheepdog/sheepdog/commits/master

No real commits to git since Jan 2018, and before then just some minor
technical debt cleanup.

There is essentially no activity on the mailing list aside from
patches to QEMU that get CC'd due to our MAINTAINERS entry.

Fedora packages for sheepdog failed to build from upstream source
because of the more strict linker that no longer merges duplicate
global symbols. Fedora patches it to add the missing "extern"
annotations and presumably other distros do to, but upstream source
remains broken.

There is only basic compile testing, no functional testing of the
driver.

Since there are no build pre-requisites the sheepdog driver is currently
enabled unconditionally. This would result in configure issuing a
deprecation warning by default for all users. Thus the configure default
is changed to disable it, requiring users to pass --enable-sheepdog to
build the driver.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/sheepdog.c           | 14 ++++++++++++++
 configure                  |  5 +++--
 docs/system/deprecated.rst |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2f5c0eb376..e270f2022c 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -242,6 +242,16 @@ typedef struct SheepdogInode {
  */
 #define FNV1A_64_INIT ((uint64_t)0xcbf29ce484222325ULL)
 
+static void deprecation_warning(void)
+{
+    static bool warned;
+
+    if (!warned) {
+        warn_report("the sheepdog block driver is deprecated");
+        warned = true;
+    }
+}
+
 /*
  * 64 bit Fowler/Noll/Vo FNV-1a hash code
  */
@@ -1548,6 +1558,8 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     char *buf = NULL;
     QemuOpts *opts;
 
+    deprecation_warning();
+
     s->bs = bs;
     s->aio_context = bdrv_get_aio_context(bs);
 
@@ -2007,6 +2019,8 @@ static int sd_co_create(BlockdevCreateOptions *options, Error **errp)
 
     assert(options->driver == BLOCKDEV_DRIVER_SHEEPDOG);
 
+    deprecation_warning();
+
     s = g_new0(BDRVSheepdogState, 1);
 
     /* Steal SocketAddress from QAPI, set NULL to prevent double free */
diff --git a/configure b/configure
index ca9b458ea0..c5971fe560 100755
--- a/configure
+++ b/configure
@@ -533,7 +533,7 @@ vdi="yes"
 vvfat="yes"
 qed="yes"
 parallels="yes"
-sheepdog="yes"
+sheepdog="no"
 libxml2=""
 debug_mutex="no"
 libpmem=""
@@ -1940,7 +1940,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vvfat           vvfat image format support
   qed             qed image format support
   parallels       parallels image format support
-  sheepdog        sheepdog block driver support
+  sheepdog        sheepdog block driver support (deprecated)
   crypto-afalg    Linux AF_ALG crypto backend driver
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
@@ -7200,6 +7200,7 @@ if test "$parallels" = "yes" ; then
   echo "CONFIG_PARALLELS=y" >> $config_host_mak
 fi
 if test "$sheepdog" = "yes" ; then
+  add_to deprecated_features "sheepdog"
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
 if test "$pty_h" = "yes" ; then
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index da862201ba..fbc67b189b 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -376,6 +376,15 @@ The above, converted to the current supported format::
 
   json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
 
+``sheepdog`` driver (since 5.2.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``sheepdog`` block device driver is deprecated. The corresponding upstream
+server project is no longer actively maintained. Users are recommended to switch
+to an alternative distributed block device driver such as RBD. The
+``qemu-img convert`` command can be used to liberate existing data by moving
+it out of sheepdog volumes into an alternative storage backend.
+
 linux-user mode CPUs
 --------------------
 
-- 
2.26.2


