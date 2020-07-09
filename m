Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09834C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B560520775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMmvwbrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B560520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbbC-0006rI-1H
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtbaL-0005xf-WB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:47:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtbaI-0001pz-RB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594320469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mu1qF4DWJePip3Ck6w22ORBK20LiSkZWFG3uNzJQfGk=;
 b=LMmvwbrZakWqJWmXfLLfbqtcK12y55CggBrWezyFpEqk78kYNP7R5BXriLQB9dvCJspcyf
 I3UHh+CwjWTSyRrARdeo/6TiYkfEMTrHsdL1LVfmzHBXBnEDNv0jV6rFU8lKmZ6aXQx9FC
 nHMVSn5bu5ZC8cIY64cHxyOq6vkBuKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-8iYO3BWKMfyzKrUqKS2Hyw-1; Thu, 09 Jul 2020 14:47:37 -0400
X-MC-Unique: 8iYO3BWKMfyzKrUqKS2Hyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7BAF107ACCA;
 Thu,  9 Jul 2020 18:47:36 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0143519D61;
 Thu,  9 Jul 2020 18:47:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Remove VXHS block device
Date: Thu,  9 Jul 2020 22:47:28 +0400
Message-Id: <20200709184728.2051009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 ashmit602@gmail.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vxhs code doesn't compile since v2.12.0. There's no point in fixing
and then adding CI for a config that our users have demonstrated that
they do not use; better to just remove it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure                        |  39 --
 qapi/block-core.json             |  22 +-
 block/vxhs.c                     | 590 -------------------------------
 block/Makefile.objs              |   2 -
 block/trace-events               |  17 -
 tests/qemu-iotests/017           |   1 -
 tests/qemu-iotests/029           |   1 -
 tests/qemu-iotests/073           |   1 -
 tests/qemu-iotests/114           |   1 -
 tests/qemu-iotests/130           |   1 -
 tests/qemu-iotests/134           |   1 -
 tests/qemu-iotests/156           |   1 -
 tests/qemu-iotests/158           |   1 -
 tests/qemu-iotests/282           |   1 -
 tests/qemu-iotests/check         |  10 -
 tests/qemu-iotests/common.filter |   1 -
 tests/qemu-iotests/common.rc     |  33 --
 17 files changed, 2 insertions(+), 721 deletions(-)
 delete mode 100644 block/vxhs.c

diff --git a/configure b/configure
index ee6c3c6792a..53328bb021c 100755
--- a/configure
+++ b/configure
@@ -500,7 +500,6 @@ numa=""
 tcmalloc="no"
 jemalloc="no"
 replication="yes"
-vxhs=""
 bochs="yes"
 cloop="yes"
 dmg="yes"
@@ -1531,10 +1530,6 @@ for opt do
   ;;
   --enable-replication) replication="yes"
   ;;
-  --disable-vxhs) vxhs="no"
-  ;;
-  --enable-vxhs) vxhs="yes"
-  ;;
   --disable-bochs) bochs="no"
   ;;
   --enable-bochs) bochs="yes"
@@ -1921,7 +1916,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   xfsctl          xfsctl support
   qom-cast-debug  cast debugging support
   tools           build qemu-io, qemu-nbd and qemu-img tools
-  vxhs            Veritas HyperScale vDisk backend support
   bochs           bochs image format support
   cloop           cloop image format support
   dmg             dmg image format support
@@ -6224,33 +6218,6 @@ if compile_prog "" "" ; then
     have_sysmacros=yes
 fi
 
-##########################################
-# Veritas HyperScale block driver VxHS
-# Check if libvxhs is installed
-
-if test "$vxhs" != "no" ; then
-  cat > $TMPC <<EOF
-#include <stdint.h>
-#include <qnio/qnio_api.h>
-
-void *vxhs_callback;
-
-int main(void) {
-    iio_init(QNIO_VERSION, vxhs_callback);
-    return 0;
-}
-EOF
-  vxhs_libs="-lvxhs -lssl"
-  if compile_prog "" "$vxhs_libs" ; then
-    vxhs=yes
-  else
-    if test "$vxhs" = "yes" ; then
-      feature_not_found "vxhs block device" "Install libvxhs See github"
-    fi
-    vxhs=no
-  fi
-fi
-
 ##########################################
 # check for _Static_assert()
 
