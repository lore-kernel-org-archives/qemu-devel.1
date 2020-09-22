Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CEC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6B920739
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/cs4p0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6B920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKg3W-00062L-FS
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKft8-0001ps-L1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKft5-0000on-Bi
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGUZsjHgqLj5E8LG5C3k/EV9yuWT8nhX0OrJwrirL4w=;
 b=i/cs4p0TdnIAtJgAq/EZJzCi6fXtRzL8L52zBotyhF+VliewQJtgU8mApnZwcHYpZ92Gxd
 5OKEAL6FvXmsXi6o/tLwkhhVepS7WIO6ZHsNL3ac2iOz/TSEHqx3OMRFmOo//1Ica5R/0K
 D/UgKawRQlKo2+ZexinspU9xApAi99Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Jyb7PmWANuqi1Mo6T3YHiQ-1; Tue, 22 Sep 2020 06:51:02 -0400
X-MC-Unique: Jyb7PmWANuqi1Mo6T3YHiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 769401084C80;
 Tue, 22 Sep 2020 10:51:01 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6052319C4F;
 Tue, 22 Sep 2020 10:50:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 18/20] iotests: Allow testing FUSE exports
Date: Tue, 22 Sep 2020 12:49:30 +0200
Message-Id: <20200922104932.46384-19-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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

This pretends FUSE exports are a kind of protocol.  As such, they are
always tested under the format node.  This is probably the best way to
test them, actually, because this will generate more I/O load and more
varied patterns.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check         |   6 ++
 tests/qemu-iotests/common.filter |   5 +-
 tests/qemu-iotests/common.rc     | 124 +++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 467a7cf1b7..07232138d7 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -270,6 +270,7 @@ image protocol options
     -rbd                test rbd
     -sheepdog           test sheepdog
     -nbd                test nbd
+    -fuse               test fuse
     -ssh                test ssh
     -nfs                test nfs
 
@@ -382,6 +383,11 @@ testlist options
             xpand=false
             ;;
 
+        -fuse)
+            IMGPROTO=fuse
+            xpand=false
+            ;;
+
         -ssh)
             IMGPROTO=ssh
             xpand=false
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 838ed15793..172ea5752e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -44,7 +44,8 @@ _filter_qom_path()
 _filter_testdir()
 {
     $SED -e "s#$TEST_DIR/#TEST_DIR/#g" \
-         -e "s#$SOCK_DIR/#SOCK_DIR/#g"
+         -e "s#$SOCK_DIR/#SOCK_DIR/#g" \
+         -e "s#SOCK_DIR/fuse-#TEST_DIR/#g"
 }
 
 # replace occurrences of the actual IMGFMT value with IMGFMT
@@ -127,6 +128,7 @@ _filter_img_create_filenames()
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
+        -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
@@ -227,6 +229,7 @@ _filter_img_info()
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
+        -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
         -e "/encrypted: yes/d" \
         -e "/cluster_size: [0-9]\\+/d" \
         -e "/table_size: [0-9]\\+/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e4751d4985..e17f813f06 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -257,6 +257,9 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="$DRIVER,file.driver=nbd,file.type=unix"
         TEST_IMG="$TEST_IMG,file.path=$SOCK_DIR/nbd"
+    elif [ "$IMGPROTO" = "fuse" ]; then
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG="$DRIVER,file.filename=$SOCK_DIR/fuse-t.$IMGFMT"
     elif [ "$IMGPROTO" = "ssh" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="$DRIVER,file.driver=ssh,file.host=127.0.0.1,file.path=$TEST_IMG_FILE"
@@ -273,6 +276,9 @@ else
     elif [ "$IMGPROTO" = "nbd" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         TEST_IMG="nbd+unix:///?socket=$SOCK_DIR/nbd"
+    elif [ "$IMGPROTO" = "fuse" ]; then
+        TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
+        TEST_IMG="$SOCK_DIR/fuse-t.$IMGFMT"
     elif [ "$IMGPROTO" = "ssh" ]; then
         TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
         REMOTE_TEST_DIR="ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)\\?$TEST_DIR"
@@ -288,6 +294,9 @@ fi
 ORIG_TEST_IMG_FILE=$TEST_IMG_FILE
 ORIG_TEST_IMG="$TEST_IMG"
 
+FUSE_PIDS=()
+FUSE_EXPORTS=()
+
 if [ -z "$TEST_DIR" ]; then
         TEST_DIR=$PWD/scratch
 fi
@@ -357,6 +366,10 @@ _test_img_to_test_img_file()
             echo "$1"
             ;;
 
+        fuse)
+            echo "$1" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DIR/#"
+            ;;
+
         nfs)
             echo "$1" | sed -e "s#nfs://127.0.0.1##"
             ;;
