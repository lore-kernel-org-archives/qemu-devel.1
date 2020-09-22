Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4243CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA75C20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8+36IOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA75C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgEL-0002OQ-Lf
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKft1-0001XO-5V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsz-0000oA-4P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hnj3PSRtLOsHp9ec4/iMuR+OvApwM2qEmtwfQx+hol0=;
 b=D8+36IOGX+p4xGhvJrUyyM5k1+IbGqEzMI4kawBz3lZzbNOznWt2VhzrMNSXRgmDozN2tY
 wvyO8wJchPqPKlc+JfrY+9c7IyrizPk08ELQXUq+Wo9ccUv1X2k1uFl5UaQm6dCLzQV8AY
 +OLlqp3ENXFsgbrHdZSpie4TTmfCskc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-oQ6tuRm6NHe59JC-tTsvTg-1; Tue, 22 Sep 2020 06:50:56 -0400
X-MC-Unique: oQ6tuRm6NHe59JC-tTsvTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E2964082;
 Tue, 22 Sep 2020 10:50:55 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 238CF5C1DC;
 Tue, 22 Sep 2020 10:50:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 17/20] iotests: Give access to the qemu-storage-daemon
Date: Tue, 22 Sep 2020 12:49:29 +0200
Message-Id: <20200922104932.46384-18-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check     | 11 +++++++++++
 tests/qemu-iotests/common.rc | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e14a1f354d..467a7cf1b7 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -644,6 +644,17 @@ if [ -z $QEMU_NBD_PROG ]; then
 fi
 export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
 
+if [ -z "$QEMU_STGD_PROG" ]; then
+    if [ -x "$build_iotests/qemu-storage-daemon" ]; then
+        export QEMU_STGD_PROG="$build_iotests/qemu-storage-daemon"
+    elif [ -x "$build_root/storage-daemon/qemu-storage-daemon" ]; then
+        export QEMU_STGD_PROG="$build_root/storage-daemon/qemu-storage-daemon"
+    else
+        _init_error "qemu-storage-daemon not found"
+    fi
+fi
+export QEMU_STGD_PROG="$(type -p "$QEMU_STGD_PROG")"
+
 if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 23f46da2db..e4751d4985 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -124,6 +124,7 @@ fi
 : ${VALGRIND_QEMU_IMG=$VALGRIND_QEMU}
 : ${VALGRIND_QEMU_IO=$VALGRIND_QEMU}
 : ${VALGRIND_QEMU_NBD=$VALGRIND_QEMU}
+: ${VALGRIND_QEMU_STGD=$VALGRIND_QEMU}
 
 # The Valgrind own parameters may be set with
 # its environment variable VALGRIND_OPTS, e.g.
@@ -211,6 +212,21 @@ _qemu_nbd_wrapper()
     return $RETVAL
 }
 
+_qemu_storage_daemon_wrapper()
+{
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
+    (
+        if [ -n "${QEMU_STGD_NEED_PID}" ]; then
+            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-storage-daemon.pid"
+        fi
+        VALGRIND_QEMU="${VALGRIND_QEMU_STGD}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QEMU_STGD_PROG" $QEMU_STGD_OPTIONS "$@"
+    )
+    RETVAL=$?
+    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
+    return $RETVAL
+}
+
 # Valgrind bug #409141 https://bugs.kde.org/show_bug.cgi?id=409141
 # Until valgrind 3.16+ is ubiquitous, we must work around a hang in
 # valgrind when issuing sigkill. Disable valgrind for this invocation.
@@ -223,6 +239,7 @@ export QEMU=_qemu_wrapper
 export QEMU_IMG=_qemu_img_wrapper
 export QEMU_IO=_qemu_io_wrapper
 export QEMU_NBD=_qemu_nbd_wrapper
+export QEMU_STGD=_qemu_storage_daemon_wrapper
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
-- 
2.26.2


