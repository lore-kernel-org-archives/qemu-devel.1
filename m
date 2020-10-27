Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4ADC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D9E21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ64PuOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D9E21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUaD-0006dm-IU
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJs-0002Ej-3j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJq-0001SF-3H
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIeOSqUJGHpKnfcWy8KgVXyRch+8ibs63v2yc/7rxN8=;
 b=IQ64PuOacStuH1alrlPn3REpySpjiruu5gMXKuQbfQP3nA4+b0j47n0sQKdosAtWRIyxNI
 tD05BQ4bwC9EISGKz4ZouYqB/CASVRxXMNMP4d96X3+9/NvcILkW3SLdhevMxagGmMJmZf
 3LyEQ8ZXM42FZk4a1NXD3ShtemzSO2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-tPCpsSivMT6Ny4qg4fzCNw-1; Tue, 27 Oct 2020 15:07:37 -0400
X-MC-Unique: tPCpsSivMT6Ny4qg4fzCNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DEE31018F7B;
 Tue, 27 Oct 2020 19:07:36 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29D7C73660;
 Tue, 27 Oct 2020 19:07:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 17/20] iotests: Give access to the
 qemu-storage-daemon
Date: Tue, 27 Oct 2020 20:05:57 +0100
Message-Id: <20201027190600.192171-18-mreitz@redhat.com>
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check     | 11 +++++++++++
 tests/qemu-iotests/common.rc | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 678b6e4910..3c1fa4435a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -644,6 +644,17 @@ if [ -z $QEMU_NBD_PROG ]; then
 fi
 export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
 
+if [ -z "$QSD_PROG" ]; then
+    if [ -x "$build_iotests/qemu-storage-daemon" ]; then
+        export QSD_PROG="$build_iotests/qemu-storage-daemon"
+    elif [ -x "$build_root/storage-daemon/qemu-storage-daemon" ]; then
+        export QSD_PROG="$build_root/storage-daemon/qemu-storage-daemon"
+    else
+        _init_error "qemu-storage-daemon not found"
+    fi
+fi
+export QSD_PROG="$(type -p "$QSD_PROG")"
+
 if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 23f46da2db..20589e59a5 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -124,6 +124,7 @@ fi
 : ${VALGRIND_QEMU_IMG=$VALGRIND_QEMU}
 : ${VALGRIND_QEMU_IO=$VALGRIND_QEMU}
 : ${VALGRIND_QEMU_NBD=$VALGRIND_QEMU}
+: ${VALGRIND_QSD=$VALGRIND_QEMU}
 
 # The Valgrind own parameters may be set with
 # its environment variable VALGRIND_OPTS, e.g.
@@ -211,6 +212,21 @@ _qemu_nbd_wrapper()
     return $RETVAL
 }
 
+_qemu_storage_daemon_wrapper()
+{
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
+    (
+        if [ -n "${QSD_NEED_PID}" ]; then
+            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-storage-daemon.pid"
+        fi
+        VALGRIND_QEMU="${VALGRIND_QSD}" _qemu_proc_exec "${VALGRIND_LOGFILE}" \
+            "$QSD_PROG" $QSD_OPTIONS "$@"
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
+export QSD=_qemu_storage_daemon_wrapper
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
-- 
2.26.2