@@ -385,6 +398,11 @@ _make_test_img()
     local opts_param=false
     local misc_params=()
 
+    if [[ $IMGPROTO == fuse && $TEST_IMG == $SOCK_DIR/fuse-* ]]; then
+        # The caller may be trying to overwrite an existing image
+        _rm_test_img "$TEST_IMG"
+    fi
+
     if [ -z "$TEST_IMG_FILE" ]; then
         img_name=$TEST_IMG
     elif [ "$IMGOPTSSYNTAX" != "true" -a \
@@ -469,11 +487,105 @@ _make_test_img()
         eval "$QEMU_NBD -v -t -k '$SOCK_DIR/nbd' -f $IMGFMT -e 42 -x '' $TEST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
+
+    if [ $IMGPROTO = "fuse" -a -f "$img_name" ]; then
+        local export_mp
+        local pid
+        local pidfile
+        local timeout
+
+        export_mp=$(echo "$img_name" | sed -e "s#$TEST_DIR/#$SOCK_DIR/fuse-#")
+        if ! echo "$export_mp" | grep -q "^$SOCK_DIR"; then
+            echo 'Cannot use FUSE exports with images outside of TEST_DIR' >&2
+            return 1
+        fi
+
+        touch "$export_mp"
+        rm -f "$SOCK_DIR/fuse-output"
+
+        # Usually, users would export formatted nodes.  But we present fuse as a
+        # protocol-level driver here, so we have to leave the format to the
+        # client.
+        QEMU_STGD_NEED_PID=y $QEMU_STGD \
+              --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
+              --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on \
+              &
+
+        pidfile="$QEMU_TEST_DIR/qemu-storage-daemon.pid"
+
+        # Wait for the PID file
+        while [ ! -f "$pidfile" ]; do
+            sleep 0.5
+        done
+
+        pid=$(cat "$pidfile")
+        rm -f "$pidfile"
+
+        FUSE_PIDS+=($pid)
+        FUSE_EXPORTS+=("$export_mp")
+    fi
 }
 
 _rm_test_img()
 {
     local img=$1
+
+    if [[ $IMGPROTO == fuse && $img == $SOCK_DIR/fuse-* ]]; then
+        # Drop a FUSE export
+        local df_output
+        local i
+        local image_file
+        local index=''
+        local timeout
+
+        for i in "${!FUSE_EXPORTS[@]}"; do
+            if [ "${FUSE_EXPORTS[i]}" = "$img" ]; then
+                index=$i
+                break
+            fi
+        done
+
+        if [ -z "$index" ]; then
+            # Probably gone already
+            return 0
+        fi
+
+        kill "${FUSE_PIDS[index]}"
+
+        # Wait until the mount is gone
+        timeout=10 # *0.5 s
+        while true; do
+            # Will show the mount point; if the mount is still there,
+            # it will be $img.
+            df_output=$(df -T "$img" 2>/dev/null)
+
+            # But df may also show an error ("Transpoint endpoint not
+            # connected"), so retry in such cases
+            if [ -n "$df_output" ]; then
+                if ! echo "$df_output" | grep -q "$img"; then
+                    break
+                fi
+            fi
+
+            sleep 0.5
+
+            timeout=$((timeout - 1))
+            if [ "$timeout" = 0 ]; then
+                echo 'Failed to take down FUSE export' >&2
+                return 1
+            fi
+        done
+
+        rm -f "$img"
+
+        unset "FUSE_PIDS[$index]"
+        unset "FUSE_EXPORTS[$index]"
+
+        image_file=$(echo "$img" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DIR/#")
+        _rm_test_img "$image_file"
+        return
+    fi
+
     if [ "$IMGFMT" = "vmdk" ]; then
         # Remove all the extents for vmdk
         "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut -f 2 -d: \
@@ -496,6 +608,17 @@ _cleanup_test_img()
             rm -f "$TEST_IMG_FILE"
             ;;
 
+        fuse)
+            local mp
+
+            for mp in "${FUSE_EXPORTS[@]}"; do
+                _rm_test_img "$mp"
+            done
+
+            FUSE_PIDS=()
+            FUSE_EXPORTS=()
+            ;;
+
         file)
             _rm_test_img "$TEST_DIR/t.$IMGFMT"
             _rm_test_img "$TEST_DIR/t.$IMGFMT.orig"
@@ -562,6 +685,7 @@ _img_info()
         sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
+            -e "s#$SOCK_DIR/fuse-#TEST_DIR/#g" \
             -e "s#$IMGFMT#IMGFMT#g" \
             -e "/^disk size:/ D" \
             -e "/actual-size/ D" | \
-- 
2.26.2