@@ -7005,7 +6972,6 @@ echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "avx512f optimization $avx512f_opt"
 echo "replication support $replication"
-echo "VxHS block device $vxhs"
 echo "bochs support     $bochs"
 echo "cloop support     $cloop"
 echo "dmg support       $dmg"
@@ -7854,11 +7820,6 @@ elif test "$pthread_setname_np_wo_tid" = "yes" ; then
   echo "CONFIG_PTHREAD_SETNAME_NP_WO_TID=y" >> $config_host_mak
 fi
 
-if test "$vxhs" = "yes" ; then
-  echo "CONFIG_VXHS=y" >> $config_host_mak
-  echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
-fi
-
 if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b20332e592a..0b788a10796 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2790,7 +2790,6 @@
 #
 # Drivers that are supported in block device operations.
 #
-# @vxhs: Since 2.10
 # @throttle: Since 2.11
 # @nvme: Since 2.12
 # @copy-on-read: Since 3.0
@@ -2808,7 +2807,7 @@
             'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
             'sheepdog',
-            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3895,22 +3894,6 @@
   'base': 'BlockdevOptionsGenericFormat',
   'data': { '*offset': 'int', '*size': 'int' } }
 
-##
-# @BlockdevOptionsVxHS:
-#
-# Driver specific block device options for VxHS
-#
-# @vdisk-id: UUID of VxHS volume
-# @server: vxhs server IP, port
-# @tls-creds: TLS credentials ID
-#
-# Since: 2.10
-##
-{ 'struct': 'BlockdevOptionsVxHS',
-  'data': { 'vdisk-id': 'str',
-            'server': 'InetSocketAddressBase',
-            '*tls-creds': 'str' } }
-
 ##
 # @BlockdevOptionsThrottle:
 #
@@ -4010,8 +3993,7 @@
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
       'vpc':        'BlockdevOptionsGenericFormat',
-      'vvfat':      'BlockdevOptionsVVFAT',
-      'vxhs':       'BlockdevOptionsVxHS'
+      'vvfat':      'BlockdevOptionsVVFAT'
   } }
 
 ##
