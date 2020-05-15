Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54050C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E52620758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxd8L4FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E52620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZpa-0006NN-8W
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZiu-0002dW-9P
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38088
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZir-0002Bs-OS
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVyhiR0n+Jp3lZ9I7Z5cN7gaZ3axxDiWezI8vxNxYgQ=;
 b=bxd8L4FF19S5p1fEBGqlI035vtzQ5tIwotoXjvztB4V4c/XxONvtwhvuxf86x0DXRuRRBZ
 +1B21baXJRVnjjR3/eW2m+rP0yyPmbNCNMJ8BjPl5JWX8o8L4ZWHpFBQzULlQwXujn6GHx
 um4yVzRE0IycNpMhzI5KAFEqIZMNbus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-jjJZFcHpOSeKscCZ5_vROw-1; Fri, 15 May 2020 08:45:48 -0400
X-MC-Unique: jjJZFcHpOSeKscCZ5_vROw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD30E19200C0;
 Fri, 15 May 2020 12:45:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFAC32E024;
 Fri, 15 May 2020 12:45:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/51] block: Add BlockDriver.is_format
Date: Fri, 15 May 2020 14:44:44 +0200
Message-Id: <20200515124521.335403-15-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We want to unify child_format and child_file at some point.  One of the
important things that set format drivers apart from other drivers is
that they do not expect other format nodes under them (except in the
backing chain), i.e. we must not probe formats inside of formats.  That
means we need something on which to distinguish format drivers from
others, and hence this flag.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200513110544.176672-3-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 7 +++++++
 block/bochs.c             | 1 +
 block/cloop.c             | 1 +
 block/crypto.c            | 2 ++
 block/dmg.c               | 1 +
 block/parallels.c         | 1 +
 block/qcow.c              | 1 +
 block/qcow2.c             | 1 +
 block/qed.c               | 1 +
 block/raw-format.c        | 1 +
 block/vdi.c               | 1 +
 block/vhdx.c              | 1 +
 block/vmdk.c              | 1 +
 block/vpc.c               | 1 +
 14 files changed, 21 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7ba8c89036..1c24df53fd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -95,6 +95,13 @@ struct BlockDriver {
      * must implement them and return -ENOTSUP.
      */
     bool is_filter;
+    /*
+     * Set to true if the BlockDriver is a format driver.  Format nodes
+     * generally do not expect their children to be other format nodes
+     * (except for backing files), and so format probing is disabled
+     * on those children.
+     */
+    bool is_format;
     /*
      * Return true if @to_replace can be replaced by a BDS with the
      * same data as @bs without it affecting @bs's behavior (that is,
diff --git a/block/bochs.c b/block/bochs.c
index 32bb83b268..e7bbeaa1c4 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -301,6 +301,7 @@ static BlockDriver bdrv_bochs = {
     .bdrv_refresh_limits = bochs_refresh_limits,
     .bdrv_co_preadv = bochs_co_preadv,
     .bdrv_close		= bochs_close,
+    .is_format          = true,
 };
 
 static void bdrv_bochs_init(void)
diff --git a/block/cloop.c b/block/cloop.c
index 4de94876d4..f90f1a4b4c 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -297,6 +297,7 @@ static BlockDriver bdrv_cloop = {
     .bdrv_refresh_limits = cloop_refresh_limits,
     .bdrv_co_preadv = cloop_co_preadv,
     .bdrv_close     = cloop_close,
+    .is_format      = true,
 };
 
 static void bdrv_cloop_init(void)
diff --git a/block/crypto.c b/block/crypto.c
index 6b21d6bf6c..bdb2b27475 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -771,6 +771,8 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
 
+    .is_format          = true,
+
     .strong_runtime_opts = block_crypto_strong_runtime_opts,
 };
 
diff --git a/block/dmg.c b/block/dmg.c
index 4a045f2b3e..ef3c6e771d 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -753,6 +753,7 @@ static BlockDriver bdrv_dmg = {
     .bdrv_child_perm     = bdrv_format_default_perms,
     .bdrv_co_preadv = dmg_co_preadv,
     .bdrv_close     = dmg_close,
+    .is_format      = true,
 };
 
 static void bdrv_dmg_init(void)
diff --git a/block/parallels.c b/block/parallels.c
index e7717c508e..bd5f6ffa09 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -918,6 +918,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
     .bdrv_co_readv  = parallels_co_readv,
     .bdrv_co_writev = parallels_co_writev,
+    .is_format      = true,
     .supports_backing = true,
     .bdrv_co_create      = parallels_co_create,
     .bdrv_co_create_opts = parallels_co_create_opts,
diff --git a/block/qcow.c b/block/qcow.c
index b0475b73a5..6a72dea049 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1185,6 +1185,7 @@ static BlockDriver bdrv_qcow = {
     .bdrv_co_create         = qcow_co_create,
     .bdrv_co_create_opts    = qcow_co_create_opts,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
+    .is_format              = true,
     .supports_backing       = true,
     .bdrv_refresh_limits    = qcow_refresh_limits,
 
diff --git a/block/qcow2.c b/block/qcow2.c
index ad9ab4fafa..76bec61ee9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5767,6 +5767,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_save_vmstate    = qcow2_save_vmstate,
     .bdrv_load_vmstate    = qcow2_load_vmstate,
 
+    .is_format                  = true,
     .supports_backing           = true,
     .bdrv_change_backing_file   = qcow2_change_backing_file,
 
diff --git a/block/qed.c b/block/qed.c
index 5da9726518..337eb6dbb6 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1665,6 +1665,7 @@ static BlockDriver bdrv_qed = {
     .format_name              = "qed",
     .instance_size            = sizeof(BDRVQEDState),
     .create_opts              = &qed_create_opts,
+    .is_format                = true,
     .supports_backing         = true,
 
     .bdrv_probe               = bdrv_qed_probe,
diff --git a/block/raw-format.c b/block/raw-format.c
index 9108e43696..00e13bb41e 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -566,6 +566,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_copy_range_to  = &raw_co_copy_range_to,
     .bdrv_co_truncate     = &raw_co_truncate,
     .bdrv_getlength       = &raw_getlength,
+    .is_format            = true,
     .has_variable_length  = true,
     .bdrv_measure         = &raw_measure,
     .bdrv_get_info        = &raw_get_info,
diff --git a/block/vdi.c b/block/vdi.c
index 2d28046615..0ef733ae19 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -1053,6 +1053,7 @@ static BlockDriver bdrv_vdi = {
 
     .bdrv_get_info = vdi_get_info,
 
+    .is_format = true,
     .create_opts = &vdi_create_opts,
     .bdrv_co_check = vdi_co_check,
 };
diff --git a/block/vhdx.c b/block/vhdx.c
index 53e756438a..e692cf80cc 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2254,6 +2254,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_co_check          = vhdx_co_check,
     .bdrv_has_zero_init     = vhdx_has_zero_init,
 
+    .is_format              = true,
     .create_opts            = &vhdx_create_opts,
 };
 
diff --git a/block/vmdk.c b/block/vmdk.c
index b18f128816..56e85689f3 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -3070,6 +3070,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_get_info                = vmdk_get_info,
     .bdrv_gather_child_options    = vmdk_gather_child_options,
 
+    .is_format                    = true,
     .supports_backing             = true,
     .create_opts                  = &vmdk_create_opts,
 };
diff --git a/block/vpc.c b/block/vpc.c
index 5e31dd1e47..46a2d48659 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1250,6 +1250,7 @@ static BlockDriver bdrv_vpc = {
 
     .bdrv_get_info          = vpc_get_info,
 
+    .is_format              = true,
     .create_opts            = &vpc_create_opts,
     .bdrv_has_zero_init     = vpc_has_zero_init,
     .strong_runtime_opts    = vpc_strong_runtime_opts,
-- 
2.25.4


