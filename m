Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E1FC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9324D20756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDvZboxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9324D20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUSo-00060L-LF
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIy-0000yB-8x
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIr-0001KT-Kd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxA1kn7lg37UfO6T647djICOtes050SoBSTF2NibAkI=;
 b=PDvZboxJnmhtQgHP2XHBxJ6gAei5i9ug36VvbRZGzgCsgmiBos3CuxbiGrIi+mWPMkc3ni
 5txa9rStMwvc/e94/LY6TiOnFTRSLKDdqLQFwRHFG2lJS+pel6f2A+TIN7PNm1gUacoSDo
 nEw+6O/HFWLuS3Fe9zLJNMRmO+74ZG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-IR8A1KSXP1SVf-iLNZamXQ-1; Tue, 27 Oct 2020 15:06:36 -0400
X-MC-Unique: IR8A1KSXP1SVf-iLNZamXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A721882FBE;
 Tue, 27 Oct 2020 19:06:35 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 483216EF46;
 Tue, 27 Oct 2020 19:06:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 06/20] fuse: Implement hole detection through lseek
Date: Tue, 27 Oct 2020 20:05:46 +0100
Message-Id: <20201027190600.192171-7-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a relatively new feature in libfuse (available since 3.8.0,
which was released in November 2019), so we have to add a dedicated
check whether it is available before making use of it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 configure           |  8 ++++-
 meson.build         | 20 ++++++++++++
 block/export/fuse.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 meson_options.txt   |  2 ++
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index fc315deebe..f74b7ef3f4 100755
--- a/configure
+++ b/configure
@@ -449,6 +449,7 @@ ninja=""
 skip_meson=no
 gettext=""
 fuse="auto"
+fuse_lseek="auto"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -1524,6 +1525,10 @@ for opt do
   ;;
   --disable-fuse) fuse="disabled"
   ;;
+  --enable-fuse-lseek) fuse_lseek="enabled"
+  ;;
+  --disable-fuse-lseek) fuse_lseek="disabled"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1847,6 +1852,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
   libdaxctl       libdaxctl support
   fuse            FUSE block device export
+  fuse-lseek      SEEK_HOLE/SEEK_DATA support for FUSE exports
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6988,7 +6994,7 @@ NINJA=$ninja $meson setup \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
         -Ddocs=$docs -Dsphinx_build=$sphinx_build -Dinstall_blobs=$blobs \
-        -Dfuse=$fuse \
+        -Dfuse=$fuse -Dfuse_lseek=$fuse_lseek \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 4e8436b456..ea1a68b46d 100644
--- a/meson.build
+++ b/meson.build
@@ -736,10 +736,28 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
+if get_option('fuse').disabled() and get_option('fuse_lseek').enabled()
+  error('Cannot enable fuse-lseek while fuse is disabled')
+endif
+
 fuse = dependency('fuse3', required: get_option('fuse'),
                   version: '>=3.1', method: 'pkg-config',
                   static: enable_static)
 
+fuse_lseek = not_found
+if not get_option('fuse_lseek').disabled()
+  if fuse.version().version_compare('>=3.8')
+    # Dummy dependency
+    fuse_lseek = declare_dependency()
+  elif get_option('fuse_lseek').enabled()
+    if fuse.found()
+      error('fuse-lseek requires libfuse >=3.8, found ' + fuse.version())
+    else
+      error('fuse-lseek requires libfuse, which was not found')
+    endif
+  endif
+endif
+
 #################
 # config-host.h #
 #################
@@ -773,6 +791,7 @@ config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_FUSE', fuse.found())
+config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -2169,6 +2188,7 @@ summary_info += {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')}
 summary_info += {'rng-none':          config_host.has_key('CONFIG_RNG_NONE')}
 summary_info += {'Linux keyring':     config_host.has_key('CONFIG_SECRET_KEYRING')}
 summary_info += {'FUSE exports':      fuse.found()}
+summary_info += {'FUSE lseek':        fuse_lseek.found()}
 summary(summary_info, bool_yn: true)
 
 if not supported_cpus.contains(cpu)
diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0b9d226b2f..38f74c94da 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -627,6 +627,80 @@ static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
     fuse_fsync(req, inode, 1, fi);
 }
 
+#ifdef CONFIG_FUSE_LSEEK
+/**
+ * Let clients inquire allocation status.
+ */
+static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
+                       int whence, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+
+    if (whence != SEEK_HOLE && whence != SEEK_DATA) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    while (true) {
+        int64_t pnum;
+        int ret;
+
+        ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
+                                      offset, INT64_MAX, &pnum, NULL, NULL);
+        if (ret < 0) {
+            fuse_reply_err(req, -ret);
+            return;
+        }
+
+        if (!pnum && (ret & BDRV_BLOCK_EOF)) {
+            int64_t blk_len;
+
+            /*
+             * If blk_getlength() rounds (e.g. by sectors), then the
+             * export length will be rounded, too.  However,
+             * bdrv_block_status_above() may return EOF at unaligned
+             * offsets.  We must not let this become visible and thus
+             * always simulate a hole between @offset (the real EOF)
+             * and @blk_len (the client-visible EOF).
+             */
+
+            blk_len = blk_getlength(exp->common.blk);
+            if (blk_len < 0) {
+                fuse_reply_err(req, -blk_len);
+                return;
+            }
+
+            if (offset > blk_len || whence == SEEK_DATA) {
+                fuse_reply_err(req, ENXIO);
+            } else {
+                fuse_reply_lseek(req, offset);
+            }
+            return;
+        }
+
+        if (ret & BDRV_BLOCK_DATA) {
+            if (whence == SEEK_DATA) {
+                fuse_reply_lseek(req, offset);
+                return;
+            }
+        } else {
+            if (whence == SEEK_HOLE) {
+                fuse_reply_lseek(req, offset);
+                return;
+            }
+        }
+
+        /* Safety check against infinite loops */
+        if (!pnum) {
+            fuse_reply_err(req, ENXIO);
+            return;
+        }
+
+        offset += pnum;
+    }
+}
+#endif
+
 static const struct fuse_lowlevel_ops fuse_ops = {
     .init       = fuse_init,
     .lookup     = fuse_lookup,
@@ -638,6 +712,9 @@ static const struct fuse_lowlevel_ops fuse_ops = {
     .fallocate  = fuse_fallocate,
     .flush      = fuse_flush,
     .fsync      = fuse_fsync,
+#ifdef CONFIG_FUSE_LSEEK
+    .lseek      = fuse_lseek,
+#endif
 };
 
 const BlockExportDriver blk_exp_fuse = {
diff --git a/meson_options.txt b/meson_options.txt
index 2ef4ec628f..f9e7d89f9d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -66,6 +66,8 @@ option('virtiofsd', type: 'feature', value: 'auto',
        description: 'build virtiofs daemon (virtiofsd)')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
+option('fuse_lseek', type : 'feature', value : 'auto',
+       description: 'SEEK_HOLE/SEEK_DATA support for FUSE exports')
 
 option('capstone', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
-- 
2.26.2