diff --git a/block/vxhs.c b/block/vxhs.c
deleted file mode 100644
index d79fc97df66..00000000000
--- a/block/vxhs.c
+++ /dev/null
@@ -1,590 +0,0 @@
-/*
- * QEMU Block driver for Veritas HyperScale (VxHS)
- *
- * Copyright (c) 2017 Veritas Technologies LLC.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include <qnio/qnio_api.h>
-#include <sys/param.h>
-#include "block/block_int.h"
-#include "block/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "trace.h"
-#include "qemu/module.h"
-#include "qemu/uri.h"
-#include "qapi/error.h"
-#include "qemu/uuid.h"
-#include "crypto/tlscredsx509.h"
-#include "sysemu/replay.h"
-
-#define VXHS_OPT_FILENAME           "filename"
-#define VXHS_OPT_VDISK_ID           "vdisk-id"
-#define VXHS_OPT_SERVER             "server"
-#define VXHS_OPT_HOST               "host"
-#define VXHS_OPT_PORT               "port"
-
-/* Only accessed under QEMU global mutex */
-static uint32_t vxhs_ref;
-
-typedef enum {
-    VDISK_AIO_READ,
-    VDISK_AIO_WRITE,
-} VDISKAIOCmd;
-
-/*
- * HyperScale AIO callbacks structure
- */
-typedef struct VXHSAIOCB {
-    BlockAIOCB common;
-    int err;
-} VXHSAIOCB;
-
-typedef struct VXHSvDiskHostsInfo {
-    void *dev_handle; /* Device handle */
-    char *host; /* Host name or IP */
-    int port; /* Host's port number */
-} VXHSvDiskHostsInfo;
-
-/*
- * Structure per vDisk maintained for state
- */
-typedef struct BDRVVXHSState {
-    VXHSvDiskHostsInfo vdisk_hostinfo; /* Per host info */
-    char *vdisk_guid;
-    char *tlscredsid; /* tlscredsid */
-} BDRVVXHSState;
-
-static void vxhs_complete_aio_bh(void *opaque)
-{
-    VXHSAIOCB *acb = opaque;
-    BlockCompletionFunc *cb = acb->common.cb;
-    void *cb_opaque = acb->common.opaque;
-    int ret = 0;
-
-    if (acb->err != 0) {
-        trace_vxhs_complete_aio(acb, acb->err);
-        ret = (-EIO);
-    }
-
-    qemu_aio_unref(acb);
-    cb(cb_opaque, ret);
-}
-
-/*
- * Called from a libqnio thread
- */
-static void vxhs_iio_callback(void *ctx, uint32_t opcode, uint32_t error)
-{
-    VXHSAIOCB *acb = NULL;
-
-    switch (opcode) {
-    case IRP_READ_REQUEST:
-    case IRP_WRITE_REQUEST:
-
-        /*
-         * ctx is VXHSAIOCB*
-         * ctx is NULL if error is QNIOERROR_CHANNEL_HUP
-         */
-        if (ctx) {
-            acb = ctx;
-        } else {
-            trace_vxhs_iio_callback(error);
-            goto out;
-        }
-
-        if (error) {
-            if (!acb->err) {
-                acb->err = error;
-            }
-            trace_vxhs_iio_callback(error);
-        }
-
-        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs),
-                                         vxhs_complete_aio_bh, acb);
-        break;
-
-    default:
-        if (error == QNIOERROR_HUP) {
-            /*
-             * Channel failed, spontaneous notification,
-             * not in response to I/O
-             */
-            trace_vxhs_iio_callback_chnfail(error, errno);
-        } else {
-            trace_vxhs_iio_callback_unknwn(opcode, error);
-        }
-        break;
-    }
-out:
-    return;
-}
-
-static QemuOptsList runtime_opts = {
-    .name = "vxhs",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
-    .desc = {
-        {
-            .name = VXHS_OPT_FILENAME,
-            .type = QEMU_OPT_STRING,
-            .help = "URI to the Veritas HyperScale image",
-        },
-        {
-            .name = VXHS_OPT_VDISK_ID,
-            .type = QEMU_OPT_STRING,
-            .help = "UUID of the VxHS vdisk",
-        },
-        {
-            .name = "tls-creds",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of the TLS/SSL credentials to use",
-        },
-        { /* end of list */ }
-    },
-};
-
-static QemuOptsList runtime_tcp_opts = {
-    .name = "vxhs_tcp",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
-    .desc = {
-        {
-            .name = VXHS_OPT_HOST,
-            .type = QEMU_OPT_STRING,
-            .help = "host address (ipv4 addresses)",
-        },
-        {
-            .name = VXHS_OPT_PORT,
-            .type = QEMU_OPT_NUMBER,
-            .help = "port number on which VxHSD is listening (default 9999)",
-            .def_value_str = "9999"
-        },
-        { /* end of list */ }
-    },
-};
-
-/*
- * Parse incoming URI and populate *options with the host
- * and device information
- */
-static int vxhs_parse_uri(const char *filename, QDict *options)
-{
-    URI *uri = NULL;
-    char *port;
-    int ret = 0;
-
-    trace_vxhs_parse_uri_filename(filename);
-    uri = uri_parse(filename);
-    if (!uri || !uri->server || !uri->path) {
-        uri_free(uri);
-        return -EINVAL;
-    }
-
-    qdict_put_str(options, VXHS_OPT_SERVER ".host", uri->server);
-
-    if (uri->port) {
-        port = g_strdup_printf("%d", uri->port);
-        qdict_put_str(options, VXHS_OPT_SERVER ".port", port);
-        g_free(port);
-    }
-
-    qdict_put_str(options, "vdisk-id", uri->path);
-
-    trace_vxhs_parse_uri_hostinfo(uri->server, uri->port);
-    uri_free(uri);
-
-    return ret;
-}
-
-static void vxhs_parse_filename(const char *filename, QDict *options,
-                                Error **errp)
-{
-    if (qdict_haskey(options, "vdisk-id") || qdict_haskey(options, "server")) {
-        error_setg(errp, "vdisk-id/server and a file name may not be specified "
-                         "at the same time");
-        return;
-    }
-
-    if (strstr(filename, "://")) {
-        int ret = vxhs_parse_uri(filename, options);
-        if (ret < 0) {
-            error_setg(errp, "Invalid URI. URI should be of the form "
-                       "  vxhs://<host_ip>:<port>/<vdisk-id>");
-        }
-    }
-}
-
-static void vxhs_refresh_limits(BlockDriverState *bs, Error **errp)
-{
-    /* XXX Does VXHS support AIO on less than 512-byte alignment? */
-    bs->bl.request_alignment = 512;
-}
-
-static int vxhs_init_and_ref(void)
-{
-    if (vxhs_ref++ == 0) {
-        if (iio_init(QNIO_VERSION, vxhs_iio_callback)) {
-            return -ENODEV;
-        }
-    }
-    return 0;
-}
-
-static void vxhs_unref(void)
-{
-    if (--vxhs_ref == 0) {
-        iio_fini();
-    }
-}
-
-static void vxhs_get_tls_creds(const char *id, char **cacert,
-                               char **key, char **cert, Error **errp)
-{
-    Object *obj;
-    QCryptoTLSCreds *creds;
-    QCryptoTLSCredsX509 *creds_x509;
-
-    obj = object_resolve_path_component(
-        object_get_objects_root(), id);
-
-    if (!obj) {
-        error_setg(errp, "No TLS credentials with id '%s'",
-                   id);
-        return;
-    }
-
-    creds_x509 = (QCryptoTLSCredsX509 *)
-        object_dynamic_cast(obj, TYPE_QCRYPTO_TLS_CREDS_X509);
-
-    if (!creds_x509) {
-        error_setg(errp, "Object with id '%s' is not TLS credentials",
-                   id);
-        return;
-    }
-
-    creds = &creds_x509->parent_obj;
-
-    if (creds->endpoint != QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
-        error_setg(errp,
-                   "Expecting TLS credentials with a client endpoint");
-        return;
-    }
-
-    /*
-     * Get the cacert, client_cert and client_key file names.
-     */
-    if (!creds->dir) {
-        error_setg(errp, "TLS object missing 'dir' property value");
-        return;
-    }
-
-    *cacert = g_strdup_printf("%s/%s", creds->dir,
-                              QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    *cert = g_strdup_printf("%s/%s", creds->dir,
-                            QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    *key = g_strdup_printf("%s/%s", creds->dir,
-                           QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
-}
-
-static int vxhs_open(BlockDriverState *bs, QDict *options,
-                     int bdrv_flags, Error **errp)
-{
-    BDRVVXHSState *s = bs->opaque;
-    void *dev_handlep;
-    QDict *backing_options = NULL;
-    QemuOpts *opts = NULL;
-    QemuOpts *tcp_opts = NULL;
-    char *of_vsa_addr = NULL;
-    Error *local_err = NULL;
-    const char *vdisk_id_opt;
-    const char *server_host_opt;
-    int ret = 0;
-    char *cacert = NULL;
-    char *client_key = NULL;
-    char *client_cert = NULL;
-
-    ret = vxhs_init_and_ref();
-    if (ret < 0) {
-        ret = -EINVAL;
-        goto out;
-    }
-
-    /* Create opts info from runtime_opts and runtime_tcp_opts list */
-    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
-
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        ret = -EINVAL;
-        goto out;
-    }
-
-    /* vdisk-id is the disk UUID */
-    vdisk_id_opt = qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
-    if (!vdisk_id_opt) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER, VXHS_OPT_VDISK_ID);
-        ret = -EINVAL;
-        goto out;
-    }
-
-    /* vdisk-id may contain a leading '/' */
-    if (strlen(vdisk_id_opt) > UUID_FMT_LEN + 1) {
-        error_setg(&local_err, "vdisk-id cannot be more than %d characters",
-                   UUID_FMT_LEN);
-        ret = -EINVAL;
-        goto out;
-    }
-
-    s->vdisk_guid = g_strdup(vdisk_id_opt);
-    trace_vxhs_open_vdiskid(vdisk_id_opt);
-
-    /* get the 'server.' arguments */
-    qdict_extract_subqdict(options, &backing_options, VXHS_OPT_SERVER".");
-
-    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
-    if (local_err != NULL) {
-        ret = -EINVAL;
-        goto out;
-    }
-
-    server_host_opt = qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
-    if (!server_host_opt) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER,
-                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
-        ret = -EINVAL;
-        goto out;
-    }
-
-    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
-        error_setg(&local_err, "server.host cannot be more than %d characters",
-                   MAXHOSTNAMELEN);
-        ret = -EINVAL;
-        goto out;
-    }
-
-    /* check if we got tls-creds via the --object argument */
-    s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
-    if (s->tlscredsid) {
-        vxhs_get_tls_creds(s->tlscredsid, &cacert, &client_key,
-                           &client_cert, &local_err);
-        if (local_err != NULL) {
-            ret = -EINVAL;
-            goto out;
-        }
-        trace_vxhs_get_creds(cacert, client_key, client_cert);
-    }
-
-    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
-    s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
-                                                          VXHS_OPT_PORT),
-                                                          NULL, 0);
-
-    trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
-                             s->vdisk_hostinfo.port);
-
-    of_vsa_addr = g_strdup_printf("of://%s:%d",
-                                  s->vdisk_hostinfo.host,
-                                  s->vdisk_hostinfo.port);
-
-    /*
-     * Open qnio channel to storage agent if not opened before
-     */
-    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0,
-                           cacert, client_key, client_cert);
-    if (dev_handlep == NULL) {
-        trace_vxhs_open_iio_open(of_vsa_addr);
-        ret = -ENODEV;
-        goto out;
-    }
-    s->vdisk_hostinfo.dev_handle = dev_handlep;
-
-out:
-    g_free(of_vsa_addr);
-    qobject_unref(backing_options);
-    qemu_opts_del(tcp_opts);
-    qemu_opts_del(opts);
-    g_free(cacert);
-    g_free(client_key);
-    g_free(client_cert);
-
-    if (ret < 0) {
-        vxhs_unref();
-        error_propagate(errp, local_err);
-        g_free(s->vdisk_hostinfo.host);
-        g_free(s->vdisk_guid);
-        g_free(s->tlscredsid);
-        s->vdisk_guid = NULL;
-    }
-
-    return ret;
-}
-
-static const AIOCBInfo vxhs_aiocb_info = {
-    .aiocb_size = sizeof(VXHSAIOCB)
-};
-
-/*
- * This allocates QEMU-VXHS callback for each IO
- * and is passed to QNIO. When QNIO completes the work,
- * it will be passed back through the callback.
- */
-static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, uint64_t offset,
-                               QEMUIOVector *qiov, uint64_t size,
-                               BlockCompletionFunc *cb, void *opaque,
-                               VDISKAIOCmd iodir)
-{
-    VXHSAIOCB *acb = NULL;
-    BDRVVXHSState *s = bs->opaque;
-    int iio_flags = 0;
-    int ret = 0;
-    void *dev_handle = s->vdisk_hostinfo.dev_handle;
-
-    acb = qemu_aio_get(&vxhs_aiocb_info, bs, cb, opaque);
-
-    /*
-     * Initialize VXHSAIOCB.
-     */
-    acb->err = 0;
-
-    iio_flags = IIO_FLAG_ASYNC;
-
-    switch (iodir) {
-    case VDISK_AIO_WRITE:
-            ret = iio_writev(dev_handle, acb, qiov->iov, qiov->niov,
-                             offset, size, iio_flags);
-            break;
-    case VDISK_AIO_READ:
-            ret = iio_readv(dev_handle, acb, qiov->iov, qiov->niov,
-                            offset, size, iio_flags);
-            break;
-    default:
-            trace_vxhs_aio_rw_invalid(iodir);
-            goto errout;
-    }
-
-    if (ret != 0) {
-        trace_vxhs_aio_rw_ioerr(s->vdisk_guid, iodir, size, offset,
-                                acb, ret, errno);
-        goto errout;
-    }
-    return &acb->common;
-
-errout:
-    qemu_aio_unref(acb);
-    return NULL;
-}
-
-static BlockAIOCB *vxhs_aio_preadv(BlockDriverState *bs,
-                                   uint64_t offset, uint64_t bytes,
-                                   QEMUIOVector *qiov, int flags,
-                                   BlockCompletionFunc *cb, void *opaque)
-{
-    return vxhs_aio_rw(bs, offset, qiov, bytes, cb, opaque, VDISK_AIO_READ);
-}
-
-static BlockAIOCB *vxhs_aio_pwritev(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t bytes,
-                                    QEMUIOVector *qiov, int flags,
-                                    BlockCompletionFunc *cb, void *opaque)
-{
-    return vxhs_aio_rw(bs, offset, qiov, bytes, cb, opaque, VDISK_AIO_WRITE);
-}
-
-static void vxhs_close(BlockDriverState *bs)
-{
-    BDRVVXHSState *s = bs->opaque;
-
-    trace_vxhs_close(s->vdisk_guid);
-
-    g_free(s->vdisk_guid);
-    s->vdisk_guid = NULL;
-
-    /*
-     * Close vDisk device
-     */
-    if (s->vdisk_hostinfo.dev_handle) {
-        iio_close(s->vdisk_hostinfo.dev_handle);
-        s->vdisk_hostinfo.dev_handle = NULL;
-    }
-
-    vxhs_unref();
-
-    /*
-     * Free the dynamically allocated host string etc
-     */
-    g_free(s->vdisk_hostinfo.host);
-    g_free(s->tlscredsid);
-    s->tlscredsid = NULL;
-    s->vdisk_hostinfo.host = NULL;
-    s->vdisk_hostinfo.port = 0;
-}
-
-static int64_t vxhs_get_vdisk_stat(BDRVVXHSState *s)
-{
-    int64_t vdisk_size = -1;
-    int ret = 0;
-    void *dev_handle = s->vdisk_hostinfo.dev_handle;
-
-    ret = iio_ioctl(dev_handle, IOR_VDISK_STAT, &vdisk_size, 0);
-    if (ret < 0) {
-        trace_vxhs_get_vdisk_stat_err(s->vdisk_guid, ret, errno);
-        return -EIO;
-    }
-
-    trace_vxhs_get_vdisk_stat(s->vdisk_guid, vdisk_size);
-    return vdisk_size;
-}
-
-/*
- * Returns the size of vDisk in bytes. This is required
- * by QEMU block upper block layer so that it is visible
- * to guest.
- */
-static int64_t vxhs_getlength(BlockDriverState *bs)
-{
-    BDRVVXHSState *s = bs->opaque;
-    int64_t vdisk_size;
-
-    vdisk_size = vxhs_get_vdisk_stat(s);
-    if (vdisk_size < 0) {
-        return -EIO;
-    }
-
-    return vdisk_size;
-}
-
-static const char *const vxhs_strong_runtime_opts[] = {
-    VXHS_OPT_VDISK_ID,
-    "tls-creds",
-    VXHS_OPT_HOST,
-    VXHS_OPT_PORT,
-    VXHS_OPT_SERVER".",
-
-    NULL
-};
-
-static BlockDriver bdrv_vxhs = {
-    .format_name                  = "vxhs",
-    .protocol_name                = "vxhs",
-    .instance_size                = sizeof(BDRVVXHSState),
-    .bdrv_file_open               = vxhs_open,
-    .bdrv_parse_filename          = vxhs_parse_filename,
-    .bdrv_refresh_limits          = vxhs_refresh_limits,
-    .bdrv_close                   = vxhs_close,
-    .bdrv_getlength               = vxhs_getlength,
-    .bdrv_aio_preadv              = vxhs_aio_preadv,
-    .bdrv_aio_pwritev             = vxhs_aio_pwritev,
-    .strong_runtime_opts          = vxhs_strong_runtime_opts,
-};
-
-static void bdrv_vxhs_init(void)
-{
-    bdrv_register(&bdrv_vxhs);
-}
-
-block_init(bdrv_vxhs_init);
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 577e578bc22..19c6f371c9d 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -31,7 +31,6 @@ block-obj-$(CONFIG_LIBNFS) += nfs.o
 block-obj-$(CONFIG_CURL) += curl.o
 block-obj-$(CONFIG_RBD) += rbd.o
 block-obj-$(CONFIG_GLUSTERFS) += gluster.o
-block-obj-$(CONFIG_VXHS) += vxhs.o
 block-obj-$(CONFIG_LIBSSH) += ssh.o
 block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
@@ -61,7 +60,6 @@ rbd.o-cflags       := $(RBD_CFLAGS)
 rbd.o-libs         := $(RBD_LIBS)
 gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
 gluster.o-libs     := $(GLUSTERFS_LIBS)
-vxhs.o-libs        := $(VXHS_LIBS)
 ssh.o-cflags       := $(LIBSSH_CFLAGS)
 ssh.o-libs         := $(LIBSSH_LIBS)
 block-obj-dmg-bz2-$(CONFIG_BZIP2) += dmg-bz2.o
diff --git a/block/trace-events b/block/trace-events
index dbe76a76136..d3533ca8963 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -136,23 +136,6 @@ qed_aio_write_prefill(void *s, void *acb, uint64_t start, size_t len, uint64_t o
 qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
 
-# vxhs.c
-vxhs_iio_callback(int error) "ctx is NULL: error %d"
-vxhs_iio_callback_chnfail(int err, int error) "QNIO channel failed, no i/o %d, %d"
-vxhs_iio_callback_unknwn(int opcode, int err) "unexpected opcode %d, errno %d"
-vxhs_aio_rw_invalid(int req) "Invalid I/O request iodir %d"
-vxhs_aio_rw_ioerr(char *guid, int iodir, uint64_t size, uint64_t off, void *acb, int ret, int err) "IO ERROR (vDisk %s) FOR : Read/Write = %d size = %"PRIu64" offset = %"PRIu64" ACB = %p. Error = %d, errno = %d"
-vxhs_get_vdisk_stat_err(char *guid, int ret, int err) "vDisk (%s) stat ioctl failed, ret = %d, errno = %d"
-vxhs_get_vdisk_stat(char *vdisk_guid, uint64_t vdisk_size) "vDisk %s stat ioctl returned size %"PRIu64
-vxhs_complete_aio(void *acb, uint64_t ret) "aio failed acb %p ret %"PRIu64
-vxhs_parse_uri_filename(const char *filename) "URI passed via bdrv_parse_filename %s"
-vxhs_open_vdiskid(const char *vdisk_id) "Opening vdisk-id %s"
-vxhs_open_hostinfo(char *of_vsa_addr, int port) "Adding host %s:%d to BDRVVXHSState"
-vxhs_open_iio_open(const char *host) "Failed to connect to storage agent on host %s"
-vxhs_parse_uri_hostinfo(char *host, int port) "Host: IP %s, Port %d"
-vxhs_close(char *vdisk_guid) "Closing vdisk %s"
-vxhs_get_creds(const char *cacert, const char *client_key, const char *client_cert) "cacert %s, client_key %s, client_cert %s"
-
 # nvme.c
 nvme_kick(void *s, int queue) "s %p queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 0a4b854e652..658a36ff2f0 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
-_unsupported_proto vxhs
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat" \
                      "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 2161a4b87a5..61d78c00a4c 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting intenal snapshots
 _supported_fmt qcow2
 _supported_proto generic
-_unsupported_proto vxhs
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 23a1bdf8905..41efeb9ab25 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
-_unsupported_proto vxhs
 # External data files do not support compressed clusters
 # (TODO: Consider writing a version for external data files that does
 #        not test compressed clusters)
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 26104fff6c6..38985263f0d 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
-_unsupported_proto vxhs
 # qcow2.py does not work too well with external data files
 _unsupported_imgopts data_file
 
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 77ad2aa13a0..a7b365701c4 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
-_unsupported_proto vxhs
 _supported_os Linux
 # We are going to use lazy-refcounts
 _unsupported_imgopts 'compat=0.10'
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 5162d216624..17fe1d6ed48 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2
 _supported_proto generic
-_unsupported_proto vxhs
 
 
 size=128M
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 5559df63a53..8e17716926c 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -50,7 +50,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto generic
-_unsupported_proto vxhs
 # Copying files around with cp does not work with external data files
 _unsupported_imgopts data_file
 
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index ba4db6116ac..3416ef8c459 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2
 _supported_proto generic
-_unsupported_proto vxhs
 
 
 size=128M
diff --git a/tests/qemu-iotests/282 b/tests/qemu-iotests/282
index 081eb120802..27da2a00239 100755
--- a/tests/qemu-iotests/282
+++ b/tests/qemu-iotests/282
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt luks
 _supported_proto generic
-_unsupported_proto vxhs
 
 echo "== Create non-UTF8 secret =="
 echo -n -e '\x3a\x3c\x3b\xff' > non_utf8_secret
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 9c461cf76de..e0d8049012e 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -272,7 +272,6 @@ image protocol options
     -nbd                test nbd
     -ssh                test ssh
     -nfs                test nfs
-    -vxhs               test vxhs
 
 other options
     -xdiff              graphical mode diff
@@ -383,11 +382,6 @@ testlist options
             xpand=false
             ;;
 
-        -vxhs)
-            IMGPROTO=vxhs
-            xpand=false
-            ;;
-
         -ssh)
             IMGPROTO=ssh
             xpand=false
@@ -646,10 +640,6 @@ if [ -z $QEMU_NBD_PROG ]; then
 fi
 export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
 
-if [ -z "$QEMU_VXHS_PROG" ]; then
-    export QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
-fi
-
 if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index d967adc59aa..be4a8d2fb2c 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -237,7 +237,6 @@ _filter_img_info()
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
-        -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
         -e "/encrypted: yes/d" \
         -e "/cluster_size: [0-9]\\+/d" \
         -e "/table_size: [0-9]\\+/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 7ac46edc1f9..494490a2725 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -124,7 +124,6 @@ fi
 : ${VALGRIND_QEMU_IMG=$VALGRIND_QEMU}
 : ${VALGRIND_QEMU_IO=$VALGRIND_QEMU}
 : ${VALGRIND_QEMU_NBD=$VALGRIND_QEMU}
-: ${VALGRIND_QEMU_VXHS=$VALGRIND_QEMU}
 
 # The Valgrind own parameters may be set with
 # its environment variable VALGRIND_OPTS, e.g.
@@ -212,19 +211,6 @@ _qemu_nbd_wrapper()
     return $RETVAL
 }
 
-_qemu_vxhs_wrapper()
-{
-    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
-    (
-        echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
-        VALGRIND_QEMU="${VALGRIND_QEMU_VXHS}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
-            "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
-    )
-    RETVAL=$?
-    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
-    return $RETVAL
-}
-
 # Valgrind bug #409141 https://bugs.kde.org/show_bug.cgi?id=409141
 # Until valgrind 3.16+ is ubiquitous, we must work around a hang in
 # valgrind when issuing sigkill. Disable valgrind for this invocation.
@@ -237,7 +223,6 @@ export QEMU=_qemu_wrapper
 export QEMU_IMG=_qemu_img_wrapper
 export QEMU_IO=_qemu_io_wrapper
 export QEMU_NBD=_qemu_nbd_wrapper
-export QEMU_VXHS=_qemu_vxhs_wrapper
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
@@ -279,9 +264,6 @@ else
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         REMOTE_TEST_DIR="nfs://127.0.0.1$TEST_DIR"
         TEST_IMG="nfs://127.0.0.1$TEST_IMG_FILE"
-    elif [ "$IMGPROTO" = "vxhs" ]; then
-        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
-        TEST_IMG="vxhs://127.0.0.1:9999/t.$IMGFMT"
     else
         TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
     fi
@@ -436,12 +418,6 @@ _make_test_img()
         eval "$QEMU_NBD -v -t -k '$SOCK_DIR/nbd' -f $IMGFMT -e 42 -x '' $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
-
-    # Start QNIO server on image directory for vxhs protocol
-    if [ $IMGPROTO = "vxhs" ]; then
-        eval "$QEMU_VXHS -d  $TEST_DIR > /dev/null &"
-        sleep 1 # Wait for server to come up.
-    fi
 }
 
 _rm_test_img()
@@ -468,15 +444,6 @@ _cleanup_test_img()
             _stop_nbd_server
             rm -f "$TEST_IMG_FILE"
             ;;
-        vxhs)
-            if [ -f "${TEST_DIR}/qemu-vxhs.pid" ]; then
-                local QEMU_VXHS_PID
-                read QEMU_VXHS_PID < "${TEST_DIR}/qemu-vxhs.pid"
-                kill ${QEMU_VXHS_PID} >/dev/null 2>&1
-                rm -f "${TEST_DIR}/qemu-vxhs.pid"
-            fi
-            rm -f "$TEST_IMG_FILE"
-            ;;
 
         file)
             _rm_test_img "$TEST_DIR/t.$IMGFMT"
-- 
2.27.0.221.ga08a83db2b


